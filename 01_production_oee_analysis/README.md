## Analiza wąskich gardeł i strat czasu produkcji

## 1. Sytuacja Biznesowa (Context)
Fabryka mebli skrzyniowych odnotowywała powtarzające się opóźnienia w realizacji zleceń produkcyjnych. Kierownictwo nie było w stanie jednoznacznie wskazać, czy problem wynika ze złej organizacji przezbrojeń maszyn, awarii parku technologicznego (CNC, okleiniarki), czy opóźnień na etapie pakowania gotowych paczek meblowych.

## 2. Cel Projektu (Task)
Identyfikacja gniazd produkcyjnych (Workcenters) generujących największe skumulowane straty czasu oraz kategoryzacja przyczyn przestojów na podstawie surowych logów z systemu MES (`mes_production_logs.csv`).

## 3. Działania i Technologie (Action)
* **SQL:** Wstępna agregacja danych i odfiltrowanie zleceń, w których czas rzeczywisty przekroczył czas normatywny (`actual_duration_min > planned_duration_min`).
* **Python (Pandas):** Zastosowanie metody `pivot_table` do stworzenia macierzy przestawnej (Gniazdo x Status przestoju) oraz zsumowanie minut strat.
* **Python (Matplotlib/Seaborn):** Wizualizacja danych za pomocą wykresu słupkowego skumulowanego (Stacked Bar Chart) wraz z automatycznym etykietowaniem wartości (data labels) wewnątrz słupków dla lepszej czytelności biznesowej.

## 4. Kluczowe Wnioski i Wyniki (Result)
Analiza danych produkcyjnych wykazała łączną stratę tysięcy minut na głównych gniazdach procesowych:

1. **Okleiniowanie i Rozkrój jako główne wąskie gardła maszynowe:** Oba te gniazda generują najwyższe straty czasu (ponad 4000 minut każde). Największym problemem są tam oficjalnie rejestrowane **Awarie Maszyn** (odpowiednio 1485 min i 1514 min), co wskazuje na krytyczną potrzebę weryfikacji planów konserwacji maszyn (piła i okleiniarki).
2. **Problem zbrojenia na Wierceniu:** Gniazdo "Wiercenie" wykazuje najwyższą stratę z tytułu **Przezbrojeń (1601 min)** w całym zakładzie. Oznacza to, że proces ustawiania maszyn wielowrzecionowych pod nowe partie mebli trwa zbyt długo lub partie produkcyjne są zbyt małe (częste przezbrajanie).
3. **Krytyczne awarie na Pakowaniu:** Na etapie końcowym (Pakowanie) dominują **Awarie Maszyn (1364 min)** – np. usterki linii kartonujących lub owijarek, a nie wolna praca operatorów (status OK to tylko 483 min).

## 5. Rekomendacje Procesowe
* **Wdrożenie SMED (Single-Minute Exchange of Die) na Wierceniu:** Przeprowadzenie warsztatów optymalizacji przezbrojeń w celu skrócenia czasu 1601 minut utraconych na ustawianie maszyn wiertarskich.
* **Tuning Utrzymania Ruchu (TPM):** Skupienie budżetu serwisowego na działaniach prewencyjnych dla maszyn na gniazdach: Rozkrój, Okleiniowanie oraz Pakowanie, gdzie awarie sumarycznie blokują ponad 4300 minut pracy.
* **Zwiększenie partii produkcyjnych dla Rozkroju i Okleiniarki:** Wysoki udział czasu przezbrojeń (powyżej 1300 min na gniazdo) sugeruje, że fabryka produkuje zbyt małe serie, co wymusza częste zatrzymania linii.

