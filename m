Return-Path: <cgroups+bounces-7787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEADA99FAA
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 05:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCDF19457ED
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167019CD16;
	Thu, 24 Apr 2025 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GZ98z1hJ"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011016.outbound.protection.outlook.com [52.101.129.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028E199FD0;
	Thu, 24 Apr 2025 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466035; cv=fail; b=gya1FtZkDU/HHAMJTZzz24NgbsY8mWaHK6IPOb9jtpThnWHQ3VIy4tFXry36t1oxQ0xFWBgQxJPvrchHEVtLqnJbYD50zaj5lMGsyds6n3Bzj2veq1DBpUaWoBflfAyjJX3TPmchX3TQbPkqTzmjI/Hks5RRcenqeXvAmPY+98E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466035; c=relaxed/simple;
	bh=BcYt4Fmryv/wgVdOOYzbYhL+n7pzeonG3VKI5+sPkWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cBqjg9WGkEsoe+uGC8zvTNwNohmxgQFqDhLONcOXSJxq4U37SxFLJWW8rroJzz3ZB3O1jOiXzJte1PzuR1z+b8gKFsFRQA+TBDiL+s3dNWCN14VJ8kvkNnTzL0n5TY9oNNh07+VEZY2GNkAZze/S77iyX0Reor3N6zZ8eycgJQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GZ98z1hJ; arc=fail smtp.client-ip=52.101.129.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUk0R1dLrWGuWzRWt+Fkei/koS86NrxIBCUsUxtMsLji3hsoxvJO2+RAZYrBpI5KJgR0CGBiKfCJ7tCCzBqb2F7Iuu22NhUcqM+nCvmIvjmiPTjoZroqiVGNsv8b+GAoqdShJy1sZ0wW07HR0616kG+jBL54lerxWH0B/X26Qcg6HpEVw1mxcspAgtIDLfSGdaoNx8usYXhlrkDUVPW0g89o0qNDjZhPmwL0Pm7fO9yXgct04VBjIEkc8XdxLbrgY2WXsDM513zFISA3RU0VifLnqfnrc2Bkt0u+bse6azD1vrUSpepStSlrPA9rLsAYlRnjh58R2AMOI89bdTOJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvcVYYlHVSqlJsxJ9hJ4hSdxdX4E7WO4vGPa2EOnkmM=;
 b=vPPB7Fu8HoNBaMEeMXIWPQVgzJB9qsnc976dK/r6VaJ5W7IrxwtjFAXXAmD3iE4rhrpTl+2cz3Ybh52EpJildYmhiy9gcasDaC/4YTdKEdBLNx9JEwJs6/Lk5N89PTZT5ww+EQvsblJVmtASWRJSuWmliGcS4U48iFk4gs1YTsWxLwcfp8kqF0qb6ClRP5QnBuum+LiUQoS8ZlD2gikif1YuIceQoJfEj3U8As3YkarkmiLxllf+/hEEmt5KEplZwKSqypD61jar6pw0Jg32KibJhwySpjprX0qwnaRS0d0z5o6Bun77Q7kMivJymUKBlZelZEFV9jpHEs7xzruZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvcVYYlHVSqlJsxJ9hJ4hSdxdX4E7WO4vGPa2EOnkmM=;
 b=GZ98z1hJdXkJL1kOgLo+df2ppePjef4R8Wxt/mjwFixmfrH2qQNA/IRl0AAsbgWZ5zlrICsfnUuN+Ej6tMPpZRE7BJXB6WDxEiqx6/mbRZ51E5qaxZming+ESZalvEfTygEM8RpgfVn9TrAu1ib53bQSupGLfrPLzbv8E+YLepOSzfUERdwE115upsmf0H+sgp26WmFQS8XeW3rflQidOcds9KZPdFXXyYk/KdVHEZkCOGJiGXJCY34ugZ71j8PIImOF9pLPgJFVOK0yyrgJtqErXqkMJY9rwRjiBXhqz3Yle3rBZQ1mVx6s2FnqDJx0QSe0Dj6juaz/C55G8gB8+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6619.apcprd06.prod.outlook.com (2603:1096:400:451::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:40:28 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 03:40:27 +0000
Message-ID: <db9e45e5-47ff-4355-9d6b-8704ab1b20df@vivo.com>
Date: Thu, 24 Apr 2025 11:40:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20250423084306.65706-1-link@vivo.com>
 <20250423084306.65706-2-link@vivo.com>
 <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
 <dp5frcrqofkjjp77hw5sbkri6etnpdsvxnahs6nazvakaxt6im@xouxw25rggci>
 <142e6a02-80bf-4e7e-9165-1b5690fde690@vivo.com>
 <3txgkddzf62xhxwlzm63ip3tqv3r2tmd4elnka2z5ya7ngqr62@f554paqdco5s>
From: Huan Yang <link@vivo.com>
In-Reply-To: <3txgkddzf62xhxwlzm63ip3tqv3r2tmd4elnka2z5ya7ngqr62@f554paqdco5s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: ad051eed-8d10-4989-1cc6-08dd82e1c0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHN1NndMT25vYzdqUnVpRUNVMUpsdUlYeE5KZWw1bXB2b2E1WHRHbXRnajQ5?=
 =?utf-8?B?V2oxYjJmb0ZFMWFFYTVoSU9ubFVuVStIOGlVdEtNaUV1dTFHbWxFWlpnRTIw?=
 =?utf-8?B?TTB6OFYvamlHV3E2Skc0ZFBwRmJ3bzE4ZElFWG0wOFZZcjVSSEg3YWx1bkMz?=
 =?utf-8?B?SFVySVZlL2NydlJzZ0o5QlhjRUx0Y2JlOTFkU3pSN3M5TTEvWTUrZWxWQTV6?=
 =?utf-8?B?WGl3TUJENGtjb3VsRG9ETlFiZUkyNjdZYmhtd29HUHFDLzM5ZkczOEdPRCth?=
 =?utf-8?B?VnRUL1B4L3JvQ25TS050bUJCd0ErSVBLUDF4cjc3UGk2UVVjVjBKME9TaTk0?=
 =?utf-8?B?UmZaeFZ4ajRRUTJwZ054VUJjeU54RTZJdStPekMyOVcyUFAyb3lFNlhSK2kr?=
 =?utf-8?B?aGE2bFRYcHNkUHhDVFJ0YnlxQUhGL2MvdVJjOG1zZ0tRWThJT2ZUSFE1YmJ2?=
 =?utf-8?B?UENkSEV1QWRyb3VSanlmZ0RJbUZsRUVXUGM0SElhcU5mUDd1WkEveGpIZVA5?=
 =?utf-8?B?N2o2K0YrSmNCYmdHbHNyc2l0YnIwMEJlZnRZU3EweGJyUHg0ZzBsTERBeENq?=
 =?utf-8?B?TVBTWnF3dDlPazlEeHAzZEYwWCs0UkRhTDVtWnhIZVFkRnJZY3NpWWlwOUx5?=
 =?utf-8?B?bjh6eCt2NGVGMU5KZlRLakg4aHh5V1htTU44bEM1cko1ckxMbEZWeFY0Sitt?=
 =?utf-8?B?TkhNUitQSk1zSEpFN2RlMmFWQ1V3Tmp1L3VyTGtNdnFJcFY4UkQ1WnQ0eHVj?=
 =?utf-8?B?Z2pkVC9pWGI0MWZxRFNXS1lRS05oV2kyQnBVSkhyTzkvaVdSSmt2S3ZXMU10?=
 =?utf-8?B?b2FsT1ZpYStDSG44N0ZzVEQwZk1YNk9kNVZpWjU2dVhoTEFEQU9UL25IRVlJ?=
 =?utf-8?B?Vnp3VEd4eFJ0OEtQeVNCSUdsSWpjdDV1UFhKMVZLZW9xbEh5QXhDYllmOWQx?=
 =?utf-8?B?eHd0NHJXMk40VTdrUG5SN052dThlRlUxdHptbUFMbkVxeU9yVk16N1J0dlZQ?=
 =?utf-8?B?UlZxalowRW9lTUtRb3BrS2NySTdHSGV0Zm5kZUdSV2dJRU5vbXhvNGcvSlcv?=
 =?utf-8?B?WTdCVXNvWkJETmRqTU9OdnU4QjNtV1p6T0cvTUphUjlvYVhaOHRPajlYK00w?=
 =?utf-8?B?UDhmZG1JOVYrOW1wTm04MTlpSjdJTkxUa3RoNkxmVEpzMVZKNzNXbWFKTmVZ?=
 =?utf-8?B?amppVWgrVTRhQy9iOUdUZEdIL2tYd0FEaFRTaFE0M01XNzNwOVV0YVBjZysr?=
 =?utf-8?B?Tk1HOVpSTW9BRVYrUmZ4bHYzQVRhNUVEdnVSMlNpbUNmWjRHZUpuVHFTL0J3?=
 =?utf-8?B?dDBpTTF2aVlFNmhvdnRXUjVzOUZsMisvSms2b0lyK2M0SzN6YythMlRMZjZE?=
 =?utf-8?B?K0ozNXJZQ2lvRnUwVVJkQ0xTcDZuNWliWmpHRGVQa3kzai9scG0xZ3B0VVdC?=
 =?utf-8?B?bDhzeEVrM2szdUtJZFBiRXlTNlgxeVFBQ3lFMFNmNTVzTEpYdTdpMzlLWDZP?=
 =?utf-8?B?Rkhmc0drcXNORW9OVVMvRXdRV0tNWUtDWEFPU1hQcGFxNlVralpvK0FBR0l0?=
 =?utf-8?B?Nmp4TkdTL1A4TTJCTHB5WGVUb0g1dDZiOWJmZE8vUklHaXowcm84M29sT2JK?=
 =?utf-8?B?MGgzaDc0bTlnK2ppelBBTGJPcnliNUFxTTZQY2RLWGFTM1UrUTgxVEFLNUVT?=
 =?utf-8?B?QzQxT3dyNWdYKzd2WkNuQUFxbEFTdGlwM1JUTzBXZ1RieUk3R2ZTNEYycFUy?=
 =?utf-8?B?Z3A2aFljOGU1NkFKY2gyc2orZnN2RlBIRkJna3ByMWxEb2tpWXdaalUvMjJt?=
 =?utf-8?B?WmMrOVAyWnZwcFNZa0NuakEwZ0k1WkVOVHJCR1MrMCtjRFR3VjdZNlE4T2lx?=
 =?utf-8?B?QTR3U3FRcWpwaklpVXJMK0JadUhmQ1BNUGFTTFBvRUdRb3lQdm4zR1FKUGUw?=
 =?utf-8?B?VEhlOWtsOTZEY0tGZUxtS2pXSTh4MGJTK0JEa1FuNXZmM2JoaDNLZjVGVTBi?=
 =?utf-8?B?M2xRVXJsYTN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFA2V0hPZFFDb1g1OHB0cXdSaG1OVXFna0t3Nnc2elJKYUtGeTFOcXBwUFg2?=
 =?utf-8?B?NmEzZDNxSnZVUkNweHJDN1k5MXo3SjY3a0dEL3E4Z09BbzdsckU1dDF3QjRR?=
 =?utf-8?B?Zy9rTndQVVJHUlVkMjBSZExydlZBWnBXbTQ0SnNNcGJpbDdaOCt4a1ZqNHlV?=
 =?utf-8?B?dXNWTXlWcTNqWWZSbDZDQStCd2ZzL0VpNW83SUtYNGRuWUcyb1V2VHhSdVhm?=
 =?utf-8?B?TCtLM1FuTlcweGhHYVJFVllJSXdBUXg5UEk1UlIrRFVFMU1FSWhqREd5N05I?=
 =?utf-8?B?Q3dTemhGWGRKNzhRNU1mMDNoc0Zvd09iM2dZZk5xNVJFeU10K1NmZ243SUFv?=
 =?utf-8?B?RFoxOFU2U0JiR0ZPaFBDd1M5MGJCK2NUK2pIMTNHdmg2RHVIcFMxVjV1ZzY3?=
 =?utf-8?B?RVlTSDY3Z0xpcTdvaEc2ZHVWbHAvVXVaOWJPQWwzREF4RWRPV3JUQ00vOFdN?=
 =?utf-8?B?RjkzL3JleE52emsvOThwS2N6d2FLUFd4anRoQ3g0TlpvZHZEby9hWEMyT216?=
 =?utf-8?B?VldzRFFBdFp6bk9zdGxyWUd1WTMvL1NJeHJ6RVhsdHlScThabU90SEFhTVRG?=
 =?utf-8?B?SVJHYVd6ZzRaTmhWOWZhUkY3RVpKVHpPb29VUnVubEFXMnFXOXluaXRhRHNK?=
 =?utf-8?B?RDJpUk44WGtlZkJkVDFFb0N3TkkyeVo3bDRnV3lacm1RVnAxMmtKNzdTdjFN?=
 =?utf-8?B?M3AxNENVQU9Ja1cxa1VhNmJaekRHY2QwVDJaOW5LRkpqMnY4djZBVTZMZysv?=
 =?utf-8?B?REtuR05tT0pwaHcxdkgyYXdlQlVKUXdoRTQ1N1Q0NEFDN3k2R2NxTlBkOVFx?=
 =?utf-8?B?L1IxcjFtOG5mZ0l4RDEwVERFVVdJaStweWJ0U2UwQzlTbW1pUG1jWjcvNFRz?=
 =?utf-8?B?disyNVg5b3VvN0ZpTXduQXZucS80TnRHL1VZYWdreHF6Wjh0VVpnQ2FtRjJF?=
 =?utf-8?B?UzA2WmUrNnVPSTBKTm45MGNPdEtJWmpjOEFQcmRWOWFKMTNkdXV1Wk81cHNv?=
 =?utf-8?B?NUI5akdYamtOS2NCY25lNE9MMEdqWFF6YTNjZll6aGdpakJIVmtrZHV1RHEz?=
 =?utf-8?B?TjI2ZjB4OUVta3dIUnQwdWtPRWpQWHBwM1luZFQxUVRGM083UnVtdE9ZUGtX?=
 =?utf-8?B?YlNEN1N6bmVJZ0hBdGVJMnk5RnFDNk1oY0lGbDIrVWZwVVZUaG5FT0Z1Y25y?=
 =?utf-8?B?RjVjTEd5WGl1aGE5UFVTRWdPeHVSTEp4YWRDVk13SkhXb0pub0NsV2lCclVk?=
 =?utf-8?B?N0xxVE9XaitJbW1SNGQrLy90SC83UHM2eEgzcm5UUUdHUEhrL2xaSTJVSjdS?=
 =?utf-8?B?ZDBiTTUvVTFCQ3AzM1ljZkdTWEdCR0xsZXg5dmFYSlluZE56VGp3OUlvQ3ox?=
 =?utf-8?B?aWZkVTE5Uks2NXVZZkNnNnRnaG14N3NYK3YvTXhYK3V0MnlvZ2tWckVEZzQw?=
 =?utf-8?B?U1NmWmRTYU1tMWlNdG93aVkweHhxa1pEeEhLbVpic1Fhd3lJVjBRUm15dGI3?=
 =?utf-8?B?WkxBd0dlamszK1lxdENHT1o4V24rclZ2NldTYkJnbVkzSVJqSlpUNWk4N210?=
 =?utf-8?B?OTFWT3pTaFlManpVcXI0bUZUbTFENTN5cjR2WTlHSlJnM1NsSWF5UEZJS092?=
 =?utf-8?B?ZXBBMzdMY09sWEMzOTNyWWk1MTV3MnFRUlhRbk54bCtsQ1ljY2NjeDNiRExS?=
 =?utf-8?B?NVZjSWgzcnJXcVE4Mkp6NDhCUHFjL2pxN1NjM2pBeFRQNDlSZlIzaHdUQmlJ?=
 =?utf-8?B?cFNBZERIMDlHSkJlNkVsRVJuN0tvMXF2SmFQdWJDblFIK0tGRFM3WHlCeGJv?=
 =?utf-8?B?NmFXT1VFNHNpbXVudFVUenVNQjR1R0VUM0xWZElVdlJUK24ydWkzOUtXbENq?=
 =?utf-8?B?dUI3YWpKQ01KT29qUHVCM3JSTXZKaExrTGpJaTNlT0lvYmdRanQzdmdoZDgz?=
 =?utf-8?B?MjhUYk9qSE9QS1JJRmlKL2lmZUcvTzlCSmxnMlpuUWlPNHpYSVJUaWVIYmxk?=
 =?utf-8?B?SWRYbjdiRTZ6TFBkTnNWMHA1MzdzOHVzVzR1MkRoRzZqdCswVloyZGlBNlVW?=
 =?utf-8?B?aHNTUGh1L0gxU0tOY1I2bVgvdjFFellDdVRpblRHSmNCZ2hXWVJxdmJ0K3Zr?=
 =?utf-8?Q?dsZAQxRn1mOxnZ0DyaGs7PO+D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad051eed-8d10-4989-1cc6-08dd82e1c0e7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:40:27.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxMAKCD5RmRRaCAajN5FOLL9AbYpY47xXIT0ZCEQFQLnUGMMgpLFMEhZKiSIArY8gfQMxnLlSe5Dr/UA86U+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6619

Hi Shakeel

在 2025/4/24 11:31, Shakeel Butt 写道:
> On Thu, Apr 24, 2025 at 10:45:05AM +0800, Huan Yang wrote:
>> Hi Shakeel
>>
>> 在 2025/4/24 06:13, Shakeel Butt 写道:
>>> On Wed, Apr 23, 2025 at 02:59:12PM -0700, Andrew Morton wrote:
>>>> On Wed, 23 Apr 2025 16:43:04 +0800 Huan Yang <link@vivo.com> wrote:
>>>>
>>>>> @@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>>>>>    	int __maybe_unused i;
>>>>>    	long error;
>>>>> -	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
>>>>> +	memcg = likely(memcg_cachep) ?
>>>>> +			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
>>>>> +			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
>>>>> +				GFP_KERNEL);
>>>> Why are we testing for memcg_cachep=NULL?
>>>>
>>>>> @@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
>>>>>    		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>>>>>    			  drain_local_stock);
>>>>> +	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
>>>>> +	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
>>>>> +					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
>>>> If it's because this allocation might have failed then let's not
>>>> bother.  If an __init-time allocation failed, this kernel is unusable
>>>> anyway.
>>>>
>>>> +1 to Andrew's point. SLAB_PANIC is used here, so, memcg_cachep can't be
>>>> NULL later.
>> I see cgroup_init(in start_kernel) ahead of initcall( which in rest_init->kernel_init->...->initcall). So, root_mem_cgroup create use
>>
>> cachep will trigger NULL pointer access.
> So, either create a new function which creates this kmem cache before
> cgroup_init() or just call mem_cgroup_init() before cgroup_init()
> (similar to cpuset_init()).

