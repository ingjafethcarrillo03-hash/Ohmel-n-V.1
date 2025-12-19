# OhMelón - Aplicación Flutter

Aplicación móvil Android desarrollada con Flutter para gestión de productos, recetas, finanzas y más.

## 🚀 Características

- **Home**: Visualización de productos desde Supabase
- **Recetas**: Sección de recetas (próximamente)
- **IA**: Asistente inteligente (próximamente)
- **Finanzas**: Gestión financiera (próximamente)
- **Perfil**: Gestión de información personal del usuario

## 📋 Requisitos Previos

- Flutter SDK (3.9.2 o superior)
- Dart SDK (3.9.2 o superior)
- Android Studio
- Cuenta de Supabase
- Credenciales de Google OAuth

## 🛠️ Instalación

1. **Clona o descarga el proyecto**

2. **Instala las dependencias:**
```bash
flutter pub get
```

3. **Configura Supabase:**
   - Edita `lib/config/supabase_config.dart`
   - Agrega tu URL y clave anónima de Supabase

4. **Configura Google Sign In:**
   - Sigue las instrucciones en `CONFIGURACION.md`

## 🏃 Ejecutar la Aplicación

```bash
# Verificar dispositivos disponibles
flutter devices

# Ejecutar en Android
flutter run

# O ejecutar en un dispositivo específico
flutter run -d <device-id>
```

## 📱 Configuración de Supabase

1. Crea una tabla `productos`:
```sql
CREATE TABLE productos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  nombre TEXT NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10, 2),
  unidad TEXT,
  imagen TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);
```

2. Crea una tabla `perfiles`:
```sql
CREATE TABLE perfiles (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE NOT NULL,
  nombre TEXT,
  telefono TEXT,
  direccion TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);
```

3. Configura Row Level Security (RLS) según tus necesidades.

## 🎨 Diseño

La aplicación utiliza un tema verde melón con:
- Colores principales: Verde (#4CAF50) y Naranja (#FF9800)
- Interfaz moderna y amigable
- Gradientes y sombras para profundidad visual
- Material Design 3

## 📦 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── config/                   # Configuraciones
│   └── supabase_config.dart # Configuración de Supabase
├── models/                   # Modelos de datos
│   └── producto.dart
├── providers/               # State management
│   └── auth_provider.dart
├── screens/                 # Pantallas
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── recetas_screen.dart
│   ├── ia_screen.dart
│   ├── finanzas_screen.dart
│   └── perfil_screen.dart
├── services/               # Servicios
│   ├── supabase_service.dart
│   └── auth_service.dart
└── theme/                  # Tema y estilos
    ├── app_colors.dart
    └── app_theme.dart
```

## 📝 Notas

- Asegúrate de configurar correctamente las credenciales de Supabase y Google antes de ejecutar
- La aplicación está lista para desarrollo, pero algunas funcionalidades están marcadas como "próximamente"
- El diseño es responsive y optimizado para dispositivos móviles Android

## 📄 Licencia

Este proyecto es privado.
