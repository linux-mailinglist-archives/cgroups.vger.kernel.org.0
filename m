Return-Path: <cgroups+bounces-12830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0FCEAAD8
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C4A30145BF
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206DB263F52;
	Tue, 30 Dec 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VB//iglf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3206231827;
	Tue, 30 Dec 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129132; cv=fail; b=ilSkqp2wRhN8wkv70EYsiPO6wJkACoWj91BkuOomf77djQtpKDvRs0WmjrZWv4QX00QG5ITnmtdBlTmUTSnFwwP8MvUHgaPt2kM4AfrddUs5bccuQcronxMdntedXUm0KpxsVA+nTAQP2oL6ND3S7vAyvB78t7kp942B8pNkLJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129132; c=relaxed/simple;
	bh=t/Uy/AQwvkF1LK52j4vCFJokmMwdd7IAYHmv8oAPJIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6thIGMqtGiu60lObPqsqyZccY+VniLdKqR2KcgffpPLd5ChYXww4raIHvAiWSqBUwAM+uL9RwTlI9VNFCskZiK2+VydxGXgZHNQoaO0CGeT70GPc2FHJu6jPsv/oqz/WX3TH3jZWpQ6hbBWXtZpeeeKuLI+DLSZhEdt2zAUe3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VB//iglf; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BULAArA3220653;
	Tue, 30 Dec 2025 13:11:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=AIfFXFZ9a0GodfCueUCpfyqtnjSj7Ey0sVzylAi56Io=; b=VB//iglfG709
	9oW1U6rLHnZ2S7ey1O++JjeyiPKaDJJMzX0hTKTunZFYWP8V3hBSre715Rg0IDxT
	CT/oBhrvb4SP3S5+YnApRn48khln9NrzecQd3I1Wwprpv6MAHHxe03OIQaQNO9nQ
	H3xe7SHyU8qf8ZEwKi5nEwx5AmoCySjP6wDgSFes7JMUPNxMu49pYfYrOjjppbFm
	92KpBd01eQjheXar4V19xx/wyqMd8mbnacrhsJZAlrTwFYZ31dbuGmbT2WEDmuV3
	3A4D6F4aXJbIoa3Re+3h0H2ajabbWJMSpIUaemrNuAUc3P9UZU2sP83b5oulO+kI
	+vcTa0UBjA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bc507p46e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 13:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QakuprR2d0k4CjwWgefBNkQD1Snj2+8VTNTmX1fkqmnak+GUSvKnT7lhBcwLzcju3JJyuDq9wXdyhbTggbdPxjRqoL2oQvDim7ykoDRLUJo9AEyUrFUgsFdOIpcB2BZbvoU8ZDHpKb5c5Fl3EjXYRiXFinNoMfNA1wseBFcoSf/RWREfEOu/RNv1QwSxrO8spoVa57Kks41SK1sFKGfrZBTgTwWm3mubv1xIvHaslgJbbWhKLxjLzPLNTToVy+7ijuzLO68H+Q8Gw7M3oKglO7Z790+oWpBTo80s1jiV3SyOhLcJQhgtpxApxe4kcQG+5V8fxvbmzLihP3CVrCbctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIfFXFZ9a0GodfCueUCpfyqtnjSj7Ey0sVzylAi56Io=;
 b=fZp9zPHmpatZHTCwE7ummK3LbPJy+CYlGrsToijXAMF1f0vs0EnqEeR9ZOxxiyNEfG8sPRclhC+1ezWKNOlkhKmz+QLYTbq/q3Uy1CdlcSfOysLOIo0D4dgF2DVLbRHLFCD/mlZrjjTbP8GX/l8EexYBjSA8Bf8zn7qFEmy3t+1bxhfhOBYNFmufBzsRwyxN/DlxSPHo1xFK/ME4aoc3uKHaDxa/9R8NNtNAPOnF725v2c2TVENkR92ufk1sGvOs29A17ZSH6OMJCLEVkeQORYdH9seoDMgTbcF81vhxpWvS2FhQxFsmhzgV8zU0SewZnUO7ON0YWWajCD4YST+Kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB4567.namprd15.prod.outlook.com (2603:10b6:a03:378::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 21:11:09 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9456.008; Tue, 30 Dec 2025
 21:11:09 +0000
Message-ID: <04505386-e4e9-4026-8d68-58e85f2879ed@meta.com>
Date: Tue, 30 Dec 2025 16:10:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Matthew Wilcox <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, muchun.song@linux.dev, david@kernel.org,
        lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
        imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        chenridong@huaweicloud.com, mkoutny@suse.com,
        akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
        apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>, Chris Mason <clm@fb.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev> <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
 <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
 <slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
 <59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>
 <aVQ7RwxRaXC5kAG2@casper.infradead.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <aVQ7RwxRaXC5kAG2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:208:160::30) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: b3040963-13d8-40f3-5717-08de47e7f402
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zk5LUFR2M2VvSCtHL2JXZUdGcFRNazdEcW9PVHNVNVpPZzVWK3FuckZ5NmN6?=
 =?utf-8?B?d3JBNzc2K3NYT0kwMUIyVGNwbXd0VmRtMmRtOFVEZUwrTk50K3krcjVaNTlG?=
 =?utf-8?B?WllldW0xUkZUSjJ0LzdiMmI2d1BSM29CYmppeXpHS1NqWmw1V1lzWWdMQmZx?=
 =?utf-8?B?dFZEY2NDdWFpN0liUHZsNEZMU3UxaERPSlI4SVhGdEE0eFJTajU2cGhIRkJ5?=
 =?utf-8?B?WmI1MkxQQTIzeEhYNGorMjg1ZU1SVldrdkhRL3VTbVdldFV3Q3o3OElpR0Z1?=
 =?utf-8?B?SEV4VGZhM2xEcUQ2eUxCOU5Cb2diWkh6by9WTzgxdXlwek12WjFFQmFpVjk4?=
 =?utf-8?B?NUNsN044ak1ralZQdmhIa0toYWY5bVhwNExwTjlVVlVueWtTalNOTEVMT0hD?=
 =?utf-8?B?VHRWUUtTM1FZTEdOSU1TeUJNeG1ENXBUaVZUdjI4TEUyY1FWRUxhVUZrdmlq?=
 =?utf-8?B?UGF6K0dWdzN3QzVGUWQrQ0g5Y2pIVkRBdmIrK1N1S3NGUjVkaTZkSlJLOTZH?=
 =?utf-8?B?SkRwclEzMnBoNlZ6b0RUVlBDdW01cTlxQWtKY2l1cjhNT1lZdW13bUNNaXo3?=
 =?utf-8?B?NmQvZ2V3bzEzQlRrYkNrZVFGOE5WYW9aeE1rSml2WmlXL2t2eWU0ZG9JTTBt?=
 =?utf-8?B?V0NNMzUwM010OTE4N0ZTeHVyUWJmdzR6OElPalpRdkRocHZBSFcrMkhyUFNV?=
 =?utf-8?B?RDFwRmpZL1ZDcDM0RzdCendXWkF3NjRtN2YyNnNITkxwVXpSUkcxaE1CRVFZ?=
 =?utf-8?B?NXdYK1FheXpicTVWb1AyUXJNeUE3aHBvV0pGMFFVUFpuUTl6K0hlQ0RkUWdM?=
 =?utf-8?B?UmFWVkVyYmRvVFNXYUNFd04zZ1I4Wk5lT1Zwb3c2MUY3MUR6SGFSRGxueWY4?=
 =?utf-8?B?bW5MdzliN0xFalVTTTgzQjRqZzM1ZE42Q2NzTTZBSytBOHJuZkNvZnlCdW02?=
 =?utf-8?B?bUg0RXFlQWQrS1VyNjltYjFTOW9OWWxINThIRnU1Mk5RYllSTk10RHB2STlR?=
 =?utf-8?B?QUdsaGtwR1Y5YnhuT3Y3cWs1QzZyVEkwVFBpUU9pVzQyKzVrRXdZNjBoTkFu?=
 =?utf-8?B?bzdHb0xKZDN4UGFwNlJ0Vnd6TDJkMTV4eXZ3bGFEZUY0WDFYVzVRZmxYZU1t?=
 =?utf-8?B?YWFHMW1SUHFKZFZBcy9KOUh1eXJBNUxJQnJ1RU5aa1VUUWhUYWhaNDRTZTdI?=
 =?utf-8?B?dDlSQXA1eWQyOVh6SjFSeWxrbTlzNEJGV2p5OU1Wc09GM0JCaUwxZndjUmw4?=
 =?utf-8?B?d0V6dDBOQ3JKV0krbW4yVXB3UWkxUFA0QjVpRVRXQWl2SkUzMkg2UFRmTXRB?=
 =?utf-8?B?eUpicUlJTlhRdDc2V3hjMm4wR3RGS2d0NGpyalJZdXErKzR3MmlPMFNtb1RL?=
 =?utf-8?B?blh6QnJGR3B6Y1l0YTRGcjJva2puaUZTaHV0Z1EvNzlrd0lDem9zMmNJVmV2?=
 =?utf-8?B?RjhrWFZhZnI1YnBKUnl4TUtsTWl4aUhGYm5iTVI0Z29iVUlmMWs2V3BWeXpv?=
 =?utf-8?B?dElTeEVod0ZrbG9TRDBBSXQwT3I3RDVmYWdFTzR5ZklDV0ljTUU1dGxjMndo?=
 =?utf-8?B?MEt1cWc4Zk5xVW1ON3JlVmdFNzBsV09hTmZYd1N1M0pHSmdnTi9LMVRTckpK?=
 =?utf-8?B?dkh0WGlDRG5odkpKZS9HeHAyM1c3VVNqSUQrNDFRYUJnRXFVSThnZDA2NnhW?=
 =?utf-8?B?M2MxbTFjMkh4UEUzV0xtSmlHbitoOHVwZjBkUVp4RE15eDZQYnNlN3Zlckpr?=
 =?utf-8?B?K0tvQk1yb1l4aUJhUGdHbDF0V0EybHAzMThnWnRwRHN1MmZTLzA0SzVXY2FJ?=
 =?utf-8?B?alVjTG4vUllwUEc2ekZZQURSVUY0blcraWdJSUtTVG1yK1NOcmVBWjVXS0ZN?=
 =?utf-8?B?UzBDckpwZVFjNWo3UDBhUnMxMSsyaHlkcG1rUWlWOTBOdVlBQmxhaGVXN01q?=
 =?utf-8?B?OHVlQ0VFQzRDalFOVEgyVkZkT1lOb0ZNbFY0QnFtenp5SG1GQnJJU0psVGZD?=
 =?utf-8?B?eUEvclRYREdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUJLK2d0Y2JPbmQzLytxcmhvSEh6WkdSRDAxUS8zL0FzUGtDU3ZVQjFHK0I4?=
 =?utf-8?B?TUlTVzhod2ZvVmh0aHdpUkRBd1NaYkhQNldiNDM1UVpJZzRtRUhiLzlCWjRH?=
 =?utf-8?B?eXlYTjlSYjhQRm5vYVhHMEg4VVdXMGNBWFB0VTViOWlDa1ljV080Y1dXZ3J3?=
 =?utf-8?B?UDFNa1ZrTkxpbGpzK283V2Zwei9PVU00UzJUOFlhRldZMks0M1RFZ0ZOV243?=
 =?utf-8?B?L2E5TUZHdW41c0daNWFxSDRFVlNadTNwOVp3MklBU0gyL2liaW1Ca1M3L0d3?=
 =?utf-8?B?K1FuL3ZIVFlMQU0yeFQyZGJ5eVRNUEhCUmlxZU0zSm53WFJjVG5RaTJrNTZ6?=
 =?utf-8?B?citERVBhdWlvR2hweEZlWm1uVzRRNEIyU3RoVTFrTU0yTjBaMnYrRU5oT29R?=
 =?utf-8?B?bkQwd1BlQzdqaEJSa3ZhaStmRTZZOHNEUVRiWi9ET28wQWlzYm40cWp2NXVI?=
 =?utf-8?B?RjFiYU9kazR2cnJGM1BlY0hzV2ErTlhTTmZvL21WdkpvQW5lQkZsY24yNkZq?=
 =?utf-8?B?SzV4NGV0MmFrN0srSnF3YlAxMkdUeFZuM1J5cnFkeTRoRFNUU3VoNXFhVFZy?=
 =?utf-8?B?bmV3akp5VEM5ZGFSWUJmcHVBVlgzQmZBeldRQXVHZ0ZCNVNqRDdGL201Ym8v?=
 =?utf-8?B?Tmk5UWRBTnMzVzNqQllLQkpxZFR3S1Q2SVA3Zzc0N3hHZG9FMXRsSVIvVk9W?=
 =?utf-8?B?cVhrUmhSKzNXeU5iQVhnSjNhYnQ1aTZmcHBwRGtsUE5VdWpKTUg0MXdwTmI5?=
 =?utf-8?B?RkVUY2JETzFaYmhCM2pKaVBMZXh6ZnJ2YkQycW1XN1BkVnJ4QUZRUTl4Q0FB?=
 =?utf-8?B?dmJKd0dDa3RnYisvci81Z001aFgyZFk3cEc4dUlVK2NadU9jQkpxRzdRVm54?=
 =?utf-8?B?Tk9xM0N1WlRDN2s4U0tIOTNscE9MeHZrREZIeHJVb0M4OVlZYWlyL1lpTGJy?=
 =?utf-8?B?Tmh3aC9WRnJ0bUZoNVowMTI5REo1QTErU0UxejFnZDlldXhlOGMvMCtQNkFK?=
 =?utf-8?B?c0ZXOENzdzlGTVJJaDZsTjJlZy9qYzhzYThlS29CTFg1aU1wcGFMTVkwY29u?=
 =?utf-8?B?YlNScHpRUTZqWkc4bFc0RDNMOXpsbmp0YkUrUi96b2paUUNFMnhFSVBtdXdC?=
 =?utf-8?B?a3VFUXdpNDBzd2ZObkZsYXpUS2dlUENUcEVrL1kyb09hMjIrV0tXM0tHZ0Uw?=
 =?utf-8?B?YWVmaHhpdXRDSllZOVJXWE14Sm16cnhWNFF1OFYwVGF2b0VYdzNLa0hqV3No?=
 =?utf-8?B?TVlJSUhVM2FGZVBxc0FtZHJkZC9KRFI5aE5IVEY4cjVXMERSQU1ReGZ6b2Zm?=
 =?utf-8?B?SU5HSUZrdUtRbC9yT0dZYWR5MjlqRmIzVVA3UktTQVFvVHFZcFFoNHROQzIw?=
 =?utf-8?B?aHJsaks5MHluTUhhRnR5MHBOZHkrVjh3LzhpQTdqNENCd3pWeFdYVCtkVTdu?=
 =?utf-8?B?dHFVc2dYa3pMT0kwbEJrWE04TUVxUVpqbkxqTzFvdS9qY0l0bWp4NTlHZjl6?=
 =?utf-8?B?cWI4TTdLS2s0T2xtYi95NFB2NGJGdXkyMUJBOGkwc0NZZWV3eEtXL2lGTTFG?=
 =?utf-8?B?ME5oZ0cxMWNHL3lvWkNQcUFmWVBWcTlpbWRoS0RQejFTckJVQVdoNzA5YVQv?=
 =?utf-8?B?dExCUXZZSlBDN1dPdThOd3FsQUQxakRidEMvTFRqV3pJcjRoREJNdW03RWQx?=
 =?utf-8?B?N3REaTB3NE9zUVhpNmh1NXBhRUN4L1pFK3VaYjd3Vk10NkVaRzVNWUx5dS9i?=
 =?utf-8?B?azdlMjZINjZxWm5TMHpDeWdrdExHOXozUFBnUERZNkF2ellMRzJWaFRRWjh0?=
 =?utf-8?B?M0RINFVmeUZOV3FaVzRnM292Mzg0NlNUQ2pxNDhuclZVYkczRjZ0bzQvRzMz?=
 =?utf-8?B?bXdtQjRhZjlYakgzVlExaHN1VlJMa21hMWFHeExESGppZXBxREk1eWhSakhx?=
 =?utf-8?B?ZUVocmxob2E5YnM5RFVZOFg4MGxXMUlzZHVhL1d6ekcrRkNTMnBrMDlWOWpO?=
 =?utf-8?B?UHZFK2Y1LzluYXRXUytVYzlmMWZkQWI2dng2LzFIYi82aHM1d2UrMlhla3Zn?=
 =?utf-8?B?TytUK2ZrWWNyZjNuY1ZKNmRTQzBWUkg0VkwwMVpGUFNENzdUVDlQa2JPdG1Z?=
 =?utf-8?B?cnR2dVZ2eUNiZ0F4OTdQd2FIMUpkNEpUbTFmVE10OWo2Nm1hb0NHUHU5YzFM?=
 =?utf-8?B?VUxGR2FHTDdDM21zMGtnU2dPdm9HM2lSbXNVZHR3b3hOeUMwVnpkSlZRNGZi?=
 =?utf-8?B?aElNd2ZSTXk4Mit6OUVzSlo1elY1VFEwNlgrcktNY3lIVE5oNWxvWWRmUjZh?=
 =?utf-8?Q?edc60xnhUHYJLyvgby?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3040963-13d8-40f3-5717-08de47e7f402
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 21:11:09.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32qGHtWTk9KqK0P80ztFWBnW0TyKI5Mm4MReMyCOH+uNby5cbPeVdbNtkI+Bw4Py
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4567
X-Proofpoint-ORIG-GUID: 5YRxP8MWGmGEGTlG9cXma-icgjZ-iod3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE4OSBTYWx0ZWRfXzE41G2BfpVJg
 +Wn8KK4LdAaw8PYH+0LjvXikuIFrDIuXAMQMJO70KgMm9RkbYnOwpFR0UuNJkqmY+Ot9y8sg+MC
 W+FC9TwxxkuZp6RaDHoYPINmv4zF3E2Di83orsfWqRjnj7ToF4MlTDNLj0MDWh+on8ore06Pco2
 Frya9scNNbtJyTz/pvwYC/69IYygb4XpBhBcCAOFYWkb+E+LBpXf/VnEMWAUSEsmV2kgVvsk0Wh
 riTE97SjPD2q0eObpRo9Any0KjZ0ZPiqsvWBaSTTOQGtIrAci8zDDY37c9fUcHZxgEe5ebyzz9B
 jenpMw/62368f1tv6PtDW8MRYHpG9D67H9Bdc/mgMvR7K9k7kQrAA0Ctg+GKRjIqj0fNVOuG0UT
 5CRAlV1bbNuhNpSp9FNwfV7MNy8jK4tFLlsTEfjFhvOOX0N3Yw33vjyYTlmh/7jeeP2e5A9J2J5
 czr6yapvYiZzEzqhpEg==
