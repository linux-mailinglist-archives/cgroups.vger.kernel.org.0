Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0D679D50
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 16:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjAXPW5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjAXPW4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 10:22:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5219A7DAF;
        Tue, 24 Jan 2023 07:22:52 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEAvkv001062;
        Tue, 24 Jan 2023 15:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=zKahx/26rU2y5d8c6FBCmzIL/utDrXbK8NwDGiNVaAY=;
 b=fcbGN5z+UgIRxlJSHjJoTvwj1wfiywWaB7m4yqxnwIefp5Nr2pcAC3x+qkeht6h3xy9c
 xHHLUJowvN2aL31s8w19PbYSr/zfSI/ghejkAhtmuPUc9LK2Xfg8wLZiaIvTR3Rl8QkO
 B8u9pvgmoAkyHRjoK3vVe/7COEIZL/64Dm0IiDbACBNFNOD7wOaMkwdEWSewqBVxkFN+
 GAArOUty19lLrPZAL2UllrBxReShJ+z/xpmqkE4EGkTjQ0G2A95dRKhJVOTjQpSuV7jf
 gU18mDNXB3PrXFUDgUgAXjnco55V7zGI6K1Iq0fSLoE6ppBkBh0lZFLBC7c3tlAp/9qP vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg0rmwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 15:22:36 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ODZT0S010206;
        Tue, 24 Jan 2023 15:22:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg0rmwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 15:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdJQe/MQb0JE6BN8ATv7fnTDUdcVNLxO6548WEX4lEc5PvrbKIucsYZIkddl/Uz8qoVz6jw1gof+41QsEiss7NDzovrsnC/JR4ARfdk69lee1xwb0+y+7T1ASG9UcSpyXiBhBVkCkbLN3UM2UQRTOnbCxReYB139/DTUvUbZi03jDL0S3LZVb4lx0kFifF43bsRoi/20x5g+v2mICTicvldAWCh9u+OB+d8jC+ylRJnppRkDGfI5jaM5MpVGh8koCDzjeAewPM7PvWcPPLG201VD6I8EXS4nBgW4C4s4ihYbKhnrm5cEj6nHI/MMdjgks1LWaHkBdir/qbMN5eROsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKahx/26rU2y5d8c6FBCmzIL/utDrXbK8NwDGiNVaAY=;
 b=lU3jHqx2EjUf987gT9l7zJl4Xiuxmtj3nnTQeCL0ekSYDU48nxm0UTdanC4YFQR6D6sbGcA44y1j1trLaqBUdEJpnTSEPKllGsdIWfyhMmdlUnl+xqrmizKXEOxC55Ow7td7yuLwQvMRz8rqdBzQwv1KEw//5X4dlWgJ6jAd5JM7bjUFcxRL3RbqZHLobqBNLQxM7KHYvvIevoy4QGaJnB6jS5NmbXBd9UNtXWyHtTJWimSjOe+0ZolbwXxyIaPNkFbycm0rRM8e3jvHVZGRmmE8ETpnX8giIxweq0D0ZM3xc8LThe+Te3UWG8Tj9mZt92tkTB/pctwtiDvnoXLfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BY1PR15MB6102.namprd15.prod.outlook.com (2603:10b6:a03:52a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:22:33 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%8]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:22:33 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "surenb@google.com" <surenb@google.com>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 05/19] RMDA/siw: Convert to use
 vm_account
Thread-Index: AQHZMAFcvDYXQj0ZBk+u14TQW21Sfq6trvPg
Date:   Tue, 24 Jan 2023 15:22:32 +0000
Message-ID: <SA0PR15MB3919CF22BBACD6A25ECFAD2699C99@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
 <Y8/tGIeg5mI9bDOa@nvidia.com>
