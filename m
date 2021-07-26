Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC093D5CBF
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhGZOgG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 10:36:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7508 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234928AbhGZOfy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 10:35:54 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16QFG4xR025362;
        Mon, 26 Jul 2021 08:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pLzogDWx/JHJfcJWQc3D3qgj3LortFeGDH+JW0b+vyQ=;
 b=SaoEpPyp1YbLnHbSvKUw4QIR8tWVcg6gN+RNzgzwdEIEiLohgoLbE1OrR/avRVyvGbkA
 e/nrJYww/yi4rNbHE2dl0vP87HLb3JKnatU8GE4Bz8GfHBDvS88ojfVbMZ9s46ymSf32
 6WCfLPWYgNmh0H889kGJP7atIAAl5dzm4FM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3a0eceager-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 08:16:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 08:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhyMM1+PKyGAIv47dGt99fQEKROFu1FOA4vIX+sB8pmtqUsAFmWxHqSnJnsqwPt9kRPlLQmt2RAgyd6Z8LyJyYMD4RpT+c45tCjk0Hw8u6P9X1yDBuuvB1dsPflG4fxNiLVDFr5iNo1mObi7DMY+/80GSRHn3BOA+pajYggRxeO/Rxlo5fWkgQ4pNqzrKGCWf6aUt1t6XU+WXnGDHO64b35XGzwkwNq8w8bFmmy+qx0jl3qudEe+ySq3Y8uW8Uu2LhXbpL6aBAtQWZtQ218kMIdhqcmutguQV3wjukQPVGZu9zj0LGJjZQiL/axJTVXpoeiRkb/i+BrROgoLhVjRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLzogDWx/JHJfcJWQc3D3qgj3LortFeGDH+JW0b+vyQ=;
 b=mM7UskLY9t4l9d7IcF2McV00arlYQoiFpWQsW8DeiUx8vdbnYVjp5RAj5gXEzgrugMKn0u9WZ6Qagm31iovtHvOpK4nHi5Y4x1ppxuXl6zEkr7EEY0a1DluYp6yRxsfYRAvloV3LC1BqokNkxMWiLf9DXIoC6uCDE4GxJu0a8e1934MmDFg2As128gWBv5Y/0MapIZ4hG6y2lG4xlSILcXxDpPEcOO24mUjrpBH+nzmR6pURCgLigtyBG5oOLdrizj5tAeHqx1iR3wzL0GPWEqEFZ0etMwpyLxuaTDDRJdDSBIgvusYqUa6JLpg/olDTn32fJc7j0XKqe4MFcf918A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB3182.namprd15.prod.outlook.com (2603:10b6:208:a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 15:16:06 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::311e:701a:589c:249c]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::311e:701a:589c:249c%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 15:16:06 +0000
