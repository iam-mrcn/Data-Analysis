-- ==============================================================================
-- Tytuł: Identyfikacja anomalii kosztowych (BOM vs Magazyn WMS)
-- Autor: Marcin Brząkała
-- Przeznaczenie: Wykrywanie odchyleń materiałowych i finansowych na zleceniach
-- ==============================================================================

SELECT 
    w.order_id,
    w.product_id,
    w.component_name,
    w.produced_qty,
    w.actual_consumed_qty,
    -- Wyliczanie teoretycznego zużycia na podstawie normy z BOM
    (w.produced_qty * b.required_qty) AS expected_consumed_qty,
    -- Wyliczanie odchylenia ilościowego
    (w.actual_consumed_qty - (w.produced_qty * b.required_qty)) AS variance_qty,
    -- Wyliczanie procentowego odchylenia (Material Variance %)
    ROUND(
        ((w.actual_consumed_qty - (w.produced_qty * b.required_qty)) / (w.produced_qty * b.required_qty)) * 100, 
        2
    ) AS material_variance_pct,
    -- Wyliczanie straty finansowej w PLN
    ROUND(
        (w.actual_consumed_qty - (w.produced_qty * b.required_qty)) * b.standard_cost_pln, 
        2
    ) AS financial_impact_pln
FROM 
    wms_material_consumption w
INNER JOIN 
    erp_bom_recipes b ON w.product_id = b.product_id AND w.component_name = b.component_name
WHERE 
    -- Filtrujemy tylko te pozycje, gdzie zużycie różniło się od normy BOM
    w.actual_consumed_qty <> (w.produced_qty * b.required_qty)
ORDER BY 
    financial_impact_pln DESC;