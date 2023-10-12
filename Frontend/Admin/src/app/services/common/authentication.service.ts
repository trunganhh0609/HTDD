import { DOCUMENT } from '@angular/common';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Cookie } from 'ng2-cookies';
import { AuthConstant } from 'src/app/constants/auth.constant';
import { environment } from 'src/environments/environment';
import { CommonService } from './common.service';
import { ApiUrlUtil } from 'src/app/utils/api-url.util';
import { Router } from '@angular/router';
import { AuthenticationUtil } from 'src/app/utils copy/authentication.util';
import { HeadersUtil } from 'src/app/utils copy/headers.util';

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  constructor(
    private http: HttpClient,
    private commonService: CommonService,
    @Inject(DOCUMENT) public document: any,
  ) {}

  logIn(data:any):Observable<any>{
      return this.http.post<any>(environment.authURL, data);
  }
  // getUserInfo(): Observable<any> {
  //   const headers: HttpHeaders = HeadersUtil.getHeadersAuth();
  //   const url = ApiUrlUtil.buildQueryString(
  //     environment.apiURL + '/api/userInfo/getUserInfo'
  //   );
  //   return this.http.get<any>(url, { headers: headers });
  // }


  logout(){
    AuthenticationUtil.deleteAllCookie();
  }
}
