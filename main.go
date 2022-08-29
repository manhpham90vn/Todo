package main

import (
	"TodoBackEnd/helpers"
	"TodoBackEnd/model"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func main() {
	// connect db
	dsn := "root:toor@tcp(localhost:3306)/todo_db?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		fmt.Println("Error connecting to database : error", err)
	}

	route := gin.Default()
	api := route.Group("/api")
	{
		api.POST("/user/register", func(ctx *gin.Context) {
			var user model.RegisterModel
			// check bind and validate
			if errorShouldBindJSON := ctx.ShouldBindJSON(&user); errorShouldBindJSON != nil {
				ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
					"message": errorShouldBindJSON.Error(),
				})
				return
			}

			// check hash password
			hashedPassword, errorHash := helpers.HashPassword(user.Password)
			if errorHash != nil {
				ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
					"message": errorHash.Error(),
				})
				return
			}

			user.Password = hashedPassword
			// create user
			if error := db.Table("user").Create(&user).Error; error != nil {
				ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
					"message": error.Error(),
				})
				return
			}

			ctx.JSON(http.StatusOK, gin.H{
				"data": user,
			})
		})

		api.POST("/user/login", func(ctx *gin.Context) {
			var loginModel model.LoginModel
			var user model.User

			// check bind and validate
			if errorShouldBindJSON := ctx.ShouldBindJSON(&loginModel); errorShouldBindJSON != nil {
				ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
					"message": errorShouldBindJSON.Error(),
				})
				return
			}

			if error := db.Table("user").Where("email = ?", loginModel.Email).First(&user).Error; error != nil {
				ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
					"message": error.Error(),
				})
				return
			}

			if !helpers.CheckPasswordHash(loginModel.Password, user.Password) {
				ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
					"message": "Wrong password",
				})
				return
			}

			ctx.JSON(http.StatusOK, gin.H{
				"data": user,
			})

		})
	}

	route.Run(":8080")
}
