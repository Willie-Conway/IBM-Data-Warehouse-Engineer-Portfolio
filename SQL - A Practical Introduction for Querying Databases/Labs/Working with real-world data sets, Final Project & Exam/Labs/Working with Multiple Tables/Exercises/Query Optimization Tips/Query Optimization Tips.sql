-- Instead of multiple LIKE clauses
WHERE column LIKE '%value1%' OR column LIKE '%value2%'

-- Consider (if possible)
WHERE column IN ('value1', 'value2')

-- Add index for frequently searched columns
CREATE INDEX idx_community_area ON chicago_public_schools(community_area_number);