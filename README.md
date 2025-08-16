# Práctica Final DevOps – CI/CD con GitHub Actions + Docker + Render

**App:** Node.js + Express (Hola Mundo)  
**Pruebas:** Jest + Supertest  
**Contenedor:** Dockerfile (Node 20)  
**CI/CD:** GitHub Actions (test → build & push a Docker Hub → deploy a Render via Hook)  

## 1) Ejecutar localmente
```bash
npm ci
npm start
# http://localhost:3000
```

## 2) Ejecutar pruebas
```bash
npm test
```

## 3) Construir y ejecutar con Docker (local)
```bash
docker build -t tuusuario/devops-final:local .
docker run -p 3000:3000 tuusuario/devops-final:local
```

## 4) Preparar GitHub Secrets
En tu repositorio → **Settings → Secrets and variables → Actions → New repository secret**

- `DOCKERHUB_USERNAME` → tu usuario de Docker Hub
- `DOCKERHUB_TOKEN` → un Access Token de Docker Hub (no tu contraseña)
- `RENDER_HOOK_URL` → Deploy Hook de tu servicio en Render (opcional pero recomendado para el deploy).

> Si no configuras `RENDER_HOOK_URL`, la app igual subirá la imagen a Docker Hub; para el despliegue, Render puede hacer auto-deploy con cada push si conectas el repo.

## 5) Crear el servicio en Render (una vez)
1. Crea una cuenta en **Render** y enlaza tu GitHub.
2. **New → Web Service** y elige tu repositorio.
3. **Runtime:** *Docker* (Render detectará el `Dockerfile`).  
4. **Port:** Render usará la variable `PORT` automáticamente (nuestra app respeta `process.env.PORT`).  
5. En **Settings** del servicio, crea un **Deploy Hook** y copia la URL. Añádela a GitHub como `RENDER_HOOK_URL` (ver paso 4).

## 6) Flujo CI/CD
Con cada *push* a `main`:
1. **Test:** instala dependencias y ejecuta `npm test`.
2. **Build & Push:** construye la imagen y la sube a Docker Hub con tags `latest` + SHA.
3. **Deploy:** hace `POST` al `RENDER_HOOK_URL` para disparar el despliegue en Render.

## 7) Enlaces a entregar
- **Repositorio público:** (pega aquí tu URL)
- **URL en producción:** (pega aquí la URL de Render una vez desplegado)

---

### Estructura
```text
devops-final-practica/
├─ app.js
├─ app.test.js
├─ package.json
├─ Dockerfile
├─ .dockerignore
└─ .github/
   └─ workflows/
      └─ ci-cd.yml
```
