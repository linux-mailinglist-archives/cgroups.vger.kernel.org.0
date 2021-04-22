Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D936795B
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhDVFkI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 01:40:08 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:53836 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhDVFj5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 01:39:57 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M5YL3Z021198;
        Thu, 22 Apr 2021 05:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=ijRYYH3nAWlguqDVOMEgSJaHR1RCi7MR0jOwoRMAuMc=;
 b=cKPXQjAbdRrg7e5kUNv1Y1ikWzEXSqbMMgYjdvFN8cyKAmr+tQD3W62WrFuTdPrcqHdL
 4r5DdX40+2X41TAXy7HHD6dDn/fubTlq0Nl0QD3cltfhPxuG0hMcuNd0gKgSfWtwknMT
 tb+3frMSL4nHuZXcGUJ/8GMUjMbntOSpbi01dHQNBJXTsoYcVR86/v/fdnu8SPI4pQLn
 s8ECvW+V59u6mzDZY+/PF7o7cE9otPPII5GR0vuqyj7l/n5P0ubCh8WigzA2+ymHFuNx
 2CQu6VZtESnyWz5rUxTVWYCLHYdChwtTVan9FHo6Y/7dZKjzxORBLCH2Ek1K5NTFsOB8 9w== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55])
        by mx08-001d1705.pphosted.com with ESMTP id 382dwg9qwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 05:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+qUiD6Hq2oNQrvKbsycS/p92D+rWkJAnVN3d5TC4upmn8jKC6BOqVNX9392+3Qj+gIFydAKS1JCBM8BTL3e0DrHNDvk3bXJ7kxI815bPbi+4F6mURb3/oY27xIgeDxOA8StdtvswHQVoL/s2yN9EyEGOelKPBxUUAClbA8zdkqtXYBjVb8xkescR56j7T66O3sxA9jAw48Cxaf8zV6RZK4VRdRZLX0SruIrz53eJZJKCWzxVeeE+8kmzJF96aXwkfy3D/Lw8mrfF+7/XnNoRydPCIrQugdHeHPuA2xwX5E88jKHJV+5okikRsWl34NGZRkTBdEFIp5pRBSs8I8jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijRYYH3nAWlguqDVOMEgSJaHR1RCi7MR0jOwoRMAuMc=;
 b=eJlcq7MciyqRk6Oo0OZpfUTT6/uv7AKBopxBOFeNXvFcVkjDdV1yKS1juB8ybfVQg6wJRW3XangK6ppicwmx6evJyUFM9LhUpPv23ySt12PVJq/QGW4/vjDeU74vGecBkTmEoSeNhM6Y4kMyMZSMfq6uBvjVui/BWPjIy0cp1WZxSffE9ow9Db1XRSZaVcCpZUvVhge9ncDyj6HeLWYujTJZVjVxncbzYqEBdFUnxf/SeyAMrx6husUQxJgPK6jfsJB9P+waVt4w0Thdzs5jSs8CyE0EA5qt7Z0vY9d4yVeHwAp7Nrt5f3F2yTjDkwLrlLXkbHfP2xHOG33rG0s8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB0984.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 05:38:13 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 05:38:13 +0000
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
Thread-Index: AQHXNtw2hk/SodxcJ0CeC+3Me7WEMKq/T3oAgAAI/QCAAK0lAA==
Date:   Thu, 22 Apr 2021 05:38:13 +0000
Message-ID: <6eaa4c24-c565-bc5d-dbca-b73c72569a16@sony.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
 <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
 <1f8d300b-9a8b-de09-6d5d-6a9c20c66d24@sony.com>
 <CALvZod5+5ycobmSt=NC3VJF4FRMFmBQEN7SQgipyTDbzHEbPUQ@mail.gmail.com>
