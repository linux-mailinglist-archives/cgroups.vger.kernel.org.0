Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0488643B34
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 03:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLFCMD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 21:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFCLW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 21:11:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229E248CD;
        Mon,  5 Dec 2022 18:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXsItz7jYO5Qiit0FYadUfQqREzHD42UVuHUwcc1+jtvNn///Z2pag/dsLnOe+jhn6updMS8IehVzYZ8ZAN/7vvvZy90FUVSggzbxiNcWKQ4N+rzXv+6odgMgXTzCcwDP79RTUhLFYMm84+nxatjWm5WnlVILnLIxtmJylloma8YhHxKhWHyrIxYgUIlhLCdL+YG26SD8TrfQqacjNhB06GKe8Biu41nU6xiKINM2dNqM3nvIQdrAwm44B4vPD5KvpebTSS+FT0s9zv/A+yLLVYWxAo1VmomUjcg3M1ZU1c5k61CKKSFGp67ikIhqzXmSjCz0ane/0HGGApNjMS5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdNi8KCoKMXwQNY1CFP9KuxnyY9A5blltKISfwicFmg=;
 b=d/uj6xHeU/pCK1XGv2SVB1kZHdav1QazWBdldE3sfFlcLlDycwPUGUmR4QGsbhEKSglVljVaa4D27VAb5787KMZ68rlc2Elf/z3W//PBbPCH30iHVgeOKveXn8eg1XZ9ALkkWAsDmpPT7rh9IHoz6B5wf7aeZSahBIml5P5y+uOpn4NF+L6FjKVT092QpiGYUk+o8vk830i8UWWsvLh/jVJYmORDgfIfzCqSfUAEoqoh0CQ80r/mbshdqJYebnV2QuLzOj41wwMJZ5POmvHXhgk8+AMoqb4b1iWsJDUIFcP8GawGKmdYGoPet9/rBwSMpwvIPj4gaPDUCDfTyH/OBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdNi8KCoKMXwQNY1CFP9KuxnyY9A5blltKISfwicFmg=;
 b=WLeVBRkvwHu6BRhEZNuxviuANHgsVdK6jAe+GSn5R9jUp7LSMbPSOu/zOFVXIeLjMXfl0EBhM955Vg5LQ21FUOmBstzkTkcQZJjkf+T5s00eLnQi5+deZcH7Zbu7440knt9sUwAQtEUFDCgS9g2zdaqm2jbkMCDPGpJeznLwYNpx0r1Idc0qrNQrjkO+oidhZZ3LFKv7X3Rkuaa4fjTjYSTzJ/WbFSgJqXGbIIkrKf4Kd+dQEaWJ9uu/3gkXmh5114QtBmLYNpc29xaDhESOx1KFmaIPqVTnSgFkWQrUc2XFmqLJKgLfwY6QsOv9h6AjOCELMWyW3cTtluhqSXyLzg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 02:11:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 02:11:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH v3] blk-cgroup: Fix typo in comment
