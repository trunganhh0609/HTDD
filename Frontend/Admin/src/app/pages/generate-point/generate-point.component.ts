import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ThienAnConstant } from 'src/app/constants/thien-an.constant';
import { CommonService } from 'src/app/services/common/common.service';
import { AuthenticationUtil } from 'src/app/utils copy/authentication.util';

@Component({
  selector: 'app-generate-point',
  templateUrl: './generate-point.component.html',
  styleUrls: ['./generate-point.component.scss']
})
export class GeneratePointComponent implements OnInit {

  lstClass: [] = [];
  page:number = 1;
  userName: string = '';

  constructor(
    private commonService: CommonService,
    private router: Router
) { }

  ngOnInit(): void {
    this.userName = AuthenticationUtil.decodeToken().Username;
    this.getClassByIdTeacher(this.userName);
  }


  getClassByIdTeacher(idTeacher: any){
    const param = {
      "QuerryString":"[sp_appTeacher_ListClass] " + idTeacher,
      "PASSWORD": ThienAnConstant.PASSWORD
    }
    this.commonService.getClassByTeacher().subscribe(res=>{
      this.lstClass = res.Content;
    })
  }

  listStudent(data:any){
    this.router.navigate(['gen-point/class-point'], {
      queryParams: {idLop: data.ID_lop, idMon: data.ID_mon, tenMon: data.Ten_mon, startDate: data.Tu_ngay, endDate: data.Den_ngay}
    })
  }
}