From:   Rik van Riel <riel@fb.com>
To:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
Thread-Topic: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
Thread-Index: AQHXgi7+kFjHsY/NM0SDAPAR8veOlKtVXfCA
Date:   Mon, 26 Jul 2021 15:16:06 +0000
Message-ID: <2b0b08f9385b25fb7750dbe453516b0c8bb27604.camel@fb.com>
References: <20210726150019.251820-1-hannes@cmpxchg.org>
In-Reply-To: <20210726150019.251820-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 395e9191-da97-4429-fcf4-08d950484a2c
x-ms-traffictypediagnostic: MN2PR15MB3182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB3182D826528E9C1C91E64257A3E89@MN2PR15MB3182.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtTxeyLGcDxtLYjgqrHP46/zsyAqepcioStRjaoRXlb4gjikfj09sp1ttqiY4OtSOLEPPc0vIrvIjJqhvNygIzrWbNtlfgV0/FoFMzIv3onlVcMlHpzb5TgoIZoLTdZxDmAPvkMSShXwW0+vzFcZs9USYnu4EDuO21HdtbPGHci1VYZXhEKkeiOlUDaDKGbQNP9ly1smfMh2s9LN5oabBX3WvUzLPHH/cQ07kzwY5L4JQPBd1Wa42vMLa3F131D9bSsXelrHL7ZiDxAUWlyzz7ukm5TPb6rTBNGT2Nys55YWkT5Z91TnkS6DE/Uyru+bMCXh03N7i3IDE6eESs4NSi3b3rSIae8RzptJQNuJiK993iVvCbgO+dpwvx/HdAOPO+n4gV6Ol9SkHW1hy9SlrYgJoFjBhgn2jNeZvNuM0IDc5HTT5R1R6TCvqFgop7oQiggM0uFecAE5Lw6vbe5bXV4jG1bDv/CJpQgLWX2ucfFQPfY/A4JngAN56Qr1DQER1TCnV10p8GQ5nXcc+VwV4k0Vzq86OL6JKkmyO2C5o4KIMMdh9JsBnxIgq2TvWHh+C/Pm6hZ86WLklM9y/0coBfRQATVVmKYAsXoMoaqH7+e1wJHGN4SI24IeHvjqWoD9skdHTqrtIEv/LwgeLCK68QltKmlCXDvPnJixoiD022y4BpRdhe2lF8UBCTrRFmXDc1aPMD//Wq8B22kdWzJaKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(64756008)(2906002)(76116006)(316002)(36756003)(54906003)(110136005)(6486002)(66946007)(86362001)(66556008)(8936002)(66446008)(508600001)(66476007)(122000001)(4326008)(6506007)(71200400001)(6512007)(2616005)(4744005)(186003)(38100700002)(5660300002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnEwVU1Ta21XWFRMRW0vbHFlTC9venVGOGVLRkM4QUh2VnQ3aVBBbUY0LzQ3?=
 =?utf-8?B?MEZ6S2xxWUI1amc3UTNYdUI0dWFZZ256bXM3eHg1WHVXdGFXaFFFMFpqWW9Z?=
 =?utf-8?B?emtPTkVYL0wwb2NZZFh3RG1mUzgvNXVjWGFRNmRmbnJlSkF4UmdFY2Y0cHg3?=
 =?utf-8?B?RVlyQlgvM08wbnJnUE9RUlZCK3krMnJYT1FaditOM0swY3ZsQ3ZwRitiS1VE?=
 =?utf-8?B?QXdzQWZBNFk2cEpLaEdqdFBLZVhuY0plYUQ5WUxFOHVPKzk5dUVpT3ZWS014?=
 =?utf-8?B?MnZSSktnVjR5dzViSGVCV2lMcU9TdjgwNk82RllHRU5YZUNVb3dMNmt1bCtS?=
 =?utf-8?B?T1JVbHdnR2tsMTZ5R2xOb0RkQXFDUG5SV1RUTTZJOGFjbHBVc1U1Tzh5Uk1E?=
 =?utf-8?B?dmh6TGcrYVhJeGZFWjVGVXcwdFNNZWRlVGVtbFFGNVpGQVdncFNxTGxsUDN6?=
 =?utf-8?B?NTFldmFoYmtJeTIzaEw1ajZvTGQrRUl2UTlyUHluQ0ZUeDRTZmZsWGRjK0RB?=
 =?utf-8?B?RTkrMGFoSDVLRHlDTlk2eWNZbjlld2VGY3J4QUFkNXRrRFlwQWh6aUxOVjgw?=
 =?utf-8?B?dnhNRUxrUHZ4OEVobW5vWTRBbE9JRklXM05EUVJYbU5xZzhyZk5OQkcrQ1lx?=
 =?utf-8?B?OGNHV2JqamxudTN4SFRpbFprei9WZVVhRG9wcnFoNjZqWjdGTllpU2RXR3pz?=
 =?utf-8?B?cFFJM2N3VXNseWNvUjhuYVV3THp5cEZacTFOYjhmMkxiNERWclJIczdHWVJs?=
 =?utf-8?B?UzlLWEVmYlJvMHBKTDN2NW4wRnNPQ3grdmVxNm9qeGl2SnB3S01nSytYbG5O?=
 =?utf-8?B?cFNyTXg1WGlERjMra1U0U0FkSWNuUnpjMGZacXJ4SXZqcUVxSVBmV0VvVUN6?=
 =?utf-8?B?dE9ON1NTRittb0d4NEI2Nmd6NVNzcm1qSTA4bVRENy9MZUE3RzlHZ0JBVzVs?=
 =?utf-8?B?RDMzck9nZmp0ZzNsTHRrWmhrQ0hKcWpMeWNEemRvL2JyeG4xdExoNU9UTTBt?=
 =?utf-8?B?aloyTlFxZFM4ejU4Tm9PcjhEa2xFMjN0NWtLZUc2ZGtqVVRIMUNsclhHazEx?=
 =?utf-8?B?UjgyWXBKTnIySzFwNkZBREUxemFTZXgrbDZrWndlU3ZldzhzZ1NFOXJiS21u?=
 =?utf-8?B?aitLK0V4UzhDRlEzeVpqNWZiYWVnTTFyMEFkZjBIbVJhbVk3OGg0YjNqaFBR?=
 =?utf-8?B?dGdOZ0JBY0w0TmM1Qno5dnl6SVFIZGxOdkhEdko3OUtaUDQvanJOMW5FaFV2?=
 =?utf-8?B?dEk2UHNtczlaVFdvUnduYmlNMllpYlpLVUVlODV6akRERVpzOWxKNVBMVVpF?=
 =?utf-8?B?RVRNVWkzT3lkVzhiOHozUzNvclJicEdiK2d0L2VvWXlkUGJjMFk1S1RDMklY?=
 =?utf-8?B?OXdRVkpUb0lGSjdsWXQvaU4wckF2N3luWGwzeVBOVmQ0NzJ2M054NTg2Y2JM?=
 =?utf-8?B?N0wwQ0hsNWZISnZ5bFVWNmpBeGIwZEU0ZmsyOHFyWGVqMTFydDlEZi9ZeUta?=
 =?utf-8?B?d3gyOVl3MzA2Y210RnAxczJ0Uy9YaERXMWtDMkJTQTdLank3d0YrUk5YOU9n?=
 =?utf-8?B?Q0NPV29pQlY1U1Y0bTlqUEo1NGgrU29PSko2M2JlVERCOERXWExhcWJJaTls?=
 =?utf-8?B?cDE3MkFNWElsT21GSHJOOVpjUlJHVjd0TStkQzVLQS9aQlcydE1TTDRRSTZy?=
 =?utf-8?B?YmRjMkM5N0xSY1cxbDhYam9PWWx4SWlNTTBYWitabFlHYmlORzNzVGlYd0Er?=
 =?utf-8?B?TG1PR3F0SXFFdmpiK0dIdFBiT1FOT1ZlcGsrd053NVRDRlNBdlAyM2JGdTA0?=
 =?utf-8?Q?V2UFrnfCOW+C9pmg/MLvEHwmOaVvta0TD3S+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FE66FAAC22F194485956A13D426A99F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395e9191-da97-4429-fcf4-08d950484a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 15:16:06.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZkw5XhkQ7WHSICWVgLBcF7tWqQbOGjvneGjO5Egy3LijVtV/v6JWtLZcI5IdV29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3182
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: p2pfhre0Ai4EbbQo9toQABrh-1RsR5OR
X-Proofpoint-ORIG-GUID: p2pfhre0Ai4EbbQo9toQABrh-1RsR5OR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 mlxlogscore=974 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107260088
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTI2IGF0IDExOjAwIC0wNDAwLCBKb2hhbm5lcyBXZWluZXIgd3JvdGU6
DQo+IA0KPiBfX21lbV9jZ3JvdXBfdGhyZXNob2xkKCkgaW5kZWVkIGhvbGRzIHRoZSByY3UgbG9j
ay4gSW4gYWRkaXRpb24sIHRoZQ0KPiB0aHJlc2hvbGRpbmcgY29kZSBpcyBpbnZva2VkIGR1cmlu
ZyBzdGF0IGNoYW5nZXMsIGFuZCB0aG9zZSBjb250ZXh0cw0KPiBoYXZlIGlycXMgZGlzYWJsZWQg
YXMgd2VsbC4gSWYgdGhlIGxvY2sgYnJlYWtpbmcgb2NjdXJzIGluc2lkZSB0aGUNCj4gZmx1c2gg
ZnVuY3Rpb24sIGl0IHdpbGwgcmVzdWx0IGluIGEgc2xlZXAgZnJvbSBhbiBhdG9taWMgY29udGV4
dC4NCj4gDQo+IFVzZSB0aGUgaXJzYWZlIGZsdXNoaW5nIHZhcmlhbnQgaW4gbWVtX2Nncm91cF91
c2FnZSgpIHRvIGZpeCB0aGlzDQoNCldoaWxlIHRoaXMgZml4IGlzIG5lY2Vzc2FyeSwgaW4gdGhl
IGxvbmcgdGVybSBJIHRoaW5rIHdlIG1heQ0Kd2FudCBzb21lIHNvcnQgb2YgcmVkZXNpZ24gaGVy
ZSwgdG8gbWFrZSBzdXJlIHRoZSBpcnEgc2FmZQ0KdmVyc2lvbiBkb2VzIG5vdCBzcGluIGxvbmcg
dGltZXMgdHJ5aW5nIHRvIGdldCB0aGUgc3RhdGlzdGljcw0Kb2ZmIHNvbWUgb3RoZXIgQ1BVLg0K
DQpJIGhhdmUgc2VlbiBhIG51bWJlciBvZiBzb2Z0IChJSVJDKSBsb2NrdXBzIGRlZXAgaW5zaWRl
IHRoZQ0KYm93ZWxzIG9mIGNncm91cF9yc3RhdF9mbHVzaF9pcnFzYWZlLCB3aXRoIHRoZSBmdW5j
dGlvbiB0YWtpbmcNCm11bHRpcGxlIHNlY29uZHMgdG8gY29tcGxldGUuDQoNClJldmlld2VkLWJ5
OiBSaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+DQo=
