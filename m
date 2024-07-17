Return-Path: <cgroups+bounces-3723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03186933583
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826531F236F6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 02:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FF4C99;
	Wed, 17 Jul 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QOZvHekT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WNh8QEYE"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106633D8;
	Wed, 17 Jul 2024 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721184052; cv=fail; b=fdFZGTaRhTrnGK72kCWxr1iAiQKgYgKf+k0MNuEwuB77sULHWqi0nXMCro27vHnzd++0yWqkAJHivJUgjSZfFM+rmo75pPok+Nv7qFOODr/u8vBtD57APzB4X1PfxiKd7zSsitsr8nGtnvQVFPwegVtwCTr8oo+oivH6E+vHB/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721184052; c=relaxed/simple;
	bh=r4NLsSmXf9PWJ4QOmNt1+/Md2rWmcCedeoojrETn1ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nEM8oGXRIIDe9RaxJMilhv9iNR64UFWp7c/WKSX29K5gl2LeucASunzveUEjwU8FtKalnrGZl0JkKGRVIwQlGcJxqYALKcf4Y4NVQyAX4ZqmAciJJQzNqfvv2QK96JJJSiuO3mkgSN2VrvA+K3Ikni1He7qgyb57/D9LO3oOS7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QOZvHekT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WNh8QEYE; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dbda234a43e311ef87684b57767b52b1-20240717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r4NLsSmXf9PWJ4QOmNt1+/Md2rWmcCedeoojrETn1ww=;
	b=QOZvHekT/5K+jBhk+u2ynBjc4uNgETr7VPVCzCYrGplcT8Wpq2tfNV48GL1XTJe8wa3mkFLKlf5n0tdRgesaW+V1Ca604sUeVbuFT8HNSYvvN3UVg7ibltEDZBf4hG791caA3sNd4lj8V/UalpFgZwvo8oZ5bNoHfLzWLRURTPM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:8a4f73c9-06a2-4993-8f21-4e16aba0a99b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:35426ed5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dbda234a43e311ef87684b57767b52b1-20240717
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1291780922; Wed, 17 Jul 2024 10:25:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Jul 2024 10:25:40 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Jul 2024 10:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXK+fLJOQYGLpDmhaZ0oYnnAA7PzMqXJBFvnKsuObsZqfjg1SxFO29drC0TjfgicrF/VZ1pfRfIanWQtC2Yy10+VS98ExJQCXl6XuUjq5VsR3PmwTAVzzPTYdrdeoc4rH8mC0CrpHil/AMiejM53LVdjcTQSQjgshrosg3cylHIoUDr+uk2vq8bkxu8WCiw3+loZmTJrNMuyBK21mNLJBLCvRa/LGLTTK5QZcSU9ZCh/aug5CkXsMChjq92JiZiyF09J2w4FdyxO/QHFQGFSJwvhV/oKJbGB0aIV9cNqnJ4yg0+f3oStUUK5hgWnybHKfzhFsAzDalYreaqiCOf5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4NLsSmXf9PWJ4QOmNt1+/Md2rWmcCedeoojrETn1ww=;
 b=ftIl/l5CwL6bjTrDxlfHeb0CSk0M7EoFSG5r6V2sfuARnOgtp2mOV17hO1WC5+oo1ek2RB4f6Y3sISYkzuSmlN0ugL9Uc4f4b4pvuOjAEL2K7vpPUaBJ6/ydWk0QArzQp+guPCmNlfozJb+TQCMdHqzVcKjw58UwE5MdykI34IYfXOpHJTo0WyMvB6jpTrvDHdV3jOORLueMk1v7ng0NEJWM0TDn17tTvQq/WucsoUXfzNS3IGEMUq3PIGJq0euve/xppaab0LQPqG/+plYX3oXehfEImc9MSHyPCkAZLichBpkWzvTxeg/e8aPUgvtHYyAh/kovMI1KwGG67g7nMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4NLsSmXf9PWJ4QOmNt1+/Md2rWmcCedeoojrETn1ww=;
 b=WNh8QEYE9pD5iqYMAbFHBkvNf6wu6399IVSRJSyJSPHJnyabuzHqUhf/12/785jKISJKScGlqIvycrXA0RNG68uP+HIRfDR4WlpG8Dn3PtZ6UWqHi7bV40iIrHQwkKbc/G+MvfJOtY2MpBMWQY3ZJV5qN55rRS4qVvRcOXAB8H0=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 02:25:38 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 02:25:37 +0000
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
Thread-Index: AQHa11Ul4ctm5KmuYkmA12uhv9CQ2bH521+AgABXLQA=
Date: Wed, 17 Jul 2024 02:25:37 +0000
Message-ID: <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
	 <Zpbify32lel9J-5I@slm.duckdns.org>
