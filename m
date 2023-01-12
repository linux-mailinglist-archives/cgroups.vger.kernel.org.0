Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630B666EB2
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 10:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjALJxA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 04:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjALJwb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 04:52:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938EB227;
        Thu, 12 Jan 2023 01:49:04 -0800 (PST)
X-UUID: 56aa9c28925e11ed945fc101203acc17-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=Uc6KOZdKqaVjGbmZMALE9tJ11cr4lOR4fM38tMkynLM=;
        b=G6IxiEQPvJTtqq+zxdCu8Ca3Skfk0F6ojjvYVtKhWBqHLpUgVlvbFr4Wmd5wlzRIl/RAyXGhaMMAAwBbCvDV7kbaZLXP9uDYik7sk2symIJmA6T+UFbhBdKUR0H75DRciqSxTjoY8f5wZ7Zq5YVRYs1vRTQzNqnF7pcRrRVkEKY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:47bbec45-b51b-48d7-a7b1-8bc37968707f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:28189ff5-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 56aa9c28925e11ed945fc101203acc17-20230112
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <lixiong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 222903765; Thu, 12 Jan 2023 17:48:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 17:48:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 17:48:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOZLQR/bYFchzNMiPZ4FEoB0Rvz2D/LPJA7s4GZY5pmEg9IvHpUtmwHAZHC7k9g9M9bGAMvLUuhqjYDP/RyOcop/IXoLR9Gc6XJbLLLIEzWvx2kAt2Ocaq0/k5OXd/smqI7MDPwKJqksOCjLQVtD7RknT19/YbipeDFWDT/QnmLM7BWhMZO+hREg3Uva9SF0aa2B8iK2jjyllC/zxQaUp4Pwzdh/lJfDLHL40wxbJs4HW5i/s5ZTtZeTPXYzIA3cvXsq9/0VkEs3PuHCVuCm8cTeGacLICg9UMYYo8nMqmAdb2fM0p+LWyI2DolKVUu+ljfOGlCIafvuy2V7UJUzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc6KOZdKqaVjGbmZMALE9tJ11cr4lOR4fM38tMkynLM=;
 b=n9+zpC8Ff65DPk59xYIjWhHJh4d1Nb3xof2dCdswvlVXhGoVZ8uXrd9l4FLCK0SoTu4dPJURrU5eTS10V2ZSNCq85cGjqaCqUMKH51S81/5llA1+KWKMfgnQM/yyXzJjhhwzqmVlK69GzCn3LWQBMYsRXDJfdrzT2hjxPnzqIAfImPvwRIpCFowz7KUDONI8xQSI38unAEMKs5xBaiUMwxWFe717YpveGBnh9FUgSpQVwOYXUKS9JYpLYM1RzpKSkj+aXANsEnJrZcdbg1fI4RSMyWys1ftMV5ZtZ9XJy8t6CpWMJu4ga6mTG4E3fFIlYhnYtmY5Q+zIgqjVXsAR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc6KOZdKqaVjGbmZMALE9tJ11cr4lOR4fM38tMkynLM=;
 b=qia9UcD3MpLmwCow3+7hb04w20rkakQe+zffkxgANNpaLXyXuKGnZrdUtGwnzhXmcDyXImyY1GCzUOpiVD2ES1JxbCKVSAddmWOl4WnjLbuc/O0ekIMasq+G8SE5QR/rc77I6lYW9xxkOriulnInDOexFj05mwJcAMqAPtUFXBM=
