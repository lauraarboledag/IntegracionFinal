IF EXISTS (SELECT * FROM sysobjects WHERE ID = OBJECT_ID(N'sp_AnalizarDataMart') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_AnalizarDataMart
GO

CREATE PROCEDURE sp_AnalizarDataMart
    @TableName NVARCHAR(128)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @ColumnName NVARCHAR(128)
    DECLARE @DataType NVARCHAR(128)
    

    DECLARE @HasGanancias BIT = 0
    DECLARE @HasProducto BIT = 0
    DECLARE @HasCantidadVendida BIT = 0

    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'precio_unidad' AND TABLE_CATALOG = DB_NAME() AND TABLE_SCHEMA = SCHEMA_NAME())
        SET @HasGanancias = 1

    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'descripcion' AND TABLE_CATALOG = DB_NAME() AND TABLE_SCHEMA = SCHEMA_NAME())
        SET @HasProducto = 1

    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName AND COLUMN_NAME = 'precio_venta' AND DATA_TYPE IN ('int', 'decimal', 'numeric', 'float', 'real') AND TABLE_CATALOG = DB_NAME() AND TABLE_SCHEMA = SCHEMA_NAME())
        SET @HasCantidadVendida = 1


    DECLARE @ColumnsCursor CURSOR
    SET @ColumnsCursor = CURSOR FOR
        SELECT COLUMN_NAME, DATA_TYPE
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName AND TABLE_CATALOG = DB_NAME() AND TABLE_SCHEMA = SCHEMA_NAME()

    OPEN @ColumnsCursor

    FETCH NEXT FROM @ColumnsCursor INTO @ColumnName, @DataType

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @DataType IN ('varchar', 'nvarchar', 'char', 'nchar', 'text', 'ntext')
        BEGIN
            SET @SQL = 'SELECT ''' + @ColumnName + ''' AS NombreColumna, ' +
                       'SUM(CASE WHEN [' + @ColumnName + '] IS NULL THEN 1 ELSE 0 END) AS Cantidad_Datos_Null, ' +
                       'SUM(CASE WHEN LTRIM(RTRIM([' + @ColumnName + '])) = '''' THEN 1 ELSE 0 END) AS Cantidad_Datos_Vacios ' +
                       'FROM ' + SCHEMA_NAME() + '.' + @TableName
        END
        ELSE
        BEGIN
            SET @SQL = 'SELECT ''' + @ColumnName + ''' AS NombreColumna, ' +
                       'SUM(CASE WHEN [' + @ColumnName + '] IS NULL THEN 1 ELSE 0 END) AS Cantidad_Datos_Null, ' +
                       'NULL AS Cantidad_Datos_Vacios ' +
                       'FROM ' + SCHEMA_NAME() + '.' + @TableName
        END
        
        EXEC sp_executesql @SQL

        FETCH NEXT FROM @ColumnsCursor INTO @ColumnName, @DataType
    END

    CLOSE @ColumnsCursor
    DEALLOCATE @ColumnsCursor


    IF @HasGanancias = 1
    BEGIN
        SET @SQL = 'SELECT SUM((precio_unidad - precio_proveedor) * cantidad) AS TotalGanancias FROM ' + SCHEMA_NAME() + '.' + @TableName
        EXEC sp_executesql @SQL
    END
END
