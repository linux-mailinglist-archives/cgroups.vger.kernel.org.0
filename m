Return-Path: <cgroups+bounces-3560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F84929AA6
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA09B20BCF
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C115A8;
	Mon,  8 Jul 2024 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dwXq/8dR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ka8T/BU7"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7F19B;
	Mon,  8 Jul 2024 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720404056; cv=fail; b=m/893/JMredvhZt54uZEDwiVY4wxTywtn8EWj25sOKyAQzWvoQrv8WP/Iigzca72aqPAxQ7yzvYvasVWrgIEG0ajZFz9DH4TCRMROriVp59vGRqPF7cNkuu0tnGHJR+JoXjg8CWSozzyOTl6nIEfz5QsOD7m6bJTl314VjdVb6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720404056; c=relaxed/simple;
	bh=lDOvguoS6R6Df2qWOwtXMCwNH4VLN4QAaHT7gNULGJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5Mb5KgaIT9itHULCKEJn3OpYo0/fXpkcmPRwOh3khMGaxmHiHD2hrSjSFMJnkbVL2JOd9zmIIAXzGE4ho3YyoQ7Ee0Ha6Ii8hlq8AYgBno0CfGQuaZTysCHj1UuxY950Za2N0emuesdjQonLOWNZ56nI3+MZV9JTW0yZ7Inni0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dwXq/8dR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ka8T/BU7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e4ca623e3ccd11ef8b8f29950b90a568-20240708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lDOvguoS6R6Df2qWOwtXMCwNH4VLN4QAaHT7gNULGJg=;
	b=dwXq/8dRho1h8HPGLvvQusw+/UTSx3Q8DFsVAHI1sZ2WKuCchxO/9oluqAIFdONtf4VVzGI+wyhfZsCXMSYQrANh8gy4KHgUjwVjiOG9uptefJWMR2aAh7eIgcqklL0PGAQA8Bw+iRK4QXDhWqCZdGl2ziFPscLix6RtaLICHkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:33024501-4eef-40dc-be7a-fc5cca991a3f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:428133d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e4ca623e3ccd11ef8b8f29950b90a568-20240708
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2012390340; Mon, 08 Jul 2024 10:00:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Jul 2024 10:00:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Jul 2024 10:00:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiCZDbkXIPCtv+VC/b5FV7kpNIhvrxfoxPJJsRyerVplcbwhgiY3bfFfWHc20TPf3FdrraFsD1jiQvY0oEQj92D1/O2XecG62BGrpQzY8iz5srnZzSSIlhOwgQJX5YZae9PK0qiHi5KWGGIstdjwIoA3n+AcuwNdTd8WiHYsySirOdxQ5NB/hw+xfT4SPhcEj6DAP5zAptzHnd5A4X5h/pStlvpgpQzjAjqY8JrDNU9krlfGGVkEP9Jh/1T04iCsalggvDKJLulV+g2FyWnbkc6C8qiLPYMwnDcFZ1u5jhqHvV62/RcqkHuPlzrMfUwnSMtB46NMiRBa1765If7n4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDOvguoS6R6Df2qWOwtXMCwNH4VLN4QAaHT7gNULGJg=;
 b=SBXNqr6xnSiaygd+VcY/8fczdgtLHD5xGahuQZXXNhzMwrOTWGOqi5h6OxC9xo6CXSmwrsk//B9Y2xufgxVsnIRejIV1jpa5Seqbz5UIOezt0Lmkm1YK62GP8bHnBx15/c+4Y87o/8bSazbbIKdW/VaWFufC9+vQtrpbHBp+5W33HHTUaH7VcAvsQCjzIM/mndI/H91M0n/fgwt3mxw/KsBeP+I8NxPagi5He0q8mtF0TDqQRZ8aXrx2iRw66BMbZPqEr8kTiTwWA+DscqEZqBRT0/KzbUt4fhOKPKZYdKnBlWvtH07CtwctrfYVpXPxVBfeZbS00HRlMP3A/FQh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDOvguoS6R6Df2qWOwtXMCwNH4VLN4QAaHT7gNULGJg=;
 b=Ka8T/BU7MSqcl1Ag2IJB5nmd+oaTyOmVR0EPWMAnqiuOSUu8rXZQxaesgeL8kSsjK6kLUT8d3TOGaY4X44lZ/ZhPxKVtdx7rzLKQd/gzRzepHjwfXZYawrFj6SGsFzxA24bgwy+uy8G7GN8VRRuN2iAfPbed0c20saTYz8RVoGg=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SEYPR03MB7535.apcprd03.prod.outlook.com (2603:1096:101:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:00:44 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:00:42 +0000
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
Subject: Re: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Thread-Topic: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Thread-Index: AQHazrDFnjNwsUu8gUWrj4pzis0BS7HoX+4AgAO39YA=
Date: Mon, 8 Jul 2024 02:00:42 +0000
Message-ID: <709276ca279982cf0014e93eafaa2272f847ff4a.camel@mediatek.com>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
	 <Zogpum23mjHZC8yO@slm.duckdns.org>
In-Reply-To: <Zogpum23mjHZC8yO@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SEYPR03MB7535:EE_
x-ms-office365-filtering-correlation-id: defd7467-a8df-4afb-c877-08dc9ef1c5f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXhrZlVGd1dla2oxQVV5WjlTVHM1azUvM0p2QjBTRXJib3JiTWhSYzExK2lU?=
 =?utf-8?B?Q09qYVNzcHJ4ZjJBM1U2cWVpQkN1ciswVis0akh5U1pvbzlScFBTOENWQmtT?=
 =?utf-8?B?bkVTUm1nSUhXL0JMaHVpRVJSdEY3SlcycFIxdWprWWZIdWhVVUs0RzJQaFh4?=
 =?utf-8?B?NzNnZTJISzBlM2t2Z25GR3pOMDNISFdaTEhuK3lVM0FZQjRidCtPL3hFMkRh?=
 =?utf-8?B?VVBJcUJzOTVsLzhZZldiaGJtYTIyZnhuMndudVplYlBDNkRsZ2N4bXFvNTJt?=
 =?utf-8?B?L2Z3MDA3SjZKMGwxV2tnblVVK0IzTFU1bzJvRzRHKzRwekJJSmlXT2d3eURj?=
 =?utf-8?B?QnBwNzJENGN3RFRNRElZY0VnSHpIUFZ6RHJaMVpVYmM4VG1KZnpRbHJiMERi?=
 =?utf-8?B?bVp0Z2E0RWhybjA1dCtxNkxxM0NYU1VUMjI5TlBPTENuY1EwSE8xS0N6dnJX?=
 =?utf-8?B?a2piTTVtTHhuaExReWE4WXNDWVpBdnY3ejVIQm44QzY2K0FLU3VpR2h2ei91?=
 =?utf-8?B?M1g5V3VRQ3JEeFlBWnVsSEJhaG82RHlZK1B1N0ZIbWUvQlJNaDFHYVo0OVBD?=
 =?utf-8?B?Y1NTd3BQcXBrN2lHaS9uelF6ZG9DN2Y1T20rRlJ2dlM0Vzh0SEZldkdqM3p1?=
 =?utf-8?B?NUt0YUVyelZHM25nUk9rOU41ZWY5Nzdjakp6UXRxZnZaalBsd2QvTWdvZnlq?=
 =?utf-8?B?ejJrOXpUemRnNUM2YThqQU1yVUMxVVRjL2JzS21ReHV3ZW00ZFhicEtjSElE?=
 =?utf-8?B?YlRyQXRmZUZiaFprM0pIa1dOdFFMZjYyVHFZaVdCMUpiV0I1T2NqYytYU0g0?=
 =?utf-8?B?aDVubzNzV0NZODZzaWNlWU1QYkd2Mk82YnVWSVhuQ2ltcmxtY2xkbmdtOGd3?=
 =?utf-8?B?ZDRpNVFZSklySnkyWTVaU3htaFJIN3NCVERnODFCN0Z2TmVpVnN5WFVYbEx0?=
 =?utf-8?B?b3dsUHV6VTlwbDROYk44ZW9ObEthN2sweTJnTmllb0F0MkgzdzVMQ3hNaksv?=
 =?utf-8?B?Tm5RaGJXV1d2cklNRlRsbkx0dUFLTWI5b1EyWHk0SHB5dkY1amNHMk1IbXBW?=
 =?utf-8?B?M2ZoUmN4Nm15d2RPYlRZZjh4RWZzLzY4YW5jR3E5a1haYVkxOVJ3UU1tMmtL?=
 =?utf-8?B?WTRoclJXUmFXeUl5TnJXZldXUWlmaWJHR1lNU0E4ZUJwZXZFREFCUFZEc0E0?=
 =?utf-8?B?cHhJVFZ2bmtpR0JWMVhpNWE4REZ5L25FOWdPYXg3cTRtQU5VbFN4SGFXZmZl?=
 =?utf-8?B?bVE5RVppcTlzZ2ZsWHFwMmg2VllHWXVLbVNBblBBSmV5OUt6d0FwWG5vbW5X?=
 =?utf-8?B?MjFvSEtxQjc3d3ZZTk9DdXlXZjh6bG1uUVJ0QTVTMTZMdkVnK1l1VWhtWTc1?=
 =?utf-8?B?SWtYZkphVncycVU0dmhaKzVCd0hTVXFGbGJNT2FnVkU2STVYbWlvVUh0WFdq?=
 =?utf-8?B?UTRGZ1lEcFdJNEVaM0haNXgzbUIzbC9ZckJ3QmFOTUZxM3ExOG9IV2hreml3?=
 =?utf-8?B?NHdlSlFFZ2Z0VmxWQzVlRVNydWNzcmtINXcxWFhheTVPR1ROc0ZHM2FPRDNE?=
 =?utf-8?B?M1hFaXpTYWxTRFRGWHBGemFOSHE4Z0pQbnZwbXF6RVdvSDhBMmRSSU9HaExG?=
 =?utf-8?B?aC9STk9OakRPRXJwT0twRkhwSW8xMWo5VWEzR1JJamdkM0lvMjZzQ05zMzM1?=
 =?utf-8?B?a2g2UFFQMThiU25DRmVJQWxQQ1lxM3BibGRIQW5Dc2pRbnVIV3lDSFIzU2U2?=
 =?utf-8?B?OExRc1kweFVzTE44Z1dHS1JDSlVOUVZHK1RrSllKNTJTQkRjQzVzOWdORnpD?=
 =?utf-8?B?bXIzK2pra2VFZWRCVUQ1eEQrWmFTcTVNWXBOM0tDdUh0emtBT0x4TkgwQVhz?=
 =?utf-8?B?RU94Yzg1S0V2YXhPNDJySnpzQk8rSU5IQWI0MHhJWkJNYWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2JqR1lvM1dBMWQvMHk1bk8wMG1wQk5KdTJIdk9ldG9NKzNZdWIvM0tQa3lo?=
 =?utf-8?B?S1ZJaHJBOEViYWtlNGtEREdPb25rcEZGMzBWRUc4dmRrSkVQT2dBWHFIanNU?=
 =?utf-8?B?U3FGUlJ4S1hJSjFFQmJvU2NaSTRsSHZmNkZkK1FBMWdvMW1XMGdlRmVudDFN?=
 =?utf-8?B?SFA2N2NCMXlaenZBRUFPNXk5ZnFWOGoyYjNTS0tIQWtuZDJmdzBhaGltNWla?=
 =?utf-8?B?L3BGUjdhSkpBem00WVdFN0JKaDB2TElqblFtbkpQdmt2dThZMEVOMFNZSmJ2?=
 =?utf-8?B?U3BieVNneldiNWZtWlR1NmF1cXVoYnJQOVZSNmtzN053TzFiK3k2MUF2MTFu?=
 =?utf-8?B?dXdQVzF5V1VER1hPWXVzTjRRTCsvbHVIWVVCY1IxU0dFSGs0OFlSSUJtc0lT?=
 =?utf-8?B?dlg5OC9QRXhxSFF1c2FtYTIwZnF6UDJBZnUwT0NjTmVuYnBUendzMnBUMnFt?=
 =?utf-8?B?UHJNNmZzcGoxZTlHS0tXODF0eEFWTzdFQjBrc0dvbzliR2hIdTFTWG9qSGdv?=
 =?utf-8?B?b2w1Y1RlLzBqT1RKYVltL01zUkIvSWR3eWhCWTgxN095WWlEcGsrWU5JeVVM?=
 =?utf-8?B?ZDlXMUVwVVA0UzFkbFlhUjBPdlMxcDcxdTJGdDVwRmRXOUYwQzVrcGxjVmx4?=
 =?utf-8?B?Y2RBUXc2czRvYWdTT3I5QXNpVnVqNDZVd1dHT293bnFqTTgrQzJDcXlWMTJ3?=
 =?utf-8?B?T0YxMHMvLy8zZm5yYUVaREN4dXQvU3p0Z0RxNGd2ZDNFN1pVRjVubE8xOG9W?=
 =?utf-8?B?c1d3WDlndnptNGlPQWxiQkVWU0c2a25XcUxkYTBpUTRPRFE3WTY1T0Y2SUNW?=
 =?utf-8?B?dEJBVkU5djdKNGJqcFhyN2xjZUVsVlgvR3NIemRGdXlMd01QR2s0QUpGY3h6?=
 =?utf-8?B?Q3kxT1drKzlsSnNFKzg2YW1iL245cXhrSERsdGNNWkY3N3piQmZXbnJXUnJL?=
 =?utf-8?B?OUhoa2pBVVZYQ05wUFNVYTlDVDRrbHRDbkxxUnhEck1XNStHREJDZ2RmcWxy?=
 =?utf-8?B?ZDFISTd2UGVOUnZXVkF6QzNGSHNnWFh2REhoanhMZTJ0Q0NOME4zTzMyRWJB?=
 =?utf-8?B?YWRHRXpvaUdtcEVuT2Q5WDRGcndncDZWZDJPellKUnBvUGhYV2Jzcm56SzYx?=
 =?utf-8?B?elRaSExsZkltWEN0UjdNeVpTVy9xQW53cDF6ZEJPQTV1ZXVaWlRrSXZNK2Zj?=
 =?utf-8?B?Tk8zeDRzVGNpU3d2blFnTGt4dGFLZkR0SGJqK0JKVTlBZ01ZWUh4SmRYSjlh?=
 =?utf-8?B?OGVQQ3ZZUnhFbHpXT3h1Z0JLRi9pT25UQkxHeElUNnVYeFFEZUl2MDlSSkcw?=
 =?utf-8?B?NTdVM0doZDZZQVF4YkxYb094bFNUWTd0eWRtd2x6RkFDVUFYdHBUNDRUTjRJ?=
 =?utf-8?B?T1NCMXNhaHlvVSs2bmk2Q3FDLzZ5ZVNURk9mbUdndDl0SmhSSkY4REdIaWRi?=
 =?utf-8?B?dzk1Uk41a25icVZoZFp6VTg0S090QTlBVkdDL253QjhPM0t0cEtOdmdvbFhM?=
 =?utf-8?B?UTR5eHZmTmZlQk9jcVZPc0pCZUNGLzBLaFZ0c1VvRm80bTczV20zT3o4cTIz?=
 =?utf-8?B?TlRjaWdiMitsTjZQWGNGUnY2UzJOTnFJZEVEeWI1aVBqd3VmdE9xcUhkdEV4?=
 =?utf-8?B?Y1BCV3Byd0dJbzBUM2Y3MlVlRkw0TEVoTDJkLzZzNENwcmt6MUpoUE1jcS9X?=
 =?utf-8?B?T1NXZW95UkJjVXZuVnI3K0NEN1AvUUk2cktGdGh0YmFDUzlOZW9FMVNMdStZ?=
 =?utf-8?B?bDR4N2hseklaV3JFcXdpRFhRSGJPZ3g1ZjRCbjZaRW5ZVU5FVFF6VHlPUEdl?=
 =?utf-8?B?SjJjbUJCWGYxRmRjYkJMTWxnOTcycm9WOFJ0LytOMlBmM2ZOZDh3YmtzVjNs?=
 =?utf-8?B?c2JHeU9GeFkyN0RuVDBTVUlhblBlWUJobFphTTJxeTJGUmg5R3RKUWVWNGMr?=
 =?utf-8?B?YXRObTV6MndFSG1FN25DWVhYaDRSbEtybzRUa1JxbWZhUTJMdDZSS29SeFJH?=
 =?utf-8?B?ZXdQUW1KaUhkVHpWYURoTWw1bFRlVDhjM1hxT21zOC9QeVhXYlZ1dHRNU2hn?=
 =?utf-8?B?dE8wZnQ2OEFnT1owK3dqckR3NnNIOEZaYitaQ0NMeU1OM3VoWVhsWHAzWlVJ?=
 =?utf-8?Q?uv1WopyKxPx65i8IOSzxGGdu3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3C95905D0551F48B0CB49EE93BE3A33@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defd7467-a8df-4afb-c877-08dc9ef1c5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:00:42.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFLJ0Hym25IvrmajQFoqhElvpKVZWQM56g3Ik3LN5J4ZKVtpXVNqv/mDNZTupNNHGEm5ItYSO/0tcUAPInKWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7535

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDA3OjEzIC0xMDAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgSGVsbG8sDQo+IA0KPiBPbiBGcmksIEp1bCAwNSwgMjAyNCBhdCAwMzo1NTo0
NFBNICswODAwLCBib3kud3Ugd3JvdGU6DQo+ID4gRnJvbTogQm95IFd1IDxib3kud3VAbWVkaWF0
ZWsuY29tPg0KPiA+IA0KPiA+IEluIDMyYml0IFNNUCBzeXN0ZW1zLCBpZiB0aGUgc3lzdGVtIGlz
IHN0cmVzc2VkIG9uIHRoZSBzeXMgbm9kZQ0KPiA+IGJ5IHByb2Nlc3NlcywgaXQgbWF5IGNhdXNl
IGJsa2NnX2ZpbGxfcm9vdF9pb3N0YXRzIHRvIGhhdmUgYQ0KPiBjb25jdXJyZW50DQo+IA0KPiBX
aGF0IGlzIHN5cyBub2RlPw0KPiANCj4gPiBwcm9ibGVtIG9uIHRoZSBzZXFsb2NrIGluIHU2NF9z
dGF0c191cGRhdGUsIHdoaWNoIHdpbGwgY2F1c2UgYQ0KPiBkZWFkbG9jayANCj4gPiBvbiB1NjRf
c3RhdHNfZmV0Y2hfYmVnaW4gaW4gYmxrY2dfcHJpbnRfb25lX3N0YXQuDQo+IA0KPiBJJ20gbm90
IGZvbGxvd2luZyB0aGUgc2NlbmFyaW8uIENhbiB5b3UgcGxlYXNlIGRldGFpbCB0aGUgc2NlbmFy
aW8NCj4gd2hlcmUNCj4gdGhpcyBsZWFkcyB0byBkZWFkbG9ja3M/DQo+IA0KPiBUaGFua3MuDQo+
IA0KPiAtLSANCj4gdGVqdW4NCg0KSSBhbSB1c2luZyBzdHJlc3MtbmcgdG8gc3RyZXNzIG15IEFS
TSAzMmJpdCBTTVAgc3lzdGVtLCBhbmQgdGhlcmUgaXMgYQ0KdGVzdCBjYXNlIC0tc3lzZnMgd2hp
Y2ggY3JlYXRlIHByb2Nlc3NlcyB0byByZWFkIGFuZCB3cml0ZSB0aGUgbm9kZQ0KdW5kZXIgL3N5
cy8uIFRoZW4gSSBlbmNvdW50ZXJlZCBhIGRlYWRsb2NrIHRoYXQgMyBDUFVzIGFyZSBpbg0KZG9f
cmF3X3NwaW5fbG9jayhibG9jay9ibGstY2dyb3VwLmM6OTk3KSBpbiBibGtjZ19wcmludF9zdGF0
IGFuZCAxIENQVQ0KaXMgaW4gdTY0X3N0YXRzX2ZldGNoX2JlZ2luKGJsb2NrL2Jsay1jZ3JvdXAu
Yzo5MzEpIGluDQpibGtjZ19wcmludF9zdGF0LCBhbmQgdGhlIHN5bmMuc2VxLnNlcXVlbmNlIGlz
IGFuIG9kZCBudW1iZXIsIG5vdCBhbg0KZXZlbiBudW1iZXIuDQoNCldoZW4gYWNjZXNzaW5nIC9z
eXMvZnMvY2dyb3VwL2lvLnN0YXQsIGJsa2NnX3ByaW50X3N0YXQgd2lsbCBiZSBjYWxsZWQsDQph
bmQgdGhlcmUgaXMgYSBzbWFsbCBjaGFuY2UgdGhhdCBmb3VyIHByb2Nlc3NlcyBvbiBlYWNoIENQ
VSBjb3JlIGFyZQ0KYWNjZXNzaW5nIC9zeXMvZnMvY2dyb3VwL2lvLnN0YXQsIHdoaWNoIG1lYW5z
IGZvdXIgQ1BVcyBhcmUgY2FsbGluZw0KYmxrY2dfcHJpbnRfc3RhdC4gQXMgYSByZXN1bHQsIGJs
a2NnX2ZpbGxfcm9vdF9pb3N0YXRzIHdpbGwgYmUgY2FsbGVkDQpzaW11bHRhbmVvdXNseS4gSG93
ZXZlciwgdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlIGFuZA0KdTY0X3N0YXRzX3VwZGF0
ZV9lbmRfaXJxcmVzdG9yZSBhcmUgbm90IHByb3RlY3QgYnkgc3Bpbl9sb2Nrcywgc28gdGhlcmUN
CmlzIGEgc21hbGwgY2hhbmNlIHRoYXQgdGhlIHN5bmMuc2VxLnNlcXVlbmNlIHdpbGwgYmUgYW4g
b2RkIG51bWJlcg0KYWZ0ZXIgdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVzdG9yZSBkdWUgdG8g
dGhlIGNvbmN1cnJlbnQgQ1BVcyBhY2VzcywNCmJlY2F1c2Ugc3luYy5zZXEuc2VxdWVuY2UgcGx1
cyBvbmUgaXMgbm90IGFuIGF0b21pYyBvcGVyYXRpb24uDQoNCmRvX3Jhd193cml0ZV9zZXFjb3Vu
dF9iZWdpbigpOg0KL3Vzci9zcmMva2VybmVsL2NvbW1vbi9pbmNsdWRlL2xpbnV4L3NlcWxvY2su
aDo0NjkNCmMwNWU1Y2ZjOiAgICAgICBlNTk2MzAzMCAgICAgICAgbGRyICAgICByMywgW3I2LCAj
NDhdICAgOyAweDMwDQpjMDVlNWQwMDogICAgICAgZTI4MzMwMDEgICAgICAgIGFkZCAgICAgcjMs
IHIzLCAjMQ0KYzA1ZTVkMDQ6ICAgICAgIGU1ODYzMDMwICAgICAgICBzdHIgICAgIHIzLCBbcjYs
ICM0OF0gICA7IDB4MzANCi91c3Ivc3JjL2tlcm5lbC9jb21tb24vaW5jbHVkZS9saW51eC9zZXFs
b2NrLmg6NDcwDQpjMDVlNWQwODogICAgICAgZjU3ZmYwNWEgICAgICAgIGRtYiAgICAgaXNoc3QN
Cg0KZG9fcmF3X3dyaXRlX3NlcWNvdW50X2VuZCgpOg0KL3Vzci9zcmMva2VybmVsL2NvbW1vbi9p
bmNsdWRlL2xpbnV4L3NlcWxvY2suaDo0ODkNCmMwNWU1ZDMwOiAgICAgICBmNTdmZjA1YSAgICAg
ICAgZG1iICAgICBpc2hzdA0KL3Vzci9zcmMva2VybmVsL2NvbW1vbi9pbmNsdWRlL2xpbnV4L3Nl
cWxvY2suaDo0OTANCmMwNWU1ZDM0OiAgICAgICBlNTk2MzAzMCAgICAgICAgbGRyICAgICByMywg
W3I2LCAjNDhdICAgOyAweDMwDQpjMDVlNWQzODogICAgICAgZTI4MzMwMDEgICAgICAgIGFkZCAg
ICAgcjMsIHIzLCAjMQ0KYzA1ZTVkM2M6ICAgICAgIGU1ODYzMDMwICAgICAgICBzdHIgICAgIHIz
LCBbcjYsICM0OF0gICA7IDB4MzANCg0KVG8gcHJldmVudCB0aGlzIHByb2JsZW0sIEkgYWRkZWQg
c3Bpbl9sb2NrcyBpbiBibGtjZ19maWxsX3Jvb3RfaW9zdGF0cywNCmFuZCB0aGlzIHNvbHV0aW9u
IHdvcmtzIGZpbmUgdG8gbWUgd2hlbiBJIHVzZSB0aGUgc3RyZXNzLW5nIC0tc3lzZnMNCnRlc3Qu
DQoNCi0tDQpib3kud3UNCg0K

