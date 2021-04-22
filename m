Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49815368395
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhDVPl5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 11:41:57 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:31272 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236459AbhDVPl4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 11:41:56 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MFYDpM020081;
        Thu, 22 Apr 2021 15:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=hLhyqvuSNau+9nQWxEwBZLvM2wcnTQlEU2YPuxWm1k0=;
 b=Msc9MtxYPz8lQqVqwxkCG1USRqzlnENq+EQVW1a6ZUJUxX091ePGLXRTyYO6Id4Y3Rz0
 67Rjti5n519if474k4O7Bt6G48Vc5PCH0gZqIWuCwhq+9LHpbjzdaw+zdE2SxwaC13Lz
 Gu5pbl67xFK8f9Aaz8ntqf4/HQbKnw+qhN88V01IUrOPYWUaOYHx301Yx9f55ySiEgF1
 LrgRaJr7z7lFsVG2F3NSg1PSAbRLPcG/BsT8eyW+/MMWNXlXzilVrl23r3qxAsf7VNJx
 /sBvScx00LoejJu7JHLjdJ9w9buO4mQG1BVT3pq9Tt+3eo1SHNuxjWcv7FiN7e5pHlOO ww== 
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
        by mx08-001d1705.pphosted.com with ESMTP id 382dwgajwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLPE+/ePsR3OZymGWeS0XvbWUFzpnAedueaSfViwiNU6M5K6dyOGDzrYLjSTlKWXRIuWy4GtQhVaO/3smiiAOypEjiS1ibPknjIgs1VmmB2i2A4JPtkRdGGR2GvgDCUUoU6ZkJgfNnKp6EcN/N6K9cLNBGh4TYICpJj+c6uBH3SKPUHgJsuCTHKNI41qnWXQbBbYmIqbyfZ40gnOx6IU24Ba9XYLfbBX5znK/ag3W/QIwUjY/sQjw9aFrM+6BKEPzks9YocGKsq9Ih7RclCNeOcfThbd8KjyZmGwGM6XgxcApDF60ivWfKkgva3KuO5G3OfGo2wl4Ysdih5gR/hplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLhyqvuSNau+9nQWxEwBZLvM2wcnTQlEU2YPuxWm1k0=;
 b=GNzfIKSuTLQxBLCSOyoyELzJjwCPcK4VMVsFx1a4uCu7j/XODOlyn1c4EZciAYyYPvRKKINsbMLtDFnLT8MHscXT6q4A2ELgX3ODbiHcNUJXUPh0r+7GR+gExRK5TwBa3l8QArQnV5CQj6M0jnts45NL4PZmLtNRZ6CAvIAhatiAnynLR4TzSgSQnf0Jj3xdjgX8dOa3akP4Ymgd8Hnu5FbyEPVeyEaTBfwwt7+ZbZ8E/tpXOHlwUvI3F3vsVSlgMxbkmFr0UT2enzr6/oJwGUUv3gpSQa97JXUFSU5Vlpv2CvQmlqArjvwWpWne95s0mpF90dTFfE7PPLS69luiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB0932.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 15:41:05 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:41:05 +0000
From:   <Peter.Enderborg@sony.com>
To:     <shakeelb@google.com>
CC:     <hannes@cmpxchg.org>, <guro@fb.com>, <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <rientjes@google.com>,
        <linux-kernel@vger.kernel.org>, <surenb@google.com>,
        <gthelen@google.com>, <dragoss@google.com>,
        <padmapriyad@google.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
Thread-Topic: [RFC] memory reserve for userspace oom-killer
Thread-Index: AQHXNtw2hk/SodxcJ0CeC+3Me7WEMKq/T3oAgAAI/QCAAK0lAIAAk80AgAAUrQA=
Date:   Thu, 22 Apr 2021 15:41:05 +0000
Message-ID: <6217dcce-d178-3ab4-5174-1a98cdb14d98@sony.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
 <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
 <1f8d300b-9a8b-de09-6d5d-6a9c20c66d24@sony.com>
 <CALvZod5+5ycobmSt=NC3VJF4FRMFmBQEN7SQgipyTDbzHEbPUQ@mail.gmail.com>
 <6eaa4c24-c565-bc5d-dbca-b73c72569a16@sony.com>
 <CALvZod5dr8Uy84wJ5-a=zyR52_k5AU64GtFAsJpBRE89DEt-yg@mail.gmail.com>
