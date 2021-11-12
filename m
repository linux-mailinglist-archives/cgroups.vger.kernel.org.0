Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1A44EAC9
	for <lists+cgroups@lfdr.de>; Fri, 12 Nov 2021 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKLPsI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Nov 2021 10:48:08 -0500
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:35809
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234508AbhKLPsH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 12 Nov 2021 10:48:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5K3WQSWmdC7bEK1kdhCI4va9urIarj5BxFFyVDSmgeBRdvsKwkjFyBFr4F9uK0+VSgvuudbagFbsa61P/vMYy3uyuvSXM8i+srmFoQ99S8JcIQTqTgufe6KsADVeDiILRH+XBlli/tlEoFD6wxe9M//ueoAyecYR55Pw2hVD/rPk3YTO3Y47JfkHt0tZ96mQJlhulNmqEiXDi62kptxkM60TGlzhH9xAUf6c8ehS/nC2ZmVqr2PiqsNQgkNc1tjSGqp5xXaHWHu7MvnAZ6cm9G/9mPP8+CELJvCuCBGMm9GKasHD6PJG0RaTNXMNus+U2qP3BrQHNxCRPkCozenBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXYo28bRRFG5H61E6X9CXjNIvOxp/0wnYhKrrAevhAk=;
 b=XPXAQ5VEbKPhxjCIcskLSO/1duGzme3XWgYxAiKoF3FRI+GYrjZC5xgLUYvTsXl4oTQGUE5GLpU1UY8L5/180iyb/dZXSRwKdYjuHyrmKu+Cr2R7MLSGDKRzAklC5L7SYDTpvVBKDi3FIEyIYycPaLvV9PHxOjmFwxAit4LzL+1WvckPrkHHj7rpNUpN6xRoN9rKpIDOiurnk9decfe/XoP00arSingE5ssv4Vr/D1Y0yJMyX/s8C4VJt3XytVD5enoVNRZvCapLKGKgbf+XYQSEHiLbvvbBZ/TQP8iISjGIvhbFNLUtz3sFxR1n2n9LXceIcujaZN42+Cm6u1Lf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXYo28bRRFG5H61E6X9CXjNIvOxp/0wnYhKrrAevhAk=;
 b=HZ3StQm09NfZRphN8UCLCu32UWNMdk1JYYMq6amfwK99pGPMluA/F+lvRiTpLRkd3IJMrqh2cDXZBVvqOnaflqTLVW3rdGMvbHw6TiX8nXM0oBEnZ5EiVK0CuVknVRC02+33Jx04jTeVjfjnUNxlo19RKrKzhR3Je4a4vpNShJ7gzEzIzLaSndDjPGu/lOyeeig9tH/EJ0JiWNxOZA01vWW+mQgE7TS9D537a8iCGx3Wt3P9Gsj5iXqklG6dSMMY2fJT+21fGWbQpfdCZhdIEKerCzN2L0LBglJGuloW1QsaFu1kSVe/OnWAX9v25xqyVQNNVS1VWBcYyxB5LfnLbQ==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by AM0PR10MB2052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 15:45:13 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd5b:fde0:8141:2c4e]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb%8]) with mapi id 15.20.4690.015; Fri, 12 Nov 2021
 15:45:13 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: Questions about replacing isolcpus by cgroup-v2
