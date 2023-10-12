import { HttpHeaders } from "@angular/common/http";
import { environment } from "src/environments/environment";
import { ThienAnConstant } from "../constants/thien-an.constant";

export class HeaderUtil{
  public static getHeaders(): HttpHeaders {
    return new HttpHeaders({
      'Content-Type': 'application/json'
    });
  }

  public static getHeaderAuthTA(token:any){
    const header = new HttpHeaders()
      .set('Content-Type', 'application/json')
      .set('Authorization', token)
    return header;
  }
  public static getHeadersAuth(): HttpHeaders {
    const token = '';
    if (!token) {
      return HeaderUtil.getHeaders();
    }
    const header :HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    return header;
  }

}
