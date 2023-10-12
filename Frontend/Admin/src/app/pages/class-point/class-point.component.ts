import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { ThienAnConstant } from 'src/app/constants/thien-an.constant';
import { AttendanceService } from 'src/app/services/attendance/attendance.service';
import { CommonService } from 'src/app/services/common/common.service';
import { LoaderService } from 'src/app/services/loader.service';
import { PointService } from 'src/app/services/point/point.service';
import { CreatePointFormComponent } from './create-point-form/create-point-form.component';
import * as XLSX from 'xlsx';
import { element } from 'protractor';

@Component({
  selector: 'app-class-point',
  templateUrl: './class-point.component.html',
  styleUrls: ['./class-point.component.scss']
})
export class ClassPointComponent implements OnInit {
  dataTable: any = [];
  classInfo: any = {};
  dataCheckin : any;
  totalAttendance: number = 0;
  lstSinhVien: any = [];
  lstPoint:any = [];
  dataSheet:any =[];
  countLesson: number = 0;
  constructor(
    private commonService: CommonService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
    private attendanceService: AttendanceService,
    private pointService: PointService
  ) { }

  ngOnInit(): void {
    this.getClassInfo();
    this.getStudentInClass();
  }

  openPopup(){
    this.dialog.open(CreatePointFormComponent).afterClosed().subscribe(result=>{
      const request = {
        idClass : this.classInfo.idLop,
        idSubject: this.classInfo.idMon,
      }
      this.getCheckinData(request, result)
    })
  }
  async getClassInfo(){
    await this.route.queryParams.subscribe(async res =>{
      this.classInfo = res
      this.countLesson = this.diff_weeks(new Date(this.classInfo.startDate),new Date(this.classInfo.endDate))
      // console.log(Math.round(this.countLesson * 1/5));

    })
  }

  getStudentInClass(){
    const param = {
      "QuerryString":"[sp_appTeacher_DiemDanhKeHoach_ChiTiet_Load_List]0," + this.classInfo.idLop +"," + this.classInfo.idMon + ",'2020-01-01',1,1,1" ,
      "PASSWORD": ThienAnConstant.PASSWORD
    }
    this.commonService.getStudentInClass(param).subscribe( result => {
      this.dataTable = result.Content
      const request = {
        idClass : this.classInfo.idLop,
        idSubject: this.classInfo.idMon,
      }
      this.pointService.getPoint(request).toPromise().then(res =>{
        this.lstPoint = res.data
        this.dataTable.forEach(ele=>{
          this.lstPoint.forEach(pointItem =>{
            if(pointItem.USER_ID == ele.Ma_sv){
              ele['point'] = pointItem.POINT
            }
          })
        })
        this.setDataSheet()
      })


    })

  }

  getCheckinData(request:any, dataForm: any){
    this.lstSinhVien = this.dataTable
    this.attendanceService.getListAttendanceInLesson(request).toPromise().then(res => {
      this.dataCheckin = res.listAttendanceInLesson
      let lstAttendanceInAllLesson = res.attendanceInAllLesson;
      this.totalAttendance = res.totalLessonAttendance;
      for(var i=0; i<this.lstSinhVien.length; i++){
        this.lstSinhVien[i]['numAttendance'] = 0
        this.lstSinhVien[i]['numLate'] = 0
        lstAttendanceInAllLesson.forEach(element=>{
          if(element.USER_ID == this.lstSinhVien[i].Ma_sv){
            if(element.STATUS == '01-02'){
              this.lstSinhVien[i]['numAttendance'] += 1;
            }
            if(element.STATUS == '01-03'){
              this.lstSinhVien[i]['numLate'] += 1;
            }

          }
        })
      }
      this.lstSinhVien.forEach(element => {
        element['point'] = 10;
        if((res.totalLessonAttendance - Math.round(element.numLate*parseFloat(dataForm.late)) - element['numAttendance']) >= dataForm.half){
          element['point'] = 5
        }
        if((res.totalLessonAttendance - Math.round(element.numLate*parseFloat(dataForm.late)) - element['numAttendance']) >= Math.round(this.countLesson * 1/5)){
          element['point'] = 0
        }
      });
      this.dataTable = this.lstSinhVien


      const dataRequest = {
        idClass : this.classInfo.idLop,
        idSubject: this.classInfo.idMon,
        lstPoint : this.dataTable
      }
      this.pointService.addPoint(dataRequest).subscribe(res => {
        this.getStudentInClass();
      })
      this.setDataSheet()
    })
  }
  diff_weeks(dt2 : Date, dt1 : Date)
  {
   var diff =(dt2.getTime() - dt1.getTime()) / 1000;
   diff /= (60 * 60 * 24 * 7);
   return Math.abs(Math.round(diff));
  }
  setDataSheet(){
    this.dataSheet = []
    this.dataTable.forEach((element, index)=>{
      let itemData = {}
      itemData['STT'] = index + 1;
      itemData['Mã sinh viên'] = element.Ma_sv;
      itemData['Họ tên'] = element.Ho_ten;
      itemData['Giới tính'] = element.Gioi_tinh;
      itemData['Ngày sinh'] = element.Ngay_sinh;
      itemData['Lớp'] = element.Ten_lop;
      itemData['Khoa'] = element.Ten_khoa;
      itemData['Điểm chuyên cần'] = element.point;
      this.dataSheet.push(itemData);
    })
  }

  export(){
    const ws: XLSX.WorkSheet = XLSX.utils.json_to_sheet(this.dataSheet);
    ws['!cols'] = [{width:10}, {width:15}, {width:15}, {width:25}, {width:20},{}, {width:30}, {width:20}]
    const wb: XLSX.WorkBook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'Sheet1');
    XLSX.writeFile(wb, "diem_chuyen_can "+ this.classInfo.tenMon +".xlsx");
  }

}
