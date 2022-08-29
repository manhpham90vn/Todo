package model

type LoginModel struct {
	Email    string `json:"email" gorm:"column:email" binding:"required,email"`
	Password string `json:"password" gorm:"column:password" binding:"required,min=8,max=255"`
}
