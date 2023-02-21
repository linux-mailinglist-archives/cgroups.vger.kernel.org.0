Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41869E6C2
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBUSEJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 13:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBUSEH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 13:04:07 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96511554A;
        Tue, 21 Feb 2023 10:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S72JB93pLbdwmWS11tzEG/X49SQNqJjsYyl7DI7tdQq56F4OfCE3OCpibSl64z5lWrTKhsTD9lYeg/27bEqhY/BGAFNxpM7bHnb3in2YDqJbyXVUH66PX5WUjV7dRbpe9kc65RcaZ0S+4Y+VWixHmhTi7haPjqM5m77uvaHP2HMQy2dQBNAruTLIsaD/gXnRGWAeOX9cXYYQr/J7oyg6ATc3pkrQ5GDOC30yuzmvItDT9nib7nj4Wlc43unF24jdX0+XAQXLUT+J/dJ5jwijYwHE9K1Vz/Darwr0J0BoKojg/MOhnLVJdqrXDnXanD+K0Ga+RH5ZXIXJzd3MbcNi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiZ1T9W8rI0nSik7AWw5HX9R/24n2bpB8kZOYRiZ2Sk=;
 b=J8JdLLAcOI9ERxANsK6FiBWZyt9JD0fT0f+UNP4ivKTjhFh+bFN+1LYtKSw2BhV+PQBSG+QYa5DtlpGmRM0Le6zeS0Gv8stJv/jTUabLrr6u+Z9nyiYFfcHtdOYGqVT+Ezyt5MwznqNBNVM20kOWfgz81taAQO377qxLU5uCkvpbLWBUpP68ww1fLNtXl02TQJk8+yeSLXYjbxiNuz37GO4nDPAZKnLi4KTDsRY0SIgrBuEaXjJ2Iek/+EjqesxBE4r9O6rsLCkcAd0x8dewvb33IAVyosKIV1Ax1DFOl6AlFDiGcNMxWHKf18l/IuYACIlu1kjfH8bW687DmDA4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiZ1T9W8rI0nSik7AWw5HX9R/24n2bpB8kZOYRiZ2Sk=;
 b=bbt4ZlpbfxrfNdm7pM49dG14wSAcKEL/sqBtK7/u7n4AZ9FmlZjIElz7jKJ4v78U/1A1MqjYj2X3wWNScntCfc7TY5VyxjavMsN1SY1SzodnpZteaPUphp0ibbfgxpoibWXdeOJY2FnBdEnh6yCriLuN6wGCTMX0JnuTL6EX9NJUa/dIhuTzEqVB1P70yEmb0cxqFEmWpzsLq7grQDMgSq/oAsD2Yb4tU57/HWOulTFPFG/zaD7hQxuUvThF+eGcor5BiFbUxMcUeZZ7bc5jzWCZffqTt3dcmXvmnYfRg1HQ7f7Yk4AzeNIWjMQ4z9u+KTIiv0VmEtyPVn6L9IKXGQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 18:04:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 18:04:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Hou Tao <houtao@huaweicloud.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
