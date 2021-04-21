Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996D23672CC
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 20:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbhDUSrF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 14:47:05 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:51858 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233038AbhDUSrF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 14:47:05 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LIf7Vf014856;
        Wed, 21 Apr 2021 18:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=v2af2Y67j2Zmkp/5RNqUHM5m9viZMjoevknqrwOcuSg=;
 b=e7AQFycMQAdX0DHdWUJn5p3dK8AYsIKdHU9Y0lbSOWbH3H5MslzOq6BcYA9GveoXheIP
 CqNd1/J3ajBXuB49Ud1qW+JOM6yxMqX8id5rhj1Xev9J6+uq6bemVMPZoaPp6ObpW9oP
 0+32qUaxntsOuQohpxR21ZpcYOlBjkcOCtptlzWHhASwvFeWD0UNeeyJu4Rt8dV53HVx
 zKW0oBhJLEoZ3V56A53120WLIDCuIxHp0EUtWBnDTQ2hg9mvSUlA8GCnXa1b4PRYiPTf
 jnsPTCRe0wTI1GWLcCesQV2H591SPf3Yp/acCE7sZ3J+lpspzxE525Q50H8rNScjZli1 gQ== 
Received: from eur02-ve1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
        by mx08-001d1705.pphosted.com with ESMTP id 382dwg92nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 18:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6dRav9T8AOUOAI7V/07RyWiQcNeDpg3S51/LPr+SbARpj2V5222ZNamtm73RqX4T2QDtdmmSprs1Wvls8qZ8Ra/UULcT5ssdGBNqg7wDJY2GTKLGsXY/umebe6fo7hCvyh+FfawS6M7VAay8+zjcPvAA1bPRIXSZ+UxbTYVulxXfK3b3PY1u864GiOqgBpcKVuQBf+6iNqFC4RWhbTkqRrNrAKypqPG4XM9bd33B4WtsFUkqyn7oJTJD799BYW6KtD/JPOKw/YgwVcm6uZSvyLgLy6F8HHY9zy83sFDVk9mX6sPOQXFZIeHdQ7kCR9ttzKAeVoAReJ679VI8ns6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2af2Y67j2Zmkp/5RNqUHM5m9viZMjoevknqrwOcuSg=;
 b=W9MslSvQX61Djb/uW5N/l+k44z8qSgyrlKlpkcakZ9MTM7l7+jMdnwbfQZ4egO6oSLQk43r0tpubTQhKZwelFZg165f13JHskIl3Di7QqnmmggYjFANT3RdhPg4nnMMzkbuL09+1vPH5T296MdLqMvmUzriwmxumencrMP2ZxmFvJUtd4Gv+dbldCQDM8G6ioFpjLXPXIQbmtpvzJtifW+HBpJzw+NIwcn0pVuRG6mP91g5NuZwKuC6Kj+kEhQNAB9Otazc85IbyT8WjC7oGAN2OTgtC0FWDZ9tdlU133sUdW/rHNopmlTUqpVHvrLy7PLEO+pCvFqztbW6mPO3M9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0770.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 18:46:13 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Wed, 21 Apr 2021
 18:46:13 +0000
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
Thread-Index: AQHXNtw2hk/SodxcJ0CeC+3Me7WEMKq/T3oA
Date:   Wed, 21 Apr 2021 18:46:13 +0000
Message-ID: <1f8d300b-9a8b-de09-6d5d-6a9c20c66d24@sony.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
 <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
