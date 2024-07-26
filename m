Return-Path: <cgroups+bounces-3905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E493CD0E
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 05:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4611EB2101F
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFB23774;
	Fri, 26 Jul 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M6ruoQrR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LvGusJvq"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C362B9AD;
	Fri, 26 Jul 2024 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965418; cv=fail; b=Z0f7NjeiJW5QZzy0QuiRscLQTnKOhDy8wceICVGaxtTrRhAKHkJevcmI9soRKRSF1w5OcLOx3tpP1vnpX+O1gIY8qAuFQSl/3l6ao1J8pcSBUgbHaOmHvy7jqvFxXvCWjZpE/viZhRBG3eFQhs/s9Rxt/ASE8A77uHc2mtFunS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965418; c=relaxed/simple;
	bh=Tcy6pvDhK0Q0/nxAkaXNJ1G5LUw49abxIaaK34Q4llU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZI55lEB5TmXDK9xPT3KbIlVZjIap09xvd/5G72HfxmUv2c0sBS2GkXuKOiC1eO9+gATcZTAxY5P9svYGHCDm1BQJHGCTTJKwky1Sow9oH0fKGiG0xn3TemjCtf1gC2fTi+eIQq3s/9wT0PtuUPcz+IWdGqH5I1Pk/RH03p1Ty3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M6ruoQrR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LvGusJvq; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3a04c69a4b0111efb5b96b43b535fdb4-20240726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Tcy6pvDhK0Q0/nxAkaXNJ1G5LUw49abxIaaK34Q4llU=;
	b=M6ruoQrRaHCp9095bUO9tbjhaUne8C/XMcDgvIe8z0AzkDAvZCYr02NcDJHtSi8bH+vEoizF2WuDWjdT4KMyeN8hiIvbkfUdAbSDp6sqSHQQy34wMAVH7d7zXZZmbgFKhU0un+aAo8zcbH3eqSXhDNzwxCDMR1Faepqxg8tYKLI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:9f8e0d2c-d7dc-42e8-bd0f-a4c65f51e34a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:cee0e9d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3a04c69a4b0111efb5b96b43b535fdb4-20240726
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 141956581; Fri, 26 Jul 2024 11:43:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jul 2024 11:43:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jul 2024 11:43:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP1L8+bgN3vutunsErw6mFHijt7lr2c/UBE8Li/kJz92ZvQUWWB3ocEv/v0bRT1HNPibrqzbTc5D+IwZL1/z79h4s+xMq31PJJWBa96htJcnBi/Yj56Tt9ZELhdfZCtPsoa8c28jeLqyLkdDV0NhmcZ9MGM16nKrp0qq3MgjyiJ68cNyVm96gIohVEmFTwi6SYp1J0oZlIO8xbaMhmeoMHR27wpQ6PCzxniMhFnslGB7Q8OMDCRPu08HFLrO3hmzpKagKHaxRmf5sVE62BRxixV4O2CzAv3Tac28l2/b4v0Ee9oAT52iHzkBGeH3g1rbPlQ8VbIm7SPHQ9kZfIFv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tcy6pvDhK0Q0/nxAkaXNJ1G5LUw49abxIaaK34Q4llU=;
 b=vhGC+TpgqRloGIb3jnwy2xFHOlVVT5v6xHb38BBrO1Ue8XikzOXZbSUke+3SEn7+IHFDNZRiQwmr+emc3Pm88jQ6Yc4pYTbQ8LMs4sxtz4P28iML5nzaJibITVJwnTx1g4Pt2cf63Jf4Xwc4/+kTOjsZgy5Omi8CFQgq0p964JVJvgeLZmn2LwUm9MNUCEEtXczuch9Wp7a5YNJL1sf44H+U4LaYRdpaeYGA931SCsANNMHyLefTuwjTdF7m2Gx230aEMyGJZZO+xlkJXUTNJ2CF+wN31yzKG7CHHWLIaYOapb1B9DIPVkaTMGcrE2TTUIJNzw9zGjkK8HS9Mc3XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tcy6pvDhK0Q0/nxAkaXNJ1G5LUw49abxIaaK34Q4llU=;
 b=LvGusJvqMQp9GzWSAF+t8aBHdHVa/HxS4UhEYBIV1qY9cxZNs/ClDxYo8FsYG38xPphZGPjcBbjd44/2WrqNl97an/A6pBOyJoa6xNw90fHqVeO1DJmGxTHXqaidrsDj3/6YD7Avoo+u3p6RlJNQL6kniMyA5AUiNEj6VJxLEf4=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SEZPR03MB7900.apcprd03.prod.outlook.com (2603:1096:101:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 03:43:28 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 03:43:27 +0000
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
Subject: Re: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Thread-Topic: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Thread-Index: AQHa2O5aruOvW4TdxkyHU/91XL9eyrH8/V0AgABMBgCAAQfXgIAKGNoA
Date: Fri, 26 Jul 2024 03:43:27 +0000
Message-ID: <e944e61fb64e5094aa6a0afef652359734619ba5.camel@mediatek.com>
References: <20240718084112.12202-1-boy.wu@mediatek.com>
	 <ZpmF8HJsuefjC7Xr@slm.duckdns.org>
	 <00c595a16b4e96ae56973ac2ce586f6ad736059f.camel@mediatek.com>
	 <ZpqjCVxSAV-Q7Yhy@slm.duckdns.org>
In-Reply-To: <ZpqjCVxSAV-Q7Yhy@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SEZPR03MB7900:EE_
x-ms-office365-filtering-correlation-id: 867c0cd5-c202-48a0-424e-08dcad251c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEJJZ08vbllCbHZneW15SFgwUnFOL1FxWW4ralRoTUdURmQ2NFdGNUdvY05E?=
 =?utf-8?B?TnUySFVIcG1IRTVJSXVjY2hVMTNmUTdaZHU5MHM3aVBmczIvR3VaeGRubGVM?=
 =?utf-8?B?TFJZNDJLNjk1amxTMy9yaGhMdGJkRUZDYXBWVG84R2ZJcldnMjZDMXNxdmFO?=
 =?utf-8?B?aklzYVFUL3lDbG1sUHpQTlFENFA4STV6eXhrbFd1TDZFMzIzaEwvNHVEci9X?=
 =?utf-8?B?SVZERE8vcWl4TktMOGZGd3ZyU1JHV1VUY1lZNDFTN3BNVVV2Q0lnNUx5QkY1?=
 =?utf-8?B?RUpoWkVXZGwwdkZ0eGd0R2Zzd05ENXdjR2gwWkFJcVlwUlZqb2c1M1phRUty?=
 =?utf-8?B?YkhTNEhhaDNsQ2I5NXdiOXk5SFcwb2oxbWl5OWNudUhMcjZucThnb3dIM2Fu?=
 =?utf-8?B?ZHpzZXJxUmoyTm5GdW1Vb2xXQVRoL25xS0xRYStxQkR1ek5lNG84QzhtbnpQ?=
 =?utf-8?B?cDBESHBRb2QyOGFiRWhzT1VXcCs5a204eFBrRUQzbUlFUXZuSkI4MlJjT0Fy?=
 =?utf-8?B?WW1EdlU5WkJJYll6N1RPTSthSmpXenpZUENVRHhtNVBHUG9Uc1RDL2drYkli?=
 =?utf-8?B?TUFXeXhGeXRYUHhKS1ptSG9HMFp6aFRTTkh4ZnNHamRXTmI5SHl1WjE0Rm52?=
 =?utf-8?B?RlJMWXRVOGw0SDF4KzhGd1ZaRjJkVlY3eGRadUMxV2thZkJHZFUvWjl4QVhq?=
 =?utf-8?B?U2E4dld4NFBBQmk4NWFUM0hRa0hNRkpUbGtMUXViTWl3K1Vwa3ExaWtNU0k1?=
 =?utf-8?B?cEFObzl2ZzBZbU85NEM3TTRsbjdYTTR6bXkvRUtDbFRzWjVRd0xQdzZuUW5i?=
 =?utf-8?B?RzQxZWRzRFVod0l2M1UzeG54UGtLZkUrVG9xdURaTHhDM1RwcFF4VGF6ZWFW?=
 =?utf-8?B?QWlsRjhNc0ErcVB3OG9ZUUxHcHUvT1FQQVF6TnA5c0lCYk9naXVrRUJUZXVZ?=
 =?utf-8?B?QkNqb2E1Z1hKWHZ4RHJkUk44N0U5V0NzY3c2Q2lkRU5oRXVpMUtobDJiWWg4?=
 =?utf-8?B?L29QcHBmem1lNllpUVRRSy9YbWJENFlwQ3NDMk0xWnhYUURyTk8wdWtLaHVn?=
 =?utf-8?B?bVR6QjRsVWY0dkZ6dTRLd04yRVViL2lER3J1NUphcmlEbmppb25LUUtHQkND?=
 =?utf-8?B?Y1Zmdms1MnhySTllMkFHSVg0eVhTNnE4T2piYzNUYWE1ajY3WklZVTFyaFlE?=
 =?utf-8?B?K2NHMUltNXV2RUx2NmRYK3laQjJUK0ZxaHJhb05lSU9MWUZkS216aUlFNlYv?=
 =?utf-8?B?U2lhdUFrMTdFUWJDck1UbE1ydFZrWlZ5NWRtZ3h6dFdSQlhMUk5lSy92cExr?=
 =?utf-8?B?a2hGYmxHVUtNSDZxMy9UZUVHRnZKK0FBeE96aGtIeXY1YUtXRkp5M2hwbGQx?=
 =?utf-8?B?UW1nWWt4VEx2TnoxMUF6QUtNK1JHWHpNdTYybS8wZlBKM1NlZzJnRG5oTGJF?=
 =?utf-8?B?QWtBd0hFQ2tWQ3BYa1pDSVd2eDJ5cERwcFh1MTExd3VnT0tkQ0dWWnUzajBS?=
 =?utf-8?B?UzBhaG11R0pVZlE0M3NKM2Roc1B0aEk4TFpnQzFJdm9RSnd3N0ZwRWpsOTha?=
 =?utf-8?B?TkVOdTZxc1VPTHZlSzhSZEZvWHptclRrTm9DSVIvbmROdWdkZWhyMU8yOGVX?=
 =?utf-8?B?bTFUZWRETlZmQjJKdXFYVzVrZFFOaFVXaEZiRE5wdDQxMHNjU2FUeVJPdFFE?=
 =?utf-8?B?cDFIVmhycVpWK1hWbUZBSzZmcEhkcitaYmZaaXdPT05QMFJZZEhRRW1INUsw?=
 =?utf-8?B?UE83NDZURzhyM2Y4MFhsWXl0OEpMbXFodUtVOXRnTzNVZitiTTdLZlNwN05x?=
 =?utf-8?B?UHg2Q3JOOTN4YjJHcGNqSDd1cXlLQjFrVVRiaGFIaHhmLzFsSmN4Qk42ZGVz?=
 =?utf-8?B?NGFyTzdxR2NFQXo3dkEwdHlaQTk3YWhTZ09PNjJpL2xVaVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTI3VzhKb1k2YzNEYnB0M0d0Z1BYYWhmemNGSnpXNlBTUUgxVmw1MytEQi8w?=
 =?utf-8?B?VGhwdExJMUVKZ3RmZEwzNVVWU0I4ODM2cnhyaDBnNXN2Nkx1TEVmcWtlVVBP?=
 =?utf-8?B?WUlwOXdJSjhIWHd5OTU4RzVwWVh3QzBDS3VQRTk5TFFqTnBqRTRZeUtFTldl?=
 =?utf-8?B?T0ZwenhZN1h0SDJLNGtPMHg3YWFuYlNoRi9LVWNGQU4raXpoWUthRWxkYU5p?=
 =?utf-8?B?bnpMcHkvWUNTbU5sMjZqUU9RN0NJZWZwSXA1QnZldnFrYU11NHBUWDNvcDMx?=
 =?utf-8?B?Ui8zcUo3dXMzVHdLVlZZdWRhNldhVXVQL2Fqb2FpdUQyVFc5WWhPbmdmTmJN?=
 =?utf-8?B?ODhPTkx5M3BJbitQR3FuWnlyQmVRMWhBb3IrV29hT0JDVlJkMWxYVFdVODVv?=
 =?utf-8?B?UnY2TGdRdHZxTnBXOW5tbk9idURTVGcyU1oxcFZkYklyQmIremFBcjNmRlZV?=
 =?utf-8?B?NktRQThtdXcwL3NIamhTY29VTXJvcERLZ2R1S0h0dkdLNlVmSTdodFpMZWlJ?=
 =?utf-8?B?a3U4eHVFWStRZUxtT1NkUXQ1Y2NoNjMwUTZkd0NYWmUwV083ZlhPeEZwWTJJ?=
 =?utf-8?B?S3Q3RWFZQzNVOGEvdEt5SGJDaTU2Lzc2MVhTRGpBTUpxcUNsOVpHWFRRdFVr?=
 =?utf-8?B?NGJ3UGdsSmtHYWtrcWN3U3Bpd3UzZTNuOFl5MjE2SnBNemhNZzNNMCtjTENS?=
 =?utf-8?B?cWh2dmxQSkR4RWpKR3hOV3BIQkh4UzF2SWhlYlVnOW1QTVJqV3JWYVlzdERr?=
 =?utf-8?B?Yi9WckwxUHoyTFJ2Nk80RGQwTGU3cHdtc2JBaFQ5MVVyWFVLTXMyeUxLdGpv?=
 =?utf-8?B?ZVdkNFRTSmNVdWZDdE1qSS9aLytKTENKTXdiR1BBQjcwS1JqWGJDT3lEdm9n?=
 =?utf-8?B?emNIb0l6NEZhNTJnaDFPUWZ6RFllTS80bEJzaHpETkNRZWI4Wk8wcUxVd1di?=
 =?utf-8?B?S3V3S3h2dzUyUU9wdlowUnQwQjQ2aGRtalVCam9kVlZ3aUh2SXFSL1NkNnJr?=
 =?utf-8?B?dTlwK0NvN2xTWGw5Q3dSTGpwOU1QdCtUS2NQcC90TVkvUGJLNHdCK0lUaDlW?=
 =?utf-8?B?b0hpejEyV05GQjRZbENnUDh3RnJWNUZNMUJmYlBNY1FPVG5PVGZqR2wvWWVX?=
 =?utf-8?B?MWxvTEtNZkFhUHpaaXpSYU9WcE0rMms4aE1HOVh6b29CWTBadUkvclFON0xo?=
 =?utf-8?B?NFYzbHlTWTlyUExUTXUxVnk4YUpYQmdKSkxrUDlnNkNhV0hMbUdUUlVtU2kv?=
 =?utf-8?B?amJ1Qkk4SEMySysvbHZ0T0RvZEVzVkg0RHhkV2R3RS8rS25YSVZIeG0rdTFC?=
 =?utf-8?B?M2k2SXY3VlVWbDB3SjNjOHBHc00xZzJmT0cvTjZTOXdJVXd1QUdSMEFVWkNF?=
 =?utf-8?B?YlFJQUJzdm9JMFJBekhkZEszS0t4bUFta1NTNkZDRnlkUVBETmdJNTJDQThy?=
 =?utf-8?B?YlNOd2V6RnpjS1FUS21kRjVwZW9zOVJxSDh6R045eDRyc1J3WEpaWlJka24y?=
 =?utf-8?B?dkdLRy92K0Q2MmhSTzlBK2c4ZUJBcUdNREczRWpuampFUitUeEVpbTg4L2Rk?=
 =?utf-8?B?dHVONE9aRDhGQm9PbmY5VDBoeVVwelc0NDdPTmhITzh5WktjSXY4R1BWd0xD?=
 =?utf-8?B?QXJhMjZFS0VCNnIrTlJpZWorMWI2QlFyTmhsaW1ZenE2NTFSQkJxM3Q0RjBt?=
 =?utf-8?B?cXEvb2dLd250bmNHc2NMeHdqdXJWRUNERTkvN1V0c0plOVBUb2N5TkcvYkFw?=
 =?utf-8?B?dlR3dnRQZlNaTzZGZGgxRjRYQ0RBY29GTlUrTVJocWdTcUFqMStCVmVsM1RQ?=
 =?utf-8?B?by9MWUhrWHF2anFob1pqVE9hVHMvL0VuZ3NYM1VLcnNPQzRLZnVOcmM0K3dy?=
 =?utf-8?B?dDJmWjh3bmdxR0xtMVRmbGJkVnRub2hGOGV1cHV0TWNTbmZIS2xLS2RkeGZ4?=
 =?utf-8?B?RDJBTzZ1Qm1WNkZ5Q1ZaWWRHakJJTzRpcVp3NEJtN2NjTFJ3NWt5OEJZL0Qy?=
 =?utf-8?B?cnU2QmVKY3BlTy9ldVBzNUl3N2lFTFowKzJMdWU0dXJRSmV4ek1vMy84QkNT?=
 =?utf-8?B?RGxTb1czMEMwN2ZNNXRZT3Brc3U0emwydTVLa0x0STRPVU1nem42MzJldm41?=
 =?utf-8?Q?6SAd1EB0jH7UdijNRQZ3j8TU1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F90DF735E323B4187D5B3D95C32EB12@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867c0cd5-c202-48a0-424e-08dcad251c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 03:43:27.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0eRIESONWpCLQfZHayQEpd30AUThPt8wQnn0yKJx1TgfNMMqDueT5zBvTaCACsEi/eMSwv7nEav0NPJpvKwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7900
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.973700-8.000000
X-TMASE-MatchedRID: 2Ti2c92MxSzUL3YCMmnG4hlckvO1m+JcjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2w0z6QDA9shNUENBIMyKD0Z722hDqHosTpEr
	BsExd5RvgNkha/JpgXGdUkQeUFMYgZIEKKTn9mhKzI1v7J4hECiseSAhqf1rRWltirZ/iPP5y7u
	XbFJiueMiL1N7k/vXlB+XnaTaGHqr0gegh04/2ZdxajlW+zwxCACnH/2c62CQTb/3sT17MXMJfR
	ix8rcI6XRmViCgAXqxz6Ti47hoQ8g3MtvKAx5cC4bl1FkKDELep7eIcybi6oblmMfLNiukaCCYK
	Lq3oRN5EtGYGQWlFcNmKZ1DSG646uQcDB0Z4dPWHFPwEnOCsnSmkZgwpl7M3yPQR7DhM3ja6aUs
	LmD3ge44q35WZMVPcDuqXN7hzGCgV5bNTfdsFPC3JWAaUy9sMEtdrY/Wb3fPNDTnArhVutRQMfG
	/Bl4stH5TnHYZFBIiI0veHE2pTTuI+D4eDXPKVxPkB0MIBaXHhfhSaE9tNW2tEzrC9eANpje0jg
	ce+svLi8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.973700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EF9D60C23587684AD202D1953D40183014699543DE3B6DD507A45D94F69588EE2000:8

T24gRnJpLCAyMDI0LTA3LTE5IGF0IDA3OjMxIC0xMDAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIEhlbGxvLCBCb3kuDQo+IA0KPiBPbiBGcmksIEp1bCAxOSwgMjAyNCBh
dCAwMTo0NzozNUFNICswMDAwLCBCb3kgV3UgKOWQs+WLg+iqvCkgd3JvdGU6DQo+IC4uLg0KPiA+
IElmIGl0IGlzIGZvciByZWFkYWJpbGl0eSwgSSB0aGluayBrZWVwaW5nIHVzaW5nIHU2NCBzeW5j
IGluc3RlYWQgb2YNCj4gPiByZXBsYWNpbmcgaXQgd2l0aCBzcGlubG9jayBpcyBiZXR0ZXIsIGJl
Y2F1c2Ugd2hhdCB1NjQgc3luYw0KPiBwcm90ZWN0cyBpcw0KPiA+IDY0LWJpdCBkYXRhIGZvciAz
Mi1iaXQgc3lzdGVtcywgd2hpbGUgc3BpbmxvY2sgY2FuIGJlIHVzZWQgZm9yIG1hbnkNCj4gPiBv
dGhlciByZWFzb25zLiBUaGUgcm9vdCBjYXVzZSBvZiB0aGlzIGlzc3VlIGlzIGp1c3QgdGhlIGlu
Y29ycmVjdA0KPiB1c2UNCj4gDQo+IFllYWgsIGJ1dCBpdCBjYW4ndCBiZSB1c2VkIHdoZW4gdGhl
cmUgYXJlIG11bHRpcGxlIHVwZGF0ZXJzLg0KPiANCj4gPiBvZiB1NjQgc3luYy4gQWRkaW5nIGJh
Y2sgdGhlIG1pc3Npbmcgc3BpbmxvY2sgZm9yIHRoZSBjb3JyZWN0IHVzYWdlDQo+IG9mDQo+ID4g
dTY0IHN5bmMgaXMgc2ltcGxlci4gSXMgdGhlcmUgYW55IGJlbmVmaXQgdG8gcmVwbGFjaW5nIHU2
NCBzeW5jDQo+IHdpdGgNCj4gPiBzcGlubG9jaz8NCj4gDQo+IEl0IGRvZXNuJ3QgbWFrZSBzZW5z
ZSB0byBwcm90ZWN0IHU2NF9zeW5jIHdpdGggYSBzcGlubG9jay4gQm90aCBhcmUNCj4gb25seQ0K
PiBuZWVkZWQgb24gMzJiaXQuIFdoYXQncyB0aGUgcG9pbnQgb2YgaGF2aW5nIGJvdGg/IEFsc28s
IG5vdGUgdGhhdA0KPiBpb3N0YXRfY3B1DQo+IGlzIGFsc28gdXBkYXRlZCBmcm9tIHR3byBwYXRo
cyAtIGJpbyBpc3N1ZSBhbmQgc3RhdCByZXNldC4gSWYgeW91DQo+IHdhbnQgdG8NCj4ga2VlcCB0
aGF0IHU2NF9zeW5jLCB0aGUgb25seSB3YXkgdG8gYXZvaWQgcG9zc2libGUgZGVhZGxvY2tzIGlz
DQo+IGFkZGluZw0KPiBzcGlubG9jayBpbiB0aGUgYmlvIGlzc3VlIHBhdGggdG9vLCB3aGljaCB3
aWxsIGJlIHByZXR0eSBleHBlbnNpdmUuDQo+IA0KDQpUaGUgdXNlIG9mIGEgc3BpbmxvY2sgd2l0
aCB1NjQgc3luYyBpcyBzdWdnZXN0ZWQgaW4NCmluY2x1ZGUvbGludXgvdTY0X3N0YXRzX3N5bmMu
aDozMy4NCg0KICogVXNhZ2UgOg0KICoNCiAqIFN0YXRzIHByb2R1Y2VyICh3cml0ZXIpIHNob3Vs
ZCB1c2UgZm9sbG93aW5nIHRlbXBsYXRlIGdyYW50ZWQgaXQNCmFscmVhZHkgZ290DQogKiBhbiBl
eGNsdXNpdmUgYWNjZXNzIHRvIGNvdW50ZXJzIChhIGxvY2sgaXMgYWxyZWFkeSB0YWtlbiwgb3Ig
cGVyIGNwdQ0KICogZGF0YSBpcyB1c2VkIFtpbiBhIG5vbiBwcmVlbXB0YWJsZSBjb250ZXh0XSkN
CiAqDQogKiAgIHNwaW5fbG9ja19iaCguLi4pIG9yIG90aGVyIHN5bmNocm9uaXphdGlvbiB0byBn
ZXQgZXhjbHVzaXZlIGFjY2Vzcw0KICogICAuLi4NCiAqICAgdTY0X3N0YXRzX3VwZGF0ZV9iZWdp
bigmc3RhdHMtPnN5bmNwKTsNCiAqICAgdTY0X3N0YXRzX2FkZCgmc3RhdHMtPmJ5dGVzNjQsIGxl
bik7IC8vIG5vbiBhdG9taWMgb3BlcmF0aW9uDQogKiAgIHU2NF9zdGF0c19pbmMoJnN0YXRzLT5w
YWNrZXRzNjQpOyAgICAvLyBub24gYXRvbWljIG9wZXJhdGlvbg0KICogICB1NjRfc3RhdHNfdXBk
YXRlX2VuZCgmc3RhdHMtPnN5bmNwKTsNCg0KSXMgdGhpcyBhIGluY29ycmVjdCBzdGF0bWVudD8N
Cg0KPiA+ID4gQWxzbywgZm9yIGJsa2dfY2xlYXJfc3RhdCgpLCB3ZSdyZSBydW5uaW5nIGEgc2xp
Z2h0IGNoYW5jZSBvZg0KPiA+ID4gY2xlYXJpbmcgb2YNCj4gPiA+IGlvc3RhdF9jcHUgcmFjaW5n
IGFnYWluc3Qgc3RhdGUgdXBkYXRlcyBmcm9tIHRoZSBob3QgcGF0aC4gR2l2ZW4NCj4gdGhlDQo+
ID4gPiBjaXJjdW1zdGFuY2VzIC0gc3RhdCByZXNldCBpcyBhbiBjZ3JvdXAxLW9ubHkgZmVhdHVy
ZSB3aGljaCBpc24ndA0KPiA+ID4gdXNlZA0KPiA+ID4gd2lkZWx5IGFuZCBhIHByb2JsZW1hdGlj
IGludGVyZmFjZSB0byBiZWdpbiB3aXRoLCBJIGJlbGlldmUgdGhpcw0KPiBpcyBhDQo+ID4gPiB2
YWxpZA0KPiA+ID4gY2hvaWNlIGJ1dCBpdCBuZWVkcyB0byBiZSBub3RlZC4NCj4gPiANCj4gPiBJ
IGRvbid0IGdldCB0aGlzIHBhcnQsIGJ1dCBpZiB0aGlzIGlzIGFub3RoZXIgaXNzdWUsIG1heWJl
IGFub3RoZXINCj4gPiBwYXRjaCB3b3VsZCBiZSBiZXR0ZXI/DQo+IA0KPiBJdCdzIHRoZSBzYW1l
IGlzc3VlLiBSZXNldCBpcyBhbm90aGVyIHdyaXRlciBhbmQgd2hlbmV2ZXIgeW91IGhhdmUNCj4g
bW9yZSB0aGFuDQo+IG9uZSB3cml0ZXJzIHcvIHU2NF9zeW5jLCB0aGVyZSdzIGEgY2hhbmNlIG9m
IGRlYWRsb2Nrcy4gU28sDQo+IGlvc3RhdF9jcHUgYWxzbw0KPiBoYXMgdHdvIHdyaXRlcnMgLSBi
aW8gaXNzdWUgYW5kIHN0YXQgcmVzZXQuIElmIHlvdSB3YW50IHRvIGtlZXAgdXNpbmcNCj4gdTY0
X3N5bmMgaW4gYm90aCBwbGFjZXMsIHRoZSBvbmx5IHdheSB0byBkbyBpdCBpcyBhZGRpbmcgc3Bp
bmxvY2sNCj4gcHJvdGVjdGlvbg0KPiB0byBib3RoIHBhdGhzLCB3aGljaCBpcyBhbiBleHBlbnNp
dmUgdGhpbmcgdG8gZG8gZm9yIHRoZSBiaW8gaXNzdWUNCj4gcGF0aC4gU28sDQo+IGhlcmUsIHdl
J2QgcmF0aGVyIGp1c3QgZ2l2ZSB1cCBhbmQgbGV0IHN0YXQgcmVzZXR0aW5nIGJlIHJhY3kgb24N
Cj4gMzJiaXQuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtLSANCj4gdGVqdW4NCg0KVGhlcmUgYXJl
IHRocmVlIHBsYWNlcyB1cGRhdGUgaW9zdGF0IGFuZCB0d28gcGxhY2VzIHVwZGF0ZSBpb3N0YXRf
Y3B1DQppbiBibGstY2dyb3VwLmMgaW4gdmVyc2lvbiA2LjEwLjEuDQoNCkkgYXNzdW1lIHRoZSBz
dWdnZXN0aW9uIGluIHU2NF9zdGF0c19zeW5jLmggaXMgY29ycmVjdC4gRm9yDQpyZWFkYWJpbGl0
eSwgaG93IGFib3V0IHRoZSBmb2xsb3dpbmcgY2hhbmdlPw0KDQpkaWZmIC0tZ2l0IGEvYmxvY2sv
YmxrLWNncm91cC5jIGIvYmxvY2svYmxrLWNncm91cC5jDQppbmRleCA4NWIzYjkwNTE0NTUuLjc0
NzJjZmE5YTUwNiAxMDA2NDQNCi0tLSBhL2Jsb2NrL2Jsay1jZ3JvdXAuYw0KKysrIGIvYmxvY2sv
YmxrLWNncm91cC5jDQpAQCAtNjIsNiArNjIsMTAgQEAgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVf
c3RydWN0ICpibGtjZ19wdW50X2Jpb193cTsNCg0KIHN0YXRpYyBERUZJTkVfUkFXX1NQSU5MT0NL
KGJsa2dfc3RhdF9sb2NrKTsNCg0KKyNpZiBCSVRTX1BFUl9MT05HID09IDMyDQorc3RhdGljIERF
RklORV9SQVdfU1BJTkxPQ0soYmxrZ19zdGF0X2NwdV9sb2NrKTsNCisjZW5kaWYNCisNCiAjZGVm
aW5lIEJMS0dfREVTVFJPWV9CQVRDSF9TSVpFICA2NA0KDQogLyoNCkBAIC01MzUsNSArNTM5LDU1
IEBAIHN0YXRpYyB2b2lkIGJsa2dfZGVzdHJveV9hbGwoc3RydWN0IGdlbmRpc2sgKmRpc2spDQog
ICAgICAgIHNwaW5fdW5sb2NrX2lycSgmcS0+cXVldWVfbG9jayk7DQogfQ0KDQorc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBsb25nIGJsa2NnX2lvc3RhdHNfdXBkYXRlX2JlZ2luX2lycXNhdmUoc3Ry
dWN0DQp1NjRfc3RhdHNfc3luYyAqc3luY3ApDQorew0KKyAgICAgICB1bnNpZ25lZCBsb25nIGZs
YWdzOw0KKw0KKyNpZiBCSVRTX1BFUl9MT05HID09IDY0DQorICAgICAgIGZsYWdzID0gdTY0X3N0
YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKHN5bmNwKTsNCisjZWxzZSAvKiA2NCBiaXQgKi8NCisg
ICAgICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZibGtnX3N0YXRfbG9jaywgZmxhZ3MpOw0KKyAg
ICAgICB1NjRfc3RhdHNfdXBkYXRlX2JlZ2luKHN5bmNwKTsNCisjZW5kaWYNCisNCisgICAgICAg
cmV0dXJuIGZsYWdzOw0KK30NCisNCitzdGF0aWMgaW5saW5lIHZvaWQgYmxrY2dfaW9zdGF0c191
cGRhdGVfZW5kX2lycXJlc3RvcmUoc3RydWN0DQp1NjRfc3RhdHNfc3luYyAqc3luY3AsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZw0KZmxhZ3MpDQorew0KKyNpZiBCSVRTX1BFUl9MT05HID09IDY0DQorICAgICAgIHU2
NF9zdGF0c191cGRhdGVfZW5kX2lycXJlc3RvcmUoc3luY3AsIGZsYWdzKTsNCisjZWxzZSAvKiA2
NCBiaXQgKi8NCisgICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9lbmQoc3luY3ApOw0KKyAgICAgICBy
YXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYmxrZ19zdGF0X2xvY2ssIGZsYWdzKTsNCisjZW5k
aWYNCit9DQorDQorc3RhdGljIHVuc2lnbmVkIGxvbmcgYmxrY2dfaW9zdGF0c19jcHVfdXBkYXRl
X2JlZ2luX2lycXNhdmUoc3RydWN0DQp1NjRfc3RhdHNfc3luYyAqc3luY3ApDQorew0KKyAgICAg
ICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KKw0KKyNpZiBCSVRTX1BFUl9MT05HID09IDY0DQorICAg
ICAgIGZsYWdzID0gdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKHN5bmNwKTsNCisjZWxz
ZSAvKiA2NCBiaXQgKi8NCisgICAgICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZibGtnX3N0YXRf
Y3B1X2xvY2ssIGZsYWdzKTsNCisgICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbihzeW5jcCk7
DQorI2VuZGlmDQorDQorICAgICAgIHJldHVybiBmbGFnczsNCit9DQorDQorc3RhdGljIGlubGlu
ZSB2b2lkIGJsa2NnX2lvc3RhdHNfY3B1X3VwZGF0ZV9lbmRfaXJxcmVzdG9yZShzdHJ1Y3QNCnU2
NF9zdGF0c19zeW5jICpzeW5jcCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQNCmxvbmcgZmxhZ3MpDQorew0KKyNpZiBC
SVRTX1BFUl9MT05HID09IDY0DQorICAgICAgIHU2NF9zdGF0c191cGRhdGVfZW5kX2lycXJlc3Rv
cmUoc3luY3AsIGZsYWdzKTsNCisjZWxzZSAvKiA2NCBiaXQgKi8NCisgICAgICAgdTY0X3N0YXRz
X3VwZGF0ZV9lbmQoc3luY3ApOw0KKyAgICAgICByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
YmxrZ19zdGF0X2NwdV9sb2NrLCBmbGFncyk7DQorI2VuZGlmDQorfQ0KKw0KIHN0YXRpYyB2b2lk
IGJsa2dfaW9zdGF0X3NldChzdHJ1Y3QgYmxrZ19pb3N0YXQgKmRzdCwgc3RydWN0DQpibGtnX2lv
c3RhdCAqc3JjKQ0KIHsNCiAgICAgICAgaW50IGk7DQpAQCAtNjMyLDI0ICs2ODYsMjYgQEAgc3Rh
dGljIHZvaWQgYmxrZ19pb3N0YXRfc2V0KHN0cnVjdCBibGtnX2lvc3RhdA0KKmRzdCwgc3RydWN0
IGJsa2dfaW9zdGF0ICpzcmMpDQogc3RhdGljIHZvaWQgX19ibGtnX2NsZWFyX3N0YXQoc3RydWN0
IGJsa2dfaW9zdGF0X3NldCAqYmlzKQ0KIHsNCiAgICAgICAgc3RydWN0IGJsa2dfaW9zdGF0IGN1
ciA9IHswfTsNCi0gICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCg0KLSAgICAgICBmbGFncyA9
IHU2NF9zdGF0c191cGRhdGVfYmVnaW5faXJxc2F2ZSgmYmlzLT5zeW5jKTsNCiAgICAgICAgYmxr
Z19pb3N0YXRfc2V0KCZiaXMtPmN1ciwgJmN1cik7DQogICAgICAgIGJsa2dfaW9zdGF0X3NldCgm
YmlzLT5sYXN0LCAmY3VyKTsNCi0gICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVzdG9y
ZSgmYmlzLT5zeW5jLCBmbGFncyk7DQogfQ0KDQogc3RhdGljIHZvaWQgYmxrZ19jbGVhcl9zdGF0
KHN0cnVjdCBibGtjZ19ncSAqYmxrZykNCiB7DQogICAgICAgIGludCBjcHU7DQorICAgICAgIHVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQoNCiAgICAgICAgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkg
ew0KICAgICAgICAgICAgICAgIHN0cnVjdCBibGtnX2lvc3RhdF9zZXQgKnMgPSBwZXJfY3B1X3B0
cihibGtnLQ0KPmlvc3RhdF9jcHUsIGNwdSk7DQoNCisgICAgICAgICAgICAgICBmbGFncyA9IGJs
a2NnX2lvc3RhdHNfY3B1X3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZzLQ0KPnN5bmMpOw0KICAgICAg
ICAgICAgICAgIF9fYmxrZ19jbGVhcl9zdGF0KHMpOw0KKyAgICAgICAgICAgICAgIGJsa2NnX2lv
c3RhdHNfY3B1X3VwZGF0ZV9lbmRfaXJxcmVzdG9yZSgmcy0+c3luYywNCmZsYWdzKTsNCiAgICAg
ICAgfQ0KKyAgICAgICBmbGFncyA9IGJsa2NnX2lvc3RhdHNfdXBkYXRlX2JlZ2luX2lycXNhdmUo
JmJsa2ctPmlvc3RhdC5zeW5jKTsNCiAgICAgICAgX19ibGtnX2NsZWFyX3N0YXQoJmJsa2ctPmlv
c3RhdCk7DQorICAgICAgIGJsa2NnX2lvc3RhdHNfdXBkYXRlX2VuZF9pcnFyZXN0b3JlKCZibGtn
LT5pb3N0YXQuc3luYywgZmxhZ3MpOw0KIH0NCg0KIHN0YXRpYyBpbnQgYmxrY2dfcmVzZXRfc3Rh
dHMoc3RydWN0IGNncm91cF9zdWJzeXNfc3RhdGUgKmNzcywNCkBAIC0xMTM0LDkgKzExOTAsOSBA
QCBzdGF0aWMgdm9pZCBibGtjZ19maWxsX3Jvb3RfaW9zdGF0cyh2b2lkKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjcHVfZGtzdGF0cy0+c2VjdG9yc1tTVEFUX0RJU0NBUkRdIDw8
DQo5Ow0KICAgICAgICAgICAgICAgIH0NCg0KLSAgICAgICAgICAgICAgIGZsYWdzID0gdTY0X3N0
YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZibGtnLQ0KPmlvc3RhdC5zeW5jKTsNCisgICAgICAg
ICAgICAgICBmbGFncyA9IGJsa2NnX2lvc3RhdHNfdXBkYXRlX2JlZ2luX2lycXNhdmUoJmJsa2ct
DQo+aW9zdGF0LnN5bmMpOw0KICAgICAgICAgICAgICAgIGJsa2dfaW9zdGF0X3NldCgmYmxrZy0+
aW9zdGF0LmN1ciwgJnRtcCk7DQotICAgICAgICAgICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9lbmRf
aXJxcmVzdG9yZSgmYmxrZy0+aW9zdGF0LnN5bmMsDQpmbGFncyk7DQorICAgICAgICAgICAgICAg
YmxrY2dfaW9zdGF0c191cGRhdGVfZW5kX2lycXJlc3RvcmUoJmJsa2ctPmlvc3RhdC5zeW5jLCAN
CmZsYWdzKTsNCiAgICAgICAgfQ0KIH0NCg0KQEAgLTIxNTIsNyArMjIwOCw3IEBAIHZvaWQgYmxr
X2Nncm91cF9iaW9fc3RhcnQoc3RydWN0IGJpbyAqYmlvKQ0KDQogICAgICAgIGNwdSA9IGdldF9j
cHUoKTsNCiAgICAgICAgYmlzID0gcGVyX2NwdV9wdHIoYmlvLT5iaV9ibGtnLT5pb3N0YXRfY3B1
LCBjcHUpOw0KLSAgICAgICBmbGFncyA9IHU2NF9zdGF0c191cGRhdGVfYmVnaW5faXJxc2F2ZSgm
YmlzLT5zeW5jKTsNCisgICAgICAgZmxhZ3MgPSBibGtjZ19pb3N0YXRzX2NwdV91cGRhdGVfYmVn
aW5faXJxc2F2ZSgmYmlzLT5zeW5jKTsNCg0KICAgICAgICAvKg0KICAgICAgICAgKiBJZiB0aGUg
YmlvIGlzIGZsYWdnZWQgd2l0aCBCSU9fQ0dST1VQX0FDQ1QgaXQgbWVhbnMgdGhpcyBpcw0KYSBz
cGxpdA0KQEAgLTIxNzUsNyArMjIzMSw3IEBAIHZvaWQgYmxrX2Nncm91cF9iaW9fc3RhcnQoc3Ry
dWN0IGJpbyAqYmlvKQ0KICAgICAgICAgICAgICAgIFdSSVRFX09OQ0UoYmlzLT5scXVldWVkLCB0
cnVlKTsNCiAgICAgICAgfQ0KDQotICAgICAgIHU2NF9zdGF0c191cGRhdGVfZW5kX2lycXJlc3Rv
cmUoJmJpcy0+c3luYywgZmxhZ3MpOw0KKyAgICAgICBibGtjZ19pb3N0YXRzX2NwdV91cGRhdGVf
ZW5kX2lycXJlc3RvcmUoJmJpcy0+c3luYywgZmxhZ3MpOw0KICAgICAgICBjZ3JvdXBfcnN0YXRf
dXBkYXRlZChibGtjZy0+Y3NzLmNncm91cCwgY3B1KTsNCiAgICAgICAgcHV0X2NwdSgpOw0KIH0N
Cg0KLS0NCmJveS53dQ0KDQo=