X-Proofpoint-GUID: 5YRxP8MWGmGEGTlG9cXma-icgjZ-iod3
X-Authority-Analysis: v=2.4 cv=GMkF0+NK c=1 sm=1 tr=0 ts=69543ff1 cx=c_pps
 a=vvCUPcqovLgrcFR9lHNvxw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e8O0uTMVAAAA:20 a=oFbXVLCymPGyUj_0NTIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bn7x_FpfJtc3yKQXRW3z:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_03,2025-12-30_01,2025-10-01_01

On 12/30/25 3:51 PM, Matthew Wilcox wrote:
> On Tue, Dec 30, 2025 at 02:18:51PM -0500, Chris Mason wrote:
>>>>>> I just think you should do a preliminary review of the AI ​​review results
>>>>>> instead of sending them out directly. Otherwise, if everyone does this,
>>>>>> the community will be full of bots.>>>>>> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/blob/main/mm.md  , are you sure the patterns are all right?
>>>> 	a. Page/Folio States, Large folios require per-page state tracking for
>>>> 		Reference counts. I thought we want to get rid of per page refcount.
>>

[ ... ]

>> Early in prompt development I hand picked a few hundred patches from
>> 6.16 fixing bugs, and I iterated on these adding subsystem knowledge to
>> catch the known bugs.  That's where that rule came from, but as you say
>> there's a risk this information gets old.  Do we want to get rid of per
>> page refcounts or have we done it?  (more on that at the bottom of the
>> email).
> 
> There is no such thing as a per-page reference count.  Any attempt to
> access the page reference count redirects to the folio refcount.  This
> has been the case since 2016 (four years before folios existed).  See
> commit ddc58f27f9ee.
> 
Ok, I'm half out the door to vacation, but I'll fix up the mm.md to
better reflect reality when I get back.