In-Reply-To: <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 6c9f2405-1b56-4ac0-9ee7-08d904f5bd35
x-ms-traffictypediagnostic: AM0P193MB0770:
x-microsoft-antispam-prvs: <AM0P193MB077065065BB92D667732EE5E86479@AM0P193MB0770.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rbiK+uVFmDKVzjl7/aX/2kA8rxSJ4aU3Lg4P8o7jbGbwj82GNOp2jb96VqQRnzhbnQfJLyWXvm6s2StKRuyA7Feflh6fSINgfG9Ue/cbTmdToX3N6XhnAvSBPq3jlKwNZFAlpWOytEFq/+omf60huo658+sQ3/hnLGSaCqTQjK2L89CsmcQgfxzcF+VHIGPf80vwUAGFInjSxSM9ndlN3t3G9VF5pdWIXPvLEPRFYaEEQ/m2ktacEpUwZ5fVvp846DiRdhnnjBSLjhLfkwghVjMYevXHmVvAAJSY9Ne/A+7i1zgKOWlQaTaojR/e/s00zBi5SBBAhMPQYEwW63jFXGlgfThZkWXhY8cTvxxKoT/optzsFE66NSub7Dx6vjUwJ3iJnCHkzf4+y057lhqPJ0Hiswb5V+7LErwgO1EfMNoUdqPDbEGB1N9DQBaR6yHmNFDjv1dTB1mHclS1MwyfA7JtFQO4BZaPtuKD7frbrqnR28Vzxxty0K3SC7m2g21zgxpcqTWwAsPdBmYn+JKqz35rIKs9w3ifhjDrqNJKiPEzElxz32SfdXW21g/MmXqMM6ckuakd615lvwfdn//uM9paPVezELlJ/MFqPnZ09illFuw+IknsnKRgv6L1PH+i1pczI6Dqrqde5SL8ixUycXKBZhKGP5L0jfr3Zob8ZM3+Jned35WeXPwGAbVqTjjeuAngVdnlVqn88IHTITDYHWsNz2yjmpz/gXLs+ceeunAv18M0JgKBihXmgO5EEhFiTh6t9Fva1KqthiKOPOBG1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(366004)(396003)(346002)(2616005)(6486002)(316002)(2906002)(186003)(54906003)(4326008)(26005)(6512007)(6916009)(71200400001)(7416002)(38100700002)(31686004)(66556008)(66446008)(36756003)(122000001)(91956017)(76116006)(8936002)(66946007)(8676002)(6506007)(966005)(5660300002)(53546011)(64756008)(86362001)(31696002)(66476007)(478600001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cHdHWGo1SU85RkVKVHZFdEZlNTU0UmEzdytlTVFkMmNFM3BIR3kxVjZ2R3FX?=
 =?utf-8?B?cjFrT3AybFFpbm1aYm5mUUdPaFp1ZVNiRkcycEJ6bFdNMlFHc244dTNrWHlh?=
 =?utf-8?B?RC9zVXVvd25XMHE4eisvMHkxRGdSZHlEWEpTSytSSk9TUkk1MTYwZkdYN29w?=
 =?utf-8?B?UE1rQzU5bnc3ckJWSWNLOXFwNHIwcU5RVmRDVWJiRDJsUWk5YkZJRTNZbWd2?=
 =?utf-8?B?em1oV1FaV2tlZ1FqTUFZMkdZQ3NhdDFxVW5vU1ZMU1AzR1NzNjFkOEFwU1Zp?=
 =?utf-8?B?U1pXckhTRU9VL0JPbHlLSmRseUJxc01rdUZJVkN1aVdJWEs0WG5NdHV6aXVV?=
 =?utf-8?B?Zy8rT1loL1paUXdNNG1hYlNVdGdtSUJaazFVUGJrNk9WN2h5RGtQL1VyaTAx?=
 =?utf-8?B?TG5oalIrYzFVb21Jd09XekEvUUJKb1EwVGxIUktXK1Z1UFNsSm5jZDdwNEh3?=
 =?utf-8?B?UHl5SVdEWUwvVm5kMFgvNWQxS0xYR3AxSHUrK2swRDdqOHhGT0RTUDdURTVx?=
 =?utf-8?B?M1g2Ym1rdlZnZVhpaGNXUE1KOWx1R3NtVEdpRVkwMzlpMWRSV3g2V0hjQ2d3?=
 =?utf-8?B?eTdpZEJQMXJOdEx5UkR4L2FKRzVqYkVNWlRDbVNZYVFnQVpZSTZZOEFVZjhj?=
 =?utf-8?B?ank4TVVmQVAyYzZQaEFmNXR5VHg1UVpxb1BZSDdqUmwvbEFZZGtDbm5DUEda?=
 =?utf-8?B?cklLWTRqUEc2d1hqc2tIdWkrRXZSeGg0WDllMHJCY1lkV1ZTeTNyTXMvMURQ?=
 =?utf-8?B?L1FCdk5mb041MSsveEpvbHdoVXQzeGE1bnN1WWhVK3VnN1c1UU1BRDBBajRZ?=
 =?utf-8?B?dVo0ZHRpWXZSdGFxeldtYnF5ZFd6aFdYWnY2cTVIbERHQXNaZnhWZlpvSXUw?=
 =?utf-8?B?MXJaRWlCaG9qME9XaW4rbjJubDB1YUYzc3Fna1dGbEVNZHhJb0ZvNnVpNlJM?=
 =?utf-8?B?bzI4TkdURVBybEsydVVidVhZRm9uR1RUVnVRa0RWUlJ1bWdaeTlSNnZNYjRu?=
 =?utf-8?B?dkhReFp2aWt0dENDajZFWTdDTkdienFHSzNUK2hHNmhkcFJHdVRxUHZsV21E?=
 =?utf-8?B?YitEa202Rlg1UDRlaVZQQ2QzVjEvQlRnSnpPLzdYTnBFZWVYTzZDdnRIYnJz?=
 =?utf-8?B?N05oWXJmRTR0dUZEVnRDZFJ2Q04vRWdtWUxCdHRtS2djWmpJRVhjTDJUZXpP?=
 =?utf-8?B?VEZVYnBEZjE0K3lhWk9MdTRwcUFXZ1FwK3NqRjFWN0dtRVZlaldubU5ndXZT?=
 =?utf-8?B?cFpJVE9SRXE4dEhzSmhUbWthakpMZ3dyYklGUXg3TldHNGRPZFRFejQ4M2h5?=
 =?utf-8?B?N2VpSm1GQXZLVzRONWQ4MHVLTUMvU29aYnBlVkhoOFF1U0d0NnhmTUxMUmh4?=
 =?utf-8?B?Qno2SVJaM09meVlmWDZ5WkE4bTN6NWxxcXFYSkIxUUVCMEFLaHlDcWhrcDZv?=
 =?utf-8?B?WWF0WVhPZlI2SHk0cndBc1FLMDhMbU9wRjV6bnVya2lrVVNjNjYvVFhTOEJV?=
 =?utf-8?B?OXhrZlMwZEFHbGhqdFExMlVKb05lT0llb3h2Ujh4ZFl6bjQ5TmpDYlBHV0N2?=
 =?utf-8?B?WGp3NnpBdVd3aVZJK3dQNDBQOWNsQVJqWHpMcG8rMlNEdHl4RzZLcHB2eXRN?=
 =?utf-8?B?TUhPM2hjTEN2bWFNMUJsSVlxM3lRS0s5ZU1WUlA5d2krNXBsYVY2Rzh3R0JG?=
 =?utf-8?B?TE56aTVqNyt5NXloRE5haFJIS1BCamN4dEN3OUZpYlRMbEtxSHdPYzd4cG5m?=
 =?utf-8?Q?+zejic1VIa4j3xJXrQExOLAlppjqITpPZy/ow0n?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D5B716718F7FC41A8629E8261815C61@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9f2405-1b56-4ac0-9ee7-08d904f5bd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 18:46:13.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xadyYsmifM4fDK/phqpdPqY8b0zlk7W3zKdJdcEbg6AuJxj4r9LKcuK7Y0Z9Wl1BUat2hcVeCM3nOLSkBKTJpgOXRaKMQZZb2U7NUwkXIwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0770
