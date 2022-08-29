package model

type User struct {
	ID           int    `json:"id" gorm:"column:id"`
	UserName     string `json:"username" gorm:"column:username" binding:"required,alphanum,min=4,max=255"`
	Email        string `json:"email" gorm:"column:email" binding:"required,email"`
	Password     string `json:"password" gorm:"column:password" binding:"required,min=8,max=255"`
	CreateTime   int    `json:"create_time" gorm:"column:create_time"`
	UpdateTime   int    `json:"update_time" gorm:"column:update_time"`
	AccessToken  string `json:"access_token" gorm:"column:access_token"`
	RefreshToken string `json:"refresh_token" gorm:"column:refresh_token"`
}
