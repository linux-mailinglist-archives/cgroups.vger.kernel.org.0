Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012EC685F73
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 07:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBAGEa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 01:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjBAGEU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 01:04:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4308E5CD1F;
        Tue, 31 Jan 2023 22:04:10 -0800 (PST)
X-UUID: 3c714904a1f611eda06fc9ecc4dadd91-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yzvs+YvZPWqNwv/4NYDDD2VPWghmfGCFkmwOGLsLv80=;
        b=Ia5xwtaPZzabpQtAtLr17Zd65MdHk9j20LQE4vRy6Glkf5Mgup9Qlupcq3Q4kSm57twDQKabz4v+RnoaQY8Wr4yLvdkb+oFYR0YDbJuy7NDhioQSxhp9dY/+P4nU+yGULhwPQzkpcmIA3jsK01K8UmWy+7KNuSN37XU3HEQmlHM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:9fbdba0f-5ba3-4c3f-86bb-7e45428cc475,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:42018c8d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 3c714904a1f611eda06fc9ecc4dadd91-20230201
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <lixiong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 331953373; Wed, 01 Feb 2023 14:04:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 14:04:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 14:04:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVOxFKSuIRagGHkwQhjMlZejDvhKXfmkqMUSEwqXDJusOmvvjUrwscQxdOR/sIVfjWkHCDygXMyVKCyWX02HWrr1CoOK7kVOhNwRr5qyNqIwAz6mWCMC0H3B8MsjgTI6aUbYj9m+PTll5zQW5FdykMoVlzVGgxl/Nn5vkugDqNNwfUPDxsBIQzyd7v2Lg+HtHmsinB7gbAhHq7hkOLBRpFsh2t/O9rJz6468M6NUC5N1IfB6rynGc+1+a2SMitG3mpK0fwrOR/hNh877FZrcEF5EDs3flEuig//pIvg7+lALjgA322QftLw8p7xg8OB97KFIMQ7sd9seJkDQ/jMsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzvs+YvZPWqNwv/4NYDDD2VPWghmfGCFkmwOGLsLv80=;
 b=aMcLKX5DuWjBuhL26gfP072zOZFjbMZxJ2LiBlS2cOFbcaEYHh7yOMM5a5OU5HDBquqjLkRhcZQ5x9XqGlmWtckqIfoCTAtKFuTs5yMMWUdvUaJ5mxzn4YzQPisOfbJhvBeoTcIBjL8oYQDOBbSv6zkxLVDw2TIobL+KH/urbI8hIxZO6ebDHgDYjmesa2w61HS81Tl8jZroU5zrDLUZX1ond5BjdyGBWnGZkJwk3bTfkxGMGbdLFt+QlGaes2HREX7/VIxzB1+n2dkAp1pBdbyV9fROV0hs+xqh1fM22jVqrU+Ru8PrGAqHLv5fbIGK2B4f8OgJV61m+CcJZb+0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzvs+YvZPWqNwv/4NYDDD2VPWghmfGCFkmwOGLsLv80=;
 b=iFFDfg9B/QexmaEKnag4XuFBs4a/g6a9JsZdss94cEnVWkWaVBZ5480dMXrmFCG3c9TWxbWVEuyf6vMeiVjV8N8jUFMChh5EEfiTY+S7cqxoI7MfrL7mrO3csTKkwHcoU9SyXsmdpcNEAR8AZDYHSmi5sJbXXzdHcbER0o87J00=
