ALTER PROCEDURE [dbo].[RegisterUser]
	@Name nvarchar(max),
	@Login nvarchar(max), 
	@Age int
AS
BEGIN
declare @LoginExist bit = 0
set @LoginExist = (select Count([Login]) from Users where Login = @Login)
if (@LoginExist = 0)
begin
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
   end
END