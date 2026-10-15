USE TechNova_Bodega;
GO

-- Permite ejecutar la migración si la columna ya fue agregada en SSMS.
IF COL_LENGTH('inventario.Productos', 'Marca') IS NULL
BEGIN
    ALTER TABLE inventario.Productos
    ADD Marca NVARCHAR(80) NULL;
END;
GO

ALTER VIEW inventario.vw_CatalogoProductos
AS
SELECT
    p.ProductoID,
    p.CodigoProducto,
    p.NombreProducto,
    c.NombreCategoria,
    pr.RazonSocial AS Proveedor,
    p.PrecioVenta,
    p.CostoUnitario,
    p.Stock,
    p.StockMinimo,
    p.StockMaximo,
    p.Activo,
    p.FechaUltimaActualizacion,
    p.Marca
FROM inventario.Productos AS p
INNER JOIN inventario.Categorias AS c
    ON p.CategoriaID = c.CategoriaID
LEFT JOIN compras.Proveedores AS pr
    ON p.ProveedorID = pr.ProveedorID;
GO
