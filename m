Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87EA2E663
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE2Ups (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 16:45:48 -0400
Received: from mail-eopbgr810073.outbound.protection.outlook.com ([40.107.81.73]:32192
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfE2Upr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 May 2019 16:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi8+MoISYpwTfBH6qOBp0pOUiZUQJfBIKB9cFl8xvPU=;
 b=cM04rBW16jH0kT3amWcka7H/RspkM0TrPGhGnOR2wFmfBrzzPagzLyH6ZLttt4ntTtySvhkPdyYjZpAhv7zwIfYkCrimOnVx8DnKrWOGZ4f0JHiG44y01wDUpc0G9nVQTPy1VKmogLzxga0lroFlT4QqO8giRod4WlRa+qfeGJk=
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3179.namprd12.prod.outlook.com (20.179.104.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 29 May 2019 20:45:44 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::5964:8c3c:1b5b:c480]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::5964:8c3c:1b5b:c480%2]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 20:45:44 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Tejun Heo <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/4] drm/amdkfd: Check against device cgroup
Thread-Topic: [PATCH v2 4/4] drm/amdkfd: Check against device cgroup
Thread-Index: AQHVDMu25wvZUqMPIUm3iuLqsF/FUKZvwA0AgBE2MoCAAa8fAA==
Date:   Wed, 29 May 2019 20:45:44 +0000
Message-ID: <d39ec6a7-b30d-404b-c8d1-4e22604e0c8e@amd.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
 <20190517161435.14121-5-Harish.Kasiviswanathan@amd.com>
 <e547c0a1-e153-c3a6-79bc-67f59f364c3e@amd.com>
 <20190528190239.GM374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190528190239.GM374014@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-clientproxiedby: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21c3fb3b-a906-470e-52d9-08d6e4769ed4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3179;
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-microsoft-antispam-prvs: <DM6PR12MB31793419F901318CB5787BD4921F0@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(189003)(199004)(6486002)(71200400001)(65806001)(54906003)(6246003)(102836004)(71190400001)(31696002)(229853002)(86362001)(8676002)(52116002)(256004)(64126003)(66066001)(5660300002)(2906002)(110136005)(476003)(53936002)(11346002)(65826007)(31686004)(486006)(25786009)(2616005)(58126008)(36756003)(26005)(72206003)(6436002)(4326008)(68736007)(7736002)(478600001)(186003)(65956001)(66476007)(6512007)(66446008)(76176011)(8936002)(446003)(81166006)(6116002)(316002)(6506007)(3846002)(14454004)(81156014)(66556008)(99286004)(386003)(53546011)(64756008)(73956011)(305945005)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3179;H:DM6PR12MB3947.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SPmGjKxGcBETrsBgFop9Hs3jK/H/GIvuB8LiuHVZfts+qS75n3xLnu9olXbj3lo0wxRfI5pq3ttLZdRkeozuGHx/vgv5UZn+Rco8kzSbB7pe8uASiRc8ec4+8mXd+mB6sr9gWXxzZGMuWpDGB8IvK90c+c+8idCXyqcYiG1/qN/0Sjja50n0FGgPAvbxo35SwXFxTNtPjCKno6R+BoyG/56t5nhJljkp9pG9x8hlBhEWisZUgDKGbXbIBDQTeDO4IjG8yJCLB6jhUExommrHqag0IO0AYY8KmbXRY0Iy4sgl0dMKUm5j4U6PIdq131XDSKlp8BY4+02SMH9h6riymLu4Ro9FrMQRW0IAe+yTWJ868jJzb/SXntai/eOFnn9kjy9SK+nirE0TfZPaBqQDiuIHnXQHB/wqBKFVQk8GNFA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BEE5F0ACC2D1740A23D8F3495D41A37@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c3fb3b-a906-470e-52d9-08d6e4769ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 20:45:44.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gMjAxOS0wNS0yOCAzOjAyIHAubS4sIFRlanVuIEhlbyB3cm90ZToNCj4gSGVsbG8sDQo+DQo+
IE9uIEZyaSwgTWF5IDE3LCAyMDE5IGF0IDA4OjEyOjE3UE0gKzAwMDAsIEt1ZWhsaW5nLCBGZWxp
eCB3cm90ZToNCj4+IFBhdGNoZXMgMSwyLDQgd2lsbCBiZSBzdWJtaXR0ZWQgdGhyb3VnaCBhbWQt
c3RhZ2luZy1kcm0tbmV4dC4gUGF0Y2ggMw0KPj4gZ29lcyB0aHJvdWdoIHRoZSBjZ3JvdXAgdHJl
ZS4gUGF0Y2ggNCBkZXBlbmRzIG9uIHBhdGNoIDMuIFNvIHN1Ym1pdHRpbmcNCj4+IHBhdGNoIDQg
d2lsbCBuZWVkIHRvIHdhaXQgdW50aWwgd2UgcmViYXNlIGFtZC1zdGFnaW5nLWRybS1uZXh0IG9u
IGEgbmV3DQo+PiBlbm91Z2gga2VybmVsIHJlbGVhc2UgdGhhdCBpbmNsdWRlcyBwYXRjaCAzLg0K
Pj4NCj4+IFBhdGNoIDEgYW5kIDIgY291bGQgYmUgc3VibWl0dGVkIG5vdyBvciB3YWl0IGZvciBw
YXRjaCAzIGFzIHdlbGwgc28gd2UNCj4+IHN1Ym1pdCBhbGwgb3VyIGNncm91cCBzdHVmZiBpbiBh
bWRncHUgYW5kIEtGRCB0b2dldGhlci4gSXQgcHJvYmFibHkNCj4+IG1ha2VzIG1vc3Qgc2Vuc2Ug
dG8gd2FpdCBzaW5jZSB1bnVzZWQgY29kZSB0ZW5kcyB0byByb3QuDQo+Pg0KPj4gUGF0Y2hlcyAx
LDIsNCBhcmUgYWxyZWFkeSByZXZpZXdlZCBieSBtZS4gRmVlbCBmcmVlIHRvIGFkZCBteSBBY2tl
ZC1ieQ0KPj4gdG8gcGF0Y2ggMy4NCj4gUGxlYXNlIGZlZWwgZnJlZSB0byBhZGQgbXkgYWNrZWQt
YnkgYW5kIHRha2UgcGF0Y2ggMyB3aXRoIHRoZSByZXN0IG9mDQo+IHRoZSBwYXRjaHNldC4NCg0K
VGhhbmsgeW91IFRlanVuIQ0KDQpKdXN0IHRvIGNsYXJpZnksIGFyZSB5b3Ugc2F5aW5nIHRoYXQg
d2Ugc2hvdWxkIHVwc3RyZWFtIHRoaXMgY2hhbmdlIA0KdGhyb3VnaCBBbGV4IERldWNoZXIncyBh
bWQtc3RhZ2luZy1kcm0tbmV4dCBhbmQgRGF2ZSBBaXJsaWUncyBkcm0tbmV4dCANCnRyZWVzPw0K
DQpJIGFkZGVkIERhdmUgYW5kIEFsZXggdG8gdGhpcyBlbWFpbCB0byBtYWtlIHN1cmUgd2UncmUg
YWxsIG9uIHRoZSBzYW1lIHBhZ2UuDQoNClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KPg0KPiBUaGFu
a3MuDQo+DQo=
