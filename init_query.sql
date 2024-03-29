 USE [EateryDB]

GO
/****** Object:  UserDefinedFunction [dbo].[fn_General_Split]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_General_Split]
(
	@list VARCHAR(MAX),
	@delimiter VARCHAR(5)
)
RETURNS @retVal TABLE (Id INT IDENTITY(1,1), Value VARCHAR(MAX))
AS
BEGIN
	WHILE (CHARINDEX(@delimiter, @list) > 0)
	BEGIN
		INSERT INTO @retVal (Value)
		SELECT Value = LTRIM(RTRIM(SUBSTRING(@list, 1, CHARINDEX(@delimiter, @list) - 1)))
		SET @list = SUBSTRING(@list, CHARINDEX(@delimiter, @list) + LEN(@delimiter), LEN(@list))
	END
	INSERT INTO @retVal (Value)
	SELECT Value = LTRIM(RTRIM(@list))
	RETURN 
END
GO

/****** Object:  Table [dbo].[msDishRecipe]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE TABLE [dbo].[msDishRecipe](
	[DishRecipeID] [int] IDENTITY(1,1) NOT NULL,
	[DishDetailID] [int] NOT NULL,
	[Ingredient] [varchar](100) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Unit] [varchar](100) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishRecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[msDishDetail]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msDishDetail](
	[DishDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DishID] [int] NOT NULL,
	[RecipeName] [varchar](100) NOT NULL,
	[RecipeDescription] NVARCHAR(MAX) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msDishRecipe]  WITH CHECK ADD FOREIGN KEY([DishDetailID])
REFERENCES [dbo].[msDishDetail] ([DishDetailID])
GO
/****** Object:  Table [dbo].[msDish]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msDish](
	[DishID] [int] IDENTITY(1,1) NOT NULL,
	[DishTypeID] [int] NOT NULL,
	[DishName] [varchar](200) NOT NULL,
	[DishPrice] [int] NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msDishDetail]  WITH CHECK ADD FOREIGN KEY([DishID])
REFERENCES [dbo].[msDish] ([DishID])
GO

/****** Object:  Table [dbo].[msDishType]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msDishType](
	[DishTypeID] [int] IDENTITY(1,1) NOT NULL,
	[DishTypeName] [varchar](100) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msDish]  WITH CHECK ADD FOREIGN KEY([DishTypeID])
REFERENCES [dbo].[msDishType] ([DishTypeID])
GO


/****** Object:  StoredProcedure [dbo].[Dish_Delete]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Delete dish
 */
CREATE PROCEDURE [dbo].[Dish_Delete]
	@DishIDs VARCHAR(MAX)
AS
BEGIN
	UPDATE msDish
	SET AuditedActivity = 'D',
		AuditedTime = GETDATE()
	WHERE DishID IN (SELECT value FROM fn_General_Split(@DishIDs, ','))
END
GO
/****** Object:  StoredProcedure [dbo].[Dish_Get]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get semua dish
 */
CREATE PROCEDURE [dbo].[Dish_Get]
AS
BEGIN
	SELECT 
		DishID,
		DishTypeID,
		DishName, 
		DishPrice 
	FROM msDish WITH(NOLOCK)
	WHERE AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[Dish_GetByID]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get dish tertentu by Id
 */
CREATE PROCEDURE [dbo].[Dish_GetByID]
	@DishId INT
AS
BEGIN
	SELECT 
		DishID,
		DishTypeID,
		DishName, 
		DishPrice 
	FROM msDish WITH(NOLOCK)
	WHERE DishId = @DishId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[Dish_InsertUpdate]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Insert atau update dish
 */
