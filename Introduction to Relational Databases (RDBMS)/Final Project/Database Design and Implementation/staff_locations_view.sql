CREATE OR REPLACE VIEW staff_locations_view AS
SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    staff.location
FROM 
    staff
WHERE 
    "position" NOT IN ('CEO', 'CFO');
