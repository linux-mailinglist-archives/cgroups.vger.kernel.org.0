Return-Path: <cgroups+bounces-3607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0392DE57
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 04:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7501C2172A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7ED51C;
	Thu, 11 Jul 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r1QmLkDs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SrepWkyP"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002DBE49;
	Thu, 11 Jul 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664742; cv=fail; b=D+BgxxnXRor/TlRPNMgux48p3qlwa9IAR/3t3Tarth/WlUbXtqirqi5X1arMFb35finUuh5ELfci//CJXDQU1FozO6T2w5KmI8DS7PySf51rsifvECgH//pXZfp9W4aMgDtCOf8vx3efPEM6W1dd0rNeqA0l45tzC79ORE/13f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664742; c=relaxed/simple;
	bh=2cJ6Iyd7Lvr2Cu8M0VpfUvKfjceF2TCjVtDuadnMuUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VMA4OHKbWjRTuQxTaJA/47eAjCdBK0ow8Pwj8Na88G8VJ6Vv5wuBzXxJn4Z0zyPcKp4cDEg4xlJ38TAj2o0QiGt9fT/tiHpatoL1R8LXtnfpVeo15HGK6ZvGniq4vgJjA2gcnn4BQ18hazn5M9eIwHY3TFXzTfqcB11eInsFEk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r1QmLkDs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SrepWkyP; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d975af543f2c11efb5b96b43b535fdb4-20240711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2cJ6Iyd7Lvr2Cu8M0VpfUvKfjceF2TCjVtDuadnMuUg=;
	b=r1QmLkDshPZnygJt9ooJ20jFfY/nMd2VfjNA59iinRmzB30ETZcmtonT1gSe/BHEYzqJj7SfnjDBCmRVHxPGwLUw9cIhtDU8u3KeC42wtjmEkRRB5maKRyBMvoxkm8fymAeFwgvZ5DitocmIC6dDe6oc8AeX5p+DpIE+jXKt2Mw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:2729b6c7-5d61-413f-bc3a-6572901e32a2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:84522845-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d975af543f2c11efb5b96b43b535fdb4-20240711
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1810218930; Thu, 11 Jul 2024 10:25:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Jul 2024 10:25:31 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Jul 2024 10:25:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2Fq9qhnMayCw0jPN0/P9uG2G+DSPtd5d2Lc8URr+el15O22Hx3+McqN/FULul2+DDdqqXlKI1ge2eUkXNSABd179libbgJ3BcEcCdG8k2C4Ssfvjs43Itk9Ms1fRhHRRqWFRIgZM+P/t+JPo2bIY4QcEzvYd0ZzvAlujxyFDOU1bmp9NXU9GfmuVX7nUp1c+Lq/7AEE9G+puZI2WIjior7Ip5qLosW/6eOj4PFrPgWtjUeLbdzqn3WkOVMA5c6R23+f0GFWn+GCdMbQsF+hX8vDUQtEfO9Bx+lZIzln47fxcAASG2U51yFhJ18J52daHUxnKZMoX0h9TCMlXsqgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cJ6Iyd7Lvr2Cu8M0VpfUvKfjceF2TCjVtDuadnMuUg=;
 b=L1GekGE3meBZPo5OdUWNEqKbhS8ltvXX2tFBSYxLaYT2WsHfrUi/tQajRiVxn9W3yBapi8HiqAP4eJNWMXYdonvYmZosD/xuhqymvVq5BKV/Z/7mcNraYBr3vFg+c+UuWvfrru+ptT+vvg3+nnzzV7cq9iW1thJPwq3UDzVk7uF2x4Tp+DDbBxjgsY46X0FGZfOhX7l0PqxQeHk+kxPP/iHad1HXIQmRx/jg2TMgFtTNu7ZWWaCsKDFv/Gt53sPf3MR54VOhxY1RNjLo5aRFKWtzQ+n8GIhaN/DCyhA+A4e7ALYEKYm1bFEWyeuAZAV26SUBbMEHU5jwpn9G/UZGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cJ6Iyd7Lvr2Cu8M0VpfUvKfjceF2TCjVtDuadnMuUg=;
 b=SrepWkyPW1mMUaNqGK3uLr0iSAZzQq2BElCj8DUFlLKN3sZHKDWzDedT6PuesK+lEoYJh2mVJQjRr/m3p39UIE5uXpj7esnnTfagdIZ0d0ldcnnCMX2btIPY/8VgMP9dP+/4Bq6Rl/Ckth4KbALBtZa+r9056ljLJRyZ2qu0rPs=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by TYSPR03MB7739.apcprd03.prod.outlook.com (2603:1096:400:42e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 02:25:29 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 02:25:29 +0000
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
Subject: Re: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Thread-Topic: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Thread-Index: AQHa0pBR30AINLT9pky6tv6t6Zyx7bHwh18AgABGsAA=
Date: Thu, 11 Jul 2024 02:25:29 +0000
Message-ID: <6114fbad7bce9b15806bb9fee25a1075ecb53dd1.camel@mediatek.com>
References: <20240710061334.1888-1-boy.wu@mediatek.com>
	 <Zo8HTD2AD-b51q0C@slm.duckdns.org>
In-Reply-To: <Zo8HTD2AD-b51q0C@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|TYSPR03MB7739:EE_
x-ms-office365-filtering-correlation-id: 1cf5830d-8322-45b8-9ed4-08dca150bb61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RkNzOGVuOVgwcGowREF3UmpTQ1pyTFgyS2JabGtVSFFiRGxPblh3RExZQTBq?=
 =?utf-8?B?RE54SzQ0K1VkdnhCaUNMQnhJaHZ6cWhLeDJjUm9MKy9RSmZiWHA4SzZBVEla?=
 =?utf-8?B?RCtPZlNrejFlMDQzWk5yMmtFUDcwRUNRTTdiaU5PTlhXclZ5K3B3QWNNOS9W?=
 =?utf-8?B?UjJOTXhITnJKTjZ5VDNhMFl6NncyV2pKUmJuaEw3enVoZnl1QUMwdlJTZm5y?=
 =?utf-8?B?WDFjZ2daTzByZHBTbERCaFhVc205TE0wWkdjZ2Y5VXErMzNVaEttMUxTRk9j?=
 =?utf-8?B?dnZjazU1TDkrYnp3SDhKT0Z0RDRMbGFXaTc1TGlzcVg5UjFWWVd5a3lzR1Yx?=
 =?utf-8?B?a2FNNFdTcVlUTWRqSlZ1RG5teEE0S2NDdG50dEZvSDYzOGliQUNjV0ZGUlB5?=
 =?utf-8?B?bTl0SFBER3BGbnhYamtVeFNJNVdKMUxwbzZacFpOdWxhOFVhK1VBVTcvdG51?=
 =?utf-8?B?WkluRE8wci96MjQ0Q2VIcUYvQ3JReU9MMXlPd3RuV2lBT3ZhWG16SzVvdVFF?=
 =?utf-8?B?TmoxS3FSaG9hY3JUSWQ5WEtOdUxuMU8zRW11TnZQazFpWGFsbG5qNWpIdU9m?=
 =?utf-8?B?NFJUMkhFZUFGZy9XTnRqNHhpTUl5VTZvS091UUNrS1M4U2x3K1E1ajUwZ21r?=
 =?utf-8?B?MkdrMzBzelJIN1VzU1dCOFNObEpkYkptMlc0bmJJNWxmUzFNOEJxOW1JQ0xr?=
 =?utf-8?B?M2ExTUpFS0tXVVUxQklDVTRBd1NtdDFKeUp2aWY3REU0RWlTeFpzWlBzb3hz?=
 =?utf-8?B?NWtOL2FiOWg3Tmp5Z1F1SU1KWHVxRGFNS1dCV2hwbWdFdTc0WnU2ZUtQVGZJ?=
 =?utf-8?B?VFBGb1laOVNpSE1RNS94SE5KTzI2ckljelgwTHFUakZTZ0hHaVhvdy9STGFV?=
 =?utf-8?B?alN1TmtEdmxLOWsrbVJ1QWV1TVBOL2FlaXp5aFVnQk9hUVNVc0tvZStna1Zz?=
 =?utf-8?B?WVdQanN1WHVXVmlyY1BIY0FTZTdEcE5obFUyQ2IrZFd4eVFFTGI2NGZZM0dM?=
 =?utf-8?B?ZUsybDhSVkFCQkUxcDF6V2pYMlVvUzg3YlNRSFZoNmFVV2t4S2FYTm5VSTF4?=
 =?utf-8?B?Ri9DeGkvNmo4Unc4dXJ3aHNXZHVEYnZFNWIvcEJHM3c2eVFmTmRyUks4M3M4?=
 =?utf-8?B?QmRuK21YQ2pxaWNvM2JCVW9UTGdxS3hCeUgycU43L253OXlJWEdLY1V0aFFm?=
 =?utf-8?B?L0xicjJGbzlodEIzMEQyeXVnSWkyQ0JDMHNZR1RRb1ZwWFlkbWNtSW5vdGVR?=
 =?utf-8?B?MlNCdTl5Qm9uQVpmSVVwWG1KRG1ORjkySXZyQjhuYk5PUVE4Rk9IeDFUZXBz?=
 =?utf-8?B?dyt1WGoxWUM5REtvVmM4dkQ3cDZyRzBSZ1p2MUl5YjFmTFY1L0szTDVpNnZr?=
 =?utf-8?B?azJlT3NiOVNyVlJXd0pnQWVPUWc5cldCeHMzTDVjTksxditZZjZTWnE5VnN2?=
 =?utf-8?B?c2I0dzJUTVorQzRONkJlUjA3QzJJdVgzSnJDcFpxdzJUKzVxUGZSR2IyaCtt?=
 =?utf-8?B?NDU3SWg2eHRNTGFCOGJKaXlEN0tYelJHTzBxbkx3TFpDeXhXVFl4NEhoL21X?=
 =?utf-8?B?Ulg1THZKUHY0L0tQUTIrUENFSVVkQkRXMkhWN3NWd1ZOQnMxZjB4NlJKM3hO?=
 =?utf-8?B?dnNFVVAzRm91VHVRYm9oSThaZUlaRVU5azhPQm90aGZtU21vdDBMeHMvSk9W?=
 =?utf-8?B?a1FEOEZVaW53Wis5b012MlNnMjRGYmxvS0l4T21oMjBZVlhBbmxtN3UvUk42?=
 =?utf-8?B?ZUYvbUU3R2J2QnRZb0xXMWk2bm9EMlpuU1dZdXQ1Z2xrZG5aQ1MzWDcvWEdk?=
 =?utf-8?B?blUrbm9CeU5jZFFReFdlckhzZk9KZ0pjU3J5bGJ0aVgxUDBiS1MzQzRMT1RN?=
 =?utf-8?B?WVpGVHNqWWtvTjB5NHVySW1EWmllb0w1MXdSZDZQaTFjYUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZQQkNmZTJ0TGxIVDNJRXNjSzE5WjN4ZjI0c0E0SjFod1pzYXNCeHBDL3ZE?=
 =?utf-8?B?QWN5VVozK3RjTDVFSklmZ1lyYVh0V0JKTTJMalcvOXoxK1BDb1R0WTk0eUw2?=
 =?utf-8?B?YkFTTHU3d3NvLzk0NnAzZHlpa2JmcFBrWFRGUzdkamwrZE90bUhITU44S1J2?=
 =?utf-8?B?b1duOTg1NWF3cWN6d0FPeEZQeGNyWTg4dEtySWZSQ0NrbUdZSHpPTUE1Q1RW?=
 =?utf-8?B?T2lXMFdaR1l5N1dCcU5UTkw0UzdISzk2LzdtUW9KS1dacTJBd24zazlRUy8y?=
 =?utf-8?B?ekNrRjUvYjduQUg2eU14bU9sMjJMMk5xNkd6YVovTFVLWm9aeHI5NTNlUFN1?=
 =?utf-8?B?UVNIRFFkK0gvVGlIZlVmYUJZbGRBbW9kbmhCK0REL0RXSnZNMW9ac3FNeDRq?=
 =?utf-8?B?OENyZ2kyYkpFL0N1S3dNQkw5OE1Rd09ueGRKMTZ5T1phR3c3NHV3U0lYL3VH?=
 =?utf-8?B?eE92c0JLWDBlYzdWakdrVDNPTmRoZ0Q3cDhhdVlIdE1LK0dFUEZwUzdWMW51?=
 =?utf-8?B?aGFlYjNWYTRMT1pMMmxtQ0s5SG14RnlCRmp2dGZJNWRROFV1TnpFU0M1Mmxm?=
 =?utf-8?B?VVpSQlY3UDNNUkcvaUlUajVDN3FsQ2FOc2FSaDhPcVJ1Q3ZTOUt5K1BXalBq?=
 =?utf-8?B?U0FHUlBzMXY4VWZ3NU1RaVdWVVdGY2RCcVRaRWhpd1ZaZWNlT1p4TVpaVkdO?=
 =?utf-8?B?QzBta1lPZXBjODlMR1NqU2c0RkcyVnlSejRxelZIWEFBNnNWNkxlUGxpSDFC?=
 =?utf-8?B?Slh1M2Q1SUM5eDZTejd1MVMrTGEyUXk3dDduUW00Nm5VaWlpOWhQTzRMY1BD?=
 =?utf-8?B?WGdEUGZwcnJKTkF3MVJ0Nm5jUVFnWXJOY3dJYzZ2bytHbnh4c05xRFYxUlk1?=
 =?utf-8?B?VkIvT2w2YnZlU2REMGZSWmd5YkM3Qlc2Kzc5WG96QXRZczA3YXZibGFydEQ3?=
 =?utf-8?B?SHEzMjdEVkFPdytBb2Y0cm9lTlBhTWlRY3FpWkxqS0xmaWk1TXVhbXdIQ0o1?=
 =?utf-8?B?cmJEeWZiaTdYU3hmYWtwTWFqVW9KWUd0NVdpaDIxeU8yTXZ3U3BrVE5TYnVE?=
 =?utf-8?B?TVA2ZGw3elZUa05zeldKRkVsUFZxay9pc2cxKy9UTUZPRS9sUW96YlE2ZnR6?=
 =?utf-8?B?TkRRaHFISjBqWTBocjRLTk5mT1NhRTR3UWQvQy9YODlDV09tNkxpdXZ0cllM?=
 =?utf-8?B?clRjYkJBT0kwZ3Z2ZmdIUG9CdFl2dEVYSVZwUElBQjVVVlVUNnd0NnI0YnYx?=
 =?utf-8?B?R3R1TTJybDFhTC9HLzEzdjNSazhpeXloR0FVWVY5a3FhdHVFb3E3Rng0M290?=
 =?utf-8?B?anFGd2hhM2ZwYUYyVGRlVUg5aVo1amhhOWFQdEp5ZGVVZFBBM1NUTmtRQmZY?=
 =?utf-8?B?TFJIejVsQnpVOUVVTzBRQ1RNOWJZT2lzZVNwSDB3cklDMzYrSjR1MTRWK3Mv?=
 =?utf-8?B?UUlGNWJoUlVXd29pclhzRUttNmxibVBldE5lMnFheTR2QkJtOEJkc1VPaU1L?=
 =?utf-8?B?bDhiSlZwWitiU2tvUStLUGFaK2hFWlJ4OGFXZXV3VmZHSmFRdVNEbWxneDdF?=
 =?utf-8?B?dmtBNlhKSWptUHNCbEZjYi82TlVqZkJ5K0pTTGdwdUVEK3gvY0FlT2pQcXBI?=
 =?utf-8?B?TDJUNytuNUJNODNsSzBJaFllbHE1R0VUaElKcGxhYzdjWnNzR29udTJUemli?=
 =?utf-8?B?SUJZWEpzdzZaRTl1RkRZcmt6dzlWM0pIWlY5MXBmSlpIZVFGd1lBaXdZdkxN?=
 =?utf-8?B?Q25hNGwxNFhOa1ZJb2xnalB1MStHZnNsei8wZ0JsenFkeWlNeGp5VHB1dmhW?=
 =?utf-8?B?a0I0NmVBRERhN2ZWUStSVkhOWHhvb1FOcnBjNlFSOHdGV3c2OFVRVGVsRUlz?=
 =?utf-8?B?dEFyenp2cnozT1Y2ZW5ydldIbHQwSXRhWElCWFlaeTB4bjlva0p5bTdZWlFu?=
 =?utf-8?B?OVM3Uk5DRlJxTG1vcmM1NjZ0QUp3cEo3TndmOVpvV3ZGWEQ4NE9Hc2RYR2lr?=
 =?utf-8?B?alJJUEs1TlBpcWNBek9FeG1zZVU5R3pmTEREK1BLK3d1dk1rSEJUNUZqL21o?=
 =?utf-8?B?VUl0c3BhaWgrbW9PV3lFMnY2LzRlc2hOeldHczNXRFYycGdkSHJWZDlXRlMy?=
 =?utf-8?B?a0FnMkw4MmxmWDBJSThNSzR0UUpZNkoxaE85RzhXMlkzazFtMm45dldIVE53?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32A76A652A6D24784E50560DDB04E52@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf5830d-8322-45b8-9ed4-08dca150bb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 02:25:29.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjQ94PH3wv8erlFzASeh2r/H81g80AkrnUZ5deM7JA1YYdmjDq51YqllnKhHi1oae2qs1WAlJ8CE/pSAnXybVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7739
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.959200-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpGpaLcbZyfwA9lly13c/gF+Mk6ACsw4JgqiCYa6w8tvG0m
	bV40iq4548KYoXzhzGodWJS1n0O5+fa1p1ynKVeDhuXUWQoMQt4iuaoNXJrK/Vo+424uIBNLLJW
	h+/6PrD8OsTQEt61AlW46EYm5LvvD6eJVowF9Ts+i9l247YAX38rPh3yI68clQTWaasNJff9v1a
	CEawbZWJH/wDreljX8To7gobHptohnsS71Oo/Hw5gCHftmwEMJ9LQinZ4QefKU8D0b0qFy9mTDw
	p0zM3zoqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.959200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0FD7754B973EF548089D6D6400A428365CC1285EA7422FD4A70302A323D4D8E62000:8

T24gV2VkLCAyMDI0LTA3LTEwIGF0IDEyOjEyIC0xMDAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgSGVsbG8sDQo+IA0KPiBPbiBXZWQsIEp1bCAxMCwgMjAyNCBhdCAwMjoxMzoz
NFBNICswODAwLCBib3kud3Ugd3JvdGU6DQo+IC4uLg0KPiA+IEBAIC05NTIsNyArOTUyLDYgQEAg
c3RhdGljIHZvaWQgYmxrY2dfZmlsbF9yb290X2lvc3RhdHModm9pZCkNCj4gPiAgc3RydWN0IGJs
a2NnX2dxICpibGtnID0gYmRldi0+YmRfZGlzay0+cXVldWUtPnJvb3RfYmxrZzsNCj4gPiAgc3Ry
dWN0IGJsa2dfaW9zdGF0IHRtcDsNCj4gPiAgaW50IGNwdTsNCj4gPiAtdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPiAgDQo+ID4gIG1lbXNldCgmdG1wLCAwLCBzaXplb2YodG1wKSk7DQo+ID4gIGZv
cl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsNCj4gPiBAQCAtOTc0LDkgKzk3MywxMCBAQCBzdGF0
aWMgdm9pZCBibGtjZ19maWxsX3Jvb3RfaW9zdGF0cyh2b2lkKQ0KPiA+ICBjcHVfZGtzdGF0cy0+
c2VjdG9yc1tTVEFUX0RJU0NBUkRdIDw8IDk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLWZsYWdzID0g
dTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZibGtnLT5pb3N0YXQuc3luYyk7DQo+ID4g
KyNpZiBCSVRTX1BFUl9MT05HID09IDMyDQo+ID4gK2d1YXJkKHJhd19zcGlubG9ja19pcnFzYXZl
KSgmYmxrZ19zdGF0X2xvY2spOw0KPiA+ICsjZW5kaWYNCj4gPiAgYmxrZ19pb3N0YXRfc2V0KCZi
bGtnLT5pb3N0YXQuY3VyLCAmdG1wKTsNCj4gPiAtdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVz
dG9yZSgmYmxrZy0+aW9zdGF0LnN5bmMsIGZsYWdzKTsNCj4gDQo+IElzbid0IHRoZSBwcm9ibGVt
IHNoYXJlZCBhY3Jvc3Mgb3RoZXIgYmxrZy0+aW9zdGF0LnN5bmMgdXNlcnMgdG9vPyANCg0KVGhl
cmUgYXJlIHRocmVlIHBsYWNlcyBmb3IgaW9zdGF0IHVwZGF0ZSBzeW5jLg0KMS4gVGhlIHN5bmMg
aW4gYmxrY2dfaW9zdGF0c191cGRhdGUgaXMgYWxyZWFkeSBwcm90ZWN0ZWQgYnkNCmJsa2dfc3Rh
dF9sb2NrLg0KMi4gVGhlIHN5bmMgaW4gYmxrY2dfZmlsbF9yb290X2lvc3RhdHMgaXMgd2hlcmUg
d2UgYWRkZWQgaXQgaW4gdGhlDQpwYXRjaC4NCjMuIFRoZSBzeW5jIGluIGJsa19jZ3JvdXBfYmlv
X3N0YXJ0IGlzIHBlciBDUFUsIGFuZCBJIGRvbid0IHRoaW5rIGl0DQpjYXVzZXMgYSBjb25jdXJy
ZW50IHByb2JsZW0uDQoNCj4gQWxzbywNCj4gbWF5YmUsIHdlIGNhbiBqdXN0IGdyYWIgdGhlIHNw
aW5sb2NrIHdpdGhvdXQgdGVzdGluZyBmb3IgMzJiaXQuIGJsa2ctDQo+ID5pb3N0YXQNCj4gKHVu
bGlrZSB0aGUgcGVyLWNwdSBjb3VudGVycGFydCkgaXNuJ3QgYWNjZXNzZWQgdGhhdCBmcmVxdWVu
dGx5LCBzbw0KPiBrZWVwaW5nDQo+IGl0IHNpbXBsZSBhbmQgY29uc2lzdGVudCBwcm9iYWJseSBt
YWtlcyBtb3JlIHNlbnNlLCByaWdodD8NCg0KSSBjYW4gcmVtb3ZlIHRoZSAzMmJpdCBvbmx5IGRl
ZmluZSwgYnV0IEkgdGhpbmsgd2UgbmVlZCB0byBhZGQgYmFjayB0aGUNCnU2NCBzeW5jLCBiZWNh
dXNlIHRoZSBzcGluIGxvY2sgYW5kIHRoZSB1NjQgc3luYyBzZXJ2ZSBkaWZmZXJlbnQNCnB1cnBv
c2VzLiBUaGUgc3BpbiBsb2NrIGlzIGZvciBoYW5kbGluZyBjb25jdXJyZW50IHByb2JsZW1zIGZy
b20NCmRpZmZlcmVudCBDUFVzIHVwZGF0aW5nIHN0YXRzLCBhbmQgdTY0IHN5bmMgaXMgZm9yIHVw
ZGF0aW5nIDY0IGJpdHMNCmRhdGEgYW5kIGZldGNoaW5nIDY0IGJpdHMgZGF0YSBmcm9tIGRpZmZl
cmVudCBDUFVzIGluIDMyYml0IFNNUA0Kc3lzdGVtcy4NCg0KPiANCj4gVGhhbmtzLg0KPiANCj4g
LS0gDQo+IHRlanVuDQoNCi0tDQpib3kud3UNCg==

