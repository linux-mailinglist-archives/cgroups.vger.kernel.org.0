Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFFD00FE
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2019 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfJHTLl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Oct 2019 15:11:41 -0400
Received: from mail-eopbgr730068.outbound.protection.outlook.com ([40.107.73.68]:16117
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfJHTLk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 8 Oct 2019 15:11:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaTY9TTmwL3fFStgBPeJOF18RVIjWdD3nkrbgJZ81vk55khHD7siAx65iu2NqQBp9iZn5RPnzXOSFU3wzUUwRCThAWo8cEFcYlf4bC2xpuvBVkNBuDkSzlRAYYQ/4jq/xR4obligSehxh7xVckgVqi22R3vGHzj0jsDzsxLpIUuXx0wiV8u0h16/Dd9kZYBpooPKmh3EfLJrIzn9MMaN9J8Igb6aZO2PJ4gLcyGAfvd8hd4RBKPt8XM5yue+G9Djan+zIqiSifgEpoCv8/MEj1msr+6uVVj6jVGR+S4U13Ko9jGvxY+mIRVl1OFj0fJ1xKbNWVOlPo79kZ7jpXgd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97I/0DWQPSd2J6+JmO6swohBqpSljVEExZ5phca6P3s=;
 b=P8ZgiPqP0O4tbRW3KDVXKgjX7eGEG5CNpaD6RJtJl8jC08B6UlFV+8+JR5AW9LhVpklp7XG547mPc9HstY2ZAbapJjacEpmQ4lV4Roab7qS3dPs0YefXHpwA8qbxK8ANs1yIHsDwKZrQm6eHvlnU09TjA/RBuiYW9hrDSaB3hDWY9V9u1gKZnMTjszwz+/ByDvQb7YUX5XJGGbWdsmza4pXHyWP9lnyiIYDzCTvLKSurIgbUSgzgoSMc65ObmYIBlYuLct6X26O3JD2FfWEy4A9v6GsUzwPp91k/WMumn+g0Ui69LYe1j2V2Aez3wg621/j5/WTy9z3ikZl/fufY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97I/0DWQPSd2J6+JmO6swohBqpSljVEExZ5phca6P3s=;
 b=E4a3gxtLSB2CzYDsgpM8znKN8wsyggqRA99WRVvPjPXLCH+M73j7j+IOBvQWNjsrDQr/WBDfksaUXxeZa6R7VyyWMDWTD3uwLD+QtFtnWrDRlnmHqLKWNvogxG3CB6Jonfqv4oMbSh9zVqiX4dv+hqOszdYb1d0U+6dgZrEAR3E=
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3660.namprd12.prod.outlook.com (10.255.76.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 19:11:31 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::e56a:1c63:d6bd:8034]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::e56a:1c63:d6bd:8034%4]) with mapi id 15.20.2327.025; Tue, 8 Oct 2019
 19:11:31 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH RFC v4 16/16] drm/amdgpu: Integrate with DRM cgroup
