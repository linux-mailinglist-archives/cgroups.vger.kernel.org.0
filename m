Return-Path: <cgroups+bounces-9875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2BDB5190C
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702611B202AD
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F112322764;
	Wed, 10 Sep 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kDr9xgjY"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012008.outbound.protection.outlook.com [40.107.75.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1092D0C9D;
	Wed, 10 Sep 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513657; cv=fail; b=HI4GjtQaNBbT9H7SuUsHMb1mLrpuQKEeb07irmG+rHiuEsAUf7RvPTd5Lamks+bLEzqwKNlQi4YuZYu+tu9aZXg5DnCfXNVlt4iuZw2QVZ6tGy7Qw+M1YdEY2vAAk8obQ2znkQhcQ7nYXFcBOJnPl5Gq7nIuQRLG8vD6xRIyxjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513657; c=relaxed/simple;
	bh=/4gZm8tpUJQYlc6O7t3TJIhMyeGRr/36UL226tRvDdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fs49hd8/T/fbXjhkn+DTC7udbJbtnDzFOgYFxoGW0HofEdNI2AChxKnsBmf5mLG2eytM6bPANiy4jjlEoHubo5IwsXbf0cUK67+XAjncaRkyDIJOrhtPg94CBUC9gROdwHMF03UszeK87WwlEjyqjg2wo6Q0MEqSFvYRw01kdog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kDr9xgjY; arc=fail smtp.client-ip=40.107.75.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZgMg4mbpjeH/dpM6AEr4Oe9bYnW2U17ER4Z+l+TWoLYZDc5sY1JO2HVv26Y6PC8/LdvOgcv47sPhsYmHwOWVotUJhELwDSMnqhLgU6y2aNrymfiL/f82ptxDL7k8sDM1WkG5pLXuFHKc6nH4Rrmzww1fawY6CFt0DHAadoTv+IW/gzViCrw0EXzfD8BgRj0UbkdJKgB3XunFzL/kAmL+t4yE/DaFDu2mJgR/PH+UDKGYfPNGggGD/AQQ1o18vOJQ3dk4Cd7A7SeGZPQLD/2xAVzf0S9HkGvJhBZYEWkO2OfSqUfeFXc/dc/L8t5XQ23w4j3YxUUvxmcakSbBFKvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgRmjlD2LmJXCGGgx2nP5xOgwtcBo9Ai44iU2m3/c+w=;
 b=Z9AlseVb3grDSkQFp3D2o8vNQsWEs7ONQoXcanacpB5a0JBUyjXT8v7KIG0DanNZg4Tyw8BzmkB3vndkVHw5WTOz2Xj6vemxqctjFt7mSpevA777ufC4KUg6rPxNxk91FvkoDBrZ1fmytg3CokfsoB8ltGUWhyhzdfPef33VZ+ZLAsPa9MhOKqqxlSYrS7Hdsj/ffnC3OIRvXcluZXZJSeySC6bXJ7qzUmeM/P3reKV39ciT5R0zySPCbEibmejEmJ61dAGZsMIxw5q970s+iHb2WlOcA6qjSzbJgm5Lw0fEg88k1SopaP5BbR60akLar4CKQJ4FBnYkMxIBcdUMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgRmjlD2LmJXCGGgx2nP5xOgwtcBo9Ai44iU2m3/c+w=;
 b=kDr9xgjYE4AvgqJwtb3oquqeUVwHdD9NN8GhATFMs+kkL/u3T5HsTIX5gj4+R2nrkTHDufQwkzZE75E1EkGmHitzxYuCFQaZJW2CR+ft2vOC9yFCq/xlsj7gcTxRrYzDtIjkIQliW/bWD2knFzqwVftchDkHM9++4xDxOb/5OcujGLD7XQuC9Sv2y/K7qxDF9pmRWH3QUOgpTo4vqe7HpYMFCyoTu3DYc3vwmFhZnECttjf8rGxaK+9DmGEZdgZyXQgsFAg+BsVc2/BN0pS/O6XJ8H5PieV1iWEi6XWB2P+RBiAxzpg8pAa7Oxny6eF9rhHIWL663Ng3cXnNbXYRaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB6356.apcprd06.prod.outlook.com (2603:1096:400:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:14:13 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:14:12 +0000
Message-ID: <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
Date: Wed, 10 Sep 2025 22:14:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async
 release
To: Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Hao Jia <jiahao1@lixiang.com>,
 "Kirill A. Shutemov" <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Fushuai Wang <wangfushuai@baidu.com>,
 "open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: df4999e5-680d-4a14-9481-08ddf0745134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|42112799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFM0REMwTjhiaEFSVEt6WEVlWkdBdlhSZEI0dUc3TVluRjlrc1NDYnZBbGpW?=
 =?utf-8?B?Q2pzaFd5ZXRMTjlLZjNsWFo5WnZ1MWdvcVlVcG4xVllSZmxLMHJWUStucG1Z?=
 =?utf-8?B?T0tFVWdYVVFVcHV2MFdZQ0tnNXZMYU1YZXJqQU1MaTFrQTkreUpZYlVUSFAr?=
 =?utf-8?B?WjYvSkpaSlRhMUFzNk9VbDN3akd5OEVIUVd3WnE4OVdmWTExNXN5dDgwL1pB?=
 =?utf-8?B?UHhYb3FpVXZFbkdQZ2MzK3BMWEtKVi95cVprZitJUkdld2VXRkFVclo0LzdJ?=
 =?utf-8?B?bXJubTk2N3JuaTlsT2dhR1dBdDJLdGRNaVBveWNZTTJRVCtJaVNjSnpoWVlY?=
 =?utf-8?B?eXBLMFNSeGlxSlpHYm9INjJCbmZIZWhXTis4aGRXMnNmOEVPT0JKMTgwUE9m?=
 =?utf-8?B?QUhJWFdFT0xUZDJCaUFERDN3UlJpUnFnZE9qbXZUNS8rMi9PWEV2Nk5EWjIr?=
 =?utf-8?B?ZzNONlovWWcwWEJDb3hsL25OWkg2aVg3OXYyNWt3MFBUQW1MNnV5bWkwQVVw?=
 =?utf-8?B?Wm00ckxLK20xZ2hMYzgrWHpudnI5aDA4SG1Tbk10V2dOeHZUNEZNZ2YvVzJs?=
 =?utf-8?B?OUF6aXZ3dEUzeWQreVI4cjFhM3dqaEM0eExENmkyVytmQXFIZXdMT0I0MzBW?=
 =?utf-8?B?V2o0SFViRWhhOUdqRmJ6aXNmRGd1N2pqZ2Vrd3czNDhyRGdFU0FtNm9rVEhk?=
 =?utf-8?B?ZHEyOFkxSDhNZ1FJRHUyNnowZXdrSTB6WENtN1FlUUIySTFtYWF2dExrT3p0?=
 =?utf-8?B?Mk0ybFhqOVVPcEZ5VkRkZEdKV2hOL0JOWTY1TmJQcG9yN2JKVVp2Mkt2NStE?=
 =?utf-8?B?TmlNY01xZG0wWWl0QkZBa3M3SGNBcU5nb0NhUE1LOXY0WjVmYXlNUVdyTlBV?=
 =?utf-8?B?TFZqSzAxYjFSNnlXL2N4ZVA0N014Skp3d09aUFVnOGtKKzBqQnZ3c2k1Y1hj?=
 =?utf-8?B?TndSb2M4Y2ZWUWNtNU54QVpBb0JFMFZESUFCOTQ3TElIQmQ1TENSeEJLenBK?=
 =?utf-8?B?VnFNZGxtMWZQYjRtMGkwODNYdTNlSU56WC9SUXpXSjM0a1VvQ2sxZDZMZnhD?=
 =?utf-8?B?eFFGV3JOcmZlOVVaMTZrOEJNL1FmZjRiempGQTRFcWVtWWI4TTBIVGl4MUQx?=
 =?utf-8?B?V3I3M0NjTmdzZVRZVVdPYWczZUl5MW1DOUo0M1ZrRXE2M1hMek5mTzRDYWRD?=
 =?utf-8?B?K282QURTa2hIaXU1aytwZ0l5dFNXVnEyUHdUaW56dXB5YjVIRlR6U2lWTVl4?=
 =?utf-8?B?YzhFUVd2VDZtdTd4eHgvVGFtaE1DUzdwMGRiYS9xeE9EK2lhVVluVDBGL1hL?=
 =?utf-8?B?VGlOSGQydTZmdTNjb0JTMnhPdFRoejdBWGQ2S2NrcndVWmdOODNSRG91czhS?=
 =?utf-8?B?RTRKcUdCV0pKOFFpMDg4K2phaHAwMUpHWlBsNUxWR3V5S2tYczc5NHlmTkxs?=
 =?utf-8?B?d3ZXZ3NxL0MxVUwvMzBYOTJZRXJMUWxzQXJSbUJzM1I3OEoyWkd0T2VWU1JW?=
 =?utf-8?B?dmZuZWJwV1dVMzF1dUw3c056UlMzVFJuRUNEM3dZaGFEdnZyQjRmUmRwcllO?=
 =?utf-8?B?NEV4MlpHNWxGaW55b0s3eFBRSWtzSnRtTVJ6eUQrVVRTb3VIanRLT2I4V0lV?=
 =?utf-8?B?NU5xUXJkU1NlNmNXMTJRVlNFd3VPU1hPKzE5UjRHbFZoM0QvUFA3d2paSGUr?=
 =?utf-8?B?bE84Z3VKMEtJVTZtMmVTUy92aUZLK1Jkbk4zWkxjdENsanFGcDJSWXZsc25l?=
 =?utf-8?B?emhlMGcrbEpTUVdzSlBQc0FXZlI5cWRva0VhUVBxSVRrWjYvMXQ1L282ZG1p?=
 =?utf-8?B?NXU4Z2dQMlU3ajN0ODhzQXQ5Q1pFbkhKL1dDNlFXQXloL0oyTFo4ZTZMZVll?=
 =?utf-8?B?R1R5UmlMa0o2cG5zbnFKVXFlYXlIZDV3eDhYdmtLRW1nYmQwNjlBNi9HaXNX?=
 =?utf-8?Q?h57xIF1Knh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(42112799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEhWTjRuWjYxQkNXcVcydURBMzZSSE9yTkFvUW9ZQmN2bFZBZkRKM0poM3BC?=
 =?utf-8?B?blhDaXhiMm9VbTV3cE9vN2RaS09IS0lDR1NiQ1FEbXc5ZE5OU2hDaFMxcFJP?=
 =?utf-8?B?b1ZKUG1FOS9RWWF1bjU5bnlrWmVlUU4wVGEwc2xhUkxINlRTd1ZMakZOblc3?=
 =?utf-8?B?YlBmbmUvK1NaRVNTYzIrSU1UK2tMZnpCS1FuSjY0ZDNocnZvMjhPNkEyQXNK?=
 =?utf-8?B?aXl6UGc0Z0pZRjlSLzNSeE5CZU0xbEJoUHVTb09kd1lHNVdRVXNiZkI5UWhY?=
 =?utf-8?B?VnBSNHBEbER6S0xucnU4bm9oN3JQZWdsbWtTSlNURzVFdUttQkRsTC9xSG96?=
 =?utf-8?B?MVJOR2o4VVdheXVWb2wyaGdnMnlpdmlpcTRQTTNZWVhLR3BvdEc1MmFmMWxi?=
 =?utf-8?B?OTk4dnQwclRSMytrM1lEQnMvY05ETVRlS3ZPK0ZaN0hudjN0MEdnVkRiN0U0?=
 =?utf-8?B?R1Z2dlFoNlhWcU9uQ2oyRDFITmJTcWVaVndZSGFoUnExT2VYRFBrSnF5ZU94?=
 =?utf-8?B?cGFpN3dhalhEeDJab3VmZTRiWlgxblB5bm1DNGJqL1pLVHRLWk5kV1ZRa1ZC?=
 =?utf-8?B?VmtKSy9qT3dsN1RsKzJNM2doODJtOG1YTkpKVmJEUlA5MzEwQ2xST0grTTU5?=
 =?utf-8?B?NkhXMTJKc05GTlkyblEzMURLekU0N2NrTDBXQStwSjcrNTVZRlZHRW1oVW5j?=
 =?utf-8?B?ejdpb2k4bzFjbFFmenZIaExxZ1dXNGxucmdYUEtJdWR3ZWVHbjZrMDlvUWp6?=
 =?utf-8?B?YWJ2Uzl3bUVxS0duYkpzTUhXdHpBbTJMbmpvVThKVzNzK2tOdmhhTkZvUXVF?=
 =?utf-8?B?YmZML3ZCWEwwbU1IQTlJbWVYT245RVg0ZlE2bGZhdEh1OFVzK0hrdW5xbWVl?=
 =?utf-8?B?dURyNXc2aGR0ZnA4R0NVTDAwTlJZVFphUXI2L3J2U0Y2ZFEyUTdaelp1TmVI?=
 =?utf-8?B?VjJSS1ZDa2RZbXUwRW9EQ0FsbFpLMklucStMNlRseis1U3pxNlA5dTgyOWlG?=
 =?utf-8?B?dVBZaGdxK2UxSEtja3ZSNHJvdXBrQ08xYUhrczF0R0tlTGg1WDFYNTZZcFdv?=
 =?utf-8?B?bzZmTkdJOGZHMExwU0lrUnEvWEcvVllXdXBKekRYTDdPMTZlUHYzOXRuTEI1?=
 =?utf-8?B?OFh5T0JXVmE5cTBBS01aRkFoTjA5eDhZTDgzR0RISVNjbzJ1YVUwNUFzbGQw?=
 =?utf-8?B?UU83VFVKS3d3cFIrb1dqbFV6WXRRYnZEMDF4TDNvYUZjV2tsSU85dyttdTEw?=
 =?utf-8?B?MWgrNm1WKys5RUhTS2xJQlREVjVjeE9CY2M1SFIvdnBWeVNBSWYwaFduRTUv?=
 =?utf-8?B?NW85M1lhazcrd25nQjhrL295aWtGd0tJeEhZQXk2YlNuVUpKUEhmeHFrTWov?=
 =?utf-8?B?WCszZ20vZjQ3MzhyR0oyTGZPc1JHdXArNkYxOG1VeGhhdHR5QUxXM2tkNG9N?=
 =?utf-8?B?R3hhelE0V1ZvZlJKQzVGdmxTNGdyaXhieGtzV3pZUmxmS2x2VjJyd2tTaDJu?=
 =?utf-8?B?YTYrdW51cUI3bDhWT0JnWUtWR3EwRklQUnN3R29kRzBDbjZ2ZUU3dXJCMVgy?=
 =?utf-8?B?V3JQUWZ5TS90Q3cyYWhjakRpUkpBVjlZYS9pdkZEYlBmeWtSNGZCZTFHdE8z?=
 =?utf-8?B?Rys2UkdQQmltclh3S0hhSjhITlFEK1VJcGtJU01iV3NxZ1dGd2ZWZUxxcm5O?=
 =?utf-8?B?cnBPcXVOTXhjKzJxcWdTTzNEMGlhQSt2Mi9EM1hSTWxmTmlpSVcyOW9uRkRq?=
 =?utf-8?B?U0lhRFdHWXFxMnFVVWZ6R2NubXBYMmtMUW04RnQ4aFdySXQ3OWk1VndkQnJJ?=
 =?utf-8?B?WjZBNERxMmZNeElIdGh4NENZaW1hRHlZZ1JYVWUvWlFIK0luNUhJSDRWMC90?=
 =?utf-8?B?bE5acU5DZGE1bWhPc3FnbnNVbXVKQ0Z5bjVpQ1dET2hTc29ZVUlTaEt5NWNp?=
 =?utf-8?B?a3d1VVNlWjlEYy9XTUQ1cC9pS3V3M09lVVQwRC9zNnh3YVBCM1h6cHdlRTZB?=
 =?utf-8?B?N1ZGaHQrVERMcjBCeEtMSXQ4RUZ0T2FQQlFJa0srcUNDcFlZMWkvUlE5Rm54?=
 =?utf-8?B?ZS9ENU1JMXY4ZzhSMDE1RnplUnNQdlhlVE5Da1B5NHlaRTYzY1JvT3kzeW5G?=
 =?utf-8?Q?ttQsFjT8y1de0jMSnSo7g64pY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4999e5-680d-4a14-9481-08ddf0745134
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:14:12.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGGk8VVJsfXjcZrr+t1VFJzUpQeGh4uPACZt1U1Zx9c2s6RXhMISEJbK//mtkmputQeWO6o9yH11oFP4NKsFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6356


On 2025/9/10 3:48, Suren Baghdasaryan wrote:
> On Tue, Sep 9, 2025 at 12:21 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
>>> 1. Problem Scenario
>>> On systems with ZRAM and swap enabled, simultaneous process exits create
>>> contention. The primary bottleneck occurs during swap entry release
>>> operations, causing exiting processes to monopolize CPU resources. This
>>> leads to scheduling delays for high-priority processes.
>>>
>>> 2. Android Use Case
>>> During camera launch, LMKD terminates background processes to free memory.
>> How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> SIGKILL
>
>>> Exiting processes compete for CPU cycles, delaying the camera preview
>>> thread and causing visible stuttering - directly impacting user
>>> experience.
>> Since the exit/kill is due to low memory situation, punting the memory
>> freeing to a low priority async mechanism will help in improving user
>> experience. Most probably the application (camera preview here) will get
>> into global reclaim and will compete for CPU with the async memory
>> freeing.
>>
>> What we really need is faster memory freeing and we should explore all
>> possible ways. As others suggested fix/improve the bottleneck in the
>> memory freeing path. In addition I think we should explore parallelizing
>> this as well.
>>
>> On Android, I suppose most of the memory is associated with single or
>> small set of processes and parallelizing memory freeing would be
>> challenging. BTW is LMKD using process_mrelease() to release the killed
>> process memory?
> Yes, LMKD has a reaper thread which wakes up and calls
> process_mrelease() after the main LMKD thread issued SIGKILL.

Hi Suren

our current issue is that after lmkd kills a process,|exit_mm|takes 
considerable time. The interface you provided might help quickly free 
memory, potentially allowing us to release some memory from processes 
before lmkd kills them. This could be a good idea.

We will take your suggestion into consideration.


Thank you




>

