import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { RequestParam } from 'src/app/models/request-param';
import { HeadersUtil } from 'src/app/utils copy/headers.util';
import { ApiUrlUtil } from 'src/app/utils/api-url.util';
import { ParamUtil } from 'src/app/utils/param.util';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class PointService {

  constructor(
    private http: HttpClient,
  ) { }

  addPoint(param: any): Observable<any>{
    // const header: HttpHeaders = HeadersUtil.getHeadersAuth();
    // const params: RequestParam[] = ParamUtil.toRequestParams(param);
    const url = ApiUrlUtil.buildQueryString(environment.apiURL + '/addPoint');
    return this.http.post<any>(url, param);

  }

  getPoint(param: any): Observable<any>{
    const params: RequestParam[] = ParamUtil.toRequestParams(param);
    const url = ApiUrlUtil.buildQueryString(environment.apiURL + '/getPoint', params);
    return this.http.get<any>(url);
  }
}
