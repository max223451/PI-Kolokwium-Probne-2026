#!/usr/bin/env bash
# Podstawy informatyki — szablon do uzupełnienia.
# Uruchomienie: bash src/analiza.sh dane
# Wynik: po jednej linii dla każdego pliku .log:
# nazwa_pliku;liczba_ERROR;STATUS

# TODO 1. Pobierz katalog z argumentu (lub ustaw dane jako domyślny).
# TODO 2. Sprawdź -d; jeśli go nie ma, błąd na stderr i exit 2.
# TODO 3. Pętla for po plikach *.log; obsłuż brak dopasowań.
# TODO 4. Zlicz ERROR w każdym pliku i ustal status przez if.
# TODO 5. Użyj printf, dokładnie trzy pola rozdzielone ;.
KATALOG="${1:-dane}"

if [[ ! -d "$KATALOG" ]]; then
    echo "Blad: brak katalogu $KATALOG" >&2
    exit 2
fi

for PLIK in "$KATALOG"/*.log; do
    [[ -f "$PLIK" ]] || continue
    ILE=$(grep -c '^ERROR;' "$PLIK")
    if [[ "$ILE" -ge 2 ]]; then
        STATUS="ALARM"
    else
        STATUS="OK"
    fi
    printf '%s;%s;%s\n' "$(basename "$PLIK")" "$ILE" "$STATUS"
done
