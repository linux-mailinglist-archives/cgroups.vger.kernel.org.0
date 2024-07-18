Return-Path: <cgroups+bounces-3755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8B9345AF
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 03:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5B61F226E5
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50915C3;
	Thu, 18 Jul 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XJQfcgXb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gBtZW7NM"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF515394;
	Thu, 18 Jul 2024 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265708; cv=fail; b=jdQZAObbJWhUp0wb5C9obwfrcvxSuW7w974dg2bOSwgLsJuVQv+xx/EZg3E4WTlH+DtqpXxzoZdW+H/QEqa0UBScS9hXUPJznZy+KyN4FrLL6+/eLuBXU5/I6Z7pzVmdhEVpE/MGrxsAVjMbtkymW1bGnM1ELun856BIDCJMgmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265708; c=relaxed/simple;
	bh=cc0nUzW/0K9V0IUoqH8FTGftS1rL+dqVCqSA/gTECiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tFIMxJz9DrsLXbvlU/hYsIWYTb5Q2lvmSKpvX3U8BG8eyiB9LFUBOrgjB6mOeByKFb40fKl68u43fEm+/F5s80yqfLMMKheIgcQRsnXTkgSl6vJV59vJDHmKMRZUTIAdxVu7MysjAnmrpi2Cjbi7EfFk6rskQbn4+HfePgikb0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XJQfcgXb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gBtZW7NM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 12bc5ebc44a411ef87684b57767b52b1-20240718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cc0nUzW/0K9V0IUoqH8FTGftS1rL+dqVCqSA/gTECiA=;
	b=XJQfcgXbtkMqeJtlYvZh+Fw5zF+wF2ymswcrJ1xpdrMNm09G+gPwtMCCWTCMR3pRNn6vol24uFuGXLpn7DvnFN3qR5mzWxZTQ3TeC4eh6Cu3YB+iP+sdvwxIE1smNp4ffYmQkGVMyezO6LZGsXyHFH+/9TORYST/A+aRFyK6NY8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:22cefdbf-38c0-4280-8b6a-46302583dcc4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:0ad8950d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 12bc5ebc44a411ef87684b57767b52b1-20240718
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1142175392; Thu, 18 Jul 2024 09:21:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Jul 2024 09:21:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Jul 2024 09:21:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrBP/qRatQ5J512hWdHX5zHnQti2W0vxN8VniZe7OGoxP0gemS20bPnSFfBiRVaBwAiBo7XQApWFMNZsfBmMd2F/vEVqjnKbBtZKunZUQvVPsTHOAnOFC50cck1Pa3JIls/GHk1W2ZSSrKjwNdqoU01fJ4zWaiTpMMJDn6Cj67NM4PZPX/Hsp/TwyelKDaNDxFML111sajdGPEDyLPjoJMc9Yn+GAHOaweiE8uqsIC8epAyxsT1IkNWdfkvOLPAuLVlJbRfNuXV4LmRDwkcD5vXlroFPAcuLpwYlE768c2oFkBY0H6/KqQP4g2qmMWe4J4SeoCMMKj62kJ7dOjVJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc0nUzW/0K9V0IUoqH8FTGftS1rL+dqVCqSA/gTECiA=;
 b=IPQSI44qlRdFzioa5X8FzodhYLi9AzZoKggSeJxCrXkaQphb3SQ36fOGPSM1Mx9VGFRjCoTaTjJrI/XXrrtJlC8MigunXlX7t8WZ+yfMIjxJQ9LyYXO+VEPELBOi65OdVQAsHT6Zqnu7iGWKFLFLjbY0tJpZH7AGVmcjHjyTeJlrKxDVjP9fQ6HWx5YsnbPO16HOW3tahVIuI6MMApXEhorHBFPdJ9vydUTj7rRiWp5hrOX3fucQYrZ56LA0IJl2objx6R9MmF5sEGQPP4plOH4hdB9XnD9SsF9O+ioBx5yC1QBAxhv4riZPnP9lUm1H4jNJxc72e7MtsPEy/0Dw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc0nUzW/0K9V0IUoqH8FTGftS1rL+dqVCqSA/gTECiA=;
 b=gBtZW7NMwxg4kGLFwpsK0saG/i/gprg0PZLxNNzZL/QVCF3q5Ee6LMapH1plxvYiuOIoNverQ1ZwfVmn7LZrVARdQsJgg+Jil3lk9e44lttT5TnqfhOrsOzEINo7hb3ZY2CjJ22LF52K/ReK3toTpKXW7o7pp1SoQantOr1atHk=
