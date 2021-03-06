/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

/********************************************************************20**

     Name:     

     Type:     C Hearder file

     Desc:     Defines required by the NBU layer service user

     File:     nbu.x

     Sid:      
     Prg:      

*********************************************************************21*/
typedef struct _nbuSTmsi
{
   Bool                      pres;
   U8                        mmec;
   U32                       mTMSI;
} NbuSTmsi;

typedef struct _nbuUeAttachReq
{
    U8 ueId;
    U32 rrcCause;
    NbuSTmsi stmsi;
    TknStrOSXL nasPdu;
}NbuInitialUeMsg;

typedef struct _nbuUlNasMsg
{
   U8 ueId;
   TknStrOSXL  nasPdu;
}NbuUlNasMsg;
typedef struct _nbuUlRrcMsg
{
   U8 ueId;
   TknStrOSXL  rrcPdu;
}NbuUlRrcMsg;

typedef struct _nbuDlNasMsg
{
   U8 ueId;
   TknStrOSXL nasPdu;
}NbuDlNasMsg;

typedef struct _nbuErabCb
{
   U8 erabId;
   TknStrOSXL nasPdu;
}NbuErabCb;

typedef enum _nbuCauseRadioNw
{
  NBU_CAUSE_RADIONW_UNSPECIFIED = 0,
  NBU_CAUSE_RADIONW_UNKNOWN_MME_UE_S1AP_ID = 1,
  NBU_CAUSE_RADIONW_UNKNOWN_ENB_UE_S1AP_ID
}NbuCauseRadioNw;
typedef enum  _nbuCauseTport
{
   TEMP_1,
   TEMP_2
} NbuCauseTport;
typedef enum  _nbuCauseProt
{
   TEMP_3,
   TEMP_4
}NbuCauseProt;
typedef enum  _nbuCauseNas
{
   TEMP_5,
   TEMP_6
}NbuCauseNas;
typedef enum  _nbuCauseMisc
{
   TEMP_7,
   TEMP_8
}NbuCauseMisc;

typedef struct _nbuErabRelCause
{
        U8 choice;
        union {
                NbuCauseRadioNw radioNw;
                NbuCauseTport transport;
                NbuCauseNas nas;
                NbuCauseProt protocol;
                NbuCauseMisc misc;
        } val;
}NbuErabRelCause;

typedef struct _nbuErabRelCb
{
   U8 erabId;
   NbuErabRelCause cause;
}NbuErabRelCb;
typedef struct _nbuErabLst
{
   U8 numOfErab;
   NbuErabCb *rabCbs; 
}NbuErabLst;

typedef struct _nbuErabRelLst
{
   U8 numOfErab;
   NbuErabRelCb *rabCbs; 
}NbuErabRelLst;

typedef struct _nbuErabRelIndLst
{
   U8 ueId;
   U8 numOfErabIds;
   U8 *erabIdLst; 
}NbuErabRelIndList;

typedef struct _nbuErabsRelInfo 
{
   U8 ueId;
   Bool nasPduPres;
   NbuErabRelLst *erabInfo;
   TknStrOSXL nasPdu;
}NbuErabsRelInfo;

typedef struct _nbuErabsInfo 
{
   U8 ueId;
   Bool nasPduPres;
   Bool ueRadCapRcvd;
   NbuErabLst *erabInfo;
}NbuErabsInfo;

typedef struct _nbuS1RelInd
{
   U8 ueId;
}NbuS1RelInd;

typedef struct _nbuUeInActvInd
{
   U8 ueId;
}NbuUeInActvInd;

typedef struct _nbuUeIpInfoReq
{
   U8 ueId;
   U8 bearerId;
}NbuUeIpInfoReq;

typedef struct _uePagingMsg
{
   U8      ueIdenType;
   union
   {   
      NbuSTmsi  sTMSI;      /*!< S-TMSI of the UE*/ 
      U8       imsi[22];   /*!< IMSI of the UE. IMSI size is
                             min-6 Integer digits and
                             max-21 Integer Digits.As we are using
                             the first index for the storing
                             the length of IMSI */
   } ueIden;     /*!< It contians either IMSI or S-TMSI */
   U8      domIndType;

}UePagingMsg;

typedef enum  _bearerType
{
 DEFAULT_BER =1,
 DEDICATED_BER
}BearerType;

typedef struct _nbuUeIpInfoRsp
{
   U8 ueId;
   U8 bearerId;
   S8 IpAddr[20];
   BearerType berType;
}NbuUeIpInfoRsp;

typedef struct _nbuTunDelReq
{
   U8 ueId;
   U32 erabId;
}NbuTunDelReq;

