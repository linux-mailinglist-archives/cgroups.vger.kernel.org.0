Return-Path: <cgroups+bounces-3781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C6D937216
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF131C20E8E
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425A1877;
	Fri, 19 Jul 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NzmG3Pof";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="irWcDuW+"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822624C69;
	Fri, 19 Jul 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721353668; cv=fail; b=tySTPdKChy9t8M/lvME/zAce+bUSSf/GuAV6ONHe1YAX8uC8SDeCyaHg3GQJ2AjrfBon3ECnZLw5x2+LJraaA4srLzjIb88Dup3nIrztaT5ROOjiACNV7PXNldTR+DnCLXbkLsPE81y2zjsqhILgpD1Ey2twPC1MNtlLDtNTCmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721353668; c=relaxed/simple;
	bh=eRq3T3HDeKmXOErFS8YYLbmPGzlrBxbtUg4lA724550=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tIU8kP8bzxWsT6bg02kzrKRrLTYaCQ9CWjR5R0tVcUvQ6NQKzqw6kJpuvvxODMDMR+mbSqi1nvkoM7v8ua0+JMnDKUMenw6fj5CcO09dptBZega/7/zI6tmWpZ/YL7FaoBVtE8BT4Ynf9ZuhMPYt6mhgp7ScaTtxU/41UuZEpvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NzmG3Pof; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=irWcDuW+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e18dd906457011efb5b96b43b535fdb4-20240719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eRq3T3HDeKmXOErFS8YYLbmPGzlrBxbtUg4lA724550=;
	b=NzmG3PofHlMqJdGyhEl/5aC2u5551NSMk7ntYDRv3yCbq29iELOtUW1HKndcQ4DkVAIzbpuXDj9iw5VnG1z7QVgzFXrwwogSSQ9NrFXiBVhzclSG9CezoKlsuIGE13uWym+yUOqewvN3BeOekke+T3lJsvMQxaIfz/8OyoCeyso=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d6e3b445-77eb-4284-a105-7884cf862816,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:aede84d5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e18dd906457011efb5b96b43b535fdb4-20240719
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1343349083; Fri, 19 Jul 2024 09:47:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jul 2024 09:47:38 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jul 2024 09:47:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNAQeZlUVBrX5M5SHKeyfIP5avVYRwl8grWs1VLg9NfnNwK2S2qfUzeLAM139S2Fx+wms2Iyk2qaq3F9Canx2nGuuslmfC9nYiCfLid76LHoCVxCtCzhONPw6OQLX0C4dSTJjZlbCe9eawEfzpasPhM6k5hQU3Lj4QkzbUteuB7PTH+Buky7JK+9QgSgILTXcd0DDbqgq2Xin6vWmxFXAChRAR3Ol2Ar4jcFjR5ylApS5h3zUBfN4ousWLvxqvarAPjwRjgQXbc5FmyzewX2IKYgnlxD9z8zaj2jJQXwNE3XZeCphYAN1o/U2iNsSiMEu5nsAk1g1fY0bShvtyfZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRq3T3HDeKmXOErFS8YYLbmPGzlrBxbtUg4lA724550=;
 b=rUcG2irZNgEADaLIQVGMv0puXsfMccJimlSlg8VBFhKXP4xuN0EjD9F8k5ueFCUpO7K4we6ob9ElM9xPoP8mP/GJe4Cb8wN1Hi1MV+cuP1e5iZP1BevUH2Ieln/9MQTK3YOTuqZHh8YAEDM2PUeH8obi0p2YrXPhxh2xRpqYL6VklSXsUWbWNxnG+lRjLlEqWsL+jPh2uOUR5UKB9QvfA3swMwEadC7TpQOopIFKBcRDMCvc0kRJ1ovyPFSgK9sUh7VYBdOrXtGmR9sOm1MMxM3tkzHdPlbzC2zBC98jVJAexpIQkJs/NCfcN4ekHWB+vqbEpHfiTiKkWgBRb826EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRq3T3HDeKmXOErFS8YYLbmPGzlrBxbtUg4lA724550=;
 b=irWcDuW+SsOt4cgHwP3sv1tLizOTvJua/UL7irOG/qdBy+J828VQSCUFWtTepM3uMslivqItoYoXoFozOpTMsea/w8CpO1nFpjN+NU9YPBQfD+WpAMV1J9v9UU5on5ZcPJmFvZNX9tLUOil0iLOjw5JdFUCUI7/Yvo56gvK+bfY=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by TYSPR03MB7428.apcprd03.prod.outlook.com (2603:1096:400:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 01:47:35 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 01:47:35 +0000
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
Subject: Re: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Thread-Topic: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Thread-Index: AQHa2O5aruOvW4TdxkyHU/91XL9eyrH8/V0AgABMBgA=
Date: Fri, 19 Jul 2024 01:47:35 +0000
Message-ID: <00c595a16b4e96ae56973ac2ce586f6ad736059f.camel@mediatek.com>
References: <20240718084112.12202-1-boy.wu@mediatek.com>
	 <ZpmF8HJsuefjC7Xr@slm.duckdns.org>
In-Reply-To: <ZpmF8HJsuefjC7Xr@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|TYSPR03MB7428:EE_
x-ms-office365-filtering-correlation-id: 6ae92243-26a9-4822-99f8-08dca794c379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NDk4MCtUNHdHRW9NWlBGRlhuTTduK2V5eUtueXlWNHdzU09OeUdoc1BuL2F3?=
 =?utf-8?B?Zkk1aHZZb1B6TG1Pdzlza1lETGI3NlJkbkh1NHlmRm9yNERzSXNkZmJtM1V2?=
 =?utf-8?B?d0FEc3hmdWsrOVZhTXVYRWwwMkxzbmpDWWZlWCtwUFZYbjY5c1JPUk1BdEFk?=
 =?utf-8?B?bFYzSXBOSUNnQmJJdDRneFN4dkxhVndnV2FLK0cxMlBtREZRNllZMFBydm84?=
 =?utf-8?B?dkltbG90U1paUmVvQ2ErTVhVVFVlRWVoZUlSWWNDMjNGM2FvRjhxSnhFRDdX?=
 =?utf-8?B?ZTZ5MVdFMzJQL2xSdzlQQkpSUUphejBOYnlTN25WRCt1RmJObk9VSVFBd2RG?=
 =?utf-8?B?NEo0SUhNQ0VoLzJsOGVCVGVsUUo5VkJSSGZEaUIrUUFGcHVIOVRjZFc1Y3FW?=
 =?utf-8?B?dFJCRVdwalVQZTh2Yy85MHJVMnk1V2JDZXdEcVBwN2VwelFzbnlCeGNMekhQ?=
 =?utf-8?B?Vi9McWZLbG02K1UxZllIZ2ZoYWUzNjlnNHFmWnVFZHZKRlN4UU5UL3FJa1c0?=
 =?utf-8?B?V1AwR1ZONStJNUZwQ0NqTWtQcEJMcDRvekpCcUtaZUpFM1hFMG1IaGE5WGVl?=
 =?utf-8?B?NDFUdjZNRDRwdTR2L0NwYjJsbHV2U21jbU9tNEFtN0gyaTg1RlA5Tnp1OWZM?=
 =?utf-8?B?YUdqZEJRUnBrS2dqT2ZoVEFlTmJLWWdBOG1yMVlBMlRaa1g5a1RJa1lzRVNw?=
 =?utf-8?B?YkpVZE5BTE00NVQrNzB3S1lSdUE5NUVHdkxhU3BtRjFIZS9RNnVjOHhWaUJE?=
 =?utf-8?B?NjZ5VmhERUVqNDZmK2Q1SVFuSWJlWE1qYjhGTHNscm9rSU1HSXh1ckdpUkNK?=
 =?utf-8?B?YVI2OEVsUktlUGZsdUpkdkIzMEhZWlpWQkNTcGZaVGl6c1d5WG5yMERKckNI?=
 =?utf-8?B?OVRGcFNrQ0xuQzFxTExzUjdBKzdmUXdKdzlGVW15eVFCRm5VVjRHTStqblJK?=
 =?utf-8?B?aVNNcllVSklkR0NSUzVESktnTFZUbHB5Ri9HU1dWd2x5MTVmenRnTUFkb284?=
 =?utf-8?B?M3Jma0FwWlUxQ3o1SVZmZHJIM2RQM2J3N1drdWgxL0Q1R1NoVTA2OW9SQ1Ir?=
 =?utf-8?B?VFpMNml6TERUamtlbUZJY3l1d3gxNmczMEt2NDlVWWNONEozZDF2cG5IVjBO?=
 =?utf-8?B?TmRRdWQxZ1JpZFVyZm44M3JVWkNDemczWnFHUGxQSzZmWVV4M0JGeWUxc0hY?=
 =?utf-8?B?akZFMllndkI5TE8wREhTQ3lVTzgvNW5lWjFDOFh1c1AvWEpDclNaMDNWSHFZ?=
 =?utf-8?B?MllJdkQrcHROT3RYek4xKy9mc2ROWW80YkR0eFFFdTIxSjVZTnRyMkc4ZFNa?=
 =?utf-8?B?SU1PdEFNSWE1NFdhVGJWQmNYZUZJUHFEdFZRa3cwVm4zYjErb25lQWxSYmJF?=
 =?utf-8?B?WVNwTldVOW80NlMzQ0ttOTYzYlN3SytXRmcvME9FNjFJUHlZNmNPQmJ6K0Nn?=
 =?utf-8?B?NDJVcXNUNVMxanIzNzFRMXlXWmtpeUpsTXFGTVlodFlJRXByWVNOOE50WExF?=
 =?utf-8?B?SnMxN3k3b2lxZVFSL0RxSmNaYkJKMy85WXUrNzUzUHR6anRIWDlXbm9rS3Rj?=
 =?utf-8?B?eW5USHlGT2xZMVF3bHp0ZldlWGFxNmJ6R2c1NmwvWlFvdHIxcWdNMXJPQWFk?=
 =?utf-8?B?Tmw3QWdLUFRyaHBFUHFIaTFEbm9XVU5KMUx1ZW52NytyWjhPTi9RWDRjTWxW?=
 =?utf-8?B?L0RNaS91Q0JqRUFoS3lJQmVrZGdKVnlzUHp1bmNaNnB5N1pVa3hwYXBkOUJu?=
 =?utf-8?B?SEhFL1lwQmpieklaazNCUWEzM00vMUVIQ3pyUVJpNHdaMDNwVnNjemRIOXhH?=
 =?utf-8?B?aHppR0ZuN3ZSNlJoUUkrczVGNFVITFBiTWQweFhlNDVTdko2MkhCSzFLTDFn?=
 =?utf-8?B?eGxidjJtL2ppWHEwdkFDcjlGZkNQdExGNThYbXNLOG1HTVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elpLRXpMWnVuZDczaTRUK283TldYb2VtQlJHdmQ0T1YvbnI3TkFpeThDQnQv?=
 =?utf-8?B?a2tUQ2ZmTHRoNmQ0QVhNbkpLYjZGMWdFcUc0Y2FjZEVIS2RrR3ZCWTByVFJq?=
 =?utf-8?B?SjBaMHRxNnBuWjhoNjFTbXc2b2Evb0pKL0YxRWZPbGpFejNldlpka0NiTVpM?=
 =?utf-8?B?OXFyeHhIZUIrV1AzUEFvakZ6MnFJQ3VKcVBlNVYxb3B2OEJJd0VPZUlEQ2gz?=
 =?utf-8?B?M1RUOGNhOHY3RndvelJQQnMzNlVTcUJJc2pDcUhldnlyQnNnUXA2N3E4Wks0?=
 =?utf-8?B?bmNlZ09zZkNLZ0loVmRXWEhTVlZXTVVSdCs4WmFmMVRnclhhdlBVRm5PV01U?=
 =?utf-8?B?R1NWekJIT2lYR0wrNU5NSFgwMDJpajB3NFJCenFRamtueTdYR0FGSU9rMms2?=
 =?utf-8?B?S0FVTkcwd05tSVY3a1NOaFNJVGR4ZnNBa2hpVTVhdGl4WC9GMFkraFFMSXF2?=
 =?utf-8?B?endVNnRlZjRnZWxFVVRiSGplQk9TbWVrMWttcktkeWQ0SVJTTzk5TWRUWHll?=
 =?utf-8?B?eDRGMzNEa2VPL1cyazBEc2lKcGIrZzF6ZURoZlFsWjB3ODU5SUV4SmVDalZG?=
 =?utf-8?B?UGtpM2E0bGRFOFhNNkx6ZGtxSHdvdmFSUmc0SFVqM0NnRVgzdm1MZ0FidVJQ?=
 =?utf-8?B?WHhJdjFzVFJaRzRuZG54YUZ1SC9aQlZ6YTVPVnFGY3NPU2J2bUtxYzhRc0RC?=
 =?utf-8?B?SjBuR1hNZllrbWgyQUZXc0tlV296T2RsdytrSUNyL21iREhnN0VnK3BKcm9E?=
 =?utf-8?B?OGI0MXdSL1Y1QjVBNjdQdjlrUnJxb3YvNWNkRmwrRXVGUGpndktUWnZBN0tV?=
 =?utf-8?B?UjVsMDJ6NDZjamw0SHRtbFh1ZWVSRmw5UUJMaFk5enhCM1UxQmRGL2poWWNH?=
 =?utf-8?B?WTF0cUtZZ0lJKzRpS2l1cTNkSGluSFZHUDF6MnZSRENQMUd5MkRaMTE5QTQ1?=
 =?utf-8?B?RkV4NmxKZVo1Umw2L0Juek13djFRa2pqRTk3dU9mVFlZRUZ5eDdzTjVDN1pz?=
 =?utf-8?B?bWYzb0ErT0xqN3ZFTDBXeGhYckJPMWFIRFJRUW9OZVNDcjNSZkZueHF1cU5Q?=
 =?utf-8?B?QURxMTBwd01QdVcveUdUeGM2ODNMUDAwVDhZUVM3NTBmTDdVUGFVTXM5c0VM?=
 =?utf-8?B?RVpGWTJYVVZSNmJzczNNZklCZ2gybzZFSXYvaWFLWGVVU2FoT3d2REUzeE5i?=
 =?utf-8?B?TzgxMXM4cnREM0dDdmJKVERMTXg2WGlrZjhLWFpyTEtabDlkMVA1bWx3NVpF?=
 =?utf-8?B?OExYbWY2aDlYOGJvaG1sTGJrQkdjL29UUllmQ241NTFROEQzc2dOQ1pEWjhu?=
 =?utf-8?B?OXJIRFpwYkl3dUhPTkU3blNzeVkzdmJiWk1xWXM3QmpPS1pER0pCNzkzem1t?=
 =?utf-8?B?RHJqaWxIckNjOWFMNzVRbW9XVkI1KzlGbTdzbGlOUEpYQTdYVmNXNFIzeE9N?=
 =?utf-8?B?dGFOcTlSNUphRDJrbHhvQTlCZDBzSHVZU3dUK2Y0aVM2WXBTbTQ5TmlSNWJr?=
 =?utf-8?B?UG9KY1pwbmxyaTk1SmZCT1BNVXJ3ZERSV3FMSTV6M1RxamJHVTQydlVPMDRR?=
 =?utf-8?B?UFhubi8wMnNCeVhDOW1YTzBxMkZMbFQ5OGQ4b3U5YWRhdmZwNDJUTW1QL1By?=
 =?utf-8?B?dzRSekE1MUdmUE5OWmVmSnhVRnRkVHdMNFlMYUhyZGNJamg2eS9MSE1JN0RD?=
 =?utf-8?B?Wjk2WGtPQ1lUNDRKcGw5b0NpbENGYTJqNWZOS2R6K2M3ZFJ3VlMxZUFoQVZ4?=
 =?utf-8?B?ZW5NUWVQbmtYVm9LcDdmZWVSSkJKRU5BTW1jMVVzMWZvOHZDQXVNQXcxLytK?=
 =?utf-8?B?cW95UGxoUlhiVlRJVXQ2RWFSaUtHZTluS0dTSFo2VUlyRFNLcHBMclJ4V0tM?=
 =?utf-8?B?bEFxYVM0czg1aTJwM3orZWhyYXlBQ05ETkxwUitnUGJMOXlNb1NtMVF6VnFF?=
 =?utf-8?B?Zi9HNGpxRmZSTmZ5T0JXa0VacFFqMkgyU2pCNlNVaFp5Mlp4NHBETmVpelps?=
 =?utf-8?B?MWp1Rmx6RkUxWC9DeGMwbnlORFVJMTM3QS9saDRnMmtyN1Z1Y0VJNStBTDBh?=
 =?utf-8?B?OXJ6NnpZSDZ6NEpMWEM5amVvY0NzR2R2NnJWaE5BRlptWTV1YzkzS1hwQUJv?=
 =?utf-8?Q?Gpgrays+pzUBhmmVLHQe1Zdpv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F188A3908130FE41A2D8C8829C91AD1C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae92243-26a9-4822-99f8-08dca794c379
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 01:47:35.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmP2yn7VxskDPaIVCLbBqBLCljadA/AXjALBmTbHa4t3KitxXxIpr1FApbk93E/n8lok2YtmBTs8VG+PXobQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7428

T24gVGh1LCAyMDI0LTA3LTE4IGF0IDExOjE1IC0xMDAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgSGVsbG8sDQo+IA0KPiBPbiBUaHUsIEp1bCAxOCwgMjAyNCBhdCAwNDo0MTox
MlBNICswODAwLCBib3kud3Ugd3JvdGU6DQo+ID4gIHN0YXRpYyB2b2lkIGJsa2dfY2xlYXJfc3Rh
dChzdHJ1Y3QgYmxrY2dfZ3EgKmJsa2cpDQo+ID4gIHsNCj4gPiAgaW50IGNwdTsNCj4gPiAgDQo+
ID4gKyNpZiBCSVRTX1BFUl9MT05HID09IDMyDQo+ID4gK2d1YXJkKHJhd19zcGlubG9ja19pcnFz
YXZlKSgmYmxrZ19zdGF0X2xvY2spOw0KPiA+ICsjZW5kaWYNCj4gDQo+IENhbiB5b3UgcGxlYXNl
IGNvbGxlY3QgdGhlIGlmZGVmcyBpbnRvIGEgc2luZ2xlIHBsYWNlPyBJZiBndWFyZCBjYW4NCj4g
YmUgdXNlZA0KPiBmb3IgdGhhdCwgdGhhdCdzIGdyZWF0LiBJZiBub3QsIGp1c3Qgc3Bpbl9sb2Nr
L3VubG9jayB3cmFwcGVycyBhcmUNCj4gZmluZSB0b28sDQo+IGJ1dCBwbGVhc2UgY29sbGVjdCB0
aGVtIGludG8gYSBzaW5nbGUgcGxhY2UgYW5kIGFkZCBhIGNvbW1lbnQNCj4gZXhwbGFpbmluZyB3
aHkNCj4gdGhpcyBpcyBuZWNlc3NhcnkgYW5kIHdoeSB1NjRfc3luYyBpc24ndCBiZWluZyB1c2Vk
Lg0KPiANCklmIGl0IGlzIGZvciByZWFkYWJpbGl0eSwgSSB0aGluayBrZWVwaW5nIHVzaW5nIHU2
NCBzeW5jIGluc3RlYWQgb2YNCnJlcGxhY2luZyBpdCB3aXRoIHNwaW5sb2NrIGlzIGJldHRlciwg
YmVjYXVzZSB3aGF0IHU2NCBzeW5jIHByb3RlY3RzIGlzDQo2NC1iaXQgZGF0YSBmb3IgMzItYml0
IHN5c3RlbXMsIHdoaWxlIHNwaW5sb2NrIGNhbiBiZSB1c2VkIGZvciBtYW55DQpvdGhlciByZWFz
b25zLiBUaGUgcm9vdCBjYXVzZSBvZiB0aGlzIGlzc3VlIGlzIGp1c3QgdGhlIGluY29ycmVjdCB1
c2UNCm9mIHU2NCBzeW5jLiBBZGRpbmcgYmFjayB0aGUgbWlzc2luZyBzcGlubG9jayBmb3IgdGhl
IGNvcnJlY3QgdXNhZ2Ugb2YNCnU2NCBzeW5jIGlzIHNpbXBsZXIuIElzIHRoZXJlIGFueSBiZW5l
Zml0IHRvIHJlcGxhY2luZyB1NjQgc3luYyB3aXRoDQpzcGlubG9jaz8NCg0KPiBBbHNvLCBmb3Ig
YmxrZ19jbGVhcl9zdGF0KCksIHdlJ3JlIHJ1bm5pbmcgYSBzbGlnaHQgY2hhbmNlIG9mDQo+IGNs
ZWFyaW5nIG9mDQo+IGlvc3RhdF9jcHUgcmFjaW5nIGFnYWluc3Qgc3RhdGUgdXBkYXRlcyBmcm9t
IHRoZSBob3QgcGF0aC4gR2l2ZW4gdGhlDQo+IGNpcmN1bXN0YW5jZXMgLSBzdGF0IHJlc2V0IGlz
IGFuIGNncm91cDEtb25seSBmZWF0dXJlIHdoaWNoIGlzbid0DQo+IHVzZWQNCj4gd2lkZWx5IGFu
ZCBhIHByb2JsZW1hdGljIGludGVyZmFjZSB0byBiZWdpbiB3aXRoLCBJIGJlbGlldmUgdGhpcyBp
cyBhDQo+IHZhbGlkDQo+IGNob2ljZSBidXQgaXQgbmVlZHMgdG8gYmUgbm90ZWQuDQoNCkkgZG9u
J3QgZ2V0IHRoaXMgcGFydCwgYnV0IGlmIHRoaXMgaXMgYW5vdGhlciBpc3N1ZSwgbWF5YmUgYW5v
dGhlcg0KcGF0Y2ggd291bGQgYmUgYmV0dGVyPw0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtLSAN
Cj4gdGVqdW4NCg0KLS0NCmJveS53dQ0K