CREATE PROCEDURE [dbo].[Dish_InsertUpdate]
	@DishID INT OUTPUT,
	@DishTypeID INT,
	@DishName VARCHAR(100),
	@DishPrice INT
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msDish WITH(NOLOCK) WHERE DishID = @DishID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msDish
		SET DishName = @DishName,
			DishTypeID = @DishTypeID,
			DishPrice = @DishPrice,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE DishID = @DishID AND AuditedActivity <> 'D'
		SET @RetVal = @DishID
	END
	ELSE
	BEGIN
		INSERT INTO msDish 
		(DishName, DishTypeID, DishPrice, AuditedActivity, AuditedTime)
		VALUES
		(@DishName, @DishTypeID, @DishPrice, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
	SELECT @DishId = @RetVal
END
GO
/****** Object:  StoredProcedure [dbo].[DishType_Get]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get semua dish type
 */
CREATE PROCEDURE [dbo].[DishType_Get]
AS
BEGIN
	SELECT DishTypeID, DishTypeName FROM msDishType WITH(NOLOCK) 
	WHERE AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[DishType_GetByID]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get dish type by ID
 */
CREATE PROCEDURE [dbo].[DishType_GetByID]
	@DishTypeID INT
AS
BEGIN
	SELECT DishTypeID, DishTypeName
	FROM msDishType WITH(NOLOCK)
	WHERE DishTypeID = @DishTypeID AND AuditedActivity <> 'D'
END
GO
-- SEEDING msDishType
INSERT INTO msDishType (DishTypeName,AuditedActivity,AuditedTime)
VALUES ('Rumahan','I',GETDATE()), ('Restoran','I',GETDATE()), ('Pinggiran','I',GETDATE())


/****** Object:  StoredProcedure [dbo].[DishDetail_InsertUpdate]    Script Date: 07/03/2024 11:37:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 07 Maret 2024
 * Purpose: Insert atau update dish detail
 */
 CREATE PROCEDURE [dbo].[DishDetail_InsertUpdate]
	@DishDetailID INT OUTPUT,
	@DishID INT,
	@RecipeName VARCHAR(100),
	@RecipeDescription NVARCHAR(MAX)
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msDishDetail WITH(NOLOCK) WHERE DishDetailID = @DishDetailID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msDishDetail
		SET RecipeName = @RecipeName,
			DishID = @DishID,
			RecipeDescription=@RecipeDescription,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE DishDetailID = @DishDetailID AND AuditedActivity <> 'D'
		SET @RetVal = @DishDetailID
	END
	ELSE
	BEGIN
		INSERT INTO msDishDetail 
		(DishID, RecipeName, RecipeDescription,AuditedActivity, AuditedTime)
		VALUES
		(@DishID, @RecipeName,@RecipeDescription, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
	SELECT @DishId = @RetVal
END
GO

 

/****** Object:  StoredProcedure [dbo].[DishDetail_Get]  Script Date: 07/03/2024 11:37:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 07 Maret 2024
 * Purpose: Get dish detail
 */
CREATE PROCEDURE [dbo].[DishDetail_Get]
AS
BEGIN
	SELECT 
		DishDetailID,
		DishID,
		RecipeName,
		RecipeDescription
	FROM msDishDetail WITH(NOLOCK)
	WHERE AuditedActivity <> 'D'
END

/****** Object:  StoredProcedure [dbo].[DishDetail_GetByID]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin Tjandraatmadja
 * Date: 13 Maret 2024
 * Purpose: Get dish tertentu by Id
 */
CREATE PROCEDURE [dbo].[DishDetail_GetByID]
	@DishDetailId INT
AS
BEGIN
	SELECT 
		DishDetailID,
		DishID,
		RecipeName,
		RecipeDescription
	FROM msDishDetail WITH(NOLOCK)
	WHERE DishDetailId = @DishDetailId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[DishDetail_GetByDishID]  Script Date: 13/03/2024 13:00:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 13 Maret 2024
 * Purpose: Get dish detail by dish id
 */
GO
CREATE PROCEDURE [dbo].[DishDetail_GetByDishID]
    @DishID INT
AS
BEGIN
    SELECT 
        DishDetailID,
        DishID,
        RecipeName,
		RecipeDescription
    FROM msDishDetail WITH (NOLOCK)
    WHERE AuditedActivity <> 'D'
        AND DishID = @DishID
END
GO

/****** Object:  StoredProcedure [dbo].[DishDetail_Delete]    Script Date: 13 Maret 2024******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin Tjandra
 * Date: 13 Maret 2024
 * Purpose: Delete dish Detail
 */
 CREATE PROCEDURE [dbo].[DishDetail_Delete]
	@DishDetailIDs VARCHAR(MAX)
AS
BEGIN
	UPDATE msDishDetail
	SET AuditedActivity = 'D',
		AuditedTime = GETDATE()
	WHERE DishDetailID IN (SELECT value FROM fn_General_Split(@DishDetailIDs, ','))
END
GO

/****** Object:  StoredProcedure [dbo].[DishRecipe_InsertUpdate]  Script Date: 13/03/2024 13:00:00 PM  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 13 Maret 2024
 * Purpose: Insert atau update msDishRecipe
 */
CREATE PROCEDURE [dbo].[DishRecipe_InsertUpdate]
	@DishRecipeID INT OUTPUT,
	@DishDetailID INT ,
	@Ingredient VARCHAR(100),
	@Quantity INT,
	@Unit VARCHAR(100)
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msDishRecipe WITH(NOLOCK) WHERE DishRecipeID = @DishRecipeID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msDishRecipe
		SET DishDetailID=@DishDetailID,
			Ingredient=@Ingredient,
			Quantity=@Quantity,
			Unit=@Unit,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE DishRecipeID = @DishRecipeID AND AuditedActivity <> 'D'
		SET @RetVal = @DishDetailID
	END
	ELSE
	BEGIN
		INSERT INTO msDishRecipe
		(DishDetailID, Ingredient, Quantity, Unit,AuditedActivity,AuditedTime)
		VALUES
		(@DishDetailID,@Ingredient,@Quantity,@Unit, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
END
GO

/****** Object:  StoredProcedure [dbo].[DishRecipe_Get]  Script Date: 07/03/2024 11:37:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 13 Maret 2024
 * Purpose: Get dish recipe
 */
CREATE PROCEDURE [dbo].[DishRecipe_Get]
AS
BEGIN
	SELECT 
		DishRecipeID,
		DishDetailID,
		Ingredient,
		Quantity
	FROM msDishRecipe WITH(NOLOCK)
	WHERE AuditedActivity <> 'D'
END

/****** Object:  StoredProcedure [dbo].[DishRecipe_GetByDishRecipeID]  Script Date: 13/03/2024 13:00:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 13 Maret 2024
 * Purpose: Get dish detail by dish id
 */
GO
CREATE PROCEDURE [dbo].[DishRecipe_GetByDishRecipeID]
    @DishDetailID INT
AS
BEGIN
    SELECT 
		DishRecipeID,
		DishDetailID,
 		Ingredient,
		Quantity,
		Unit
    FROM msDishRecipe WITH (NOLOCK)
    WHERE AuditedActivity <> 'D'
        AND DishDetailID = @DishDetailID
END
GO


/****** Object:  StoredProcedure [dbo].[DishRecipe_DishRecipeDelete]  Script Date:13 Maret 2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin 
 * Date: 13 Maret 2024
 * Purpose: delete dish recipe
 */
CREATE PROCEDURE [dbo].[DishRecipe_Delete]
	@DishRecipeIDs VARCHAR(MAX)
AS
BEGIN
	UPDATE msDishRecipe
	SET AuditedActivity = 'D',
		AuditedTime = GETDATE()
	WHERE DishRecipeID IN (SELECT value FROM fn_General_Split(@DishRecipeIDs, ','))
END
GO

/****** Object:  StoredProcedure [dbo].[DishRecipe_GetByID]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Edwin Tjandraatmadja
 * Date: 14 Maret 2024
 * Purpose: Get dish recipe tertentu by Id
 */
CREATE PROCEDURE [dbo].[DishRecipe_GetByID]
	@DishRecipeId INT
AS
BEGIN
	SELECT 
		DishRecipeID,
		DishDetailID,
		Ingredient,
		Quantity,
		Unit
	FROM msDishRecipe WITH(NOLOCK)
	WHERE DishRecipeID = @DishRecipeId AND AuditedActivity <> 'D'
END
GO

 
 -- SEEDING msDishType
INSERT INTO msDishType (DishTypeName,AuditedActivity,AuditedTime)
VALUES ('Rumahan','I',GETDATE()), ('Restoran','I',GETDATE()), ('Pinggiran','I',GETDATE())