Do you mean like this:

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5264d148bdd9..e9a4fc5aabc7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -348,6 +348,7 @@ enum objext_flags {

  #ifdef CONFIG_MEMCG

+extern int mem_cgroup_init(void);
  static inline bool folio_memcg_kmem(struct folio *folio);

  /*
@@ -1059,6 +1060,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)

  #else /* CONFIG_MEMCG */

+static inline int mem_cgroup_init(void) { return 0; }
+
  #define MEM_CGROUP_ID_SHIFT    0

  static inline struct mem_cgroup *folio_memcg(struct folio *folio)
diff --git a/init/main.c b/init/main.c
index 6b14e6116a1f..d9c646960fdd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -50,6 +50,7 @@
  #include <linux/writeback.h>
  #include <linux/cpu.h>
  #include <linux/cpuset.h>
+#include <linux/memcontrol.h>
  #include <linux/cgroup.h>
  #include <linux/efi.h>
  #include <linux/tick.h>
@@ -1087,6 +1088,7 @@ void start_kernel(void)
      nsfs_init();
      pidfs_init();
      cpuset_init();
+    mem_cgroup_init();
      cgroup_init();
      taskstats_init_early();
      delayacct_init();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e2ea8b8a898..1537562c01c2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5029,14 +5029,12 @@ static int __init cgroup_memory(char *s)
  __setup("cgroup.memory=", cgroup_memory);

  /*
- * subsys_initcall() for memory controller.
- *
   * Some parts like memcg_hotplug_cpu_dead() have to be initialized from this
   * context because of lock dependencies (cgroup_lock -> cpu hotplug) but
   * basically everything that doesn't depend on a specific mem_cgroup structure
   * should be initialized from here.
   */
-static int __init mem_cgroup_init(void)
+int __init mem_cgroup_init(void)
  {
      int cpu;

@@ -5057,7 +5055,6 @@ static int __init mem_cgroup_init(void)

      return 0;
  }
-subsys_initcall(mem_cgroup_init);

  #ifdef CONFIG_SWAP
  /**

Anyway, I'll test it.:)

Thanks for your suggestion.

Thank you,

Huan


