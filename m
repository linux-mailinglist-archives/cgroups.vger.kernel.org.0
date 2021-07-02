Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72AA3B9E14
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 11:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGBJZ3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 05:25:29 -0400
Received: from mail-eopbgr1310115.outbound.protection.outlook.com ([40.107.131.115]:36043
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230078AbhGBJZ2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Jul 2021 05:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdA8OBggWaR0UrHmfuZ++NhEZOVqYl06hjESgdIoeU1INnQmatkW3cl1pg7gbivIl0e1wrBPH8ZSr7dm8chP7BF3LtDoQccGvRpqTMJDY0a0LsqYkVc7w1XmPNAXZuNe9BhzaFUQRcca3PAuaFXtsmeMgGp9jthtLfBj8noHlnuEYZIR53nN6W9O6/ymO8XDdqlm1O985RtCkuOReoREMOTZmZhucaWH8sSrjmSN2pmJSEryC8XL7PCgyhmBG6OSNsOZFtbB3mpzuBoHBoTOMu6fcCyG34hByUEgg1FRP5zS62kmaP/pUaPZ7I1mXrJYME16Ye6P4mGxWusHP42LEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wodV1s0I/maPBygvJW5DQaUaiXras6T40vRKZerzfMQ=;
 b=fnCR38FAnxb2bOKPBcx29QC7x80Xv50bxkzmpMRVm0ElxsWO28g7wRrzDyO7c3Vd3wBqxzaZq/NdGEPZjQAHqxbw3/CGblT6+oR58NrhpuAPMxstOrZ2Oq+YtDU05pTMP+pwgl12jJ1S6boTCYdMySUrE5ABLOOXJc84Zi4VLOQ+c8u61Z4kZY/rlLqJQ0Z8bLrR0/QS9619PAG9810mgIo5LzmMUIYSzbkQ8H+BT3/c4rYEJrcTs/y4mSFjx9BxV4oZWV1eo22EGdcpOG7OjogP3bKY4WkN2IEWRe1z4lr0NQ5G9kqApA49LRlQLRW9uj9VpCcNNv+x51ArKmp3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wodV1s0I/maPBygvJW5DQaUaiXras6T40vRKZerzfMQ=;
 b=kzEjmM+DL/zHV6Md6NQ1vhVS34SMnt2aKyItL/FWgv3Ua9X+XgNRTsastQpCHK7T540DAbjBZlTbQyBXuKr8awcI7rzGWy2jVNMmuQuTEY6beIerUf5lTKRQ/t4bP7H1wxzK098Stf+gqPRqwQSkC3fFD0NKfeeeQcebnWmdIffGsj97sFc5SVrF+GUvnhc1C9AmtPCPkvqYI4XawypCIYSEFNzCSkU0nTlQpFmzZPEg06vPUxJmsj24pEt0+FnOpXW42FTPUfqEmC70jXdKCb9IBM7i1PZsSEbbahnoDtXGhs2grBa3sGFqQrKpi69Wg7UTe1Bh/uRyRCenVK5UEA==
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR0201MB2136.apcprd02.prod.outlook.com (2603:1096:802:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Fri, 2 Jul
 2021 09:22:54 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b%3]) with mapi id 15.20.4287.023; Fri, 2 Jul 2021
 09:22:54 +0000
From:   =?utf-8?B?6IuP6L6JKFJvYmVydCBTdSk=?= <suhui@zeku.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGNncm91cC9waWQ6IGZpeCB0aGUgcGlkX2NncnAg?=
 =?utf-8?Q?attach_bug_in_cgroup_v2?=
