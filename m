Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5994646B
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfFNQh2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 12:37:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47880 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfFNQh1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jun 2019 12:37:27 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EGIGhI023443;
        Fri, 14 Jun 2019 09:36:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jNRW9EmWXHDKfmPq7ZRz6M8ppAhae7tV4WfQ4SRKB3U=;
 b=NVPU6cUCj7go4ZN7SujSkagzKLFGRAvTuDJxxXSZB551P6cFcWPJuPwECHFebknecsd4
 VyTjACWDRkD/Ouv+sm+sw+Ql2iLP+0b1ymlfnFHd7a0jHw39898gM8V04SDPjzKQ+YxT
 KzH5nTOncGkuUTD31BffwEFwXWm9edhr+ME= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4ds0rbv0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jun 2019 09:36:10 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Jun 2019 09:35:40 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Jun 2019 09:35:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNRW9EmWXHDKfmPq7ZRz6M8ppAhae7tV4WfQ4SRKB3U=;
 b=UxzpnnnC3dfgmaTf592qdGW5mOmgO2x/XYv25lANqMZL3QcJdoCabA2Z8gB0L3ts1nMo0eBc5rA+YSINSgi0O6MBPcR3RM3GGulxT9rRNSyK4gX/zeaH5wrEE23+LB5QtmRO0pHiUY76oNkx1ihN2Eg7n36BfISVxTM+ux5k/iE=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2421.namprd15.prod.outlook.com (52.135.198.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 14 Jun 2019 16:35:35 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702%7]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 16:35:35 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Tejun Heo <tj@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, Andy Newell <newella@fb.com>,
        "Chris Mason" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "Dennis Zhou" <dennisz@fb.com>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH 10/10] blkcg: implement BPF_PROG_TYPE_IO_COST
Thread-Topic: [PATCH 10/10] blkcg: implement BPF_PROG_TYPE_IO_COST
Thread-Index: AQHVIlSgdAmsTapt/U2E3GyZX/rb/6abBPGAgAA4BYCAABy+AA==
Date:   Fri, 14 Jun 2019 16:35:35 +0000
Message-ID: <bed0a66a-7aa6-ac36-9182-31a4937257e5@fb.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614015620.1587672-11-tj@kernel.org>
 <e4d1df7b-66bb-061a-8ecb-ff1e5be3ab1d@netronome.com>
 <20190614145239.GA538958@devbig004.ftw2.facebook.com>
In-Reply-To: <20190614145239.GA538958@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0060.namprd14.prod.outlook.com
 (2603:10b6:300:81::22) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:6345]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64d84e9b-9c9d-474a-b66e-08d6f0e6536d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2421;
