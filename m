Return-Path: <cgroups+bounces-3561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF67929AF3
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 04:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1ADB20B2B
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5846BF;
	Mon,  8 Jul 2024 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ioGHcK+6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cv9/53rc"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2803C0C;
	Mon,  8 Jul 2024 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407138; cv=fail; b=SMw3F9s6z/qeOd0QrcGavPLPRHdbYLmiqzXUium4Z83E4CHUFVNLcU3rAjzofFzGd9evMz5kGfbaAl9xJhUAI9uiPT7PqAb2AhdM8tFOac3Rzbk4+TH1SQw6RuTQaZKeuXi3VhaWEA5Et9hDA8ruMjWcoTgve98e2lH/MxQiO5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407138; c=relaxed/simple;
	bh=HWP+x9NoV19tcOLo8xYaU/xtKhrKNrNggzcBb/1rXbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLsuvDUG3zeNWlAlGqor2xsKTNzLRM0EJTbvQ85Q7I7+dKdwhvcBFBMXodi4uDouZvPe1w4wyVKzLmrh9ah2BmgDAu6BexVI0bKJw0wf/UltSWeIdSfyNq9ovNqon2qb5SWqR/34ft3lt7A3LpFITEEoOOJpGiYeJXz06XOVJ/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ioGHcK+6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cv9/53rc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1249386e3cd511ef8b8f29950b90a568-20240708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HWP+x9NoV19tcOLo8xYaU/xtKhrKNrNggzcBb/1rXbo=;
	b=ioGHcK+6gPR+yNzrOsYrupBYPmvGfRygPLrp8cx+4HFiPunccqPX3/cftF66cb6EHNYCvmgrEakTOSyyedvMTIumTkjlof49CfdkwrVjMfnEqwqlmvj9+U3tjnKwiYkqnwSmZEb/fU3DgP6HlJqRy9BrS5O/owM3lBYf1OBaP3Y=;