In-Reply-To: <CALvZod5dr8Uy84wJ5-a=zyR52_k5AU64GtFAsJpBRE89DEt-yg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3716c5d6-19d3-4781-8004-08d905a50a72
x-ms-traffictypediagnostic: AM8P193MB0932:
x-microsoft-antispam-prvs: <AM8P193MB0932FF4CBD95AB9CFE6469B986469@AM8P193MB0932.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szKDAdB5syjOhiX+Wmi738rzSbnzruu/IQJ7gv18HxK2u0I3KCec4vA5PvLYCn7xetxapHKSzIwjbWidhNrAy1h1x14g9VtvUwYyXZ9S954+AvP2dd2FEQoeCF7fiWvlHqYEvuZrwCzlzKXmbj/laDoNr/mRnF+wh3hEeG0U7FGymwpRRCaP41AC4s2iyfgs9GFmAZnLnvFSmBAF5y2frOrh0maqxI7G5pnpENFBHek7r+EYSlPFj450vIpNQgm9a8lAnFQvicmfAPIpFp2YC+yyFpWVvBXLmp7rW2bCoYGpKUYmb3IaOaIsedOe1hy+vfWKFYKlNP5cDPb/LgmoG5umGU0x18g4zGT3agrM4nsn8Qy1codp9zexTlfGlbzD3ybhmTjQNDEkJDukk5hiOhym25rw+4kCY9lGr4rUCbGzt+7ssMyad9/pisM/CWDaptf1EYyapaJje6cphn7uz2f+yU2LfBRYI8NQ7mFME0O5ULIb4XmihFFW3TAFGBElSGfkCsqaMI5btxqpaMzgXQgrKCbvHdsascyUZ9vM7Av5CwEbjhxsycCFir+MFh1BokzJmeaCQPWp+k/m8pho64ccPTa8X1gu15e9sC3Xhi3zMzL1RQspUesWnm2yFhcV6ae6HImI/JlSMrW3FCVyw/BuJLfkntekmpqy4rhYoet5sj7MLxXaqjEgzUM4HroN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(76116006)(91956017)(122000001)(54906003)(66556008)(26005)(478600001)(66446008)(4326008)(7416002)(6916009)(64756008)(36756003)(66946007)(53546011)(8936002)(6486002)(8676002)(6506007)(186003)(38100700002)(6512007)(86362001)(31696002)(31686004)(71200400001)(316002)(2906002)(5660300002)(66476007)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NVNBdkFQTEM4VjRqTU56dEhVRnFiOG1qZ0p5Z1MySlBEa2Q4M083aFU2KzBN?=
 =?utf-8?B?K24yU215eVFLbnBZcW5mWHI5UFBWdVhIWTBSVVIvdDFIa25NODZ3aXZhem1v?=
 =?utf-8?B?WWhkSFFtMDljOXd0T1ZPOXlLbmpJS3FLZWp0TUY0VlVZSDQ1SFJSSGRNejlB?=
 =?utf-8?B?cHFON3JIenR0dVhoZnpvT0xhWUVEOTdla2FRZ3BONWVzUTZQd1NiRFZMVHho?=
 =?utf-8?B?ZklVRTgwbHQ3Tm5WMXJIWlNKR2cza25GdXNKdmJWNVRaOTRUb0xuSitBb1V6?=
 =?utf-8?B?SnJDRlEzRGF6UzlhblhOVkF4SDF2SUtQSGFvbjZtWkkxQkVKQVQvMnZ3eUl1?=
 =?utf-8?B?UWl3c0xsSGs3emlMa21mU1hVc2VNN1ZuSCtvK3QwTWVUVUk1K1B0L25OZ09p?=
 =?utf-8?B?M09ITjA1RmFvQ3Z2VEdxV2lKYmJGQ28xV0hMMkUwZGNTTDdsSUVrOXhLZ2N3?=
 =?utf-8?B?bVFMeWlHaU9rVXpnR1ZCT3hxLzJCSHJpMjFhc3AzWVByeTVuQjlYZVlOdDhT?=
 =?utf-8?B?T3JUK1NzZFRDaHZkUzJPaklGMVM4amUwVU1RcGZCbmZtQ0dXRmVob2Z1QTRW?=
 =?utf-8?B?U25JVit1d3pRWjFhMG1CVmdVL1JVbE1ncm9ObzlUVkR6S1dwbXNtTU5BV0Jh?=
 =?utf-8?B?OWFXQXVQaURPTVF1alV2RzNteG0zYnM0NEhyMDR3VmJlSTI1NTU1SFpLblIw?=
 =?utf-8?B?eDhRU05jTktLZCszcVdiYjJYS3pJcURFdFBYWEtsVDR0V1d2OXJrSUV4VW5y?=
 =?utf-8?B?UFdlNWd0UmtpTVNLL3IrV1FtWC95Rk1CNm8zcXBoYzB4TEJVV1pTalg3TGRZ?=
 =?utf-8?B?Y1ltdXh4T3dGQXpadFVpYVduVjNwSHQxWHV2dHpRUWM3S2lHWjJVZGt1d2lw?=
 =?utf-8?B?UG13MEJTNXNXYTZnSVg5V2NjU0wyQ3FmL0NnV0xPa1hzcjR4bGo5c3ZVMlFt?=
 =?utf-8?B?aDhHSTVNUnd6QzhCeDh2V2NPM2ljZW5la1ZCdXc5NnNFbkdSdHBLWnNsZ3FD?=
 =?utf-8?B?RHV1Tk1uWjh0a0c1QVBTcytIQWpEdVljaTZMNzQxY085bTdVdUV3Qlhmd0Y3?=
 =?utf-8?B?Z0Q2ZzNQMnRUTDlvSFpkeDlFQXRDaTJHbXlqT1FEalExcHRtMWs4ZmUvNVY1?=
 =?utf-8?B?T1VjSmVNNWpPNGRIcTg1cFJrZ0pZVDRndVk2VVVja3FnVkhDTjMxcERncHUy?=
 =?utf-8?B?R1l0UW9JY2s4UWFVSTg1MThRTXg5RER2K0JaSU5kZU9sdzlHcmJIaEkzSldx?=
 =?utf-8?B?WC80OWw1cXA5ZXVPRXBCb0YyY0VUL3p4K0xyNk82V0ZlQ2ZuTlN3amNqUlVn?=
 =?utf-8?B?b1l4TmN3OG9TZlVCU3RTMUViMVZFTXQxQ2FhZFAyVjNFNFhxUTE1Mng5aVZR?=
 =?utf-8?B?ckQ0L0NpRzlyOGFyQmxOTWF3Z01ONU1xMFZiVkNWYmhpbjhpTDVGbW1TcExX?=
 =?utf-8?B?RmxzdFBIQm90OHhrbzZUSmNLT2dNYVNaRUNEbU05U0ZydzNaTVV4RWd1SUVT?=
 =?utf-8?B?UFpOQzIraTR5dDkrOEZWS0xDb2Q1c1hXVHFpM1FHOGpSdWwwNGhENEUyMnVC?=
 =?utf-8?B?VlVDc3N2MStYakk5MGptbTFwSXFkZ1ZGaFRxWGJBakh6M3g4Zk55WEVZWVJP?=
 =?utf-8?B?R2M0TlRKSklHUkYrdGFLSnk3WWIyUnhtNm5aeE0vbnRnWk1QRmJ2STU0eFRJ?=
 =?utf-8?B?N2ZTcWdXZjY0dmczSEhRN2h4cmZDZ0FxL2NSWmFCVDMzQTBtN2VUc21Gbytl?=
 =?utf-8?Q?REJ1mJ1+6aWM6imtaDeZgpgtRla5Q3HqcRnPP1u?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE679FEF622BEC4F904FF0E7A459843E@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3716c5d6-19d3-4781-8004-08d905a50a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 15:41:05.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arzJ0UGYFNIKHzfAKxvi8UN/9vDWWoH81MzAycKYPb1iEqmgdmFIV3sZy7XT864O1gmHDWGlu9w3wM34Uw5S40ybhKkUM6Kfov9lRzcwdkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0932
