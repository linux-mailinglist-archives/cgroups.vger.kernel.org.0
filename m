Return-Path: <cgroups+bounces-3725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB79335CB
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 05:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D271D284515
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 03:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF563CB;
	Wed, 17 Jul 2024 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="asoN7TA+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jcABh4h7"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96125B64C;
	Wed, 17 Jul 2024 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721187899; cv=fail; b=eYgO6RFSqFbOkgSMWUWzzATk14/JRkLSh1SuJ6XTKmu9itlDCiBary3HoyeYSUu6CgQ+KWXF9xwT3pYuC+MKGjF1tdYWVo3qD4lYZ2Uep3kVYq6bFONAj1VJG6jMqiCOOO4kH/VLCPQeJocFTy8BVEMe/LmeJlGZCSOJMbrr2es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721187899; c=relaxed/simple;
	bh=9YiQfwPaf7xDrsOeSVZnPvjkKbf6qDCN3vWcX/0G7UA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEqWfd5uWinCC2ZAlc/9w+pRnTGyRe0fuhMyhjFlZ4sfiAD93o3GQstXBKG/Dsrh9pjfVAN3IHmtj9IEpgrnab57q/C3iJF1OKzYj2D1Zj4IllapOkQTJAbIdAYvCkxU+njDfWT97wtQob4U8NheFXmn+QhWnrP78+oslWwJzzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=asoN7TA+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jcABh4h7; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ead693d243ee11ef87684b57767b52b1-20240717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9YiQfwPaf7xDrsOeSVZnPvjkKbf6qDCN3vWcX/0G7UA=;
	b=asoN7TA+5H6qzEcHir0IGlRi+Am7SXNTj3riuFis88CHo3Ke7GqjaFlRU6HQ/y6vdRJ+r94Tg5cnrFSAbuAu8mNbX2sCqK8tY13WvY8+x7ZH0c82l1re2lDUjL94XHm6e/y78m5O32YeumW+w5RoBso5DBdXdJRKN+b9/RoTlMg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:603753f1-084e-44fb-a724-dbb73988252f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:836892d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ead693d243ee11ef87684b57767b52b1-20240717
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 5772770; Wed, 17 Jul 2024 11:44:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Jul 2024 11:44:49 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Jul 2024 11:44:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/wuPmnyC2N6E9OYiMYWBYcGezVg/+9c1Nyv9VG4w/QKk9ihTnsfwcjZbYXORn675g7tqa3fNgHV87WVVf3la3qJ02X2raNgQUmVIH8ocM6u9YR3ZpVFtmrsXg808MF/UyG8SJe2tsYl9MmEEzBmb7TCnFv8KoX9HRKn2sKkKljSuSi6c4MDaAhYJygM382xxakEUFNOGtQAUsAdRBTcCtRv2dXbJYGi17UzUUo+maBBm1QNk9ZkKZsKS8RR5Y2HmwLQ7ktsjGe7bFkv5a+XhuOpkKGWiXRERUf8/dn2OApdRR92o/DrwPvONdJdc6GpgKqZZTAndHOIGXmppv74lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YiQfwPaf7xDrsOeSVZnPvjkKbf6qDCN3vWcX/0G7UA=;
 b=qsW64WmE8omsvmBxfI5mYhFCYg/lxNoQbrcPs5pEhFmJDL81gcbH07zgnJIb4/M5MogDYVVq97O4YImjZrkDG4TZ8zVmGY1M1moWB7R4lnsr0eI9u+K7x3HrNf6retv5mT+P56Fr0x4TLpsGXB+cFROadApnpvVwGLZjJz60qb9uJ+KNV7q760HtukwEydXGRiLNjoIFW1lNd6OajcPBXBLbSciBcQ+HXh0zrgy1gaW6yiIac+D70OLRyiYUxmHl6zQ+rnSOrMXdF9PKA4NuoGR35CKyvAauMGL5lOCWb2vcSaPq6o8w7c8KT7dVPPCyDVX1ExKgTB8bxsJ6OMoG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YiQfwPaf7xDrsOeSVZnPvjkKbf6qDCN3vWcX/0G7UA=;
 b=jcABh4h7uVJKSSs6SjkRjJ5rSlv2Pu+r344g4xUtkWn/KjfsXxxcz6ajkqoJg+T3kep93Px5ICMwDXNoYgohxsLOW/ITYkgeFLj9w8l+EK6R5AUloNuwY7FqYREj0sP+ecesWLJJFOEN2wk6nKwYRy6ju1qSH+wfLGouLY62zQI=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SEYPR03MB8270.apcprd03.prod.outlook.com (2603:1096:101:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 03:44:47 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 03:44:47 +0000
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
Thread-Index: AQHa11Ul4ctm5KmuYkmA12uhv9CQ2bH521+AgABXLQCAABYeAA==
Date: Wed, 17 Jul 2024 03:44:47 +0000
Message-ID: <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
	 <Zpbify32lel9J-5I@slm.duckdns.org>
	 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
In-Reply-To: <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SEYPR03MB8270:EE_
x-ms-office365-filtering-correlation-id: 1eaf437e-7c8b-41b0-e646-08dca612ce16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a29QRElCQlN3VlFXcHNQV1dZdzh2Ti92K0J1VUttb213S3ZLbU8zbXJqU0Qw?=
 =?utf-8?B?Z28vUnFRZlZJa3lZdHA1SEtDNDJ0RTZqSUo3MFVJeGs1NUI0UEhrOTBsSU5k?=
 =?utf-8?B?Vi8rdkk4ZWFlbng4N2JyS3ZtczlIeENERXE0cjlqczhkY3NCZFRYazJzNFhQ?=
 =?utf-8?B?akVkNFFaLzRMZGZDNHRnOGUrS0lwa0l2eHVzSjNkMy9MWW1CTzFWcnppVVFx?=
 =?utf-8?B?SmRkb0xZYTBjL0xWcWtBSGRDcmQvMlhLa1FWUWNRTnM4ZWZ0ditjZGVENUo5?=
 =?utf-8?B?UGRiR3pmTS9OWGdFaVhRV3Q4aUxjengvaXFPd1M3cUN1SFN3dGZSY0JBVUlM?=
 =?utf-8?B?TEN1ZFZYLzI0S3ZzdnJqa0U0SHNjaHJZcTlod0xhQ3RuL0l4UEtIZ1FySkNa?=
 =?utf-8?B?QUxiRENvTjZRdmo2N2dob3VzZko5dmtGV0JQZE5xUk5EOXFBeENKdjA2amxs?=
 =?utf-8?B?QjdkWU9yT045aEFrWHl0czVXdk1iak9ZNjkzTERsQjYyMi9Vc09iN1B5VUFr?=
 =?utf-8?B?MC9LUDZwZy9wQnFEb1FRMWVScEE1T296ZHJkUDdLTzI0azZXS1hBS2creEpw?=
 =?utf-8?B?UGZLaWtYUDdyRGRTbHJkUHJKc0Z6bzJ0bVdGZWRCbWVBQ2NRSHVyT2R4SUdL?=
 =?utf-8?B?OHAyL1NrOWczUHE0b2RvZHJYcVVJQmlqc3l4T1ZmSlpPT3I0NDV2VDB1UUxJ?=
 =?utf-8?B?c2JmUjNLOXk4NElnVHpIcXI2VDRhelo4eG5QWDRBcTlYRkZFa3hMV2R5a1RT?=
 =?utf-8?B?THdsQTV4TGI2ZTZpWjJZaXJjQXNKRlVDbEl5TnFCeUIwaWlNd0pWbTNLbmhs?=
 =?utf-8?B?THhwaWEvbFBVdjFWaUlUMHpLVnR0cWpxZ1dJRUFob2hJWC83RXM2MHVIWkJT?=
 =?utf-8?B?TkRJbVpBWGplNU5Ock9iQXp2cFBsTS9iUndEQmplOUZoZ3VoazNBTDNaRDc2?=
 =?utf-8?B?SVlSTktjcC9hMkkwZUV4MnhaRWRTYlgxd3NVS1hPOU9rQjd0M1M1TDZ2Rjg1?=
 =?utf-8?B?OUZ6WVZOOHp6Y1ZEM0ZnT1BwK01EZDZzQzBSajRnbEk1cFpXMG11Nk5OdTIw?=
 =?utf-8?B?NE04aTVlclVGN3puQVR6UU9WbWF0N25MYU9VT2lkL3pSWWVHYm5VVWdHU3dr?=
 =?utf-8?B?eUlrK2ZyZFk1alIwRW0xZ1Vlck1jcnF3MWk3R1I3V3ZaTnVtendMeUxzZU54?=
 =?utf-8?B?TXR1MGJaeFdNZDlVM3hvTlcyRENIQkV2NzlmYmdyQnQxSHZUREwvdGRkY2tK?=
 =?utf-8?B?RXByUjlGdlVvcklBWGFNVXJBcVZyUllHLyswUTBwU2Q4dVRvZlhpWndXelFm?=
 =?utf-8?B?MkZNYUtsdnROWU9QMHFUQjMwWFRwaVpRSnV1OWxkR2lOaitSYXhvRG9kWVJX?=
 =?utf-8?B?SHlkdVYwaE5vVWl2NE9nV2xCclRMcFFIZURyQzQ0QlU5QU92a3VOcnNCbUNz?=
 =?utf-8?B?eXRKbllSZUFWOUQ3Q2R3R04xMHp3blVxSi92akpNckhhcytuREZBMnIralBk?=
 =?utf-8?B?U0QrTHlOMlQwMlIvYWhCSU9mOGJkRU1NZUUyK25LWThpc3hkTnpyMlEwMzZO?=
 =?utf-8?B?a2ZhaTdWLzRwUVFVRjZSbmtTd2UrK3E3bllZZlF0OTl5K2doUEFDWjBvZDVM?=
 =?utf-8?B?dHNPS2IxY1NzUUF3VVhsMXhSaTFiZUw2ZEh0Z21BZmVPT1p6UnJ0K0ZPK1Nq?=
 =?utf-8?B?cytlUm50bHJ3RmVCUkdxNmFGS2M0WVVjZ0dlMGtYZ2pzNjJFMHY0QlI1cE0z?=
 =?utf-8?B?WUNqMVFyOWpsN1QzL1lvV3VnQnFFU2xTdC85eFpCV2JCMGY2WXNhK3NzY1V2?=
 =?utf-8?B?eGRCbk4vcTdkQWdiZmVSKzUwVTg2blB5ODBDQ1BzYjhvakIwWEtWMmRBejdk?=
 =?utf-8?B?OHNERE5lRURkWmlyc2NIUGpiQ2ttTVFSSkRiUEJnbk5zR2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEdsUVNhUHlrSUdEQzZlSUQ5N1RiUWU1MEw0U1pETkVvNHhwZUlLaFExbkZu?=
 =?utf-8?B?ZlcvaW9LNFYwQ00xZTRXVUZvWm1IaVUwTllFeWkzaUpZVmx2bDRyRzhTTGM0?=
 =?utf-8?B?S3l5NC9NalJuQi9iK3ZsUVJmc2owVmlYZ0hzNEV4eEh1YTZWN1BydkwrUEYw?=
 =?utf-8?B?WlJsZWoyQWxtMzdYSm9RV09jcnZLRjFEc1dLa1FTWWVzYUIwUXBMMHFmSUNN?=
 =?utf-8?B?LzRiNDRMY2YzTDZ6TW1QQnhoOFN0SEhDVXUwbXB0U2wvVnN4ME1tR2YxNnJw?=
 =?utf-8?B?ZW5WelErRjNtbVdxelJsL2M2U0lsTDRFWGc3RklwdkJxL3YybjNqblRid0Fv?=
 =?utf-8?B?bnk4TmVidk9VdlpPMVJORDRRRXBraXl1WFVvS2tRTitFLzdwRUNvRkdmQzk3?=
 =?utf-8?B?SDY5QXpXUUNZcTJhTDZWa0RVZld4SDJyTjErZDFEZEFKalJUbHFjNFdvbGEv?=
 =?utf-8?B?S2pJQ2tEQ0Y4T0xrblNrOVVwVGViYXJTTUpkNUg2VW56NjJmaFdIZWd2cEQx?=
 =?utf-8?B?QzMxYU5NTlc1czVOd3UrdDdTeXIrcjlZZXNPTGdHY2dDc2xHb2EwYkRSQlY1?=
 =?utf-8?B?a3ZFWjBSa1FBbFR2RVZTR3FwbnRUTzQ2alhES3A2YXBTc000K2NwOHhWcUli?=
 =?utf-8?B?cHp1T0R6azFFd0dRTkx4a0p6dm84bHRYUCtyMjNoejBVYXp2Yk9HRWgvcWI3?=
 =?utf-8?B?S3VOenI3WElsZzVxK3ZyQWZMS3FSdm0xQXppa3E3eUNZeUVCYlRjbGZsQWdP?=
 =?utf-8?B?Wjlka0daSmxNZzlCQW9rcjZSN3N3MzVLTERLa2RkMllYWTEraW5EM25iazlX?=
 =?utf-8?B?WW91UEVvS3lNalppdklLS1huSEIvRTJmMmNLNTZCRGJJRUt6Y1BhVXJEZDZX?=
 =?utf-8?B?dldyVlpEcWlOVnUrOGtZRGp3cjVoUGxLeGV3OE1JaGdUeEZZVjlaMFRjMXVK?=
 =?utf-8?B?OVJVVEM2bU1rY043MkJDSnJ4VkFrU0tXVCszN255SHBwNVhLekhJRWMwYXFo?=
 =?utf-8?B?VGg5VERVNEdGQmMxWlZDNzI2UEg1NHQyUUNmeGRUZ0JXWHZmdnJhd1RMeElk?=
 =?utf-8?B?SGFERldGSE85Y2hlY3NDajZzSGNjNlgwTlQ3RlB0OGQ2SHUzakR1T055NVJV?=
 =?utf-8?B?QVhPYndwUGM0cXN1WU1MSkZqQ0tOMXV4b1VMV2pkeFNqbUx0U1ZhMFZ2VTZJ?=
 =?utf-8?B?MmxPWGRyRlpTTHVnWjZrekRFVXdXZk5XaGNkTFZMcnNYcEc4SU9xZ1FSUEcv?=
 =?utf-8?B?UVA2ZmFuR3pmTk54SHIyOUtadStVRDZPSHlzWnZ4SFFNT1ZpZ01DUFpRZXor?=
 =?utf-8?B?SmFRU1IzcWtUZ0VBME1tY3FFNExWMWt2TjFVOFJlNVg2RHhFVXBSZjhFcGla?=
 =?utf-8?B?TUpaNkNyWmVNUGNlZmoxVURZaGFoTU9iVW9WM1l0NXhvZ0EzYXNsTW1XSGpS?=
 =?utf-8?B?MDhxZi8rZU84MENQcjExUTZxU3FrNFY0Ty9TUUMvdTVkUWlQYkJHWEdHL2VJ?=
 =?utf-8?B?eWFaWU1Sbkt0ZDhFai94RFVBMUc2dTc4KzA2ajJmVFB4dHdTbGlzNTJMczFE?=
 =?utf-8?B?WUZ6aXU5MzhIVi9oZzl3VEJka0xJc2tpdzFIdEtpYW4vV0h3SVltOXUyaXU2?=
 =?utf-8?B?ckV0UisvdUFrUndWYmY0SnpET1N1QWN6bTVFaUNFUGFxbjNaYW9xYWZ6Ujhi?=
 =?utf-8?B?K0U0K2g2cllYSUFvSm9TQ1FRSFkwWDVicTI1bjBOWFhsaS9kbXAzQUVnTTg1?=
 =?utf-8?B?VE9FeFhSMSt0aFNxQUI2QjlaQWFiTGJYcWVxV1pVTExRMHhNbUEwM0trb0VS?=
 =?utf-8?B?c0dSSmhxczBhVmxOV083REIzSnpFVWRxVlRPZFMwWTlvSms1anhvVC85KzZZ?=
 =?utf-8?B?cjgvaXppd1Y2Y2NVamFoSUZ2WVNSTXJxbkh4NnZwT0VtQWRvaHVibEdpbEhH?=
 =?utf-8?B?eUZmUG5YV1ZnWFFKM1Z3Q3Zac1hZWDIvYTZYb1M1a1kwcmRKeFNsZUllaWdK?=
 =?utf-8?B?UWpaSkFQWG81NUQyRWxzd3VGck02SUFyZlkrbk1LVmIwdWRIcVMzdXp2UjRS?=
 =?utf-8?B?Y3pEWWk0UFR0NnA2cEk0NTVyQUk2Q1c1b2ZuRE1mbEtJZW0yWUkvQmlhaXI2?=
 =?utf-8?Q?g0fg41YAj7q6vJkbNcAiZLknJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99B6B8D253C8264DA8A0B5BEB8B9BEE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaf437e-7c8b-41b0-e646-08dca612ce16
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 03:44:47.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c01fC91CXhWoNu7pBeqYo/ydUA+309MDyvHYBUMDehQSm5bXOZH06RQA7F85pBZFT+iHowyiixTiRQ84auaFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8270

T24gV2VkLCAyMDI0LTA3LTE3IGF0IDEwOjI1ICswODAwLCBCb3kuV3Ugd3JvdGU6DQo+IE9uIFR1
ZSwgMjAyNC0wNy0xNiBhdCAxMToxMyAtMTAwMCwgVGVqdW4gSGVvIHdyb3RlOg0KPiA+ICAJIA0K
PiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzDQo+ID4gdW50aWwNCj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiA+ICBIZWxsbywgQm95Lg0KPiA+IA0KPiA+IFNvLCBsb29raW5nIGF0
IHRoZSBwYXRjaCwgSSdtIG5vdCBzdXJlIHBlci1ibGtnIGxvY2sgbWFrZXMgc2Vuc2UuDQo+ID4g
DQo+ID4gT24gVHVlLCBKdWwgMTYsIDIwMjQgYXQgMDM6NTI6MDZQTSArMDgwMCwgYm95Lnd1IHdy
b3RlOg0KPiA+ID4gQEAgLTk5NSwxNSArOTk1LDEzIEBAIHN0YXRpYyB2b2lkIGJsa2NnX2lvc3Rh
dF91cGRhdGUoc3RydWN0DQo+ID4gDQo+ID4gYmxrY2dfZ3EgKmJsa2csIHN0cnVjdCBibGtnX2lv
c3RhdCAqY3VyLA0KPiA+ID4gIHN0cnVjdCBibGtnX2lvc3RhdCAqbGFzdCkNCj4gPiA+ICB7DQo+
ID4gPiAgc3RydWN0IGJsa2dfaW9zdGF0IGRlbHRhOw0KPiA+ID4gLXVuc2lnbmVkIGxvbmcgZmxh
Z3M7DQo+ID4gPiAgDQo+ID4gPiAgLyogcHJvcGFnYXRlIHBlcmNwdSBkZWx0YSB0byBnbG9iYWwg
Ki8NCj4gPiA+IC1mbGFncyA9IHU2NF9zdGF0c191cGRhdGVfYmVnaW5faXJxc2F2ZSgmYmxrZy0+
aW9zdGF0LnN5bmMpOw0KPiA+ID4gK2d1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZibGtnLT5pb3N0
YXQuc3BpbmxvY2spOw0KPiA+ID4gIGJsa2dfaW9zdGF0X3NldCgmZGVsdGEsIGN1cik7DQo+ID4g
PiAgYmxrZ19pb3N0YXRfc3ViKCZkZWx0YSwgbGFzdCk7DQo+ID4gPiAgYmxrZ19pb3N0YXRfYWRk
KCZibGtnLT5pb3N0YXQuY3VyLCAmZGVsdGEpOw0KPiA+ID4gIGJsa2dfaW9zdGF0X2FkZChsYXN0
LCAmZGVsdGEpOw0KPiA+ID4gLXU2NF9zdGF0c191cGRhdGVfZW5kX2lycXJlc3RvcmUoJmJsa2ct
Pmlvc3RhdC5zeW5jLCBmbGFncyk7DQo+ID4gPiAgfQ0KPiA+IA0KPiA+IFRoaXMgaXMgYWxyZWFk
eSBjYWxsZWQgd2l0aCBibGtnX3N0YXRfbG9jayBoZWxkLg0KPiANCj4gSW4gYmxrY2dfaW9zdGF0
X3VwZGF0ZSwgaXQgaXMgcHJvdGVjdGVkIGJ5IGJvdGggYmxrZ19zdGF0X2xvY2sgYW5kDQo+IHU2
NA0KPiBzeW5jLiBJIGFncmVlIHRoYXQgbm8gY2hhbmdlcyBhcmUgbmVlZGVkIGhlcmUuDQo+IA0K
PiA+IA0KPiA+ID4gQEAgLTEwNTEsMTAgKzEwNDgsOCBAQCBzdGF0aWMgdm9pZCBfX2Jsa2NnX3Jz
dGF0X2ZsdXNoKHN0cnVjdA0KPiA+ID4gYmxrY2cNCj4gPiANCj4gPiAqYmxrY2csIGludCBjcHUp
DQo+ID4gPiAgZ290byBwcm9wYWdhdGVfdXA7IC8qIHByb3BhZ2F0ZSB1cCB0byBwYXJlbnQgb25s
eSAqLw0KPiA+ID4gIA0KPiA+ID4gIC8qIGZldGNoIHRoZSBjdXJyZW50IHBlci1jcHUgdmFsdWVz
ICovDQo+ID4gPiAtZG8gew0KPiA+ID4gLXNlcSA9IHU2NF9zdGF0c19mZXRjaF9iZWdpbigmYmlz
Yy0+c3luYyk7DQo+ID4gPiArc2NvcGVkX2d1YXJkKHNwaW5sb2NrX2lycXNhdmUsICZiaXNjLT5z
cGlubG9jaykNCj4gPiA+ICBibGtnX2lvc3RhdF9zZXQoJmN1ciwgJmJpc2MtPmN1cik7DQo+ID4g
PiAtfSB3aGlsZSAodTY0X3N0YXRzX2ZldGNoX3JldHJ5KCZiaXNjLT5zeW5jLCBzZXEpKTsNCj4g
PiANCj4gPiBUaGlzIGlzIHBlci1jcHUgc3RhdCBhbmQgd2Ugc2hvdWxkIGtlZXAgdXNpbmcgdTY0
X3N5bmMgZm9yIHRoZW0uDQo+ID4gDQo+ID4gPiBAQCAtMTEzNCw5ICsxMTI4LDggQEAgc3RhdGlj
IHZvaWQgYmxrY2dfZmlsbF9yb290X2lvc3RhdHModm9pZCkNCj4gPiA+ICBjcHVfZGtzdGF0cy0+
c2VjdG9yc1tTVEFUX0RJU0NBUkRdIDw8IDk7DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+ID4gLWZs
YWdzID0gdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbl9pcnFzYXZlKCZibGtnLT5pb3N0YXQuc3luYyk7
DQo+ID4gPiArZ3VhcmQoc3BpbmxvY2tfaXJxc2F2ZSkoJmJsa2ctPmlvc3RhdC5zcGlubG9jayk7
DQo+ID4gPiAgYmxrZ19pb3N0YXRfc2V0KCZibGtnLT5pb3N0YXQuY3VyLCAmdG1wKTsNCj4gPiA+
IC11NjRfc3RhdHNfdXBkYXRlX2VuZF9pcnFyZXN0b3JlKCZibGtnLT5pb3N0YXQuc3luYywgZmxh
Z3MpOw0KPiA+ID4gIH0NCj4gPiA+ICB9DQo+ID4gDQo+ID4gLi4uDQo+ID4gPiBAQCAtMTE1Nywx
NiArMTE0OSwxNCBAQCBzdGF0aWMgdm9pZCBibGtjZ19wcmludF9vbmVfc3RhdChzdHJ1Y3QNCj4g
PiANCj4gPiBibGtjZ19ncSAqYmxrZywgc3RydWN0IHNlcV9maWxlICpzKQ0KPiA+ID4gIA0KPiA+
ID4gIHNlcV9wcmludGYocywgIiVzICIsIGRuYW1lKTsNCj4gPiA+ICANCj4gPiA+IC1kbyB7DQo+
ID4gPiAtc2VxID0gdTY0X3N0YXRzX2ZldGNoX2JlZ2luKCZiaXMtPnN5bmMpOw0KPiA+ID4gLQ0K
PiA+ID4gK3Njb3BlZF9ndWFyZChzcGlubG9ja19pcnFzYXZlLCAmYmlzLT5zcGlubG9jaykgew0K
PiA+ID4gIHJieXRlcyA9IGJpcy0+Y3VyLmJ5dGVzW0JMS0dfSU9TVEFUX1JFQURdOw0KPiA+ID4g
IHdieXRlcyA9IGJpcy0+Y3VyLmJ5dGVzW0JMS0dfSU9TVEFUX1dSSVRFXTsNCj4gPiA+ICBkYnl0
ZXMgPSBiaXMtPmN1ci5ieXRlc1tCTEtHX0lPU1RBVF9ESVNDQVJEXTsNCj4gPiA+ICByaW9zID0g
YmlzLT5jdXIuaW9zW0JMS0dfSU9TVEFUX1JFQURdOw0KPiA+ID4gIHdpb3MgPSBiaXMtPmN1ci5p
b3NbQkxLR19JT1NUQVRfV1JJVEVdOw0KPiA+ID4gIGRpb3MgPSBiaXMtPmN1ci5pb3NbQkxLR19J
T1NUQVRfRElTQ0FSRF07DQo+ID4gPiAtfSB3aGlsZSAodTY0X3N0YXRzX2ZldGNoX3JldHJ5KCZi
aXMtPnN5bmMsIHNlcSkpOw0KPiA+ID4gK30NCj4gPiANCj4gPiBUaGUgYWJvdmUgdHdvIGFyZSB0
aGUgb25seSBwbGFjZXMgd2hpY2ggY2FuIHBvdGVudGlhbGx5IGJlbmVmaXQNCj4gPiBmcm9tDQo+
ID4gcGVyLWJsa2cgbG9jayBidXQgdGhlc2UgYXJlbid0IGhvdCBwYXRocy4gSSdkIGp1c3QgdXNl
DQo+ID4gYmxrZ19zdGF0X2xvY2sNCj4gPiBmb3INCj4gPiB0aGUgYWJvdmUuDQo+IA0KPiBJbiBf
X2Jsa2NnX3JzdGF0X2ZsdXNoLCB1NjQgc3luYyBpcyB1c2VkIGZvciBmZXRjaGluZyBkYXRhLCBj
aGFuZ2luZw0KPiB0bw0KPiBzcGlubG9jayB3aWxsIGluY3JlYXNlIG92ZXJoZWFkIGJvdGggNjQg
Yml0IGFuZCAzMiBiaXQgc3lzdGVtcy4gNjQNCj4gYml0DQo+IHN5c3RlbXMgZG8gbm90aW5nIGlu
IHU2NCBzeW5jLCBhbmQgMzIgYml0IHN5c3RlbXMgY2FuIHJlYWQgZGF0YSBpbg0KPiBwYXJhbGxl
bCBpbiB1NjQgc3luYyBpZiBubyBvbmUgdXBkYXRpbmcgZGF0YS4gSG93ZXZlciwgaXQgaXMgYWxy
ZWFkeQ0KPiBwcm90ZWN0ZWQgYnkgYmxrZ19zdGF0X2xvY2ssIHNvIHRoZXJlIGlzIG5vIHBhcmFs
bGVsaXNtIG5vdywgYW5kDQo+IHRoZXJlDQo+IGlzIG5vIGlzc3VlIGhlcmUuIEkgdGhpbmsgdGhh
dCBubyBjaGFuZ2VzIGFyZSBuZWVkZWQgaGVyZS4NCj4gDQo+IEluIGJsa2NnX2ZpbGxfcm9vdF9p
b3N0YXRzLCB0aGlzIGlzIHdoZXJlIHRoZSBpc3N1ZSBoYXBwZW5zIGluIDMyIGJpdA0KPiBTTVAg
c3lzdGVtcywgc28gc3BpbmxvY2sgbmVlZHMgdG8gYmUgYWRkZWQgdG8gcHJvdGVjdCBpdC4NCj4g
DQo+IEluIGJsa2NnX3ByaW50X29uZV9zdGF0LCB1NjQgc3luYyBpcyB1c2VkIGZvciBmZXRjaGlu
ZyBkYXRhLiBDaGFuZ2luZw0KPiB0byBzcGlubG9jayB3aWxsIGluY3JlYXNlIG92ZXJoZWFkIGxp
a2UgaW4gX19ibGtjZ19yc3RhdF9mbHVzaC4NCj4gSG93ZXZlciwgaXQgaXMgYWxyZWFkeSBwcm90
ZWN0ZWQgYnkgc3Bpbl9sb2NrX2lycSgmYmxrZy0+cS0NCj4gPnF1ZXVlX2xvY2spIA0KPiBpbiBi
bGtjZ19wcmludF9zdGF0LCBzbyB0aGVyZSBpcyBubyBwYXJhbGxlbGlzbSBub3csIGFuZCB0aGVy
ZSBpcyBubw0KPiBpc3N1ZSBoZXJlLiBJIHRoaW5rIHRoYXQgbm8gY2hhbmdlcyBhcmUgbmVlZGVk
IGhlcmUuDQo+IA0KPiA+IA0KPiA+ID4gQEAgLTIxNTIsMzAgKzIxNDEsMjkgQEAgdm9pZCBibGtf
Y2dyb3VwX2Jpb19zdGFydChzdHJ1Y3QgYmlvDQo+ID4gPiAqYmlvKQ0KPiA+ID4gIA0KPiA+ID4g
IGNwdSA9IGdldF9jcHUoKTsNCj4gPiA+ICBiaXMgPSBwZXJfY3B1X3B0cihiaW8tPmJpX2Jsa2ct
Pmlvc3RhdF9jcHUsIGNwdSk7DQo+ID4gPiAtZmxhZ3MgPSB1NjRfc3RhdHNfdXBkYXRlX2JlZ2lu
X2lycXNhdmUoJmJpcy0+c3luYyk7DQo+ID4gPiAtDQo+ID4gPiAtLyoNCj4gPiA+IC0gKiBJZiB0
aGUgYmlvIGlzIGZsYWdnZWQgd2l0aCBCSU9fQ0dST1VQX0FDQ1QgaXQgbWVhbnMgdGhpcyBpcyBh
DQo+ID4gDQo+ID4gc3BsaXQNCj4gPiA+IC0gKiBiaW8gYW5kIHdlIHdvdWxkIGhhdmUgYWxyZWFk
eSBhY2NvdW50ZWQgZm9yIHRoZSBzaXplIG9mIHRoZQ0KPiA+IA0KPiA+IGJpby4NCj4gPiA+IC0g
Ki8NCj4gPiA+IC1pZiAoIWJpb19mbGFnZ2VkKGJpbywgQklPX0NHUk9VUF9BQ0NUKSkgew0KPiA+
ID4gLWJpb19zZXRfZmxhZyhiaW8sIEJJT19DR1JPVVBfQUNDVCk7DQo+ID4gPiAtYmlzLT5jdXIu
Ynl0ZXNbcndkXSArPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZTsNCj4gPiA+IC19DQo+ID4gPiAtYmlz
LT5jdXIuaW9zW3J3ZF0rKzsNCj4gPiA+ICtzY29wZWRfZ3VhcmQoc3BpbmxvY2tfaXJxc2F2ZSwg
JmJpcy0+c3BpbmxvY2spIHsNCj4gPiA+ICsvKg0KPiA+ID4gKyAqIElmIHRoZSBiaW8gaXMgZmxh
Z2dlZCB3aXRoIEJJT19DR1JPVVBfQUNDVCBpdCBtZWFucyB0aGlzIGlzIGENCj4gPiANCj4gPiBz
cGxpdA0KPiA+ID4gKyAqIGJpbyBhbmQgd2Ugd291bGQgaGF2ZSBhbHJlYWR5IGFjY291bnRlZCBm
b3IgdGhlIHNpemUgb2YgdGhlDQo+ID4gDQo+ID4gYmlvLg0KPiA+ID4gKyAqLw0KPiA+ID4gK2lm
ICghYmlvX2ZsYWdnZWQoYmlvLCBCSU9fQ0dST1VQX0FDQ1QpKSB7DQo+ID4gPiArYmlvX3NldF9m
bGFnKGJpbywgQklPX0NHUk9VUF9BQ0NUKTsNCj4gPiA+ICtiaXMtPmN1ci5ieXRlc1tyd2RdICs9
IGJpby0+YmlfaXRlci5iaV9zaXplOw0KPiA+ID4gK30NCj4gPiA+ICtiaXMtPmN1ci5pb3Nbcndk
XSsrOw0KPiA+ID4gIA0KPiA+ID4gLS8qDQo+ID4gPiAtICogSWYgdGhlIGlvc3RhdF9jcHUgaXNu
J3QgaW4gYSBsb2NrbGVzcyBsaXN0LCBwdXQgaXQgaW50byB0aGUNCj4gPiA+IC0gKiBsaXN0IHRv
IGluZGljYXRlIHRoYXQgYSBzdGF0IHVwZGF0ZSBpcyBwZW5kaW5nLg0KPiA+ID4gLSAqLw0KPiA+
ID4gLWlmICghUkVBRF9PTkNFKGJpcy0+bHF1ZXVlZCkpIHsNCj4gPiA+IC1zdHJ1Y3QgbGxpc3Rf
aGVhZCAqbGhlYWQgPSB0aGlzX2NwdV9wdHIoYmxrY2ctPmxoZWFkKTsNCj4gPiA+ICsvKg0KPiA+
ID4gKyAqIElmIHRoZSBpb3N0YXRfY3B1IGlzbid0IGluIGEgbG9ja2xlc3MgbGlzdCwgcHV0IGl0
IGludG8gdGhlDQo+ID4gPiArICogbGlzdCB0byBpbmRpY2F0ZSB0aGF0IGEgc3RhdCB1cGRhdGUg
aXMgcGVuZGluZy4NCj4gPiA+ICsgKi8NCj4gPiA+ICtpZiAoIVJFQURfT05DRShiaXMtPmxxdWV1
ZWQpKSB7DQo+ID4gPiArc3RydWN0IGxsaXN0X2hlYWQgKmxoZWFkID0gdGhpc19jcHVfcHRyKGJs
a2NnLT5saGVhZCk7DQo+ID4gPiAgDQo+ID4gPiAtbGxpc3RfYWRkKCZiaXMtPmxub2RlLCBsaGVh
ZCk7DQo+ID4gPiAtV1JJVEVfT05DRShiaXMtPmxxdWV1ZWQsIHRydWUpOw0KPiA+ID4gK2xsaXN0
X2FkZCgmYmlzLT5sbm9kZSwgbGhlYWQpOw0KPiA+ID4gK1dSSVRFX09OQ0UoYmlzLT5scXVldWVk
LCB0cnVlKTsNCj4gPiA+ICt9DQo+ID4gDQo+ID4gVGhlc2UgYXJlIHBlci1jcHUgc3RhdCB1cGRh
dGVzIHdoaWNoIHNob3VsZCBrZWVwIHVzaW5nIHU2NF9zeW5jLiBXZQ0KPiA+IGRvbid0DQo+ID4g
d2FudCB0byBpbmN1ciBsb2NraW5nIG92ZXJoZWFkIGZvciBzdGF0IHVwZGF0ZXMgaW4gdGhlIGhv
dCBpc3N1ZQ0KPiA+IHBhdGguDQo+ID4gDQo+IA0KPiBJIGFncmVlIHRoYXQgbm8gY2hhbmdlcyBh
cmUgbmVlZGVkIGluIGJsa19jZ3JvdXBfYmlvX3N0YXJ0Lg0KPiANCj4gPiBUaGFua3MuDQo+ID4g
DQo+ID4gLS0gDQo+ID4gdGVqdW4NCj4gDQo+IEkgdGhpbmsgd2UgY2FuIGxvb2sgYmFjayB0byB0
aGUgb3JpZ2luYWwgaXNzdWUsIHdoaWNoIGlzIHRoYXQgb24gMzINCj4gYml0DQo+IFNNUCBzeXN0
ZW1zIHdpbGwgaGF2ZSBjb25jdXJyZW50IHByb2JsZW1zIG9uDQo+IHU2NF9zdGF0c191cGRhdGVf
YmVnaW5faXJxc2F2ZSBhbmQgdTY0X3N0YXRzX3VwZGF0ZV9lbmRfaXJxcmVzdG9yZSBpbg0KPiBi
bGtjZ19maWxsX3Jvb3RfaW9zdGF0cy4gU28sIGFkZGluZyBhIGxvY2sgb25seSBvbiAzMiBiaXRz
IHN5c3RlbXMNCj4gaW4gYmxrY2dfZmlsbF9yb290X2lvc3RhdHMgaXMgdG8gcmVzb2x2ZSB0aGUg
Y29uY3VycmVudCBpc3N1ZSBhbmQgbm90DQo+IGFmZmVjdCA2NCBiaXQgc3lzdGVtcywgd2hpY2gg
ZG8gbm90IGhhdmUgdGhlIGlzc3VlIGluIHRoZSBmaXJzdA0KPiBwbGFjZSwNCj4gYmVjYXVzZSB1
NjQgc3luYyBkb2VzIG5vdGluZyBpbiA2NCBiaXQgc3lzdGVtcyBhbmQgdGhleSBkb24ndCBuZWVk
DQo+IGl0Lg0KPiANCj4gSSB0aGluayB3ZSBjYW4ganVzdCBmaXggaXQgYnkgZm9sbG93aW5nIGNo
YW5nZS4NCj4gDQo+IEBAIC0xMTM0LDkgKzExMjgsOCBAQCBzdGF0aWMgdm9pZCBibGtjZ19maWxs
X3Jvb3RfaW9zdGF0cyh2b2lkKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNw
dV9ka3N0YXRzLT5zZWN0b3JzW1NUQVRfRElTQ0FSRF0gPDwNCj4gOTsNCj4gICAgICAgICAgICAg
ICAgIH0NCj4gDQo+ICsjaWYgQklUU19QRVJfTE9ORyA9PSAzMg0KPiArICAgICAgICAgICAgICAg
Z3VhcmQoc3BpbmxvY2tfaXJxc2F2ZSkoJmJsa2dfc3RhdF9sb2NrKTsNCj4gKyNlbmRpZg0KPiAg
ICAgICAgICAgICAgICAgZmxhZ3MgPSB1NjRfc3RhdHNfdXBkYXRlX2JlZ2luX2lycXNhdmUoJmJs
a2ctDQo+ID4gaW9zdGF0LnN5bmMpOw0KPiANCj4gICAgICAgICAgICAgICAgIGJsa2dfaW9zdGF0
X3NldCgmYmxrZy0+aW9zdGF0LmN1ciwgJnRtcCk7DQo+ICAgICAgICAgICAgICAgICB1NjRfc3Rh
dHNfdXBkYXRlX2VuZF9pcnFyZXN0b3JlKCZibGtnLT5pb3N0YXQuc3luYywNCj4gZmxhZ3MpOw0K
PiAgICAgICAgIH0NCj4gIH0NCg0KSSB0aGluayB0aGVyZSBpcyBhbm90aGVyIHdheSB0byBmaXgg
aXQuIE1heWJlIHdlIHNob3VsZCBhZGRyZXNzIHRoZQ0Kcm9vdCBjYXVzZSwgd2hpY2ggaXMgdGhh
dCB1NjRfc3RhdHNfdXBkYXRlX2JlZ2luX2lycXNhdmUNCmFuZCB1NjRfc3RhdHNfdXBkYXRlX2Vu
ZF9pcnFyZXN0b3JlIGRvIG5vdCBwcm90ZWN0IHRoZSBzZXFjb3VudCBpbiAzMg0KYml0IFNNUCBz
eXN0ZW1zLiBUaGlzIGNhbiBiZSBmaXggYnkgdGhlIGZvbGxvd2luZyBjaGFuZ2UuDQoNCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3U2NF9zdGF0c19zeW5jLmgNCmIvaW5jbHVkZS9saW51eC91
NjRfc3RhdHNfc3luYy5oDQppbmRleCA0NjA0MGQ2NjMzNGEuLjk0ZGQ3NGI0ZmIyYyAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvdTY0X3N0YXRzX3N5bmMuaA0KKysrIGIvaW5jbHVkZS9saW51
eC91NjRfc3RhdHNfc3luYy5oDQpAQCAtNjQsNiArNjQsNyBAQA0KIHN0cnVjdCB1NjRfc3RhdHNf
c3luYyB7DQogI2lmIEJJVFNfUEVSX0xPTkcgPT0gMzINCiAgICAgICAgc2VxY291bnRfdCAgICAg
IHNlcTsNCisgICAgICAgc3BpbmxvY2tfdCAgICAgIHNwaW5sb2NrOw0KICNlbmRpZg0KIH07DQoN
CkBAIC0xMzgsNiArMTM5LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHU2NF9zdGF0c19pbmModTY0
X3N0YXRzX3QgKnApDQogc3RhdGljIGlubGluZSB2b2lkIHU2NF9zdGF0c19pbml0KHN0cnVjdCB1
NjRfc3RhdHNfc3luYyAqc3luY3ApDQogew0KICAgICAgICBzZXFjb3VudF9pbml0KCZzeW5jcC0+
c2VxKTsNCisgICAgICAgc3Bpbl9sb2NrX2luaXQoJnN5bmNwLT5zcGlubG9jaykNCiB9DQoNCiBz
dGF0aWMgaW5saW5lIHZvaWQgX191NjRfc3RhdHNfdXBkYXRlX2JlZ2luKHN0cnVjdCB1NjRfc3Rh
dHNfc3luYw0KKnN5bmNwKQ0KQEAgLTE5MSw2ICsxOTMsNyBAQCBzdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGxvbmcNCnU2NF9zdGF0c191cGRhdGVfYmVnaW5faXJxc2F2ZShzdHJ1Y3QgdTY0X3N0YXRz
X3N5bmMNCiB7DQogICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MgPSBfX3U2NF9zdGF0c19pcnFz
YXZlKCk7DQoNCisgICAgICAgc3Bpbl9sb2NrX2lycSgmc3luY3AtPnNwaW5sb2NrKTsNCiAgICAg
ICAgX191NjRfc3RhdHNfdXBkYXRlX2JlZ2luKHN5bmNwKTsNCiAgICAgICAgcmV0dXJuIGZsYWdz
Ow0KIH0NCkBAIC0xOTksNiArMjAyLDcgQEAgc3RhdGljIGlubGluZSB2b2lkDQp1NjRfc3RhdHNf
dXBkYXRlX2VuZF9pcnFyZXN0b3JlKHN0cnVjdCB1NjRfc3RhdHNfc3luYyAqc3luY3AsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIGZsYWdzKQ0KIHsNCiAgICAgICAgX191NjRfc3RhdHNfdXBkYXRlX2VuZChzeW5jcCk7DQor
ICAgICAgIHNwaW5fdW5sb2NrX2lycSgmc3luY3AtPnNwaW5sb2NrKTsNCiAgICAgICAgX191NjRf
c3RhdHNfaXJxcmVzdG9yZShmbGFncyk7DQogfQ0KDQotLQ0KYm95Lnd1DQoNCg==