Received: from SL2PR03MB3947.apcprd03.prod.outlook.com (2603:1096:100:45::15)
 by SI2PR03MB5529.apcprd03.prod.outlook.com (2603:1096:4:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 06:04:04 +0000
Received: from SL2PR03MB3947.apcprd03.prod.outlook.com
 ([fe80::cdc4:41f3:5ffc:d0dd]) by SL2PR03MB3947.apcprd03.prod.outlook.com
 ([fe80::cdc4:41f3:5ffc:d0dd%5]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:04:04 +0000
From:   =?utf-8?B?TGl4aW9uZyBMaXUgKOWImOWIqembhCk=?= 
        <Lixiong.Liu@mediatek.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        =?utf-8?B?V2VuanUgWHUgKOiuuOaWh+S4vik=?= <Wenju.Xu@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?SmluZy1UaW5nIFd1ICjlkLPpnZzlqbcp?= 
        <Jing-Ting.Wu@mediatek.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        =?utf-8?B?V0ogV2FuZyAo546L5YabKQ==?= <wj.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QW5kcmVzcyBLdW8gKOmDreWtn+S/rik=?= 
        <Andress.Kuo@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: cgroup user-after-free
Thread-Topic: cgroup user-after-free
Thread-Index: AQHZJmsW9ZxsTkmTF0qxxstxXHzhsq6bi+8AgABKN4CAHeL7gA==
Date:   Wed, 1 Feb 2023 06:04:04 +0000
Message-ID: <3bb8e65797b905e4e9d4fad93a8f4fe26b8958a4.camel@mediatek.com>
References: <697032f2331a92eec0e03e85e46cb78bd975a788.camel@mediatek.com>
         <Y8Cwdsk5pYNd8fX8@slm.duckdns.org>
         <f8b24df3bd009d112479e9d5db36ec4afff9bb71.camel@mediatek.com>
In-Reply-To: <f8b24df3bd009d112479e9d5db36ec4afff9bb71.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB3947:EE_|SI2PR03MB5529:EE_
x-ms-office365-filtering-correlation-id: 40ce1dca-71ce-43ea-9fed-08db041a1f4b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uF8+VTcGyjznmFbDHF875+a/ofBproZgOLpqmesbsSvsiAWtDQSbJTZHIM6KlJM8C4B4fzs4rPIeI2KBc30OjWjEsfav3u5TOxutDAI7o4yW3RRSY8Q7ziX+lnPOctHNg7rnNI9UK6JTUQ2hQRu8Js/szp4L+r8CVRGqteM9AdwmdZIVN7riCQKVz2oQrKUR8E9oCGePfpZAOlSOQFy9D17/WO+Ll1OIDjHlVLz3sRNJDaQGu8H0Ocwh5g4CZmZxNRY7+stfV6BbuhNAw5rZt6YiKdea6GuV3yBpXYBpA4UAFuixXBDviqBVH9w4hR0i7FIJw6oL0XIJuFu/EX1scdVFIt7iKxxSz6b0OAByD+Uwut0OyRpLEstc26lbFmKmtKD33P49NI85Epx4gqA/aEHXHMB4PNfYcQoNySuZwCIc8qAedKIQ0Q6+G0l8oGTbLA/JdqHk6oTmDyeqljn9kVT2ew9f4GEQpS7K8cgUAif5aZngjP7GOl/c0QzeiNgddN1nxN/Jvd5vpwnGwUpkqmfp/ADI9ytGe0TJ0AhHwyKx7uUely5KM66lFVQ4NNHFJ23smOZcAsuwdF0w7vLwBVwy8TLNMF9RE2GVRAE98isZsFGVCz5wUdo4JX6BZFkj6QH9zP/cIa/Hpn7m/exuXnh2eEsDanD4X3QOEv6EUWdVeuKSf3dPW83hWSceTLcGT/LCYFPqsGu6sb+t0lMMxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB3947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(2906002)(6506007)(186003)(2616005)(4744005)(26005)(6512007)(76116006)(5660300002)(91956017)(66946007)(86362001)(66476007)(66556008)(85182001)(3480700007)(8936002)(83380400001)(66446008)(478600001)(6916009)(4326008)(36756003)(6486002)(71200400001)(8676002)(54906003)(41300700001)(122000001)(38070700005)(64756008)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0xkMk1oMU9QVW5iSXhHM1pTcWpSYzAvdS9CWkFtMVJRTXFZMWlneXNGOStT?=
 =?utf-8?B?TDlwZ3k5azRKMDZCK3haSzJ3QlgzUk96YnQrV3F0RGprOGU0SHgvYUFiMSsy?=
 =?utf-8?B?dUpSZW9HY2F0Sm94STQ1a3FSU3BuNjF0bHNuRlFaUjNYQ2RGNU12UUZaNjhh?=
 =?utf-8?B?YWE0empUSkxjMWpzWkxKWHU1V2ptY0paY0tRWFhiRHBsRGVKZmZ6ZnAwd3M5?=
 =?utf-8?B?ZnZ2S0NMSUlLNEdSZU9LNDRVZzQyQnk2YXFDUjBxUHlMdzI1bWNnMU9weEZi?=
 =?utf-8?B?c2tiM0Z6ZFpmT1RLYnE1QWZmVWovalR6L016SlEvSVM2MGNDbTh5dVAwVjhx?=
 =?utf-8?B?TE00VUF3aFVYWmFyQTluTkh4cFNVbmo0dEt1UVJmTElJZzhWMU9vaVhYcWNN?=
 =?utf-8?B?dXdQRWZoS2FVMWJ2RE9uQ3dXWitCM1IxQWF0cWJOMmthdGdzMmZLQkFkV1M4?=
 =?utf-8?B?SVFnMDJuQnVQU0F4c2N6cTIzZ2xmSytnRHRWNkp0YzczbTQvYjB0RTZUb0pZ?=
 =?utf-8?B?SGdiMEZDVHVCeWJXVExqcDVOSkcvMnJCU1l5eU1hYTkwZUc4Ri9IakFPZUdS?=
 =?utf-8?B?N2U0a2ZJR2xOZGlHZG9ZUEpLaC9Hb0NNUHhUSWlIMGVIbndORGlQMWtwelA4?=
 =?utf-8?B?Qy9telkxMmUrdnI1RXdKWUFVbDdvdGc2aHMrU3kwV1ExTEhNTHJWRlUwUitX?=
 =?utf-8?B?VTQ1ODAvSElCdk1vMnM0MmRHUGRxb1R1TjhkUmdHYSsvY3ZkbExnRWQ3SG1l?=
 =?utf-8?B?REtoTTZacnJHRDl6ZGtaSm4xeFFOS1hGa2tsZlFiMm9MUmxIRndPTUVPZWlJ?=
 =?utf-8?B?RG5zM3hIMDRRejVRSEFqaG9TTXl6WkQ1M1oxcnl1SktWVStNZkp4eXlRNTJl?=
 =?utf-8?B?RG5ad3VqUlptanRNdW1wY1BlbWpqTVl0S3JTdE5CZFlyZ3hLa1lNRmFXdERa?=
 =?utf-8?B?UER3Mm1PWnVlVm5uN1BBMzJMRW5xSDhQdk00VHZQeTM5UkM5NUYvRHdnZVdn?=
 =?utf-8?B?bGdiWXVJeFZSVDJ4OFhjM2lwRUx6bEtCN21GN2FJb0JRNHBQcHY1MGwyRGp2?=
 =?utf-8?B?MlVMZmdWU2NkTEhrU1BrME9oOTlRK3NicDZpSGZ2TllXVll1RTBZVnZGTTNn?=
 =?utf-8?B?YkJCYlBuWFpGeDVCUFJjRHpUQlAvWUlvb0dtOFZhbk8vTDdWU0hMRko3RENR?=
 =?utf-8?B?SGkrWmY3NGliN3NWMkpqMXJWUGEweS9OeVBiQ0VIOUhDbk9TK1lJanVMWkxV?=
 =?utf-8?B?dFArSnhwMklGcGtha2JydlY3QXVGQmhsS3ZJTHlkbGxFTzZiMXlYY0JlMC9W?=
 =?utf-8?B?TXFjdWtTUURwUjJqY2I3NE5iOVNuRGtIbkFGQ29MVGQzTDZFV0FmOW9OTlU3?=
 =?utf-8?B?dmhZMTdMam9RMDRTTExIR2E5Wm5XUHptOFFYdzE0MU42bkwyTE5QZ2tRb05X?=
 =?utf-8?B?VkZZblRlUzUvaEk2UnA1S2NidGtPc213S3pYdStKbWZhTU5qNTBZcWs2SUF0?=
 =?utf-8?B?dGU0REdMQjljc2pRbHlrckVoSmFLSGlWNGdybzYwc1BjbXFWa29VcFJKZlVZ?=
 =?utf-8?B?T3NmcVpES29KVkRqakFXd1MzL2M5NWk3V2xTV3dQK2lsSmVUYS9KTWNycEl1?=
 =?utf-8?B?U3JVTC96UGhFSnNLRnFqZnkwNndzR1Rydm5MYnBXdXdPK1dtVHhpNVZPTEtW?=
 =?utf-8?B?eUxZQzQ0K0ZrZjhPeWFnbkxVVURnRXJwTkVvZHYrMXVldi9FK1Fra1NHenVp?=
 =?utf-8?B?VHJ2R05Td0kxTlUvWUcrNUlrTGRXZW43MGNiczY3eFNLTFJqYi80dlBxTUt6?=
 =?utf-8?B?UEdjZXc1TTUzVFcrbGxuT1g3RjBoUkN1SjAvdmZRWVYybjlqVWtoK3M3Vm93?=
 =?utf-8?B?bk5pNlZHeERQV08vQ3NRUkRGUVhyWWIzVVlQd2RweTFhRWRUYjZoZElSQmQ2?=
 =?utf-8?B?c3VlLzh3NWx5WnViMjF4QldKM0ZkU3U5ZVg0dVJ1bEc3cG01SVo1elprTFVj?=
 =?utf-8?B?c2tBNmxUd2Q5a0Y5SEtJVzNIM0FhWktBcmtDZm9Ld1NFejhqVjMyTlJGQmNI?=
 =?utf-8?B?am1Ed0ZnUEJwazVucWdvSTFtWm9PSXVBTEtRTTFSVmZMZWJ6ZTViMXIyTzBr?=
 =?utf-8?B?RjFYMUtPNVF3QnBTSCtRSE9HT0JIemxpR2dpOHZySVFaUXAwcTdMdFVRVlQx?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07E3047408019941B471670B8603DAC7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB3947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ce1dca-71ce-43ea-9fed-08db041a1f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 06:04:04.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCvgzHp/R9eiqLSLj3V5/Ww1s0UKwEPDVhbHa3TpClzjl8wjkrX6x/XthnIFEsmcLJysXRmVjl7g8bmomz9gc9tF1f32U2YJnR/vYLBEsnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5529
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDEzOjQwICswODAwLCBsaXhpb25nIGxpdSB3cm90ZToNCj4g
PiA+IFJvb3QgY2F1c2U6IA0KPiA+ID4gY2dyb3VwX21pZ3JhdGVfZmluaXNoIGZyZWUgY3NldOKA
mXMgY2dyb3VwLA0KPiA+ID4gDQo+ID4gPiBidXQgY2dyb3VwX3NrX2FsbG9jIHVzZSB0aGUgZnJl
ZWQgY2dyb3VwLA0KPiA+ID4gDQo+ID4gPiB0aGVuIHVzZS1hZnRlci1mcmVlIGhhcHBlbmVkLg0K
PiA+IA0KPiA+IFNvdW5kcyBzaW1pbGFyIHRvIHRoZSBwcm9ibGVtIGZpeGVkIGJ5IDA3ZmQ1YjZj
ZGYzYyAoImNncm91cDogVXNlDQo+ID4gc2VwYXJhdGUNCj4gPiBzcmMvZHN0IG5vZGVzIHdoZW4g
cHJlbG9hZGluZyBjc3Nfc2V0cyBmb3IgbWlncmF0aW9uIikuIENhbiB5b3UgdHJ5DQo+ID4gaXQg
b3V0Pw0KPiA+IA0KPiA+IFRoYW5rcy4NCj4gPiANCj4gDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIg
cXVpY2sgZmVlZGJhY2suDQo+IA0KPiANCj4gICANCj4gQnV0IHdlIGVuY291bnRlcmVkIHVzZS1h
ZnRlci1mcmVlIHZlcnNpb24NCj4gDQo+IGFscmVhZHkgY29udGFpbnMgdGhpcyBwYXRjaC4NCj4g
DQo+IA0KPiANCj4gU28sIHdpdGggdGhpcyBwYXRjaCB3aWxsIGFsc28gZW5jb3VudGVyDQo+IA0K
PiB0aGlzIHVzZS1hZnRlci1mcmVlLg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gDQogIERvIHlvdSBo
YXZlIGFueSBzdWdnZXN0aW9uIGZvciB0aGlzIGlzc3VlPw0KDQogIEJlc3QgcmVnYXJkcywNCiAg
TGl4aW9uZyBMaXUNCg==
