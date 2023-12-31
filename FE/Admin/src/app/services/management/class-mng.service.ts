import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiUrlUtil } from 'src/app/utils/api-url.util';
import { AuthenticationUtil } from 'src/app/utils/authentication.util';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ClassMngService {

  constructor(
    private http: HttpClient
    ) { }


  getData(){
    const headers = { 'Authorization': AuthenticationUtil.getToken() };
    const url = ApiUrlUtil.buildQueryString(environment.apiURL + '/class/getListClass');
    return this.http.get<any>(url, {headers});
  }

  searchTeacher(keySearch:any){
    const headers = { 'Authorization': AuthenticationUtil.getToken() };
    const url = ApiUrlUtil.buildQueryString(environment.apiURL + '/class/searchTeacher?keySearch='+keySearch);
    return this.http.get<any>(url, {headers});
  }

  addClass(param:any){
    const headers = { 'Authorization': AuthenticationUtil.getToken() };
    const url = ApiUrlUtil.buildQueryString(environment.apiURL + '/class/addClass');
    return this.http.post<any>(url, param, {headers});
  }
}
