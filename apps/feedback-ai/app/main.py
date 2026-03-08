import os
from functools import lru_cache
from typing import Literal

from fastapi import FastAPI, HTTPException
from langchain.prompts import PromptTemplate
from langchain_core.output_parsers import PydanticOutputParser
from langchain_google_genai import ChatGoogleGenerativeAI
from pydantic import BaseModel, Field


class FeedbackRequest(BaseModel):
    feedback: str = Field(..., min_length=1, max_length=2000)


class SentimentResult(BaseModel):
    sentiment: Literal["positive", "negative"]
    reason: str = Field(..., min_length=1, max_length=280)


app = FastAPI(title="ChosenWell Feedback AI", version="1.0.0")


@lru_cache(maxsize=1)
def get_chain():
    api_key = os.getenv("GOOGLE_API_KEY", "").strip()
    if not api_key:
        raise RuntimeError("GOOGLE_API_KEY is required")

    parser = PydanticOutputParser(pydantic_object=SentimentResult)
    prompt = PromptTemplate(
        template=(
            "You classify customer feedback for ChosenWell.\n"
            "Decide whether the feedback is positive or negative.\n"
            "If the message is mixed, critical, or uncertain, classify it as negative.\n"
            "Return only the structured output requested below.\n\n"
            "{format_instructions}\n\n"
            "Customer feedback:\n{feedback}"
        ),
        input_variables=["feedback"],
        partial_variables={"format_instructions": parser.get_format_instructions()},
    )
    model = ChatGoogleGenerativeAI(
        model=os.getenv("GEMINI_MODEL", "gemini-2.5-flash-lite"),
        temperature=float(os.getenv("GEMINI_TEMPERATURE", "1.7")),
        google_api_key=api_key,
    )
    return prompt | model | parser


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.post("/classify", response_model=SentimentResult)
def classify_feedback(request: FeedbackRequest):
    try:
        chain = get_chain()
        result = chain.invoke({"feedback": request.feedback.strip()})
        return result
    except Exception as exc:
        raise HTTPException(status_code=500, detail=f"classification failed: {exc}") from exc