Received: from SEZPR03MB7873.apcprd03.prod.outlook.com (2603:1096:101:189::8)
 by TYZPR03MB8103.apcprd03.prod.outlook.com (2603:1096:400:45d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 01:21:32 +0000
Received: from SEZPR03MB7873.apcprd03.prod.outlook.com
 ([fe80::cb95:6c16:4f9a:a0ab]) by SEZPR03MB7873.apcprd03.prod.outlook.com
 ([fe80::cb95:6c16:4f9a:a0ab%3]) with mapi id 15.20.7762.032; Thu, 18 Jul 2024
 01:21:32 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
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
Thread-Index: AQHa11Ul4ctm5KmuYkmA12uhv9CQ2bH521+AgABXLQCAABYeAIAABwWAgADV/ACAAI1OgA==
Date: Thu, 18 Jul 2024 01:21:32 +0000
Message-ID: <99af713e187a92f0501482e8344be469f1b3e454.camel@mediatek.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
	 <Zpbify32lel9J-5I@slm.duckdns.org>
	 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
	 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
	 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
	 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
In-Reply-To: <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7873:EE_|TYZPR03MB8103:EE_
x-ms-office365-filtering-correlation-id: f203ec3c-c419-49c4-1996-08dca6c7f546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXRaZ0V0K1RyOVhyL1Y0OHU0SEhsY0ZIeFR4eHU1Mm1DbWxMcW1LVzJJWSs5?=
 =?utf-8?B?dk5kSHBjcFpsZFJaM0gwZllLRlRpK0Z6OUdSMExsZnZ6WnVzK2s4SjdmMkZW?=
 =?utf-8?B?bnZ3MmZBdVp6MFNmYkR4Qmt5MDRxekR1Z0x2ZGIvUVplbnk5S0M5MkVCSEFL?=
 =?utf-8?B?ekR6ci9wNFhyZjlRNUd4RlJObzRMWjlPaVh0OUJKZzlqN3RNWEpUbUFPQjBE?=
 =?utf-8?B?a1dPdGVZUUdIanJWb25VN052VVF3b0JUbTlVWDluaVMraVJDOGk1ZGhXa0ZR?=
 =?utf-8?B?aTRWZEtVeTJYWEdBU2kza0RIY0x2ZENNQzFMQk5XWGxUQUg3aGhXN200YXQ5?=
 =?utf-8?B?d1Q4SFNTbms4dmt3TnVvY0ljL0h6a1Mxd2VYaC9vMkJxYlRZM1JNOW42YWdO?=
 =?utf-8?B?WmlnTEFrVURuand5aS8zOFpSVUdSMHlkcUVsS3A1MDgyMlVURHNlNXdxK1pK?=
 =?utf-8?B?YkRJbDJqWnAyRFE0YXpOWHh3SXJFaVArNVhDcDEwUG05YWNsL0xXSXcwUGpX?=
 =?utf-8?B?NFg3MzlZdTl2bllnNDlSbnl5UDhTbUp6eHlKZXNCSXBPYVBOOWJ0YUhuc0Fn?=
 =?utf-8?B?RnNtcXZWcHlKRWV2Z3NyQ1Z6QlNUeDBhS2luK3NBMGthVnJNd2JqSy9XOEh4?=
 =?utf-8?B?d0I2ell3MjNYQjcxZ3J2LzdpMGhqL1dIQUV6UEM0Tjl1SmRKeGdvREpGTnhM?=
 =?utf-8?B?SVh2a1FqM0FvOEIwVUZvLzlHS2lQaW9nN3JrSy9WaGthMndnVDFUUUpRMGda?=
 =?utf-8?B?OVMyMmVxWlQzNkNDb1B4VUk1Sk5Xb2tGeFM5VUlnNWRhS3J6U2RuSzZtZDhx?=
 =?utf-8?B?VzdNSTJ2dkRQMXpNaE94VjN3SXRFTzQ3VEZDcHdzRkdYYzVBdFpYNTMrQkZH?=
 =?utf-8?B?MWxwM0VWMDdNOE5NbUVrK2RiOEc2b2FwSHZ2ZUgvSWxha1NXTkYxVk8yNXFn?=
 =?utf-8?B?RnNLLzNwSmdkYitEd3A2M2tqc2RsOHRTTTk0ZzgrazUyNWt3SHJIU2V6UVRJ?=
 =?utf-8?B?S2l2eGZwSzlsaHdxcmxNNTNNTHkwSUdXY1VadjQ2Q1RVMmYwTkE5ekU5UDJh?=
 =?utf-8?B?ak1FbDVIYkI4ak1MMC8rcUNzZlJIUzdEMndtV3RyS1lWZEhNSkpRbWJEYitQ?=
 =?utf-8?B?bmU1MmFUOHlOVmVrMS80cUZHWU0yRnkyQVpmWGN1b2UwRURJUE5qL3h5ZWtt?=
 =?utf-8?B?R3pxdVhnZjFjdDhOZGpnUUUrRzU0eGxRUU1qbmRLMEJVYzBSSk8wREtiK2Zs?=
 =?utf-8?B?SWRFdGxMMXNwcE1NNzNqN2ZvWmUwR25kakhyeG92NUkyUWhSOGoyRW5EdVph?=
 =?utf-8?B?YTJNMWI5Vys1N2oybjByN3hnVnB5eXIwR3RTbTlzcmI4eGN4WXpWNGZuajFF?=
 =?utf-8?B?d2N0VUxtdnM0dUVYMERCcEtxM0RMdjNoKzRROEpwVVh1TURsTFZlOGMzT1RR?=
 =?utf-8?B?TFk2VWNaSE1aejNsS2RuY1pkUG9rcG5PbGxOT3Y4bXc1T3N1bndoMVgweGpR?=
 =?utf-8?B?V2Z4TUVweThTWi9PdUg0K0tyRmFXK1d1SVBQd2k1OGhWd1hweDVHaFhyajBY?=
 =?utf-8?B?ZzdHSlY5Y0NNWTllb1VWeWlkWHdrelFJbjhtZXhXK2pmWkU2K2xsRmFzdDlW?=
 =?utf-8?B?WFdSblVLRHNwd0g5cUZWY1FQV08xTjQ1ODJGQml3RXVlaDMvd0Y3WXlabnA1?=
 =?utf-8?B?N1NGRGVlWFBOKzE3d0dOMTV4QS9SeGhkOUNQUnNqQzRmTithUGcvV0FNMFNJ?=
 =?utf-8?B?aXlkejJUL3RRSjA2cWlxMFZqWEc1elF0VHZhaW9HaEJWLyswSmMxemVOc1Z2?=
 =?utf-8?B?TzVsc2VZdHBkMTB4R1hVOUlUWlpCcld3amszOEVMRlNCb29XeHNYc2ZkUFhi?=
 =?utf-8?B?ekEvcjZIRitrcDBRK2ZQUXFkRld5NVc5b1V0ZFNORVp1WHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7873.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0hjeU1lL25pYVc3eTFYTTdTSUhqS285d3g1YnpVVk94TkVieWhFZ2NtTytD?=
 =?utf-8?B?VUlsQ2UwRDY0bVlMclBGVGlSZXFBV2Z3dEl5d0svamxWbTZoZDkwL01TZGFL?=
 =?utf-8?B?MkphVmZRSlJZWUJNQ2tGZzJ2bnBtNUdMNm10Tm4xNGtlcVRwRlU4Z0w0RUEx?=
 =?utf-8?B?ZWNud05JR2pNcktjb3p1d3JrUzQxczFNTTdzV3NONDhkaFd4dFlCNUM5RGlp?=
 =?utf-8?B?UTA1d29WY00xb1hHdllYWE9nYzY5MlQ1ekFSWEMvRjZlUGRuY0tQZEFQR2pP?=
 =?utf-8?B?c1VoMnQxOFptYmlLU1cveXk1RW5ybXdQYUFtdEd2V08zblpCRkVnYStXQ3Q0?=
 =?utf-8?B?OVplb3JiV2d0QUYwcEI4TzBuZEFvazQ2VzJLUjBwTWJYOWlSTXdMdXZoNHY1?=
 =?utf-8?B?VVJFd2M1bmdPRVFzS0hjbHFncWEweHZuN3Y2Nmw5OFduMzhXS0xzT2ttWCtj?=
 =?utf-8?B?enZVZ0crNkh5dzMxU2dxM3orYm1tc01TSXhDRVUwY2xId2xXclJPQmF0bzMw?=
 =?utf-8?B?aWd6TkxFdnJMWWoydS9RTnJiWjJ5ZzhmOHVFVGpacmE2NXhSV1AxL1gwVkh5?=
 =?utf-8?B?VW8zWk5zNzFuS2VmeW9WZXdZampCaTRkcXZxVU5MMzQrSEsvdm1ObXJJRTlO?=
 =?utf-8?B?ZmNvMUc2TGRlNGlvcHhwWjd4RDhjbWgraFRrVGxvTEZqakozSWgwaERFd3NF?=
 =?utf-8?B?SitJTytjd2UxVFZWZWN5NXRkOGdZT2FzM3puaFNYRlozbm9RaHpiRkZYdUlv?=
 =?utf-8?B?UU9UY3Bmb01VWW9XcjVxcHM4cWE2cmlHc1hSc1dVZDRvRnhBVm5yK3dnK0x6?=
 =?utf-8?B?b3ZTWFNoblp0VzJCeFU3Z3NpSFBpTURLR0tNVXduMHJUWDVoMEdDOTBudWpm?=
 =?utf-8?B?bFIwZ3psY3VFZlR0WWNIb2xMZS9jbTlBN0t0OEFIMnVUdkg4NFFjL2Z5ZGxw?=
 =?utf-8?B?dzBxYUhGaHROazA0Sm1acVlEeUhxZXNUblZXV3h5dVQxTVNqZUNPb0xXWk5T?=
 =?utf-8?B?cEhBMDd0RHdMaXlpLzdKMmZZY0xQWXFhem5oU2lESk1hbG5JOFlmMnNYVHNq?=
 =?utf-8?B?eFBhRmw2SDVTODhleUxHT1FYWU5BRmxDYitoWitpcHlJamxHS0NySDE2VFF5?=
 =?utf-8?B?VjNWeG9BZ094M3NQaDVrdTV1VCt5bHgvNmozaFVGRnVWTEE0cGlYejIwVGY0?=
 =?utf-8?B?VHIxc1Z4ckc1YWFrdkhvZzlicUFVWC9JaFhuQ1VPcThjSmJCZ2dBcHhnRUZO?=
 =?utf-8?B?TXo5ZERpK3RhaUdPRzNoUXlUaGNHdUpoUEhIM2hmOENOc0lNMlhRNW02bUNQ?=
 =?utf-8?B?N1dxUlIwTUxWdGNEZ3lLL0htR3NwenNQUXQxSURxU3RhUHA5ZlRzeXBOdVAv?=
 =?utf-8?B?Q1RGeHNMR0ltcis4SnU5NVBoV3E1T2JMS054Sm9jeExVbkhCUGxIbUgvdm5H?=
 =?utf-8?B?OVlyd3RPM2EwYXoyY0xEcnRnZ3lzS09jUFFDRG1UajNxeW5aN0kvK1BmV0VT?=
 =?utf-8?B?T2NNcWNscmZCMHRBdGZ1VE5xOWdDUDZSbUh0Smhpc3p6WjNZZkhVdnlqaWxS?=
 =?utf-8?B?akMxVFdKeEY3OGR0TlQyM0VzNGVxcTBQektsZmVTT2xhSXM2TUVEZUhhaVJy?=
 =?utf-8?B?VnNLdklJdllTWjJLYXowTEtnd09uVkVFTUw0dmVNbDBKYkRmcGY2dXQ0ZlAw?=
 =?utf-8?B?RDBrT0toVEJ6U0dQS2RWREs2dUdzKytmY3dEMVp2aFdJeXNTNHBGekxkWnM4?=
 =?utf-8?B?S2ZycEhVOFdETGVxb29kbzk4QkVBVG9KR253QlFuZDJOL0dVdlpCVXBoRDNr?=
 =?utf-8?B?akZpV1YwT2hZdlA0ZURqQWcwOFd0YjZYT2RxQzczekxjS3RYNWhSZDluTWh1?=
 =?utf-8?B?ZE9IVW4zVVkxSHAzWlF0RFdERlFhUGNkS1luK0trUUwwSzhsTXdmcEVWcFFE?=
 =?utf-8?B?UDQzVUdqNUE5YTR4dXZlRGduYlIwdzdxYUZ5SnZqYUFVVm5WUmNvdURqaTFK?=
 =?utf-8?B?MSswZ3JRWVBNUldSaWEwRE1Rc1JKdnlCR1l3eVh4ZERXUXo0cVZxWm80bHc2?=
 =?utf-8?B?eE9hZ1ZxV2RRY1ZTZzRYZzhQWE82RVdEY0ZKbVBZQytpeXVhOURMeTRSMHVK?=
 =?utf-8?B?K1BEam9yd0laSlk5cHVGWUlDSGw3Z2RwL3hLM3ZHOGt1ckh4M2ZDSjlqU3dy?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C83B7DC3C07274FB49A3C45B1EAEEE7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7873.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f203ec3c-c419-49c4-1996-08dca6c7f546
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 01:21:32.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qf2FmTR5pvrpQQHxiUibwi69pUPrFOpBVnZ52McuG2Z1kR7KwA3xLrWWV9hIQhrTwgQo7qlxVjTFQ8WmT6Dv+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8103

T24gV2VkLCAyMDI0LTA3LTE3IGF0IDA2OjU1IC0xMDAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIEhlbGxvLA0KPiANCj4gRG9lcyBzb21ldGhpbmcgbGlrZSB0aGUgZm9s
bG93aW5nIHdvcmsgZm9yIHlvdT8NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IGRpZmYgLS1naXQgYS9i
bG9jay9ibGstY2dyb3VwLmMgYi9ibG9jay9ibGstY2dyb3VwLmMNCj4gaW5kZXggMzdlNmNjOTFk
NTc2Li5lYzFkMTkxZjVjODMgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1jZ3JvdXAuYw0KPiAr
KysgYi9ibG9jay9ibGstY2dyb3VwLmMNCj4gQEAgLTMyOSw3ICszMjksNiBAQCBzdGF0aWMgc3Ry
dWN0IGJsa2NnX2dxICpibGtnX2FsbG9jKHN0cnVjdCBibGtjZw0KPiAqYmxrY2csIHN0cnVjdCBn
ZW5kaXNrICpkaXNrLA0KPiAgSU5JVF9XT1JLKCZibGtnLT5hc3luY19iaW9fd29yaywgYmxrZ19h
c3luY19iaW9fd29ya2ZuKTsNCj4gICNlbmRpZg0KPiAgDQo+IC11NjRfc3RhdHNfaW5pdCgmYmxr
Zy0+aW9zdGF0LnN5bmMpOw0KPiAgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgew0KPiAgdTY0
X3N0YXRzX2luaXQoJnBlcl9jcHVfcHRyKGJsa2ctPmlvc3RhdF9jcHUsIGNwdSktPnN5bmMpOw0K
PiAgcGVyX2NwdV9wdHIoYmxrZy0+aW9zdGF0X2NwdSwgY3B1KS0+YmxrZyA9IGJsa2c7DQo+IEBA
IC02MzIsMjQgKzYzMSwyNiBAQCBzdGF0aWMgdm9pZCBibGtnX2lvc3RhdF9zZXQoc3RydWN0IGJs
a2dfaW9zdGF0DQo+ICpkc3QsIHN0cnVjdCBibGtnX2lvc3RhdCAqc3JjKQ0KPiAgc3RhdGljIHZv
aWQgX19ibGtnX2NsZWFyX3N0YXQoc3RydWN0IGJsa2dfaW9zdGF0X3NldCAqYmlzKQ0KPiAgew0K
PiAgc3RydWN0IGJsa2dfaW9zdGF0IGN1ciA9IHswfTsNCj4gLXVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ICANCj4gLWZsYWdzID0gdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZiaXMtPnN5
bmMpOw0KPiAgYmxrZ19pb3N0YXRfc2V0KCZiaXMtPmN1ciwgJmN1cik7DQo+ICBibGtnX2lvc3Rh
dF9zZXQoJmJpcy0+bGFzdCwgJmN1cik7DQo+IC11NjRfc3RhdHNfdXBkYXRlX2VuZF9pcnFyZXN0
b3JlKCZiaXMtPnN5bmMsIGZsYWdzKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgYmxrZ19j
bGVhcl9zdGF0KHN0cnVjdCBibGtjZ19ncSAqYmxrZykNCj4gIHsNCj4gK3Vuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ICBpbnQgY3B1Ow0KPiAgDQo+ICtyYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmJsa2df
c3RhdF9sb2NrLCBmbGFncyk7DQo+ICsNCj4gIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsN
Cj4gIHN0cnVjdCBibGtnX2lvc3RhdF9zZXQgKnMgPSBwZXJfY3B1X3B0cihibGtnLT5pb3N0YXRf
Y3B1LCBjcHUpOw0KPiAgDQo+ICBfX2Jsa2dfY2xlYXJfc3RhdChzKTsNCj4gIH0NCj4gIF9fYmxr
Z19jbGVhcl9zdGF0KCZibGtnLT5pb3N0YXQpOw0KPiArDQo+ICtyYXdfc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmYmxrZ19zdGF0X2xvY2ssIGZsYWdzKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlu
dCBibGtjZ19yZXNldF9zdGF0cyhzdHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqY3NzLA0KPiBA
QCAtOTk4LDEyICs5OTksMTAgQEAgc3RhdGljIHZvaWQgYmxrY2dfaW9zdGF0X3VwZGF0ZShzdHJ1
Y3QgYmxrY2dfZ3ENCj4gKmJsa2csIHN0cnVjdCBibGtnX2lvc3RhdCAqY3VyLA0KPiAgdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCj4gIA0KPiAgLyogcHJvcGFnYXRlIHBlcmNwdSBkZWx0YSB0byBnbG9i
YWwgKi8NCj4gLWZsYWdzID0gdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZibGtnLT5p
b3N0YXQuc3luYyk7DQo+ICBibGtnX2lvc3RhdF9zZXQoJmRlbHRhLCBjdXIpOw0KPiAgYmxrZ19p
b3N0YXRfc3ViKCZkZWx0YSwgbGFzdCk7DQo+ICBibGtnX2lvc3RhdF9hZGQoJmJsa2ctPmlvc3Rh
dC5jdXIsICZkZWx0YSk7DQo+ICBibGtnX2lvc3RhdF9hZGQobGFzdCwgJmRlbHRhKTsNCj4gLXU2
NF9zdGF0c191cGRhdGVfZW5kX2lycXJlc3RvcmUoJmJsa2ctPmlvc3RhdC5zeW5jLCBmbGFncyk7
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIF9fYmxrY2dfcnN0YXRfZmx1c2goc3RydWN0IGJs
a2NnICpibGtjZywgaW50IGNwdSkNCj4gQEAgLTExMzQsOSArMTEzMyw5IEBAIHN0YXRpYyB2b2lk
IGJsa2NnX2ZpbGxfcm9vdF9pb3N0YXRzKHZvaWQpDQo+ICBjcHVfZGtzdGF0cy0+c2VjdG9yc1tT
VEFUX0RJU0NBUkRdIDw8IDk7DQo+ICB9DQo+ICANCj4gLWZsYWdzID0gdTY0X3N0YXRzX3VwZGF0
ZV9iZWdpbl9pcnFzYXZlKCZibGtnLT5pb3N0YXQuc3luYyk7DQo+ICtyYXdfc3Bpbl9sb2NrX2ly
cXNhdmUoJmJsa2dfc3RhdF9sb2NrLCBmbGFncyk7DQo+ICBibGtnX2lvc3RhdF9zZXQoJmJsa2ct
Pmlvc3RhdC5jdXIsICZ0bXApOw0KPiAtdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVzdG9yZSgm
YmxrZy0+aW9zdGF0LnN5bmMsIGZsYWdzKTsNCj4gK3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZibGtnX3N0YXRfbG9jaywgZmxhZ3MpOw0KPiAgfQ0KPiAgfQ0KPiAgDQo+IEBAIC0xMTQ1LDcg
KzExNDQsNiBAQCBzdGF0aWMgdm9pZCBibGtjZ19wcmludF9vbmVfc3RhdChzdHJ1Y3QNCj4gYmxr
Y2dfZ3EgKmJsa2csIHN0cnVjdCBzZXFfZmlsZSAqcykNCj4gIHN0cnVjdCBibGtnX2lvc3RhdF9z
ZXQgKmJpcyA9ICZibGtnLT5pb3N0YXQ7DQo+ICB1NjQgcmJ5dGVzLCB3Ynl0ZXMsIHJpb3MsIHdp
b3MsIGRieXRlcywgZGlvczsNCj4gIGNvbnN0IGNoYXIgKmRuYW1lOw0KPiAtdW5zaWduZWQgc2Vx
Ow0KPiAgaW50IGk7DQo+ICANCj4gIGlmICghYmxrZy0+b25saW5lKQ0KPiBAQCAtMTE1NywxNiAr
MTE1NSwxNCBAQCBzdGF0aWMgdm9pZCBibGtjZ19wcmludF9vbmVfc3RhdChzdHJ1Y3QNCj4gYmxr
Y2dfZ3EgKmJsa2csIHN0cnVjdCBzZXFfZmlsZSAqcykNCj4gIA0KPiAgc2VxX3ByaW50ZihzLCAi
JXMgIiwgZG5hbWUpOw0KPiAgDQo+IC1kbyB7DQo+IC1zZXEgPSB1NjRfc3RhdHNfZmV0Y2hfYmVn
aW4oJmJpcy0+c3luYyk7DQo+IC0NCj4gLXJieXRlcyA9IGJpcy0+Y3VyLmJ5dGVzW0JMS0dfSU9T
VEFUX1JFQURdOw0KPiAtd2J5dGVzID0gYmlzLT5jdXIuYnl0ZXNbQkxLR19JT1NUQVRfV1JJVEVd
Ow0KPiAtZGJ5dGVzID0gYmlzLT5jdXIuYnl0ZXNbQkxLR19JT1NUQVRfRElTQ0FSRF07DQo+IC1y
aW9zID0gYmlzLT5jdXIuaW9zW0JMS0dfSU9TVEFUX1JFQURdOw0KPiAtd2lvcyA9IGJpcy0+Y3Vy
Lmlvc1tCTEtHX0lPU1RBVF9XUklURV07DQo+IC1kaW9zID0gYmlzLT5jdXIuaW9zW0JMS0dfSU9T
VEFUX0RJU0NBUkRdOw0KPiAtfSB3aGlsZSAodTY0X3N0YXRzX2ZldGNoX3JldHJ5KCZiaXMtPnN5
bmMsIHNlcSkpOw0KPiArcmF3X3NwaW5fbG9ja19pcnEoJmJsa2dfc3RhdF9sb2NrKTsNCj4gK3Ji
eXRlcyA9IGJpcy0+Y3VyLmJ5dGVzW0JMS0dfSU9TVEFUX1JFQURdOw0KPiArd2J5dGVzID0gYmlz
LT5jdXIuYnl0ZXNbQkxLR19JT1NUQVRfV1JJVEVdOw0KPiArZGJ5dGVzID0gYmlzLT5jdXIuYnl0
ZXNbQkxLR19JT1NUQVRfRElTQ0FSRF07DQo+ICtyaW9zID0gYmlzLT5jdXIuaW9zW0JMS0dfSU9T
VEFUX1JFQURdOw0KPiArd2lvcyA9IGJpcy0+Y3VyLmlvc1tCTEtHX0lPU1RBVF9XUklURV07DQo+
ICtkaW9zID0gYmlzLT5jdXIuaW9zW0JMS0dfSU9TVEFUX0RJU0NBUkRdOw0KPiArcmF3X3NwaW5f
dW5sb2NrX2lycSgmYmxrZ19zdGF0X2xvY2ssIGZsYWdzKTsNCj4gIA0KPiAgaWYgKHJieXRlcyB8
fCB3Ynl0ZXMgfHwgcmlvcyB8fCB3aW9zKSB7DQo+ICBzZXFfcHJpbnRmKHMsICJyYnl0ZXM9JWxs
dSB3Ynl0ZXM9JWxsdSByaW9zPSVsbHUgd2lvcz0lbGx1DQo+IGRieXRlcz0lbGx1IGRpb3M9JWxs
dSIsDQoNCkkgdGhpbmsgdGhpcyB3aWxsIHdvcmssIGJ1dCBhcyBJIG1lbnRpb25lZCBiZWZvcmUs
IHRoaXMgaXNzdWUgaXMgb25seQ0Kb24gMzIgYml0IFNNUCBzeXN0ZW1zLiBSZXBsYWNpbmcgdTY0
IHN5bmMgd2l0aCBzcGlubG9jayB3aWxsIGluY3JlYXNlDQpvdmVyaGVhZCBvbiA2NCBiaXQgc3lz
dGVtcywgYmVjYXVzZSB1NjQgc3luYyBkb2VzIG5vdGhpbmcgb24gNjQgYml0DQpzeXN0ZW1zLiBI
b3dldmVyLCBpZiBpdCBpcyBhY2NlcHRhYmxlLCB3ZSBjYW4gcHJvY2VlZCB3aXRoIHRoaXMNCnNv
bHV0aW9uLg0KDQotLQ0KYm95Lnd1DQoNCg==