In-Reply-To: <CALvZod5+5ycobmSt=NC3VJF4FRMFmBQEN7SQgipyTDbzHEbPUQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 26aeee37-8509-41ff-f0ad-08d90550d22b
x-ms-traffictypediagnostic: AM9P193MB0984:
x-microsoft-antispam-prvs: <AM9P193MB09846599441F1CB9794EAE8E86469@AM9P193MB0984.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkxhQrmjxJqnOoH3a1LZ+SmB+nEjD6gyZ1Yxk4uiCOd7yOwmRMpQJISstPe0zZCt8sJDXrXMNUmannLz1MSJB9Ag/TRd/pvRiIv/oHu8SlN6DLOtX1iL1H6RtPTpUb4mEA0qVRLmbAuQdiqrhFseKDowS6cJIFnFxr1iw7IgtqlHpqZUxp9+3fmxo9RWcsAWgxfnsMgQgpkLYb6qEctBYvVscaRy/McCkAG30skGabsl6wyXedMnima6iqcygE6JBnuPAymv4m89Up6b9P01EeMbfQp1owKUKR1CIdnrPStvlljKazv8xuYMKncWoRGTXxbEUeynvRP6pBjbxJvLAIPYF6VD/KWYve8dJTP3ZIMf4RG/o4/EBCoigqCbUpkYTYiSzjcAzwBflIhovvxbjEkXxZnKcqRsl5bXTcDIuYDtlxgqTQug6Lsp+gwtkorFnUhWpwXIuQcvtur+leEeQ0FzOQdLKzmV7Nf+KW3TCMzPX5VsoISdJK9qRuo9oCrq/Sw+qTWDWfgwf2dGFKGTk1ZD/6Mg6EREJKstooS2/psDbh/C8lIpZUf16ZsurkQNcUN2fcLyRQ40AdQlRd+dPue5uYU5YiG82gGTJCGGPEzgnyK9v+RSNBg5wluwC4KraFiWXYxGZ8u5LRctPUmT70/y4TjrfcMJVP35sLNcq6/tndIgh8C2RGtXO3lnLLSdJ8dklHWvT0H6mMxTMH8hyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39850400004)(346002)(316002)(2906002)(71200400001)(86362001)(6916009)(54906003)(2616005)(76116006)(53546011)(91956017)(31686004)(8936002)(6506007)(31696002)(64756008)(66946007)(66446008)(8676002)(122000001)(478600001)(83380400001)(38100700002)(66476007)(5660300002)(66556008)(26005)(6512007)(36756003)(6486002)(186003)(4326008)(7416002)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDFiakRabWVleXJWWFBNSGI2ZWIyS3NnQTF6OXBPRnE0ejhaZldTVmZjS2g3?=
 =?utf-8?B?T1NpZmRzSlJWQmdkSUdnMGxzL1RBa2VqSzIvSCs0Z0FJQi8vcHJxSE9DUnRB?=
 =?utf-8?B?S3lnU1ZRVjB4RVYvMWFoQ29pYmhieG01K1BtcHNyUk9TUjN0VkpMeDdiL1Bl?=
 =?utf-8?B?MlpNZ3FqN2JodE5iSTMxQ2s3K0IwYkhoRVFzclpBRFByY09td3RRdzVxUlBv?=
 =?utf-8?B?QkZxWXJycU1ZWk1Id0FDRENnNVFvVitXTklVY25Ua2lVY3dyajJuUEhxTmRQ?=
 =?utf-8?B?M3M0ZXZCTVVkRE5odDZYajEzWjZqSFZMMVovWHlqbG5adEdSNVNybDlKODd3?=
 =?utf-8?B?WHB1Sm5Jbi82L0ZNTEVmcldIZ3FsQngzQitPUU1PRFg1RnZCcnhnUTYxemZp?=
 =?utf-8?B?bGFVMlM5QTlJS1QrQVNKOVZWTDlYVUNldHdabTY5NmE0azQvdlJjeFdrQThM?=
 =?utf-8?B?V3ZjQTJSNmh0bldHaHBBOFBObUZNNGpDNGczOUJmWUlycEhsRVlMRjByZGs5?=
 =?utf-8?B?bXJoWjhPRUhVR1g4R1A3QkV5OFlWZnZjS05ickNMSm5CR2EraW1UOFZkbS9G?=
 =?utf-8?B?cTBIR2szMTFoUXpJNTNLZ0EyYzJkdWFneTdVTW41VWdtcVViQ2lnQjZWSUNy?=
 =?utf-8?B?TXN5Ynp4Z1FCUzNXaWUwblVaRFhUYWxib2ovbXRSOFJ1SlpBVUdwY0Z4RGs5?=
 =?utf-8?B?Z29xZytZWHF5Ujg0ZzNCZ3I5MHh4eGFiSzllZCtMbnkwMWhMcXUyWHpOVnBm?=
 =?utf-8?B?eDljRGpBaXVhYTZwVlpyOTRROERQZ1dGckdMaEIxZkNzYnN4TmpzZjA5UFVS?=
 =?utf-8?B?dWFhV3NMbGg3bGs1NGsybGdJbzRBZVQxL215ZE00M21vdUpTQTdsQ2p4eHZ3?=
 =?utf-8?B?Y0tKVGVMenRHd2JrSi9kU2tqdytRSUhEblJ2eis5NGNiUmJaUUcra3FZU0Fu?=
 =?utf-8?B?RkR0YmZqdGxEUWs5Y0p2V1JsSGtoVndMcnRicVUrbzVpVXNHcHVheHJXc0dr?=
 =?utf-8?B?YXl1S05leHN5Q1p5QjdUR0RSRHFIOFJxUjlWc2VWMC9ZSTdnQTlIMnRFd3dP?=
 =?utf-8?B?THR2c3NpeDVYZ1VCck1RU0JPRzJOZ2E1djczZms4RlM1WTlLaWYxT2J4NGJm?=
 =?utf-8?B?SU1DejRKUXExOWNzME1LdS9xNmxvMkpqNWNWejJhN3hOWUJHY28vcVNSRFMv?=
 =?utf-8?B?WktsT0tUalptamtXMmRpbURCWEdvaituYnBYaUhzdFFxcEVvRzRocUxRb1hu?=
 =?utf-8?B?d2xYS054L3ZyV1JlUTRUTkVwdEpodmc4MjVkeWdFTENIVVJqMHZIWFBvNk9w?=
 =?utf-8?B?NFhsVklmODh6RDVWUml3TzZncFloNlQ0MTdCS05aZFBBODVTbHE0enpLYVQ0?=
 =?utf-8?B?T0lna0dwTC9sV21KTzJPZnp1TlljUGM1a2VPYTNwU3RsSFZBZGZKR2lQRW5B?=
 =?utf-8?B?WmYwdUUvWFFxWGUzY2x4RjA1bjgvV1VtN01KZmt0RlB3KzdidnVQSGkrY1pJ?=
 =?utf-8?B?SDQ1RHZhcERhVlI1dHdxNExVUzlyZWQ2R3p2Qnl4bGd0VWx1SHpFWm9XYnNa?=
 =?utf-8?B?T0JBelJpTEQwckd2UW5acjA1OWJhU1NnUVRscFJiRTBrelducWt2L1BXeW1U?=
 =?utf-8?B?elhzbjZaSWxnNS9hWGNNM2E3ZXNFekJPQStXanBJMzJZM3doQmsvMG1YYzBj?=
 =?utf-8?B?VkE3UlhtQ0k0QVJOeXkxSTdpOHVObVQ5Z1JKOVlEWTVEcVZlME4xY256UlRX?=
 =?utf-8?Q?KkAkTQcxEmMJpRVl2ZRqjKiEf7atv52TeXCh20L?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE08DE8AA22B454A8F89E18D52193277@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aeee37-8509-41ff-f0ad-08d90550d22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 05:38:13.0576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCC9P6JHV9Z+yoTTLI8knKN1ckl6oE151IVZ+ocBez06TaVflKmuBctIEFrRX0XGKU0i5ocjDeOhBvXeCps8H0FHuv8y/FnEaezSXLEc5YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0984
