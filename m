Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C6621F87
	for <lists+cgroups@lfdr.de>; Tue,  8 Nov 2022 23:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKHWuP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Nov 2022 17:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKHWuO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Nov 2022 17:50:14 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C360E99;
        Tue,  8 Nov 2022 14:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvcY+ur4mlgJ11jZT+Xk4tzbHJB0ExRgr/4L6vLpq8ob+vuY5Kyw1NdMqxhGLsshnD7lTEKe+Yp4rffF4uxJblIpKAWk8aCHd2r8Y5pgH4V6MoX5hA1CoxUGfUZgV6CbLB+W+GtHhdSZ7Ftmg8rHYs+qq3sFWojXgqvn6wlAkZyiSf6nbS7L4T7tL9nsRGGyIvd+92A4XdASH+U/k7ti0uilc2bMU8F+YcCAPm1kWcgrMTnAWzNltzkQhA7rqBusuwglWoF0UBIlJArBi7Mvz0oQdD6BeTsJlYsG3fXni/kriv74aRauPD69JqALCyMMGHwacjy/tWDKoQjBm7s7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhn+9Ui3M67t3XW/MjbUG2SmvMUJ29TAPu9muTtJZbc=;
 b=IchB9DySGixkHNj3FfTSW93zY6k+NS+coa0W8pTSTzvUerxyMTzCUikgtaJKAGW44OJoN3mBL+5LvkblObnMrmRq8VDJRNyByep7W0/tKvaXy98E5s/XycYZpfUxi60nUMk/c9P1BIpTWh7Z13Uz03tTTGE3qwl9D+Uw+8M8XHGAdz7VmYzuLDWpVlUbw1QK7NfJWCd/OLjDbg2xzqsC0EpS25ouh/Blx2zwuzQmTcQr2Zf1I+h37DCxkUYwS05Vo9jT1IEU901gYDQ5lkg5dca0M/f4zbrgUFTifxAfjc4EM6IcZC2ELn89veP79hSBlClIFV83EAVkB4t7GMdNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhn+9Ui3M67t3XW/MjbUG2SmvMUJ29TAPu9muTtJZbc=;
 b=Sq1sERNHx5dV7jEuSVkN1Y5W3oDWsW7+/6LZd7tXsOA0ALJRN1Teaya65RQmKJ/HIEgz45YbOucNR6cqH1ktdKO2/0Dbd++mwDEFiqlVghVUXB1oszXjknJoKYhRNpOmIjUEtMNJdbUHzpHEHRMsa82NeBQC3sHSg/ZlnZhjxqkxbeqvnAeINJMb2I0mC6EUT/6Y4aZWXEI2ZAEZinYanP+Yh9EghX2o/zcOfbzCQQHcREmadbB7LT9eUvjxa0WjrsqfvEJ1YoJt0keGCQiymm/gB7Eax2qaCy/ObeEJHOPhtIRrJ3hImz6amgiRVVz+88ZIxLCpVFE4SNoY+1ZjGQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 22:50:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 22:50:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, "jack@suse.cz" <jack@suse.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] block, bfq: fix null pointer dereference in
 bfq_bio_bfqg()
Thread-Topic: [PATCH] block, bfq: fix null pointer dereference in
 bfq_bio_bfqg()