In-Reply-To: <Zpbify32lel9J-5I@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SI2PR03MB6686:EE_
x-ms-office365-filtering-correlation-id: 7c5875ac-e33e-46cb-60a2-08dca607bf00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VnpPald1QTZDaUlYMTU1dlJleHcvc25xWjJIb21mWVd0S1pCc2lxRnU3dTFH?=
 =?utf-8?B?Zk9tT05xYnYrazk4TjRxR3VqM0N2ZmdSdjkyYVdFdFlUY0RpTUVBY2FmTFdX?=
 =?utf-8?B?Ui8wVURWbHQrQlpzTC9oWUZqN1pXQlh0ZUUrOUp3OXFUNTRTb1VzaUVXNndG?=
 =?utf-8?B?Y0xqWURkc1lKeVRFQTlRTVVlWDRZbU9YZGhHeVFIYlJLYkxlV2FUUGszYkI3?=
 =?utf-8?B?K2I1c1F6U0tlczNTL1BzL2p3djdzS3FiVWFGYUFBTFBLTzJDUGl5bXBxNTJK?=
 =?utf-8?B?UzltSHZUNkl4Tm1pN3ZWZTVOZko2QnVtTC9JekhuRUtiUzgrOFA3cGVyWUM5?=
 =?utf-8?B?cnk5aXVOQyt0LzBLNkdXOURtWmlKdituYjM2TG85L2ZGVmkzTmo3NS93dS9G?=
 =?utf-8?B?eGlVU0hNWU9hbmZjTmNZY0lIUm1VY1ZKRDFUQlZSdmQ2SkFqQ1NITjRrZDhE?=
 =?utf-8?B?ZzFhYVdaL3VLaDNra3RzNDdSellUaHFyZlhoVVVtTU9RQWNuSlFNdmE5SFIr?=
 =?utf-8?B?L2Fyc3B4N2tybWk2NksxZ0Foc1MrZDZ1UzJBZkZuSFQzVUZPbzB1Y0drNzcz?=
 =?utf-8?B?NWdRQ0xFd1hpMlRuUzR3eGxCd1dadHE2L1g1cEhyM1RMbW8wbTA1N0JDMEc2?=
 =?utf-8?B?em1HYzI4R1NIcHlDVUo5cG5PczZDVWZTalpEQXQ4STBJOWVaWXZRQmpLOG5u?=
 =?utf-8?B?S041UTZERDYrS0RpZnhhK2hJTHhIeHJzK01Lclg3OU5jT0M2V0ErWm1UNnMr?=
 =?utf-8?B?TzBDZ0IwdkVRQWFreHJSQjlUUlRjMlhZVHZmYUN0RTYySzdjQjJnRExQblp1?=
 =?utf-8?B?L1ZORDJ3YUtIdG9FM2lzS08wbmU1L1d2cjIxaXJNUEJncm1XWjRTbm1YcDNN?=
 =?utf-8?B?RjF3bTZyQXoyazRzTDBDb01RSHBoQTlCcWtzbVNBeGpoc2lwOFFOTWlXWGFC?=
 =?utf-8?B?RVRtZytOUGNJcUdTN1F5WTdvK0hSYjhNMTVxK1MxQStTd0cyRVE3SndnYWcr?=
 =?utf-8?B?YXgyNXNuN1k2WTc3WU5CSk5iSFp4UGQwZXE1ckdyNU93Z00vQ1dnYk5uNXdH?=
 =?utf-8?B?Qnk1Ti9UazJ4ZGdXSTIvalc2WFJhd1lwVC9BVFNHYkdtL1VFVFFZYXRFSkto?=
 =?utf-8?B?emdYYW1FYS9pdzZBbkVaa3ZDZC84OFpMb3F3eFp2bko3d2VpeEFvdzcwb1Vj?=
 =?utf-8?B?ZmpmcktkeE40THJxR2N1aml5cDBnVXFldEJFWWRuRGRGYTRtL1lNUG93bTlI?=
 =?utf-8?B?OTFkZXNFdzhXT0NFcU8yQ2s4My94R2xIQjkzdW1VVXdNVzkxaW5adE9NSmwz?=
 =?utf-8?B?UDMwL0JPcUJ5SGNyWXF1NUp3YWNadEVoZWZHMXVTWkJ4RWR5SnY4cmMwZTUw?=
 =?utf-8?B?a2g1ODFaRlpaZHo5dHViSHZqY0VhU0ZQbEVjWm1kMGZXMlJPMzliSVhBZ0Nl?=
 =?utf-8?B?YWVjUldxY3V5ZkVnci96bjBSYkNKdGFJNHVENlhSbGEvbXUrc1grTmJIays1?=
 =?utf-8?B?aGFBWms2YjVNSWdZVGVkZmNzdysvbHBaaVdYTkhBNXNtWFljR1Q0QjF5cjdr?=
 =?utf-8?B?N2ZEY3p0SDdpNVozU1JKaElHbWs1UGREdWE2YU9JY0x2bVVqY0UzZmlPZnNn?=
 =?utf-8?B?TU13aVdDOHlIYWo4dmNZQ3VFYzZUVC9pNkNpdWRyWG1sWWxHakZmLytpL2VR?=
 =?utf-8?B?anMyVE1rWUp0U0F3NWkwYWNZZHRPYjVQbDhYOWNLMDdsMWhXZ2ZPZ1dqOExX?=
 =?utf-8?B?YnR3L3MrdjBaOTIyb25TS3RvS0hUU2dUR2t5WWxFbEhwYWtlZFJ5aFlVM0hD?=
 =?utf-8?B?NmdSVHZnK2tHcUxmdDkzcjVEK05jcXFQTFNkbHRoT1pYODZyU3RKOTgyN3Nj?=
 =?utf-8?B?WUtuazh4NURJMDZJYVRWeHpzbTVYUGcxZVY3dHdiRzlGQ2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2lydTY0TUVETzNNdUdWNHZsZjA4UlVxTGxEemRjYlI2WkJKTXhmWnc3ZjFm?=
 =?utf-8?B?YlFZMGRUcWZ6Y3ZmUTlBaVAxUkV4elhXbklpSjVMNmJvWktRQjFPbHRPVGlW?=
 =?utf-8?B?bE5LNHAyUHpZT0pwV3ZqaEFJQjk3NVV3dkhzQnp2UkJ2NUZ4R1BSczN2dXFa?=
 =?utf-8?B?QlRpQldFREVsMi8rZSt1SWg0OTdLc2hpb21HbmsrQmRURTdOZlRqNGpGYW1U?=
 =?utf-8?B?aXk4eTZJNFZKWGR6cFJCazUwUjYrT1Q4cTVWc3JpMzJmRFRodW1RbFJJWG83?=
 =?utf-8?B?Zno2K0NZK3duK2VkSjI2c2xPb3B0MnVjNjdqd3ZNRS9LcVFWNkhuRGZISXYx?=
 =?utf-8?B?U0Q1OE8zbENRbTlmK1JRaFVNNXR5V3FxUDZENGdIbnptSzU5UHRVaEtHMDNL?=
 =?utf-8?B?U0k1emlBZ002cnl6L2hQQzBSaDhZaStMWUw3OHp4S1MxTkFJZURrWjMxWmF6?=
 =?utf-8?B?ekZ2SElxL2Y5N3dvSEszcWNpVGZDczQ5Vm9ia01henc1UTNUNHF3cXRzQzRL?=
 =?utf-8?B?UmFTWVJUTThKTWpMcExxREVqS2tveGFJdHlTbW1ObXV3bWxNKytpYksyTTRB?=
 =?utf-8?B?N20wSE1SemtVYzhpd3l6bURDdnFXRk8rRWdZa1dFSC80TWhLN3ZLWUVwK0w3?=
 =?utf-8?B?cVoreFFCVmE1N1RqR2NCNDdpS2VaL1ZGcE9scGtrZ1ZXVHZOdFlJRVlZMEVV?=
 =?utf-8?B?YldUVC9Jd1BpV0l4UzJLN3BvVi9iK0lEYjVKemorL2VkYjZZSFZLdTNxSVIz?=
 =?utf-8?B?Qi9KV29sMFY4b2FmWjRwTlJudzJORG5Xc1oyT3gyb1ppNjBXYXo4akpEc3lW?=
 =?utf-8?B?TktLSnZZckxSZkcvL25RNnE4aC9lMnNJSHdCbGRCc2JwSExxeGYvd1VMem5D?=
 =?utf-8?B?MytJd051Ui9iczVkNDJzaHBqN21tL0VCVTJTKzFMR0xQRG5GOTlIMjBnQk9T?=
 =?utf-8?B?MExqdTRkVEQ1dG05VHRlL1Jia2c0OXlMMjhsVDZOV05mT04yUzZEV0t3cGJQ?=
 =?utf-8?B?MlpGK1dZR2F6cDBGQjQxZXJQcHBLYWJaQWtwSkxaWEt0UEpHQ2FIVDR6ajRW?=
 =?utf-8?B?dnBLdEo5a2pjVHRXdFg0L0ZVeWFkMGp3cmVXeVlraHJtYm9JMlNpWmFmR1Nw?=
 =?utf-8?B?TkNOckZrVlNmbTZPaGJHbUlqUUNSYUEvSUxsaHdZZXpJOGo0VlM1c2tSS1Vz?=
 =?utf-8?B?RFk4VVhYUEFZdUluU2lycWJGTmtvTG5iVVlpZFBsUnYrYnZDZWJjVVJXVWdM?=
 =?utf-8?B?U0Q0MVdVV2oxaHY4dXIrUnJTaGZZZFMrV1M1Z2kvRzBLVXdhc2dZWGhFNGJI?=
 =?utf-8?B?cmdCSGM1YkRqd3NaRDNpc2dJT3JHaWQ0MzlubEJJa25RelBvZUlSb245ekhS?=
 =?utf-8?B?QXFaRmc0aldkRUhUTVIwOE1qTHhVZlJmTElHbHcwVVNRekFKdlZlOXNzeERr?=
 =?utf-8?B?dGxDdU5pa2tuT0NrRXVmVlN5czFzY0lRZ3ljRjhNUlpLbmdZWDg4aGdyQmsv?=
 =?utf-8?B?dEx6TUl1RGp4Yk5QZTdSdG5XL3BxVzM0MHNnekxlTWlPSS9OQjl3dlQ2YXVr?=
 =?utf-8?B?OFloZkpOV2tpYWt4ekg5NU02UjB3Z1VLTUVtbUdaQml6MEdMWTRNMkFWZ2pt?=
 =?utf-8?B?eU5CWTNCTm9xLytOaEFvNWtaSFh6a2UrMmxVNlVzV29nL2lzbFpXUkN1UDlz?=
 =?utf-8?B?NmQzQmVHc0EwZE1WZzhLOG5DcGxqTEJ6TnEvenBwVWVRdmt6dXRSS0k2S0xZ?=
 =?utf-8?B?VDFXQVBQa0RtNUlkNTZUU3BiWjh6Vk02N1NLSGttN2N3MC9hcmNtM2ZvMkJm?=
 =?utf-8?B?Qy9sWVpyTDhWNTdHVWgyQTJCZkQ3d3o1L3V3SjYxb1NkaXRZdFlWWXRldTZr?=
 =?utf-8?B?WFlid2pielo2aUNZaFU4eElWZ2tYZFQ1ZXo1TWo2dTJsMDhLbTZWbG4rQUdq?=
 =?utf-8?B?UFQ3NExtU0szMTF2ZWxrTUlWQndoZDBJTmJ2TW1hOFVoZExjMnc4dWhlUndr?=
 =?utf-8?B?TFR4VDlkUG1leTgyOHMyZHVUc0hTemhOd1ozQnJVTWhyL1FwWWJya3lTb1BG?=
 =?utf-8?B?dWxud1BiWHZoOWdKQlNJc3R5VUlPZEN3WVlkZXBiWHVkTnJIa1E0cmRIcEpT?=
 =?utf-8?Q?YVev6wjJ3KyQW+hLLysGvziG0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81E3BB5A0514314C9C3CF6C1A711859B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5875ac-e33e-46cb-60a2-08dca607bf00
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:25:37.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vWbxnFXuDdhSyIzhBAcLLsH3j1CdiC2xAdPXCDiBGEj+AMI3iYC0LwFo6IacvNG/FeCy9fUceAIPv7HZPu1yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6686

