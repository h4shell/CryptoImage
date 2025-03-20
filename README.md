# Documentazione dello Script "CryptoImage"

Questo script in Bash permette di criptare un segreto testuale e incorporarlo nei metadati di un file immagine oppure di decriptare un segreto precedentemente criptato. Il segreto cifrato viene prodotto tramite GPG (utilizzando AES256) e successivamente codificato in Base64, in modo da poter essere facilmente incorporato in metadati o trasmesso in forma testuale.

## Requisiti

```
base64
exiftool
gpg
```

## Funzionalità

Lo script supporta due modalità operative:

1. **Modalità criptazione:**

   - Se lo script viene eseguito senza parametri, viene chiesto all'utente di inserire:
     - Il segreto da criptare.
     - La password (passphrase) per la cifratura.
     - Il file immagine su cui incorporare il segreto (opzionale).
   - Il segreto viene criptato utilizzando GPG in modalità simmetrica con l'algoritmo AES256.
   - Il risultato della cifratura viene poi codificato in Base64 e, se viene specificato un file immagine, il valore codificato viene inserito nel campo `Title` dei metadati del file immagine, sfruttando ExifTool.
   - Se non viene specificato nessun file immagine, il segreto criptato in Base64 viene semplicemente stampato a video.

2. **Modalità decriptazione:**
   - Se lo script viene eseguito con almeno un parametro, si presume che il parametro sia il segreto criptato (in Base64).
   - Il parametro fornito viene decodificato da Base64 e salvato temporaneamente su `/tmp/s.gpg`.
   - Utilizzando GPG, il contenuto temporaneo viene decriptato; successivamente il file temporaneo viene eliminato.

## Requisiti

Per utilizzare lo script è necessario che siano installati i seguenti strumenti:

- [GPG](https://gnupg.org/)
- [ExifTool](https://exiftool.org/)
- [Base64](https://man7.org/linux/man-pages/man1/base64.1.html) (solitamente già presente sulla maggior parte delle distribuzioni Linux)

## Modalità d'uso

### 1. Modalità Criptazione

#### Senza file immagine

Esegui lo script senza parametri. Ti verranno chieste le informazioni necessarie:

```bash
./script.sh
```

Output (esempio):

```
Nessun parametro specificato.
inserire il segreto:
=> [inserisci il segreto qui]
inserire la password:
=> [inserisci la password qui]
inserisci il file di immagine:
=> [premi Invio se non vuoi usare un'immagine]
```

Se l'input relativo al file immagine è rilasciato vuoto, il segreto criptato in Base64 verrà stampato a video.

#### Con file immagine

Esegui lo script e, quando richiesto, specifica il percorso dell'immagine in cui vuoi incorporare il segreto:

```bash
./script.sh
```

Durante il processo ti verrà chiesto:

```
inserisci il file di immagine:
```

Inserisci il percorso del file immagine (ad esempio `immagine.jpg`). Lo script utilizzerà ExifTool per inserire il segreto cifrato nel campo `Title` del file immagine.

### 2. Modalità Decriptazione

Per decriptare un segreto precedentemente criptato, utilizza il parametro passando la stringa codificata in Base64:

```bash
./script.sh "SEGRETO_CRIPTATO_IN_BASE64"
```

Lo script:

- Decodificherà il parametro da Base64.
- Salverà il contenuto decodificato in un file temporaneo `/tmp/s.gpg`.
- Decripterà il file utilizzando GPG.
- Rimuoverà il file temporaneo.

Ti verrà richiesta la password per la decriptazione (la stessa utilizzata in fase di criptazione).

## Considerazioni di Sicurezza

- La cifratura è effettuata in modalità simmetrica tramite GPG e protetta dall'algoritmo AES256.
- È fondamentale utilizzare una passphrase robusta per garantire la sicurezza del segreto.
- Assicurarsi di eliminare i file temporanei e gestire con cura i dati sensibili durante e dopo l’utilizzo dello script.

## Esecuzione e Permessi

Assicurati che lo script abbia i permessi di esecuzione:

```bash
chmod +x script.sh
```

Quindi esegui lo script:

```bash
./script.sh [opzionale: segreto_criptato_in_base64]
```

## Esempi

### Criptare un segreto e stamparlo a video:

```
./script.sh

Nessun parametro specificato.
inserire il segreto:
> Questo è un segreto
inserire la password:
> miaPasswordSicura
inserisci il file di immagine:
> [premi Invio]
[lo script stamperà il segreto criptato in Base64]
```

### Criptare un segreto e incorporarlo in un'immagine:

```
./script.sh

Nessun parametro specificato.
inserire il segreto:
> Altro segreto
inserire la password:
> miaPasswordSicura
inserisci il file di immagine:
> immagine.jpg
[lo script ingloba il segreto cifrato nel campo Title dei metadati dell'immagine.jpg]
```

### Decriptare un segreto:

```
./script.sh "SEGRETO_CRIPTATO_IN_BASE64"
[lo script ti chiederà la password e mostrerà il segreto decriptato]
```

---