Thread-Topic: [PATCH v3] blk-cgroup: Fix typo in comment
Thread-Index: AQHZCRLVG4rmYPHPKkysDmYXRxHOz65gHdWA
Date:   Tue, 6 Dec 2022 02:11:03 +0000
Message-ID: <503e6c9c-71c0-57d3-4e05-fbfd3870fb8d@nvidia.com>
References: <20221206093307.378249-1-shikemeng@huaweicloud.com>
In-Reply-To: <20221206093307.378249-1-shikemeng@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7506:EE_
x-ms-office365-filtering-correlation-id: bd252b3a-5c32-497b-223f-08dad72f20af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 191Ps5aq7YcHcHrbDhEqTSnjiaGMhu8KhMkbsMRy5BhbW04kurptaWMS8cRljrbR9V5DA/b6tPKVby0mMpjadsqDjmgUMgaLe4Ksx+TBpKAq8OAeGqrP1oH41h2/Kp6U2nqmx5dE+qa9RegcdxYJOE9wTV8+3p1Kwo7+4rumL9rgdrjFYi0FPPmcSqKD3PIABgCda92QO40UdND09mchTBCfArhW8qEczZlPkBP8GiixnaI7eg743O6T51bBgZQwcNDOEHC77vF4l/zAePmaKE8veBJn8hwYSAslfr47x74GdMVx4dvcQ1YdIpmB8l6+OV06ImJXXA7ke2K2NPsdkOKOZAnXXfY7SV5LXilQsoC/enO6fQbocsqs2CCbUrGChkcs8LZo3+XP32HfBMVkXQVH4A9lNkY30Ik9BEQgAbt37DgAGtzVRidxHu5z7Frva8O+c8uXBsmyWiEfIkVzXKZBxN8Fi6ELKO5+etg6+4bRxXLUvSYCDEPb9TLAcgvhY3XxMacFn9jcI+SvwAHkV7NdfEZvFMGlCBCqEU3GK8ft5M+x8ZrMbWxy6iPGMsYNf3zhtPuX6aXBJgAInNtPHo8XvjwkNqlQ+WZZTqWK0UpFiswKDLDqeS5bfrqVu9d77JoiXlR8/2o14vJkXFBdxdVA3HXdUzmLxcSfcI2N1N5vXwmRMrOWb81DGn1kodhBbdANmhEAtt8n0Ma758c4XMVEto2iD7JpBQTAxZY4zxlZK7xUX+3RG+ih0hUVnRl2rTYBNxlkmyESR8boRPOIwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(2616005)(31686004)(186003)(558084003)(86362001)(31696002)(316002)(71200400001)(54906003)(110136005)(38070700005)(36756003)(6512007)(53546011)(122000001)(38100700002)(6506007)(6486002)(5660300002)(478600001)(76116006)(66946007)(91956017)(41300700001)(8936002)(8676002)(4326008)(66556008)(64756008)(66476007)(2906002)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hleVZVRUEyaXE1SFY0RnAvYzJrK3NaSUZybmUrVTVoZ1BVZGZBMDk3T2g2?=
 =?utf-8?B?Wldab2dXUVQrWUwxR1pCcTk5QXozOVM1bXZjcWZTVDhRTUdnQzlhSmZpb2w5?=
 =?utf-8?B?Ylh4aXM5eExOa00yNHpGQmZWRUpwRnRGMEpNMEhWUEZQblMzQUtNdStId2dM?=
 =?utf-8?B?SHIzL3RIQktzUElKMDBoc0tlUkFmbkVwdDhITy9najNYWkRwRVVDT200LzJJ?=
 =?utf-8?B?c21Va1lJV3BydUI4TW5pTDN1RDA3M1JpTWxCcWwxckdTb3VXcmlpRjhPeXRH?=
 =?utf-8?B?bmJweS9YV29nK2d4WkJLNGY3bDQzNUZ6MEtjMUo1aWFOZXpHakpqVnFZcmlG?=
 =?utf-8?B?ZWNZVjIyMjZMZFBMaU1WN3plQTFaeEdPVXA1ZitSSk0rcHRJNUhDYXBqS3I2?=
 =?utf-8?B?T3lLSnVhbWxMNXNWaldrMEZ0d2Y3STVxRGIrN2IzR2NiZTNkeXc1aHI2NWxD?=
 =?utf-8?B?blpRTFI0bnAzWkpHR0EyOCt4WE1jeTAvMDEzcjlkaElqMVZ4Mm9DNkw0c09q?=
 =?utf-8?B?MEJFREtkOFNCY3c4WTA4OUE1TWxpU21DVnhES1lDZE1XditBcGswRGVDY2Zw?=
 =?utf-8?B?SU9NaTZrQUlqUmdEa2tVOWZwT3k4T0ZaS3ZpUkJZK2ZrcDdsdm9WS2N1dzNX?=
 =?utf-8?B?NWs5SDIxWW9OOWx3NS9rNXdGUFo4NmNBd0lNejNILzlxTVIwUFpkcWhPU0Iz?=
 =?utf-8?B?ZkNlSld1d25ISmN3b0kyQXBBQjBXeFhJZ20yL0pqTGtTWDJTTDJ5MVBNRHJm?=
 =?utf-8?B?WjZMMTlhNnFmM2xkOG5FaVJ2LzlmNkdoWk5hMDkxRlpSZEFRYlFYQzZrdjBl?=
 =?utf-8?B?NGVCQnR0TlM3bXFpaHJ1MnVQOHV3OXdWVWpGODhLYjNqMWZaRVJVTm1Gd24y?=
 =?utf-8?B?MmpKSzJTcWVHc2RLU1lLbnozQURxeHI4K3oxSDFiTnNsMjJTVjlzRWRoZ0o5?=
 =?utf-8?B?dDB2VGZQOS9TLzlyeFNSMklDaTNETHZqcktCODVtVkx4dFJNRkt6Tyt6cFN0?=
 =?utf-8?B?VnlwaWRxbUJMQW9Od0VEb2xaRFM0V2dnTUZSSnNFTThKblVVQjV0RW9PZ05O?=
 =?utf-8?B?Nnd2Rlpxb0JpdVMySk4rc2dmZGlwaHVqY2p1SEpidWlobGJEdUhsTUNSTUdE?=
 =?utf-8?B?VXJDYmlWQ1d4RkNFbnEzQ3QwcktVOWRyTUNxQzgwZU43dFFkT0tzY1JFb1di?=
 =?utf-8?B?SlFncUgyWFR4TFc0cDdOV0JIUktaQjVJZkxkOXV2WE1uL3JmOG9udjJsd1hK?=
 =?utf-8?B?WXUzK1dUZXJzdTcwWjd4bTBwWjZYUm1Tc0dpOWE4Ymk3OG9lNCtMQ2pYc2hq?=
 =?utf-8?B?UUEvMGthaHZOM0lVcCtvc0ozQy9xNW5LZGZvaEtTWUdzVDZ4eEEyYi9xNXBS?=
 =?utf-8?B?TDFGdGhhNFJTVHRmc3hrVGMxbnpPelgwK0xyQi94Q0VKYVpTWWNnNGtJYk9W?=
 =?utf-8?B?T09saVdscVNzWWE3WS9EUGVNN2lpMjA0b3daYk5LenFrSnRJNjUyZ0JRaDAv?=
 =?utf-8?B?bkorZUZDSHJEMXZRSkJnTVlJYnVmN1hIR2lEUW50WC9Oc3R2UWhSbzhleEhy?=
 =?utf-8?B?R0pRTTJrNnJRZ095YVM5SDFCcjNhNElyK2h0akp6YTF6M2lDNGFZUUh0WmdF?=
 =?utf-8?B?RkJhR05yc3ZBMTVJMlZSbmpsSkVLc2tmN0FtTTlNdGRmaW1LZUdBNzJqZjNX?=
 =?utf-8?B?N1BXSFlLU0lMY21kRlRNNmZqMGZYUVdEK29kK3BuNDI1NTY3RTlSZjkydVM4?=
 =?utf-8?B?cmhLQlVOQ0IyT2N5KzBheld2ZWlrREU1VjEvdGJjaTU4bUFseDhqNExZZWZQ?=
 =?utf-8?B?MC9tVDNJWlZMakJNZ1liTFM3T3h5d3I4RmFCL2tSYXBIYjNPU2ZjQ0ZJNHBR?=
 =?utf-8?B?dEJURWlHcEp0cVF3Qmh0Q2g3WW8xZkxlU1Ric1B0d0U5Ri9Lb3owT0hjWk9U?=
 =?utf-8?B?cUxhcEFvS2xYTUV6Z0JYWWdLMVMrTEcwZ3c0NGpkQXB5bnlyR3cyY2xyaloy?=
 =?utf-8?B?UWJLSDlENHN1T0Q1MFp0VUF1QUlHdFVsVVAxVk5OMUtQdTVOeHVJM25DQ0NK?=
 =?utf-8?B?T084QVA2bnN5RGtWY3pSbHErejVKSCtyQ040MDJMejJ4Mzd2VG45QWtwV09S?=
 =?utf-8?B?Rm5kNW00ZjRNMk1rb0UxbE02amloTTMrUEdPa3J1Z1Y2WGJubHNRV3hZUDRx?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D80D5B3881D3D4789A4198AABC9786C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd252b3a-5c32-497b-223f-08dad72f20af
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 02:11:03.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hh4GbiVB5M9pFw0U4Ug98ZzDV3T3UViaCS5Hcp7fzocrfN2GNwznJnbHulQAnTxOYVPKoACGw8//AXCELUf+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gMTIvNi8yMiAwMTozMywgS2VtZW5nIFNoaSB3cm90ZToNCj4gRnJvbTogS2VtZW5nIFNoaSA8
c2hpa2VtZW5nQGh1YXdlaS5jb20+DQo+IA0KPiBSZXBsYWNlIGFzc29jYXRpbmcgd2l0aCBhc3Nv
Y2lhdGluZy4NCj4gUmVwbGFjZSBpbnRpYWlsaXplZCB3aXRoIGluaXRpYWxpemVkLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2VtZW5nIFNoaSA8c2hpa2VtZW5nQGh1YXdlaS5jb20+DQo+IEFja2Vk
LWJ5OiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBNdWtlc2ggT2po
YSA8cXVpY19tb2poYUBxdWljaW5jLmNvbT4NCj4gDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
