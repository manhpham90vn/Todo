package model

type RegisterModel struct {
	UserName string `json:"username" gorm:"column:username" binding:"required,alphanum,min=4,max=255"`
	Email    string `json:"email" gorm:"column:email" binding:"required,email"`
	Password string `json:"password" gorm:"column:password" binding:"required,min=8,max=255"`
}
