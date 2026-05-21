Return-Path: <cgroups+bounces-16144-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKY3ACuQDmqt/wUAu9opvQ
	(envelope-from <cgroups+bounces-16144-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 06:55:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD859EE71
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 06:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEBE83026240
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 04:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC2336882;
	Thu, 21 May 2026 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fNteNa3d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lsG9Q/EY"
X-Original-To: cgroups@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB03101B6;
	Thu, 21 May 2026 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339302; cv=fail; b=cP0XRmneDqC3ONPrNGXkjiJD2WrZmiia6SV9l98CUq5fXJFtOvVhTMyEdy+99m6XO2KudxMmBMb2zwj83EJRsOsVF4hs0lzpo4LO2hEnbtlZ/rlIVNKxW3NRps2rACe9RO6dVuxGMCBKWT1hieXJFS3G4Ar/O4XVq778FXclj1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339302; c=relaxed/simple;
	bh=w1mHhPZXnP9PHDpgYd0jm9GT+91v9yUmXscivLcG3N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UxjBL2TIhv25IYirp1eOs/bkWxSiYLV1mxg3WcVhN4KpdnrqZod2KBVTkwsVd0XJxzrUdvvtW7Mfa3R2Y7smiUkGRVOYoAdt0z/lvbBBPVGVsddR6xWfzX93yOIefhc70ycB+kST/fiJPl4yBo1aSXqDOmJvUJ2sUQbBqFHQBV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fNteNa3d; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lsG9Q/EY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779339301; x=1810875301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w1mHhPZXnP9PHDpgYd0jm9GT+91v9yUmXscivLcG3N4=;
  b=fNteNa3dgkPBbL4zbUCrlZQtNNPcgJ/KI1YoPdfmhkZqkJ7IaCG5ZeT5
   tR3ACmFdna3LoR6qV9shzUqqkvbhSQS1PyvLV685F2/kZa6fKR3DRPyXb
   6kF0FWkI0k9TsM+GUZPnMx1W37jMjW3n9JwDxcafiq/QNLsymN8ZC5MqF
   Q6jmmrkqnpLXbKz+RTKvpBKrh0THqkhtN0mO7fMCUVbh9ZCHKMYWiYQ+t
   37K/8LWQckrei3McuOHGjl2KHKtyJCLiuc2kHXILh95ohil2+agRASLFJ
   lirrvSUIsxSYP53YYgNqpWiuT0loN7dzIofHny4+uLwlEAtUPqFTwQj6A
   Q==;
X-CSE-ConnectionGUID: sVWecuhfQZWs5XtIViM8RQ==
X-CSE-MsgGUID: FMECXSsITgitNG21Qin47g==
X-IronPort-AV: E=Sophos;i="6.23,245,1770566400"; 
   d="scan'208";a="147388040"
Received: from mail-westus3azon11012024.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.24])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2026 12:54:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usaGQU5nR12+9AqYuKhcy2LMLkYbW6qyAdUVGqiqQO+Gn7JooHmWoaDFdiF7yrJZlvz/oUAQFAOLe2nAfLazjO+ImxT1R6ZF6mWPaaKY40vQUHjXgTh7n2PPXNl4weoDqY/z6DiqK1X61B/EBpFq8ISVpF73qhsmZyiQmyrslJRRGkZ6sd6+Mo39+81F/r47IrpHpCISLedlkVUHueuoHxKESIuUBF3RHgol49qVrpLSzBXC8Dk5j8M9+1ClBzTLUOkKbnHPnSIZIOAl9Q19tP4d818DRW/H9tYA1Quen9GrRou0c9V9T2F50kk7RxhaNXW7C76ZoRAwK1qrbGRD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUvD09q3bnigNbaesUKq8rlksFmhAx4ZOINP8rk24LY=;
 b=PZeBy5oGXHeavfb+eZPXxWTtcKjSRfz+LHNRapcYnmLDySpPZ/lUj96EBDb15dZzmYwICAh8Op+HEmDt88u6ztuAM6/D/Q4n2M04RRB0QzKADcRqXpMe7jZmvghxqjlSQ9lIh+Yg0Z6ofeMppEqxFwfLVZtkmEa8Ot+u9ln2Gbwq08ok/sUZXI2xlrf4yhQjjgC4tS1xmDmF5u9Rp/YY4/B4PJQUffm+EBP/dVRwrhHiwdU1JAogfczpH8MtWmseIj0dXyHnZeGQQfBkhTQ/xOP2YQRNEXl44dSgKBFLvMEgBsm9KExIc4Kog2di+Ko4Vog5QdV4VCnSoz7i1X18pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUvD09q3bnigNbaesUKq8rlksFmhAx4ZOINP8rk24LY=;
 b=lsG9Q/EYUOdRio3b5gPkFDsRHBNUbM+h9oZFvmRSA31TzMLWOcV5MTdAPRmAXeADM3lm/A/HIfpzfmHcrlwD9YNO2P3vw3EuRskPzG8g3MfvFelVSGQJHCa+vAaBSmS0YguIwTNAzgvF8XiFHKkLWsAigGa35x3c8j2P46wfg2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV3PR04MB9068.namprd04.prod.outlook.com
 (2603:10b6:408:275::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 04:54:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:54:50 +0000
Date: Thu, 21 May 2026 13:54:43 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: axboe@kernel.dk, cgroups@vger.kernel.org, josef@toxicpanda.com, 
	linux-block@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH] blk-throttle: schedule parent dispatch in tg_flush_bios()
