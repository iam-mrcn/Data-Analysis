## Prognozowanie popytu i optymalizacja zapasów magazynowych

##  1. Sytuacja Biznesowa (Context)
Tradycyjne metody planowania zakupów surowców i komponentów w fabryce mebli opierały się na intuicji Działu Handlowego lub prostej średniej arytmetycznej z poprzednich miesięcy. Taki model nie uwzględniał trendów wzrostowych oraz silnej sezonowości branży meblarskiej (np. drastycznych spadków zamówień w okresie letnim oraz gwałtownych szczytów przed świętami Bożego Narodzenia). Skutkowało to kosztownym zamrażaniem kapitału w niesprzedanych wyrobach gotowych (martwy sezon) lub przerwami w ciągłości produkcji i utratą zamówień z powodu braku materiałów (szczyt sezonu).

##  2. Cel Projektu (Task)
Stworzenie narzędzia predykcyjnego w Pythonie, które na podstawie 24-miesięcznej historii sprzedaży flagowego produktu (*SZAFA_PAX_01*) wygeneruje prognozę popytu na I kwartał 2026 roku. Dodatkowo model miał za zadanie wyliczyć matematyczny **Zapas Bezpieczeństwa (Safety Stock)** w celu zabezpieczenia płynności logistycznej fabryki przy jednoczesnym ograniczeniu kosztów magazynowania.

##  3. Działania i Technologie (Action)
* **Analiza serii czasowych (Time Series):** Załadowanie danych sprzedażowych (`erp_demand_history.csv`) za pomocą Pandas, zabezpieczenie skryptu przed błędami kodowania Windows (UTF-8 BOM) i oczyszczenie nagłówków.
* **Algorytm Predykcyjny (Wycinkowa Średnia Ważona):** Implementacja modelu prognozującego opartego na dynamice ostatnich miesięcy, uwzględniającego ogólny trend wzrostu rynku rok do roku ($YoY = +10\%$).
* **Implementacja wskaźników sezonowości (Seasonal Indices):** Zastosowanie historycznych współczynników korygujących metodą relacji do średniej ruchomej w celu odwzorowania specyfiki rynkowej początku roku:
  * Styczeń: `0.65` (poświąteczne wygaszenie popytu)
  * Luty: `0.72` (stopniowe odbicie)
  * Marzec: `0.85` (początek wiosennego sezonu remontowego)
* **Kalkulacja Ryzyka Logistycznego:** Wyznaczenie odchylenia standardowego popytu (`.std()`) i obliczenie zapasu bezpieczeństwa dla **95% Poziomu Obsługi Klienta (Service Level)** przy użyciu statystycznego mnożnika rozkładu Gaussa ($Z = 1.65$).
* **Wizualizacja (Matplotlib / Seaborn):** Wygenerowanie biznesowego wykresu liniowego łączącego historię, prognozę (Q1 2026) oraz transparentną strefę zapasu bezpieczeństwa (Safety Stock Zone).

##  4. Kluczowe Wnioski i Wyniki (Result)
Uruchomienie modelu na danych historycznych dostarczyło precyzyjnych wytycznych dla działu logistyki i planowania produkcji:

1. **Zidentyfikowana Prognoza na Q1 2026:**
   * **Styczeń 2026:** Sugerowana produkcja na poziomie **155 szt.** (zabezpiecza spadek popytu bez przepełnienia magazynu).
   * **Luty 2026:** Wzrost planu produkcyjnego do **172 szt.**
   * **Marzec 2026:** Skok produkcyjny do **203 szt.** w celu przygotowania frontu pod zamówienia wiosenne.
2. **Optymalizacja Zapasu Bezpieczeństwa:** Model wyznaczył sztywną granicę zapasu bezpieczeństwa na poziomie **65 sztuk** mebla. Gwarantuje to 95-procentową dostępność produktu dla klienta końcowego "od ręki", przy jednoczesnym uwolnieniu nadmiarowej gotówki, która dotychczas była blokowana przez zbyt wysokie stany magazynowe.

##  5. Rekomendacje Procesowe (Business Impact)
* **Zautomatyzowane Planowanie Zakupów (MRP):** Rekomenduje się bezpośrednie spięcie wyników prognozy (Q1) z zapotrzebowaniem na materiały z Projektu 2 (BOM) w celu automatycznego generowania zamówień do dostawców płyt i okuć z odpowiednim wyprzedzeniem (Lead Time).
* **Dynamiczny Safety Stock:** Wskaźnik zapasu bezpieczeństwa powinien być przeliczany automatycznie co kwartał, aby dostosowywać się do zmieniającej się zmienności rynku.
* **Redukcja Kosztów Magazynowania:** Wdrożenie strefy zapasu bezpieczeństwa pozwala na redukcję średniego stanu magazynowego wyrobów gotowych o ok. 15-20% w skali roku, co bezpośrednio poprawia płynność finansową (Cash Flow) przedsiębiorstwa.
