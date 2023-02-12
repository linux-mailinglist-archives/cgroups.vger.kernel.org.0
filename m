Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2224693911
	for <lists+cgroups@lfdr.de>; Sun, 12 Feb 2023 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBLRcl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Feb 2023 12:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLRcj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Feb 2023 12:32:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E49CDD8;
        Sun, 12 Feb 2023 09:32:37 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CHO1kF023899;
        Sun, 12 Feb 2023 17:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=skl1XcvQW67x8eHf8hn2qsT50WstW7K1l9AEb+x7axE=;
 b=fgfpvUtxyGf74ZNtZBOdO5qTMwW2wi8c01kyZbaOTgUyck1Vo8rR7GR0QXEPuDUViZ4U
 WKeMOlsCgAdx2Ookzi5ED+5ptA0f02hYOnh+cdm/uqaDGMrGEzzIpU0WobElQUFiizW0
 PR2Odc7ijHPlz/WxSHxHNUmNWClaZS5ddci78LYRRxqyVqsABHiZM49CX381gstyeJx5
 71vxfKC+EI8zjpusaNmRGx76sXhza+KIFeF6FiM9ggzEvKgahvF13ZjEgmjQda3kBXx9
 KMZixCYWuMSPDRcW0b3Ha3KMWM7opz4ijK3Z4hP1CHNV8tgrvZ2vNhox5db1rK+CDels VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4ft02hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 17:32:17 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31CHWGF7012383;
        Sun, 12 Feb 2023 17:32:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4ft02hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 17:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5frQuOYThnISYuDZnY5i5oqm2Q7X5WeU6luzd9il2equmhIcupdi0fTuZ13CR40UfXYzUR+plB4d8XLeXUgVzNl20Pd2AH4aTX3sM8hHzhlT+XD0+LNIcpdfCzijCnvWdPk7Lx1PdnagFk+Nf7IZq6IuuIOi7BeZR9R7T5vLdWOR0VU1tMBOf0SpCTKXlj+1Gy7tX3WU61xlGjX+lFZUh8QW/0n1dpQIq/sYwLjbDGKmEXtqx5ml5d9Zy53+M3kJf37mll6Y2L3PoZeyy21WjIuM8yhxVaS5nN9FR82XOWmez69b5fIa6y1RtyfzXjcV7G+9Pc4vsjKCsJukeVjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skl1XcvQW67x8eHf8hn2qsT50WstW7K1l9AEb+x7axE=;
 b=SmefO+OuxjVT82P4u+zHoHOUwtjxLVtHd5yCxyPKTcbYCMZk7QYiPhsSBIHs+nSSCfYavMStZmDwIuR+qAaPY+hU52tgsxHuPGcmNhOddaV3uf8k1aSguwt099MV3iL3r5E/8dJUhwM+WYtkKgtyIWw76ze2XFe4qfkLewtlsjYhh1fUE6dNU/TBdHzcDMEOC9jGoU9AM9OfklmItuUOPilFWBrRFf2wFv6H1KNwVNJukigg638jbcHJR0F0+GY8Z9k5sUWm+Oai7uIvgt9ZeME+op0Ldlcr45WBJkJEymdGxS2Ibixn1aDRCcBp9LyMzvP6kxquJb6iPVx/m56dlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by CH0PR15MB6024.namprd15.prod.outlook.com (2603:10b6:610:184::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:32:14 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%8]) with mapi id 15.20.6086.023; Sun, 12 Feb 2023
 17:32:14 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "surenb@google.com" <surenb@google.com>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Daniel Berrange <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 05/19] RMDA/siw: Convert to use vm_account