X-Proofpoint-GUID: 2eGFq3AkSwuJe6U-luXcu5sexTiqS4mL
X-Proofpoint-ORIG-GUID: 2eGFq3AkSwuJe6U-luXcu5sexTiqS4mL
X-Sony-Outbound-GUID: 2eGFq3AkSwuJe6U-luXcu5sexTiqS4mL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_06:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220121
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gNC8yMi8yMSA0OjI3IFBNLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+IE9uIFdlZCwgQXByIDIx
LCAyMDIxIGF0IDEwOjM5IFBNIDxQZXRlci5FbmRlcmJvcmdAc29ueS5jb20+IHdyb3RlOg0KPj4g
T24gNC8yMS8yMSA5OjE4IFBNLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+Pj4gT24gV2VkLCBBcHIg
MjEsIDIwMjEgYXQgMTE6NDYgQU0gPFBldGVyLkVuZGVyYm9yZ0Bzb255LmNvbT4gd3JvdGU6DQo+
Pj4+IE9uIDQvMjEvMjEgODoyOCBQTSwgU2hha2VlbCBCdXR0IHdyb3RlOg0KPj4+Pj4gT24gV2Vk
LCBBcHIgMjEsIDIwMjEgYXQgMTA6MDYgQU0gcGV0ZXIgZW5kZXJib3JnDQo+Pj4+PiA8cGV0ZXIu
ZW5kZXJib3JnQHNvbnkuY29tPiB3cm90ZToNCj4+Pj4+PiBPbiA0LzIwLzIxIDM6NDQgQU0sIFNo
YWtlZWwgQnV0dCB3cm90ZToNCj4+Pj4+IFsuLi5dDQo+Pj4+Pj4gSSB0aGluayB0aGlzIGlzIHRo
ZSB3cm9uZyB3YXkgdG8gZ28uDQo+Pj4+PiBXaGljaCBvbmU/IEFyZSB5b3UgdGFsa2luZyBhYm91
dCB0aGUga2VybmVsIG9uZT8gV2UgYWxyZWFkeSB0YWxrZWQgb3V0DQo+Pj4+PiBvZiB0aGF0LiBU
byBkZWNpZGUgdG8gT09NLCB3ZSBuZWVkIHRvIGxvb2sgYXQgYSB2ZXJ5IGRpdmVyc2Ugc2V0IG9m
DQo+Pj4+PiBtZXRyaWNzIGFuZCBpdCBzZWVtcyBsaWtlIHRoYXQgd291bGQgYmUgdmVyeSBoYXJk
IHRvIGRvIGZsZXhpYmx5DQo+Pj4+PiBpbnNpZGUgdGhlIGtlcm5lbC4NCj4+Pj4gWW91IGRvbnQg
bmVlZCB0byBkZWNpZGUgdG8gb29tLCBidXQgd2hlbiBvb20gb2NjdXJzIHlvdQ0KPj4+PiBjYW4g
dGFrZSBhIHByb3BlciBhY3Rpb24uDQo+Pj4gTm8sIHdlIHdhbnQgdGhlIGZsZXhpYmlsaXR5IHRv
IGRlY2lkZSB3aGVuIHRvIG9vbS1raWxsLiBLZXJuZWwgaXMgdmVyeQ0KPj4+IGNvbnNlcnZhdGl2
ZSBpbiB0cmlnZ2VyaW5nIHRoZSBvb20ta2lsbC4NCj4+IEl0IHdvbnQgZG8gaXQgZm9yIHlvdS4g
V2UgdXNlIHRoaXMgY29kZSB0byBzb2x2ZSB0aGF0Og0KPiBTb3JyeSB3aGF0IGRvIHlvdSBtZWFu
IGJ5ICJJdCB3b250IGRvIGl0IGZvciB5b3UiPw0KVGhlIG9vbS1raWxsZXIsIGl0IGRvZXMgbm90
IGRvIHdoYXQgeW91IHdhbnQgYW5kIG5lZWQuDQoNCllvdSBuZWVkIHRvIGFkZCBzb21ldGhpbmcg
dGhhdCBraWxscyB0aGUgInJpZ2h0IiB0YXNrLg0KVGhlIGV4YW1wbGUgZG9lcyB0aGF0LCBpdCBw
aWNrIHRoZSB0YXNrIHdpdGggaGlnaGVzdA0Kb29tX3Njb3JlX2FkaiBhbmQga2lsbHMgaXQuIEl0
IGlzIHByb2JhYmx5IGVhc2VyDQp0byBzZWUgaW4gdGhlICJwcm9vZiBvZiBjb25jZXB0IiBwYXRj
aC4NCg0KPg0KPiBbLi4uXQ0KPj4gaW50IF9faW5pdCBsb3dtZW1vcnlraWxsZXJfcmVnaXN0ZXJf
b29tX25vdGlmaWVyKHZvaWQpDQo+PiB7DQo+PiAgICAgcmVnaXN0ZXJfb29tX25vdGlmaWVyKCZs
b3dtZW1vcnlraWxsZXJfb29tX25iKTsNCj4gVGhpcyBjb2RlIGlzIHVzaW5nIG9vbV9ub3RpZnlf
bGlzdC4gVGhhdCBpcyBvbmx5IGNhbGxlZCB3aGVuIHRoZQ0KPiBrZXJuZWwgaGFzIGFscmVhZHkg
ZGVjaWRlZCB0byBnbyBmb3IgdGhlIG9vbS1raWxsLiBNeSBwb2ludCB3YXMgdGhlDQo+IGtlcm5l
bCBpcyB2ZXJ5IGNvbnNlcnZhdGl2ZSBpbiBkZWNpZGluZyB0byB0cmlnZ2VyIHRoZSBvb20ta2ls
bCBhbmQNCj4gdGhlIGFwcGxpY2F0aW9ucyBjYW4gc3VmZmVyIGZvciBsb25nLiBXZSBhbHJlYWR5
IGhhdmUgc29sdXRpb25zIGZvcg0KPiB0aGlzIGlzc3VlIGluIHRoZSBmb3JtIG9mIHVzZXJzcGFj
ZSBvb20ta2lsbGVycyAoQW5kcm9pZCdzIGxta2QgYW5kDQo+IEZhY2Vib29rJ3Mgb29tZCkgd2hp
Y2ggbW9uaXRvcnMgYSBkaXZlcnNlIHNldCBvZiBtZXRyaWNzIHRvIGVhcmx5DQo+IGRldGVjdCB0
aGUgYXBwbGljYXRpb24gc3VmZmVyaW5nIGFuZCB0cmlnZ2VyIFNJR0tJTExzIHRvIHJlbGVhc2Ug
dGhlDQo+IG1lbW9yeSBwcmVzc3VyZSBvbiB0aGUgc3lzdGVtLg0KPg0KPiBCVFcgd2l0aCB0aGUg
dXNlcnNwYWNlIG9vbS1raWxsZXJzLCB3ZSB3b3VsZCBsaWtlIHRvIGF2b2lkIHRoZSBrZXJuZWwN
Cj4gb29tLWtpbGxlciBhbmQgbWVtb3J5LnN3YXAuaGlnaCBoYXMgYmVlbiBpbnRyb2R1Y2VkIGlu
IHRoZSBrZXJuZWwgZm9yDQo+IHRoYXQgcHVycG9zZS4NCg0KVGhpcyBpdCBpcyBhIGxpZmVsaW5l
LiBJdCB3aWxsIGtlZXAgdGhlIGxta2QvYWN0aXZpdHkgbWFuZ2VyIGdvaW5nLiBJdCBpcyBub3QN
CmEgcmVwbGFjZW1lbnQgaXQgaXMgaGVscGVyLiBJdCBnaXZlcyB0aGUgZnJlZWRvbSB0byB0dW5l
IG90aGVyDQpwYXJ0cyB3aXRoIG91dCB3b3JyeWluZyB0byBtdWNoIGFib3V0IG9vbS4gKEFzc3Vt
aW5nIHRoYXQNCnVzZXJzcGFjZSBzdGlsbCBjYW4gaGFuZGxlIGtpbGxzIGxpa2UgdGhlIGtlcm5l
bCBsbWsgZGlkKQ0K
