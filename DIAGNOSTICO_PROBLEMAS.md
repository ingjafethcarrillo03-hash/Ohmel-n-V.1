# 🔍 Diagnóstico de Problemas - Ohmelon

## Problemas Reportados
1. ❌ No se muestra la ubicación del usuario
2. ❌ No cargan las tiendas Soriana
3. ❌ No se muestran productos

## ✅ Soluciones Implementadas

### 1. Mejoras en el Código
- ✅ Logging detallado en cada paso
- ✅ Verificación de REST client antes de usar
- ✅ Mejor manejo de errores
- ✅ Muestra de ubicación en el header
- ✅ Logs de debug accesibles desde la UI

### 2. Cómo Diagnosticar

#### Paso 1: Verificar Logs
1. Abre la app
2. Si no ves productos/tiendas, presiona **"Ver Logs de Debug"**
3. Revisa los logs para identificar el problema:

**Logs importantes a buscar:**
- `🔄 Inicializando Supabase con REST Client...` - Debe aparecer al iniciar
- `✓ REST: X tiendas cargadas` - Debe mostrar el número de tiendas
- `Ubicación obtenida: X, Y` - Debe mostrar tus coordenadas
- `Tienda X: distancia Y km` - Debe mostrar distancias calculadas

#### Paso 2: Verificar Base de Datos Supabase

**Tabla `tiendas` debe tener:**
```sql
-- Verificar estructura
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'tiendas';

-- Debe tener estas columnas:
-- id (integer)
-- nombre (text)
-- direccion_texto (text)
-- latitud (numeric/double)
-- longitud (numeric/double)
-- link_maps (text)
```

**Verificar datos de tiendas:**
```sql
SELECT id, nombre, latitud, longitud 
FROM tiendas 
LIMIT 10;
```

**Las 8 tiendas Soriana deben estar con estos IDs y coordenadas:**
- ID 1: PUEBLA HERMANOS SERDAN - 19.0803, -98.2269
- ID 2: PUEBLA PLAZA SAN PEDRO - 19.0656, -98.2121
- ID 3: CAPU - 19.0699, -98.1946
- ID 4: PUEBLA CENTRO - 19.0393, -98.2069
- ID 5: PUEBLA ZARAGOZA - 19.0648, -98.1777
- ID 6: PROVIDENCIA - 19.0428, -98.1642
- ID 7: PUEBLA ANGELOPOLIS - 19.029, -98.2355
- ID 8: TORRECILLAS - 19.0, -98.2303

**Tabla `preciosactuales` debe tener:**
```sql
-- Verificar estructura
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'preciosactuales';

-- Debe tener:
-- sku (text)
-- tienda_id (integer) - Debe coincidir con IDs de tiendas (1-8)
-- precio (numeric)
-- cantidad (integer)
```

**Tabla `productos` debe tener:**
```sql
-- Verificar estructura
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'productos';

-- Debe tener:
-- sku (text)
-- nombre (text)
-- imagen_url (text, nullable)
```

#### Paso 3: Verificar Permisos de Ubicación

**En Android:**
1. Configuración > Apps > Ohmelon > Permisos
2. Asegúrate que "Ubicación" esté activado
3. Selecciona "Permitir siempre" o "Permitir solo cuando la app está en uso"

**En la app:**
- La primera vez que abres la app, debe pedir permisos
- Si no los pide, ve a Configuración del sistema y actívalos manualmente

#### Paso 4: Verificar RLS (Row Level Security)

**En Supabase Dashboard:**
1. Ve a Authentication > Policies
2. Para la tabla `tiendas`:
   ```sql
   -- Crear política para lectura pública
   CREATE POLICY "Permitir lectura pública de tiendas"
   ON tiendas FOR SELECT
   USING (true);
   ```

3. Para la tabla `productos`:
   ```sql
   CREATE POLICY "Permitir lectura pública de productos"
   ON productos FOR SELECT
   USING (true);
   ```

4. Para la tabla `preciosactuales`:
   ```sql
   CREATE POLICY "Permitir lectura pública de preciosactuales"
   ON preciosactuales FOR SELECT
   USING (true);
   ```

## 🔧 Soluciones Rápidas

### Si no se muestra la ubicación:
1. Verifica permisos en Configuración del dispositivo
2. Activa GPS/Localización en Configuración del sistema
3. Presiona "Mi ubicación" en la app
4. Revisa logs para ver si hay errores de permisos

### Si no cargan tiendas:
1. Verifica que la tabla `tiendas` tenga datos
2. Verifica que las columnas tengan los nombres correctos
3. Verifica RLS policies
4. Revisa logs para ver el error específico de Supabase

### Si no se muestran productos:
1. Verifica que `preciosactuales` tenga datos con `tienda_id` (1-8)
2. Verifica que `productos` tenga datos con `sku` que coincidan
3. Verifica que tu ubicación esté cerca de Puebla (las tiendas están en Puebla)
4. Aumenta el filtro de distancia a 20 km si estás lejos

## 📊 Verificación de Datos

### Script SQL para verificar todo:
```sql
-- Verificar tiendas
SELECT COUNT(*) as total_tiendas FROM tiendas;
SELECT id, nombre, latitud, longitud FROM tiendas ORDER BY id;

-- Verificar productos
SELECT COUNT(*) as total_productos FROM productos;
SELECT sku, nombre FROM productos LIMIT 5;

-- Verificar precios por tienda
SELECT tienda_id, COUNT(*) as productos_por_tienda 
FROM preciosactuales 
GROUP BY tienda_id 
ORDER BY tienda_id;

-- Verificar relación productos-tiendas
SELECT 
  t.id as tienda_id,
  t.nombre as tienda_nombre,
  COUNT(pa.sku) as productos_disponibles
FROM tiendas t
LEFT JOIN preciosactuales pa ON t.id = pa.tienda_id
GROUP BY t.id, t.nombre
ORDER BY t.id;
```

## 🚨 Errores Comunes

### Error: "No se encontraron tiendas"
- **Causa**: Tabla `tiendas` vacía o RLS bloqueando acceso
- **Solución**: Verifica datos y políticas RLS

### Error: "No se pudo obtener tu ubicación"
- **Causa**: Permisos denegados o GPS desactivado
- **Solución**: Activa permisos y GPS en configuración

### Error: "0 productos encontrados"
- **Causa**: 
  - No hay productos en `preciosactuales` con `tienda_id` válido
  - Estás muy lejos de Puebla (las tiendas están en Puebla)
  - El filtro de distancia es muy pequeño
- **Solución**: 
  - Verifica datos en `preciosactuales`
  - Aumenta el filtro de distancia
  - Usa una ubicación de prueba cerca de Puebla

## 📱 Prueba con Ubicación de Puebla

Si quieres probar sin GPS real, puedes usar estas coordenadas de Puebla:
- **Latitud**: 19.0414
- **Longitud**: -98.2063

Estas coordenadas están cerca del centro de Puebla y deberían mostrar varias tiendas dentro de 20 km.