x-ms-traffictypediagnostic: BYAPR15MB2421:
x-microsoft-antispam-prvs: <BYAPR15MB242115226704274B4D51FE19D7EE0@BYAPR15MB2421.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(66556008)(478600001)(229853002)(7416002)(66946007)(46003)(68736007)(6436002)(6116002)(66446008)(53936002)(66476007)(53546011)(36756003)(76176011)(110136005)(71190400001)(54906003)(64756008)(2906002)(6506007)(73956011)(31686004)(102836004)(52116002)(71200400001)(386003)(256004)(81156014)(8936002)(31696002)(6512007)(6246003)(186003)(6486002)(5024004)(86362001)(99286004)(316002)(7736002)(486006)(476003)(14444005)(4326008)(25786009)(5660300002)(305945005)(446003)(11346002)(81166006)(2616005)(14454004)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2421;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dhOBio5kMMhD9ql1AjrOLSGGX0Sg+BDYCH1tzLPOoGtxGJRQEV5ekhpTZBG3+27VGMaSCVp5+6AK/Ac+9ggCxXUtnlB4s3mOyomxsYHVHVUMNLs/rf/YgtKAMLFtqMScDxnZ6Xw3HoUjKg+YIOz++Kro1xgNOMp8bX9BCujtSRlke9oIaJ1J9uzhdpRnKBfZQmHYPTcz3dXZXYbQZd6ezRbnA1509u0KXNv2d2zsaWA1hx6X2z/R9WeByrzlSBirN0ejkrUC4zBkONA1gw6ozfjvsjv7bfpoLcHcwMUkGqqqXHxnzUcif5pg+PLhjFV/nyER4FeREEGycQlYYDsqnQGxlkDLE7OCBCcqhDVypTudRBNFjuN7WaoFNh2DEDEcW4NJBj3Jnje5CIFfJ0diQZJ8UlrKvO18D3bCrPWT7rU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28B576F5DD3F7F42A8E9DFABB8D25258@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d84e9b-9c9d-474a-b66e-08d6f0e6536d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:35:35.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ast@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140134
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gNi8xNC8xOSA3OjUyIEFNLCBUZWp1biBIZW8gd3JvdGU6DQo+IEhlbGxvLCBRdWVudGluLg0K
PiANCj4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMTI6MzI6MDlQTSArMDEwMCwgUXVlbnRpbiBN
b25uZXQgd3JvdGU6DQo+PiBQbGVhc2UgbWFrZSBzdXJlIHRvIHVwZGF0ZSB0aGUgZG9jdW1lbnRh
dGlvbiBhbmQgYmFzaA0KPj4gY29tcGxldGlvbiB3aGVuIGFkZGluZyB0aGUgbmV3IHR5cGUgdG8g
YnBmdG9vbC4gWW91DQo+PiBwcm9iYWJseSB3YW50IHNvbWV0aGluZyBsaWtlIHRoZSBkaWZmIGJl
bG93Lg0KPiANCj4gVGhhbmsgeW91IHNvIG11Y2guICBXaWxsIGluY29ycG9yYXRlIHRoZW0uICBK
dXN0IGluIGNhc2UsIHdoaWxlIGl0J3MNCj4gbm90ZWQgaW4gdGhlIGhlYWQgbWVzc2FnZSwgSSBs
b3N0IHRoZSBSRkMgbWFya2VyIHdoaWxlIHByZXBwaW5nIHRoaXMNCj4gcGF0Y2guICBJdCBpc24n
dCB5ZXQgY2xlYXIgd2hldGhlciB3ZSdkIHJlYWxseSBuZWVkIGN1c3RvbSBjb3N0DQo+IGZ1bmN0
aW9ucyBhbmQgdGhpcyBwYXRjaCBpcyBpbmNsdWRlZCBtb3JlIGFzIGEgcHJvb2Ygb2YgY29uY2Vw
dC4gIA0KDQp0aGUgZXhhbXBsZSBicGYgcHJvZyBsb29rcyBmbGV4aWJsZSBlbm91Z2ggdG8gYWxs
b3cgc29tZSBkZWdyZWUNCm9mIGV4cGVyaW1lbnRzLiBUaGUgcXVlc3Rpb24gaXMgd2hhdCBraW5k
IG9mIG5ldyBhbGdvcml0aG1zIHlvdSBlbnZpc2lvbg0KaXQgd2lsbCBkbz8gd2hhdCBvdGhlciBp
bnB1dHMgaXQgd291bGQgbmVlZCB0byBtYWtlIGEgZGVjaXNpb24/DQpJIHRoaW5rIGl0J3Mgb2sg
dG8gc3RhcnQgd2l0aCB3aGF0IGl0IGRvZXMgbm93IGFuZCBleHRlbmQgZnVydGhlcg0Kd2hlbiBu
ZWVkIGFyaXNlcy4NCg0KPiBJZg0KPiBpdCB0dXJucyBvdXQgdGhhdCB0aGlzIGlzIGJlbmVmaWNp
YWwgZW5vdWdoLCB0aGUgZm9sbG93aW5ncyBuZWVkIHRvIGJlDQo+IGFuc3dlcmVkLg0KPiANCj4g
KiBJcyBibG9jayBpb2N0bCB0aGUgcmlnaHQgbWVjaGFuaXNtIHRvIGF0dGFjaCB0aGVzZSBwcm9n
cmFtcz8NCg0KaW1vIGlvY3RsIGlzIGEgYml0IHdlaXJkLCBidXQgc2luY2UgaXRzIG9ubHkgb25l
IHByb2dyYW0gcGVyIGJsb2NrDQpkZXZpY2UgaXQncyBwcm9iYWJseSBvaz8gVW5sZXNzIHlvdSBz
ZWUgaXQgYmVpbmcgY2dyb3VwIHNjb3BlZCBpbg0KdGhlIGZ1dHVyZT8gVGhlbiBjZ3JvdXAtYnBm
IHN0eWxlIGhvb2tzIHdpbGwgYmUgbW9yZSBzdWl0YWJsZQ0KYW5kIGFsbG93IGEgY2hhaW4gb2Yg
cHJvZ3JhbXMuDQoNCj4gKiBBcmUgdGhlcmUgbW9yZSBwYXJhbWV0ZXJzIHRoYXQgbmVlZCB0byBi
ZSBleHBvc2VkIHRvIHRoZSBwcm9ncmFtcz8NCj4gDQo+ICogSXQnZCBiZSBncmVhdCB0byBoYXZl
IGVmZmljaWVudCBhY2Nlc3MgdG8gcGVyLWJsb2NrZGV2IGFuZA0KPiAgICBwZXItYmxvY2tkZXYt
Y2dyb3VwLXBhaXIgc3RvcmFnZXMgYXZhaWxhYmxlIHRvIHRoZXNlIHByb2dyYW1zIHNvDQo+ICAg
IHRoYXQgdGhleSBjYW4ga2VlcCB0cmFjayBvZiBoaXN0b3J5LiAgV2hhdCdkIGJlIHRoZSBiZXN0
IG9mIHdheSBvZg0KPiAgICBkb2luZyB0aGF0IGNvbnNpZGVyaW5nIHRoZSBmYWN0IHRoYXQgdGhl
c2UgcHJvZ3JhbXMgd2lsbCBiZSBjYWxsZWQNCj4gICAgcGVyIGVhY2ggSU8gYW5kIHRoZSBvdmVy
aGVhZCBjYW4gYWRkIHVwIHF1aWNrbHk/DQoNCk1hcnRpbidzIHNvY2tldCBsb2NhbCBzdG9yYWdl
IHNvbHZlZCB0aGF0IGlzc3VlIGZvciBzb2NrZXRzLg0KU29tZXRoaW5nIHZlcnkgc2ltaWxhciBj
YW4gd29yayBmb3IgcGVyLWJsb2NrZGV2LXBlci1jZ3JvdXAuDQo=
