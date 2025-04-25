Return-Path: <cgroups+bounces-7816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254DA9BC24
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3234B4C0D79
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56C1CAB3;
	Fri, 25 Apr 2025 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UMfxNlJw"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860C49620;
	Fri, 25 Apr 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543480; cv=fail; b=BobXod1k7Q7Y6Iitq3To0FiPalUzsm6i6bk0S5PU3GmpRrLcnRWDFZIspNckyOJzShoeMkNx1LVKgN5VPrsUiIrpxEH+9St1A+bSGOOGB6SaIT2bNME4X9ZQFjt0HZbidyx6dKD3a25N7KHUq9yqMlqhKUmWGNxZrCs046rO4sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543480; c=relaxed/simple;
	bh=CTylcipd5KmcMFk/Z5IF2FEd7v07YNW7x3B7WHm1KGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M3jYBwO0c8lqhlh6H0CaQP4KTwl48udXc2GFvS2JVxChsVq3NAgQlRe3UHLl2MGhY+cASwWlfJg/CLv4/LBiBdTlTjMzA25hPa1vOixbRnnZlJCVQJ0wtYV0azK2ei+HednYeqzQ0cl3cJwG/O8jOTA8JoEn4WPefCd6NnzOV6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UMfxNlJw; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGaD4TeBz9BiOXtTIbItB5zqeJ7HdZC3WkO4Da6ouZFBJEjw3t9om68mnJda3N8Cyvf8aRufb7EESwSJdf8xx+n9HOeQresxsONCLSTTl1D71y9NtrCZp/sjmoRgQynNDK0Yq5RxVXMnjU1Pq828RMAUp9qa06OQjpPhTJ5ps40bT+qx5VwzWdo6BbopuE7iyzh3m3BlT9g6a6cvlENq2cNaoyfcHHJDc0KrR9QmQqAo6jmMtyIXdm0eJc4i0xz3PddAHUdcPdmHLxEN3mfgmn3ciPZQbhSirwpusxXtdrD2g5ffDEykrPW8Q/Jw8oIwkYaU7HfcryKyGlyWD4IXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTylcipd5KmcMFk/Z5IF2FEd7v07YNW7x3B7WHm1KGU=;
 b=Q0Gj50bg33uk0pPpgoN1D04dMK3TOdaW0wdVdnulPkSGGH6aI1p98FH797qWOikAPzidxZWJOrDAYg9/LyemF20EkHpWluR9J9U2tpuieh3NZYI1lXzo+262CmteUb0XZgVsC26LOFfHw9AOBkzwlNTEwHOQCFW8IZVmiF9i7FuQTPqyVIz2i9AB662iGGSk+LdXkHUqLJY0Rzj8m0xzRJpXWMEOispoITCqgcaXEHPOibC1dcI0lFBk3LDEi1AcHypJ/IjMe5XNvHBTLrE3kthy3zYjsgr2mjgn2sHsJBAfZfKjhDjDe35R2puijhrESQdd7iVf5N/9Yqngmql/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTylcipd5KmcMFk/Z5IF2FEd7v07YNW7x3B7WHm1KGU=;
 b=UMfxNlJwD9c7m7Eq6OPDsZWtdIVje1+cHxsKtYMWoYJLx19POQuNW3sFk3Sx8xXEb9Lxrs9RRcusJ6yvZ0NWUyZPQu9lSCq+q2vFoVhZfDL4Fv0+nymlK+GhESL9kXvuSUnPJmeBb/hV1SMb8VxbxWAhlmvvseMf8OEtdZXEwQHtjBoljrakXV149zupSazbguK5L5is7aEKDWCbxZlWvgDuzhEELWz48Tbb+5VPd14H1USGmYh8dwuNGkAJexm8RmFLe7ba+/TZepJItmhovQ6ANCu7YfdLdpWAGmnXt5qMYwb6m/JswkncScSdOKWyiJZjx3pVQR/D6z2wG8I4xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6529.apcprd06.prod.outlook.com (2603:1096:101:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Fri, 25 Apr
 2025 01:11:11 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 01:11:10 +0000
Message-ID: <1166b629-92a0-47d5-8cba-01aafd928e25@vivo.com>
Date: Fri, 25 Apr 2025 09:11:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Francesco Valla <francesco@valla.it>,
 Huang Shijie <shijie@os.amperecomputing.com>, KP Singh <kpsingh@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 Raul E Rangel <rrangel@chromium.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Paul Moore <paul@paul-moore.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, opensource.kernel@vivo.com
References: <20250424120937.96164-1-link@vivo.com>
 <20250424120937.96164-4-link@vivo.com>
 <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
 <lkumupd7gkzcui2wzssz4tzrw3cchta67onxnykxjldssmfnei@54mlc5fn3brk>
From: Huan Yang <link@vivo.com>
In-Reply-To: <lkumupd7gkzcui2wzssz4tzrw3cchta67onxnykxjldssmfnei@54mlc5fn3brk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 03374215-4626-4067-129b-08dd839610bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU0xNkljb1FxVnZBR0xVVlU2OUZwSklLVVJGNy96YkFGU2J3SzhOVmJRa2Nr?=
 =?utf-8?B?cWxqblcxRXU2d0poZnQyL1EycGNuWlVFRllnQkNKMHBlNXE2dkNDZXBsTDJ1?=
 =?utf-8?B?eG92ZGxkZzQ3M2JJUThLcnJNc09PSWNHS0RQSk5jMjl4Zk9rUWJRaUN1cE9u?=
 =?utf-8?B?VURDbHgvS2gvVFE2SUpaa2duTnRRQVZyNFlVWlRzOFBwSk5FOEt6Q2I0d3hS?=
 =?utf-8?B?blQ1c294MFlJclVSM3J4bmhqWFhHN3gxT0dJeTNjMXZydDBMT0IwdndUWWlS?=
 =?utf-8?B?d1gxelJpWk9ROVB1TUJyNDE3ZHZiWDBnZVF6cFBSRGlpY1lXdHh6dDN5dUFD?=
 =?utf-8?B?TUV4ajY5UWtaSS9mNnNqci9vV29QYWl4a0haOW9jckpMcHFLcUtaN2dCNkNq?=
 =?utf-8?B?MFAxOENocmlCeXhXM293Y0ZDSkIvNUl4SzgvWGIvZUpWNE1GQXhTRkxSMVpJ?=
 =?utf-8?B?TERmbnVQcTF5bWxhS0YzWDFMTFRVaE80K0h1RzRDMkNVMTdBelpIOHI2VHBH?=
 =?utf-8?B?VlZGcUdZN1B0MnRmd3VmeXdFV1FGZ2VTV0J3aUI5dHN5VkpST3AzUmRRUGpu?=
 =?utf-8?B?UHpPd1BJNWRoRXkzOWN4Q2Z6WFpza0h6d2xZTWd1NDlhTWE4NDNSYWlzcnlk?=
 =?utf-8?B?a0lnUG9qYXVURUlJNmpYZlhLaVJxK0ZiSUlXYnJNeWhIbHh1NjhueHhKUjlD?=
 =?utf-8?B?WEcvRjJBTGpRbVBHS0FMZXhRYWJGbG1IZG90UWlhWnovd3cxMFFwMHJHcHRM?=
 =?utf-8?B?RnR5NnYySGNIUUFyR3RRTG1wWG1JSGY1RVRuVDdYcXdGY2RIdTV3cTA0ck1P?=
 =?utf-8?B?SUsvMXNtNU1HT1gzNEY0THgxckdpTjlKWWdtNjRaVFhwTGVqSzJHd0pnYWI5?=
 =?utf-8?B?Zzd6N1BVOGdDZDV1VmN6amdnQlhxY3NGS2p4T2hoRHR5RXFwTkFGL3l3citV?=
 =?utf-8?B?TlRUUjc3R3hjM3VtZ1Bab0JrblIxR0s0Ti95dVhkY0ZFK3JqSVdLK3RyWm9x?=
 =?utf-8?B?Ni82NDVQTVRSUlVrSzAyN3FTclhncTd5T0hpbjh6d1ZWL1VpNFFjSGxEZmJz?=
 =?utf-8?B?a0tTekVGcGtVRlJIbHlLSXlIUEYrTjhNRFVwaFhIV0JEaXlMZVJvOVQyWFQ1?=
 =?utf-8?B?NGdUSmZabTNIWjJPZGNpeTlGYkJZbUdsQlJSQStpc2l6QVZRYmdLKzVJVGlH?=
 =?utf-8?B?c1RrbnIvd2NLSkVjbXd2ZVUxaVQ2bmQvdllKY05jQm1NTER2bmtndkk3UEVm?=
 =?utf-8?B?ZG5QRnlDOWlpY1IyY3RCaDloL1hzTWc5ZDFuR3dXUkI1WEY2Q2orY0M4S2lN?=
 =?utf-8?B?emorNVhLc3FqT3FJQ0FsYkNNZGtYcVRGUWFWcnZTNFJ3blptdlNubE5wZUd2?=
 =?utf-8?B?N0c1anNJQ00wd1dFVXVjUG10ZjdXS2NzeFpZOTErTDlXVWk2eDkxRGN6TmxU?=
 =?utf-8?B?RzlicHZrU0pFUDV4TDhMQ3I4RjZkKzRiZCtIdXdueXptanZMb2k3STBzbURW?=
 =?utf-8?B?WENXcDBJN0dOaDgxSDQ3d2VsL2lnb1NvTi9vZ25raG9ZME04dm43R1g5WVVz?=
 =?utf-8?B?bnc4M0pOOGkyVUlKcldNQUNqemFUbS82eDhRQzJiV1phdlpuc09CN2o3bTlJ?=
 =?utf-8?B?a0pTZGRvNUdzQ2sxSERqSlV5Q1pTMkpnbWNuQVd2cG83RWlvaE1CRkhsclFz?=
 =?utf-8?B?a285RmNUVVRBcGhndjFBMTRCaVg5SnVKL0ZDa1NaaGxIeXRMMFMyM1pGUkRN?=
 =?utf-8?B?aFFBajIyZ1lHbXl2N0VmYlltaXQ4QUowcUhGSGF1V0x6V2FvNGlWZ3NBWHMv?=
 =?utf-8?B?aXBKNmV2NldLenRybWt1aXRTQkxmeWVpaGhOTTZaUGVFWGZsMHFjQmtOcU5U?=
 =?utf-8?B?RkwvclY4b3dvd25mRDFQWmVPbVdQMDdZVC84bDRDYlI2U21wWFRqU01aaU5B?=
 =?utf-8?B?eDJUUWRhN1J2ZVZzRTJWWTI1SmZldlVLcGtLVGFHYzh2cWRxWlF3VU9FR2xv?=
 =?utf-8?B?T25UU2RxMXFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjY4OUdLTlZia1RMdzZCZzBIc0ZON0ZKTDZIT0U1TkdYNGZnK0xwVVQ1TDY2?=
 =?utf-8?B?dExXdi8yU1Z3cHp6NVMrVWw0dTcwQWJkR1FRbE1PRXVyODhXQmFMOXVtTWZz?=
 =?utf-8?B?amJXVGFZMk5jZ0hENlhWYmZPYjhkYUFDL0lubTlkN0hLRXNjTzA0NzFRWjJw?=
 =?utf-8?B?bjdSOUJxV1hkVDI3ZUNvYTZYRUtpRCs1R3djYTgyZUtoeGxiUlJBWm92U21L?=
 =?utf-8?B?TGhDOWpaMG9UWHcvSWo5c3R1QzZFeFRTNzYyTGJNM3hyQVdsYzBlTXV0Y0ZK?=
 =?utf-8?B?dEZwL29xdk5GTmJTMjR4SzFCUFZrT0dCRmpuOHRtbXpzazZQelZnd29ySS91?=
 =?utf-8?B?T3BpOFBEYjF3clhOdXdBREpxelVvb1BLWWV3dTZoRFVpNU04cFgxMG8zMGgv?=
 =?utf-8?B?VnpqZFZMZG5zbWlhVDBBTGwyTSs2MWQ0Y2Q4N2ZKZWE4R0dhSi9yK0ZuWTZL?=
 =?utf-8?B?VExMRVU3bnZGTnJuZ3h3Y3krcWh0eVB0SlIzSjNBdC9mOEJ2a1lndUJJdkM0?=
 =?utf-8?B?WHNlMnpNRWQvMEFlQlNES3ZjcmRZRjduWTlha1ZjbnJYeGtVWHZ2T1JLdFdH?=
 =?utf-8?B?eVRvZ3VtRTFDZytUK3dmdFNWdVlFdmkwL21yaS8ydkEyd29BWXdGZGlIeVdk?=
 =?utf-8?B?ajY2NUVsL040S2xMMjU2dHdLQ3pRZUpOd3E3R2RlVGZGRytqTDZaVGJWNDly?=
 =?utf-8?B?ZG1HU1hKU0tyOWFoZEh4WTlaUDdXUGZBU1RKMWZ2c3pWK2M4MTJORjR1Y3N3?=
 =?utf-8?B?czF3OEl5QzVIS0RPM0FZbGRVakh5V3hCNjY3WTBLN2k3Y0l0R21uR3d6b2RH?=
 =?utf-8?B?bEx4bGljYldZd0ZKLzdlcWh6R0k5MXVzcjhwd3gwZmVXN2QvazQ0WTdTL3cr?=
 =?utf-8?B?aURqWjg2L2Y2VU5PTlMvMitodFkyMWs4aEtkWWxubE5nZ0QzVTRZNUlqTmdr?=
 =?utf-8?B?bUNIWktxUjZyMVF4WVpmS0lTVjYyN3Zoclpma0FtVXhxYUFDSy80MnBPZlJB?=
 =?utf-8?B?MlBXdzZteit1NXd4SXBLdEQyYzJRQ2M3TkVFZytyeG1TbjIvUkFsNG1HbEJ6?=
 =?utf-8?B?bldRM0xVcGN0N3JrRlpmTjUvNVVvT2lNYVh1eUtIcU43cjF3RW1yMWVyT090?=
 =?utf-8?B?aTkyMjFCK2VSVGUrZ3o0S0JaZTFaR1hDaXdtU2N5UnBld2RjLzVDTTVCZFZj?=
 =?utf-8?B?empnTkd5TFlEWVVsOGUvcjhFWXdIM2lhVzllQTNOTWJsTWp3ZXg2RTl0YTBy?=
 =?utf-8?B?aHIwUzlUY1RXYlYzVjR1Z2wwdXlCa2NYZjVjTWZQZk4zZzBXakk5eUNzQUgr?=
 =?utf-8?B?ZlplNkNqSE03QVVIOGJmdkNxMDFHTWU5aTh6ODNSeHVqSVB4SXpiZzNhdllt?=
 =?utf-8?B?S0NvNlEvaEdhaWdtZ1Z6c1kzUlM5bFRDM2JndVgySGt1U0N6ck41RDkrNGEv?=
 =?utf-8?B?OWl0OGtTbjlmclBBNDFjVjg5WHMzYnVzY204ei9BVW50bXRCc0d4ck92WUUz?=
 =?utf-8?B?UnAvazJwQlhsbXY1TGV2S1FES3RHUVFiMDFJcG9OL0lpVE82L1RqUVM2Szh4?=
 =?utf-8?B?QnUxQWphM3pYcTZJZVI5RkZudENZMjNYd2pGVXByR2Uxb3RkbVZqUHh2azhQ?=
 =?utf-8?B?Rk1tSHlsOUNnTUFMWjdGMmFmZVM0MnlEODIrV1prazlhVDlBbXFCdVBQaDBt?=
 =?utf-8?B?dm52d1lXdzJ0NWhPVjUxcHUraUVSQzAvaGF5b2dnczdwNHAyMHN3d0dkV2VD?=
 =?utf-8?B?SkRSckFDSGxDZW9nc2toV1MrZE41OXZsS3padWJYdm4vdjlhaWVXUDlFS1N5?=
 =?utf-8?B?KzU1L29ad3d2MVd5VW05ekRscVMwMU9qUEt6ZUNlajdXTUcvOTFrLzVFdUZH?=
 =?utf-8?B?TTdDY2hkRFMvOWpVZnVrTU9QUmpRQ3NpTXR1S2oyd2dzNmtQM0lUeVZJdk9J?=
 =?utf-8?B?dzRaQjY2OUpjd3pvNzg3enRuZERuMjVIOTdBcFNnV1c3WUpjaW5vRUt2a2dX?=
 =?utf-8?B?VjN1Q2VQeC9leGNMVmVuMisrbjBFQjM1MVU4cHo3bDFDbnlxQnRDRkVuMS9t?=
 =?utf-8?B?dW8zbE5ZYWFrMmg5eVhKbFh1L3hFMDcxOGQrdVNrbHdzZnBWdU5mc2dKNklx?=
 =?utf-8?Q?rGXfL96bW3WRUJObzPOfUZjIq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03374215-4626-4067-129b-08dd839610bc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 01:11:10.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccs7ltRtPt8bhAvgQC1+17H9uqsYaG9bLsgEMZamRK4p4gizVWEI9+6gPRVaEp92SixOGFwY3h9vp1JQUqjOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6529

Hi Shakeel

在 2025/4/25 07:00, Shakeel Butt 写道:
> On Thu, Apr 24, 2025 at 09:00:01AM -0700, Shakeel Butt wrote:
>> On Thu, Apr 24, 2025 at 08:09:29PM +0800, Huan Yang wrote:
>>> When cgroup_init() creates root_mem_cgroup through css_online callback,
>>> some critical resources might not be fully initialized, forcing later
>>> operations to perform conditional checks for resource availability.
>>>
>>> This patch introduces mem_cgroup_early_init() to address the init order,
>>> it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
>>> by initcall, mem_cgroup_early_init can use to prepare some key resources
>>> before root_mem_cgroup alloc.
>>>
>>> Signed-off-by: Huan Yang <link@vivo.com>
>>> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
>> Please move this patch as the first patch of the series and also remove
>> the "early" from the function name as it has a different meaning in the
>> context of cgroup init. Something like either memcg_init() or
>> memcg_kmem_caches_init().
> BTW I think just putting this kmem cache creation in mem_cgroup_init()
> and explicitly calling it before cgroup_init() would be fine. In that
> case there would be a single memcg init function.

Maybe someone also need init something after cgroup init done?

Currently no, but for furture may need?

So, memcg_init then cgroup_init then initcall->mem_cgroup_init.

Thanks,

Huan


