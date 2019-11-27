CREATE PROCEDURE [dbo].[CreateUser]
	@Name nvarchar(max),
	@Login nvarchar(max), 
	@Age int,CREATE PROCEDURE [dbo].[RegisterUser]
	@Name nvarchar(max),
	@Login nvarchar(max), 
	@Age int
AS
BEGIN
declare @LoginExist bit = 0
set @LoginExist = (select Count([Login]) from Users where Login = @Login)
if (@LoginExist = 0)
	BEGIN TRANSACTION Transact
  BEGIN TRY
	declare @AccessId int 
	if (@Age >= 18)
	begin
		set @AccessId = 1
	end
	if (@Age < 18)
	begin
		set @AccessId = 2
	end

	exec [CreateUser] @Name, @Login, @Age, @AccessId
 COMMIT TRANSACTION Transact
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION Transact
  END CATCH  
END

select * from Access
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