Thread-Topic: [PATCH 05/19] RMDA/siw: Convert to use vm_account
Thread-Index: AQHZPwfxtGmIZkc2MUSF6RefnZmQOg==
Date:   Sun, 12 Feb 2023 17:32:14 +0000
Message-ID: <SA0PR15MB391902A16F71DB916716709799DC9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <d1a04938f4ef21d48345d1d3614be10fc75d8536.1675669136.git-series.apopple@nvidia.com>
In-Reply-To: <d1a04938f4ef21d48345d1d3614be10fc75d8536.1675669136.git-series.apopple@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|CH0PR15MB6024:EE_
x-ms-office365-filtering-correlation-id: 37a73f53-418c-4de6-bbb8-08db0d1f146d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I48c9cRCpYEmeTJOgEAwxRzWVf4cmbw6J8tJ8AHOuknQoei8Rn6uN0+fqJKIcx0TOp0TDsrCMLulUZ32Gl2feRpvDJXmULUt4d/K6jBd4M3GIHcGKOmUsSN/04I+hyYZawoUnTqqYMm8Y9jxSOK1MqYVtWmDkOdFDYvHheRzH+oGSrHcuijG0TVcimuQxZi10u5GM0iMYJIHB9i95fMxLD2H7GELIqjClsc1LWdNV6nq8MiUsTtW2/ov/WWXghdngiHtFF+2ElmhA3+t2/QSJZEBqsshZj0auUzmTdSkXAZvwdvcZtkJg5VOuvJ7GoD8uBrorUCpAbtNr4YFylLTBvcxxGKxeK9aCHWYWdEfGvY60DPLX9i8MiwSi5aimwz4cr6ih5IEEGlTuxf88figO9rHpOHZMy+MzgBae1Bam9tPY1qbg1Gsl1KdcIxpyrCookTfyEX4yrtxERddhQtuVUtLtHwZxrsBhyUaeMPEPHED/MSPaHMOokMbo31wOO6VPbQQTJPlyPlO93UHbc6ulRPHDcvUH/rSFGNssLD1CC/NhpnaAYkokhLuHanjplSCtari9VSLo8XUk/8Ra60kP9GUrAFAD8p7JxN8e99qdzr2VT9jHWBJ7CF3CqUSkVhe2D3fdjTFUY7/8uHskQ8CzSYN1ZxQKH1vrlwj2aacM0a663mnRj10m8C4AmkN5HxISJb/zKUNCtHVQzevqXqQQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199018)(83380400001)(38070700005)(86362001)(55016003)(122000001)(64756008)(38100700002)(76116006)(66446008)(66946007)(66556008)(66476007)(8676002)(52536014)(5660300002)(8936002)(7416002)(4326008)(41300700001)(478600001)(9686003)(53546011)(6506007)(7696005)(71200400001)(186003)(110136005)(316002)(54906003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdJOTJUUUh1VFl0RG1kdmpweDBsSC9YQjdnN3N3Qk9Ib1p0NmhtZmJ6Wnhn?=
 =?utf-8?B?amJNVnR0ZFI5bit5TS83ajJrYk1aRC9jVFZhakQzVUI4eTRlV0NSU1BOSE9x?=
 =?utf-8?B?UmhIbXk3eVVTSU9qb3RRRHN3OEpHOEFPSUFsTDBFdnRlR0dQczl0RTVzMXlP?=
 =?utf-8?B?d0UvS3JmQW9lTDc0NWNCRTNscG9SQkU5TFoxcnByK0JEWEZZVWNrYjhVZWtF?=
 =?utf-8?B?NTg3Q2l5bWo1elk1cjVBZ1M3bTZaVlFmemdmRFN3M09vc08wc2dqV0JNRkNS?=
 =?utf-8?B?ZG1MU0FxaU14VHIzV3BXUWN6YWdGbVNjUjk0MzFOSzJEU2syS0xCdjhsUzNO?=
 =?utf-8?B?VUF3VnVlcUF0Mkk1THFJVzl2NGtaWmZIbGo1Tk1qTXl5MkZNTzlEV1Y1REsw?=
 =?utf-8?B?TngzdER0Z2wraVcrY1pxV3FkOHNzOU4xMzV4c0FtSXY1aElCTVNYUmh2enpQ?=
 =?utf-8?B?U2FYbWdENFlWODRnT2ZRYktIR3ZmMU9SRlptaUJiNFgxTTBxWGhCMnoxbDhl?=
 =?utf-8?B?cVRURVczazhtUzlFL1FNaUFPdy9YR2J5ZFk1OUFwRUNmVFlYMHY5bUFJbmFw?=
 =?utf-8?B?eGhEYSt6TEFIL3VjRVV4ZzBpR3JmV0NrVHA3TFhGLy84Z0p3UTBNLzdIT1BN?=
 =?utf-8?B?SmlvZ0ViLzZodTM4MEtFalc4QzRDY1VTMk9zWTUrcFpYaUE3eHQxaEk5THZH?=
 =?utf-8?B?akpWeWp6aTZLakZqR3MyS3ZUODUyUEdzTkFoTjVqczVQazNtb1RxL1FoSDhB?=
 =?utf-8?B?MENtUkhneHIwSDBuc0k0Q2k3eWg3b1FmL2k1Njg0VEVubHRWaC9nRFZYcUlW?=
 =?utf-8?B?dnY2YWdFUGFEaHFBV1lSeVBUdkg5djFBeGpWUzFSNnZIdk1SeUJTK3FtKzRS?=
 =?utf-8?B?VjJvM3U4RGtUY09vaWEzaXNPRkdTZHZnRjlYME11YWQzMy9xL0xUclprdnNL?=
 =?utf-8?B?U3hOblBzWDJXZk8xaWMvRHVFZVRHd2d5SnB6YmFYYTFrRjZmYmJKZ3dTVVNt?=
 =?utf-8?B?MUpESlozcWtrZDFYcE5ta0JiaHVoUjV4UER0NG9FRGxzMDJiaFpMTFBrcFQ3?=
 =?utf-8?B?Y1ZtNVI4WndrNi9RTW5BN0M1RDlveDdoL0pkOGdJTUdCOFZxOTFTL3VCVDBj?=
 =?utf-8?B?NmY4WWxGU2M2dXdxNEhiVXhEdS9aT1JZOFVtWTRQK2pLc2FLL1Y4ZEVSMTFR?=
 =?utf-8?B?WDA4QVZvTEgybWgwc3VFR1gvNXRzejR0NDFjRGt0aDlKYVZYczFzeFBISVc3?=
 =?utf-8?B?aDhGSEs1UDhmM1RZMkMvTTQzK2p5MzFnbStkSmx5alRwR0tQMlNEMkc2Z2R3?=
 =?utf-8?B?bGw1WnA0VFZ1WjlyaUZXdnlqT3J4MC9pQklBSkJjd2hHL2l0UU84QjJ2NWkx?=
 =?utf-8?B?L0JGcFJCSkJKQnlHd1BkNkV6ZFNiMy9XM0plbEQvUEF4WjJtcytjcU1lYVVt?=
 =?utf-8?B?Y2VvcG13emg1TlhkSkRLaWtZb2RjQ3IyZk5YK3pTdFJqL3JWNEl5Q3B5YmI4?=
 =?utf-8?B?Z2NNcE9Fa1N2WFQ4WlRmSjFncHpDdmVENEZzVXFzcGl1RlRaVncvTzMwbk9Q?=
 =?utf-8?B?M3pLa2pKRUQ0ZCtLUEJ3R1A0ZjE3RDFnM2tNK0xtZ3VRUkpqdmhjNWFBZGpO?=
 =?utf-8?B?bk41SUx2Sm9iRVU4N3NlQUV6L3ZhcnR2aGNoa1V5MVBFNnRoOHR0T3ZPOVU1?=
 =?utf-8?B?WUNzS1hEL2ZPREFFd1hIQVJKbWZiQWQ0SWk2Ly81T25kc0NXSmJZYUV0dlo2?=
 =?utf-8?B?b1dOTVU4bU95SVhyeDF0Tmd0S29qcVFmRGJVNWpiVDdtMEM1dVc2dDl0VTJ2?=
 =?utf-8?B?S1VUMFJWZVlRd0JRRzRuQ0VHZXJVdHpYZDVmbVJLcHdTb1BzMUFSOUplcnpW?=
 =?utf-8?B?ZkZqS2dpRnhrd2tsYVB1R1ZaeGxCaWJsa0M4Mkk2UG5XdUN0b2RvcHlBT2Rz?=
 =?utf-8?B?b3o5dVZTQmREVXVucmlFbGlPVi93c1pMalZZWE5KbCtGRWk3QnV3SU5qMmtR?=
 =?utf-8?B?b0FLOWFtLzcyeDVxcCtWQ0t5UkNTbU5qSFAzZ0NleHVpMmV1ZFhJM2xpR28x?=
 =?utf-8?B?aTFjK3ZWWlZtN1FuRW1MUGxleXhjWEh3YjVySDNUSVF6ZURWUnhPMThWWGRu?=
 =?utf-8?B?K3I1Y3hwQlI5c3ZtaDZ6ejlhWTNhelE2anBsTXNKQjdhczY5a0YxamE5Mkx3?=
 =?utf-8?Q?zj5Bm9CmQmIjXMBnVDXNfw8cegIhCDIKUZwJEE0Yi7cB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a73f53-418c-4de6-bbb8-08db0d1f146d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 17:32:14.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKYtXP5dgGkMjMnp2HqFHff6SNlG81xVtQ6QsEVf/nKSzHMCvg4d9RNtvviI8VQUm/nCjsRenW9V1e/A5+2/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6024
X-Proofpoint-GUID: VNgQMRxJRCKFwTtWcSg71YlSqwVi4l2U
X-Proofpoint-ORIG-GUID: j_yk2HLd3OlDaj_su-S3nbJfnTABNU0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_06,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302120154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgUG9wcGxl
IDxhcG9wcGxlQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgNiBGZWJydWFyeSAyMDIzIDA4
OjQ4DQo+IFRvOiBsaW51eC1tbUBrdmFjay5vcmc7IGNncm91cHNAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBqZ2dAbnZpZGlhLmNvbTsgamh1YmJh
cmRAbnZpZGlhLmNvbTsNCj4gdGptZXJjaWVyQGdvb2dsZS5jb207IGhhbm5lc0BjbXB4Y2hnLm9y
Zzsgc3VyZW5iQGdvb2dsZS5jb207DQo+IG1rb3V0bnlAc3VzZS5jb207IGRhbmllbEBmZndsbC5j
aDsgRGFuaWVsIEJlcnJhbmdlIDxiZXJyYW5nZUByZWRoYXQuY29tPjsNCj4gQWxleCBXaWxsaWFt
c29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT47IEFsaXN0YWlyIFBvcHBsZQ0KPiA8YXBv
cHBsZUBudmlkaWEuY29tPjsgQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBK
YXNvbiBHdW50aG9ycGUNCj4gPGpnZ0B6aWVwZS5jYT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBr
ZXJuZWwub3JnPjsgbGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtF
WFRFUk5BTF0gW1BBVENIIDA1LzE5XSBSTURBL3NpdzogQ29udmVydCB0byB1c2Ugdm1fYWNjb3Vu
dA0KPiANCj4gQ29udmVydCB0byB1c2luZyBhIHZtX2FjY291bnQgc3RydWN0dXJlIHRvIGFjY291
bnQgcGlubmVkIG1lbW9yeSB0bw0KPiBib3RoIHRoZSBtbSBhbmQgdGhlIHBpbnMgY2dyb3VwLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgUG9wcGxlIDxhcG9wcGxlQG52aWRpYS5jb20+
DQo+IENjOiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IEphc29u
IEd1bnRob3JwZSA8amdnQHppZXBlLmNhPg0KPiBDYzogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtl
cm5lbC5vcmc+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3LmggICAgICAgfCAgMyArKy0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
X21lbS5jICAgfCAyMSArKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+IGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXcuaA0KPiBpbmRleCAyZjNhOWNkLi42ZDRhYWJkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3LmgNCj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICNpbmNsdWRlIDxjcnlwdG8v
aGFzaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NyYzMyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
Y3JjMzJjLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvdm1fYWNjb3VudC5oPg0KPiANCj4gICNpbmNs
dWRlIDxyZG1hL3Npdy1hYmkuaD4NCj4gICNpbmNsdWRlICJpd2FycC5oIg0KPiBAQCAtMTI0LDcg
KzEyNSw3IEBAIHN0cnVjdCBzaXdfdW1lbSB7DQo+ICAJaW50IG51bV9wYWdlczsNCj4gIAlib29s
IHdyaXRhYmxlOw0KPiAgCXU2NCBmcF9hZGRyOyAvKiBGaXJzdCBwYWdlIGJhc2UgYWRkcmVzcyAq
Lw0KPiAtCXN0cnVjdCBtbV9zdHJ1Y3QgKm93bmluZ19tbTsNCj4gKwlzdHJ1Y3Qgdm1fYWNjb3Vu
dCB2bV9hY2NvdW50Ow0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3Qgc2l3X3BibGUgew0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiBpbmRleCBmNTFhYjJjLi5iZTkwMTIxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiBAQCAtNjgsNyArNjgsNiBAQCBz
dGF0aWMgdm9pZCBzaXdfZnJlZV9wbGlzdChzdHJ1Y3Qgc2l3X3BhZ2VfY2h1bmsgKmNodW5rLA0K
PiBpbnQgbnVtX3BhZ2VzLA0KPiANCj4gIHZvaWQgc2l3X3VtZW1fcmVsZWFzZShzdHJ1Y3Qgc2l3
X3VtZW0gKnVtZW0sIGJvb2wgZGlydHkpDQo+ICB7DQo+IC0Jc3RydWN0IG1tX3N0cnVjdCAqbW1f
cyA9IHVtZW0tPm93bmluZ19tbTsNCj4gIAlpbnQgaSwgbnVtX3BhZ2VzID0gdW1lbS0+bnVtX3Bh
Z2VzOw0KPiANCj4gIAlmb3IgKGkgPSAwOyBudW1fcGFnZXM7IGkrKykgew0KPiBAQCAtNzksOSAr
NzgsOSBAQCB2b2lkIHNpd191bWVtX3JlbGVhc2Uoc3RydWN0IHNpd191bWVtICp1bWVtLCBib29s
IGRpcnR5KQ0KPiAgCQlrZnJlZSh1bWVtLT5wYWdlX2NodW5rW2ldLnBsaXN0KTsNCj4gIAkJbnVt
X3BhZ2VzIC09IHRvX2ZyZWU7DQo+ICAJfQ0KPiAtCWF0b21pYzY0X3N1Yih1bWVtLT5udW1fcGFn
ZXMsICZtbV9zLT5waW5uZWRfdm0pOw0KPiArCXZtX3VuYWNjb3VudF9waW5uZWQoJnVtZW0tPnZt
X2FjY291bnQsIHVtZW0tPm51bV9wYWdlcyk7DQo+ICsJdm1fYWNjb3VudF9yZWxlYXNlKCZ1bWVt
LT52bV9hY2NvdW50KTsNCj4gDQo+IC0JbW1kcm9wKG1tX3MpOw0KPiAgCWtmcmVlKHVtZW0tPnBh
Z2VfY2h1bmspOw0KPiAgCWtmcmVlKHVtZW0pOw0KPiAgfQ0KPiBAQCAtMzY1LDkgKzM2NCw3IEBA
IHN0cnVjdCBzaXdfcGJsICpzaXdfcGJsX2FsbG9jKHUzMiBudW1fYnVmKQ0KPiAgc3RydWN0IHNp
d191bWVtICpzaXdfdW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQgbGVuLCBib29sIHdyaXRhYmxlKQ0K
PiAgew0KPiAgCXN0cnVjdCBzaXdfdW1lbSAqdW1lbTsNCj4gLQlzdHJ1Y3QgbW1fc3RydWN0ICpt
bV9zOw0KPiAgCXU2NCBmaXJzdF9wYWdlX3ZhOw0KPiAtCXVuc2lnbmVkIGxvbmcgbWxvY2tfbGlt
aXQ7DQo+ICAJdW5zaWduZWQgaW50IGZvbGxfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOw0KPiAgCWlu
dCBudW1fcGFnZXMsIG51bV9jaHVua3MsIGksIHJ2ID0gMDsNCj4gDQo+IEBAIC0zODUsMjAgKzM4
MiwxNiBAQCBzdHJ1Y3Qgc2l3X3VtZW0gKnNpd191bWVtX2dldCh1NjQgc3RhcnQsIHU2NCBsZW4s
DQo+IGJvb2wgd3JpdGFibGUpDQo+ICAJaWYgKCF1bWVtKQ0KPiAgCQlyZXR1cm4gRVJSX1BUUigt
RU5PTUVNKTsNCj4gDQo+IC0JbW1fcyA9IGN1cnJlbnQtPm1tOw0KPiAtCXVtZW0tPm93bmluZ19t
bSA9IG1tX3M7DQo+ICAJdW1lbS0+d3JpdGFibGUgPSB3cml0YWJsZTsNCj4gDQo+IC0JbW1ncmFi
KG1tX3MpOw0KPiArCXZtX2FjY291bnRfaW5pdF9jdXJyZW50KCZ1bWVtLT52bV9hY2NvdW50KTsN
Cj4gDQo+ICAJaWYgKHdyaXRhYmxlKQ0KPiAgCQlmb2xsX2ZsYWdzIHw9IEZPTExfV1JJVEU7DQo+
IA0KPiAtCW1tYXBfcmVhZF9sb2NrKG1tX3MpOw0KPiArCW1tYXBfcmVhZF9sb2NrKGN1cnJlbnQt
Pm1tKTsNCj4gDQo+IC0JbWxvY2tfbGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spID4+IFBB
R0VfU0hJRlQ7DQo+IC0NCj4gLQlpZiAoYXRvbWljNjRfYWRkX3JldHVybihudW1fcGFnZXMsICZt
bV9zLT5waW5uZWRfdm0pID4gbWxvY2tfbGltaXQpIHsNCj4gKwlpZiAodm1fYWNjb3VudF9waW5u
ZWQoJnVtZW0tPnZtX2FjY291bnQsIG51bV9wYWdlcykpIHsNCj4gIAkJcnYgPSAtRU5PTUVNOw0K
PiAgCQlnb3RvIG91dF9zZW1fdXA7DQo+ICAJfQ0KPiBAQCAtNDM0LDE0ICs0MjcsMTQgQEAgc3Ry
dWN0IHNpd191bWVtICpzaXdfdW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiBib29sIHdy
aXRhYmxlKQ0KPiAgCQl9DQo+ICAJfQ0KPiAgb3V0X3NlbV91cDoNCj4gLQltbWFwX3JlYWRfdW5s
b2NrKG1tX3MpOw0KPiArCW1tYXBfcmVhZF91bmxvY2soY3VycmVudC0+bW0pOw0KPiANCj4gIAlp
ZiAocnYgPiAwKQ0KPiAgCQlyZXR1cm4gdW1lbTsNCj4gDQo+ICAJLyogQWRqdXN0IGFjY291bnRp
bmcgZm9yIHBhZ2VzIG5vdCBwaW5uZWQgKi8NCj4gIAlpZiAobnVtX3BhZ2VzKQ0KPiAtCQlhdG9t
aWM2NF9zdWIobnVtX3BhZ2VzLCAmbW1fcy0+cGlubmVkX3ZtKTsNCj4gKwkJdm1fdW5hY2NvdW50
X3Bpbm5lZCgmdW1lbS0+dm1fYWNjb3VudCwgbnVtX3BhZ2VzKTsNCj4gDQo+ICAJc2l3X3VtZW1f
cmVsZWFzZSh1bWVtLCBmYWxzZSk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
X3ZlcmJzLmMNCj4gaW5kZXggOTA2ZmRlMS4uOGZhYjAwOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IEBAIC0xMzIxLDggKzEzMjEsNiBAQCBzdHJ1Y3QgaWJf
bXIgKnNpd19yZWdfdXNlcl9tcihzdHJ1Y3QgaWJfcGQgKnBkLCB1NjQNCj4gc3RhcnQsIHU2NCBs
ZW4sDQo+ICAJc3RydWN0IHNpd191bWVtICp1bWVtID0gTlVMTDsNCj4gIAlzdHJ1Y3Qgc2l3X3Vy
ZXFfcmVnX21yIHVyZXE7DQo+ICAJc3RydWN0IHNpd19kZXZpY2UgKnNkZXYgPSB0b19zaXdfZGV2
KHBkLT5kZXZpY2UpOw0KPiAtDQo+IC0JdW5zaWduZWQgbG9uZyBtZW1fbGltaXQgPSBybGltaXQo
UkxJTUlUX01FTUxPQ0spOw0KPiAgCWludCBydjsNCj4gDQo+ICAJc2l3X2RiZ19wZChwZCwgInN0
YXJ0OiAweCVwSywgdmE6IDB4JXBLLCBsZW46ICVsbHVcbiIsDQo+IEBAIC0xMzM4LDE5ICsxMzM2
LDYgQEAgc3RydWN0IGliX21yICpzaXdfcmVnX3VzZXJfbXIoc3RydWN0IGliX3BkICpwZCwgdTY0
DQo+IHN0YXJ0LCB1NjQgbGVuLA0KPiAgCQlydiA9IC1FSU5WQUw7DQo+ICAJCWdvdG8gZXJyX291
dDsNCj4gIAl9DQo+IC0JaWYgKG1lbV9saW1pdCAhPSBSTElNX0lORklOSVRZKSB7DQo+IC0JCXVu
c2lnbmVkIGxvbmcgbnVtX3BhZ2VzID0NCj4gLQkJCShQQUdFX0FMSUdOKGxlbiArIChzdGFydCAm
IH5QQUdFX01BU0spKSkgPj4gUEFHRV9TSElGVDsNCj4gLQkJbWVtX2xpbWl0ID4+PSBQQUdFX1NI
SUZUOw0KPiAtDQo+IC0JCWlmIChudW1fcGFnZXMgPiBtZW1fbGltaXQgLSBjdXJyZW50LT5tbS0+
bG9ja2VkX3ZtKSB7DQo+IC0JCQlzaXdfZGJnX3BkKHBkLCAicGFnZXMgcmVxICVsdSwgbWF4ICVs
dSwgbG9jayAlbHVcbiIsDQo+IC0JCQkJICAgbnVtX3BhZ2VzLCBtZW1fbGltaXQsDQo+IC0JCQkJ
ICAgY3VycmVudC0+bW0tPmxvY2tlZF92bSk7DQo+IC0JCQlydiA9IC1FTk9NRU07DQo+IC0JCQln
b3RvIGVycl9vdXQ7DQo+IC0JCX0NCj4gLQl9DQoNClllcywgbWFrZXMgc2Vuc2UuIFRoaXMgZG91
YmxlIGNoZWNraW5nIG5vdyBhbmQgdGhlbg0KaW4gc2l3X3VtZW1fZ2V0KCkgd2FzIGp1c3QgdXNl
bGVzcy4gdGhhbmtzIQ0KDQo+ICAJdW1lbSA9IHNpd191bWVtX2dldChzdGFydCwgbGVuLCBpYl9h
Y2Nlc3Nfd3JpdGFibGUocmlnaHRzKSk7DQo+ICAJaWYgKElTX0VSUih1bWVtKSkgew0KPiAgCQly
diA9IFBUUl9FUlIodW1lbSk7DQpMR1RNIQ0KUmV2aWV3ZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8
Ym10QHp1cmljaC5pYm0uY29tPg0KDQo+IC0tDQo+IGdpdC1zZXJpZXMgMC45LjENCg0K
