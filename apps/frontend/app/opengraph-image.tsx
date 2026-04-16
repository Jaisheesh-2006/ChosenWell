import { ImageResponse } from "next/og";

export const runtime = "edge";

export const alt =
  "ChosenWell - Curated Health Products for Everyday Use in India";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function Image() {
  return new ImageResponse(
    (
      <div
        style={{
          background: "#FFFFFF",
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          fontFamily: "sans-serif",
          position: "relative",
        }}
      >
        {/* Top accent bar */}
        <div
          style={{
            position: "absolute",
            top: 0,
            left: 0,
            right: 0,
            height: "10px",
            background: "#6B7A65",
          }}
        />

        {/* Logo circle + wordmark */}
        <div
          style={{
            display: "flex",
            alignItems: "center",
            gap: "24px",
            marginBottom: "36px",
          }}
        >
          <div
            style={{
              width: "88px",
              height: "88px",
              borderRadius: "50%",
              background: "#6B7A65",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              flexShrink: 0,
            }}
          >
            <span
              style={{
                color: "#FFFFFF",
                fontSize: "36px",
                fontWeight: 700,
                letterSpacing: "-1px",
              }}
            >
              CW
            </span>
          </div>
          <span
            style={{
              fontSize: "60px",
              fontWeight: 700,
              color: "#1E1E1E",
              letterSpacing: "-1px",
            }}
          >
            ChosenWell
          </span>
        </div>

        {/* Tagline */}
        <div
          style={{
            fontSize: "30px",
            color: "#7B8B7A",
            textAlign: "center",
            maxWidth: "820px",
            lineHeight: 1.45,
          }}
        >
          Curated Health Products for Everyday Use in India
        </div>

        {/* Sub-tagline */}
        <div
          style={{
            marginTop: "28px",
            paddingTop: "28px",
            borderTop: "2px solid #E8EBE7",
            fontSize: "22px",
            color: "#6B7A65",
            fontWeight: 600,
            letterSpacing: "0.02em",
          }}
        >
          No sponsored rankings — just honest comparisons
        </div>

        {/* Bottom accent bar */}
        <div
          style={{
            position: "absolute",
            bottom: 0,
            left: 0,
            right: 0,
            height: "10px",
            background: "#E8EBE7",
          }}
        />
      </div>
    ),
    { ...size }
  );
}