Received: from SL2PR03MB3947.apcprd03.prod.outlook.com (2603:1096:100:45::15)
 by TYZPR03MB5993.apcprd03.prod.outlook.com (2603:1096:400:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:48:56 +0000
Received: from SL2PR03MB3947.apcprd03.prod.outlook.com
 ([fe80::ecdc:147a:dee8:be1c]) by SL2PR03MB3947.apcprd03.prod.outlook.com
 ([fe80::ecdc:147a:dee8:be1c%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 09:48:56 +0000
From:   =?utf-8?B?TGl4aW9uZyBMaXUgKOWImOWIqembhCk=?= 
        <Lixiong.Liu@mediatek.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGl4aW9uZyBMaXUgKOWImOWIqembhCk=?= 
        <Lixiong.Liu@mediatek.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        =?utf-8?B?V2VuanUgWHUgKOiuuOaWh+S4vik=?= <Wenju.Xu@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?SmluZy1UaW5nIFd1ICjlkLPpnZzlqbcp?= 
        <Jing-Ting.Wu@mediatek.com>,
        =?utf-8?B?V0ogV2FuZyAo546L5YabKQ==?= <wj.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QW5kcmVzcyBLdW8gKOmDreWtn+S/rik=?= 
        <Andress.Kuo@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: cgroup user-after-free
Thread-Topic: cgroup user-after-free
Thread-Index: AQHZJmsW9ZxsTkmTF0qxxstxXHzhsg==
Date:   Thu, 12 Jan 2023 09:48:55 +0000
Message-ID: <697032f2331a92eec0e03e85e46cb78bd975a788.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB3947:EE_|TYZPR03MB5993:EE_
x-ms-office365-filtering-correlation-id: de7637c3-1376-41fb-6af1-08daf482389f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2BSlXclG0lll6Q7CTOCJQtlO/RdyJEYbYKEAYa+fJ0ipRTskydrWCIkGXE4phh5DReIf/+FQS5Xg8KhFHR6SBrCrh2a863KcbU/4aoGWXoxIk8vgkIwfcqTkqVk4/tQpHHDOHAFFRc6A31Qc2xUdhXohF0kJ6Z61AxK8zxhyM5yeidhKSBa6z/TK+a7oKPVJU+XZpnPh5EO7yndxfa3LH3kZmRu9Ri4l++gMBLJtkzI2DOsykZ89XMcBdPvQy4SPz/9FuFQnu2xQ3Kd4vP1TaHN/RaaHLqpwalgD/sdGegO8eRLC3v+gJVWppx5Yw7rbVZ5qXMZNJNp5H+0VRywzDmyuHyKfxWmEIhoorrzxcEmqJgv747yylzBwE0L3riRsAQQpkQWEdODCHIJT9USasauGdyD+dBJ/sl0efOgd5k37H4R+Tig7BUqu+8dKEO0RTMiynB+nmrjUN8A06BV97ZtEU/DY3kAYd1mpXC7TJm0DZc2o76uziNAKe6xgZsrLZy4XAJhxWEHlWqUMfIbIgfYDpg39TODYwjwHtWGjwCt6FiTiQjcYLw1q78ndfCqykP90r/zCVErneFw6RFkQnXcdEpgsLPURPInO9vzjlk8Zc1S2+dSxYk1WSJX/MZiK2J64h0jBvcgvuYwBz6vLOWuKpsoh1sXNGyhfWL9rvMxKe8tIiHxZfGSuFLzKX0sjSYqLOl2NAmy7ccY85l5Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB3947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(316002)(86362001)(71200400001)(26005)(6512007)(5660300002)(186003)(478600001)(6486002)(2616005)(64756008)(91956017)(41300700001)(66556008)(4326008)(66946007)(66446008)(54906003)(66476007)(110136005)(76116006)(8676002)(36756003)(8936002)(83380400001)(38070700005)(85182001)(6506007)(122000001)(38100700002)(2906002)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hLeTkxZzZrTlJCMlhlamNXcWRwckdIS0FJOUE5VldxL2t6R1Y4aDJpeERR?=
 =?utf-8?B?TkFhdDdmWHJ3VU4wRDVOWmsydU5ZMTdNSVo3Y1VFTnk1eUxhZmJoUUx2UWhs?=
 =?utf-8?B?Yjg2WUUxZytJYXkzWUw3YS93bHh4RjJvckdOd3dqU3MzdFhoSHRtb0xSdzZX?=
 =?utf-8?B?SHkvRVdLSWR2QkZDc2VnbmRvZFNhS043ZEo2TGxpNzJKRkJjQVRGNHFlVXdz?=
 =?utf-8?B?T1JxOWVQb3lZK2R3Zml2dFNJNDJSN1UrakE3dVp2bGF2aVRmZnlwdFZxQXNG?=
 =?utf-8?B?MExsT3o5WXgvbkNYY25PV0gyTGgrMmxhaUYzMmJEZGFpQVB2c3lrcDVobHJJ?=
 =?utf-8?B?QjRnOUxaRHp3NFZpaW1CK1lZdzVMZGIxUVNRbGwvRml1RVRrMFhTblZjVVZh?=
 =?utf-8?B?VTdxT3lnM0IyM2RveWRBMGh2b1pQaHhhYStWNnUwZzFOdTBUM1ROdy9QSjRJ?=
 =?utf-8?B?MllmeHRsYzFYbktZTGNVeGJKZ1JXTGcrSk9jbVR1OGI3WmNkT05BUHBUck1O?=
 =?utf-8?B?T2htQ1kzM3o4ZmxkaC9PVGV1WEVBVWZDdEVxVDlrL3g3SlYrNERuZGJKSFAx?=
 =?utf-8?B?eHV5aldsYVRwZ05GeEdha0dINzNNd2I0bzlrV01pNktEMDkwZkNGSjlranVh?=
 =?utf-8?B?R3lmZ0tpdk1kbWNvSUdXOWg5bG1MNGM2UjJBRVFXK2F5NzgzSXNjenphWWRz?=
 =?utf-8?B?R2V1ckpkMm9FdzRPb2RUT3NBYlVKOFRDRmlHMEp6RmwrSWhTd25HbUNHVWh4?=
 =?utf-8?B?eVhjU3dnTEp0eGdnSXlIa2M1My9PTnBZM24yRm5yZU9OTjBKM211bVFMWXcy?=
 =?utf-8?B?SFU2Wlp6MTA3NThxeHJ3Q25uTmpaMUkwUmlPT3ViWER0aW4vcE0wNHd5K3ZC?=
 =?utf-8?B?VGlSdUFUTkNIRXZSSVM0RkhoRnVxK3kzQ0twczdTN2NtQWYraG55SUg0RFJy?=
 =?utf-8?B?Wm4zNkxjZE5lS1lEQ3FocnRnc2xQRVRHczdTZ0x1MGhVSUJMNXEvd2oxYjZv?=
 =?utf-8?B?UEtKaFUxYnlnTzdPK1pUOHU1M09BUVIwUlNKZlJYV1YxYm1PSEFEZjBFV296?=
 =?utf-8?B?TzdhdkMvT0g5RzFKVHNiL1FkU2Z1Sit4L1IxTm1KS2wrUnc0VlhlOTBnY1JV?=
 =?utf-8?B?RmV1ZzN0THEvZjNsdzVWZWR0UnZYc2hEdndqVXZaaGFlSTdXY0xVZStlVnYz?=
 =?utf-8?B?Q0QreXhtUjM4MDFkY1hCSDQrRTBBZTV5R3VKeXdmSWZVN0xDaVd4WWhwVW50?=
 =?utf-8?B?eVZoRFhJSWtIekp6akdXWmp4cENEdTV5eDFIRFFySUpLcFRtdVVDQ1JBcGVD?=
 =?utf-8?B?YzNlQTJtS0lHR3EvRTdicXZpK2d2elA1ejRKSURnR2xoZzBCU1ZaS2dVamRN?=
 =?utf-8?B?ZHFNR3YyMzhWdnRVM1k1aVM0Y3I1Z29pdGp6dkhRLzhaT3E4SEtEOGFKS25N?=
 =?utf-8?B?OTFCblpTa1Rvc0drcllvM2g1UXZhbnk3eHJaYlBkZkhEWWNRNCtSSGdRNGNr?=
 =?utf-8?B?TnNwMnR4OXcrZ2NqREpXK3QvNEVqSForNlFYNWFFdktEMEFHMzdCS1Z4VnZj?=
 =?utf-8?B?aXd6ZVNXWTdwNnFLTHJmV2w4WmM3ZUd6b2cwMENmZEpjdXpsaVdBMzhtNHd2?=
 =?utf-8?B?dW5uaWVMVjZDU1J4ek5pTEV5dlEzYXRLU1BGR2VobGZqdnZDcFBjYkRjYXVC?=
 =?utf-8?B?V1JNTVZFNjBnT0QxL2QyQ252eldCV0JRdXB3emFDTEZlK0xrZ3hEcG1oTEds?=
 =?utf-8?B?bzZRL1c5TlZSZVBEaDN1cUtxZ1RXQ1N3azgzL1I1UEJ4UTlxR0FGUTIvWmRj?=
 =?utf-8?B?VlVtWUNyU2xOakYycHJ3ZjhITmFYYlJvRzVxZ2RFMUZWQVZpUG1MTHBDZlFV?=
 =?utf-8?B?aDBKOVNGQ202YXo1ai9Sc1FiNkVsV2UrRG1pZ0lFU1VZNi9mcEV3TmtEbWpv?=
 =?utf-8?B?ZnlhSmlFNTRKM1M1dy9VU1AzT2FQMWlJd0NuVDJpZWhya3o1OFZWZXFoeVJF?=
 =?utf-8?B?Vnl6Qkpiek5rR0I1clZvUXZYN0xEN0U5THNWWW5ISmpiNk9yMGFXYTM0NzNK?=
 =?utf-8?B?K0g5Skt6ZFFnbjRzRHNlL05lbks4ejZRR0J5V1ZHK1VaTGpRN0Y5WEdsZW9n?=
 =?utf-8?B?MXRSUDY2eWg4M0pUYTF5cWhMSW51WHN0d0VyZ0tQclNCWDBGcXByKzF0WUdT?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B4495EAA0FBA47ABB21324D1A92613@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB3947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7637c3-1376-41fb-6af1-08daf482389f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 09:48:55.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKjgJ5GA9DJn+FuZ1UDBE8nOZ6wqFVhfBcftCdUjervz5XcnlL0r6juJmyRM0JU0hcJ5DtKC3gFWPt66eFxnehvasMX4dAzq78ApIthtvOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGksDQoNCldlIG1lZXQgY2dyb3VwIHVzZS1hZnRlci1mcmVlIGhhcHBlbmVkIGluIFQgU1cgdmVy
c2lvbiB3aXRoIA0KDQprZXJuZWwtNS4xNS4NCiANClJvb3QgY2F1c2U6IA0KY2dyb3VwX21pZ3Jh
dGVfZmluaXNoIGZyZWUgY3NldOKAmXMgY2dyb3VwLA0KDQpidXQgY2dyb3VwX3NrX2FsbG9jIHVz
ZSB0aGUgZnJlZWQgY2dyb3VwLA0KDQp0aGVuIHVzZS1hZnRlci1mcmVlIGhhcHBlbmVkLg0KDQoN
Cg0KRGV0YWlsOg0KW25hbWU6cmVwb3J0Jl1CVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBj
Z3JvdXBfc2tfYWxsb2MNCg0KW25hbWU6cmVwb3J0Jl1SZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZm
ZmZmZjgwZDZkMmEwNDggYnkgdGFzaw0KDQpDaHJvbWl1bU5ldC81MjU5DQpDYWxsIHRyYWNlOg0K
ZHVtcF9iYWNrdHJhY2UNCnNob3dfc3RhY2sNCmR1bXBfc3RhY2tfbHZsDQpwcmludF9hZGRyZXNz
X2Rlc2NyaXB0aW9uDQpfX2thc2FuX3JlcG9ydA0Ka2FzYW5fcmVwb3J0DQpfX2FzYW5fcmVwb3J0
X2xvYWQ4X25vYWJvcnQNCmNncm91cF9za19hbGxvYw0Kc2tfYWxsb2MNCnVuaXhfY3JlYXRlMQ0K
dW5peF9jcmVhdGUNCl9fc29ja19jcmVhdGUNCl9fc3lzX3NvY2tldA0KX19hcm02NF9zeXNfc29j
a2V0DQppbnZva2Vfc3lzY2FsbA0KZWwwX3N2Y19jb21tb24NCmRvX2VsMF9zdmMNCmVsMF9zdmMN
CmVsMHRfNjRfc3luY19oYW5kbGVyDQplbDB0XzY0X3N5bmMNCg0KW25hbWU6cmVwb3J0Jl1BbGxv
Y2F0ZWQgYnkgdGFzayAxMzgwOg0KX19fX2thc2FuX2ttYWxsb2MNCl9fa2FzYW5fa21hbGxvYw0K
a21lbV9jYWNoZV9hbGxvY190cmFjZQ0KZmluZF9jc3Nfc2V0DQpjZ3JvdXBfbWlncmF0ZV9wcmVw
YXJlX2RzdA0KY2dyb3VwX2F0dGFjaF90YXNrDQpfX2Nncm91cDFfcHJvY3Nfd3JpdGUNCmNncm91
cDFfcHJvY3Nfd3JpdGUNCmNncm91cF9maWxlX3dyaXRlDQprZXJuZnNfZm9wX3dyaXRlX2l0ZXIN
CnZmc193cml0ZQ0Ka3N5c193cml0ZQ0KX19hcm02NF9zeXNfd3JpdGUNCmludm9rZV9zeXNjYWxs
DQplbDBfc3ZjX2NvbW1vbg0KZG9fZWwwX3N2Yw0KZWwwX3N2Yw0KZWwwdF82NF9zeW5jX2hhbmRs
ZXINCmVsMHRfNjRfc3luYw0KDQpbbmFtZTpyZXBvcnQmXUZyZWVkIGJ5IHRhc2sgNDUzMDoNCmth
c2FuX3NldF90cmFjaw0Ka2FzYW5fc2V0X2ZyZWVfaW5mbw0KX19fX2thc2FuX3NsYWJfZnJlZQ0K
X19rYXNhbl9zbGFiX2ZyZWUNCnNsYWJfZnJlZV9mcmVlbGlzdF9ob29rDQprbWVtX2NhY2hlX2Zy
ZWVfYnVsaw0Ka2ZyZWVfcmN1X3dvcmsNCnByb2Nlc3Nfb25lX3dvcmsNCndvcmtlcl90aHJlYWQN
Cmt0aHJlYWQNCnJldF9mcm9tX2ZvcmsNCg0KW25hbWU6cmVwb3J0Jl1MYXN0IHBvdGVudGlhbGx5
IHJlbGF0ZWQgd29yayBjcmVhdGlvbjoNCmthc2FuX3NhdmVfc3RhY2sNCl9fa2FzYW5fcmVjb3Jk
X2F1eF9zdGFjaw0Ka2FzYW5fcmVjb3JkX2F1eF9zdGFja19ub2FsbG9jDQprdmZyZWVfY2FsbF9y
Y3UNCnB1dF9jc3Nfc2V0X2xvY2tlZA0KY2dyb3VwX21pZ3JhdGVfZmluaXNoDQpjZ3JvdXBfYXR0
YWNoX3Rhc2sNCl9fY2dyb3VwMV9wcm9jc193cml0ZQ0KY2dyb3VwMV9wcm9jc193cml0ZQ0KY2dy
b3VwX2ZpbGVfd3JpdGUNCmtlcm5mc19mb3Bfd3JpdGVfaXRlcg0KdmZzX3dyaXRlDQprc3lzX3dy
aXRlDQpfX2FybTY0X3N5c193cml0ZQ0KaW52b2tlX3N5c2NhbGwNCmVsMF9zdmNfY29tbW9uDQpk
b19lbDBfc3ZjDQplbDBfc3ZjDQplbDB0XzY0X3N5bmNfaGFuZGxlDQplbDB0XzY0X3N5bmMNCg0K
W25hbWU6cmVwb3J0Jl1UaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQN
CmZmZmZmZjgwZDZkMmEwMDAgd2hpY2ggYmVsb25ncyB0byB0aGUgY2FjaGUga21hbGxvYy01MTIg
b2Ygc2l6ZSA1MTINCg0KW25hbWU6cmVwb3J0Jl1UaGUgYnVnZ3kgYWRkcmVzcyBpcyBsb2NhdGVk
IDcyIGJ5dGVzIGluc2lkZSBvZg0KNTEyLWJ5dGUgcmVnaW9uDQoNCltuYW1lOmRlYnVnJl1wYWdl
IGR1bXBlZCBiZWNhdXNlOiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3RlZA0KDQoiY2dyb3VwX3Nr
X2FsbG9jIiwga2VybmVsLTUuMTUva2VybmVsL2Nncm91cC9jZ3JvdXAuYyINCiBjc2V0ID0gdGFz
a19jc3Nfc2V0KGN1cnJlbnQpOw0KIGlmIChsaWtlbHkoY2dyb3VwX3RyeWdldChjc2V0LT5kZmxf
Y2dycCkpKSB7DQogICAgICAgIGNncm91cCA9IGNzZXQtPmRmbF9jZ3JwOw0KIH0NCiANCihnZGIp
IHAveCAmKChzdHJ1Y3QgY3NzX3NldCAqKTApLT5kZmxfY2dycA0KJDIgPSAweDQ4DQogDQpEbyB5
b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbiBmb3IgdGhpcyBpc3N1ZT8gDQoNCkNhbiB3ZSB3b3JrYXJv
dW5kIHRoaXMgaXNzdWUganVzdCBieSBob2xkIA0KDQpjc3Nfc2V0X2xvY2sgYmVmb3JlIGFjY2Vz
cyBjc2V0LT5kZmxfY2dycCANCg0KaW4gY2dyb3VwX3NrX2FsbG9jPw0KDQpUaGFua3MhDQoNCkJl
c3QgcmVnYXJkcywNCkxpeGlvbmcgTGl1DQo=
