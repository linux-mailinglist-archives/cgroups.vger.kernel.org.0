Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3543EF228
	for <lists+cgroups@lfdr.de>; Tue, 17 Aug 2021 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhHQSpE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Aug 2021 14:45:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7898 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232351AbhHQSpD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Aug 2021 14:45:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HIhJXK027120;
        Tue, 17 Aug 2021 11:44:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5cDldqj3vFq1S2OIX4yKJ4U+Z9fA7hc6GDBfB+wmUyU=;
 b=GHmEsk0uo9X+kPGXC+EMJz8P0SNccS47ioNuxQP+wqeObo1ZzJ9ZH0BNtwGViViwdUpu
 KPzJGZLZmltoe0e9kNhILp7Ec33xCLLyh0crHR4iExNb0G0xXkNqVhszjHl/t/5E82gS
 eAYgy2184Jk1DTwa/vz+YRfTmsVpvUPmIqY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3afrcbskyp-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 11:44:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 11:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWrKIMaCvxcr/I0x7Ldu7zfyZ3QwjsKyp6l8mG/5C+jaOTqnmNFtLB0kB5Tm9BQ75c7+EpoxYTyovxFxV+zdx74dPAmVCp4IHioKlebOyykib/rtuM9E0elIS5NDPjHrAlk5U5XVUhGUasv467mxyM5XUhCU22mMtSBD92C9GZxZQCJNgrwQNURomDvsJy2hDPFTWzVeNk5KV38OMMUAmUeenvX3VNFvMG/RwTcCqB6RR0NNazRRDxsbOvcKviLOkaLQOorQUsvRt2Vsti9wpTTDdL9LeIcjDl+dbapRFxtN+6nMq7TTZYgTgX/4TMBCBwFRhDCy1KoT7HVNA1chMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cDldqj3vFq1S2OIX4yKJ4U+Z9fA7hc6GDBfB+wmUyU=;
 b=K07PBi6vC2gshFZa8dk6VpumAqry+2vG/Pci7aA8Emvf7yR8hDM6YqprpsDjLueWcb6I7dbeSzpvmXkMp6WJV2MQoMfxJSPoH7hzPObcSnxixHPpdLkdqaVALk5wGoIH9HNFmjeYjiRYwkxHPJN6wK5RWBuXgK/zKd2rRsHXTn2qT1kLZmvAybC+5F+knxdau9YysTVbu75p1NymivKpmXdfOJGCNx7Gwpkzixjr/AMrT+81t5ZdbJFa6FmkvL4AOSI3J9UG6pY/VasX2ASJInufHcEaZZW2+vF8McvJfoOG7wyTRCl7NvLCLb9IgQEEaiyCoXwnDV1rRlQ0SXI57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB2701.namprd15.prod.outlook.com (2603:10b6:208:12b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 18:44:11 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::311e:701a:589c:249c]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::311e:701a:589c:249c%4]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:44:11 +0000
From:   Rik van Riel <riel@fb.com>
To:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "chris@chrisdown.name" <chris@chrisdown.name>,
        Leon Yang <lnyng@fb.com>, "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Thread-Topic: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Thread-Index: AQHXk5I1Y3ES6AfjfUyiGI6UU22Rwqt4CJcA
