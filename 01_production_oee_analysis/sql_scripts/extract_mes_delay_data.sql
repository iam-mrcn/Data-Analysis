-- ==============================================================================
-- Tytuł: Ekstrakcja danych o opóźnieniach produkcyjnych z systemu MES/ERP
-- Autor: Marcin Brząkała
-- Przeznaczenie: Przygotowanie zbioru danych do analizy wąskich gardeł w Pythonie
-- ==============================================================================

SELECT 
    p.production_order_id AS order_no,
    p.workcenter_id AS workcenter,
    p.planned_duration_min,
    p.actual_duration_min,
    (p.actual_duration_min - p.planned_duration_min) AS delay_min,
    CASE 
        WHEN p.stop_reason_code = 'M01' THEN 'Awaria_Maszyny'
        WHEN p.stop_reason_code = 'S02' THEN 'Przezbrojenie'
        WHEN p.stop_reason_code = 'MAT05' THEN 'Brak_Materialu'
        ELSE 'OK'
    END AS status,
    p.execution_date AS date
FROM 
    mes_production_logs p
INNER JOIN 
    erp_production_routing r ON p.routing_id = r.id
WHERE 
    p.actual_duration_min > p.planned_duration_min
    AND p.execution_date BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY 
    delay_min DESC;