Thread-Topic: [PATCH RFC v4 16/16] drm/amdgpu: Integrate with DRM cgroup
Thread-Index: AQHVXi/my1a4M+nNv02TYWUtGtZfe6dRW/8A
Date:   Tue, 8 Oct 2019 19:11:31 +0000
Message-ID: <04abdc58-ae30-a13d-e7dc-f1020a1400b9@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-17-Kenny.Ho@amd.com>
In-Reply-To: <20190829060533.32315-17-Kenny.Ho@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-clientproxiedby: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fee5fb85-0214-4066-a2b7-08d74c23542a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB3660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3660865AE1E1332E5CDCFC56929A0@DM6PR12MB3660.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(53546011)(6506007)(76176011)(66446008)(386003)(36756003)(229853002)(25786009)(65806001)(99286004)(66946007)(64756008)(66476007)(6436002)(52116002)(31686004)(66066001)(65956001)(6512007)(26005)(66556008)(186003)(2501003)(316002)(6246003)(14454004)(110136005)(478600001)(58126008)(6486002)(2906002)(102836004)(305945005)(486006)(5660300002)(7736002)(11346002)(446003)(8936002)(81156014)(81166006)(3846002)(86362001)(8676002)(2201001)(31696002)(71190400001)(71200400001)(2616005)(6116002)(476003)(256004)(14444005)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3660;H:DM6PR12MB3947.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeIN/25JPJGJ7q1NjYpHh4uMopVBZC/SXan8yxteLnojqcjm6Pfz3kjE6f5qFihbg0h7Cjnb/PmlqRo3eDLEGtedp8JwH5ANAf+UtJxKVIxTbIBpDfYP91OwlPpGUTBOlbPCk342Jhtu2r0JhWj2R2Z+qIep6Y9WoKCY3mCbCm8FZJ51/gNFuBk1JfJ3FFHP0OjVOakVCaYDUQGx7/fDTxQwpNNzkHZEU91e72FFm/ZS6JwUYDF4nUkg6LIZt3+bUtkDog4KelK13xlolHFZ0+DKqNyyLP6KA9qGolU9MsEkn+GPwdodwscX9cz+Y+H9iQ2eSE7vI/N4wtMtzFHLLvc2dInu1bStEFs3PG6ZzZGxdWP9F9g3ZLoL6P9NaQaj7F56vZcVs+3LCVnC3znCBE48IvgRb67WqjrX/Kv6oaM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82055F7A194D0842B39C109003485573@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee5fb85-0214-4066-a2b7-08d74c23542a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 19:11:31.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpqFvAYzz0fbWpAmkWgJbdmcapFy9zLBr5kbNX7CnGPRWpi2+/ugUexNTMERZMO/dZFSqGr5OuncsTkFALXuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3660
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gMjAxOS0wOC0yOSAyOjA1IGEubS4sIEtlbm55IEhvIHdyb3RlOg0KPiBUaGUgbnVtYmVyIG9m
IGxvZ2ljYWwgZ3B1IChsZ3B1KSBpcyBkZWZpbmVkIHRvIGJlIHRoZSBudW1iZXIgb2YgY29tcHV0
ZQ0KPiB1bml0IChDVSkgZm9yIGEgZGV2aWNlLiAgVGhlIGxncHUgYWxsb2NhdGlvbiBsaW1pdCBv
bmx5IGFwcGxpZXMgdG8NCj4gY29tcHV0ZSB3b3JrbG9hZCBmb3IgdGhlIG1vbWVudCAoZW5mb3Jj
ZWQgdmlhIGtmZCBxdWV1ZSBjcmVhdGlvbi4pICBBbnkNCj4gY3VfbWFzayB1cGRhdGUgaXMgdmFs
aWRhdGVkIGFnYWluc3QgdGhlIGF2YWlsYWJpbGl0eSBvZiB0aGUgY29tcHV0ZSB1bml0DQo+IGFz
IGRlZmluZWQgYnkgdGhlIGRybWNnIHRoZSBrZmQgcHJvY2VzcyBiZWxvbmdzIHRvLg0KDQpUaGVy
ZSBpcyBzb21ldGhpbmcgbWlzc2luZyBoZXJlLiBUaGVyZSBpcyBhbiBBUEkgZm9yIHRoZSBhcHBs
aWNhdGlvbiB0byANCnNwZWNpZnkgYSBDVSBtYXNrLiBSaWdodCBub3cgaXQgbG9va3MgbGlrZSB0
aGUgYXBwbGljYXRpb24tc3BlY2lmaWVkIGFuZCANCkNHcm91cC1zcGVjaWZpZWQgQ1UgbWFza3Mg
d291bGQgY2xvYmJlciBlYWNoIG90aGVyLiBJbnN0ZWFkIHRoZSB0d28gDQpzaG91bGQgYmUgbWVy
Z2VkLg0KDQpUaGUgQ0dyb3VwLXNwZWNpZmllZCBtYXNrIHNob3VsZCBzcGVjaWZ5IGEgc3Vic2V0
IG9mIENVcyBhdmFpbGFibGUgZm9yIA0KYXBwbGljYXRpb24tc3BlY2lmaWVkIENVIG1hc2tzLiBX
aGVuIHRoZSBjZ3JvdXAgQ1UgbWFzayBjaGFuZ2VzLCB5b3UnZCANCm5lZWQgdG8gdGFrZSBhbnkg
YXBwbGljYXRpb24tc3BlY2lmaWVkIENVIG1hc2tzIGludG8gYWNjb3VudCBiZWZvcmUgDQp1cGRh
dGluZyB0aGUgaGFyZHdhcmUuDQoNClRoZSBLRkQgdG9wb2xvZ3kgQVBJcyByZXBvcnQgdGhlIG51
bWJlciBvZiBhdmFpbGFibGUgQ1VzIHRvIHRoZSANCmFwcGxpY2F0aW9uLiBDR3JvdXBzIHdvdWxk
IGNoYW5nZSB0aGF0IG51bWJlciBhdCBydW50aW1lIGFuZCANCmFwcGxpY2F0aW9ucyB3b3VsZCBu
b3QgZXhwZWN0IHRoYXQuIEkgdGhpbmsgdGhlIGJlc3Qgd2F5IHRvIGRlYWwgd2l0aCANCnRoYXQg
d291bGQgYmUgdG8gaGF2ZSBtdWx0aXBsZSBiaXRzIGluIHRoZSBhcHBsaWNhdGlvbi1zcGVjaWZp
ZWQgQ1UgbWFzayANCm1hcCB0byB0aGUgc2FtZSBDVS4gSG93IHRvIGRvIHRoYXQgaW4gYSBmYWly
IHdheSBpcyBub3Qgb2J2aW91cy4gSSBndWVzcyANCmEgbW9yZSBjb2Fyc2UtZ3JhaW4gZGl2aXNp
b24gb2YgdGhlIEdQVSBpbnRvIExHUFVzIHdvdWxkIG1ha2UgdGhpcyANCnNvbWV3aGF0IGVhc2ll
ci4NCg0KSG93IGlzIHRoaXMgcHJvYmxlbSBoYW5kbGVkIGZvciBDUFUgY29yZXMgYW5kIHRoZSBp
bnRlcmFjdGlvbiB3aXRoIENQVSANCnB0aHJlYWRfc2V0YWZmaW5pdHlfbnA/DQoNClJlZ2FyZHMs
DQogwqAgRmVsaXgNCg0KDQo+DQo+IENoYW5nZS1JZDogSTY5YTU3NDUyYzU0OTE3M2ExY2Q2MjNj
MzBkYzU3MTk1YjNiNjU2M2UNCj4gU2lnbmVkLW9mZi1ieTogS2VubnkgSG8gPEtlbm55LkhvQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmQuaCAgICB8ICAgNCArDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jICAgICAgIHwgIDIxICsrKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9j
aGFyZGV2LmMgICAgICB8ICAgNiArDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaCAgICAgICAgIHwgICAzICsNCj4gICAuLi4vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19x
dWV1ZV9tYW5hZ2VyLmMgICAgfCAxNDAgKysrKysrKysrKysrKysrKysrDQo+ICAgNSBmaWxlcyBj
aGFuZ2VkLCAxNzQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5oDQo+IGluZGV4IDU1Y2IxYjIwOTRmZC4uMzY5OTE1MzM3MjEzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oDQo+IEBA
IC0xOTgsNiArMTk4LDEwIEBAIHVpbnQ4X3QgYW1kZ3B1X2FtZGtmZF9nZXRfeGdtaV9ob3BzX2Nv
dW50KHN0cnVjdCBrZ2RfZGV2ICpkc3QsIHN0cnVjdCBrZ2RfZGV2ICpzDQo+ICAgCQl2YWxpZDsJ
CQkJCQkJXA0KPiAgIAl9KQ0KPiAgIA0KPiAraW50IGFtZGdwdV9hbWRrZmRfdXBkYXRlX2N1X21h
c2tfZm9yX3Byb2Nlc3Moc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLA0KPiArCQlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyAqbGdwdV9iaXRtYXAsDQo+ICsJCXVuc2ln
bmVkIGludCBuYml0cyk7DQo+ICsNCj4gICAvKiBHUFVWTSBBUEkgKi8NCj4gICBpbnQgYW1kZ3B1
X2FtZGtmZF9ncHV2bV9jcmVhdGVfcHJvY2Vzc192bShzdHJ1Y3Qga2dkX2RldiAqa2dkLCB1bnNp
Z25lZCBpbnQgcGFzaWQsDQo+ICAgCQkJCQl2b2lkICoqdm0sIHZvaWQgKipwcm9jZXNzX2luZm8s
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gaW5kZXggMTYzYTRm
YmYwNjExLi44YWJlZmZkZDJlNWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMNCj4gQEAgLTEzOTgsOSArMTM5OCwyOSBAQCBhbWRncHVfZ2V0X2NydGNfc2Nh
bm91dF9wb3NpdGlvbihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgcGlwZSwN
Cj4gICBzdGF0aWMgdm9pZCBhbWRncHVfZHJtY2dfY3VzdG9tX2luaXQoc3RydWN0IGRybV9kZXZp
Y2UgKmRldiwNCj4gICAJc3RydWN0IGRybWNnX3Byb3BzICpwcm9wcykNCj4gICB7DQo+ICsJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkZXYtPmRldl9wcml2YXRlOw0KPiArDQo+ICsJcHJv
cHMtPmxncHVfY2FwYWNpdHkgPSBhZGV2LT5nZnguY3VfaW5mby5udW1iZXI7DQo+ICsNCj4gICAJ
cHJvcHMtPmxpbWl0X2VuZm9yY2VkID0gdHJ1ZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgdm9p
ZCBhbWRncHVfZHJtY2dfbGltaXRfdXBkYXRlZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiAr
CQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVjdCBkcm1jZ19kZXZpY2VfcmVzb3VyY2Ug
KmRkciwNCj4gKwkJZW51bSBkcm1jZ19yZXNfdHlwZSByZXNfdHlwZSkNCj4gK3sNCj4gKwlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7DQo+ICsNCj4gKwlzd2l0
Y2ggKHJlc190eXBlKSB7DQo+ICsJY2FzZSBEUk1DR19UWVBFX0xHUFU6DQo+ICsJCWFtZGdwdV9h
bWRrZmRfdXBkYXRlX2N1X21hc2tfZm9yX3Byb2Nlc3ModGFzaywgYWRldiwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIGRkci0+bGdwdV9hbGxvY2F0ZWQsIGRldi0+ZHJtY2dfcHJvcHMubGdw
dV9jYXBhY2l0eSk7DQo+ICsJCWJyZWFrOw0KPiArCWRlZmF1bHQ6DQo+ICsJCWJyZWFrOw0KPiAr
CX0NCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBzdHJ1Y3QgZHJtX2RyaXZlciBrbXNfZHJpdmVyID0g
ew0KPiAgIAkuZHJpdmVyX2ZlYXR1cmVzID0NCj4gICAJICAgIERSSVZFUl9VU0VfQUdQIHwgRFJJ
VkVSX0FUT01JQyB8DQo+IEBAIC0xNDM4LDYgKzE0NTgsNyBAQCBzdGF0aWMgc3RydWN0IGRybV9k
cml2ZXIga21zX2RyaXZlciA9IHsNCj4gICAJLmdlbV9wcmltZV9tbWFwID0gYW1kZ3B1X2dlbV9w
cmltZV9tbWFwLA0KPiAgIA0KPiAgIAkuZHJtY2dfY3VzdG9tX2luaXQgPSBhbWRncHVfZHJtY2df
Y3VzdG9tX2luaXQsDQo+ICsJLmRybWNnX2xpbWl0X3VwZGF0ZWQgPSBhbWRncHVfZHJtY2dfbGlt
aXRfdXBkYXRlZCwNCj4gICANCj4gICAJLm5hbWUgPSBEUklWRVJfTkFNRSwNCj4gICAJLmRlc2Mg
PSBEUklWRVJfREVTQywNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5j
DQo+IGluZGV4IDEzOGM3MDQ1NGUyYi4uZmE3NjViODAzZjk3IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gQEAgLTQ1MCw2ICs0NTAsMTIgQEAgc3Rh
dGljIGludCBrZmRfaW9jdGxfc2V0X2N1X21hc2soc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBr
ZmRfcHJvY2VzcyAqcCwNCj4gICAJCXJldHVybiAtRUZBVUxUOw0KPiAgIAl9DQo+ICAgDQo+ICsJ
aWYgKCFwcW1fZHJtY2dfbGdwdV92YWxpZGF0ZShwLCBhcmdzLT5xdWV1ZV9pZCwgcHJvcGVydGll
cy5jdV9tYXNrLCBjdV9tYXNrX3NpemUpKSB7DQo+ICsJCXByX2RlYnVnKCJDVSBtYXNrIG5vdCBw
ZXJtaXR0ZWQgYnkgRFJNIENncm91cCIpOw0KPiArCQlrZnJlZShwcm9wZXJ0aWVzLmN1X21hc2sp
Ow0KPiArCQlyZXR1cm4gLUVBQ0NFUzsNCj4gKwl9DQo+ICsNCj4gICAJbXV0ZXhfbG9jaygmcC0+
bXV0ZXgpOw0KPiAgIA0KPiAgIAlyZXR2YWwgPSBwcW1fc2V0X2N1X21hc2soJnAtPnBxbSwgYXJn
cy0+cXVldWVfaWQsICZwcm9wZXJ0aWVzKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJpdi5oDQo+IGluZGV4IDhiMGVlZTViMzUyMS4uODg4ODFiZWM3NTUwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gQEAgLTEwMzgsNiArMTAzOCw5IEBAIGlu
dCBwcW1fZ2V0X3dhdmVfc3RhdGUoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLA0K
PiAgIAkJICAgICAgIHUzMiAqY3RsX3N0YWNrX3VzZWRfc2l6ZSwNCj4gICAJCSAgICAgICB1MzIg
KnNhdmVfYXJlYV91c2VkX3NpemUpOw0KPiAgIA0KPiArYm9vbCBwcW1fZHJtY2dfbGdwdV92YWxp
ZGF0ZShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsIGludCBxaWQsIHUzMiAqY3VfbWFzaywNCj4gKwkJ
dW5zaWduZWQgaW50IGN1X21hc2tfc2l6ZSk7DQo+ICsNCj4gICBpbnQgYW1ka2ZkX2ZlbmNlX3dh
aXRfdGltZW91dCh1bnNpZ25lZCBpbnQgKmZlbmNlX2FkZHIsDQo+ICAgCQkJCXVuc2lnbmVkIGlu
dCBmZW5jZV92YWx1ZSwNCj4gICAJCQkJdW5zaWduZWQgaW50IHRpbWVvdXRfbXMpOw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFu
YWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFu
YWdlci5jDQo+IGluZGV4IDdlNmMzZWU4MmY1Yi4uYTg5NmRlMjkwMzA3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFu
YWdlci5jDQo+IEBAIC0yMyw5ICsyMywxMSBAQA0KPiAgIA0KPiAgICNpbmNsdWRlIDxsaW51eC9z
bGFiLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9j
Z3JvdXBfZHJtLmg+DQo+ICAgI2luY2x1ZGUgImtmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5oIg0K
PiAgICNpbmNsdWRlICJrZmRfcHJpdi5oIg0KPiAgICNpbmNsdWRlICJrZmRfa2VybmVsX3F1ZXVl
LmgiDQo+ICsjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+ICAgI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQu
aCINCj4gICANCj4gICBzdGF0aWMgaW5saW5lIHN0cnVjdCBwcm9jZXNzX3F1ZXVlX25vZGUgKmdl
dF9xdWV1ZV9ieV9xaWQoDQo+IEBAIC0xNjcsNiArMTY5LDcgQEAgc3RhdGljIGludCBjcmVhdGVf
Y3BfcXVldWUoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLA0KPiAgIAkJCQlzdHJ1
Y3QgcXVldWVfcHJvcGVydGllcyAqcV9wcm9wZXJ0aWVzLA0KPiAgIAkJCQlzdHJ1Y3QgZmlsZSAq
ZiwgdW5zaWduZWQgaW50IHFpZCkNCj4gICB7DQo+ICsJc3RydWN0IGRybWNnICpkcm1jZzsNCj4g
ICAJaW50IHJldHZhbDsNCj4gICANCj4gICAJLyogRG9vcmJlbGwgaW5pdGlhbGl6ZWQgaW4gdXNl
ciBzcGFjZSovDQo+IEBAIC0xODAsNiArMTgzLDM2IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2NwX3F1
ZXVlKHN0cnVjdCBwcm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwNCj4gICAJaWYgKHJldHZhbCAh
PSAwKQ0KPiAgIAkJcmV0dXJuIHJldHZhbDsNCj4gICANCj4gKw0KPiArCWRybWNnID0gZHJtY2df
Z2V0KHBxbS0+cHJvY2Vzcy0+bGVhZF90aHJlYWQpOw0KPiArCWlmIChkcm1jZykgew0KPiArCQlz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldjsNCj4gKwkJc3RydWN0IGRybWNnX2RldmljZV9yZXNv
dXJjZSAqZGRyOw0KPiArCQlpbnQgbWFza19zaXplOw0KPiArCQl1MzIgKm1hc2s7DQo+ICsNCj4g
KwkJYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKSBkZXYtPmtnZDsNCj4gKw0KPiArCQlt
YXNrX3NpemUgPSBhZGV2LT5kZGV2LT5kcm1jZ19wcm9wcy5sZ3B1X2NhcGFjaXR5Ow0KPiArCQlt
YXNrID0ga3phbGxvYyhzaXplb2YodTMyKSAqIHJvdW5kX3VwKG1hc2tfc2l6ZSwgMzIpLA0KPiAr
CQkJCUdGUF9LRVJORUwpOw0KPiArDQo+ICsJCWlmICghbWFzaykgew0KPiArCQkJZHJtY2dfcHV0
KGRybWNnKTsNCj4gKwkJCXVuaW5pdF9xdWV1ZSgqcSk7DQo+ICsJCQlyZXR1cm4gLUVOT01FTTsN
Cj4gKwkJfQ0KPiArDQo+ICsJCWRkciA9IGRybWNnLT5kZXZfcmVzb3VyY2VzW2FkZXYtPmRkZXYt
PnByaW1hcnktPmluZGV4XTsNCj4gKw0KPiArCQliaXRtYXBfdG9fYXJyMzIobWFzaywgZGRyLT5s
Z3B1X2FsbG9jYXRlZCwgbWFza19zaXplKTsNCj4gKw0KPiArCQkoKnEpLT5wcm9wZXJ0aWVzLmN1
X21hc2tfY291bnQgPSBtYXNrX3NpemU7DQo+ICsJCSgqcSktPnByb3BlcnRpZXMuY3VfbWFzayA9
IG1hc2s7DQo+ICsNCj4gKwkJZHJtY2dfcHV0KGRybWNnKTsNCj4gKwl9DQo+ICsNCj4gICAJKCpx
KS0+ZGV2aWNlID0gZGV2Ow0KPiAgIAkoKnEpLT5wcm9jZXNzID0gcHFtLT5wcm9jZXNzOw0KPiAg
IA0KPiBAQCAtNDk1LDYgKzUyOCwxMTMgQEAgaW50IHBxbV9nZXRfd2F2ZV9zdGF0ZShzdHJ1Y3Qg
cHJvY2Vzc19xdWV1ZV9tYW5hZ2VyICpwcW0sDQo+ICAgCQkJCQkJICAgICAgIHNhdmVfYXJlYV91
c2VkX3NpemUpOw0KPiAgIH0NCj4gICANCj4gK2Jvb2wgcHFtX2RybWNnX2xncHVfdmFsaWRhdGUo
c3RydWN0IGtmZF9wcm9jZXNzICpwLCBpbnQgcWlkLCB1MzIgKmN1X21hc2ssDQo+ICsJCXVuc2ln
bmVkIGludCBjdV9tYXNrX3NpemUpDQo+ICt7DQo+ICsJREVDTEFSRV9CSVRNQVAoY3Vycl9tYXNr
LCBNQVhfRFJNQ0dfTEdQVV9DQVBBQ0lUWSk7DQo+ICsJc3RydWN0IGRybWNnX2RldmljZV9yZXNv
dXJjZSAqZGRyOw0KPiArCXN0cnVjdCBwcm9jZXNzX3F1ZXVlX25vZGUgKnBxbjsNCj4gKwlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldjsNCj4gKwlzdHJ1Y3QgZHJtY2cgKmRybWNnOw0KPiArCWJv
b2wgcmVzdWx0Ow0KPiArDQo+ICsJaWYgKGN1X21hc2tfc2l6ZSA+IE1BWF9EUk1DR19MR1BVX0NB
UEFDSVRZKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwliaXRtYXBfZnJvbV9hcnIzMihj
dXJyX21hc2ssIGN1X21hc2ssIGN1X21hc2tfc2l6ZSk7DQo+ICsNCj4gKwlwcW4gPSBnZXRfcXVl
dWVfYnlfcWlkKCZwLT5wcW0sIHFpZCk7DQo+ICsJaWYgKCFwcW4pDQo+ICsJCXJldHVybiBmYWxz
ZTsNCj4gKw0KPiArCWFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilwcW4tPnEtPmRldmlj
ZS0+a2dkOw0KPiArDQo+ICsJZHJtY2cgPSBkcm1jZ19nZXQocC0+bGVhZF90aHJlYWQpOw0KPiAr
CWRkciA9IGRybWNnLT5kZXZfcmVzb3VyY2VzW2FkZXYtPmRkZXYtPnByaW1hcnktPmluZGV4XTsN
Cj4gKw0KPiArCWlmIChiaXRtYXBfc3Vic2V0KGN1cnJfbWFzaywgZGRyLT5sZ3B1X2FsbG9jYXRl
ZCwNCj4gKwkJCQlNQVhfRFJNQ0dfTEdQVV9DQVBBQ0lUWSkpDQo+ICsJCXJlc3VsdCA9IHRydWU7
DQo+ICsJZWxzZQ0KPiArCQlyZXN1bHQgPSBmYWxzZTsNCj4gKw0KPiArCWRybWNnX3B1dChkcm1j
Zyk7DQo+ICsNCj4gKwlyZXR1cm4gcmVzdWx0Ow0KPiArfQ0KPiArDQo+ICtpbnQgYW1kZ3B1X2Ft
ZGtmZF91cGRhdGVfY3VfbWFza19mb3JfcHJvY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ss
DQo+ICsJCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nICpsZ3B1X2Jt
LA0KPiArCQl1bnNpZ25lZCBpbnQgbGdwdV9ibV9zaXplKQ0KPiArew0KPiArCXN0cnVjdCBrZmRf
ZGV2ICprZGV2ID0gYWRldi0+a2ZkLmRldjsNCj4gKwlzdHJ1Y3QgcHJvY2Vzc19xdWV1ZV9ub2Rl
ICpwcW47DQo+ICsJc3RydWN0IGtmZF9wcm9jZXNzICprZmRwcm9jOw0KPiArCXNpemVfdCBzaXpl
X2luX2J5dGVzOw0KPiArCXUzMiAqY3VfbWFzazsNCj4gKwlpbnQgcmMgPSAwOw0KPiArDQo+ICsJ
aWYgKChsZ3B1X2JtX3NpemUgJSAzMikgIT0gMCkgew0KPiArCQlwcl93YXJuKCJsZ3B1X2JtX3Np
emUgJWQgbXVzdCBiZSBhIG11bHRpcGxlIG9mIDMyIiwNCj4gKwkJCQlsZ3B1X2JtX3NpemUpOw0K
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlrZmRwcm9jID0ga2ZkX2dldF9w
cm9jZXNzKHRhc2spOw0KPiArDQo+ICsJaWYgKElTX0VSUihrZmRwcm9jKSkNCj4gKwkJcmV0dXJu
IC1FU1JDSDsNCj4gKw0KPiArCXNpemVfaW5fYnl0ZXMgPSBzaXplb2YodTMyKSAqIHJvdW5kX3Vw
KGxncHVfYm1fc2l6ZSwgMzIpOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygma2ZkcHJvYy0+bXV0ZXgp
Ow0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkocHFuLCAma2ZkcHJvYy0+cHFtLnF1ZXVlcywgcHJv
Y2Vzc19xdWV1ZV9saXN0KSB7DQo+ICsJCWlmIChwcW4tPnEgJiYgcHFuLT5xLT5kZXZpY2UgPT0g
a2Rldikgew0KPiArCQkJLyogdXBkYXRlIGN1X21hc2sgYWNjb3JkaW5nbHkgKi8NCj4gKwkJCWN1
X21hc2sgPSBremFsbG9jKHNpemVfaW5fYnl0ZXMsIEdGUF9LRVJORUwpOw0KPiArCQkJaWYgKCFj
dV9tYXNrKSB7DQo+ICsJCQkJcmMgPSAtRU5PTUVNOw0KPiArCQkJCWJyZWFrOw0KPiArCQkJfQ0K
PiArDQo+ICsJCQlpZiAocHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2spIHsNCj4gKwkJCQlERUNM
QVJFX0JJVE1BUChjdXJyX21hc2ssDQo+ICsJCQkJCQlNQVhfRFJNQ0dfTEdQVV9DQVBBQ0lUWSk7
DQo+ICsNCj4gKwkJCQlpZiAocHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2tfY291bnQgPg0KPiAr
CQkJCQkJbGdwdV9ibV9zaXplKSB7DQo+ICsJCQkJCXJjID0gLUVJTlZBTDsNCj4gKwkJCQkJa2Zy
ZWUoY3VfbWFzayk7DQo+ICsJCQkJCWJyZWFrOw0KPiArCQkJCX0NCj4gKw0KPiArCQkJCWJpdG1h
cF9mcm9tX2FycjMyKGN1cnJfbWFzaywNCj4gKwkJCQkJCXBxbi0+cS0+cHJvcGVydGllcy5jdV9t
YXNrLA0KPiArCQkJCQkJcHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2tfY291bnQpOw0KPiArDQo+
ICsJCQkJYml0bWFwX2FuZChjdXJyX21hc2ssIGN1cnJfbWFzaywgbGdwdV9ibSwNCj4gKwkJCQkJ
CWxncHVfYm1fc2l6ZSk7DQo+ICsNCj4gKwkJCQliaXRtYXBfdG9fYXJyMzIoY3VfbWFzaywgY3Vy
cl9tYXNrLA0KPiArCQkJCQkJbGdwdV9ibV9zaXplKTsNCj4gKw0KPiArCQkJCWtmcmVlKGN1cnJf
bWFzayk7DQo+ICsJCQl9IGVsc2UNCj4gKwkJCQliaXRtYXBfdG9fYXJyMzIoY3VfbWFzaywgbGdw
dV9ibSwNCj4gKwkJCQkJCWxncHVfYm1fc2l6ZSk7DQo+ICsNCj4gKwkJCXBxbi0+cS0+cHJvcGVy
dGllcy5jdV9tYXNrID0gY3VfbWFzazsNCj4gKwkJCXBxbi0+cS0+cHJvcGVydGllcy5jdV9tYXNr
X2NvdW50ID0gbGdwdV9ibV9zaXplOw0KPiArDQo+ICsJCQlyYyA9IHBxbi0+cS0+ZGV2aWNlLT5k
cW0tPm9wcy51cGRhdGVfcXVldWUoDQo+ICsJCQkJCXBxbi0+cS0+ZGV2aWNlLT5kcW0sIHBxbi0+
cSk7DQo+ICsJCX0NCj4gKwl9DQo+ICsJbXV0ZXhfdW5sb2NrKCZrZmRwcm9jLT5tdXRleCk7DQo+
ICsNCj4gKwlyZXR1cm4gcmM7DQo+ICt9DQo+ICsNCj4gICAjaWYgZGVmaW5lZChDT05GSUdfREVC
VUdfRlMpDQo+ICAgDQo+ICAgaW50IHBxbV9kZWJ1Z2ZzX21xZHMoc3RydWN0IHNlcV9maWxlICpt
LCB2b2lkICpkYXRhKQ0K