Thread-Topic: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
Thread-Index: AQHZRS7sDYChPU1BtUarNqVd2VXnYK7Zs2eA
Date:   Tue, 21 Feb 2023 18:04:03 +0000
Message-ID: <65a521aa-dbb9-0638-174c-3762df89fe83@nvidia.com>
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
In-Reply-To: <20230220135428.2632906-1-houtao@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6562:EE_
x-ms-office365-filtering-correlation-id: 013941ba-3cd2-4795-5d90-08db14360469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6ygxv5V7LSIvxuBmKYpBem8OSiKV3hyfwC/O+DHOb4D9+HxaVBODww/w7oZX18dHu6mU9cgTtkmdhyOC5kYt5kzocMjNwa4huGmsekVzraPp+MwHpEz3oNpR3imcZY5qz++ft2MFGhGDVeA1kfunh6VATDJ1lU23CSKhk6q+sXFB7GkaXR6cdOHBt1YZlgzmtHr33Xz0VqEihEYsbwXu66rCm8ep72rRTdftYbOM4mDwQ3s/8qUZp5R4Wo+nwHunxunJOXVtCmmC/Eo1c8U02r2czoK2nKrRnW2P1HocQdHC7fEaC14m0eLttpgSMVWQXR4PZuAg/F14+kaFkGaFgEx4WHs8eIa+BzwxOUm9DWGFpfuElKgAtBd4YlVv108E6T8QCJtS8gM2R7LwDBSy/ZcWrM1lvNECkcja7a37144ufnLcJDoVwLpBnWGUKFE6vL7+2woEEoWmfbOE59c5HMyf6mwPy/CnujZMfwq9bGOyqjP9XELW/7bxNoKFC7mM58YCrkZe6aQsb4ZRyszBhJ43n9AtqYFBIbLgt/3QF/Y4nTMNwfFpQRtg18VxIiQdrpFn2nJaejk8nnHUPxsQZ+6QQZU3TKYCP5bBVsInIBBQJlTv3lDmhqKw9GC+S9XbIoyCWquty2BscQhEdzGZeFuHPwGtd5bhcQuO1yQPYDUYcvU2UEOEUNB3iDu6XVy/THXOIrDkje8Xob3+A/59LTr4hTK+aDRidHAQq+qWvJ1giroNFJdYuA8/m3QF7XQyq9upLk/Xtf3i4ScqfQMag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(31686004)(8936002)(31696002)(86362001)(38070700005)(36756003)(41300700001)(5660300002)(7416002)(2906002)(83380400001)(38100700002)(122000001)(64756008)(66476007)(66946007)(66556008)(478600001)(76116006)(66446008)(8676002)(110136005)(71200400001)(6486002)(54906003)(186003)(316002)(26005)(53546011)(2616005)(91956017)(4326008)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVybXdHeDh6TFdTR0hjQVp2K1hVTmlBUjRvdnZxU0lRM0JFcWlxQzB3OFBy?=
 =?utf-8?B?MDV2aDV3RU11WXI3aERsYlhVMU1uemh6Z2pFaDYwWjhVbEVSY2Y0ak9OVS8z?=
 =?utf-8?B?MWcvWXFMcW4ybUxLTVBkUDNBOUR1bmVubCtxdjJHWWZ5ZCtYY1lrTXc2b1lw?=
 =?utf-8?B?YlJnYU5CQlZXckgwdFZrMVRUT3JUaFM4aEVPYnEvT3hMUk5DVG5yNDhFbHVV?=
 =?utf-8?B?V3o5Q1NJcDV5NzBudDBIc09vRzBSQ2l0SjJBMHJ1RUlqbnZ5ZzlDZURURStS?=
 =?utf-8?B?TDIxUHVob2I3bnFvMVdpNUJseHJsWFFOUExWVnYwSDhBcEdmMGltZElCNUkr?=
 =?utf-8?B?VERDT3VoaGZvQUtnWWFlYitVWGNyVFlMMHpiK2JzRmpUaU5wY2hCZVdDalFj?=
 =?utf-8?B?bUtQdzZxbUdpZ1lPOW1sbllHaVVvditpOXhzbnlsM3F2R0g4TDEwS1l0RkdR?=
 =?utf-8?B?R0F2ZmUzWm5IZjNDci9oUjFjSFU3aUFteXhTbU1vSzVhN1dFam1YdXpkTk5R?=
 =?utf-8?B?UGFBQkhhWXdLWE1ubkpNWDNkdVcrWUdCRE9DMnJQWmY2amlxQUpONlhvcnJz?=
 =?utf-8?B?aTZUT0UwdWo1Sks0Vm9SbTU0UzRFeDJ2ZkxJRFNqZm1UMjZLMyt2QnYvVFhx?=
 =?utf-8?B?RERmaXU4TFE3OVArNTJZY1M5WnZkaG5UV1c4MlVLUHFhOFVMdFlxSWc2cDZL?=
 =?utf-8?B?c1V6bnhzSE1Hc0dOcGZYend4Slk3bDNmRHhuZU9JMWtuZVhRYVU3SmZveXpM?=
 =?utf-8?B?N0F3YnlaZFBXSHlZa0diSmpSSWM5bnZCWDdWbyt2QnhnYW1OWDVraC83eXhU?=
 =?utf-8?B?MDRTUEhDNGVPWHdHUEtTR2J0bnpRc2NHTFVTdjF3empYNEVBdXpEdUtsUFQx?=
 =?utf-8?B?c0QyYmViNUg2endRM0F5MTUxUEtUamkxOXdabkFyMWtCY3V1SjFqbFlpZ3VB?=
 =?utf-8?B?YjJTQ1F1aWtCTG9NSzFvc2JJT2VpNG9EK3lzeEZFSmlKS05GVmpScXBhRGNy?=
 =?utf-8?B?RjduYmE4cmp2eUhGWng5eC9SK28vNGVqV0wzQnllSFlNaGZBZjdGOUVZL1k3?=
 =?utf-8?B?SzQ2OSttRjRnaTN6a3RBYTlRbmxuVno1SG8vY0VObXJKSU9iS0dGSmcwaG9w?=
 =?utf-8?B?a1ZDWkZQMXIxbVUwb014QnhKYU1naDR0TUJ3b2pyT25sSlU5Q0VUZzIvelhP?=
 =?utf-8?B?Z29VVkd2Y3BqbkZBUGpyRkFnUlUyWnU3MWNXVWtQVStJaWRieWVabDdvRHBC?=
 =?utf-8?B?RGw1OW91am8xK2ZzV2lDVElyTUVlejU5S0xhWlpsTXRRVnd1Y1hmUi9GODhG?=
 =?utf-8?B?c0dFbTg4VDJLZU1nY20zdklJK1Z4OVZodzErNDRNbnBZaUV2ZHNVNGhneW0x?=
 =?utf-8?B?MjBGc0tSbzJadzBMUFVYcGI3cmdVM0hPWWFpYnRNbHc1VFFJK1Frei95Z2l5?=
 =?utf-8?B?aHBIOWFCb3ZaQTZhbU1TRVFiWVZMTFJ2NFdDTXJCNGx5R2N2bithQ25tTEdI?=
 =?utf-8?B?Q1pUeDEvZUhtVnlpTk5uclR4OUJnVVgyL2dkQUFuaWJMQnhHK1J5ZngyVmRu?=
 =?utf-8?B?TlB6bTllUFY4b0ZZejJ3NmVtZXN1bTJoTXRMTDB1RHAwOGlrK2F3QU4xZnZT?=
 =?utf-8?B?R0YvU251eTdITmJJdExjZDI5dDlyYjluektsdzdvR0I2R2NTaEwwdTNzbGRa?=
 =?utf-8?B?cXVXb1BRNVRydGNyY01Wbk5pdlNXaFYveXJWa0hMZVNmT0FjemttQUZhZXQ4?=
 =?utf-8?B?cUxqQ0trK0N2bmN5bHhuc25BOUxUcXRoVnBjRmxOaVhsYm16NHloSTJiczg5?=
 =?utf-8?B?elpVRVU2MkJNRlNCSmZTUEtYK3BVWUw1MU5nQXZET29RTGs5cUJTSVNxbUJq?=
 =?utf-8?B?NUpNZFJHMzNMZmh4ZkZodmRxcjJuZVFyMzhIRDA4MFJzZzhTSS9OWXJFRUtL?=
 =?utf-8?B?UW9PNDY0bHlrcHJKUHIyVmF5OUdDVTdUNHdTUzMrMm9PTkd1end1aEJ4RElz?=
 =?utf-8?B?b3Q0bGFOaDgxd3JzcllGMkV1a3R6T3hSVTczeXptVmFWVHREbmFjSVVvZEZB?=
 =?utf-8?B?TjB0R0dxUllWY0ZwUS9PMEVoSVV0Wis4SnFaQVl3QUs1bWdKK01oYWFScVZN?=
 =?utf-8?Q?CKfCALCksuulRZj9wXsfNZYRZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16CCC625A940804EA4F52256A538E45C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013941ba-3cd2-4795-5d90-08db14360469
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 18:04:03.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZEjEzEZWASEK9CsOJK+stnXApQ/mXl9jhdXH6SSrHyLWdGhfG/YiM8pyCUhpBe/OgKhZrWPSJD/6TlpP94S2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gMi8yMC8yMDIzIDU6NTQgQU0sIEhvdSBUYW8gd3JvdGU6DQo+IEZyb206IEhvdSBUYW8gPGhv
dXRhbzFAaHVhd2VpLmNvbT4NCj4gDQo+IFNpbmNlIGNvbW1pdCBhNzg0MThlNmEwNGMgKCJibG9j
azogQWx3YXlzIGluaXRpYWxpemUgYmlvIElPIHByaW9yaXR5IG9uDQo+IHN1Ym1pdCIpLCBiaW8t
PmJpX2lvcHJpbyB3aWxsIG5ldmVyIGJlIElPUFJJT19DTEFTU19OT05FIHdoZW4gY2FsbGluZw0K
PiBibGtjZ19zZXRfaW9wcmlvKCksIHNvIHRoZXJlIHdpbGwgYmUgbm8gd2F5IHRvIHByb21vdGUg
dGhlIGlvLXByaW9yaXR5DQo+IG9mIG9uZSBjZ3JvdXAgdG8gSU9QUklPX0NMQVNTX1JULCBiZWNh
dXNlIGJpX2lvcHJpbyB3aWxsIGFsd2F5cyBiZQ0KPiBncmVhdGVyIHRoYW4gb3IgZXF1YWxzIHRv
IElPUFJJT19DTEFTU19SVC4NCj4gDQo+IEl0IHNlZW1zIHBvc3NpYmxlIHRvIGNhbGwgYmxrY2df
c2V0X2lvcHJpbygpIGZpcnN0IHRoZW4gdHJ5IHRvDQo+IGluaXRpYWxpemUgYmlfaW9wcmlvIGxh
dGVyIGluIGJpb19zZXRfaW9wcmlvKCksIGJ1dCB0aGlzIGRvZXNuJ3Qgd29yaw0KPiBmb3IgYmlv
IGluIHdoaWNoIGJpX2lvcHJpbyBpcyBhbHJlYWR5IGluaXRpYWxpemVkIChlLmcuLCBkaXJlY3Qt
aW8pLCBzbw0KPiBpbnRyb2R1Y2UgYSBuZXcgaW9wcmlvIHBvbGljeSB0byBwcm9tb3RlIHRoZSBp
b3ByaW9yaXR5IG9mIGJpbyB0bw0KPiBJT1BSSU9fQ0xBU1NfUlQgaWYgdGhlIGlvcHJpbyBpcyBu
b3QgYWxyZWFkeSBSVC4NCj4gDQo+IFNvIGludHJvZHVjZSBhIG5ldyBwcm9tb3RlLXRvLXJ0IHBv
bGljeSB0byBhY2hpZXZlIHRoaXMuIEZvciBub25lLXRvLXJ0DQo+IHBvbGljeSwgYWx0aG91Z2gg
aXQgZG9lc24ndCB3b3JrIG5vdywgYnV0IGNvbnNpZGVyaW5nIHRoYXQgaXRzIHB1cnBvc2UNCj4g
d2FzIGFsc28gdG8gb3ZlcnJpZGUgdGhlIGlvLXByaW9yaXR5IHRvIFJUIGFuZCBhbGxvdyBmb3Ig
YSBzbW9vdGhlcg0KPiB0cmFuc2l0aW9uLCBqdXN0IGtlZXAgaXQgYW5kIHRyZWF0IGl0IGFzIGFu
IGFsaWFzIG9mIHRoZSBwcm9tb3RlLXRvLXJ0DQo+IHBvbGljeS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEhvdSBUYW8gPGhvdXRhbzFAaHVhd2VpLmNvbT4NCg0KDQpUaGFua3MgZm9yIHVwZGF0aW5n
IGRvY3VtZW50YXRpb24gYW5kIGFkZGluZyBtZWFuaW5nZnVsIGNvbW1lbnQuDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