X-CID-CACHE: Type:Local,Time:202407081000+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d337d53f-0669-422f-9d37-3b8e9b57a5ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:428133d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1249386e3cd511ef8b8f29950b90a568-20240708
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2032896680; Mon, 08 Jul 2024 10:52:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Jul 2024 10:52:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Jul 2024 10:52:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGHGLMh2IafQv42x4yFlhhfAuJEfPnXrm2meADnX1TalUhteHxhb90I9cL9pPIFfj/l9fpqW7BejP7tD9iLNe4PdyYivm+PNsGDBxGZ6kgT9RKAEvvs3cBkYjNoXlYZ5mQFjtKhbLtN2y+jy1f9UK/+WgKpVmlPv78wUW0BRq0fYy4oH5CmSzFqVaRzeXI9Frhpz7B5K0hx1/zeNNYZC05gsr3+qlhv010uQsD/1jO7TCdN5D1TZVOkvRxhWoEwZctHpzhV9Iy4LQ677hq+DoujVqYvj+/a35gxydtyR/zPQ8eOS+nCoowgaevGdFAsWk8tEIpYbSPTSKWn21Bq9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWP+x9NoV19tcOLo8xYaU/xtKhrKNrNggzcBb/1rXbo=;
 b=Sghx6BOzVkc0A9A+s72KYyHsbG/yhpVU1YTBi+1qCyF36jn1j4WheJcQxP22+IP/NpumbT4Aai0JCEY71GkTK1I2B9kR+O9xJNsDVugwseV/f+PNfTkQtV6LwSy2tp7C5ly61PaQ5lvj+WIcIqlruSLgNMH4VoOTVzGb1bhHW+Y+RTpzT7Y2Z7pwjSSol6Ut5nnwTJRKr6jHIKqibj7jEPew9Yadxpd10Rg045UHqDbyBfhL4qwdpvcIA9mfbi+8SsBKtD6WYY4+uJ4vcZs90x520b7PYY2NMv+e0WUMwgxCJUNaOkZrpanxV2Yy8MjvUxl51fDWtuPgML+5DLaLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWP+x9NoV19tcOLo8xYaU/xtKhrKNrNggzcBb/1rXbo=;
 b=cv9/53rcN8+5iwyaxzJL8fePywfOA240KTbKqEKcav3codPMIEgNbeCu0/FKGMhukBhbvYVaDNZ5yIX2RiFRlOhhieUdurSkJIqNCfCF4ujz8LEuQ7ljoeeib9akNfdPJvwiVzwBsnwO/45RLHOhoC1gMwi0l9eQDvfv0JyA0uA=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SEYPR03MB7214.apcprd03.prod.outlook.com (2603:1096:101:d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Mon, 8 Jul
 2024 02:52:05 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:52:05 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Markus.Elfring@web.de"
	<Markus.Elfring@web.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>, =?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?=
	<Iverlin.Wang@mediatek.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Thread-Topic: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Thread-Index: AQHazrDFnjNwsUu8gUWrj4pzis0BS7HoXb2AgAPIgQA=
Date: Mon, 8 Jul 2024 02:52:05 +0000
Message-ID: <554f09bc6fc8f3b2a71b346f5e363950a1f8cb18.camel@mediatek.com>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
	 <8f3765db-842d-4568-9ac5-1bd9cab9e952@web.de>
In-Reply-To: <8f3765db-842d-4568-9ac5-1bd9cab9e952@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SEYPR03MB7214:EE_
x-ms-office365-filtering-correlation-id: b36c6bc5-6e7a-4495-f735-08dc9ef8f37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVZlV3ZhRjVOQWxzSUM5SHpUMTUweXQ5aDFWMjZObFZZVDhxcG1iSU02MjlS?=
 =?utf-8?B?VnhacCtqVHRyYWdTS2ZXMzVkR24zQmh0MHhkODUyN1Y2MHhSOWRWZmtwSEt0?=
 =?utf-8?B?YWdZT1RBUlIyL2JkREFjOXd0Mm5CbFdOVWdxK29YU2t6ZXJiWUhzT3RmQlRL?=
 =?utf-8?B?SnUyRWZQNDVrNHhFclJidXp6aThNeDBsYlhFc0ZJZmRmdUd2Z0JpRXl0eEJH?=
 =?utf-8?B?ZXdFTmV0MzFXNm9GV0xsUXYrZmlCdFZKWDFuYzJnVURHcjUwaFJqaUd6Y1pV?=
 =?utf-8?B?VHk2UzBUaDNOcFJHNERBNWVzT3REOWlQZldZVmNkdmNGUmFIR2Zsd21YYk1E?=
 =?utf-8?B?YmZ2NkVobzVvcmdWd09lU0Z0Wk5Gd2NtZDVxQ2sxbTZhWXBrMzFWcGxRMUUr?=
 =?utf-8?B?UGxNTkZkTWdkQUtNSkRLUzhlK0dwazRxUTJSeThpVU9ScEJ1QW1NL1lUVkdy?=
 =?utf-8?B?UVJZejltbTBaK2pkSTg5NGlHU09DSzdFN2ZHMnI3cmxONzVKVkNWZWpWL2hu?=
 =?utf-8?B?MU1wSzBJTEMzSzdlMTRKYUR5R0lnVzhOQ2xJODVOYlFVU2pNc1FObVA4QmN3?=
 =?utf-8?B?NE9xYmtGT05uRlhMSWY0bW5XZjRnZ3JYWWFubHd1d210eUlaZ3VybVhZYU5R?=
 =?utf-8?B?N2szSjJvWlY5eHI2WFNybTkvaE8xOVd6bTdSWHdvR1NEeWVlYndwL2FmRU9m?=
 =?utf-8?B?MjljUnd5WEwyU0JRcTlMT0VaSHVJTWloMXNNbHBhYWhsYURqTXFhT1RVOFlZ?=
 =?utf-8?B?VVlTZ1NCSngzZDBIcFR1SG1JQ2hBdFVrRmx4RDl5eWorUGsxVGtHWmU4OGQ0?=
 =?utf-8?B?cUdmZ1VaOWZaVG56Q0JrdFRyRVF6bDVmVnFEMmpuWlhxSitqMFNzNTQwK3NL?=
 =?utf-8?B?YjlVNmN1Z1VvNW1TSjhtc2UzeTk4bkJnMmFjQUE5Tm9zbFgxTHZ0dTdzeWtS?=
 =?utf-8?B?dnZETHNEcHhDOHVTUjB3M1FNSlZ4SURmKzVKdlZiR1RPNWpPcVFMSzNzUTJV?=
 =?utf-8?B?OHhZRU1jaDhWcVNsNVZUd0txMHZobExIYlAyYWJ5b3Ewd01BaEN6N1VRTC9H?=
 =?utf-8?B?N2VteEMrM0NVV05JRTF2eTlONWRUL0JmcGpNeTU1RXA1Y0RwMTZhQSs0N1F2?=
 =?utf-8?B?UlNyT1pzcDV6YmNBYUppUlgrbWJDVW9jc2NtaG44dG9IUzB5K0xRU01nTWda?=
 =?utf-8?B?UDNCd2FyN1d0T2lWZmZRVWJrWkdGWVd3RVgxTWIycnJmeC9GY3hhOHRtOW5x?=
 =?utf-8?B?eFhoY2RYR2tuVkRwWGVDZzB6ZmkvRjloVC9pYmhRMVpxTzlNWm5laGx2bUVS?=
 =?utf-8?B?RGU5ZWRzU3hEZmR3ZEpzT0tMMzdDbEZSMHAxdTNHRk1WVGtXUDdyVXJKWXNt?=
 =?utf-8?B?S1MwVWs3aG02NjB6bFV1bWQ2TnpsYnlML1hFc24zZ2xDMXJQaXZuTTJZa1VK?=
 =?utf-8?B?MTFBMFR4OG5MV0FobHl3YmZtN25EUGpVODQyTnlNWWs3cUlrTEg2UDRoUGdU?=
 =?utf-8?B?L1RuaXBUMmxoenNwbkhES3MvcjhNNU5HOERDSWhsRk5EUmoyVVFGSHB3YUNk?=
 =?utf-8?B?cEdtcmQzTzY1bGZxR0psRVVGUDZBQWI4ZXhsNFJTM241SHFtbmpZUGw2Tksw?=
 =?utf-8?B?dnk4bzhGbVRaM1U2bExsV045bU9XNFhCMldRQXp0Qzh2VUxFNFArOEpRV2Fz?=
 =?utf-8?B?KzVjM3gwbWsrOUd2MCs5N3MrU3ZHeGpSVmRWK3VkQjhoZElBa3dDNUFPRERW?=
 =?utf-8?B?VnI1VHZaV0NzY0RGWkx5UmFkbVRFa0RUWTYwTjJCL3dZbitMYU5zUmdhRjZY?=
 =?utf-8?B?eXg5S0NwSnJoMVAxMkQ3dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3ZteDk1VTVidnM0aXBhUmZNVytUWFQyemZYK2tSdjgvN1NiZFE1cXEyTm9D?=
 =?utf-8?B?MDFtL3JwU2ZZd0hUTmRyWkE0MWNva0ZHdUxvMUorRGtqUkJPODl0eWtTdjBT?=
 =?utf-8?B?NWYwNENvSERIYTl2UXZJUlVYWW93S0h0c2E4bGxvWXBEQ3hjKzFmQWcxYWpp?=
 =?utf-8?B?TGhpSkh2cU4yUWVoS0JkTGtwa3N5QUdUVGtzNG10QTlKdGFBRzBNZXliYjB4?=
 =?utf-8?B?SlRuS1h1SFZwdmI2cys4UzJ6Q2F2N3liL1E1cDlOcEhpeGFwNkVtcTUxNEs4?=
 =?utf-8?B?eGNFZHBFTnd4MVlJSnNTWElDM1ZNS1J5Z2JDRXpITko0SURZZ0pOV0t1am9n?=
 =?utf-8?B?S0NtY0VHR05WRGl3U0VNeFNFUHNyREZ1U0Z2NGRYaDFDVjh5eENrN0h5MVhp?=
 =?utf-8?B?V1ZLY0NKRHdXMHpXc0NQWjlTY296b3NYRmkrUE53alYvVk5keStjOEdkYlg3?=
 =?utf-8?B?T211YWpnOWpmNmNzREREckxBM1RmckRtTFBzMXV0U1JsWVlPOWNRcFM5a2cy?=
 =?utf-8?B?V2VWWEg1U1g5blpRQlZyZUVXeUhYcmc0emxTSGVTdFpweENrYitSLzR2ejBp?=
 =?utf-8?B?K0F6Z3NQMnVOYW81blZqM2plalJVS2dtZ1ZBR0l6NUdoNzdrNXl5SmN6b3hL?=
 =?utf-8?B?dGErTUhtdjlvcTFsMnRsMFNNVklTZ3VGdmIySGptY1ZrQ25jdEdwcWw5QkM2?=
 =?utf-8?B?cnBYUlU0N2I0d3BRTVgzVEN4cmMwVUcyVlFkaVd0dEt4MVU4S2V0b0tIWVJ0?=
 =?utf-8?B?LzkyR3ZySjRmSUlwRitEcnczN0d0QU50MU9EOVlhaXgyMnhsVHV6dmxpZGQv?=
 =?utf-8?B?ZjVON05rV3ZtdHlYVHZ4TTBMWjRTTS80TGVFKzVLS2VPaTQ1bUpIYjFPL2Er?=
 =?utf-8?B?UytiemxaY3VIN09RcFo5cjg0UC9TSXJwSkVQZXN2KzNvNlI4clRPUWtYU3c5?=
 =?utf-8?B?dDJGUVZwVk1UaWRVS2xSNVpXODhUeWEwNXJPajYrU0VhLzRNaERuV1I3R1c3?=
 =?utf-8?B?YVRpMUM1cGtWOGM2SWYxNmRFdzE1aEg5dkpmcjUwWGJPQ3RodFJ5ZE9ZdHBH?=
 =?utf-8?B?SmFsOHR0ZlFLQ0J6RTV6YUpUQzN3NzJONURDblhyTUQ2a1l1dEU3N0JOQmgv?=
 =?utf-8?B?bXJzNWZWQWZkc2NuVUJ4anRLQ3E2Sm1ZeDlvUmJBMENlakxFZHVEQ3BUYnJm?=
 =?utf-8?B?WVc4dXZvUkVNb3JTRGU1TjduSEtDOTdrWEJGdG1GUk9nZUV2UUp1VlhESXBH?=
 =?utf-8?B?Y212eW8wb25VZXJ3a2UyUFZpeE9qWFdKdVYveXJEOFY5aTdYM2VkbHZZYk52?=
 =?utf-8?B?UVFNcndBM1NIMkxSSnFMUGQrbHBhZEZZbTlBdGxVaGFsY3J5TURuZnhROHpl?=
 =?utf-8?B?eVlLWTF0bjgyUDdJTTh0SklEdDJjL2pWVStrc3JRSWJMVTZyRWRpVndBWDl0?=
 =?utf-8?B?OFN3Qk84cXZzdzl1aWx3d2trMzhLS0cvWnhJWUdPVGExTGpEZEFvOXR2SkFC?=
 =?utf-8?B?Z2I3Zkc0dVpESnh3bzEwWU1vNzhQYmh2Rm5kdmRNVkdFRnBoQWRBVEZtNnE4?=
 =?utf-8?B?VDgzS2V4bTlrdG0wWTFpWkZTQnJMWXEvQU4wWmIzQkp5Zml3TWtZNUJmRnlQ?=
 =?utf-8?B?ZitSb0pIaW9iKzFxa0szWXBVTE8zQlVQWTQ5L3l4eHg0QTBCQjhFaERhVE80?=
 =?utf-8?B?TFFqNk1aa1hjZmM4bnNUNjRJYm1zaGgxVTVLL2dxYzNnTDd2S3BKWGtlb215?=
 =?utf-8?B?YllQTTM1bEFwbHRRaUpZMlFuaUo2bENIeEs2anlvTW5YNjUzSlh6b2M4NHJh?=
 =?utf-8?B?OUZ0ejM1Mk9ZbXQxV2ZwQkY1dldRSllGcXEzMDhFY09pVUpJZWpIOGF1Y2x1?=
 =?utf-8?B?OUtqa0lYd1BMODBZWGpPeFhCTCtha3d5TUpKY0srY2k3eFd3dndRRUZoYXFk?=
 =?utf-8?B?VlluVFlsdWVldzkvaE9zNFVMb2xId0w5MktQUjYzdEJzbnpTWE9MK0ZRL0Vk?=
 =?utf-8?B?QjdiR29wT3IvTkdFTHdYazUyUkVjdEJGdlhmelY1b2o1ZXFUK2xBY0VrdDJh?=
 =?utf-8?B?K29scDdySmVDNkFNbm0wZTVsY3VUcmlqekFUalFmQmRINlBxTEQzMWJmQVZY?=
 =?utf-8?Q?vepPzvwZkwweQoopB+QT2EIuW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FBB167823E3E74C9A752981D11D5BD0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36c6bc5-6e7a-4495-f735-08dc9ef8f37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:52:05.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ac7Xn7/69iWLuTtAsiyIrCu80U5SC+qd1qvKySxxVIYf/CNNojQtHH6GjFDdmSJhl6jd75BmhCTzLyb2Bs569A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7214
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.067400-8.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tFp8tduyF+iBzHmTfB9+iM4fAYSb4KlgZHoC
	1i0Ap1tjKVEhq9V4azt5CEY/sdra3AD9XDrpPjx9IRA38P/dwbkGtrAxy5ENOXCmcAC8DBrNksV
	p7lQGRSwbaZTVGPRZaWBPI/LCRMYguFOuOD0D2lOKXavbHY/C1+LidURF+DB1eeFM23KSx/g2yB
	nqOBZsS2miuPjTJsRgLop34Gdsax6TBNmfHIEnzEPf7TDUOGop9LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.067400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1824CFF1799353C6B8973DF05D65C2206909DC8A1ACAB05D7F82A1EEF238C2402000:8

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDE5OjA1ICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICA+IEluIDMyYml0IFNNUCBzeXN0ZW1zLCBpZiB0aGUgc3lzdGVtIGlz
IHN0cmVzc2VkIG9uIHRoZSBzeXMgbm9kZQ0KPiA+IGJ5IHByb2Nlc3NlcywgaXQgbWF5IGNhdXNl
IGJsa2NnX2ZpbGxfcm9vdF9pb3N0YXRzIHRvIGhhdmUgYQ0KPiBjb25jdXJyZW50DQo+ID4gcHJv
YmxlbSBvbiB0aGUgc2VxbG9jayBpbiB1NjRfc3RhdHNfdXBkYXRlLCB3aGljaCB3aWxsIGNhdXNl
IGENCj4gZGVhZGxvY2sNCj4gPiBvbiB1NjRfc3RhdHNfZmV0Y2hfYmVnaW4gaW4gYmxrY2dfcHJp
bnRfb25lX3N0YXQuDQo+IA0KPiBXb3VsZCB5b3UgbGlrZSB0byBtYXJrIGFueSByZWZlcmVuY2Vz
IHRvIGZ1bmN0aW9ucyB3aXRoIHBhcmVudGhlc2VzPw0KPiANCldoZW4gZGVhZGxvY2sgaGFwcGVu
cywgdGhlcmUgYXJlIDMgQ1BVcyBpbg0KDQpkb19yYXdfc3Bpbl9sb2NrDQpibGtjZ19wcmludF9z
dGF0DQpzZXFfcmVhZF9pdGVyDQp2ZnNfcmVhZA0Ka3N5c19yZWFkDQoNCmFub3RoZXIgMSBDUFUg
aXMgaW4NCg0KdTY0X3N0YXRzX2ZldGNoX2JlZ2luDQpibGtjZ19wcmludF9vbmVfc3RhdA0KYmxr
Y2dfcHJpbnRfc3RhdA0Kc2VxX3JlYWRfaXRlcg0KdmZzX3JlYWQNCmtzeXNfcmVhZA0KDQo+IA0K
PiA+IFRvIHByZXZlbnQgdGhpcyBwcm9ibGVtLCBhZGQgc3Bpbl9sb2Nrcy4NCj4gDQo+IEFub3Ro
ZXIgd29yZGluZyBzdWdnZXN0aW9uOg0KPiAgIFRodXMgdXNlIGFuIGFkZGl0aW9uYWwgc3BpbiBs
b2NrLg0KPiANCj4gDQo+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gdXNlIGEgc3VtbWFyeSBw
aHJhc2UgbGlrZSDigJxBZGQgYSBzcGluIGxvY2sNCj4gZm9yIHN0YXRzIHVwZGF0ZQ0KPiBpbiBi
bGtjZ19maWxsX3Jvb3RfaW9zdGF0cygp4oCdPw0KPiANCj4gDQpJIGNhbiByZWZpbmUgY29tbWl0
IG1lc3NhZ2UgYXMNCg0KYmxrLWNncm91cDogQWRkIGEgc3BpbiBsb2NrIGZvciBzdGF0cyB1cGRh
dGUNCg0KSW4gMzJiaXQgU01QIHN5c3RlbXMsIGlmIG11bHRpcGxlIENQVXMgY2FsbCBibGtjZ19w
cmludF9zdGF0LCBpdCBtYXkNCmNhdXNlIGJsa2NnX2ZpbGxfcm9vdF9pb3N0YXRzIHRvIGhhdmUg
YSBjb25jdXJyZW50IHByb2JsZW0gb24gdGhlDQpzZXFsb2NrIGluIHU2NF9zdGF0c191cGRhdGUs
IHdoaWNoIHdpbGwgY2F1c2UgYSBkZWFkbG9jaw0Kb24gdTY0X3N0YXRzX2ZldGNoX2JlZ2luIGlu
IGJsa2NnX3ByaW50X29uZV9zdGF0Lg0KDQpUaHVzIHVzZSBhbiBhZGRpdGlvbmFsIHNwaW4gbG9j
ay4NCj4g4oCmDQo+ID4gKysrIGIvYmxvY2svYmxrLWNncm91cC5jDQo+ID4gQEAgLTExMzQsOSAr
MTEzNCwxNSBAQCBzdGF0aWMgdm9pZCBibGtjZ19maWxsX3Jvb3RfaW9zdGF0cyh2b2lkKQ0KPiA+
ICBjcHVfZGtzdGF0cy0+c2VjdG9yc1tTVEFUX0RJU0NBUkRdIDw8IDk7DQo+ID4gIH0NCj4gPg0K
PiA+ICsjaWYgQklUU19QRVJfTE9ORyA9PSAzMg0KPiA+ICtzcGluX2xvY2tfaXJxKCZibGtnLT5x
LT5xdWV1ZV9sb2NrKTsNCj4gPiArI2VuZGlmDQo+ID4gIGZsYWdzID0gdTY0X3N0YXRzX3VwZGF0
ZV9iZWdpbl9pcnFzYXZlKCZibGtnLT5pb3N0YXQuc3luYyk7DQo+ID4gIGJsa2dfaW9zdGF0X3Nl
dCgmYmxrZy0+aW9zdGF0LmN1ciwgJnRtcCk7DQo+ID4gIHU2NF9zdGF0c191cGRhdGVfZW5kX2ly
cXJlc3RvcmUoJmJsa2ctPmlvc3RhdC5zeW5jLCBmbGFncyk7DQo+ID4gKyNpZiBCSVRTX1BFUl9M
T05HID09IDMyDQo+ID4gK3NwaW5fdW5sb2NrX2lycSgmYmxrZy0+cS0+cXVldWVfbG9jayk7DQo+
ID4gKyNlbmRpZg0KPiDigKYNCj4gDQo+IFVuZGVyIHdoaWNoIGNpcmN1bXN0YW5jZXMgd291bGQg
eW91IGJlY29tZSBpbnRlcmVzdGVkIHRvIGFwcGx5IGENCj4gc3RhdGVtZW50DQo+IGxpa2Ug4oCc
Z3VhcmQoc3BpbmxvY2tfaXJxKSgmYmxrZy0+cS0+cXVldWVfbG9jayk74oCdPw0KPiANCmh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEwLXJjNi9zb3VyY2UvaW5jbHVkZS9saW51
eC9zcGlubG9jay5oI0w1NjcNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQpUaGUgc3BpbiBs
b2NrIHVzYWdlIGlzIHJlZmVyZW5jZSBmcm9tIGJsa2NnX3ByaW50X3N0YXQgKHY2LjEuMjUpLg0K
DQpJIGNhbiB0cnkgDQpndWFyZChzcGlubG9ja19pcnEpKCZibGtnLT5xLT5xdWV1ZV9sb2NrKTsN
Cmluc3RlYWQuDQoNCi0tDQpib3kud3UNCg0K

