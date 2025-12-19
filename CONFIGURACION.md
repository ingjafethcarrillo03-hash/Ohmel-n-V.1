# Guía de Configuración - OhMelón Flutter

## 📋 Pasos para Configurar la Aplicación

### 1. Configuración de Supabase

1. Ve a [Supabase](https://supabase.com/) y crea una cuenta o inicia sesión
2. Crea un nuevo proyecto
3. Ve a **Settings** > **API** y copia:
   - **Project URL** → `SUPABASE_URL`
   - **anon public** key → `SUPABASE_ANON_KEY`

4. Edita `lib/config/supabase_config.dart`:
```dart
static const String supabaseUrl = 'TU_SUPABASE_URL';
static const String supabaseAnonKey = 'TU_SUPABASE_ANON_KEY';
```

5. Crea las tablas necesarias (ver README.md)

6. Configura la autenticación de Google en Supabase:
   - Ve a **Authentication** > **Providers**
   - Habilita **Google**
   - Agrega tus credenciales de Google OAuth

### 2. Configuración de Google OAuth

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita la **Google+ API**
4. Crea credenciales OAuth 2.0 para Android:
   - Tipo: Android
   - Package name: `com.ohmelon.ohmelon`
   - SHA-1 certificate fingerprint: (necesitarás generar esto)

5. Configura en Supabase:
   - Ve a **Authentication** > **Providers** > **Google**
   - Pega el **Client ID** (Web)
   - Pega el **Client Secret**
   - Guarda los cambios

### 3. Configuración de Android para Google Sign In

1. Obtén el SHA-1 fingerprint:
```bash
# Para debug
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# O en Windows
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

2. Agrega el SHA-1 a tu proyecto de Google Cloud Console

3. Descarga el archivo `google-services.json` si es necesario

### 4. Ejecutar la Aplicación

```bash
# Instalar dependencias
flutter pub get

# Ejecutar
flutter run
```

## 🔧 Solución de Problemas

### Error de autenticación con Google
- Verifica que las credenciales de Google estén correctamente configuradas en Supabase
- Asegúrate de que el SHA-1 esté agregado en Google Cloud Console
- Verifica que el package name coincida

### Error al cargar productos
- Verifica que la tabla `productos` exista en Supabase
- Verifica que las políticas RLS permitan la lectura
- Revisa la consola para ver errores específicos

### Error al guardar perfil
- Verifica que la tabla `perfiles` exista
- Verifica que las políticas RLS permitan insertar/actualizar
- Asegúrate de estar autenticado