Date:   Tue, 17 Aug 2021 18:44:11 +0000
Message-ID: <0f4b106ad6f7dc8ac6a56b98861a9b65bdd66bc5.camel@fb.com>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c57b702-767f-4b79-c223-08d961af0124
x-ms-traffictypediagnostic: MN2PR15MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB2701D7EAFEC993325216475EA3FE9@MN2PR15MB2701.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itdap4eqOk/F/w2NYaD1ZcHg9UCdUjO42nRSINDEPqdPU3diIuFKY6PuSdbVbbtOYLNcs14lts0CM0Iw8+/m/tz9pfKVxO/iKOgakH+7jpVqSxFnGJRkyiFWet+E9mmOAq1p5C4LB2aDi02OvHyOoYtPIWmNRYd0kA2EY2CJF0J6W0DCWqFxUHCNAxWOnXmnsQdisNPffQ9RQDCgFYkvbniGZZd1QkQVSn05KlWe8RigapR15mpPWX8yCIiZOXQgG7EAxErmjMcUOHBsSL0vAaZmi76pVVpew5utLXptUJOZfAFfM+f7Aeqh+YC8jZKDDU30jYZSxusY0fFm1RTns9KUFr1vHWIkbJmCzgJRZUIhvxvgGyNp/UgPAToxAAK3/H2nC9nratqaawelh3TWkdRaN00oZoBRQGxHveSPebkaBeA3NSUCwcw8u/xqrCkAXovfpDqQfGsWASCOcvmcTo9Py3ryc6Z1fgKaFLKpBBsQTXfSOT8RezW4gtRxwQOsZCJjo/XG4D9IpZjwRoQy4gm7vPOO1/lx92QiqY0OThaKU9q7S1nnDTIvN0wSJKnyc1pnTnsMX9Kk68N5tz363tyUw8JUpsi8nctbYkN0xSUEGe2ySwhqoKmw7ta7iUlXmfub6CABUflq9I6xzio2PZwnTJsKlTbmU4Uam6TTd2RoaFqcdBmoDJ0ZCegNZxdk+WGhHMyHcY4jPFvnPv5UyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(54906003)(110136005)(66476007)(38070700005)(122000001)(76116006)(38100700002)(36756003)(4744005)(2616005)(71200400001)(316002)(66946007)(8676002)(66446008)(6486002)(6506007)(66556008)(478600001)(64756008)(4326008)(5660300002)(2906002)(186003)(86362001)(8936002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFIUmdPUWxvOUw1aVJxQlVMenNPbHhYbWVzM2lZalRqNE1va3ZNc3FxbXU1?=
 =?utf-8?B?ZXZVZ3IrRlNJZTZYNFVwVEdZaVhmSmd2SUVZK3h3dU9PcjFLSkJ6WUdKeE0z?=
 =?utf-8?B?MDYzY1hXbFR1N0RmdWJpL3BhSitKNEl2QU1oSlluU05Yc3lTVUZ4eDZ0L2lB?=
 =?utf-8?B?YmV0ajZMTG9JYjBQcmtvSDZKV1RSZ004b2dYR0ZmR285UU5PUG5qRHNKT3lj?=
 =?utf-8?B?ek5GRGVzWStnc3Rzb3NyZyt0RVNZYlpjays0QThFeU42Z0lyZTBVOENuaTdQ?=
 =?utf-8?B?cnpNaFRkMitoaEVIaHR3SFZiN2hKeUJnaXkzdWg2OFdteFc4Y1U4WTZ0TjZ0?=
 =?utf-8?B?ZVhvOEhjMzMyZGVxRWl6YWdqd1NwdmxzTTZwa2s3ZEc4c1l3UkNPVFdselcy?=
 =?utf-8?B?N2dKQ3pzWHRNUlJQckNLKzFhcGFHZFhVeFRoR0xvc09TN1daTmVodzllcnJQ?=
 =?utf-8?B?bEI2YVFLYVhpNWJwVGJvWHliVmREMVgvZWt0T3NaMjNwUnJUcGtqTXc2SGRD?=
 =?utf-8?B?bnpJRjBVSE9SRGN1aDlrV2lzKzJNZ0ZLRVhUMnlhTmtBMW5xbHE4ZXBPZEZS?=
 =?utf-8?B?ZmlPbnhBTEQvbUR1cUxnTXZrRjNxcm1mekFHQkQrRjlOQTYvRDM2VXpyS2tS?=
 =?utf-8?B?VDR1RXpCaFpFQnpteXNsaFgxU3VyNFMyelB2Ky9SWXpDaFpvdS8yL0NBbTF1?=
 =?utf-8?B?Y0N1ZXFJeFNZZEFrMGRCdUZIRCtSVmlybzlVdms0TkZzSkExUXZseUNZdUJQ?=
 =?utf-8?B?RktzNzM0czFtOENHd2dlUkJoNzNUanNEM2cwS1NscVJxYUNXai9qUkw0cWN2?=
 =?utf-8?B?SGtDS3ppOVF3cy9kVlE1bFRkc1BXd053MmNOSFo4UXF6d1pHTExZNXg3YzFr?=
 =?utf-8?B?OFJNREo4QzVtNC96aDNxSXc5dVBtVW9UOGh1Wkd5eG1walljWnBHQ2l0VGRZ?=
 =?utf-8?B?c2ZVL0lKRjRUbTc3a2R6bTgzczBUbnVMRVl0SW9GRk9PN0p5L2VhWGVyL1VV?=
 =?utf-8?B?UDZzb3FaRE5LWGxXWmZnM2M0UnRsbGgveEtzNis0Smh0WGRvUnpub0FDVjIx?=
 =?utf-8?B?UERNN0NKTzc0VG9jWWFyeFdUYUk3cmV6eWd6aW1GRFljM0YwcXh6eE5SSHc3?=
 =?utf-8?B?bG1odnd2cTM4YjJXY2VydmswNmxRZDM1Y2s2cVkxSTRmL1lsZ0hHU3lwR0tl?=
 =?utf-8?B?YXNoVWJJdVNUeFNVK2svS0JteVBlcjBLbkZKTUZlc1QwdzM4elliKzRBcEp6?=
 =?utf-8?B?dk1lQUNEUkZyV1JGK0lrUElLWklJTXBHbjNVcFQ3RnU2THNPTU1nWHdBNTAy?=
 =?utf-8?B?MFUzUkNoSTBHRUlVYkFuU0hSUWF5LzZaZ2QveG94eTQ5ZXhQZjB4YmphbWcw?=
 =?utf-8?B?R0Z3bVRFeTdhcHNzY1YvSHhDcUd1ZFIrVWp0b2FCcXRSMGVwbWthSjNyVGda?=
 =?utf-8?B?OGIrWkxMazY0Z2FxUk5icFQ1dHozNlZSQmdDckNLTkx5eldGS3N2cHMweUM0?=
 =?utf-8?B?K1JYRUpxWHhQM3ZmZ0VRT2xjc1pPUW1pT3g5Z2pVcGVmZk9CNU8vZGZqVW9s?=
 =?utf-8?B?S0RqMy9IK0I4bXp4N0tUZlg0RG1vSU5jc1lEbzlSek5mRkkwVFVUb0ZTNHFp?=
 =?utf-8?B?V0pvYWErdS91dTA0cElHZzR2bHMzSHhOOGJWUGVITFFETzBmb3JRYlhFbUI1?=
 =?utf-8?B?Tlp6T3dKYWZSVVhrc0doekpqT2VkeWVvdkdvSVJBeGFnSitseU8wMSthaDVl?=
 =?utf-8?B?bnlySXFJNGg0cys0NEt1eS9ta3U2UzVDd25zbVlPWUV6MmlKTC9hR3N1d1hy?=
 =?utf-8?Q?NkeuwWxkzff1lsUtYjtT2E0MqV8aiynxa3yOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6DBFDE1046CC4AB0DEB70F6AB46055@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c57b702-767f-4b79-c223-08d961af0124
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 18:44:11.3554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANnm/l/p1skO1IrOW9BNlOOIt148BAjhC9gzPM7B3o3COnlHJ3GLsQtNT5LHz1Uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2701
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: joRkUw79uIUoIwXu_kNGEcoGGSXmmSN7
X-Proofpoint-ORIG-GUID: joRkUw79uIUoIwXu_kNGEcoGGSXmmSN7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=878
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTE3IGF0IDE0OjA1IC0wNDAwLCBKb2hhbm5lcyBXZWluZXIgd3JvdGU6
DQo+IFRvIGZpeCB0aGlzLCBob29rIHByb3BvcnRpb25hbCByZWNsYWltIGludG8gdGhlIHNhbWUg
cmV0cnkgbG9naWMgd2UNCj4gaGF2ZSBpbiBwbGFjZSBmb3Igd2hlbiBjZ3JvdXBzIGFyZSBza2lw
cGVkIGVudGlyZWx5LiBUaGlzIHdheSBpZg0KPiByZWNsYWltIGZhaWxzIGFuZCBzb21lIGNncm91
cHMgd2VyZSBzY2FubmVkIHdpdGggZGltaXNoZWQgcHJlc3N1cmUsDQo+IHdlJ2xsIHRyeSBhbm90
aGVyIGZ1bGwtZm9yY2UgY3ljbGUgYmVmb3JlIGdpdmluZyB1cCBhbmQgT09NaW5nLg0KDQpHb29k
IGNhdGNoLg0KDQo+IFJlcG9ydGVkLWJ5OiBMZW9uIFlhbmcgPGxueW5nQGZiLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+DQoNClJldmll
d2VkLWJ5OiBSaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+DQo=
