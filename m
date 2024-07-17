Return-Path: <cgroups+bounces-3726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3679E9335F5
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 06:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D810284276
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686B79F2;
	Wed, 17 Jul 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YAUAlcfq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kN8Xoq56"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0456116;
	Wed, 17 Jul 2024 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721189411; cv=fail; b=j5vMMWEI1D7XnTeGDpDT0OHKS5CZmI6nAvz5OAh7eCSXbZGMrkTAnFCEWme/FFDVnqkuVPw6fZXlNRctl2u3AZAf7EoHTxvEDsYCAT2HzpNI7BX7JtZuvWBMoLYARCNnSEwpSuEwGkK2FzQBw29DtXgQC20FSb7LgBS08vWg0uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721189411; c=relaxed/simple;
	bh=QI2YyxounMu34gLqlY9N605OFmFJMpQfeUsaDoUzcQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBmSN2ikqYUrg4fKFhjs0EBCufJdcb56b++uzmneRi6lia2uRGYcyvn2hy30NRJwRzI4PMnZ35Tf08n+StNJCPs1cWfV6ifwGLl6gPBrwV3NrcfCsWUyB4sJs6BEt12sBnSWSMSHdSt9n4/32c9jBCXYLpvJc/hw+Te4q1tYDbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YAUAlcfq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kN8Xoq56; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6e12065c43f211ef87684b57767b52b1-20240717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QI2YyxounMu34gLqlY9N605OFmFJMpQfeUsaDoUzcQ0=;
	b=YAUAlcfqx+5kKP7yW4hUMDWdJZwXAbVYUiRBhUSPCQvXqFVnttOgRQG7OlldNqbfXbptSja0soNdZr1dyITy0rW5mehcgIswA+ENUJOmLS51ApfIoLDebsuWuhFM1FzTVo4GMbE/+MRXHNmIJXEDzC5FVTPZYBPXB2ZUAkHNaXA=;