In-Reply-To: <Y8/tGIeg5mI9bDOa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|BY1PR15MB6102:EE_
x-ms-office365-filtering-correlation-id: b7a5e67d-fe7c-4c4c-a513-08dafe1ed0b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwIrktVW9qxO8kt+Soxks6Ih9hjqQo5LvzrxTVLYno/MI1AbtzNZVovPdDdz/ZKBnzHS/2WmjY3SQuJQn421AVm6g03+1rRE86wLmulGQjEKvmTlRB+4rVbiP860GZnzRuVTC6gQtnhx69Tl+84AoRGxB5vPr+XilCYxY/QURdLnpc5F6S7svDSlt2iQTDexu/AOUWyA3bPS53n+z7mAcT5cRE/N/qLnMbA7HOgyZk4DOTEUBunJ1NvLfBwu0/PxRGAJXuqoOr+PbVzYa88slqmoxjZBusiGqUnCqVf8Tjh7EYMIc1f4G0liOlmWplv/6MtvWBwg4bIDld4bhOPEs9y6OQ6sHWCQZNsla8IPgpwBkjBgRNiROkD51ZjE5GsFTPfCFn170uTDMmRuH+knDN6vPwxacHFGC3F+uUh/IbGCIDD8ftJgjihJD1csxYSA/m2QXdL87z/y0kqITAO6rx3MD2WypTm/Bap2nI6vEC64qtKXs13sLZpJ7e6NF/Y2bdjdBoVwlxF4G1YvH/nzXR0jB5ceK7uIeyd1f4qNCkk9RpbmsOWy8H2Qn6KWPRUkLxfrByODGKI+P/orqrn4tkKj6v4Hvl3+9EythPgDqjh12api1xn1RP8jolMA3FTDkDZ3tCJ0RivF8ojhUGS6c+9M9id16NSKbkjFTmcVISghfk4yFsDOaBf7pdbirf0YL4zetrbSPMaNIFUJKsBSaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(478600001)(86362001)(52536014)(2906002)(7416002)(8936002)(38100700002)(122000001)(5660300002)(33656002)(110136005)(54906003)(6506007)(83380400001)(71200400001)(7696005)(38070700005)(186003)(9686003)(26005)(316002)(41300700001)(76116006)(53546011)(4326008)(66946007)(66446008)(66556008)(8676002)(64756008)(66476007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWZNQUg2VWxvL1ZsM2dvTGNMeEJhcjg4cTZaWEF5RDAyVlN5VkRjeTMyQ1BQ?=
 =?utf-8?B?K0VMeWNBaDUyclRjd1JlUnA1UVdmbWlZTEhQSDBETjJNTldTWDBmL2Jhakxk?=
 =?utf-8?B?WHNyQW04L2JuL2h6SzdkeHh5ZVhNd2xHRTVScWxhOTEwU1ArQi9RbVNicXQ4?=
 =?utf-8?B?VXdGVmUwVW9UbkxnQ2pPQ2lOaVpmWkNMeng0L0RQMytacnV5czZuZDBvbnQw?=
 =?utf-8?B?dGFVQUZYRE9JcFIrc1RyVjE1cG9UWk5HYzlEZ0IzeDNDSStQRWp6NE1XcXdt?=
 =?utf-8?B?OGo2SHN6VzY4M21LOXNrcGdPRHFFYlFWU1VvcGlMZE9TMFdvK0oyQSsrS2dF?=
 =?utf-8?B?b2l4T3hZZHltejQ4ZVJIMWk3bmlBRDhtUUdvRjBtVFlGb0Rnck5yYW1qekxm?=
 =?utf-8?B?aDU4WWlOdkE3bVo1cmNoZGREbHhUNCtNcmVXVEJIWUVCdEordVUycnlqOXBT?=
 =?utf-8?B?NmxOME0wdnptaUsyZjl1bTBvTk55b2dHM2F4bGNTVUl5cmVwbTZ2cE5JZ3l1?=
 =?utf-8?B?Nk52TFZ6NVZHZW5TVDVmbE9Nekd6a2IvMEdaUlo3dVVDTzJDa3k0NGtvQ24v?=
 =?utf-8?B?dCtXbk1ueXN2cG1SUXg2OVFBaFdWSHdNWGxEbDZpSzZvRkJhRDRzdEV0a3pO?=
 =?utf-8?B?TXFlelBOWENuWUR4Z0ltb1ZiUmt6OWkySFBTcmtDSWpRYTVMOGwwWTREcGJO?=
 =?utf-8?B?WjlRbG83R0lNNTNmTkIvVlBjNnJESllqTjJyZFdzUWRQeTJCRmlLMjlIUm5M?=
 =?utf-8?B?REx1bTZtVTluSGZjMW95MWl5Y0FGYUFKVy9zYmJMTjhBNE5TZXRKdU4rMEla?=
 =?utf-8?B?NTV2NkxWU1JPODBWNi9RYmZvNUJFOE5hTjBIZVAvUzlJTS9JZ2pVamZJb3ho?=
 =?utf-8?B?SnBMeXU5YjhtVnQwa2lrRGJJZkFpaXgwb2hmVmIvdEFYa1RqWEZvWkF6eEZh?=
 =?utf-8?B?dTZmdVQ3L2FMcitaRGQ4eFAzU3owNkI5L0ZOclFHU1NHNk5LdG5sYjBGZlFN?=
 =?utf-8?B?YXpYM3NqOE5CcVRNT2xFcmRndVEvRkdOSFAwWG8vdHhTcXlUQ20xSGRra0oy?=
 =?utf-8?B?WDA5bWZLcjIwMFkyd0lVMVBKVFFUSXlEL3piMm5nampMU2NRT3FkdjdCY3ly?=
 =?utf-8?B?QXcyQ1hrMGRnd3liWnhoaFJZREVyMDhmSXMrVGFoMU1zakxkYmdwdzllV0d0?=
 =?utf-8?B?VVBZQ0ZlUkpMd2d6VmRmcFBLUkdQTWt0dHEwSkJiREMwM0s5SytTVkoveGUv?=
 =?utf-8?B?Rkc3TVNHN1BNSnNRSzlyd2Y3YlNLQXU4dmw5VVlvY25wdmU2WjJxUW16QXpu?=
 =?utf-8?B?bitkcUR1eXNIUWYza3crc3MvZmtaZlpTRk1LcC8vVFY3R3lNeEhjSmlHL0N1?=
 =?utf-8?B?WnE2bEdFcDZ6Z09mQ2Vrd3FveCtUditJQkgxb2g0eDZHYWo2WmVZV2FsaGE3?=
 =?utf-8?B?dCswVmpWVzMzdi9sSUluUmUxM3dHbWttb0tTUGxvTUNSWUU1UGI2SVJCOTB5?=
 =?utf-8?B?YTNJMURLZnltTEdZQUJGbG5qOVN1eDVRcDlVUU9MYW9RV2c0TVZLcFVIbisw?=
 =?utf-8?B?MWc2c3gvZDZkT1ROQmx5M1c3dmtXVCtLMHA2RXRKVXV1QkJUdm5EUzc3bU13?=
 =?utf-8?B?R2htMzR3Z3VXeW5aeG12VzUybDFLeWtmSkxUbVdENHRSM0czUTdKdytrdHVP?=
 =?utf-8?B?RVpXVUtwVU5oYWpGeGlQSFBaVkxyWEdyUkNGMmlqWGxWS3FxMyt5SUpqVVZi?=
 =?utf-8?B?Q0ZuU2I5K1dlQTFxNjlJaTdhK2o5Nmk5UkhZckFtMDZLTDlGbzhDUVVQNS93?=
 =?utf-8?B?clF0VHRJazdzTXBrbUlIV2g1TmlTTVd6SmU5ZlRXbDdVQlh1LzlkZ2p5Y3pr?=
 =?utf-8?B?eTRhVmtKWVJ2NWN1V0kwZEhyM3RZcnM2MXlWdXNaaEpvQk9mczlOUWVWSHVy?=
 =?utf-8?B?RVVWOXBualRRcmRHK3pNNW1yMXN1VmRBcGhDektPdjZLeENRbHE0NXc1RnJs?=
 =?utf-8?B?eE9VWEVVc2Y0MWJvT0JvZ1ZWcmVJVStKTVo4ZVhiK2VoaWpjbFlkTVlKeUNV?=
 =?utf-8?B?aDB2OXR6eDl5cFZHK1I2by9pa3FkNHFiamNvMGJUOFpFdklWQVpOUmNRVzR2?=
 =?utf-8?Q?e8Kg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a5e67d-fe7c-4c4c-a513-08dafe1ed0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 15:22:32.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVOQGM8ZvGbQPnN94JYNnCH2rSmcRexl/APQGTn0YbR+5g+AD+7DXubc7DaZwoLa1SOOGEOjsy1KNasOeTx0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6102
X-Proofpoint-ORIG-GUID: fnpYiMW3urqzycgU5Scpx4sH9iLSjhSc
X-Proofpoint-GUID: YU6AG9TkFgX0RKvBosIXEPaqCy3xMyIg
Subject: RE: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=952
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMjQgSmFudWFyeSAyMDIzIDE1OjM3
DQo+IFRvOiBBbGlzdGFpciBQb3BwbGUgPGFwb3BwbGVAbnZpZGlhLmNvbT4NCj4gQ2M6IGxpbnV4
LW1tQGt2YWNrLm9yZzsgY2dyb3Vwc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBqaHViYmFyZEBudmlkaWEuY29tOyB0am1lcmNpZXJAZ29vZ2xlLmNv
bTsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBzdXJlbmJAZ29vZ2xlLmNvbTsgbWtvdXRueUBzdXNl
LmNvbTsgZGFuaWVsQGZmd2xsLmNoOw0KPiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJt
LmNvbT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsNCj4gbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1JGQyBQQVRDSCAwNS8x
OV0gUk1EQS9zaXc6IENvbnZlcnQgdG8gdXNlDQo+IHZtX2FjY291bnQNCj4gDQo+IE9uIFR1ZSwg
SmFuIDI0LCAyMDIzIGF0IDA0OjQyOjM0UE0gKzExMDAsIEFsaXN0YWlyIFBvcHBsZSB3cm90ZToN
Cj4gDQo+ID4gQEAgLTM4NSwyMCArMzgyLDE2IEBAIHN0cnVjdCBzaXdfdW1lbSAqc2l3X3VtZW1f
Z2V0KHU2NCBzdGFydCwgdTY0IGxlbiwNCj4gYm9vbCB3cml0YWJsZSkNCj4gPiAgCWlmICghdW1l
bSkNCj4gPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPg0KPiA+IC0JbW1fcyA9IGN1
cnJlbnQtPm1tOw0KPiA+IC0JdW1lbS0+b3duaW5nX21tID0gbW1fczsNCj4gPiAgCXVtZW0tPndy
aXRhYmxlID0gd3JpdGFibGU7DQo+ID4NCj4gPiAtCW1tZ3JhYihtbV9zKTsNCj4gPiArCXZtX2Fj
Y291bnRfaW5pdF9jdXJyZW50KCZ1bWVtLT52bV9hY2NvdW50KTsNCj4gPg0KPiA+ICAJaWYgKHdy
aXRhYmxlKQ0KPiA+ICAJCWZvbGxfZmxhZ3MgfD0gRk9MTF9XUklURTsNCj4gPg0KPiA+IC0JbW1h
cF9yZWFkX2xvY2sobW1fcyk7DQo+ID4gKwltbWFwX3JlYWRfbG9jayhjdXJyZW50LT5tbSk7DQo+
ID4NCj4gPiAtCW1sb2NrX2xpbWl0ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NI
SUZUOw0KPiA+IC0NCj4gPiAtCWlmIChudW1fcGFnZXMgKyBhdG9taWM2NF9yZWFkKCZtbV9zLT5w
aW5uZWRfdm0pID4gbWxvY2tfbGltaXQpIHsNCj4gPiArCWlmICh2bV9hY2NvdW50X3Bpbm5lZCgm
dW1lbS0+dm1fYWNjb3VudCwgbnVtX3BhZ2VzKSkgew0KPiA+ICAJCXJ2ID0gLUVOT01FTTsNCj4g
PiAgCQlnb3RvIG91dF9zZW1fdXA7DQo+ID4gIAl9DQo+ID4gQEAgLTQyOSw3ICs0MjIsNiBAQCBz
dHJ1Y3Qgc2l3X3VtZW0gKnNpd191bWVtX2dldCh1NjQgc3RhcnQsIHU2NCBsZW4sDQo+IGJvb2wg
d3JpdGFibGUpDQo+ID4gIAkJCQlnb3RvIG91dF9zZW1fdXA7DQo+ID4NCj4gPiAgCQkJdW1lbS0+
bnVtX3BhZ2VzICs9IHJ2Ow0KPiA+IC0JCQlhdG9taWM2NF9hZGQocnYsICZtbV9zLT5waW5uZWRf
dm0pOw0KPiANCj4gQWxzbyBmaXhlcyB0aGUgcmFjZSBidWcNCj4gDQpUcnVlISBTaG91bGQgaGF2
ZSB1c2VkIGF0b21pYzY0X2FkZF9yZXR1cm4oKSBpbiB0aGUgZmlyc3QgcGxhY2UuLi4NCg0KQmVy
bmFyZC4NCg0K