X-Proofpoint-GUID: NCkDAtFgYAPcEuCEoHQNUpGb_l6uZVQO
X-Proofpoint-ORIG-GUID: NCkDAtFgYAPcEuCEoHQNUpGb_l6uZVQO
X-Sony-Outbound-GUID: NCkDAtFgYAPcEuCEoHQNUpGb_l6uZVQO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_01:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220047
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gNC8yMS8yMSA5OjE4IFBNLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+IE9uIFdlZCwgQXByIDIx
LCAyMDIxIGF0IDExOjQ2IEFNIDxQZXRlci5FbmRlcmJvcmdAc29ueS5jb20+IHdyb3RlOg0KPj4g
T24gNC8yMS8yMSA4OjI4IFBNLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+Pj4gT24gV2VkLCBBcHIg
MjEsIDIwMjEgYXQgMTA6MDYgQU0gcGV0ZXIgZW5kZXJib3JnDQo+Pj4gPHBldGVyLmVuZGVyYm9y
Z0Bzb255LmNvbT4gd3JvdGU6DQo+Pj4+IE9uIDQvMjAvMjEgMzo0NCBBTSwgU2hha2VlbCBCdXR0
IHdyb3RlOg0KPj4+IFsuLi5dDQo+Pj4+IEkgdGhpbmsgdGhpcyBpcyB0aGUgd3Jvbmcgd2F5IHRv
IGdvLg0KPj4+IFdoaWNoIG9uZT8gQXJlIHlvdSB0YWxraW5nIGFib3V0IHRoZSBrZXJuZWwgb25l
PyBXZSBhbHJlYWR5IHRhbGtlZCBvdXQNCj4+PiBvZiB0aGF0LiBUbyBkZWNpZGUgdG8gT09NLCB3
ZSBuZWVkIHRvIGxvb2sgYXQgYSB2ZXJ5IGRpdmVyc2Ugc2V0IG9mDQo+Pj4gbWV0cmljcyBhbmQg
aXQgc2VlbXMgbGlrZSB0aGF0IHdvdWxkIGJlIHZlcnkgaGFyZCB0byBkbyBmbGV4aWJseQ0KPj4+
IGluc2lkZSB0aGUga2VybmVsLg0KPj4gWW91IGRvbnQgbmVlZCB0byBkZWNpZGUgdG8gb29tLCBi
dXQgd2hlbiBvb20gb2NjdXJzIHlvdQ0KPj4gY2FuIHRha2UgYSBwcm9wZXIgYWN0aW9uLg0KPiBO
bywgd2Ugd2FudCB0aGUgZmxleGliaWxpdHkgdG8gZGVjaWRlIHdoZW4gdG8gb29tLWtpbGwuIEtl
cm5lbCBpcyB2ZXJ5DQo+IGNvbnNlcnZhdGl2ZSBpbiB0cmlnZ2VyaW5nIHRoZSBvb20ta2lsbC4N
Cg0KSXQgd29udCBkbyBpdCBmb3IgeW91LiBXZSB1c2UgdGhpcyBjb2RlIHRvIHNvbHZlIHRoYXQ6
DQoNCi8qDQrCoCrCoCBsb3dtZW1vcnlraWxsZXJfb29tDQrCoCoNCsKgKsKgIEF1dGhvcjogUGV0
ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJvcmdAc29ueW1vYmlsZS5jb20+DQrCoCoNCsKgKsKg
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5DQrCoCrCoCBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KwqAqwqAgcHVibGlzaGVkIGJ5IHRoZSBGcmVl
IFNvZnR3YXJlIEZvdW5kYXRpb24uDQrCoCovDQoNCi8qIGFkZCBmYWtlIHByaW50IGZvcm1hdCB3
aXRoIG9yaWdpbmFsIG1vZHVsZSBuYW1lICovDQojZGVmaW5lIHByX2ZtdChmbXQpICJsb3dtZW1v
cnlraWxsZXI6ICIgZm10DQoNCiNpbmNsdWRlIDxsaW51eC9tbS5oPg0KI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCiNpbmNsdWRlIDxsaW51eC9vb20uaD4NCg0KI2luY2x1ZGUgPHRyYWNlL2V2ZW50
cy9sbWsuaD4NCg0KI2luY2x1ZGUgImxvd21lbW9yeWtpbGxlci5oIg0KI2luY2x1ZGUgImxvd21l
bW9yeWtpbGxlcl90bmcuaCINCiNpbmNsdWRlICJsb3dtZW1vcnlraWxsZXJfc3RhdHMuaCINCiNp
bmNsdWRlICJsb3dtZW1vcnlraWxsZXJfdGFza3MuaCINCg0KLyoqDQrCoCogbG93bWVtb3J5a2ls
bGVyX29vbV9ub3RpZnkgLSBPT00gbm90aWZpZXINCsKgKiBAc2VsZjrCoMKgwqAgbm90aWZpZXIg
YmxvY2sgc3RydWN0DQrCoCogQG5vdHVzZWQ6wqDCoMKgIG5vdCB1c2VkDQrCoCogQHBhcm06wqDC
oMKgIHJldHVybmVkIC0gbnVtYmVyIG9mIHBhZ2VzIGZyZWVkDQrCoCoNCsKgKiBSZXR1cm4gdmFs
dWU6DQrCoCrCoMKgwqAgTk9USUZZX09LDQrCoCoqLw0KDQpzdGF0aWMgaW50IGxvd21lbW9yeWtp
bGxlcl9vb21fbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqc2VsZiwNCsKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbm90dXNlZCwgdm9pZCAq
cGFyYW0pDQp7DQrCoMKgwqAgc3RydWN0IGxta19yYl93YXRjaCAqbHJ3Ow0KwqDCoMKgIHVuc2ln
bmVkIGxvbmcgKm5mcmVlZCA9IHBhcmFtOw0KDQrCoMKgwqAgbG93bWVtX3ByaW50KDIsICJvb20g
bm90aWZ5IGV2ZW50XG4iKTsNCsKgwqDCoCAqbmZyZWVkID0gMDsNCsKgwqDCoCBsbWtfaW5jX3N0
YXRzKExNS19PT01fQ09VTlQpOw0KwqDCoMKgIHNwaW5fbG9ja19iaCgmbG1rX3Rhc2tfbG9jayk7
DQrCoMKgwqAgbHJ3ID0gX19sbWtfdGFza19maXJzdCgpOw0KwqDCoMKgIGlmIChscncpIHsNCsKg
wqDCoCDCoMKgwqAgc3RydWN0IHRhc2tfc3RydWN0ICpzZWxlY3RlZCA9IGxydy0+dHNrOw0KwqDC
oMKgIMKgwqDCoCBzdHJ1Y3QgbG1rX2RlYXRoX3BlbmRpbmdfZW50cnkgKmxkcHQ7DQoNCsKgwqDC
oCDCoMKgwqAgaWYgKCF0YXNrX3RyeWxvY2tfbG1rKHNlbGVjdGVkKSkgew0KwqDCoMKgIMKgwqDC
oCDCoMKgwqAgbG1rX2luY19zdGF0cyhMTUtfRVJST1IpOw0KwqDCoMKgIMKgwqDCoCDCoMKgwqAg
bG93bWVtX3ByaW50KDEsICJGYWlsZWQgdG8gbG9jayB0YXNrLlxuIik7DQrCoMKgwqAgwqDCoMKg
IMKgwqDCoCBsbWtfaW5jX3N0YXRzKExNS19CVVNZKTsNCsKgwqDCoCDCoMKgwqAgwqDCoMKgIGdv
dG8gdW5sb2NrX291dDsNCsKgwqDCoCDCoMKgwqAgfQ0KDQrCoMKgwqAgwqDCoMKgIGdldF90YXNr
X3N0cnVjdChzZWxlY3RlZCk7DQrCoMKgwqAgwqDCoMKgIC8qIG1vdmUgdG8ga2lsbCBwZW5kaW5n
IHNldCAqLw0KwqDCoMKgIMKgwqDCoCBsZHB0ID0ga21lbV9jYWNoZV9hbGxvYyhsbWtfZHBfY2Fj
aGUsIEdGUF9BVE9NSUMpOw0KwqDCoMKgIMKgwqDCoCAvKiBpZiB3ZSBmYWlsIHRvIGFsbG9jIHdl
IGlnbm9yZSB0aGUgZGVhdGggcGVuZGluZyBsaXN0ICovDQrCoMKgwqAgwqDCoMKgIGlmIChsZHB0
KSB7DQrCoMKgwqAgwqDCoMKgIMKgwqDCoCBsZHB0LT50c2sgPSBzZWxlY3RlZDsNCsKgwqDCoCDC
oMKgwqAgwqDCoMKgIF9fbG1rX2RlYXRoX3BlbmRpbmdfYWRkKGxkcHQpOw0KwqDCoMKgIMKgwqDC
oCB9IGVsc2Ugew0KwqDCoMKgIMKgwqDCoCDCoMKgwqAgV0FSTl9PTigxKTsNCsKgwqDCoCDCoMKg
wqAgwqDCoMKgIGxta19pbmNfc3RhdHMoTE1LX01FTV9FUlJPUik7DQrCoMKgwqAgwqDCoMKgIMKg
wqDCoCB0cmFjZV9sbWtfc2lna2lsbChzZWxlY3RlZC0+cGlkLCBzZWxlY3RlZC0+Y29tbSwNCsKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqAgTE1LX1RSQUNFX01FTUVSUk9SLCAq
bmZyZWVkLCAwKTsNCsKgwqDCoCDCoMKgwqAgfQ0KwqDCoMKgIMKgwqDCoCBpZiAoIV9fbG1rX3Rh
c2tfcmVtb3ZlKHNlbGVjdGVkLCBscnctPmtleSkpDQrCoMKgwqAgwqDCoMKgIMKgwqDCoCBXQVJO
X09OKDEpOw0KDQrCoMKgwqAgwqDCoMKgIHNwaW5fdW5sb2NrX2JoKCZsbWtfdGFza19sb2NrKTsN
CsKgwqDCoCDCoMKgwqAgKm5mcmVlZCA9IGdldF90YXNrX3JzcyhzZWxlY3RlZCk7DQrCoMKgwqAg
wqDCoMKgIHNlbmRfc2lnKFNJR0tJTEwsIHNlbGVjdGVkLCAwKTsNCg0KwqDCoMKgIMKgwqDCoCBM
TUtfVEFHX1RBU0tfRElFKHNlbGVjdGVkKTsNCsKgwqDCoCDCoMKgwqAgdHJhY2VfbG1rX3NpZ2tp
bGwoc2VsZWN0ZWQtPnBpZCwgc2VsZWN0ZWQtPmNvbW0sDQrCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqAgTE1LX1RSQUNFX09PTUtJTEwsICpuZnJlZWQsDQrCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqAgMCk7DQoNCsKgwqDCoCDCoMKgwqAgdGFza191bmxvY2soc2VsZWN0ZWQpOw0K
wqDCoMKgIMKgwqDCoCBwdXRfdGFza19zdHJ1Y3Qoc2VsZWN0ZWQpOw0KwqDCoMKgIMKgwqDCoCBs
bWtfaW5jX3N0YXRzKExNS19PT01fS0lMTF9DT1VOVCk7DQrCoMKgwqAgwqDCoMKgIGdvdG8gb3V0
Ow0KwqDCoMKgIH0NCnVubG9ja19vdXQ6DQrCoMKgwqAgc3Bpbl91bmxvY2tfYmgoJmxta190YXNr
X2xvY2spOw0Kb3V0Og0KwqDCoMKgIHJldHVybiBOT1RJRllfT0s7DQp9DQoNCnN0YXRpYyBzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sgbG93bWVtb3J5a2lsbGVyX29vbV9uYiA9IHsNCsKgwqDCoCAubm90
aWZpZXJfY2FsbCA9IGxvd21lbW9yeWtpbGxlcl9vb21fbm90aWZ5DQp9Ow0KDQppbnQgX19pbml0
IGxvd21lbW9yeWtpbGxlcl9yZWdpc3Rlcl9vb21fbm90aWZpZXIodm9pZCkNCnsNCsKgwqDCoCBy
ZWdpc3Rlcl9vb21fbm90aWZpZXIoJmxvd21lbW9yeWtpbGxlcl9vb21fbmIpOw0KwqDCoMKgIHJl
dHVybiAwOw0KfQ0KDQoNClNvIHdoYXQgbmVlZGVkIGlzIGEgZnVuY3Rpb24gdGhhdCBrbm93cyB0
aGUNCnByaW9yaXR5LiBIZXJlIF9fbG1rX3Rhc2tfZmlyc3QoKSB0aGF0IGlzIGZyb20gYSByYi10
cmVlLg0KDQpZb3UgY2FuIHBpY2sgd2hhdCBldmVyIHByaW9yaXR5IHlvdSBsaWtlLiBJbiBvdXIg
Y2FzZSBpdCBpcyBhDQphbmRyb2lkIHNvIGl0IGlzIGEgc3RyaWN0bHkgb29tX2FkaiBvcmRlciBp
biB0aGUgdHJlZS4NCg0KSSB0aGluayB5b3UgY2FuIGRvIHRoZSBzYW1lIHdpdGggYSBvbGQgbG93
bWVtbW9yeWtpbGxlciBzdHlsZcKgIHdpdGgNCmEgZnVsbCB0YXNrIHNjYW4gdG9vLg0KDQo+IFsu
Li5dDQo+Pj4gQWN0dWFsbHkgbm8uIEl0IGlzIG1pc3NpbmcgdGhlIGZsZXhpYmlsaXR5IHRvIG1v
bml0b3IgbWV0cmljcyB3aGljaCBhDQo+Pj4gdXNlciBjYXJlIGFuZCBiYXNlZCBvbiB3aGljaCB0
aGV5IGRlY2lkZSB0byB0cmlnZ2VyIG9vbS1raWxsLiBOb3Qgc3VyZQ0KPj4+IGhvdyB3aWxsIHdh
dGNoZG9nIHJlcGxhY2UgcHNpL3ZtcHJlc3N1cmU/IFVzZXJzcGFjZSBrZWVwcyBwZXR0aW5nIHRo
ZQ0KPj4+IHdhdGNoZG9nIGRvZXMgbm90IG1lYW4gdGhhdCBzeXN0ZW0gaXMgbm90IHN1ZmZlcmlu
Zy4NCj4+IFRoZSB1c2Vyc3BhY2Ugc2hvdWxkIHZlcnkgbXVjaCBkbyB3aGF0IGl0IGRvLiBCdXQg
d2hlbiBpdA0KPj4gZG9lcyBub3QgZG8gd2hhdCBpdCBzaG91bGQgZG8sIGluY2x1ZGluZyBraWNr
IHRoZSBXRC4gVGhlbg0KPj4gdGhlIGtlcm5lbCBraWNrcyBpbiBhbmQga2lsbCBhIHByZSBkZWZp
bmVkIHByb2Nlc3Mgb3IgYXMgbWFueQ0KPj4gYXMgbmVlZGVkIHVudGlsIHRoZSBtb25pdG9yaW5n
IGNhbiBzdGFydCB0byBraWNrIGFuZCBoYXZlIHRoZQ0KPj4gY29udHJvbC4NCj4+DQo+IFJvbWFu
IGFscmVhZHkgc3VnZ2VzdGVkIHNvbWV0aGluZyBzaW1pbGFyIChpLmUuIG9vbS1raWxsZXIgY29y
ZSBhbmQNCj4gZXh0ZW5kZWQgYW5kIGNvcmUgd2F0Y2hpbmcgZXh0ZW5kZWQpIGJ1dCBjb21wbGV0
ZWx5IGluIHVzZXJzcGFjZS4gSQ0KPiBkb24ndCBzZWUgd2h5IHdlIHdvdWxkIHdhbnQgdG8gZG8g
dGhhdCBpbiB0aGUga2VybmVsIGluc3RlYWQuDQoNCkEgd2F0Y2hkb2cgaW4ga2VybmVsIHdpbGwg
d29yayBpZiB1c2Vyc3BhY2UgaXMgY29tcGxldGVseSBicm9rZW4NCm9yIHN0YXZlZCB3aXRoIGxv
dyBvbiBtZW1vcnkuDQoNCg0KPg0KPj4+IEluIGFkZGl0aW9uIG9vbSBwcmlvcml0aWVzIGNoYW5n
ZSBkeW5hbWljYWxseSBhbmQgY2hhbmdpbmcgaXQgaW4geW91cg0KPj4+IHN5c3RlbSBzZWVtcyB2
ZXJ5IGhhcmQuIENncm91cCBhd2FyZW5lc3MgaXMgbWlzc2luZyB0b28uDQo+PiBXaHkgaXMgdGhh
dCBoYXJkPyBNb3ZpbmcgYSBvYmplY3QgaW4gYSByYi10cmVlIGlzIGFzIGdvb2QgaXQgZ2V0Lg0K
Pj4NCj4gSXQgaXMgYSBncm91cCBvZiBvYmplY3RzLiBBbnl3YXlzIHRoYXQgaXMgaW1wbGVtZW50
YXRpb24gZGV0YWlsLg0KPg0KPiBUaGUgbWVzc2FnZSBJIGdvdCBmcm9tIHRoaXMgZXhjaGFuZ2Ug
aXMgdGhhdCB3ZSBjYW4gaGF2ZSBhIHdhdGNoZG9nDQo+ICh1c2Vyc3BhY2Ugb3Iga2VybmVsKSB0
byBmdXJ0aGVyIGltcHJvdmUgdGhlIHJlbGlhYmlsaXR5IG9mIHVzZXJzcGFjZQ0KPiBvb20ta2ls
bGVycy4NCg0K