T24gVHVlLCAyMDI0LTA3LTE2IGF0IDExOjEzIC0xMDAwLCBUZWp1biBIZW8gd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgSGVsbG8sIEJveS4NCj4gDQo+IFNvLCBsb29raW5nIGF0IHRoZSBwYXRjaCwg
SSdtIG5vdCBzdXJlIHBlci1ibGtnIGxvY2sgbWFrZXMgc2Vuc2UuDQo+IA0KPiBPbiBUdWUsIEp1
bCAxNiwgMjAyNCBhdCAwMzo1MjowNlBNICswODAwLCBib3kud3Ugd3JvdGU6DQo+ID4gQEAgLTk5
NSwxNSArOTk1LDEzIEBAIHN0YXRpYyB2b2lkIGJsa2NnX2lvc3RhdF91cGRhdGUoc3RydWN0DQo+
IGJsa2NnX2dxICpibGtnLCBzdHJ1Y3QgYmxrZ19pb3N0YXQgKmN1ciwNCj4gPiAgc3RydWN0IGJs
a2dfaW9zdGF0ICpsYXN0KQ0KPiA+ICB7DQo+ID4gIHN0cnVjdCBibGtnX2lvc3RhdCBkZWx0YTsN
Cj4gPiAtdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAgDQo+ID4gIC8qIHByb3BhZ2F0ZSBwZXJj
cHUgZGVsdGEgdG8gZ2xvYmFsICovDQo+ID4gLWZsYWdzID0gdTY0X3N0YXRzX3VwZGF0ZV9iZWdp
bl9pcnFzYXZlKCZibGtnLT5pb3N0YXQuc3luYyk7DQo+ID4gK2d1YXJkKHNwaW5sb2NrX2lycXNh
dmUpKCZibGtnLT5pb3N0YXQuc3BpbmxvY2spOw0KPiA+ICBibGtnX2lvc3RhdF9zZXQoJmRlbHRh
LCBjdXIpOw0KPiA+ICBibGtnX2lvc3RhdF9zdWIoJmRlbHRhLCBsYXN0KTsNCj4gPiAgYmxrZ19p
b3N0YXRfYWRkKCZibGtnLT5pb3N0YXQuY3VyLCAmZGVsdGEpOw0KPiA+ICBibGtnX2lvc3RhdF9h
ZGQobGFzdCwgJmRlbHRhKTsNCj4gPiAtdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVzdG9yZSgm
YmxrZy0+aW9zdGF0LnN5bmMsIGZsYWdzKTsNCj4gPiAgfQ0KPiANCj4gVGhpcyBpcyBhbHJlYWR5
IGNhbGxlZCB3aXRoIGJsa2dfc3RhdF9sb2NrIGhlbGQuDQoNCkluIGJsa2NnX2lvc3RhdF91cGRh
dGUsIGl0IGlzIHByb3RlY3RlZCBieSBib3RoIGJsa2dfc3RhdF9sb2NrIGFuZCB1NjQNCnN5bmMu
IEkgYWdyZWUgdGhhdCBubyBjaGFuZ2VzIGFyZSBuZWVkZWQgaGVyZS4NCg0KPiANCj4gPiBAQCAt
MTA1MSwxMCArMTA0OCw4IEBAIHN0YXRpYyB2b2lkIF9fYmxrY2dfcnN0YXRfZmx1c2goc3RydWN0
IGJsa2NnDQo+ICpibGtjZywgaW50IGNwdSkNCj4gPiAgZ290byBwcm9wYWdhdGVfdXA7IC8qIHBy
b3BhZ2F0ZSB1cCB0byBwYXJlbnQgb25seSAqLw0KPiA+ICANCj4gPiAgLyogZmV0Y2ggdGhlIGN1
cnJlbnQgcGVyLWNwdSB2YWx1ZXMgKi8NCj4gPiAtZG8gew0KPiA+IC1zZXEgPSB1NjRfc3RhdHNf
ZmV0Y2hfYmVnaW4oJmJpc2MtPnN5bmMpOw0KPiA+ICtzY29wZWRfZ3VhcmQoc3BpbmxvY2tfaXJx
c2F2ZSwgJmJpc2MtPnNwaW5sb2NrKQ0KPiA+ICBibGtnX2lvc3RhdF9zZXQoJmN1ciwgJmJpc2Mt
PmN1cik7DQo+ID4gLX0gd2hpbGUgKHU2NF9zdGF0c19mZXRjaF9yZXRyeSgmYmlzYy0+c3luYywg
c2VxKSk7DQo+IA0KPiBUaGlzIGlzIHBlci1jcHUgc3RhdCBhbmQgd2Ugc2hvdWxkIGtlZXAgdXNp
bmcgdTY0X3N5bmMgZm9yIHRoZW0uDQo+IA0KPiA+IEBAIC0xMTM0LDkgKzExMjgsOCBAQCBzdGF0
aWMgdm9pZCBibGtjZ19maWxsX3Jvb3RfaW9zdGF0cyh2b2lkKQ0KPiA+ICBjcHVfZGtzdGF0cy0+
c2VjdG9yc1tTVEFUX0RJU0NBUkRdIDw8IDk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLWZsYWdzID0g
dTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZibGtnLT5pb3N0YXQuc3luYyk7DQo+ID4g
K2d1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZibGtnLT5pb3N0YXQuc3BpbmxvY2spOw0KPiA+ICBi
bGtnX2lvc3RhdF9zZXQoJmJsa2ctPmlvc3RhdC5jdXIsICZ0bXApOw0KPiA+IC11NjRfc3RhdHNf
dXBkYXRlX2VuZF9pcnFyZXN0b3JlKCZibGtnLT5pb3N0YXQuc3luYywgZmxhZ3MpOw0KPiA+ICB9
DQo+ID4gIH0NCj4gLi4uDQo+ID4gQEAgLTExNTcsMTYgKzExNDksMTQgQEAgc3RhdGljIHZvaWQg
YmxrY2dfcHJpbnRfb25lX3N0YXQoc3RydWN0DQo+IGJsa2NnX2dxICpibGtnLCBzdHJ1Y3Qgc2Vx
X2ZpbGUgKnMpDQo+ID4gIA0KPiA+ICBzZXFfcHJpbnRmKHMsICIlcyAiLCBkbmFtZSk7DQo+ID4g
IA0KPiA+IC1kbyB7DQo+ID4gLXNlcSA9IHU2NF9zdGF0c19mZXRjaF9iZWdpbigmYmlzLT5zeW5j
KTsNCj4gPiAtDQo+ID4gK3Njb3BlZF9ndWFyZChzcGlubG9ja19pcnFzYXZlLCAmYmlzLT5zcGlu
bG9jaykgew0KPiA+ICByYnl0ZXMgPSBiaXMtPmN1ci5ieXRlc1tCTEtHX0lPU1RBVF9SRUFEXTsN
Cj4gPiAgd2J5dGVzID0gYmlzLT5jdXIuYnl0ZXNbQkxLR19JT1NUQVRfV1JJVEVdOw0KPiA+ICBk
Ynl0ZXMgPSBiaXMtPmN1ci5ieXRlc1tCTEtHX0lPU1RBVF9ESVNDQVJEXTsNCj4gPiAgcmlvcyA9
IGJpcy0+Y3VyLmlvc1tCTEtHX0lPU1RBVF9SRUFEXTsNCj4gPiAgd2lvcyA9IGJpcy0+Y3VyLmlv
c1tCTEtHX0lPU1RBVF9XUklURV07DQo+ID4gIGRpb3MgPSBiaXMtPmN1ci5pb3NbQkxLR19JT1NU
QVRfRElTQ0FSRF07DQo+ID4gLX0gd2hpbGUgKHU2NF9zdGF0c19mZXRjaF9yZXRyeSgmYmlzLT5z
eW5jLCBzZXEpKTsNCj4gPiArfQ0KPiANCj4gVGhlIGFib3ZlIHR3byBhcmUgdGhlIG9ubHkgcGxh
Y2VzIHdoaWNoIGNhbiBwb3RlbnRpYWxseSBiZW5lZml0IGZyb20NCj4gcGVyLWJsa2cgbG9jayBi
dXQgdGhlc2UgYXJlbid0IGhvdCBwYXRocy4gSSdkIGp1c3QgdXNlIGJsa2dfc3RhdF9sb2NrDQo+
IGZvcg0KPiB0aGUgYWJvdmUuDQoNCkluIF9fYmxrY2dfcnN0YXRfZmx1c2gsIHU2NCBzeW5jIGlz
IHVzZWQgZm9yIGZldGNoaW5nIGRhdGEsIGNoYW5naW5nIHRvDQpzcGlubG9jayB3aWxsIGluY3Jl
YXNlIG92ZXJoZWFkIGJvdGggNjQgYml0IGFuZCAzMiBiaXQgc3lzdGVtcy4gNjQgYml0DQpzeXN0
ZW1zIGRvIG5vdGluZyBpbiB1NjQgc3luYywgYW5kIDMyIGJpdCBzeXN0ZW1zIGNhbiByZWFkIGRh
dGEgaW4NCnBhcmFsbGVsIGluIHU2NCBzeW5jIGlmIG5vIG9uZSB1cGRhdGluZyBkYXRhLiBIb3dl
dmVyLCBpdCBpcyBhbHJlYWR5DQpwcm90ZWN0ZWQgYnkgYmxrZ19zdGF0X2xvY2ssIHNvIHRoZXJl
IGlzIG5vIHBhcmFsbGVsaXNtIG5vdywgYW5kIHRoZXJlDQppcyBubyBpc3N1ZSBoZXJlLiBJIHRo
aW5rIHRoYXQgbm8gY2hhbmdlcyBhcmUgbmVlZGVkIGhlcmUuDQoNCkluIGJsa2NnX2ZpbGxfcm9v
dF9pb3N0YXRzLCB0aGlzIGlzIHdoZXJlIHRoZSBpc3N1ZSBoYXBwZW5zIGluIDMyIGJpdA0KU01Q
IHN5c3RlbXMsIHNvIHNwaW5sb2NrIG5lZWRzIHRvIGJlIGFkZGVkIHRvIHByb3RlY3QgaXQuDQoN
CkluIGJsa2NnX3ByaW50X29uZV9zdGF0LCB1NjQgc3luYyBpcyB1c2VkIGZvciBmZXRjaGluZyBk
YXRhLiBDaGFuZ2luZw0KdG8gc3BpbmxvY2sgd2lsbCBpbmNyZWFzZSBvdmVyaGVhZCBsaWtlIGlu
IF9fYmxrY2dfcnN0YXRfZmx1c2guDQpIb3dldmVyLCBpdCBpcyBhbHJlYWR5IHByb3RlY3RlZCBi
eSBzcGluX2xvY2tfaXJxKCZibGtnLT5xLT5xdWV1ZV9sb2NrKSANCmluIGJsa2NnX3ByaW50X3N0
YXQsIHNvIHRoZXJlIGlzIG5vIHBhcmFsbGVsaXNtIG5vdywgYW5kIHRoZXJlIGlzIG5vDQppc3N1
ZSBoZXJlLiBJIHRoaW5rIHRoYXQgbm8gY2hhbmdlcyBhcmUgbmVlZGVkIGhlcmUuDQoNCj4gDQo+
ID4gQEAgLTIxNTIsMzAgKzIxNDEsMjkgQEAgdm9pZCBibGtfY2dyb3VwX2Jpb19zdGFydChzdHJ1
Y3QgYmlvICpiaW8pDQo+ID4gIA0KPiA+ICBjcHUgPSBnZXRfY3B1KCk7DQo+ID4gIGJpcyA9IHBl
cl9jcHVfcHRyKGJpby0+YmlfYmxrZy0+aW9zdGF0X2NwdSwgY3B1KTsNCj4gPiAtZmxhZ3MgPSB1
NjRfc3RhdHNfdXBkYXRlX2JlZ2luX2lycXNhdmUoJmJpcy0+c3luYyk7DQo+ID4gLQ0KPiA+IC0v
Kg0KPiA+IC0gKiBJZiB0aGUgYmlvIGlzIGZsYWdnZWQgd2l0aCBCSU9fQ0dST1VQX0FDQ1QgaXQg
bWVhbnMgdGhpcyBpcyBhDQo+IHNwbGl0DQo+ID4gLSAqIGJpbyBhbmQgd2Ugd291bGQgaGF2ZSBh
bHJlYWR5IGFjY291bnRlZCBmb3IgdGhlIHNpemUgb2YgdGhlDQo+IGJpby4NCj4gPiAtICovDQo+
ID4gLWlmICghYmlvX2ZsYWdnZWQoYmlvLCBCSU9fQ0dST1VQX0FDQ1QpKSB7DQo+ID4gLWJpb19z
ZXRfZmxhZyhiaW8sIEJJT19DR1JPVVBfQUNDVCk7DQo+ID4gLWJpcy0+Y3VyLmJ5dGVzW3J3ZF0g
Kz0gYmlvLT5iaV9pdGVyLmJpX3NpemU7DQo+ID4gLX0NCj4gPiAtYmlzLT5jdXIuaW9zW3J3ZF0r
KzsNCj4gPiArc2NvcGVkX2d1YXJkKHNwaW5sb2NrX2lycXNhdmUsICZiaXMtPnNwaW5sb2NrKSB7
DQo+ID4gKy8qDQo+ID4gKyAqIElmIHRoZSBiaW8gaXMgZmxhZ2dlZCB3aXRoIEJJT19DR1JPVVBf
QUNDVCBpdCBtZWFucyB0aGlzIGlzIGENCj4gc3BsaXQNCj4gPiArICogYmlvIGFuZCB3ZSB3b3Vs
ZCBoYXZlIGFscmVhZHkgYWNjb3VudGVkIGZvciB0aGUgc2l6ZSBvZiB0aGUNCj4gYmlvLg0KPiA+
ICsgKi8NCj4gPiAraWYgKCFiaW9fZmxhZ2dlZChiaW8sIEJJT19DR1JPVVBfQUNDVCkpIHsNCj4g
PiArYmlvX3NldF9mbGFnKGJpbywgQklPX0NHUk9VUF9BQ0NUKTsNCj4gPiArYmlzLT5jdXIuYnl0
ZXNbcndkXSArPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZTsNCj4gPiArfQ0KPiA+ICtiaXMtPmN1ci5p
b3NbcndkXSsrOw0KPiA+ICANCj4gPiAtLyoNCj4gPiAtICogSWYgdGhlIGlvc3RhdF9jcHUgaXNu
J3QgaW4gYSBsb2NrbGVzcyBsaXN0LCBwdXQgaXQgaW50byB0aGUNCj4gPiAtICogbGlzdCB0byBp
bmRpY2F0ZSB0aGF0IGEgc3RhdCB1cGRhdGUgaXMgcGVuZGluZy4NCj4gPiAtICovDQo+ID4gLWlm
ICghUkVBRF9PTkNFKGJpcy0+bHF1ZXVlZCkpIHsNCj4gPiAtc3RydWN0IGxsaXN0X2hlYWQgKmxo
ZWFkID0gdGhpc19jcHVfcHRyKGJsa2NnLT5saGVhZCk7DQo+ID4gKy8qDQo+ID4gKyAqIElmIHRo
ZSBpb3N0YXRfY3B1IGlzbid0IGluIGEgbG9ja2xlc3MgbGlzdCwgcHV0IGl0IGludG8gdGhlDQo+
ID4gKyAqIGxpc3QgdG8gaW5kaWNhdGUgdGhhdCBhIHN0YXQgdXBkYXRlIGlzIHBlbmRpbmcuDQo+
ID4gKyAqLw0KPiA+ICtpZiAoIVJFQURfT05DRShiaXMtPmxxdWV1ZWQpKSB7DQo+ID4gK3N0cnVj
dCBsbGlzdF9oZWFkICpsaGVhZCA9IHRoaXNfY3B1X3B0cihibGtjZy0+bGhlYWQpOw0KPiA+ICAN
Cj4gPiAtbGxpc3RfYWRkKCZiaXMtPmxub2RlLCBsaGVhZCk7DQo+ID4gLVdSSVRFX09OQ0UoYmlz
LT5scXVldWVkLCB0cnVlKTsNCj4gPiArbGxpc3RfYWRkKCZiaXMtPmxub2RlLCBsaGVhZCk7DQo+
ID4gK1dSSVRFX09OQ0UoYmlzLT5scXVldWVkLCB0cnVlKTsNCj4gPiArfQ0KPiANCj4gVGhlc2Ug
YXJlIHBlci1jcHUgc3RhdCB1cGRhdGVzIHdoaWNoIHNob3VsZCBrZWVwIHVzaW5nIHU2NF9zeW5j
LiBXZQ0KPiBkb24ndA0KPiB3YW50IHRvIGluY3VyIGxvY2tpbmcgb3ZlcmhlYWQgZm9yIHN0YXQg
dXBkYXRlcyBpbiB0aGUgaG90IGlzc3VlDQo+IHBhdGguDQo+IA0KDQpJIGFncmVlIHRoYXQgbm8g
Y2hhbmdlcyBhcmUgbmVlZGVkIGluIGJsa19jZ3JvdXBfYmlvX3N0YXJ0Lg0KDQo+IFRoYW5rcy4N
Cj4gDQo+IC0tIA0KPiB0ZWp1bg0KDQpJIHRoaW5rIHdlIGNhbiBsb29rIGJhY2sgdG8gdGhlIG9y
aWdpbmFsIGlzc3VlLCB3aGljaCBpcyB0aGF0IG9uIDMyIGJpdA0KU01QIHN5c3RlbXMgd2lsbCBo
YXZlIGNvbmN1cnJlbnQgcHJvYmxlbXMgb24NCnU2NF9zdGF0c191cGRhdGVfYmVnaW5faXJxc2F2
ZSBhbmQgdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVzdG9yZSBpbg0KYmxrY2dfZmlsbF9yb290
X2lvc3RhdHMuIFNvLCBhZGRpbmcgYSBsb2NrIG9ubHkgb24gMzIgYml0cyBzeXN0ZW1zDQppbiBi
bGtjZ19maWxsX3Jvb3RfaW9zdGF0cyBpcyB0byByZXNvbHZlIHRoZSBjb25jdXJyZW50IGlzc3Vl
IGFuZCBub3QNCmFmZmVjdCA2NCBiaXQgc3lzdGVtcywgd2hpY2ggZG8gbm90IGhhdmUgdGhlIGlz
c3VlIGluIHRoZSBmaXJzdCBwbGFjZSwNCmJlY2F1c2UgdTY0IHN5bmMgZG9lcyBub3RpbmcgaW4g
NjQgYml0IHN5c3RlbXMgYW5kIHRoZXkgZG9uJ3QgbmVlZCBpdC4NCg0KSSB0aGluayB3ZSBjYW4g
anVzdCBmaXggaXQgYnkgZm9sbG93aW5nIGNoYW5nZS4NCg0KQEAgLTExMzQsOSArMTEyOCw4IEBA
IHN0YXRpYyB2b2lkIGJsa2NnX2ZpbGxfcm9vdF9pb3N0YXRzKHZvaWQpDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNwdV9ka3N0YXRzLT5zZWN0b3JzW1NUQVRfRElTQ0FSRF0gPDwN
Cjk7DQogICAgICAgICAgICAgICAgfQ0KDQorI2lmIEJJVFNfUEVSX0xPTkcgPT0gMzINCisgICAg
ICAgICAgICAgICBndWFyZChzcGlubG9ja19pcnFzYXZlKSgmYmxrZ19zdGF0X2xvY2spOw0KKyNl
bmRpZg0KICAgICAgICAgICAgICAgIGZsYWdzID0gdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFz
YXZlKCZibGtnLQ0KPmlvc3RhdC5zeW5jKTsNCiAgICAgICAgICAgICAgICBibGtnX2lvc3RhdF9z
ZXQoJmJsa2ctPmlvc3RhdC5jdXIsICZ0bXApOw0KICAgICAgICAgICAgICAgIHU2NF9zdGF0c191
cGRhdGVfZW5kX2lycXJlc3RvcmUoJmJsa2ctPmlvc3RhdC5zeW5jLA0KZmxhZ3MpOw0KICAgICAg
ICB9DQogfQ0K

