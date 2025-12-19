# 📝 Instrucciones: Cambiar Nombre de Tabla en Supabase

## 🔧 Si tu tabla se llama 'productos_soriana' en lugar de 'productos'

### Paso 1: Cambiar en SupabaseService

**Archivo:** `lib/services/supabase_service.dart`

Busca todas las líneas que dicen:
```dart
.from('productos')
```

Y cámbialas por:
```dart
.from('productos_soriana')  // o el nombre exacto de tu tabla/vista
```

**Lugares a cambiar:**
- Línea ~11: `getProducts()`
- Línea ~29: `getAllProducts()` ← **ESTE ES EL MÁS IMPORTANTE**
- Línea ~47: `getByPriceRange()`
- Línea ~66: `searchProducts()`
- Línea ~84: `getProductBySku()`

### Paso 2: Verificar nombres de columnas

Si tu tabla/vista tiene nombres de columnas diferentes, también ajusta el SELECT:

**Ejemplo si las columnas son diferentes:**
```dart
.select('sku, nombre, imagen_url, precio')  // Ajustar según tu BD
```

### Paso 3: Verificar en Supabase Dashboard

1. Ve a tu proyecto en Supabase
2. Abre "Table Editor" o "SQL Editor"
3. Verifica el nombre exacto de tu tabla/vista
4. Verifica los nombres exactos de las columnas

---

## 🐛 Debugging Agregado

### Prints en HomeScreen

Ahora verás en la consola:
```
HomeScreen initState: Inicializando productos...
snapshot.hasData = true/false
snapshot.data = [lista de productos o null]
Productos recibidos (length): X
```

### Prints en SupabaseService

Ahora verás:
```
Supabase response type: ...
Supabase response length: X
Item: {sku: ..., nombre: ..., ...}
Productos parseados: X
```

---

## ✅ Verificación

Después de cambiar el nombre de la tabla:

1. **Ejecuta la app:**
   ```bash
   flutter run
   ```

2. **Revisa la consola** y busca:
   - `Supabase response length: X` → Debe ser > 0
   - `Productos parseados: X` → Debe ser > 0
   - `Productos recibidos (length): X` → Debe ser > 0

3. **Si sigue siendo 0:**
   - Verifica que el nombre de la tabla sea exacto (case-sensitive)
   - Verifica que las columnas existan
   - Verifica que haya datos en la tabla

---

## 📋 Checklist

- [ ] Nombre de tabla corregido en `SupabaseService`
- [ ] Nombres de columnas verificados en SELECT
- [ ] App ejecutada y logs revisados
- [ ] Productos aparecen en la pantalla

