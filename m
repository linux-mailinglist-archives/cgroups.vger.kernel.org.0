Return-Path: <cgroups+bounces-3593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DF92CAE1
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 08:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036481F238C8
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B42A5E093;
	Wed, 10 Jul 2024 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c0izVbhA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LdN3gaVi"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E717BDA;
	Wed, 10 Jul 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592358; cv=fail; b=RO2M8hlR2CH1wjPvHecQjMO6hAsZYl5d40qXEDhtf3+4jNld67MyLIDr/ZjBwKlQWamSkJO+AY0B4FdpCfYlHFbGOipALhA55KIRuIQljcWImRcGEgNWKmu4IE1uRG5dmvvrwJeTi9dWdTGs5NXaF9+UEu4bjNHjbG8H1vPmXrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592358; c=relaxed/simple;
	bh=flr211RZcM45Ol9S+tb6K9ATjdk5BzjMWpeBbuZrhIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WBaSn9sC5RCbhm2pEICH+xNpKkn46doPzNJpewPeBZaP4oO9W9ng7XQRWnyWb6zsXxuD4KYhfnDgFERm0nFFfs/MDWJHF9AVqGNQQnpWWC14vhJrH1+OFPuu2tUp96kpWHOeJyi8kaBn+3HT8VxvxtMr2LJppQhtFJXwc4kEt/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c0izVbhA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LdN3gaVi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5014ff923e8411ef87684b57767b52b1-20240710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=flr211RZcM45Ol9S+tb6K9ATjdk5BzjMWpeBbuZrhIc=;
	b=c0izVbhAQF6QMdXxu8ZLZ5B4ekklulO4Y5LamNkwOajtz/oisrrtt+e1jT3o0Q9LOmTBYTYLcooy23PhPjlu9DpTDWnTj/DPddTE3TnXw2FRUx7A/60UG7jCffVYmxjApIyxz2QZf5XJnCOqh4nqQWaKhRqevKU0QRWKMcFNXa8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:1e3f2b90-4fc3-4ec9-a437-c50a738779bb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:ace14dd1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5014ff923e8411ef87684b57767b52b1-20240710
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1719145060; Wed, 10 Jul 2024 14:19:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jul 2024 14:19:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jul 2024 14:19:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8J1jjK9JtIaRzt5sScWI6WH5hplPL52rP+Y1ux41dVIr6pbfZ+Q9tfA1sbSCO4Hc1/ro3uAA+64i9Qt3qOoEDa1O4fbj2oNDvEnvyXUefWwqsG+pwFWUvNkQHEN5T/d78qVpnf/rHhjtL41ygCD9olsWQJz81OxjkgbNeAKJRqeZvcL9LAksls6tn8WvW+GR5g1d7/K71674XnNKotuBnZcbfP8g39ImulSKPlYq7kFQTkKQbfwHaZMYYdJZugSIFq0GuQTLRN35UTSi0y/NIgCRWPcjzi4KyPn8UfAOXpay/fR0BsEoisyiGQ2QGbpXPItXkGo5eAtWyKtTyhj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flr211RZcM45Ol9S+tb6K9ATjdk5BzjMWpeBbuZrhIc=;
 b=T5A0g/lwlz8wxmxA7TB2rRI8Xd8Ap3YXzsgdIRwer7tdwqS5z100lxj5X9I8LVuKE2HUToIC8khRUHvC2c1ivryjyq37etjSF2u3RAj+sgHq7g7DL7raAbuDCx+jCIyNs8ua+dmKEvzyxCC5w09SLEme7NGm5N9DEBL8l+bjQU93PjduC4zcgVOYzWfVSt1w70/B8F6Omvi9K002gznyjXda+sJ7LUYIYiG0vUaxZnRfuURTgID7pq8fv+RFPUJHGYKKYrUxbmWMLdDlkTPKPsS5d2+fknklfigSyxNYWrVyVZdoNhvJmLRegeODI3ebZIhdqHcoJkNNR0kM2qHTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flr211RZcM45Ol9S+tb6K9ATjdk5BzjMWpeBbuZrhIc=;
 b=LdN3gaVifvBskXAdOon2hdZMQxwfQuqfEjwcyDaSs3XrK9Ub0W3XEdGAYo7klYfWSml+LCutDZiuZ2H5ATP+zkE78zTonLLpGPPyiHbnJ7aAMYAdEyVfvFK6hfcwt7iXXVJTmBoIbdDcNJcBHT29JQLhoSupWtGmsQiclt+MhTY=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by OSQPR03MB8553.apcprd03.prod.outlook.com (2603:1096:604:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 06:19:07 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 06:19:07 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>, "axboe@kernel.dk" <axboe@kernel.dk>,
	=?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "tj@kernel.org"
	<tj@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: blk-cgroup: add spin_lock for u64_stats_update
Thread-Topic: blk-cgroup: add spin_lock for u64_stats_update
Thread-Index: AQHa0Pn3X2b1kRsfT0KiFpEbrDOxBLHvgC4A
Date: Wed, 10 Jul 2024 06:19:07 +0000
Message-ID: <9cd28aa03c353234c3ece1778e8d221d5c101217.camel@mediatek.com>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
	 <8f3765db-842d-4568-9ac5-1bd9cab9e952@web.de>
	 <554f09bc6fc8f3b2a71b346f5e363950a1f8cb18.camel@mediatek.com>
	 <9d07628a-eadd-4e50-b7a8-02adb25981ab@web.de>
In-Reply-To: <9d07628a-eadd-4e50-b7a8-02adb25981ab@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|OSQPR03MB8553:EE_
x-ms-office365-filtering-correlation-id: 00b25ef7-ce57-4f42-052c-08dca0a83468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3IyeHlSem1oeUFjOEI1dVNjYXU1RUdPbTAvQWdneVdwRkc5M0lhUENsazkz?=
 =?utf-8?B?b1hFWWhmVHNMbXBCeXMyazNoK1lFeHgzUEdwUjRQcUpINitaKy9KdHNxNUdR?=
 =?utf-8?B?UW5XTGVKb1Y4aThoc0Y3K3pDOVdYd0hSL0o0TlBFNUF1MFhSb0wxU3dOOUlw?=
 =?utf-8?B?azRHU1VYU2tvc3VpV1l0a1BSRm1FbGxGVkJ1SXRLL3RHTVdCK0VBMFV2MzZa?=
 =?utf-8?B?bzlLaGwxMlZmVWJZWkFsRUVSY290L0J5L1RScDkveG5UYW9RRkZpVnNSR3Za?=
 =?utf-8?B?Q0M0eGRtR2YweFFGZjJsRzhMZ1k1NnF6T0tBc3pNMzJqNzRxN0VBNnJZRHN1?=
 =?utf-8?B?NmppSG9jZjloQ2xBQ1RBdTBhNzlLVWlpWThobDlnM3ova1lBSDVhNVp5bFEz?=
 =?utf-8?B?MnhqcFBIZzJFNmFuaGtheThrYStOU0NUandwRXk5QjU3eGFJN25BVFpENWtO?=
 =?utf-8?B?TkFMbTU5aTlBUGJvMHZrK1BRKzBOajAxYXp2dE91cExQUjlrSUJkcXFmWlpu?=
 =?utf-8?B?azV2enRhckZkNkx3NWxrQUJxYVBLcCtOU3RPbjM0STFwZ21jR0ZEbU12TXVx?=
 =?utf-8?B?NEowZ0VTWUdVTXhyVHhkODVKVzhEMWJsZTRiRmxMN05Yd0labmQyWjVEMjBC?=
 =?utf-8?B?cXJ3cFJBWmZXZktXcXlPZWd3eVRHYXBqK1Zic2dWaUVzdHdJTlhpQ0h3WTc2?=
 =?utf-8?B?MEFEci9tZG1GR2s5czJDeW14RjM2WlJmVHg1WWtubFg1ME1JQnBVQUkwVHI3?=
 =?utf-8?B?cHFhdTR0T0w1Tlh2ZXduRlpVWnYwcU4rSzlWbktRbGRSTStnTjU5VlBCVDdp?=
 =?utf-8?B?TGNLci9CVlZNbUVBcTJnWm5DaUtRc1hJQVRLYXZoajlnT2hWR0RMZkxONm9B?=
 =?utf-8?B?Q1FvZVlsL2dqOGZ4MnQ4RldLRmlqV3BrNGZBaUp3ejNBb3U2MmQ4amZOeXJo?=
 =?utf-8?B?ZUZQUkpPblhleW9aTHQ3SlJ5VmMwcE1KckhTbzBCRDhTZlFuS09jSDg2dUNC?=
 =?utf-8?B?OTZBM0pyNHFGUW5LZEFwNGdyZmF0bnRPdktVQW9Xa0g1K252WlFod2pzeDVE?=
 =?utf-8?B?NlY0VHZ0SElaNGRDSGd1bDY5MWtScEgrUE5CSHNNVHJUWG94QXc1NDhYcHFl?=
 =?utf-8?B?anp4RDhmUnU0bm9EalFGTlFveVpVV3JMOFpHTW9FUXJDelFUSm9INklHQVN5?=
 =?utf-8?B?QVFTbkwrWG5KNXNyVGJWMnBQMnZFdHVLWC93MnI5akc5bGlra3Y3eDBpT2Qr?=
 =?utf-8?B?Si9HRUNhLzRhaDFvWG1UZUppcWhXQUNvZ3FPQTZNY0JhTHBSRzE3WVdTU2o1?=
 =?utf-8?B?RHNwS2dMeTc3WE4vSlhpVFZDMnBTbG9uMm5UZ2tsSk40SjI1YmtvYnQrMDZi?=
 =?utf-8?B?TGRKa3ViWnQzaGRKVU9qdlg4aXVRa0RBeWRzTTFNUW5GVVdIb2todk16Qmdj?=
 =?utf-8?B?WWlEUEVBTDFsL2ZPdHhkYTEybCt0VEFMSHRsNExldUlEaEdlaS9POUg5M3dH?=
 =?utf-8?B?Z0l1dy9YWVI3dm45UWVPZlpFeDRLOTFkUzlQSVNmaEU2blhsdjUvYTRlVUxH?=
 =?utf-8?B?VFFoTnc1bCtlL1YrUElUY2R3UHZ6dXhZTWhUOG03ZGcxYXIySks3OGJhd2h3?=
 =?utf-8?B?c2UvUmRIZXlvOHM2ZHdRZXZLOXVFSjVkU0tRanIvTS9XeU4zdzlrZ3ZsbzYz?=
 =?utf-8?B?RkszVk1keTY0dHhqUEovY2xTL1NzSlYzYklBQitvYzNjK0Jka29SRTdJYUx2?=
 =?utf-8?B?Q3Q0eEJRenh3bWc1VFN2MDRDZ2tCa2Izc2pjOHpBTTdpVmRUMjB0RWU3Q3lX?=
 =?utf-8?B?TkFET0IyY1pNdFFSMVJ1N05QS2JpUFU4VWEySmFUeTRZV0FwMzQwSmVyS21o?=
 =?utf-8?B?UE0raHh6dWMxajl6MzRUMUxlNkdaSzZwN1RucHVvYzJkNkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWhOcVdIQlZkaFpuTmgyQ0Z1bEp0S0dJK3JjOUs2bUNjc0JPVmxtT3BYVnlM?=
 =?utf-8?B?bmozWTlFWjc5QW9ZNU53aEdEWDQrLzB5S1ptbVRxOS8xTE5XREhsQ0RYQkNP?=
 =?utf-8?B?VlEvZHFPNTZobzFWdCt3bktCQllVS2ozOHJiNHBFQ0I3SXN1Ti9VUkJmendG?=
 =?utf-8?B?V0ZaVVQ0Q3ZNeTBUQXk5OGZmVmZuMUZPRXlsQjVIcWMrVjFJbVVpcm5WS2JL?=
 =?utf-8?B?aUhMNWZoa0VMRXhETUpUWStmVEhyb1F5RkppTEZzSWx3c3lkZmhFK0FnaDRx?=
 =?utf-8?B?N1NrTjAvNVc2U1VBUVdCVER1YnZqbFRnYkt5L1VnYVRXSmFONGt3VDVnQ2pU?=
 =?utf-8?B?WElNWFhQaVVvMDA1YWpQWjh3TE5mb2Y4Smhlb1hzZWpMaFQyYjFmWDBWTG54?=
 =?utf-8?B?OGM4YXlzUWh1d3RPTHFCNytka1J2UW55MXpaajc1MWtkeHVJQi85L2wvZUtV?=
 =?utf-8?B?VlAzTWhXZFF5Qk5od3NKa216am1HUlpYNWllOWpFTmVyQlNDZWNwcGFtaVJr?=
 =?utf-8?B?eVRwZFdsQ3pGL2QzVkNKdHpFeHUxb05KVURoTDZlM0c5eE4wdVNvaHlpUEpM?=
 =?utf-8?B?bE5yT3djOXR2UVRuMlZndjBPQlBWMTk3N3NYaUN6dm50VU1JanJRNHB3N1U1?=
 =?utf-8?B?bm1qQ2M1RUdsWjlOdkMvekRPakoxZU4yR1hWWDlwZ1NEN2RYdUJ5V1Y0UG5W?=
 =?utf-8?B?eTVKS2VFRTNhMXNKWDJYSXM2Zk5mbzJmWFlqWWx3ajQ2dVNDTVpOWDZCL1hn?=
 =?utf-8?B?aFNKQUh4NUxKRWdYMzBLM2Y3VDNDeEdySTVEdWk2MTNINGJSRXc4UllxNThP?=
 =?utf-8?B?aElvc1FMU1dkM25FdUl6TnVhVS8xZGNIeVgxTWxqU290Ujd2bDUwalE4YUd3?=
 =?utf-8?B?M1RCeW0wdC9VQ01sWUpycFBTNFR4dkpUWEw1Tit4UDJEcGh2YzVPUHJXR0Jr?=
 =?utf-8?B?Nm1BUUtaNjBWZ0Z4NCtDVFlkQXZHYzBORVh0Mis4dmtYa3F4RmkxSlpFRVhV?=
 =?utf-8?B?THEvYVZHL2hTbFBpQnY1ZkRKbHZoVmRndHd3aE5JbVR4d0tnMDBoWXNtVXdK?=
 =?utf-8?B?elI4STFlMTBMK2Q2KzI2VWUyZHBxdXliZEhwdDljc2E4RklQUmNsdE9YNVh4?=
 =?utf-8?B?VHE5S3pqYzUwelYwNHNPdEZQZHZMQjhZbUIxSFE2QTZRbEFlb0w1bVVkZElx?=
 =?utf-8?B?dDNhTDhXTld3dFZUZGVQUDVIanJjOGJyYzgwTjFhQy9KWG1iL2NlU0NzU1Rq?=
 =?utf-8?B?bTdESEgxYkpzS2VDV0s2R2sra1Y1b0xQSk9DY0I0dEF3RTJJVSs2V3g5cE9z?=
 =?utf-8?B?TDBQd202bDBUMklMakQ4TnhUWVdOOGU0bHNzMVJmKzNlVEhTeWh3bkxTU2Rp?=
 =?utf-8?B?aS92RDhnUzdSOXNheXFuQWdNdy9aUnhqL0R5NGVvYjVzNFZkMzdGaGp3QU55?=
 =?utf-8?B?MEMwL1p2VmxBWlQ0d1kyQ3ZTcEo2a1lINzVON0RJU0VMUm01ejhTcVpXblFu?=
 =?utf-8?B?TU1STG1lWC9KS1M0MjRsL08zbXhZSjNUSitEM1cvNWFPZmo5UnoxOVNvMnpK?=
 =?utf-8?B?c1RzY25oVW4zcUFheWNvSUJDSHlJcnhKU0dERTh0YUZ1Y1BtdHRaZ2pYWTBu?=
 =?utf-8?B?azh4bHVBZkZNdU44bCtqWDJydkRKVTEyQ1BScng2MmtxNUNWTGFZdDFvZWk1?=
 =?utf-8?B?Z2xsUGZ6MkhOa1p4UFovbnlUaDkvZHN0TUgzVU84T1ZWd0FBVEk5WFEzbzRr?=
 =?utf-8?B?emJnbGFnTFhwZXBMMGk4SHp6dWtaUHFUOXF2aE44b24xaDdmWC9uUlpFVlJx?=
 =?utf-8?B?NEpFcjdZVk8rNS9XYXMycHZybFVPbGRKWWtaanltQXlaUmpLTzI2QmFjNTJ4?=
 =?utf-8?B?RDE4NXB2cTB2Slh3S1FsT1FlRGxmZEY5SFpBY2lpMXBoQVNKdHFXa3hOOENC?=
 =?utf-8?B?ZTdBaEwvUEtNdjAvaTg4cU9iMExNWWtNSk8rQVdzUUlKdWtZOUlPUXV2UXZP?=
 =?utf-8?B?RFBtRE0wMmZzaXB4blowbXNUYWdHTVBNV3FpTlZoY3ZmdTlubmZsQTZVVnNC?=
 =?utf-8?B?bE96SU1iS1cxMVlIaUtqUFJRM2JFOGkxSkNBZFQzRzlUMjdKaEtPUTRrR0xP?=
 =?utf-8?Q?OAcpTnpfCQayaeUPOO6hQxQDj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <554E8CC8F3CF384BBF8789E331B6C4B9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b25ef7-ce57-4f42-052c-08dca0a83468
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 06:19:07.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzzUXn2fp8YZRmS9Aloudxt9MuZCgN3Mx4bqG1Zl1TYZPVy3M06Lpt+HH+7xtQTHtcb7GLmb9i0g+uLQZkOgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8553

T24gTW9uLCAyMDI0LTA3LTA4IGF0IDA3OjQzICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICA+ICoqKioqKioqKioqKiogTUVESUFURUsgQ29uZmlkZW50aWFsaXR5
IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KPiDigKYNCj4gDQo+IFBsZWFzZSBvbWl0IHN1
Y2ggaW5mb3JtYXRpb24gZnJvbSB5b3VyIHBhdGNoZXMgZm9yIExpbnV4IHNvZnR3YXJlDQo+IGNv
bXBvbmVudHMuDQo+IFN1Y2ggaGludHMgZG8gcHJvYmFibHkgbm90IGZpdCB0byBjb21tdW5pY2F0
aW9uIGNoYXJhY3RlcmlzdGljcyBvZg0KPiBMaW51eCBtYWlsaW5nIGxpc3RzLg0KPiANCj4gUmVn
YXJkcywNCj4gTWFya3VzDQoNClRoZSBlbWFpbCBzeXN0ZW0gcmVtb3ZpbmcgZGlzY2xhaW1lciBp
cyBmaXhlZC4gQ2FuIGNoZWNrIHdpdGggcGF0Y2ggdjIuDQoNCkJveS5XdQ0K