X-Proofpoint-GUID: nNkqbiaq50AQbQ-nNjxkWByUgovnvhBS
X-Proofpoint-ORIG-GUID: nNkqbiaq50AQbQ-nNjxkWByUgovnvhBS
X-Sony-Outbound-GUID: nNkqbiaq50AQbQ-nNjxkWByUgovnvhBS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210129
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gNC8yMS8yMSA4OjI4IFBNLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+IE9uIFdlZCwgQXByIDIx
LCAyMDIxIGF0IDEwOjA2IEFNIHBldGVyIGVuZGVyYm9yZw0KPiA8cGV0ZXIuZW5kZXJib3JnQHNv
bnkuY29tPiB3cm90ZToNCj4+IE9uIDQvMjAvMjEgMzo0NCBBTSwgU2hha2VlbCBCdXR0IHdyb3Rl
Og0KPiBbLi4uXQ0KPj4gSSB0aGluayB0aGlzIGlzIHRoZSB3cm9uZyB3YXkgdG8gZ28uDQo+IFdo
aWNoIG9uZT8gQXJlIHlvdSB0YWxraW5nIGFib3V0IHRoZSBrZXJuZWwgb25lPyBXZSBhbHJlYWR5
IHRhbGtlZCBvdXQNCj4gb2YgdGhhdC4gVG8gZGVjaWRlIHRvIE9PTSwgd2UgbmVlZCB0byBsb29r
IGF0IGEgdmVyeSBkaXZlcnNlIHNldCBvZg0KPiBtZXRyaWNzIGFuZCBpdCBzZWVtcyBsaWtlIHRo
YXQgd291bGQgYmUgdmVyeSBoYXJkIHRvIGRvIGZsZXhpYmx5DQo+IGluc2lkZSB0aGUga2VybmVs
Lg0KWW91IGRvbnQgbmVlZCB0byBkZWNpZGUgdG8gb29tLCBidXQgd2hlbiBvb20gb2NjdXJzIHlv
dQ0KY2FuIHRha2UgYSBwcm9wZXIgYWN0aW9uLg0KPg0KPj4gSSBzZW50IGEgcGF0Y2ggZm9yIGFu
ZHJvaWQgbG93bWVtb3J5a2lsbGVyIHNvbWUgeWVhcnMgYWdvLg0KPj4NCj4+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcv
cGlwZXJtYWlsL2RyaXZlcmRldi1kZXZlbC8yMDE3LUZlYnJ1YXJ5LzEwMDMxOS5odG1sX187ISFK
bW9aaVpHQnYzUnZLUlN4IXB3bVk3UjFrR1BrWnE5NWJIU09iSHFJUjEtcjNJdFNCZ2RSQmRLeW05
dUNjVXByR3EtQ1VyQUlhSDk0NnZXSnFyalUkIA0KPj4NCj4+IEl0IGhhcyBiZWVuIGltcHJvdmVk
IHNpbmNlIHRoYW4sIHNvIGl0IGNhbiBhY3QgaGFuZGxlIG9vbSBjYWxsYmFja3MsIGl0IGNhbiBh
Y3Qgb24gdm1wcmVzc3VyZSBhbmQgcHNpDQo+PiBhbmQgYXMgYSBzaHJpbmtlci4gVGhlIHBhdGNo
ZXMgaGFzIG5vdCBiZWVuIHBvcnRlZCB0byByZXNlbnQga2VybmVscyB0aG91Z2guDQo+Pg0KPj4g
SSBkb24ndCB0aGluayB2bXByZXNzdXJlIGFuZCBwc2kgaXMgdGhhdCByZWxldmFudCBub3cuIChU
aGV5IGFyZSB3aGF0IHVzZXJzcGFjZSBhY3Qgb24pICBCdXQgdGhlIGJhc2ljIGlkZWEgaXMgdG8g
aGF2ZSBhIHByaW9yaXR5IHF1ZXVlDQo+PiB3aXRoaW4gdGhlIGtlcm5lbC4gSXQgbmVlZCBwaWNr
IHVwIG5ldyBwcm9jZXNzZXMgYW5kIGR5aW5nIHByb2Nlc3MuICBBbmQgdGhlbiBpdCBoYXMgYSBv
cmRlciwgYW5kIHRoYXQNCj4+IGlzIHNldCB3aXRoIG9vbSBhZGogdmFsdWVzIGJ5IGFjdGl2aXR5
IG1hbmFnZXIgaW4gYW5kcm9pZC4gIEkgc2VlIHRoaXMgbW9kZWwgY2FuIGJlIHJldXNlZCBmb3IN
Cj4+IHNvbWV0aGluZyB0aGF0IGlzIGJldHdlZW4gYSBzdGFuZGFyZCBvb20gYW5kIHVzZXJzcGFj
ZS4gIEluc3RlYWQgb2Ygdm1wcmVzc3VyZSBhbmQgcHNpDQo+PiBhIHdhdGNoZG9nIG1pZ2h0IGJl
IGEgYmV0dGVyIHdheS4gIElmIHVzZXJzcGFjZSAoaW4gYW5kcm9pZCB0aGUgYWN0aXZpdHkgbWFu
YWdlciBvciBsbWtkKSBkb2VzIG5vdCBraWNrIHRoZSB3YXRjaGRvZywNCj4+IHRoZSB3YXRjaGRv
ZyBiaXRlIHRoZSB0YXNrIGFjY29yZGluZyB0byB0aGUgcHJpb3JpdHkgYW5kIGtpbGxzIGl0LiAg
VGhpcyBwcmlvcml0eSBsaXN0IGRvZXMgbm90IGhhdmUgdG8gYmUgYSBsaXN0IGdlbmVyYXRlZA0K
Pj4gd2l0aGluIGtlcm5lbC4gQnV0IGl0IGhhcyB0aGUgYWR2YW50YWdlIHRoYXQgeW91IGluaGVy
ZW50IHBhcmVudHMgcHJvcGVydGllcy4gIFdlIHVzZSBhIHJiLXRyZWUgZm9yIHRoYXQuDQo+Pg0K
Pj4gQWxsIHRoYXQgaXMgbWlzc2luZyBpcyB0aGUgd2F0Y2hkb2cuDQo+Pg0KPiBBY3R1YWxseSBu
by4gSXQgaXMgbWlzc2luZyB0aGUgZmxleGliaWxpdHkgdG8gbW9uaXRvciBtZXRyaWNzIHdoaWNo
IGENCj4gdXNlciBjYXJlIGFuZCBiYXNlZCBvbiB3aGljaCB0aGV5IGRlY2lkZSB0byB0cmlnZ2Vy
IG9vbS1raWxsLiBOb3Qgc3VyZQ0KPiBob3cgd2lsbCB3YXRjaGRvZyByZXBsYWNlIHBzaS92bXBy
ZXNzdXJlPyBVc2Vyc3BhY2Uga2VlcHMgcGV0dGluZyB0aGUNCj4gd2F0Y2hkb2cgZG9lcyBub3Qg
bWVhbiB0aGF0IHN5c3RlbSBpcyBub3Qgc3VmZmVyaW5nLg0KDQpUaGUgdXNlcnNwYWNlIHNob3Vs
ZCB2ZXJ5IG11Y2ggZG8gd2hhdCBpdCBkby4gQnV0IHdoZW4gaXQNCmRvZXMgbm90IGRvIHdoYXQg
aXQgc2hvdWxkIGRvLCBpbmNsdWRpbmcga2ljayB0aGUgV0QuIFRoZW4NCnRoZSBrZXJuZWwga2lj
a3MgaW4gYW5kIGtpbGwgYSBwcmUgZGVmaW5lZCBwcm9jZXNzIG9yIGFzIG1hbnkNCmFzIG5lZWRl
ZCB1bnRpbCB0aGUgbW9uaXRvcmluZyBjYW4gc3RhcnQgdG8ga2ljayBhbmQgaGF2ZSB0aGUNCmNv
bnRyb2wuDQoNCj4NCj4gSW4gYWRkaXRpb24gb29tIHByaW9yaXRpZXMgY2hhbmdlIGR5bmFtaWNh
bGx5IGFuZCBjaGFuZ2luZyBpdCBpbiB5b3VyDQo+IHN5c3RlbSBzZWVtcyB2ZXJ5IGhhcmQuIENn
cm91cCBhd2FyZW5lc3MgaXMgbWlzc2luZyB0b28uDQoNCldoeSBpcyB0aGF0IGhhcmQ/IE1vdmlu
ZyBhIG9iamVjdCBpbiBhIHJiLXRyZWUgaXMgYXMgZ29vZCBpdCBnZXQuDQoNCg0KPg0KPiBBbnl3
YXlzLCB0aGVyZSBhcmUgYWxyZWFkeSB3aWRlbHkgZGVwbG95ZWQgdXNlcnNwYWNlIG9vbS1raWxs
ZXINCj4gc29sdXRpb25zIChsbWtkLCBvb21kKS4gSSBhbSBhaW1pbmcgdG8gZnVydGhlciBpbXBy
b3ZlIHRoZQ0KPiByZWxpYWJpbGl0eS4NCg0KWWVzLCBhbmQgSSB0b3RhbGx5IGFncmVlIHRoYXQg
aXQgaXMgbmVlZGVkLiBCdXQgSSBkb24ndCB0aGluaw0KaXQgd2lsbCBwb3NzaWJsZSB1bnRpbCBs
aW51eCBpcyByZWFsdGltZSByZWFkeSwgaW5jbHVkaW5nIGENCm1lbW9yeSBzeXN0ZW0gdGhhdCBj
YW4gZ3VhcmFudGVlIGFsbG9jYXRpb24gdGltZXMuDQo=
