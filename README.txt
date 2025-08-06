
Instrukcja uruchomienia aplikacji

------------------------------------------------------------
1. ZAWARTOŚĆ KATALOGU PROJEKTU
------------------------------------------------------------

Struktura katalogów powinna zawierać:

📁 system_diagnostyczny
├── 📁 diagnostyka_app             ← Folder z aplikacją Django
├── 📁 0_dB_fan                    ← Folder z nagraniami do trenowania modelu
├── 📁 NAGRANIA_DO_NASLUCHIWANIA   ← Folder z nagraniami do monitoringu
├── 📄 start_serwer.bat            ← Skrót do ręcznego uruchomienia aplikacji
├── 📄 pierwsze_uzycie.bat         ← Skrypt pełnej instalacji i uruchomienia
├── 📄 requirements.txt            ← Lista wymaganych bibliotek Python
└── 📄 README.txt                  ← Niniejszy plik informacyjny

------------------------------------------------------------
2. WYMAGANIA SYSTEMOWE
------------------------------------------------------------

- Python 3.8-3.11
- System operacyjny Windows 10/11
- Przeglądarka internetowa
- Środowisko wirtualne (venv)

------------------------------------------------------------
3. KROKI INSTALACJI I PIERWSZE URUCHOMIENIE
------------------------------------------------------------

1. Dostosuj ścieżki do plików w konfiguracji aplikacji:
   Poniższe pliki Python dostępne są w: \diagnostyka_app\diagnostyka_app\settings.py

   Plik: settings.py
   - Zmień wartości zmiennych wskazujących na lokalizację katalogów wyników i aplikacji (WYNIKI_PATH, MAIN_FOLDER, NASLUCH_AUDIO_FOLDER)


2. Uruchom plik pierwsze_uzycie.bat dwukrotnym kliknięciem.

Skrypt automatycznie:

- sprawdzi wersję Python (i zainstaluje kompatybilną z aplikacją, jeśli trzeba),
- utworzy środowisko wirtualne (venv) w katalogu projektu,
- zainstaluje wszystkie biblioteki z requirements.txt,
- uruchomi aplikację Django na lokalnym serwerze.

Po uruchomieniu aplikacja jest gotowa i pojawi się adres lokalny, np.:
http://127.0.0.1:8000/ — skopiuj go do przeglądarki (lub CTRL+click).

------------------------------------------------------------
4. UWAGI DO KOLEJNEGO URUCHAMIANIA APLIKACJI
------------------------------------------------------------

Po wykonaniu pierwszego uruchomienia (za pomocą pierwsze_uzycie.bat) środowisko wirtualne oraz wszystkie wymagane biblioteki są już zainstalowane.

Aby ponownie uruchomić aplikację:

1. Użyj pliku start_serwer.bat, który automatycznie:

- aktywuje środowisko venv,
- uruchamia lokalny serwer Django.

2. Alternatywnie – ręcznie z konsoli CMD:

cd /d ścieżka_do_folderu_aplikacji
call venv\Scripts\activate
python manage.py runserver

Po chwili pojawi się lokalny adres aplikacji, np.:
http://127.0.0.1:8000/

------------------------------------------------------------
5. ZARZĄDZANIE PLIKAMI
------------------------------------------------------------

1. Wyniki treningu zapisywane są w folderze: \system_diagnostyczny\diagnostyka_app\wyniki_treningu

2. Wyniki monitoringu zapisywane są w folderze: \system_diagnostyczny\diagnostyka_app\wyniki_monitoring

3. Pliki dźwiękowe w bazie muszą być posegregowane w następujący sposób:

audio_data/
├── train/
│   ├── normal/
│   │   ├── normal_001.wav
│   │   ├── normal_002.wav
│   │   └── ...
│   └── abnormal/
│       ├── abnormal_001.wav
│       ├── abnormal_002.wav
│       └── ... abnormal_usterka2_001/ (opcjonalnie, jeśli są inne etykiety klas)
│   
├── train/
│   ├── normal/
│   │   ├── normal_001.wav
│   │   ├── normal_002.wav
│   │   └── ...
│   └── abnormal/
│       ├── abnormal_001.wav
│       ├── abnormal_002.wav
│       └── ... abnormal_usterka2_001/ (opcjonalnie, jeśli są inne etykiety klas)
└── train/
    ├── normal/
    │   ├── normal_001.wav
    │   ├── normal_002.wav
    │   └── ...
    └── abnormal/
        ├── abnormal_001.wav
        ├── abnormal_002.wav
        └── ... abnormal_usterka2_001/ (opcjonalnie, jeśli są inne etykiety klas)


------------------------------------------------------------
6. KONFIGURACJA PUSHBULLET (POWIADOMIENIA)
------------------------------------------------------------

Aplikacja może automatycznie wysyłać powiadomienia (tekst + plik dźwiękowy) na telefon lub komputer za pośrednictwem usługi Pushbullet.

Aby skonfigurować Pushbullet na własnym koncie:

1. Zarejestruj się / Zaloguj do Pushbullet:
https://www.pushbullet.com/

2. Pobierz swój klucz API (Access Token):

Wejdź na: https://www.pushbullet.com/#settings

Kliknij "Create Access Token"

Skopiuj token (ciąg znaków)

3. Wklej token do ustawień Django:
Otwórz plik:

diagnostyka_app/diagnostyka_app/settings.py
Zmień wartość zmiennej:

PUSHBULLET_API_TOKEN = "TU_WKLEJ_SWÓJ_TOKEN"

4. Zapisz plik i uruchom aplikację ponownie.

Od tego momentu wszystkie alerty systemowe będą kierowane na konto Pushbullet powiązane z podanym tokenem.






UWAGA! System posiada nienaprawiony bug: Przy wyborze diagnostyki w czasie rzeczywistej w trybie binarnym, wszystkie wyniki z monitoringu są zapisywane ze statusem "fault". Logi z monitoringu w trybie binarnym (pokazywane bezpośrednio na stronie) mają poprawne statusy. 
