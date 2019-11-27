CREATE PROCEDURE [dbo].[CreateUser]
	@Name nvarchar(max),
	@Login nvarchar(max), 
	@Age int,
	@AccessId int
AS
BEGIN
	BEGIN TRANSACTION Transact
  BEGIN TRY
	insert into Users (Name, Login, Age)
	values (@Name, @Login, @Age)

	declare @UserId int
	set @userId = (select top 1 Id from Users order by Id desc)

	insert into UsersAccess (UserId, AccessId)
	values (@UserId, @AccessId)
 COMMIT TRANSACTION Transact
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION Transact
  END CATCH  
END