typedef S16 (*NbuInitialUeMsgHdl)(Pst*, NbuInitialUeMsg*);
typedef S16 (*NbuUlNasMsgHdl)(Pst*, NbuUlNasMsg*);
typedef S16 (*NbuDlNasMsgHdl)(Pst*, NbuDlNasMsg*);
typedef S16 (*NbuPagingMsgHdl)(Pst*, UePagingMsg*);
typedef S16 (*NbuUlRrcMsgHdl)(Pst*, NbuUlRrcMsg*);
typedef S16 (*NbuUeInactivHdl)(Pst *, NbuUeInActvInd*);
typedef S16 (*NbuS1RelIndMsgHdl)(Pst *, NbuS1RelInd*);
typedef S16 (*NbuErabsInfoMsgHdl) (Pst *, NbuErabsInfo*);
typedef S16 (*NbuErabsRelInfoMsgHdl) (Pst *, NbuErabsRelInfo*);
typedef S16 (*NbuUeIpInfoReqHdl) (Pst *, NbuUeIpInfoReq*);
typedef S16 (*NbuUeIpInfoRspHdl) (Pst *, NbuUeIpInfoRsp*);
typedef S16 (*NbuErabRelIndHdl)(Pst *, NbuErabRelIndList*);/*NbErabRelInd*);*/
EXTERN S16 cmPkNbuInitialUeMsg(Pst *pst,NbuInitialUeMsg *req);
EXTERN S16 cmPkNbuErabRelInd(Pst *pst, NbuErabRelIndList *);
EXTERN S16 cmPkNbuUlNasMsg(Pst *pst,NbuUlNasMsg *msg);
EXTERN S16 cmPkNbuDlNasMsg(Pst *pst,NbuDlNasMsg *msg);
EXTERN S16 cmPkNbuUeInActvInd(Pst*, NbuUeInActvInd*);
EXTERN S16 cmPkNbuS1RelInd(Pst*, NbuS1RelInd*);
EXTERN S16 cmPkNbuUeIpInfoReq ARGS((Pst *pst,NbuUeIpInfoReq *req));
EXTERN S16 cmPkNbuErabsInfo (Pst *pst,NbuErabsInfo *msg);
EXTERN S16 cmPkNbuUeIpInfoRsp (Pst *pst,NbuUeIpInfoRsp *msg);
EXTERN S16 cmPkNbuUlRrcMsg ARGS((Pst *pst, NbuUlRrcMsg *msg));
EXTERN S16 cmPkNbuErabsRelInfo (Pst *pst,NbuErabsRelInfo *msg);

EXTERN S16 cmUnPkNbuInitialUeMsg(NbuInitialUeMsgHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuErabRelInd(NbuErabRelIndHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuUlNasMsg(NbuUlNasMsgHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuDlNasMsg(NbuDlNasMsgHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuDlNasMsg(NbuDlNasMsgHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuUeInActvInd(NbuUeInactivHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuS1RelInd(NbuS1RelIndMsgHdl, Pst*, Buffer*);
EXTERN S16 NbUiNbuHdlInitialUeMsg(Pst*, NbuInitialUeMsg*);
EXTERN S16 NbUiNbuHdlErabRelInd(Pst*, NbuErabRelIndList*); /*NbErabRelInd*);*/
EXTERN S16 NbUiNbuHdlUlNasMsg(Pst*, NbuUlNasMsg*);
EXTERN S16 cmUnPkNbuErabsInfo(NbuErabsInfoMsgHdl func, Pst *pst, Buffer *mBuf);
EXTERN S16 cmPkNbuPagingMsg(Pst *pst, UePagingMsg *msg);
EXTERN S16 cmUnPkNbuPagingMsg(NbuPagingMsgHdl, Pst*, Buffer*);
EXTERN S16 cmUnPkNbuUlRrcMsg ARGS((NbuUlRrcMsgHdl, Pst*, Buffer*));
EXTERN S16 NbUiNbuHdlUeRadioCapMsg(Pst *pst, NbuUlRrcMsg *msg);
EXTERN S16 cmUnPkNbuUeIpInfoReq (NbuUeIpInfoReqHdl func,Pst *pst,Buffer *mBuf);
EXTERN S16 cmUnPkNbuUeIpInfoRsp (NbuUeIpInfoRspHdl func,Pst *pst,Buffer *mBuf);
EXTERN S16 cmUnPkNbuErabsRelInfo(NbuErabsRelInfoMsgHdl func, Pst *pst, Buffer *mBuf);
/********************************************************************30**

         End of file:     

*********************************************************************31*/
