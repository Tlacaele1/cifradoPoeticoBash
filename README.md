# **Cifrado Poético** 
Es un script en bash que automatiza el cifrado y descifrado de cadenas de texto.
**Para ello utiliza el estándar AES-256-CBC de OpenSSL.**

## Características:
**Alta entropía forzada** El programa exige una contraseña de cifrado de mínimo 20 caracteres. Esta exigencia asegura que la contraseña tenga alta entropía y, por tanto, sea extremadamente difícil de descifrar o adivinar.
**Gestión de mensajes híbrida:**
* El programa permite cifrar mensajes rápidos en la terminal que terminan al pulsar Enter, ideal para mensajes breves.
* También permite abrir un archivo de texto temporal con `nano` para mensajes más largos. **Este archivo se elimina una vez que se cifra el mensaje.**

## Requisitos:
* `bash`
* `openSSL`
* `nano` (para mensajes con saltos de línea)

## Recomendaciones:
[!TIP]
**Usa versos de canciones, poemas, líneas de libros o dichos populares como contraseña**
Estos son fáciles de recordar, pero difíciles de adivinar; además, difícilmente se encuentran en diccionarios públicos de contraseñas.
**Ejemplo de contraseña:** "Piramidal, funesta de la tierra nacida sombra." (verso y medio del "Sueño" de Sor Juana Inés de la Cruz).

[!IMPORTANT]
**[!]NUNCA ENVÍES LA CONTRASEÑA POR EL MISMO MEDIO QUE EL MENSAJE**
En este cifrado, la seguridad del mensaje depende casi exclusivamente del usuario. Si envías el mensaje cifrado junto a la contraseña en un mismo medio, cualquier atacante que tenga acceso al medio podrá descifrar la información.

[!IMPORTANT]
**Cualquier cambio en la contraseña al momento de descifrar, por mínimo que sea, hará imposible el descifrado del mensaje**
Por tanto, si olvidas la contraseña, no podrás recuperar la información cifrada.