Thread-Topic: [PATCH] cgroup/pid: fix the pid_cgrp attach bug in cgroup v2
Thread-Index: AQHXbyNuISG2pRPN+kqlkqyFUCZ2c6svaUKg
Date:   Fri, 2 Jul 2021 09:22:54 +0000
Message-ID: <KL1PR02MB4788DAF33A1D396F51609C22C61F9@KL1PR02MB4788.apcprd02.prod.outlook.com>
References: <20210702091844.737784-1-suhui@zeku.com>
In-Reply-To: <20210702091844.737784-1-suhui@zeku.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=zeku.com;
x-originating-ip: [58.255.79.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acfd698c-6f56-4ee0-dceb-08d93d3af94e
x-ms-traffictypediagnostic: KL1PR0201MB2136:
x-microsoft-antispam-prvs: <KL1PR0201MB2136B06236FACA85422EA953C61F9@KL1PR0201MB2136.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +M0YQ0mx5FQNs1dE5rnL2sGRmplhmboU+fQBUHqOFkHlRYtCDmraMvJfMCm5VnwGIj9kiog7fyGNuVFUJLTMeiPubQvpNc7C+GpMzbzg5EslMn8BlglvUAZXRNJANm5jzD3bElRk5BVhnwij7sK5MLmJ57dwHLKk68U5X7mMMCkURZiqY3F5Nl6qrdYUydqQiOiGr2z5PypVGm1t5tE8KhHbxTPbm1nTZuds1Z875lC6h0oqLbHjtTkIqSI6Od5SUqSKPj5fJVe10ZgHgIuaR3su3itiV5Py2bvarLkEOa/d7JDMZecnH9O4UB4RuVtGsc9ScDxNFJMPGfVZOo3yPYxSTddwnp15dqV5V/ANLJiGUVdLHiE2j0xOyhLfRWySFtmxU9lR+Gir3JHPeoLQhP4888I6U2mOoB8pWcZ798x3NSNWu+cRMboJtvFxe7bceumfizEi/vABKW+t0EjzOhuLtHh+NK+2RehHVObPcZk/ojG5ojuGr0k2/2imqRcV/81zcx127YD//t5aAOlmhxvLT2ilCq+gZ2gBGsxbMHa9ztyOjY89vPJP259JaZvpyFAgVKgYWpSgkItS16m+XWs+IM9BdyJzjoIgIDUFzHo8LLHxhpIMzW1jE0MNBj7UH0xckf9nqpKD5lk0Qhv7hYQtY+cZf+qGWJH3fwXxTs0yzF74WGmNq8n+s/QCD7ku
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(136003)(366004)(396003)(346002)(76116006)(2906002)(5660300002)(6506007)(66446008)(83380400001)(66946007)(64756008)(33656002)(478600001)(26005)(8936002)(122000001)(66556008)(186003)(71200400001)(66476007)(52536014)(7696005)(224303003)(316002)(86362001)(55016002)(38100700002)(85182001)(110136005)(9686003)(11606007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZZb0puZlROS25sblRXVTNZNXB1d29HelB4cEtjSGUyWHVTbUg5OHVEM1VD?=
 =?utf-8?B?VTA0RmZ3OVIyeHh0eE5VdldsbGlzTnFBMERzTW5aMHV4Uit0bjR3azZTNlly?=
 =?utf-8?B?dkp5MEhPMDJZN056aHU4NkN3bEYyQW05ZGFPWlpoZVZWVk8vZHV3aXZIN2Jt?=
 =?utf-8?B?NnF6T0JpMGV3ZHlBRXdPZHJVOHFSazVqcmpUajI2YjhJM2NWclEvSm9FRHRx?=
 =?utf-8?B?a1VLYzgrNHF2ZlovcVI5cWhMV2Y4OGxFVkEyMHBYMldDSWdzMmdDM1JpZWdC?=
 =?utf-8?B?VHVUMHRRb1lJTk55QThYNWxLSXVzZmUyZ1RPcmtjbHNNaC9lUXlVeDhFOGQ5?=
 =?utf-8?B?U1lBa1E3RDZxQkZGcmE2YXNYSEFmRktoV2hoRVpKVnE1NExxckQ4cHlDNFlJ?=
 =?utf-8?B?SXU5QWxmWTVQa0J4b1l0Mld4WXdRbDdzTGg2bnFlMmppL2FvWHhyaEY5bVNL?=
 =?utf-8?B?NzQ4RzFpRjVUaURDSVk2VHBRWW9qK2wvN1JYbGtRYUlmWjVwYVlDZ29ZNEE0?=
 =?utf-8?B?dnczS3B4R1Q2bTJZTkdkeXZRU3A5TTl3VDNMZjFCenZhSHJBRFVEQjIwdEF0?=
 =?utf-8?B?ajB5QXZ0TGVwVXl2RnlQNGdiMHp6U0V2TG9yaFVpWWxnUVdIOHduZ0Y3SVZL?=
 =?utf-8?B?TmovaWNQREhIUDRxOFBBRVFMdGJmK1I4ejBkZ2hLam5FUFhQb2JSVDBqRWhL?=
 =?utf-8?B?b0JFbGhMUC9PRzVuNUZ6aGp1UC84VGJyUkFVcE11cjlhWXpQQmQybTBiREVo?=
 =?utf-8?B?NXZza0lsSm95S3FVV0FOUFpqbDBlbHdibVR6OHNORFMzMHhFYkZEb0lGM3Z0?=
 =?utf-8?B?Q1ZVOXI2M3Vzck1qU1A2aDhhVkZPdHY0ZElWekNKbW5rRGlFZExBSzI3SmpG?=
 =?utf-8?B?bEdXWUcvSk45eCtXSWhFYVhycEVzbHA3MnRSN1RxcWtCYWxSTElEU2VReTRW?=
 =?utf-8?B?bnR4QjlVWFhCTTZRUXJzaGptdnlpWkpBK0U5MGRsNjhOL3V2bzVnL2lUb2I0?=
 =?utf-8?B?SHgxaUY5RUJXcjlIT1BhWnpnakNZYVpjQ050Z3BiUldVTHVkc3gxbGRkc2JY?=
 =?utf-8?B?TUdGd0tKZWNWZFJ3T3E1M2hOQkN3V3RHSEIrVHBCWmxKWXlvbmkwK2lTc21j?=
 =?utf-8?B?VGdvTnN0OTFqVzdFZmVtbGN2c3NGS3ZuYTY0YzBKcVoxcVVKcVZjbVBJejFJ?=
 =?utf-8?B?NE10dnpoR3RRZWVEQWRTYWVrNmlVVjFCc09ibDF0ZUpsZitNRVptS3RkcDBJ?=
 =?utf-8?B?bGd6Qi9aUDI2UHRYdjVubFl4ZUlnT1VhRGkreEtXNVdGVlArQ0E2amlHS1Fx?=
 =?utf-8?B?ZjdGMWdMS0tGby8rSXJDYjluZi9ZdHk1cnlZRGRkUk5PK3NJNzVBMWNwbkNa?=
 =?utf-8?B?K3VlN3FsSk15M3Rmd1lMOE85aWExY05lVU1wcno2VStsQVExUFREdndndHht?=
 =?utf-8?B?Ykh6RWlNdi9GR0VOSWJUTkVYRkZQRXREeldmN2VyUVZCcWR3V0ladlBpRk5E?=
 =?utf-8?B?dWprUEM5ZXNSa3ZRblpaemVnN3p4RzJNbUtacmd3emxOQW1KcXVhQWVCdUxM?=
 =?utf-8?B?NnREZytTdUdkNzFTMTVaeHlrSkg0OWs0MWFGYXFoRU4xUnE0Zk40KzZKa0xm?=
 =?utf-8?B?NTBlcWdnbFcydGFtb1M4OEJQUnRaeHRCRW8xZWlNM2FjMC9OR0g4SUJDN0F1?=
 =?utf-8?B?QzVGd2N3RlBFM3RxQktMWTZZYVZ6RlpRS1FuL2t6NEg5ZkY4bkpsOGVnbkor?=
 =?utf-8?Q?uo87SW9RfnOwe0rutw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfd698c-6f56-4ee0-dceb-08d93d3af94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 09:22:54.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kc9xKns3KtYt7OeOJAuBpG8dLsWHhDI4d9dl7skXdwBC9KvjGIvsuu5jJXV6ZTpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0201MB2136
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBjaGFuZ2UuLi4NCg0KLS0tLS3pgq7ku7bljp/ku7Yt
LS0tLQ0K5Y+R5Lu25Lq6OiDoi4/ovokoUm9iZXJ0IFN1KSA8c3VodWlAemVrdS5jb20+IA0K5Y+R
6YCB5pe26Ze0OiAyMDIx5bm0N+aciDLml6UgMTc6MTkNCuaUtuS7tuS6ujogdGpAa2VybmVsLm9y
ZzsgbGl6ZWZhbi54QGJ5dGVkYW5jZS5jb207IGhhbm5lc0BjbXB4Y2hnLm9yZzsgY2dyb3Vwc0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuaKhOmAgTog6IuP
6L6JKFJvYmVydCBTdSkgPHN1aHVpQHpla3UuY29tPg0K5Li76aKYOiBbUEFUQ0hdIGNncm91cC9w
aWQ6IGZpeCB0aGUgcGlkX2NncnAgYXR0YWNoIGJ1ZyBpbiBjZ3JvdXAgdjINCg0KcGlkc19jYW5f
YXR0YWNoKCkgc2hvdWxkIG1ha2Ugc3VyZSB0aGUgcGlkcy0+Y291bnRlciBub3QgYmlnZ2VyIHRo
YW4gcGlkcy0+bGltaXQsIHNvIHdlIHNob3VsZCB1c2UgcGlkc190cnlfY2hhcmdlKCkgaGVyZS4N
Cg0Kd2l0aG91dCB0aGUgY2hhbmdlOg0Kcm9vdEB0ZXN0Oi9zeXMvZnMvY2dyb3VwL3Rlc3QjIGNh
dCBwaWRzLm1heA0KMw0Kcm9vdEB0ZXN0Oi9zeXMvZnMvY2dyb3VwL3Rlc3QjIHNsZWVwIDEwMDAg
JiBbMV0gMzM3OSByb290QHRlc3Q6L3N5cy9mcy9jZ3JvdXAvdGVzdCMgc2xlZXAgMTAwMCAmIFsy
XSAzMzgwIHJvb3RAdGVzdDovc3lzL2ZzL2Nncm91cC90ZXN0IyBzbGVlcCAxMDAwICYgWzNdIDMz
ODEgcm9vdEB0ZXN0Oi9zeXMvZnMvY2dyb3VwL3Rlc3QjIHNsZWVwIDEwMDAgJiBbNF0gMzM4MiBy
b290QHRlc3Q6L3N5cy9mcy9jZ3JvdXAvdGVzdCMgZWNobyAzMzc5ID4gY2dyb3VwLnByb2NzIHJv
b3RAdGVzdDovc3lzL2ZzL2Nncm91cC90ZXN0IyBlY2hvIDMzODAgPiBjZ3JvdXAucHJvY3Mgcm9v
dEB0ZXN0Oi9zeXMvZnMvY2dyb3VwL3Rlc3QjIGVjaG8gMzM4MSA+IGNncm91cC5wcm9jcyByb290
QHRlc3Q6L3N5cy9mcy9jZ3JvdXAvdGVzdCMgZWNobyAzMzgyID4gY2dyb3VwLnByb2NzIHJvb3RA
dGVzdDovc3lzL2ZzL2Nncm91cC90ZXN0IyBjYXQgcGlkcy5tYXgNCjMNCnJvb3RAdGVzdDovc3lz
L2ZzL2Nncm91cC90ZXN0IyBjYXQgcGlkcy5jdXJyZW50DQo0DQpyb290QHRlc3Q6L3N5cy9mcy9j
Z3JvdXAvdGVzdCMgY2F0IGNncm91cC5wcm9jcw0KMzM3OQ0KMzM4MA0KMzM4MQ0KMzM4Mg0Kcm9v
dEB0ZXN0Oi9zeXMvZnMvY2dyb3VwL3Rlc3QjDQoNCndpdGggdGhpcyBjaGFuZ2U6DQpyb290QHRl
c3Q6L3N5cy9mcy9jZ3JvdXAvdGVzdCMgY2F0IHBpZHMuY3VycmVudA0KMw0Kcm9vdEB0ZXN0Oi9z
eXMvZnMvY2dyb3VwL3Rlc3QjIGNhdCBwaWRzLm1heA0KMw0Kcm9vdEB0ZXN0Oi9zeXMvZnMvY2dy
b3VwL3Rlc3QjIGNhdCBjZ3JvdXAucHJvY3MNCjI2MTQNCjM2ODMNCjM2ODQNCnJvb3RAdGVzdDov
c3lzL2ZzL2Nncm91cC90ZXN0IyBzbGVlcCAxMDAwMCAmIFs1XSAzNzMzIHJvb3RAdGVzdDovc3lz
L2ZzL2Nncm91cC90ZXN0IyBlY2hvIDM3MzMgPiBjZ3JvdXAucHJvY3MNCmJhc2g6IGVjaG86IHdy
aXRlIGVycm9yOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZSByb290QHRlc3Q6L3N5
cy9mcy9jZ3JvdXAvdGVzdCMgY2F0IGNncm91cC5wcm9jcw0KMjYxNA0KMzY4Mw0KMzY4NA0Kcm9v
dEB0ZXN0Oi9zeXMvZnMvY2dyb3VwL3Rlc3QjIGNhdCBwaWRzLmN1cnJlbnQNCjMNCnJvb3RAdGVz
dDovc3lzL2ZzL2Nncm91cC90ZXN0IyBkbWVzZyB8dGFpbCAtbiAxIFsgIDg2My42MTIxNjJdIGNn
cm91cDogYXR0YWNoIHJlamVjdGVkIGJ5IHBpZHMgY29udHJvbGxlciBpbiAvdGVzdA0KDQpTaWdu
ZWQtb2ZmLWJ5OiBIdWkgU3UgPHN1aHVpQHpla3UuY29tPg0KLS0tDQoga2VybmVsL2Nncm91cC9w
aWRzLmMgfCAxMSArKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvY2dyb3VwL3BpZHMuYyBiL2tl
cm5lbC9jZ3JvdXAvcGlkcy5jIGluZGV4IDUxMWFmODdmNjg1ZS4uNWUyNDk5MGYyOGRlIDEwMDY0
NA0KLS0tIGEva2VybmVsL2Nncm91cC9waWRzLmMNCisrKyBiL2tlcm5lbC9jZ3JvdXAvcGlkcy5j
DQpAQCAtMTcyLDYgKzE3Miw3IEBAIHN0YXRpYyBpbnQgcGlkc19jYW5fYXR0YWNoKHN0cnVjdCBj
Z3JvdXBfdGFza3NldCAqdHNldCkgIHsNCiAJc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrOw0KIAlz
dHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqZHN0X2NzczsNCisJaW50IHJldCA9IDA7DQogDQog
CWNncm91cF90YXNrc2V0X2Zvcl9lYWNoKHRhc2ssIGRzdF9jc3MsIHRzZXQpIHsNCiAJCXN0cnVj
dCBwaWRzX2Nncm91cCAqcGlkcyA9IGNzc19waWRzKGRzdF9jc3MpOyBAQCAtMTg2LDExICsxODcs
MTcgQEAgc3RhdGljIGludCBwaWRzX2Nhbl9hdHRhY2goc3RydWN0IGNncm91cF90YXNrc2V0ICp0
c2V0KQ0KIAkJb2xkX2NzcyA9IHRhc2tfY3NzKHRhc2ssIHBpZHNfY2dycF9pZCk7DQogCQlvbGRf
cGlkcyA9IGNzc19waWRzKG9sZF9jc3MpOw0KIA0KLQkJcGlkc19jaGFyZ2UocGlkcywgMSk7DQor
CQlyZXQgPSBwaWRzX3RyeV9jaGFyZ2UocGlkcywgMSk7DQorCQlpZiAocmV0KSB7DQorCQkJcHJf
aW5mbygiY2dyb3VwOiBhdHRhY2ggcmVqZWN0ZWQgYnkgcGlkcyBjb250cm9sbGVyIGluICIpOw0K
KwkJCXByX2NvbnRfY2dyb3VwX3BhdGgoZHN0X2Nzcy0+Y2dyb3VwKTsNCisJCQlwcl9jb250KCJc
biIpOw0KKwkJCWJyZWFrOw0KKwkJfQ0KIAkJcGlkc191bmNoYXJnZShvbGRfcGlkcywgMSk7DQog
CX0NCiANCi0JcmV0dXJuIDA7DQorCXJldHVybiByZXQ7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHBp
ZHNfY2FuY2VsX2F0dGFjaChzdHJ1Y3QgY2dyb3VwX3Rhc2tzZXQgKnRzZXQpDQotLQ0KMi4yNS4x
DQoNCg==
