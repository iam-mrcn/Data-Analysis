## Detektor odchyleń struktur BOM i strat materiałowych (ERP vs WMS)

##  1. Sytuacja Biznesowa (Context)
W procesie masowej produkcji mebli skrzyniowych (szafy, komody) oraz stołów loftowych, kontroling finansowy odnotował niewyjaśnione straty na stanach magazynowych akcesoriów oraz zawyżone koszty zakupu płyt drewnopochodnych. Teoretyczne normy zużycia zapisane w strukturach BOM (Bill of Materials) w systemie ERP nie pokrywały się z realnymi wydaniami surowców z magazynu (system WMS), co utrudniało precyzyjną wycenę produktów i generowało niekontrolowane koszty (scrap / nadużycia).

##  2. Cel Projektu (Task)
Stworzenie automatycznego skryptu weryfikacyjnego, który połączy dane normatywne z rzeczywistym zużyciem, wyliczy wskaźnik odchylenia materiałowego (Material Variance %) oraz wskaże finansowy wpływ anomalii (w PLN) na poszczególnych komponentach, umożliwiając natychmiastową interwencję kierownictwa.

##  3. Działania i Technologie (Action)
* **Python (Pandas):** Załadowanie i zmergowanie (`pd.merge`) danych o strukturach i kosztach standardowych (`erp_bom_recipes.csv`) z logami rzeczywistego zużycia ze zleceń produkcyjnych (`wms_material_consumption.csv`).
* **Feature Engineering:** Wyliczenie oczekiwanego zużycia ($Produced\_Qty \times Required\_Qty$), odchylenia ilościowego oraz końcowego wpływu finansowego (odchylenie $\times$ koszt standardowy jednostki).
* **Python (Seaborn/Matplotlib):** Przygotowanie biznesowego wykresu słupkowego (Bar Plot) prezentującego sumaryczny wpływ finansowy odchyleń per komponent, ze zmiennym kodowaniem kolorystycznym (anomalie kosztowe vs oszczędności).

##  4. Kluczowe Wnioski i Wyniki (Result)
Analiza danych ujawniła dwie krytyczne anomalie operacyjne w badanym okresie:

1. **Prowadnica Szuflady jako główny generator strat:** Komponent ten odnotował drastyczne, 20-procentowe odchylenie od normy BOM przy produkcji komód (zużyto 144 sztuki zamiast planowanych 120). Wygenerowało to natychmiastową, skumulowaną stratę na poziomie **432.00 PLN** na jednym zleceniu. Wskazuje to na ukryte wady montażowe (niszczenie komponentów przez operatorów) lub błędy w samej recepturze bazowej w ERP.
2. **Systematyczny odpad na płytach (Scrap Rate):** Zarówno płyty wiórowe (Szafa PAX), jak i płyty MDF (Komoda MALM) wykazują stabilne odchylenie miedzy 14% a 21%. Łączna strata finansowa na materiale płytowym przekroczyła **400.00 PLN**, co dowodzi złego ustawienia algorytmów optymalizacji rozkroju (nestingu).
3. **Stabilność okuć i elementów premium:** Elementy o wysokim koszcie jednostkowym, takie jak *Blat Dębowy 30mm* czy *Noga Metalowa*, wykazały idealną zgodność z normami BOM (odchylenie 0%), co potwierdza wysoką dyscyplinę na gniazdach montażu premium.

##  5. Rekomendacje Procesowe
* **Audyt gniazda montażu komód:** Natychmiastowa weryfikacja techniczna procesu instalacji prowadnic szuflad w celu wyeliminowania uszkodzeń mechanicznych (generujących 432 PLN straty).
* **Korekta współczynnika odpadu (Scrap Factor) w ERP:** Aktualizacja teoretycznego zapotrzebowania na płyty wiórowe/MDF w systemie ERP o stały naddatek technologiczny (ok. 15-20%) w celu realnej wyceny kosztów (Margin Analysis).
* **Wdrożenie automatycznego alertu nadmiarowego wydania:** Blokowanie wydań z magazynu WMS powyżej 5% tolerancji względem zlecenia produkcyjnego bez autoryzacji Kierownika Produkcji.