Message-ID: <ag6OXDuTc3JubfqV@shinmob>
References: <ag2owaQQoigp_fSV@shinmob>
 <20260520142022.1799724-1-cuitao@kylinos.cn>
 <ag5DjOCrzfD7D_Ln@shinmob>
 <31179261-64e0-4950-b112-32627d48e734@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31179261-64e0-4950-b112-32627d48e734@kylinos.cn>
X-ClientProxiedBy: TY4P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV3PR04MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bb70f0-7529-490f-984a-08deb6f516c7
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|4143699003|22082099003|18002099003|11063799006|56012099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GdSXWmApBNltWXVJfaaeH3VzcUr4AnEc6ZY1LA2Z8oeVsliSZOFmeJNM8f6ZX1KrXgfjyx7s99sUHPCmuBVy4pzJRseDaXW7hk6En7ag9hfGtB6TMGeF5cik+a55D563BkfCva9ERH0nevLc0m5eoCrtsTwHai7EIf3nAaw+HDew3APeIa/ZhKvGNK2hAXxURxgdFOs329KMpd6DLVHXFuAbYQJEoxEG3bC0tkbEd2qktmw+VyHm4ELIi+bX3rwP+qoi5v8f2E1GV1A6kzLdLa3OwpJkmLGSj8fYTphSjnuyEDzt824XntYfwniSdMlGxZZ6V7AdkAI6pnE470opm3cAJKmj0EtA6R8pjPNAihJsDFl2Mp0zdetdCkhWViOTy/v5hArwXW175Se63qp4doycuhpjWCbrOjD2Cx48lpcsrH9cmaVfGX8AkppStzUhlPFl94R1dDKySEFrjUhFvu39hoXQVejryal4eaAfIMW3gXvqi7oInMXIZQuB+1LhhkIFBItERjydmbEl/H4WtV90MAFYRBecAff2zQAnFOupndoo+RRCcnWZIAihhF0nab7TEfaIIb8/DwLBrKffq5vJel+wSWWr3GvcQ048BittcSbM7uhwiDuQkqy4+ewqXlSPZFXaBuY2ucrlmYZiztj+tXpljCUduVH+2x0+1MTjW1qeUpNU8QyXegnPuClH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(56012099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3PbRtJUhFbWShx/I8uTFBG8SzNOiLDmZalRD6NcfJxykCwO9gEXAUfNpE27?=
 =?us-ascii?Q?95ecN5O65oRYrsOnCmgnOxY6zZfy18SuJkX4gJTPUOPT4enXaXgj1Wz+DPY3?=
 =?us-ascii?Q?Sw96g8qh5bXIX+DmlUFtSqe+nyAbVqzNfUuXXaH5adPqhHT3Sg0pJQxkLIwV?=
 =?us-ascii?Q?wqlX5akKvQXLUzIlg3e6ZwxhEB6RpFP9YbWh2OL8v83Rrk/RNNy1t9zWs/2L?=
 =?us-ascii?Q?rLXkDQRkJsVBYjHRw501+0cYCGiYx1TwZzwjq+DF+TgJFukC3efuPzvFycS3?=
 =?us-ascii?Q?ycIdsz3PhqHf4jTmHU6szw+8yiUDiDmFTawrbW6lA7mAZ3YW/NBFeMItxCCp?=
 =?us-ascii?Q?t7BqeC7OkoIcaaTxTNOmLIw3+z1L8Bg2Dn2LkmXoZ/ELsPyIwUc7A2mQ4mah?=
 =?us-ascii?Q?NqxAHrwtDseWeVT7Tudx24D9ntvcdW8QBuyneWIIsQJoVdzKtqIybyjqLazP?=
 =?us-ascii?Q?rJ+CBluGzN6PZjTMPYRbJ5Ba9OiXtP+gdAUEOo02j+N7JBld8EC3oPRe4wo6?=
 =?us-ascii?Q?ImCmTDFz654gQjj7ZfmOQH5SGFmzoe94/6MbGI7sBBWcTtR87mmS5fPjSTHl?=
 =?us-ascii?Q?L85vNnVBF4SW/kmubsVN6fvSMbptscfzBxaICTpvsiXwv5z52lV5ll5Uz0o5?=
 =?us-ascii?Q?6eJZIm+aAqpKzR3i/94plA6xgjwY298QRXY2+/Pd76IjDQkDcPpXY2gWwtoX?=
 =?us-ascii?Q?zMdfFRNevCuLXXNjj/H48pHY2ud9I29/TLPOGNPvI04D1Cn0IC/EqbBNNH82?=
 =?us-ascii?Q?RStL6YF340ZcDx5M4putRX00BLxkje4Tl9NPVWz26U7KTeWd8/KhOBRQN0rA?=
 =?us-ascii?Q?PriPCoqUBOOC+vnFYfdDiiOgB/tpuY+Dr5OhxAHZ/KSJ0WuYhYiQUX8kRC/1?=
 =?us-ascii?Q?5mROJcA1D8i70br8lI5hVxAVfF9v5/mFSxiTkpUUOlb5hQlwmn3ydcftN2Ba?=
 =?us-ascii?Q?tYf6SJ1qLXEa1aotPzJ2crws81bke+ebV1W3p2vnz1NBJ1Zx1mQPC7kkiCM8?=
 =?us-ascii?Q?irV71I1SUy7M+4mDcsQXT4JM9fwF9AQv/kBeQlHAPKVfiWVb/261Scce1AlO?=
 =?us-ascii?Q?RHR3UqaAwexyLUXh2CIlDX5DMHq07ZBTR0rFxT/1YTx5h5Po/bpJnyHNIDzf?=
 =?us-ascii?Q?3kk7mw70JzsnOSFKV1ri+v17s/GWEiv2vE+/pZp8maJBysNQVvwaL5OW04Xs?=
 =?us-ascii?Q?jWf/aFJ5cvjGoj8Znlc8yqazq183q5Ok6kBZV6b4WAb2eS5QWfXMuAYzV5jV?=
 =?us-ascii?Q?5R8R/htCiOVHbErlJu/2Mj9paUPjbFOPjNAwq6S9CN2a+ZCKtnaaO84P8pHm?=
 =?us-ascii?Q?JIiYzEcPNud5iWMLU+gc/qs9BOV06vmDL+aPKGAgwtfMNrNt9wIX0Ab+fW7L?=
 =?us-ascii?Q?GSvmRt9jQzSM+WL8yGvmWVueloNBGYZpWme61MOBT3M1OY/MnmGmLu1j/y46?=
 =?us-ascii?Q?OhPWsGDWdaPEYAWmqbVYQKmRVNwu5b81Z+1MqvSR4SduY432mCwuHWUUpYp9?=
 =?us-ascii?Q?pTFj6IsHj3CrHnJ3T1e+t3RBUBs6hBPamJZbg0KLNAa2B0VZlC+vZLOr81Aa?=
 =?us-ascii?Q?RDV/NXfA8UxDhsZgczNIYW1mUO6MxTnB4mKXj2jz31UC9OhINTLLBU141V0Z?=
 =?us-ascii?Q?fG1dBnIRuuuyL5lIXw538gQGNr6xzYepctZEf3lZ/mnzMd1bdpgjhww66W/5?=
 =?us-ascii?Q?iP90Rf/tyDZh0rWos02nWw8xzFMVQqXgg3byKcr2axVZtOa1wC/uzqoTtnK/?=
 =?us-ascii?Q?bnXHWP3FBccBTXgp86zySvTcuXsLdF4=3D?=
X-Exchange-RoutingPolicyChecked:
	ewHewsbQR39QM6/bvVf+aTFLqN5VGegRqY5WPKI15WoHZSQczF7L5ft6XZ0tTBk9kP0J016ycHUOJ9SCXjuomCV0srcFA0Hy4zrJlzqk2Uetoxalor52yS+noIxTBkOOcea390zD8Qb5ro3VtFvdFRL20SXRbmQg9LgCa0HKmtOFbef4spuUw9nEPxjdMg+TQn3NzY55N0i4SmZwWUjEJK3f9g6MHPgNspiCFKp1JWaD0NBVuzr02d/sdXhNVjVlJdGS24juXHra0StylNQaw61AalvOiUoVYz3HYNIXkvzzoQmjYkBUrzUM4qjlj545I3HhnUIJ30wm+TwSFADp1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eRpbCbx5JhlpFwCcloy7Ubd3uX/FwKgf0pgQzfwIqNUJIwp5pfDlLiRH88k8ep+Kz6eqXz3BzEBbcMDVQfZBFJdrwHGQ3eAkuKMdhzpY/4DG1qzzavZaUlLBrY+TvGBxJizx+ogWIuxhdC4Rd9YFZmIE3NbwTK9JgtWXO6lFavcXYIhIggeXJWkDeP30ot11KdKno81BZdimUZeBGxjvn5KAs3XUZ0VgOSgRnJd/pT1/hqm45aCPeSGwqu6zbvYn0LbNhKFiOwUe/dYhE9soYJNTaKXwjm2+V7aVwbNzqYsu2dK6+e7OAHdesg1Wl5w1e5EUGMrzAhlq825BhCfvPHo5irtebUjyAiFbJMdFf8PG/0q02vqU1n0I112GgVkQPTpWGhQjWTsfPRCJAxHT/Lu46zTRIVZltewPHnujjcbm4VDb2PqItIzpuK5VC1Ctu2dYzBAhp5dJ1O+CfsIXbIapjJKR2vZ7GuoQGC32NbEL9Z+EaGlS5rwFP14XqIZr3VC1qpDRWZdJj03gSbg2YyL0F09/f9CTiGf5tZHtqOe1Zile3jvbEqBpS5Lv8H7p9l8IKC7n946CizEVvKbbErlSp3tbRutvBnV54QHZoZcsRsuJfFNz39L2p7xeqdrZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bb70f0-7529-490f-984a-08deb6f516c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:54:50.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV0b+sQnO0eY1X8fJbS4Y1rqnENBdMrt7mY33RRDNrYJ+Ya5GKJHAyG8cCJdSHgrthyldf2pR9T2TAUYQ3InGdOaYN1s8UcZKr9oNr5wrjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9068
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16144-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 93AD859EE71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 21, 2026 / 10:54, Tao Cui wrote:
...
> Could you check if your system has a non-English locale set? 

Thanks for trying it out. My system has Englihs locale.

$ locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

> If the issue persists after running with LC_ALL=C ./check throtl/004, I'll investigate further.

It still fails with LC_ALL=C.

# LC_ALL=C ./check throtl/004
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  1.250s  ...  1.211s
throtl/004 (sdebug) (delete disk while IO is throttled)      [failed]
    runtime  2.518s  ...  2.271s
    --- tests/throtl/004.out    2026-03-20 14:25:50.478000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/004.out.bad    2026-05-21 13:46:36.676000000 +0900
    @@ -1,3 +1,2 @@
     Running throtl/004
    -Input/output error
     Test complete


P.S. Through this action, I noticed that locale handling is an improvement point
     of blktests.