> We do want to git rid of calls to get_page() and put_page() for a
> variety of reasons that will be long and painful to write out.
> 
>> As an example of how I'd fix the prompt if the per page state tracking
>> were causing problems (and if we didn't want to just remove it), I asked
>> claude to analyze how it is still used.  The output is below, I'd double
>> check things as best I could, shorten into prompt form and send to the
>> list for review.
>>
>> Per-Page Tracking in Large Folios - Analysis
>> =============================================
>>
>> Based on analysis of mm/*.c files and commit history, MM-004's claim is
>> still partially true - large folios do need per-page tracking for some
>> bits, though recent work has significantly reduced this.
>>
>>
>> Bits That Still Require Per-Page Tracking
>> ------------------------------------------
>>
>> 1. PG_hwpoison (include/linux/page-flags.h:118)
>>
>>    Defined as PAGEFLAG(HWPoison, hwpoison, PF_ANY), this flag is set on
>>    individual pages within a large folio when hardware memory corruption
>>    is detected.
>>
>>    The folio_test_has_hwpoisoned() flag on the second page indicates at
>>    least one subpage is poisoned, but does not identify which one.
>>
>>    When splitting a large folio, page_range_has_hwpoisoned() in
>>    mm/huge_memory.c:3467 iterates through pages checking PageHWPoison()
>>    for each:
>>
>>        static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
>>        {
>>            for (; nr_pages; page++, nr_pages--)
>>                if (PageHWPoison(page))
>>                    return true;
>>            return false;
>>        }
>>
>>    Used in rmap code (mm/rmap.c:1990, 2070, 2473) to check individual
>>    subpages when unmapping or migrating.
>>
>> 2. PG_anon_exclusive (include/linux/page-flags.h:146)
>>
>>    Per the comment at include/linux/page-flags.h:139-145:
>>
>>        "Depending on the way an anonymous folio can be mapped into a page
>>        table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
>>        THP), PG_anon_exclusive may be set only for the head page or for
>>        tail pages of an anonymous folio. For now, we only expect it to be
>>        set on tail pages for PTE-mapped THP."
>>
>>    Used at mm/rmap.c:1408-1416: when RMAP_EXCLUSIVE flag is set for
>>    PTE-level mappings, it iterates through each page:
>>
>>        for (i = 0; i < nr_pages; i++)
>>            SetPageAnonExclusive(page + i);
>>
>>    HugeTLB stores this on head page only (see PageAnonExclusive() at
>>    include/linux/page-flags.h:1153-1162), but PTE-mapped THP needs
>>    per-page tracking.
>>
>>
>> Recent Changes - Per-Page Mapcount Removed
>> ------------------------------------------
>>
>> Commit 749492229e3bd ("mm: stop maintaining the per-page mapcount of
>> large folios") by David Hildenbrand (March 2025) introduced
>> CONFIG_NO_PAGE_MAPCOUNT which:
>>
>>   - Stops maintaining per-page mapcounts in tail pages of large folios
>>   - Tail page mapcount is now always logically 0 (-1 value)
>>   - Removed _nr_pages_mapped tracking
>>
>> This was a significant simplification, but it does not affect the
>> per-page flag tracking described above.
>>
>>
>> Flags Stored in Second Page Only (Not Per-Page)
>> -----------------------------------------------
>>
>> These are stored in the first tail page (FOLIO_SECOND_PAGE) and apply to
>> the entire folio, not individual pages:
>>
>>   - PG_has_hwpoisoned  - indicates some page in folio is poisoned
>>   - PG_large_rmappable - folio is rmappable
>>   - PG_partially_mapped - folio is partially mapped
>>
>> See PAGE_FLAGS_SECOND definition at include/linux/page-flags.h:1218-1220.
>>
>>
>> Conclusion
>> ----------
>>
>> While per-page mapcount has been eliminated, PG_hwpoison and
>> PG_anon_exclusive (for PTE-mapped THP) still require per-page tracking
>> in large folios. MM-004's claim remains valid for these specific bits.
>>
>> Key source files:
>>   - include/linux/page-flags.h (flag definitions and accessors)
>>   - mm/huge_memory.c (folio split handling)
>>   - mm/rmap.c (reverse mapping with per-page exclusive tracking)
> 
> This is pretty good and yet dangerously wrong in some missed nuances.
> Which probably summarises the state of the art nicely ;-)
> 

Yeah, that's generally how it goes.  It's a good starting point, but the
details have to get verified.

> To start with, all flags marked as PF_ANY are set on individual pages
> rather than only the folio.  So that's currently:
> 
> PAGEFLAG(Private, private, PF_ANY)
> PAGEFLAG(HWPoison, hwpoison, PF_ANY)
> PAGEFLAG(VmemmapSelfHosted, vmemmap_self_hosted, PF_ANY)
> __SETPAGEFLAG(Head, head, PF_ANY)
>         return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);
> 
> Now, PG_private is a flag we're trying to get rid of -- it should be
> identical to (folio->private != NULL), so I haven't made any effort
> to convert that from being PF_ANY.  I'm not too unhappy that your chatbot
> doesn't talk about PG_private, but a more full answer would include
> mention of this.
> 
> PG_hwpoison and PG_anon_exclusive will remain per-page state in a
> memdesc world, and there's a plan to handle those, so there's no need to
> eliminate them.
> 
> PG_vmemmap_self_hosted is a very, very internal flag.  It's OK to not
> know about it.
> 
> PG_head has to remain per-page state for now for obvious reasons ;-)
> In a memdesc word, there will be no way to ask if a page is the first
> page of an allocation, so this flag will not be needed.
> 
> I believe there are some subtleties around PG_hwpoison and hugetlb that
> are not fully captured above, but I'm not convinced of my ability to
> state definitely what they currently are, so I'll leve that for somebody
> else to do.

Thanks for taking the time to debug the output.  I think before trying
to put this into the prompt, I'd step back and ask:

- What bugs do we want AI to catch?  I can see knowing these large folio
details really helping find bugs in the transition, or debug bug reports
down the line, so it feels like an important detail to record.  It's
definitely something AI won't know all by itself.

- What details is AI getting wrong in current reviews?  We don't really
have this answer yet, but if AI isn't getting it wrong, there's no
reason to try and teach it more.

-chris


