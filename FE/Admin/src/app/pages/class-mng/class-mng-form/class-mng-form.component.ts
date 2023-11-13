import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ClassMngService } from 'src/app/services/management/class-mng.service';

@Component({
  selector: 'app-class-mng-form',
  templateUrl: './class-mng-form.component.html',
  styleUrls: ['./class-mng-form.component.scss']
})
export class ClassMngFormComponent implements OnInit {

  formData = {};
  submitted = false;
  keySearch = '';
  lstTeacher = [];

  constructor(
    @Inject(MAT_DIALOG_DATA) public data,
    private dialogRef: MatDialogRef<ClassMngFormComponent>,
    private classMngService: ClassMngService
  ) { }

  ngOnInit(): void {
    if(this.data){
      console.log(this.data);

      this.formData = this.data;
    }
  }

  submit(invalid) {
    if(!invalid){
      console.log(this.formData);
      this.classMngService.addClass(this.formData).subscribe(result => {
          this.dialogRef.close(result.status)
      })
    }
  }

  close() {
    this.dialogRef.close();
  }

  onSearchTeacher(event: any) {
    console.log(event.target.value);
    if (event.target.value.trim() != '') {
      this.classMngService.searchTeacher(event.target.value).subscribe(res => {
        if (res.status) {
          this.lstTeacher = res.data;
        }
      })
    }
  }

  onChangeTeacher(userId){
    this.formData['teacherId'] = userId;
  }

}
