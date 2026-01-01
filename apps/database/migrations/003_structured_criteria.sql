-- Migration: 003_structured_criteria
-- Description: Update category criteria to support must_have, good_to_have, disqualifiers structure
-- Created: 2026-01-01

-- Drop existing category_criteria table
DROP TABLE IF EXISTS category_criteria;

-- Create new structured category criteria table
CREATE TABLE category_criteria (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    criteria_type VARCHAR(50) NOT NULL CHECK (criteria_type IN ('must_have', 'good_to_have', 'disqualifiers')),
    criterion TEXT NOT NULL,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_category_criteria_category_id ON category_criteria(category_id);
CREATE INDEX idx_category_criteria_type ON category_criteria(criteria_type);

-- Add criteria_version to categories table
ALTER TABLE categories ADD COLUMN IF NOT EXISTS criteria_version VARCHAR(20) DEFAULT '1.0';

COMMENT ON TABLE category_criteria IS 'Structured evaluation criteria for product categories with must_have, good_to_have, and disqualifiers';
COMMENT ON COLUMN category_criteria.criteria_type IS 'Type of criterion: must_have (required), good_to_have (preferred), disqualifiers (automatic exclusion)';
