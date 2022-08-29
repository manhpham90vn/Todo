package model

type Category struct {
	ID     int    `json:"id" gorm:"column:id;"`
	Name   string `json:"name" gorm:"column:name;"`
	UserId int    `json:"users_id" gorm:"column:users_id;"`
}
