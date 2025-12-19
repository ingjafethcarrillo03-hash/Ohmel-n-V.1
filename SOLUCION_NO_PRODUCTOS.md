# 🔧 Solución: No se Muestran Productos

## 🔍 Diagnóstico Automático Implementado

He actualizado el código para que **automáticamente intente diferentes nombres de tabla**:

1. `productos`
2. `productos_soriana`
3. `Productos_Soriana`
4. `productos_soriana_view`

El código ahora probará cada una hasta encontrar la que tenga datos.

---

## 📊 Qué Verás en la Consola

### Si encuentra la tabla correcta:
```
🔍 Intentando tabla: productos
❌ Error con tabla productos: [error]
🔍 Intentando tabla: productos_soriana
✅ Respuesta recibida de tabla: productos_soriana
📊 Tipo de respuesta: List<dynamic>
📊 Longitud de respuesta: 50
📦 Item recibido: {sku: ..., nombre: ..., precio: ...}
✅ Productos parseados desde productos_soriana: 50
```

### Si ninguna tabla funciona:
```
🔍 Intentando tabla: productos
❌ Error con tabla productos: [error]
🔍 Intentando tabla: productos_soriana
❌ Error con tabla productos_soriana: [error]
...
🔄 Intentando obtener todas las columnas de "productos"...
📋 Estructura de datos recibida: [...]
⚠️ No se encontraron productos en ninguna tabla
```

---

## ✅ Pasos para Resolver

### Paso 1: Revisar la Consola

Ejecuta la app y revisa los logs. Busca:
- `🔍 Intentando tabla: ...` → Ver qué tablas está probando
- `✅ Respuesta recibida` → Si encuentra datos
- `📊 Longitud de respuesta: X` → Si X > 0, hay datos
- `❌ Error con tabla` → Ver el error específico

### Paso 2: Verificar en Supabase Dashboard

1. Ve a tu proyecto en Supabase
2. Abre **Table Editor** o **SQL Editor**
3. Verifica el **nombre exacto** de tu tabla/vista:
   - ¿Se llama `productos`?
   - ¿Se llama `productos_soriana`?
   - ¿Se llama `Productos_Soriana`? (con mayúsculas)
   - ¿Es una vista o una tabla?

### Paso 3: Verificar Columnas

Ejecuta en Supabase SQL Editor:
```sql
SELECT * FROM productos LIMIT 1;
-- O
SELECT * FROM productos_soriana LIMIT 1;
```

Verifica que las columnas sean:
- `sku`
- `nombre`
- `imagen_url` (o `imagenUrl`)
- `precio` (no `price`)

### Paso 4: Verificar Políticas RLS

Si Row Level Security está activado, verifica que permita lectura:

```sql
-- Ver políticas existentes
SELECT * FROM pg_policies WHERE tablename = 'productos';

-- Si no hay políticas, crear una temporal para testing:
CREATE POLICY "Allow public read" ON productos
FOR SELECT USING (true);
```

### Paso 5: Verificar Credenciales

Revisa el archivo `.env`:
```
SUPABASE_URL=https://gwapxyguzvhecorqgjeh.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## 🛠️ Solución Manual (Si el Auto-Detect No Funciona)

### Opción 1: Cambiar Nombre de Tabla Manualmente

**Archivo:** `lib/services/supabase_service.dart`

**Línea ~29-30**, cambia:
```dart
.from('productos')  // Cambiar por el nombre exacto de tu tabla
```

**Ejemplos:**
```dart
.from('productos_soriana')
.from('Productos_Soriana')
.from('productos_soriana_view')
```

### Opción 2: Verificar Nombres de Columnas

Si las columnas tienen nombres diferentes, ajusta el SELECT:

**Ejemplo si las columnas son diferentes:**
```dart
.select('sku, nombre, imagenUrl, precio')  // Ajustar según tu BD
```

### Opción 3: Probar Sin Especificar Columnas

Para ver qué estructura tiene tu tabla:

```dart
final response = await supabase
    .from('productos')  // o 'productos_soriana'
    .select()  // Obtener todas las columnas
    .limit(5);
    
print('Estructura: $response');
```

---

## 🧪 Prueba Rápida

Ejecuta esto en Supabase SQL Editor para verificar:

```sql
-- Ver todas las tablas/vistas disponibles
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
AND table_name LIKE '%producto%';

-- Ver estructura de una tabla específica
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'productos';

-- Ver datos de ejemplo
SELECT * FROM productos LIMIT 5;
```

---

## 📝 Checklist de Verificación

- [ ] Revisar logs de la consola al ejecutar la app
- [ ] Verificar nombre exacto de tabla en Supabase Dashboard
- [ ] Verificar que las columnas existan (`sku`, `nombre`, `imagen_url`, `precio`)
- [ ] Verificar que haya datos en la tabla
- [ ] Verificar políticas RLS (si están activadas)
- [ ] Verificar credenciales en `.env`
- [ ] Verificar conexión a internet

---

## 🚀 Próximos Pasos

1. **Ejecuta la app nuevamente** con el código actualizado
2. **Revisa la consola** para ver qué tabla está probando
3. **Comparte los logs** que veas, especialmente:
   - `🔍 Intentando tabla: ...`
   - `📊 Longitud de respuesta: X`
   - Cualquier mensaje de error

Con esa información podremos identificar exactamente qué está pasando.

---

## 💡 Nota Importante

El código ahora **intenta automáticamente** diferentes nombres de tabla. Si tu tabla tiene un nombre diferente a los que está probando, agrégalo a la lista en `supabase_service.dart` línea ~30:

```dart
final posiblesTablas = [
  'productos',
  'productos_soriana',
  'Productos_Soriana',
  'productos_soriana_view',
  'TU_NOMBRE_AQUI',  // Agregar tu nombre de tabla
];
```