X-CID-CACHE: Type:Local,Time:202407171144+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:7b679757-2bae-4ac3-a41c-c0985e14f923,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:836892d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6e12065c43f211ef87684b57767b52b1-20240717
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1668620312; Wed, 17 Jul 2024 12:09:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Jul 2024 12:09:58 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Jul 2024 12:09:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1wQyDAzSB/ZRBVdgFzRm0/YCZWXezfDO1NUGK8SEUsTcvyCOjLgdKuJZjBAxEa4TB24PRBG5l2wSi5mtHBPtTEzXzWc1Qmw24s+MJWHu1348EaxA0r1vpnvPmAExfyTuEgAONn3iuRnl8AX7tKf58WqMlzb1mnfWCDZX9/lmxnkXF1zaFmut9KiU7tE+L+Ng3YFF+AU36UQXPXzJdt0O1eN0xIftTM0Zf3ooQtVoKIyid7uYtDBIWPvvb3CcR0bjvo2bJkqvIG2PlE2hdxXw4yXjyIVnT8AjqRmrLji6Hs5E3/wdjajK2not1hbuMimoobt/N3h+u9aIxASm2cO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI2YyxounMu34gLqlY9N605OFmFJMpQfeUsaDoUzcQ0=;
 b=sck13LYLRQ1z3uTvjxK8JNRCbsvR4ItUr7qisnny1U9HiU4sdTLiMk6pDgKGO8YtztLU0qPVwU/ETsoON3TLi5VlNyVao2WV7RTwM8tvTf7KGsV7rQ03fgacKn44L7QY9eMTDLNrrbnVacrvyjYFcBrQsUU70RTChncJY5HoXAOTk8VXJ1FAKZ18Q9QBWqYUfLckHWiGvinLsJNRrsYlbrIGp6988PRHpk4Ykwtepi/gPh0qnBNgbWuXsdNDXrjyKG1/3Ik6/3UyElJDhQTuIMjp+2qYV1cdVjO2LdRLPwTvC9Ddsh/3/GAoKZclhzxWbvEcPsQm3RM1IdAu+lG7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI2YyxounMu34gLqlY9N605OFmFJMpQfeUsaDoUzcQ0=;
 b=kN8Xoq562sKQHz3g1S/csJf2WXN53eaSjtxIh3D811iULWgFuIIZy9WeC4+LHr9bB8o9jvvuIueYOGsz+bcL47SNbQRVznRqjeQv7XiXH9H32VOdHvu5M5mDmjwvI9IwAM+gULY9ChBxs789CCOjHe3i+RmwzeR/XvNoJhjwg3E=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SEYPR03MB7864.apcprd03.prod.outlook.com (2603:1096:101:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 04:09:54 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 04:09:54 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "boris@bur.io" <boris@bur.io>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	=?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Thread-Topic: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Thread-Index: AQHa11Ul4ctm5KmuYkmA12uhv9CQ2bH521+AgABXLQCAABYeAIAABwWA
Date: Wed, 17 Jul 2024 04:09:53 +0000
Message-ID: <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
	 <Zpbify32lel9J-5I@slm.duckdns.org>
	 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
	 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
In-Reply-To: <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SEYPR03MB7864:EE_
x-ms-office365-filtering-correlation-id: 0c80d938-f418-4eb9-9148-08dca6164fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2VPNVJoNkpEMVlyRnc2Ykx6d05nS0RPaHNOeFZVR254TGp3Z21DakQzNGht?=
 =?utf-8?B?Wi9YbFEzQml3SU92RmVvS2l0YzRuRkREQ00rbU9qUzUvU0R3cmlucEMrZHFC?=
 =?utf-8?B?NE5tUFlCOHhYVWZrOG9ENlJ4Q3dCVXltM3c0SkVvNlQvYjRjOVh6SktDYnRL?=
 =?utf-8?B?SEtHWUVaRVkvTEowUWFEeXcrQ3ZkT0Z3VnB3dXEwZjU0MEpEKzM0SStnMDN5?=
 =?utf-8?B?SWlQT24vT1RCVFVEVkRJbENkT2txRXBjMjBNZFU4WFo4S0x1Ky84U1pIN2VU?=
 =?utf-8?B?ZmJUaExzd1cwdkVaREZoSmFGNGpXNU1oWlVXdHNFcWM4MTFuY2YvSmU4YnVB?=
 =?utf-8?B?SEpGaHRVSHBhWEdnZmtFT1dtS29mNHovcTlYQ2hMU2lEWVBYOHNhcUdkd2VY?=
 =?utf-8?B?MjI4c1lLajFyeXBNWC9YWDJVWWx4N2lhWWNaTjVuczBVNHJTeXY5T1c3WEpk?=
 =?utf-8?B?aHA5SDQrNjZLR2Q5bWNTZnpaV24zb1RnMUpBMVVjYW5vb044Q25UeFljWFNz?=
 =?utf-8?B?VU1mQ1FEQ0U2clpMVThxTi8vUlJJL1JjczQ1YXJLTFZyaS9tczRvbzhjWVJv?=
 =?utf-8?B?MUJORjF3Y25keEZwOGhBMUtSNE14U1JpMnM1R3cyb1VZQWhtaXNoaFZjVVQr?=
 =?utf-8?B?a0dkWVU2YnNHUUZic0JlN3ZzTlFyOXdFMkpNaW0rMm9QWHNYTTJPWUJUalNi?=
 =?utf-8?B?ZUdhNGNyRDNQMXFYcVEzK2t2VFA5YmhSdXdIRjJSbUhMVVVKeFUyRWd2MjFO?=
 =?utf-8?B?NnMxZjdIZit6UktqRFpDZEZqbTdJVXcvQjFIK1ROSUNFUzk0Ym9Yc1g0Vmdy?=
 =?utf-8?B?Q3dyY282K3N1Y1dIMnFwR2JGVVMvYXFzZkZ6ZmtBalB6RU4vc2NkaVNiRzVG?=
 =?utf-8?B?T0hpK1JqRjY4S3dMcGYwWEVudTVLZVBhSWU2MkRvZmNYeWNaaVZ5UUgyL1dT?=
 =?utf-8?B?QkRoMVhkL1Q2VmxLc0R5cGtLL0ZZWGxNNVZaVGhpbEZ6MGllMFNhOW1DM0NO?=
 =?utf-8?B?U2JLdW5ISDBMd1NvU1hJb2MzSm9WbmdNQlIyWmdtYThlQ1Z1WEVBb0JsTm9l?=
 =?utf-8?B?UGVSL0p4Z1RYRk56aHFIc1ZpZU1QRzg5L0wwMGNEV2FwRHpwSjJIQ0FQVlN6?=
 =?utf-8?B?ei85YnFpaldicUs3ai9uRGgzSU5HSmpxK0ZISlI3cUY0TFVTU1g4Wkxrb2pL?=
 =?utf-8?B?Z3N6WUFycjJoU205K21ia2FpMGhoWlgzZURwdlpHT1pyZ21MRUVySVBxTmNp?=
 =?utf-8?B?Vy9MVGxIZFRCV3RPNThENHErNlFSeEg0V1JOSmE4UHhCZ3FjamlBb0xzbGZl?=
 =?utf-8?B?VitXSjM1bnlIOU9pTWV6U3R4YlBmVUMxckEwalR3cVBLRStLN1NNVU1FVWE1?=
 =?utf-8?B?bkpLTUtDbjBhNHdEZzZFVmljeW1TbHRUSGtHS3o3emEvSkhFYzhwUjRSNlNB?=
 =?utf-8?B?SzZuK2l6dm9mbm5BSGNLTzl2dHlJek9PeHhiaTJiUHFUVHhtOFp3WjEvcURl?=
 =?utf-8?B?MG8wZW5FcmhIb3IxZGZBSlhEbmZRL2g3V3VRUzRpRGhmeG90bGQwQ1U4RXBr?=
 =?utf-8?B?Z2s3WDh0clhZSEdNWmc4QzlmdUhMbXl6L2xRM21YTkZyR1A5WmVWN3N1QUlW?=
 =?utf-8?B?NmQvSXZDYWNYVFhnaXdKMndZOEhSOTRXT0Y3ajFSVTVaeXZrLzdNMXRrQTFv?=
 =?utf-8?B?dVRlZWtraGN1VkJDenN0SklzMjhreUlmNE1LYTBYVHFqdVkrWE5za1NZcGRR?=
 =?utf-8?B?L3BzYnQ0MXdXRUtSVEp1Q0R3S25zcDNhbVRDYmI2RVdiNzdLZ25rbUhHUU9Y?=
 =?utf-8?B?TmlMVm1vMTM4b1N4cnlTSXBEbXAvOGNrTXpTaGsrZ1hmZURGeWJRL1FrZFZF?=
 =?utf-8?B?Y0luOHh3RGJRZm94WGZNNFo0TGZpT2Q2QWszM2J1SnVrenc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTM1SXhvekRPaUdCTXd3ZUpFK1pZL2N5N0g3alMybmkzVHYzbWhJSGhXNmJh?=
 =?utf-8?B?WjJDQzNwNjVhQWRHaU1LbkNKTFFQYldIZS9Bc1ZDTTVvdHVaei82djFjYlFJ?=
 =?utf-8?B?TnZCVytDcWdENEtLbHdkMGNJQnJXNkt0TUNIcXg3WGhBMVhPb0FIWXN4R0FF?=
 =?utf-8?B?VUo4N0V3cXROUkFNSU8rZmY5TTMyb284RkoxeGZoU2Q3Zi91RUw3Q0Z6S3g1?=
 =?utf-8?B?RElGVTR3NXRXVUtKZWdNcGoxaWI0L1JUK2xPd1BJYjBvR2ttWVNjV0hIT0ZO?=
 =?utf-8?B?Z2QvamNIcHZFQmhlYm9ZMGEzUUwzc1grWXMwWG1iQURIUjV6U2IrQ2RMTXlo?=
 =?utf-8?B?aFlyVW00Tzg4dTcvMmpwQTR4R1JDT2xiOGNwYWdSY1ZJYXQ3Y3hPWVpEdVJ1?=
 =?utf-8?B?UHRUaW1UMm9lWS9yYmhlVm9YZU5va2NVZWswbHZKQzZCODlzN2txdDBpMXdx?=
 =?utf-8?B?NHRxT2xXemJMVkdYOVg1ZGtCT1hRNG5DWkZlVll6bGtyY3NjVW1QZXpBY2lm?=
 =?utf-8?B?OUVWUmdiKzBhZXFwZzlkRGZXbnk3c1I4MkxJUEszUEpkdUszKzR4d3BwanYz?=
 =?utf-8?B?UmdlVFB1cUtwY3EwUnVuMmFQVlIrVHVWejloQ0oxeTNUT3ZGclZ5Qys4d1g2?=
 =?utf-8?B?WkFUbUdzcEgxT01lY0s1SS9GWnMrSW12WG5rS0FmUGh6THVUMUYzUHJKb2JV?=
 =?utf-8?B?UW9Nd1lCSHJOOEplQmhSNHNrSVlQeTBxbi93Q2pJTVVNcGE2eWFMRW5CME1I?=
 =?utf-8?B?SFJCaDlaTEdRQVZNUTViaEh2SzQ0RjhSWkdialVHQ3BaZlpOOUx0SkthTW54?=
 =?utf-8?B?aHBrTmhVR2dzcEtPQ1pLTEZHUUFCWXl0SkJ5NWROaytvdmF3b1Qvd1FJMmdl?=
 =?utf-8?B?eENxeUg1OWRJblhtcGhJOEVUTFhDNEFlcVl3Ty9FNEpZUi80R2huY3JDSlg1?=
 =?utf-8?B?VmtwdVo2eWcrTmI4VEtNT0s1TzhzekhPVFlseVlxUFMyVExXNkk3djdORWlx?=
 =?utf-8?B?Z3hHdlNkZ3RMeGx5VlhkVDMyWTdrVnZ6Slk0Mk1uSWNWRTUwS1ZVdWM0THg0?=
 =?utf-8?B?UElZNEs5UEJZNXIyVlAxeGx6bk5kT2x3ZDdoaisvL284RjgzYXRQRTNqcHF2?=
 =?utf-8?B?bUNaeHdqNnE1TzFNS3lHMnZDQ1UvVGpEQWsrSEdCZkwyV3ZmR0wrTFpid3o0?=
 =?utf-8?B?azZab0hOSkMwOW1TbVFJcG5GUkdUT01DMnV3bnJEb2xvVkU1d0RGOCtvMkpX?=
 =?utf-8?B?M1h6aXYwVWZ0MVYzRTB6UkxGL0hYZWM4a3BmZzMwOGlOQ1hkZFVtVlZ2MFBv?=
 =?utf-8?B?TDBrdUxleUxiMStIZVVwcFAvOWtzemF6cXJ6WUtFM0pNTjhvTzZ3ek5seGNI?=
 =?utf-8?B?SjVrejk4TmJBRGxvdnNjNGdLR3d0bUpyZnI3c2xUODF2VzBRNHBIQ0l4amVl?=
 =?utf-8?B?dEVhTTZZd2xCUUVXN0hSR3dWbmVIRGQ4dXdqYzhZMVB5Z0oxTDljWnQ5Q0h6?=
 =?utf-8?B?S2hHTWJlU2VpVENrdVNQUHBveS9jU0RYM1RlVys1SFhWcGVJK0VBck9LSlFX?=
 =?utf-8?B?OGtxV0pHOEVhMVVKc3Z5a3JBZU9lN3d3dExjWEI4S2dnT0NxY2FjMHh3Tk5E?=
 =?utf-8?B?WTFxdVJxU3kvT25yMkdsQlM5V0hPbnovdkZTU2xBSVAzWTVKUDJhK2tPeFVR?=
 =?utf-8?B?ODdIdWRlYS8rMnB3aG45cWwyV3hCcTd3d0lrV3JPTVpVL2J5K1FQZjJDNlJ2?=
 =?utf-8?B?NUxNRWFseVowY2V3U2tvNzdub3hwc0l5NDd0ODc3bG42MldRZ21OMDRYOVdq?=
 =?utf-8?B?MnhuQmRFSUNLWThzTU9qU2ZaaUwwTm5MYU1LN3hWV2FrWmIvVk1vNi9BNVcw?=
 =?utf-8?B?ays0bGZPVERWVXJVT3VZWVoxVHV1anV2MXI3aGQwdEVCeElYa1JtdkZicm41?=
 =?utf-8?B?TERscndZdm9Eays3cjJ2Tzl1U1kvUDlWZVdVZnNMWXlQdmxaK24xTnhQWWNo?=
 =?utf-8?B?MmlrNnBBb3p6QjlKa2NFSDQwR2R4VUxGUVQvWHpLWmhqMWlPRUpqLzg4MCtG?=
 =?utf-8?B?R2g0VDJHeEhwRHdjQlBTcXRxME9SQnJvS3U3bGU4dlZFUit4NUZZYURoZksr?=
 =?utf-8?B?YjhkaXNSVHZRSmU1Z1kxaXNydnFTL2pPUitxQzVuNGF0b3RHMnFMUW80UjVj?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <159F174EC0FF164FA1324A5B4D80A6EB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c80d938-f418-4eb9-9148-08dca6164fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 04:09:53.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdwyA2w9ekNcYlMQy/xdXa94iaHrP99tojdA5YtgpSbfPZRtFhivZ9rdYUVJyp0bZ5v2FSw6M8B4Kf83B3aDog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7864

T24gV2VkLCAyMDI0LTA3LTE3IGF0IDExOjQ0ICswODAwLCBCb3kuV3Ugd3JvdGU6DQo+IA0KPiBJ
IHRoaW5rIHRoZXJlIGlzIGFub3RoZXIgd2F5IHRvIGZpeCBpdC4gTWF5YmUgd2Ugc2hvdWxkIGFk
ZHJlc3MgdGhlDQo+IHJvb3QgY2F1c2UsIHdoaWNoIGlzIHRoYXQgdTY0X3N0YXRzX3VwZGF0ZV9i
ZWdpbl9pcnFzYXZlDQo+IGFuZCB1NjRfc3RhdHNfdXBkYXRlX2VuZF9pcnFyZXN0b3JlIGRvIG5v
dCBwcm90ZWN0IHRoZSBzZXFjb3VudCBpbiAzMg0KPiBiaXQgU01QIHN5c3RlbXMuIFRoaXMgY2Fu
IGJlIGZpeCBieSB0aGUgZm9sbG93aW5nIGNoYW5nZS4NCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3U2NF9zdGF0c19zeW5jLmgNCj4gYi9pbmNsdWRlL2xpbnV4L3U2NF9zdGF0c19z
eW5jLmgNCj4gaW5kZXggNDYwNDBkNjYzMzRhLi45NGRkNzRiNGZiMmMgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvdTY0X3N0YXRzX3N5bmMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3U2
NF9zdGF0c19zeW5jLmgNCj4gQEAgLTY0LDYgKzY0LDcgQEANCj4gIHN0cnVjdCB1NjRfc3RhdHNf
c3luYyB7DQo+ICAjaWYgQklUU19QRVJfTE9ORyA9PSAzMg0KPiAgICAgICAgIHNlcWNvdW50X3Qg
ICAgICBzZXE7DQo+ICsgICAgICAgc3BpbmxvY2tfdCAgICAgIHNwaW5sb2NrOw0KPiAgI2VuZGlm
DQo+ICB9Ow0KPiANCj4gQEAgLTEzOCw2ICsxMzksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdTY0
X3N0YXRzX2luYyh1NjRfc3RhdHNfdCAqcCkNCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCB1NjRfc3Rh
dHNfaW5pdChzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMgKnN5bmNwKQ0KPiAgew0KPiAgICAgICAgIHNl
cWNvdW50X2luaXQoJnN5bmNwLT5zZXEpOw0KPiArICAgICAgIHNwaW5fbG9ja19pbml0KCZzeW5j
cC0+c3BpbmxvY2spDQo+ICB9DQo+IA0KPiAgc3RhdGljIGlubGluZSB2b2lkIF9fdTY0X3N0YXRz
X3VwZGF0ZV9iZWdpbihzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMNCj4gKnN5bmNwKQ0KPiBAQCAtMTkx
LDYgKzE5Myw3IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZw0KPiB1NjRfc3RhdHNfdXBk
YXRlX2JlZ2luX2lycXNhdmUoc3RydWN0IHU2NF9zdGF0c19zeW5jDQo+ICB7DQo+ICAgICAgICAg
dW5zaWduZWQgbG9uZyBmbGFncyA9IF9fdTY0X3N0YXRzX2lycXNhdmUoKTsNCj4gDQo+ICsgICAg
ICAgc3Bpbl9sb2NrX2lycSgmc3luY3AtPnNwaW5sb2NrKTsNCj4gICAgICAgICBfX3U2NF9zdGF0
c191cGRhdGVfYmVnaW4oc3luY3ApOw0KPiAgICAgICAgIHJldHVybiBmbGFnczsNCj4gIH0NCj4g
QEAgLTE5OSw2ICsyMDIsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gdTY0X3N0YXRzX3VwZGF0
ZV9lbmRfaXJxcmVzdG9yZShzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMgKnN5bmNwLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25n
DQo+IGZsYWdzKQ0KPiAgew0KPiAgICAgICAgIF9fdTY0X3N0YXRzX3VwZGF0ZV9lbmQoc3luY3Ap
Ow0KPiArICAgICAgIHNwaW5fdW5sb2NrX2lycSgmc3luY3AtPnNwaW5sb2NrKTsNCj4gICAgICAg
ICBfX3U2NF9zdGF0c19pcnFyZXN0b3JlKGZsYWdzKTsNCj4gIH0NCj4gDQo+IC0tDQo+IGJveS53
dQ0KPiANCg0KTmV2ZXIgbWluZCwgdGhlcmUgaXMgYSB1c2FnZSBpbiB1NjRfc3RhdHNfc3luYy5o
DQoNCiAqIFVzYWdlIDoNCiAqDQogKiBTdGF0cyBwcm9kdWNlciAod3JpdGVyKSBzaG91bGQgdXNl
IGZvbGxvd2luZyB0ZW1wbGF0ZSBncmFudGVkIGl0DQphbHJlYWR5IGdvdA0KICogYW4gZXhjbHVz
aXZlIGFjY2VzcyB0byBjb3VudGVycyAoYSBsb2NrIGlzIGFscmVhZHkgdGFrZW4sIG9yIHBlciBj
cHUNCiAqIGRhdGEgaXMgdXNlZCBbaW4gYSBub24gcHJlZW1wdGFibGUgY29udGV4dF0pDQogKg0K
ICogICBzcGluX2xvY2tfYmgoLi4uKSBvciBvdGhlciBzeW5jaHJvbml6YXRpb24gdG8gZ2V0IGV4
Y2x1c2l2ZSBhY2Nlc3MNCiAqICAgLi4uDQogKiAgIHU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnN0
YXRzLT5zeW5jcCk7DQogKiAgIHU2NF9zdGF0c19hZGQoJnN0YXRzLT5ieXRlczY0LCBsZW4pOyAv
LyBub24gYXRvbWljIG9wZXJhdGlvbg0KICogICB1NjRfc3RhdHNfaW5jKCZzdGF0cy0+cGFja2V0
czY0KTsgICAgLy8gbm9uIGF0b21pYyBvcGVyYXRpb24NCiAqICAgdTY0X3N0YXRzX3VwZGF0ZV9l
bmQoJnN0YXRzLT5zeW5jcCk7DQoNCi0tDQpib3kud3UNCg0K

