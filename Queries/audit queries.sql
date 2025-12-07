--Full audit log
SELECT 
    log_id,
    username,
    operation,
    table_name,
    action_status,
    action_time
FROM peims_audit_log
ORDER BY action_time DESC;

-- Actions by employee (accountability)
SELECT 
    username,
    COUNT(*) AS total_actions
FROM peims_audit_log
GROUP BY username
ORDER BY total_actions DESC;

-- Most edited table
SELECT 
    table_name,
    COUNT(*) AS operations
FROM peims_audit_log
GROUP BY table_name
ORDER BY operations DESC;

-- Actions per day (security trends)
SELECT 
    TRUNC(action_time) AS action_time,
    COUNT(*) AS total_actions
FROM peims_audit_log
GROUP BY TRUNC(action_time)
ORDER BY action_time DESC;