Thread-Topic: Questions about replacing isolcpus by cgroup-v2
Thread-Index: AdfRoQau9QpbKiacQpSAjNJcfArMZQGOhj8AAAAzcsA=
Content-Class: 
Date:   Fri, 12 Nov 2021 15:45:12 +0000
Message-ID: <AM9PR10MB4869F9A2D7F5F95C29B5521889959@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
References: <AM9PR10MB48692A964E3106D11AC0FDEE898D9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211112153656.qkwyvdmb42ze25iw@linutronix.de>
In-Reply-To: <20211112153656.qkwyvdmb42ze25iw@linutronix.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-11-12T15:45:11Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=7a7c7db0-b0c8-48a2-823d-759f4371fb32;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 367da66d-60b3-40fa-ce53-08d9a5f36a6c
x-ms-traffictypediagnostic: AM0PR10MB2052:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: <AM0PR10MB2052A09B71084B43451DA2DF89959@AM0PR10MB2052.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pS5UC5mGVtTFF/tDaN69yosiT8PyhRvDCoG9I3daiSk2BA7hhS3Sn6hlB0IhZJIv4ZMOzL6HNKfWyiSMGsOt7IKnMJLs3W5kez5a8D2HGn//0xqaD49lPK16307PL8EBHk7am7PeEv+TZZjt0ApXaDgjRwzOGYV1ByPfKzSTjSopn6Diltvz7nk0/g2eX1J6OTy1+mBRdE+yhMJHvoh/U2X2d82LUTQw0nz0I2l5hgb5EsN4jvmJHWbvHIND+jXXQefzHd3ugSVgd+WWT48Dfv6j1UcmR6RZWszkiRd0dIkbyonOpfB51T2MKt90rtMHVil1GJjTie158LO3ynBHN3jMv9+LuruZ0FhF0BbYFLpcbYPEfbm3gkeiSC8CgHKHq+wCrgbpa2FPCzkvbZ/EspNulbc6RWZ4QPEOX2gi+t/ZU42b97pjb960jcT5eQaTH9rj9ZNLfmV5Fuw8+ejVmZ3X9s+JojS6aD8CstgX1zIomPh3LFyyRzEtxSajghjr9hHZxPZN6EqbV9nlKJQGUg5EYu/Zt+cx8tt6Uo1iBJo1hzHnF0trR39v9O8guUEns0prFcXMmTq39LiQd4af7SyEA3K40Wb4qjs8PobYqCLyDVLDrn0ny0oZbfMTK35ugt+WRKNjV7+lRY4aSfi5/qgp5gTPps+fxI8ahHQ9DX3uL14qKaruorhLUIKkrCt2U3P9HalbNCmghuor2V+y/b+fLSyTwpA91DMFFUu+wCSQUQTn4SENIPpmu/TGmatcLeqT0REyIhema8ZhF9Uhgj0TSC7DGQ/2+Oq0i6Lcu/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(71200400001)(122000001)(26005)(38100700002)(186003)(33656002)(86362001)(966005)(316002)(38070700005)(52536014)(7696005)(82960400001)(5660300002)(4326008)(66556008)(66476007)(508600001)(110136005)(54906003)(64756008)(66446008)(83380400001)(66946007)(53546011)(6506007)(55016002)(8676002)(76116006)(8936002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTRxcEFUY3Z4YWZaSjZDSVl2RThyNS9TeGRwbnY3K3VHODZDT01CajRoMys1?=
 =?utf-8?B?WUIxeGFWUEI3MU5DSXRqYnlWT3FjbmFTNGRKSUtaODVlcS9LQWJOak5tL212?=
 =?utf-8?B?SmRMZWdBRGowNmJ0MFZaL0lORERQU29MMHlZVUFSQkxxRCtGaDM3WGwxUmND?=
 =?utf-8?B?QlVvZU9ua2tlZkZITWpON2FLbE1ITDlkWkllaGs2YlROdjBmODBYN1ZiRXpj?=
 =?utf-8?B?cU55WUtYdmJwcjhyaWdDSVA1MjR3N2FiZHl3bU96NnNZbnd1K3V5RTN0a09M?=
 =?utf-8?B?QXovemJ6eDc4ZjNhb3R0L212cHUxcENWd3o5UXVGb1IwRzMyQTRWcmszMjJh?=
 =?utf-8?B?OUVZUTVnWWtxcVYwM2w0NVFjZm1KZ0h1OTJVOFF3eDBITVFQSE5nSUNNc0VQ?=
 =?utf-8?B?cGk4SSt3UlNad0N2TDlFWW1GakdVSUdNTmVZTjI0d2ZIdk90TlVoSjcyVnZy?=
 =?utf-8?B?VStzMkRhSjV0T3owUnFuVDByY0RmVUdMeC9pd3A2aXNKdFNZd0QrOGs3SzNR?=
 =?utf-8?B?d25UVitMTjBYWWtCNWdXN0lCU00zYnZrRXhpSGc4bzk2SjVGRytISml6Vm91?=
 =?utf-8?B?eVdOSWRKY3Z6SzBBRlJiMkZJVGMrSFZZUy9KNSt1TG9sdjBKeFR5ZENVTHJh?=
 =?utf-8?B?Ym9Ba080Vlg0L2djcFRWZUR3RWJFZWJCcWgvTHdKYVUrYkFpK09tbGp3SWda?=
 =?utf-8?B?WXdBamVScWUvMzFIZGorOS9RRTErVUt0OVhiY014QjVna0crdXFuYWhRYXE2?=
 =?utf-8?B?U1AzZXZkM1k3a2hrYlJRV0VtcVovK3pITDRHc2NqbW40TVA5eWlvZStpMlla?=
 =?utf-8?B?Vmx6em9XVFk4aktYZkJ2Z2RCaWtLVFNHc2JuY0IvS2JLOUNjWXZQc05aSmd5?=
 =?utf-8?B?M1JEQVhvcTZZeXdPZ08wd09WOFJhY2RMT0FTNHFnZWdxWTNwQ0pqSGFlaGhO?=
 =?utf-8?B?M3Mwek5qRnU5OWszclVsWnNKWW9LVlUyTEdmVk8vNzRLNU11dm85b0dRdmxa?=
 =?utf-8?B?emxvZnZuS2x0RE5DZk5yNzFtelFUT1B6NlVaUEhwdTdYYzlpR1p3ckc3YzNl?=
 =?utf-8?B?R3FtS2Rnd1VPTzVabUdJRlY4MEtVY2dyV0tLaHhJbVBnTGVRMlNaRWlVVi9r?=
 =?utf-8?B?SzQ2aml3dHBsT09ieEp3VTFkd3BweUc0aWhha0V1c3oyeksrNStWdTlPNmdP?=
 =?utf-8?B?dld0QUVDUENRZFA2NGwvTTh0THV0SVQ1R0Y3SjhVbE1qcU5SeUJ3dHpqVHRq?=
 =?utf-8?B?b1ZJWFdrUEFGRTgrMTFsTm12OWthUVZiMUw3aWp3S0N5TFJlYWVMcVJob3gx?=
 =?utf-8?B?ZFZHOWVxVENLNjFHSHJBSU81NVNPcURCeW9mam9VWklCekZtQXRXbjZqWTZn?=
 =?utf-8?B?SkRSdUhhRnNqcUlVWnl6NzNDNmpSd3kwSWJFVkgxQitkZEFrNkJQYWVrS0Nz?=
 =?utf-8?B?NDNuZlNuZDQxaFZtdXpGSnU1T1JOL0o3eUN0K2s1bkNUZHhJQlJHVzR2ZlJ2?=
 =?utf-8?B?VjJJVXp3R01lR1BUZUV0eElsZFRvUEtYOHl0VUJkeWt2a2kydWdrc2lON0hw?=
 =?utf-8?B?NXlWYzVVd3JoNkNOMllOS3h3cmVDQ1cvSGVrbCt0M25aNGtRSHR5Wm0yZVBB?=
 =?utf-8?B?NE1FY1Q5UWRCUTFUQVJ0ZmpuaXJDTmhYT0Y5YXovSW05Y2h1ditwaFBaa01y?=
 =?utf-8?B?MVc3SUdvVW1qTllnQlpaZ3plRk90UDYrb0JKR0djQTlkbER3WHhZeGlOaXZH?=
 =?utf-8?B?K0F3SlNDY0h3SS9FamJUbS9OZCtSTFNZOVZRWllyWlh1bUI5dUlkam9NcFd2?=
 =?utf-8?B?R1hCWHM4djI5VmdrZGg5YlNwNW5OQXdHNjduN2RPcnVXWXdSOUJQcFgxNndV?=
 =?utf-8?B?Z0oxd3pZa2U4cXR6anZrWmI5alN4dEFXWjZEWm40ZGxhcWp3Mzh4NVhVUy9R?=
 =?utf-8?B?dEtzWmFVZ3pkVVZmRkVLR00zUms3Qk5YMmYwNEg5b2RTTzNkQTRIWTEvSDNk?=
 =?utf-8?B?YndEODBvZHlvZi92MGV5TTQrNnRWY045YmZIb1hnRjhGZXR6bmFnVTdaUFhF?=
 =?utf-8?B?SDdBWkJ5WEduTC9tTUdFWnEzekJ5YWk3dllra0hFd3c4L3pKbFVuT3N6b2FX?=
 =?utf-8?B?Z1JHNm9ld0RSTDZYR1huSkhtY2pnMFB1Z2xzdmd2Z2FXMnR0aHVyZFBjeXJ2?=
 =?utf-8?B?alF3cXdDWEZqSGxva0lqb3VGSEQyUG5XbDBVS2wrdVp2WGkzVmk1cHhLNjA1?=
 =?utf-8?B?ZlByTlFXcDQ5OFp3UncvZ1JuMU5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 367da66d-60b3-40fa-ce53-08d9a5f36a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 15:45:12.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOXfjg5hpzCuGLT++jgfxfuseOt7B9TRw7nxZy6Qzny1Ko0xyJrPHUy3TbIm0eJP/PKwC+8j8yxCOmB/xW/bpaNZ9FKmYxsi3TclvwMwGCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2052
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNl
YmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxMiwgMjAyMSA0OjM3IFBNDQo+IFRvOiBNb2Vzc2JhdWVyLCBGZWxp
eCAoVCBSREEgSU9UIFNFUy1ERSkgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+Ow0KPiBj
Z3JvdXBzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtcnQtdXNlcnNAdmdlci5rZXJuZWwu
b3JnOyBTY2hpbGQsIEhlbm5pbmcgKFQgUkRBIElPVCBTRVMtREUpDQo+IDxoZW5uaW5nLnNjaGls
ZEBzaWVtZW5zLmNvbT47IEtpc3prYSwgSmFuIChUIFJEQSBJT1QpDQo+IDxqYW4ua2lzemthQHNp
ZW1lbnMuY29tPjsgU2NobWlkdCwgQWRyaWFhbiAoVCBSREEgSU9UIFNFUy1ERSkNCj4gPGFkcmlh
YW4uc2NobWlkdEBzaWVtZW5zLmNvbT47IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBRdWVzdGlvbnMgYWJvdXQgcmVwbGFjaW5nIGlzb2xj
cHVzIGJ5IGNncm91cC12Mg0KPiANCj4gT24gMjAyMS0xMS0wNCAxNzoyOTowOCBbKzAwMDBdLCBN
b2Vzc2JhdWVyLCBGZWxpeCB3cm90ZToNCj4gPiBEZWFyIHN1YnNjcmliZXJzLA0KPiBIaSwNCj4g
DQo+IEkgQ2NlZCBjZ3JvdXBzQHZnZXIgc2luY2UgdGh1cyBxdWVzdGlvbiBmaXRzIHRoZXJlIGJl
dHRlci4NCj4gSSBDY2VkIEZyZWRlcmljIGluIGNhc2UgaGUgaGFzIGNvbWUgY2x1ZXMgcmVnYXJk
aW5nIGlzb2xjcHVzIGFuZCBjZ3JvdXBzLg0KDQpJbmRlZWQuIFRoYW5rcyENCg0KPiANCj4gPiB3
ZSBhcmUgY3VycmVudGx5IGV2YWx1YXRpbmcgaG93IHRvIHJld29yayByZWFsdGltZSB0dW5pbmcg
dG8gdXNlIGNncm91cC12Mg0KPiBjcHVzZXRzIGluc3RlYWQgb2YgdGhlIGlzb2xjcHVzIGtlcm5l
bCBwYXJhbWV0ZXIuDQo+ID4gT3VyIHVzZS1jYXNlIGFyZSByZWFsdGltZSBhcHBsaWNhdGlvbnMg
d2l0aCBydCBhbmQgbm9uLXJ0IHRocmVhZHMuIEhlcmVieSwgdGhlDQo+IG5vbi1ydCB0aHJlYWQg
bWlnaHQgY3JlYXRlIGFkZGl0aW9uYWwgbm9uLXJ0IHRocmVhZHM6DQo+ID4NCj4gPiBFeGFtcGxl
IChSVCBDUFU9MSwgNCBDUFVzKToNCj4gPiAtIE5vbi1SVCBUaHJlYWQgKEEpIHdpdGggZGVmYXVs
dCBhZmZpbml0eSAweEQgKDExMDFiKQ0KPiA+IC0gUlQgVGhyZWFkIChCKSB3aXRoIEFmZmluaXR5
IDB4MiAoMDAxMGIsIHZpYSBzZXRfYWZmaW5pdHkpDQo+ID4NCj4gPiBXaGVuIHVzaW5nIHB1cmUg
aXNvbGNwdXMgYW5kIGNncm91cC12MSwganVzdCBzZXR0aW5nIGlzb2xjcHVzPTEgcGVyZmVjdGx5
DQo+IHdvcmtzOg0KPiA+IFRocmVhZCBBIGdldHMgYWZmaW5pdHkgMHhELCBUaHJlYWQgQiBnZXRz
IDB4MiBhbmQgYWRkaXRpb25hbCB0aHJlYWRzIGdldCBhDQo+IGRlZmF1bHQgYWZmaW5pdHkgb2Yg
MHhELg0KPiA+IEJ5IHRoYXQsIGluZGVwZW5kZW50IG9mIHRoZSB0aHJlYWRzJyBwcmlvcml0aWVz
LCB3ZSBjYW4gZW5zdXJlIHRoYXQgbm90aGluZyBpcw0KPiBzY2hlZHVsZWQgb24gb3VyIFJUIGNw
dSAoZXhjZXB0IGZyb20ga2VybmVsIHRocmVhZHMsIGV0Yy4uLikuDQo+ID4NCj4gPiBEdXJpbmcg
dGhpcyBqb3VybmV5LCB3ZSBkaXNjb3ZlcmVkIHRoZSBmb2xsb3dpbmc6DQo+ID4NCj4gPiBVc2lu
ZyBjZ3JvdXAtdjIgY3B1c2V0cyBhbmQgaXNvbGNwdXMgdG9nZXRoZXIgc2VlbXMgdG8gYmUgaW5j
b21wYXRpYmxlOg0KPiA+IFdoZW4gYWN0aXZhdGluZyB0aGUgY3B1c2V0IGNvbnRyb2xsZXIgb24g
YSBjZ3JvdXAgKGZvciB0aGUgZmlyc3QgdGltZSksIGFsbA0KPiBkZWZhdWx0IENQVSBhZmZpbml0
aWVzIGFyZSByZXNldC4NCj4gPiBCeSB0aGF0LCBhbHNvIHRoZSBkZWZhdWx0IGFmZmluaXR5IGlz
IHNldCB0byAweEZGRkYuLi4sIHdoaWxlIHdpdGggaXNvbGNwdXMgd2UNCj4gZXhwZWN0IGl0IHRv
IGJlICgweEZGRkYgLSBpc29sY3B1cykuDQo+ID4gVGhpcyBicmVha3MgdGhlIGV4YW1wbGUgZnJv
bSBhYm92ZSwgYXMgbm93IHRoZSBub24tUlQgdGhyZWFkIGNhbiBhbHNvIGJlDQo+IHNjaGVkdWxl
ZCBvbiB0aGUgUlQgQ1BVLg0KPiA+DQo+ID4gV2hlbiBvbmx5IHVzaW5nIGNncm91cC12Miwgd2Ug
Y2FuIGlzb2xhdGUgb3VyIFJUIHByb2Nlc3MgYnkgcGxhY2luZyBpdCBpbiBhDQo+IGNncm91cCB3
aXRoIENQVXM9MCwxIGFuZCByZW1vdmUgQ1BVPTEgZnJvbSBhbGwgb3RoZXIgY2dyb3Vwcy4NCj4g
PiBIb3dldmVyLCB3ZSBkbyBub3Qga25vdyBvZiBhIHN0cmF0ZWd5IHRvIHNldCBhIGRlZmF1bHQg
YWZmaW5pdHk6DQo+ID4gR2l2ZW4gdGhlIGV4YW1wbGUgYWJvdmUsIHdlIGhhdmUgbm8gd2F5IHRv
IGVuc3VyZSB0aGF0IG5ld2x5IGNyZWF0ZWQNCj4gdGhyZWFkcyBhcmUgYm9ybiB3aXRoIGFuIGFm
ZmluaXR5IG9mIGp1c3QgMHgyICh3aXRob3V0IGNoYW5naW5nIHRoZSBhcHBsaWNhdGlvbikuDQo+
ID4NCj4gPiBGaW5hbGx5LCBpc29sY3B1cyBpdHNlbGYgaXMgZGVwcmVjYXRlZCBzaW5jZSBrZXJu
ZWwgNS40Lg0KPiANCj4gV2hlcmUgaXMgdGhpcyB0aGUgZGVwcmVjYXRpb24gb2YgaXNvbGNwdXMg
YW5ub3VuY2VkLyB3cml0dGVuPw0KDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xh
dGVzdC9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy5odG1sDQppc29sY3B1cz0gICAgICAg
W0tOTCxTTVAsSVNPTF0gSXNvbGF0ZSBhIGdpdmVuIHNldCBvZiBDUFVzIGZyb20gZGlzdHVyYmFu
Y2UuDQogICAgICAgICAgICAgICAgICAgICAgICBbRGVwcmVjYXRlZCAtIHVzZSBjcHVzZXRzIGlu
c3RlYWRdDQogICAgICAgICAgICAgICAgICAgICAgICBGb3JtYXQ6IFtmbGFnLWxpc3QsXTxjcHUt
bGlzdD4NCg0KPiANCj4gPiBRdWVzdGlvbnM6DQo+ID4NCj4gPiAxLiBXaGF0IGlzIHRoZSBiZXN0
IHN0cmF0ZWd5IHRvICJpc29sY3B1cyIgc2ltaWxhciBzZW1hbnRpY3Mgd2l0aCBjZ3JvdXBzLXYy
Pw0KPiA+IDIuIElzIHRoZXJlIGEgd2F5IHRvIHNwZWNpZnkgdGhlIGRlZmF1bHQgYWZmaW5pdHkg
KHdpdGhpbiBhIGNncm91cCkNCj4gPg0KPiA+IFdlIGFyZSBjdXJyZW50bHkgYXQgYSBwb2ludCB3
aGVyZSB3ZSB3b3VsZCB3cml0ZSBwYXRjaGVzIHRvIGFkZCBhIGRlZmF1bHQNCj4gYWZmaW5pdHkg
ZmVhdHVyZSB0byBjcHVzZXRzIG9mIGNncm91cHYyLg0KPiA+IEJ1dCBtYXliZSB0aGF0IGlzIG5v
dCBuZWVkZWQgb3Igd291bGQgYmUgdGhlIHdyb25nIGRpcmVjdGlvbiwgc28gd2Ugd2FudGVkDQo+
IHRvIGRpc2N1c3MgZmlyc3QuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gRmVsaXggTcO2
w59iYXVlcg0KPiA+IFNpZW1lbnMgQUcNCj4gDQo+IFNlYmFzdGlhbg0KDQpCZXN0IHJlZ2FyZHMs
DQpGZWxpeA0K
