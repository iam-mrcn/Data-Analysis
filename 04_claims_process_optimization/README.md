# Optymalizacja procesu obsługi reklamacji

## 1. Sytuacja Biznesowa (Context)
Klienci zgłaszający reklamacje jakościowe na wadliwe lub uszkodzone elementy mebli (np. porysowane fronty, brakujące okucia) doświadczali znacznych opóźnień w procesie decyzyjnym oraz logistyce zwrotnej. Średni czas zamknięcia zgłoszenia wynosił kilka dni, co generowało niezadowolenie klientów i obciążało infolinię. 

Intuicja menedżerska sugerowała, że wąskim gardłem jest Dział Jakości (długi czas oceny technicznej szkody) lub Dział Produkcji (opóźnienia w dorabianiu formatatek). Proces nie był jednak nigdzie formalnie zmapowany, a decyzje o reorganizacji pracy opierały się na przypuszczeniach i subiektywnych odczuciach.

## 2. Cel Projektu (Task)
1. **Identyfikacja faktycznego wąskiego gardła:** Analiza surowych logów zdarzeń z systemu ticketowego w Pythonie w celu precyzyjnego wyliczenia rzeczywistego czasu przejścia (Lead Time) zgłoszeń między poszczególnymi działami.
2. **Modelowanie procesów biznesowych (AS-IS vs TO-BE):** Zmapowanie obecnego, nieefektywnego przepływu oraz zaprojektowanie nowego, zautomatyzowanego procesu eliminującego wykryte opóźnienia i pętle decyzyjne.

## 3. Działania i Technologie (Action)

### Analiza Danych (Process Mining i Python)
* **Transformacja danych:** Załadowanie logów systemowych (claims_event_log.csv) i obliczenie interwałów czasowych za pomocą operacji okienkowych w bibliotece Pandas (.groupby(), .diff()). Algorytm precyzyjnie zmierzył czas, jaki każde zgłoszenie spędziło w danym departamencie przed zmianą statusu i przekazaniem do kolejnego etapu.
* **Wizualizacja Statystyczna:** Wygenerowanie wykresu pudełkowego (Box Plot) w Seaborn, który w wizualny sposób zobrazował rozkład czasu procesowania zadań (mediana, kwartyle, wartości skrajne oraz outliery).

### Architektura Procesów (bpmn.io)
* **Model AS-IS:** Odwzorowanie stanu faktycznego wykazanego przez skrypt w Pythonie z uwzględnieniem zewnętrznych przepływów komunikatów (Message Flows).
* **Model TO-BE:** Zaprojektowanie optymalizacji procesowej poprzez wprowadzenie elektronicznego formularza z automatyczną walidacją danych, routingu systemowego (Service Task) oraz bramki równoległej (Parallel Gateway AND) przyspieszającej logistykę i produkcję.

---

## 4. Kluczowe Wnioski z Analizy Danych (Result)

Analiza danych przeprowadzona w Pythonie (zobrazowana na wykresie pudełkowym) całkowicie obaliła początkowe założenia biznesowe i intuicję managementu:

1. **Wykrycie rzeczywistego wąskiego gardła:** Dział Jakości oraz Produkcja działają sprawnie i stabilnie (czas procesowania mieści się w granicach 15-30 godzin). Prawdziwym problemem okazało się Biuro Obsługi Klienta (BOK), gdzie czas przetrzymywania zgłoszeń rozciągał się od kilku aż do blisko 100 godzin (z medianą powyżej 40 godzin).
2. **Przyczyna biznesowa:** Opóźnienia w BOK wynikały z obsługi nieustrukturyzowanych wiadomości e-mail, konieczności ręcznego przepisania danych do systemu ERP oraz cyklicznego dopytywania klientów o brakujące lub nieczytelne informacje.

---

## 5. Mapa procesu obsługi reklamacji jakościowych – Stan obecny (AS-IS)

Model odzwierciedla stan faktyczny zidentyfikowany podczas analizy. Widoczna na schemacie pętla zwrotna pomiędzy BOK a Klientem (spowodowana brakami formalnymi i informacyjnymi w mailach) bezpośrednio wyjaśnia blisko 100-godzinne opóźnienia, które wykazał wykres pudełkowy. Proces opiera się na sekwencyjnym przekazywaniu zadań, co drastycznie wydłuża końcowy etap logistyczny.

---

## 6. Mapa procesu obsługi reklamacji jakościowych – Stan docelowy (TO-BE)

W nowym procesie manualne zadania BOK zostały całkowicie wyeliminowane na etapie wejściowym. Wprowadzenie bramki walidacyjnej na stronie WWW gwarantuje, że do Kontroli Jakości trafiają wyłącznie kompletne wnioski. Przekierowanie ruchu odbywa się automatycznie poprzez system, omijając pierwszą linię wsparcia. Zastosowanie bramki równoległej (Parallel Gateway AND) po pozytywnej decyzji Działu Jakości pozwala na jednoczesne uruchomienie procedur produkcyjnych oraz logistycznych, skracając czas przygotowania wysyłki.