Thread-Index: AQHY81q1Tj9TzKlyFk25MoVowvtkMq41oi+A
Date:   Tue, 8 Nov 2022 22:50:07 +0000
Message-ID: <9e0d8652-adda-3d39-88cd-d735194d4083@nvidia.com>
References: <20221108103434.2853269-1-yukuai1@huaweicloud.com>
In-Reply-To: <20221108103434.2853269-1-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB5883:EE_
x-ms-office365-filtering-correlation-id: 7e34f15d-1859-48c2-e9fb-08dac1db9589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxosOyAdD1l2PzJDBTHV6W/DGJMkPAe2C4AAESc73jT4Ahopm8qIr8AlrO+f5O8huUexWGv85lR2G0tVpgvsf8WXE2QdtuHKZdN9c6GN7TPk/Rvvtd7MZMGvHBjJO5B5dWx0txzLBSEequ2QNG0KUn2y4E3zbQ9VZXCn+hJh+u1zaxS2IMO/40hQri39NV33n2qLBkMx6pvm95ggFbYH0AJjQd7qkFBlvVGj3C8R+2iKrBnrqYxwsi/e7cTVqwFk0h3dShII6FaKcBQFKgTr+Te0D4pJjjS4utaxe4IHCnsnQipohALpseY/J/Tyu1tUnseaFpBT0fNfk6ARjUVFhnWpiYp9ZGkzjhZZJUvmJfcdHIz2Nn0HHi3lpWOxwLh9ZHUIDVvbZgFIShnJgVzQ756LtPRPgbh5G2FIcgU5YZDqUzPC8JlHkdast3u2rmERc1qAHMvUGF4u1kEKavvBP2OqGWX0Q6S9+qamZ+mAozAH2GcEAxIWlpIAR6iMOa76V5LhYOUXjXR2pkC81qHKZn3bhoeQFpE4KAKXaUr4e1RRkTvsZKT/ujXDETEw/Ms0xeeG8Fbsubr883OGRfHV708Ww5tECm7OaOBZwevdpq3dJYM3baeS/n/vMQh1fy/SW4VNUZ02tnj2Wqtt7/UDXrPH6xSgdSiQZf4ZNxCPt9RCdlDfy1qq/cOBxEuhKvNZ1TZVNUX0xytmKbW5AlsTnCFWX8mDu5imIoLgzpypkat9+X+dxLpxxeP9H4AXDgRnUW//YzUp7GCe1jSgoiZ/zExGJ9Qovi0NcEgg26fZMvYiNtGfNOWjd/2G8XgdYWJg3p7ADjfqxI7yNcGnUFT49g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(45080400002)(2616005)(186003)(110136005)(54906003)(71200400001)(53546011)(6486002)(36756003)(316002)(6506007)(478600001)(38100700002)(6512007)(38070700005)(122000001)(83380400001)(31696002)(86362001)(2906002)(66946007)(76116006)(91956017)(8676002)(66476007)(4326008)(66556008)(66446008)(64756008)(31686004)(41300700001)(7416002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzhudkxpNEJleC9NeFRFSDdjN1ltMTZmT1B2NXFzU1dlYUw0UkhEeVR6ZDdH?=
 =?utf-8?B?QUZwSjVGMVNrV3B6djNwSUxLMFlUc3pHaHp2M1psVk1NMEJPVnl3RnVnTmcr?=
 =?utf-8?B?aUN6SHM1RUtoamI0dmZHMHozc1MvaW1FR2QrK0ZoVDdrYWRFNVplWXJFMU5I?=
 =?utf-8?B?TmdOZjdTRm9FNFZYaXd3OVZ1TGpwT2NTSmV3eURLY09pMlN0QWVOWW00ZE1p?=
 =?utf-8?B?T3RxVVMzZ2tkQVJEUGxlTXF0a2hwZnZEc1dXQ2hvKzR4VDJDR2RVenFlMkth?=
 =?utf-8?B?ODhhV3UyWGZPOGZaQUhJdVBrWjZXZTgzbmozVGoxVStTOENqVUE0dkF3VElx?=
 =?utf-8?B?OThhd05TaXlBaG1IazNKNjdpZXU2elJyNVZNY0tqZzV1VlpjOU10K1VHYTMy?=
 =?utf-8?B?YVFwL2VsQkpQYUJoNnpMUlJvTHZ0Zmg1VkpvRW82SG02ank4RklkcWlqb3A3?=
 =?utf-8?B?RDhtTnppQXRUUmR0QzRiMjRYTzJscS81UDE3SHpMbmFRbGRDRDh1ZFErZ2g4?=
 =?utf-8?B?dTdEVm9NaDNGVXcvUWpmQ1dyMGxNMDBlVEJ0dHVIT2I1RmxtYW83RUNmcTZI?=
 =?utf-8?B?UXJqdG1udVlnbTNoOGNlS1E4OFhZRndTUWhmT1RhMEtLN0J4WWNXek53YUwz?=
 =?utf-8?B?a01MSnMxUGRKMHQ5cXJwcHk3Snp1ejYrNTJKNGNtc1FmK2s0NHA4NCtsdkJL?=
 =?utf-8?B?SjF6V0NSdC9vSm8wRWFMSk5pSlJwRHV1M25uRTMzVDJPWEU0L240N1pZRUZP?=
 =?utf-8?B?QWpBOHBnSEFBUUc4bUVudmI3eXBLQnBESFRmT2lnNE9YM0Y5T3RDcWcwcjJx?=
 =?utf-8?B?LzgzR3FpUmEyM2svSlJ0NEUrUFpMTGdmWVhTN3FhbUdyMHpSVmJNMGlLMXcy?=
 =?utf-8?B?eEkzQ0lDaUNrZTBNSEpENTd5NkNETVE1b3V4WVkyT29jLzlFWUNmbWx1WWlL?=
 =?utf-8?B?MlRxZVFkTzFsNjRqOFhRNzlzdDNlTWtOUElaYllOSUVZYnZlU2xZanhoVnFW?=
 =?utf-8?B?U3hQeXlDREZWR09ZZ0NZTHhpYVpudkpqS3B6WFlMbWdjUkh4QkFhL2RZak0y?=
 =?utf-8?B?ZklCRE5EMUx2MlQ2a3JYa1NPZEh6enFGWDFEYWFhNlRDdmxUVkNFd0N3QnJD?=
 =?utf-8?B?T0VnZXB6TURoN3ZJelhmTVNuVGU1VUFaV1VnSTZ1TXZ3VVMzTHhMbFBBckl5?=
 =?utf-8?B?NGE4WnAvbHhMQ1ZzbWRkUXhGRzJMdHEveGJMYzgremI0QXVkUWFqNWdZNkxx?=
 =?utf-8?B?N0dyYlh0MkJ5S0hZemY5Y3NBQ2QydFBmcllHWGM2T3g3QlZjdUxzeEdIelVS?=
 =?utf-8?B?NGtmYkxuUkdBR1NzV3hRSnF4RHN1YW1DQUhGdWZ4bmt3dGc1MUxXS05NamJr?=
 =?utf-8?B?Vkcyb2RGZENGM0E2S2JiL2s3NzYzRlduaUNBN1B1MU80VlFZR2F2OUdSYlpR?=
 =?utf-8?B?eHhSWm1SNi96V3NIZ0lud0pPRkh2MlJZN2NYOVdkMTJQLzc4L3NXayt1NXhC?=
 =?utf-8?B?YUozRy9zK3cwNmhVNHl1SHNScCttMG5OMDZ5RXdZMGtZL0VUTnpyeFgzWGht?=
 =?utf-8?B?T250UTZIS2ViUEpLWDgyQkNMdTI0dHNCNncvaE0wUzVVNmRwY3c1ckVFY1hv?=
 =?utf-8?B?Vk85OXlKY1FmdlNRbEp1bnZqQWkrM0FQQjVJMm8wa0FibnU3MHpwalpPNW04?=
 =?utf-8?B?WnEyelQwWHdpK29UTzVHYkNrMFd6Z2V1clpzL3BsczcxSEU0N2NkREpMKy83?=
 =?utf-8?B?WC80VThxUFc1OWlaNjRHMXdBNzhXZWlaWGZqbERWYkVTMThPYXVWc3l1dlZW?=
 =?utf-8?B?WWNyVXpCYkNydkVKTTFyR2VienJwMHJPcllNaU9Ia2dKNGxsWHZoTGFSTFBh?=
 =?utf-8?B?emRXY3lDVldtZkN2K3hPS1FiVGd5b2N5WVRydmVRbnZRNVZhVEtieE9KY3RI?=
 =?utf-8?B?UGdINjZEYlVTcmlqNUl4ZXNjUU9WWDh2aTFQMDQ5OWczankwTTk2NEtGT0Zn?=
 =?utf-8?B?WWNTcWlqdk9DbVM4UXF0QVhUVGh3b1gzalJrWWR4V2M0dTRhck9RRzFVZTJ4?=
 =?utf-8?B?OVB4Vm1Xc2hPQjdWa2FQclZ2RVRoODJ0VTRod05LNVVwbFBURUFXZVk3bmEr?=
 =?utf-8?B?YXg5VGtsV1g3MFdGbjdnNklkeFlOUkNRbER0Uk5oeW1oWUdsRzFMeDdGdWlw?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F5DD32547486040AF739604409FF504@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e34f15d-1859-48c2-e9fb-08dac1db9589
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 22:50:07.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KT6XrEHlcLQKpSzhOTL6eIMAJRDaIosEI66wAM9mZU8D2b5H7z+GgCh+pErb7qKL5ePebTs2P2oOwIHsFphywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gMTEvOC8yMiAwMjozNCwgWXUgS3VhaSB3cm90ZToNCj4gRnJvbTogWXUgS3VhaSA8eXVrdWFp
M0BodWF3ZWkuY29tPg0KPiANCj4gT3V0IHRlc3QgZm91bmQgYSBmb2xsb3dpbmcgcHJvYmxlbSBp
biBrZXJuZWwgNS4xMCwgYW5kIHRoZSBzYW1lIHByb2JsZW0NCj4gc2hvdWxkIGV4aXN0IGluIG1h
aW5saW5lOg0KPiANCj4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRy
ZXNzOiAwMDAwMDAwMDAwMDAwMDk0DQo+IFBHRCAwIFA0RCAwDQo+IE9vcHM6IDAwMDAgWyMxXSBT
TVANCj4gQ1BVOiA3IFBJRDogMTU1IENvbW06IGt3b3JrZXIvNzoxIE5vdCB0YWludGVkIDUuMTAu
MC0wMTkzMi1nMTllMGFjZTJjYTFkLWRpcnR5IDQNCj4gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFu
ZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgPy0yMDE5MDcyN18wNzM4MzYtYjQN
Cj4gV29ya3F1ZXVlOiBrdGhyb3RsZCBibGtfdGhyb3RsX2Rpc3BhdGNoX3dvcmtfZm4NCj4gUklQ
OiAwMDEwOmJmcV9iaW9fYmZxZysweDUyLzB4YzANCj4gQ29kZTogOTQgMDAgMDAgMDAgMDAgNzUg
MmUgNDggOGIgNDAgMzAgNDggODMgMDUgMzUgMDYgYzggMGIgMDEgNDggODUgYzAgNzQgM2QgNGIN
Cj4gUlNQOiAwMDE4OmZmZmZjOTAwMDFhMWZiYTAgRUZMQUdTOiAwMDAxMDAwMg0KPiBSQVg6IGZm
ZmY4ODgxMDBkNjA0MDAgUkJYOiBmZmZmODg4MTEzMmU3MDAwIFJDWDogMDAwMDAwMDAwMDAwMDAw
MA0KPiBSRFg6IDAwMDAwMDAwMDAwMDAwMTcgUlNJOiBmZmZmODg4MTAzNTgwYTE4IFJESTogZmZm
Zjg4ODEwMzU4MGExOA0KPiBSQlA6IGZmZmY4ODgxMTMyZTcwMDAgUjA4OiAwMDAwMDAwMDAwMDAw
MDAwIFIwOTogZmZmZmM5MDAwMWExZmUxMA0KPiBSMTA6IDAwMDAwMDAwMDAwMDBhMjAgUjExOiAw
MDAwMDAwMDAwMDM0MzIwIFIxMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBSMTM6IGZmZmY4ODgxMDM1
ODBhMTggUjE0OiBmZmZmODg4MTE0NDQ3MDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KPiBGUzog
IDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODgxZmRjMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQo+IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwMzMNCj4gQ1IyOiAwMDAwMDAwMDAwMDAwMDk0IENSMzogMDAwMDAwMDEwMGNkYjAw
MCBDUjQ6IDAwMDAwMDAwMDAwMDA2ZTANCj4gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAw
MDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gRFIzOiAwMDAwMDAwMDAwMDAw
MDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4gQ2FsbCBU
cmFjZToNCj4gICBiZnFfYmljX3VwZGF0ZV9jZ3JvdXArMHgzYy8weDM1MA0KPiAgID8gaW9jX2Ny
ZWF0ZV9pY3ErMHg0Mi8weDI3MA0KPiAgIGJmcV9pbml0X3JxKzB4ZmQvMHgxMDYwDQo+ICAgYmZx
X2luc2VydF9yZXF1ZXN0cysweDIwZi8weDFjYzANCj4gICA/IGlvY19jcmVhdGVfaWNxKzB4MTIy
LzB4MjcwDQo+ICAgYmxrX21xX3NjaGVkX2luc2VydF9yZXF1ZXN0cysweDg2LzB4MWQwDQo+ICAg
YmxrX21xX2ZsdXNoX3BsdWdfbGlzdCsweDE5My8weDJhMA0KPiAgIGJsa19mbHVzaF9wbHVnX2xp
c3QrMHgxMjcvMHgxNzANCj4gICBibGtfZmluaXNoX3BsdWcrMHgzMS8weDUwDQo+ICAgYmxrX3Ro
cm90bF9kaXNwYXRjaF93b3JrX2ZuKzB4MTUxLzB4MTkwDQo+ICAgcHJvY2Vzc19vbmVfd29yaysw
eDI3Yy8weDVmMA0KPiAgIHdvcmtlcl90aHJlYWQrMHgyOGIvMHg2YjANCj4gICA/IHJlc2N1ZXJf
dGhyZWFkKzB4NTkwLzB4NTkwDQo+ICAga3RocmVhZCsweDE1My8weDFiMA0KPiAgID8ga3RocmVh
ZF9mbHVzaF93b3JrKzB4MTcwLzB4MTcwDQo+ICAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4g
TW9kdWxlcyBsaW5rZWQgaW46DQo+IENSMjogMDAwMDAwMDAwMDAwMDA5NA0KPiAtLS1bIGVuZCB0
cmFjZSBlMmU1OWFjMDE0MzE0NTQ3IF0tLS0NCj4gUklQOiAwMDEwOmJmcV9iaW9fYmZxZysweDUy
LzB4YzANCj4gQ29kZTogOTQgMDAgMDAgMDAgMDAgNzUgMmUgNDggOGIgNDAgMzAgNDggODMgMDUg
MzUgMDYgYzggMGIgMDEgNDggODUgYzAgNzQgM2QgNGINCj4gUlNQOiAwMDE4OmZmZmZjOTAwMDFh
MWZiYTAgRUZMQUdTOiAwMDAxMDAwMg0KPiBSQVg6IGZmZmY4ODgxMDBkNjA0MDAgUkJYOiBmZmZm
ODg4MTEzMmU3MDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPiBSRFg6IDAwMDAwMDAwMDAwMDAw
MTcgUlNJOiBmZmZmODg4MTAzNTgwYTE4IFJESTogZmZmZjg4ODEwMzU4MGExOA0KPiBSQlA6IGZm
ZmY4ODgxMTMyZTcwMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZmM5MDAwMWExZmUx
MA0KPiBSMTA6IDAwMDAwMDAwMDAwMDBhMjAgUjExOiAwMDAwMDAwMDAwMDM0MzIwIFIxMjogMDAw
MDAwMDAwMDAwMDAwMA0KPiBSMTM6IGZmZmY4ODgxMDM1ODBhMTggUjE0OiBmZmZmODg4MTE0NDQ3
MDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KPiBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkg
R1M6ZmZmZjg4ODgxZmRjMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+IENTOiAg
MDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gQ1IyOiAwMDAw
MDAwMDAwMDAwMDk0IENSMzogMDAwMDAwMDEwMGNkYjAwMCBDUjQ6IDAwMDAwMDAwMDAwMDA2ZTAN
Cj4gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAw
MDAwMDAwMDAwMDANCj4gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZm
MCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4gDQo+IFJvb3QgY2F1c2UgaXMgcXVpdGUgY29tcGxl
eDoNCj4gDQo+IDEpIHVzZSBiZnEgZWxldmF0b3IgZm9yIHRoZSB0ZXN0IGRldmljZS4NCj4gMikg
Y3JlYXRlIGEgY2dyb3VwIENHDQo+IDMpIGNvbmZpZyBibGsgdGhyb3RsIGluIENHDQo+IA0KPiAg
ICAgYmxrZ19jb25mX3ByZXANCj4gICAgICBibGtnX2NyZWF0ZQ0KPiANCj4gNCkgY3JlYXRlIGEg
dGhyZWFkIFQxIGFuZCBpc3N1ZSBhc3luYyBpbyBpbiBDRzoNCj4gDQo+ICAgICBiaW9faW5pdA0K
PiAgICAgIGJpb19hc3NvY2lhdGVfYmxrZw0KPiAgICAgLi4uDQo+ICAgICBzdWJtaXRfYmlvDQo+
ICAgICAgc3VibWl0X2Jpb19ub2FjY3QNCj4gICAgICAgYmxrX3Rocm90bF9iaW8gLT4gaW8gaXMg
dGhyb3R0bGVkDQo+ICAgICAgIC8vIGlvIHN1Ym1pdCBpcyBkb25lDQo+IA0KPiA1KSBzd2l0Y2gg
ZWxldmF0b3I6DQo+IA0KPiAgICAgYmZxX2V4aXRfcXVldWUNCj4gICAgICBibGtjZ19kZWFjdGl2
YXRlX3BvbGljeQ0KPiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGJsa2csICZxLT5ibGtnX2xp
c3QsIHFfbm9kZSkNCj4gICAgICAgIGJsa2ctPnBkW10gPSBOVUxMDQo+ICAgICAgICAvLyBiZnEg
cG9saWN5IGlzIHJlbW92ZWQNCj4gDQo+IDUpIHRocmVhZCB0MSBleGlzdCwgdGhlbiByZW1vdmUg
dGhlIGNncm91cCBDRzoNCj4gDQo+ICAgICBibGtjZ191bnBpbl9vbmxpbmUNCj4gICAgICBibGtj
Z19kZXN0cm95X2Jsa2dzDQo+ICAgICAgIGJsa2dfZGVzdHJveQ0KPiAgICAgICAgbGlzdF9kZWxf
aW5pdCgmYmxrZy0+cV9ub2RlKQ0KPiAgICAgICAgLy8gYmxrZyBpcyByZW1vdmVkIGZyb20gcXVl
dWUgbGlzdA0KPiANCj4gNikgc3dpdGNoIGVsZXZhdG9yIGJhY2sgdG8gYmZxDQo+IA0KPiAgIGJm
cV9pbml0X3F1ZXVlDQo+ICAgIGJmcV9jcmVhdGVfZ3JvdXBfaGllcmFyY2h5DQo+ICAgICBibGtj
Z19hY3RpdmF0ZV9wb2xpY3kNCj4gICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JldmVyc2UoYmxr
ZywgJnEtPmJsa2dfbGlzdCkNCj4gICAgICAgLy8gYmxrZyBpcyByZW1vdmVkIGZyb20gbGlzdCwg
aGVuY2UgYmZxIHBvbGljeSBpcyBzdGlsbCBOVUxMDQo+IA0KPiA3KSB0aHJvdHRsZWQgaW8gaXMg
ZGlzcGF0Y2hlZCB0byBiZnE6DQo+IA0KPiAgIGJmcV9pbnNlcnRfcmVxdWVzdHMNCj4gICAgYmZx
X2luaXRfcnENCj4gICAgIGJmcV9iaWNfdXBkYXRlX2Nncm91cA0KPiAgICAgIGJmcV9iaW9fYmZx
Zw0KPiAgICAgICBiZnFnID0gYmxrZ190b19iZnFnKGJsa2cpDQo+ICAgICAgIC8vIGJmcWcgaXMg
TlVMTCBiZWNhdXNlIGJmcSBwb2xpY3kgaXMgTlVMTA0KPiANCj4gVGhlIHByb2JsZW0gaXMgb25s
eSBwb3NzaWJsZSBpbiBiZnEgYmVjYXVzZSBvbmx5IGJmcSBjYW4gYmUgZGVhY3RpdmF0ZWQgYW5k
DQo+IGFjdGl2YXRlZCB3aGlsZSBxdWV1ZSBpcyBvbmxpbmUsIHdoaWxlIG90aGVycyBjYW4gb25s
eSBiZSBkZWFjdGl2YXRlZCB3aGlsZQ0KPiB0aGUgZGV2aWNlIGlzIHJlbW92ZWQuDQo+IA0KPiBG
aXggdGhlIHByb2JsZW0gaW4gYmZxIGJ5IGNoZWNraW5nIGlmIGJsa2cgaXMgb25saW5lIGJlZm9y
ZSBjYWxsaW5nDQo+IGJsa2dfdG9fYmZxZygpLg0KPiANCg0KDQpQbGVhc2Ugc3VibWl0IHRoZSBi
bG9jayB0ZXN0cyBmb3IgdGhpcyBhcyB0aGlzIGlzIGNsZWFybHkgbm9uLXRyaXZpYWwNCmlzc3Vl
IHRoYXQgbmVlZHMgdG8gYmUgdGVzdGVkIGV2ZXJ5IHJlbGVhc2UgLi4NCg0KLWNrDQoNCg0K
