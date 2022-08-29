package model

type Task struct {
	ID           int    `json:"id" gorm:"column:id;"`
	Name         string `json:"name" gorm:"column:name;"`
	DueDate      int    `json:"duedate" gorm:"column:duedate;"`
	Note         string `json:"note" gorm:"column:note;"`
	CategoryID   int    `json:"category_id" gorm:"column:category_id;"`
	IsCompleted  int    `json:"isCompleted" gorm:"column:isCompleted;"`
	IsFavourited int    `json:"isFavourited" gorm:"column:isFavourited;"`
	UserID       int    `json:"user_id" gorm:"column:user_id;"`
}
