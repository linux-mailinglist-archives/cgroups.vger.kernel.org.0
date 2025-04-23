Return-Path: <cgroups+bounces-7746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06806A983F3
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E835D188B870
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28226A081;
	Wed, 23 Apr 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aPjT46p1"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011038.outbound.protection.outlook.com [52.101.129.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CE266581;
	Wed, 23 Apr 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397873; cv=fail; b=ZzXIPbYaV+DieKZH/WVrnzhFhnBscGaXUTNcE2ZrnMJahbpUUbhzt9NKCrvNNS967flcU8PRDh1EeEk1vjfVd3ZZoVk/lMLR4Mh2EBYHZDHL0FjOCh64PUJjwSHKJltGPiW1MAsyn/1Mz1vouc5M8pekzhcRjZLWiieLE90Xu88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397873; c=relaxed/simple;
	bh=cKcZVD7csn5hVXvJxQkADSpGaSl5QwCS+ibhE9Q6W5M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gNujxsiphY2w2M7atFcsg7MBhHg1wldKGYLWIFLzKycc3ezqk2WS0hQFoIyDixrpdow8NcKovZw4Bwd6DYn8PeqX4vXTB8sYACu4WT51/GNdDCXgM7Qic8G6LOwz4h+IpUHEwNyFKWn9yBFedAQML4Yq6MH98MOhlACrygTbLA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aPjT46p1; arc=fail smtp.client-ip=52.101.129.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te5k2lV0ZAJLdSWLRBK7N+BJU15NKyiB3oEfleqxCs+/DlkAnn20kI6D8RqFovKHZTv5i4Q05MAJ1TNdfPYl6p5mGaM3YsHn9yCiM5SWB9YZuipPfsXEuTXUhfV//l2PiR7k6XxDQzRUrYrL/dFMKoNvk8VsZqfHPxhM8p5IKJsGHpJUKzrUW3zLMD0vqL/qwfVX8//+AI4Zd1kSmK398xW3npusn99cU8hwDPNLZkvoF9lG602Rr62y4k6gJIkYn5IOyFyxcxutOxJfgQZmSO33feGLEHOOZumL/KF9nhflGRTwKTtk59vap012agkCm1BQ92FZjaoYVy8eXUqKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/La+0NHmzjTuCXICSobiQzL0eiy60djY+p1IuQbiqU=;
 b=OX0IAbhq7KiS9k1KLOUu8Kuvq3zlW5zKwI12VtvCa3bbyu99wRfe3nj/92Gars0FsgSWo2TU5cRdBvyHrnay6puD4THRvZjs3jS1cff2FJ69UNBNZXDmYm8Q7I+xIAWCEafrgNJFG4BwBwz42Obkb/0H1ikKX0jfmiuZnJSIZMu/nWda/fnqBGTPhkh148Jo6rb2Lb/fDxgQhPQ9FUmI26L/oia9SUuyuNAFiEfse8pWzr1zmq4TE7rN7Ym+otbWFXW19ioynUBASZE+qs0Uxhq1hDJ7oe0h7+YJG1AcwL9/oMbpRKG8PWZFf8rBMhgVtIi4HUTv5QvIAyv481PTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/La+0NHmzjTuCXICSobiQzL0eiy60djY+p1IuQbiqU=;
 b=aPjT46p1w/Ct+dhjcYpJZYIkuZQHJyqrn1rFgZPpBslIkfpWSNAV4x4SOQTK4m9IC9sqjl9VwtsfAvStXAiKYQQKbucc+uV//5NMnKzmC+PXwjsuEinOg5jfa0c7Enk2q2j/gh30bvvGje1DdJGyA5rQpAovcVOyiis0xtuFudv4J3+Z4O++SWuSSb2UVNxS/4C4jYy9qaA3Ui4iCAt712o8sduzCG1lItPCdD7ltEUPTShXN6qlEEGQAOtqyuP8n7kqQY7MbglsIO6SNCKm71ugmwCOAKJzeUHPeT9Nw/VKN9tmxk9GvlWuIV2XOhz1kDLQZXHVjdPE972D4B+vdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB7275.apcprd06.prod.outlook.com (2603:1096:405:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 08:44:21 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Wed, 23 Apr 2025
 08:44:21 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH 0/2] Use kmem_cache for memcg alloc
Date: Wed, 23 Apr 2025 16:43:03 +0800
Message-ID: <20250423084306.65706-1-link@vivo.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9dbb62-d877-4a96-cb87-08dd82430a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTaHCppes9V+H5ffjX8Egg/vUf6VSQiKsv07pjnnDyEKvHb6ylGucWusl2v7?=
 =?us-ascii?Q?xOlG4HjPj9shPkXekituz/35sIZrIckFQ6cU9wSJ2m7cnEro/xSOlE+htF89?=
 =?us-ascii?Q?w3iHHH0xkd2nr9a68zjx0q1DLfaHVsN/kJ+1C/9hC36ollbx9UntCQWIVJ2K?=
 =?us-ascii?Q?gIeA5vTGRc5zXHYamhUWSU8cQta2TLvZ6qFts4NX1sX4xFH5AgxS39PS9Vvx?=
 =?us-ascii?Q?CaIfTwtfL5e+SoaBy66reko1Z/JyoMIFjy40yqrQommqSayCzFePmWMetk2c?=
 =?us-ascii?Q?DiuaY9yoUO3KKX/jx7Uq0gv3Ph5w+42crYY17nzdJg/kaHA3TofY5xkkD4lk?=
 =?us-ascii?Q?iIJCFv0zPMQNhKCws/Af+rw3wllHvOrCs/KuzvrrmtcVQnN8JVdWWeDW0ljK?=
 =?us-ascii?Q?JfqCVQPoCsh5B645AbyUedhxByQZr9Z60jX6hSfqBYdy61bPe7iywA8E3QyS?=
 =?us-ascii?Q?a4peg0YoVq6ZYDqT/mtsYz12QtJa0kplkI+u9XAzfd84USH3ZWMDXsEk5lrP?=
 =?us-ascii?Q?zzl5ghQDtZt9CGoV9vgGVzFKFwQm/xry48Apuv2V8FBdjsEOSA0IAfrWY5vd?=
 =?us-ascii?Q?gsKT4w5fq8GTgyQzqqtBbWYso+CqysGchgg8bJwm+CBaOczzpQS66a4nDpBE?=
 =?us-ascii?Q?SyBFcWfdnkcAyPgdWICCLbZU7zR/yFkcZGlDtt4Hfa3IajIYMzThcfWYRor8?=
 =?us-ascii?Q?WOfIDcACgLYuS8nxr/l8CK+nxTotTHQoe63L3pUz1ZnWmH/9A60jmmmQg1y0?=
 =?us-ascii?Q?qcZw/zAjquJWCNbSVspfcYjHU45KQt5gvFDBG1vDvqm6gEwBkMhT/+2ZQnC/?=
 =?us-ascii?Q?VXugyZjtIgnW90an9ctiGCC5OyNzBVogS2LnmGWsyq5+B68Mm5HIXui6nlEH?=
 =?us-ascii?Q?9/BpAFabWpmR08tFNucXLO7Y5gZ/KrdaG84ZQ9xJnxCa9Yo+DSCPHypOVjdy?=
 =?us-ascii?Q?d9zxOAEs2cgwpvAktjeE98sloA3cggoVOt2AoFCkPHxArvFXvUvJv1zbalDc?=
 =?us-ascii?Q?Ps0O7IqAukSPn9J/30exsE1qxB8E9oiy5CiceHRl070BCLcj8QQm1wNPe1Jc?=
 =?us-ascii?Q?3gfXpW6wJU9D1DPMvN9R0MOaFwhcEeICJZ9CUbu0tUZEhGqM2y83IwRKb1Aj?=
 =?us-ascii?Q?eJm2OR2PQIXswcRKn9Yx0mlcL3Ix6A7uf3UMVrfKvk2k4qk7LLkmsXMCjcIT?=
 =?us-ascii?Q?7ECX2KzO30uU6A4sBSXna8PeEC7+mhxDaIF419Kiu0Td9LH8/r3H8XDyjOIF?=
 =?us-ascii?Q?NceGLmECL5jpPNC9DJYi53oUaLH9jKtvzDYrMh/cnGzrFpoVDYoj+RDlqdDA?=
 =?us-ascii?Q?X+Ps/no8uGD4b0U2vQj/9FyqNLbeOdlbWV39wLz6Zyqw3nQtfJXrmxGAtAx7?=
 =?us-ascii?Q?Y8TGrDbM9HfLq+ssIeENHwG8iTLsMEoe0eZsSMz0zo/wFYerRMFPhOpzIldk?=
 =?us-ascii?Q?xwM+WBXa6tT109tJxKeZj/RjE1AuIrfzbnejzPLtQcUtFl5ZK4gMxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g53i5z2vjj/URkmtAOu/PbKX8OxPtOBGtw3sOCTEPOalx1pjBdZx7PI5Ibew?=
 =?us-ascii?Q?5oTHOTs/qXo1VGkGOtWVaQnmWlyv+0EmrZA7QCrD41H+m0CQoaj0QceImkmG?=
 =?us-ascii?Q?nbysqV4NnOYUElofhWYPp9j0w3qYuTKmmFY2UdrYTvjyRaUzaISpdOKp807m?=
 =?us-ascii?Q?qxw921w8d14e0Uqi+woR7Ldi4YmyLa2zv0xJkZp44M34tKv0pEoaRgJSrM/F?=
 =?us-ascii?Q?Qpe5vHBxJPKINn0whPD8oqLJ4S8Y7aihRtXsvCxN/8I6k2FDDzJojJWbavMx?=
 =?us-ascii?Q?kVXLVsqRdmEoroLcyq6//DHSZ+dOgBAkDrQvgKmINQ3Xxd2qGEFfPX2Ivobr?=
 =?us-ascii?Q?ZBttfsDJNradNsTzrPxtwXgu21lfowIuzKdBL+eZiDBqNhUZlRd9ZM/9M0lF?=
 =?us-ascii?Q?BEFq8uy1tR/z35K0dSCM7GNpdckK1ccvp+1n6VQl6ip5vog7v7fu7wbm0dvT?=
 =?us-ascii?Q?+8bXydxgQ2K+Qy1qTmwkC6t9Hfa4PdWM9XUQ8O8A7xK/VW8zxp3IV4m/uZ/R?=
 =?us-ascii?Q?hClTuHVzZlTgm4v4M78ob6SjByxqyCyNzUvbRvVkGpGkPbcK6y0FzDBR9TbU?=
 =?us-ascii?Q?ysnbJWjikSJetvL9Hf2b48FARO8CIKSadeEXTsXkyu9zRQJonRrsaPNZajaQ?=
 =?us-ascii?Q?pjpa5r0chmCQJ9rGz8I7kfm3r82jKApJXuFIbpTZJt6MrsVvTUuuavrxXfUr?=
 =?us-ascii?Q?jh4lU3eqBgkCIP7s6FbpkgULfiJaa2aYajjYBG7QLwstGv3N7RJiwMQAW7QW?=
 =?us-ascii?Q?OmmCfAWDu5vOsYU5QFumvcQuxF394S/UTbYyrPb5ivPZp8AdvKkHowtjOU4s?=
 =?us-ascii?Q?bwMPIbr96JHhtQ1Zc6k4HjE9RRqcYfC6lEnAG6xrMwlGL5pc867p567PeEC6?=
 =?us-ascii?Q?f/BH2ocFLVIb2hg3bqxKFntoUDaG4myYYoO1gE9VyjW1IU4woWwQhzRMbRlA?=
 =?us-ascii?Q?dmpA2XGUFFj2AnhZXf7mH71WSCi4VNOyM4PHBcsJO7uAT1u1b+5JACT06Hrp?=
 =?us-ascii?Q?E69eEDkDaBF5NsJOAM0jaJOcwc5YfA/d9OOKe5isvYW6djGyxGHVet73jOK2?=
 =?us-ascii?Q?vc91HNzHVuSxXO2/h9+cRVYA4MeyKgo68Nj6S0FMLkI++97VT1teqt4t4PVP?=
 =?us-ascii?Q?iCC53mCEhU4pUS7qkWxlaOl49/dAdUYi26k1dYjzYFxv/JoAoPKOJ7NY2i4C?=
 =?us-ascii?Q?e3FL/8K1hmOvH3tVSSud7NviUsbyvIU8pWhXqI4ExTTKB5nVb1H0IzgfOM1+?=
 =?us-ascii?Q?VfsEIkqiQo1SqkYQLE0pFWuqTaiULhabLI2iPAj/Em89Qa9sN88R83JSzO5s?=
 =?us-ascii?Q?MDsTk+nT6uhi3SrgzZs70QsTiZ4Q/R7JNv/6mfYsUtc1dJjOPSIVL92KVoZI?=
 =?us-ascii?Q?fZhWPB8OHMPF/JWupgccuogDpc21aW0eVIGgIb7hO/flfNppr1wspVsIZZG8?=
 =?us-ascii?Q?agKsXObOzrE7OjNWAam7R8N+hjnhuaG+9wb/fmt5UNps4aJ30bassg7bTtAp?=
 =?us-ascii?Q?x4QCenlbSdau/2gGKfdf8pPBuROY+xcmI7iwIoM14q9sszE5jgmxVv+MBh0E?=
 =?us-ascii?Q?dW1jkmJf/3xU0bxqAC1bwT0MSdelatEol6flZOHQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9dbb62-d877-4a96-cb87-08dd82430a80
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:44:21.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HXwG0gBWlk8mWLWvuUTffz3UWMEkuSDtMS/baIbH08saXH04nW1UkJXInRVAvhsuxxnOxdUujSpXY6wDt1p9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7275

mem_cgroup_alloc create mem_cgroup struct and many other struct include
mem_cgroup_per_node.

In our machine - Arm64, 16G, 6.6, 1NUMA, memcgv2 with nokmem,nosocket,
cgroup_disable pressure, run shell like this:
  echo 1 > /sys/kernel/tracing/events/kmem/kmalloc/enable
  echo 1 > /sys/kernel/tracing/tracing_on
  cat /sys/kernel/tracing/trace_pipe | grep kmalloc | grep mem_cgroup
  # In other shell terminal
  echo +memory > /sys/fs/cgroup/cgroup.subtree_control
Then can see ftrace show may like this:
  # mem_cgroup struct alloc in mem_cgroup_alloc
  sh-6312    [000] ..... 58015.698365: kmalloc:
    call_site=mem_cgroup_css_alloc+0xd8/0x5b4 ptr=000000003e4c3799
    bytes_req=2312 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO
    node=-1 accounted=false

  # mem_cgroup_per_node alloc in alloc_mem_cgroup_per_node_info
  sh-6312    [000] ..... 58015.698389: kmalloc:
    call_site=mem_cgroup_css_alloc+0x1d8/0x5b4 ptr=00000000d798700c
    bytes_req=2896 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO
    node=0 accounted=false

Both two of them use kmalloc to alloc target struct, which size between
2K-4K, but get 4K above aligned slab object_size.
The reason is common kmalloc prepared many pre-defined size slab, in our
machine, like:64 128 192 256 ... 2k 4k 8k.

So, when alloc mem_cgroup or mem_cgroup_per_node, it request 2312/2896 with
between 2K-4K, and no other pre-slub like 3k or more large but low than 4k,
so it use 4K slab object_size.

So, each memcg will waste 1784bytes, and due to 1 node, also waste
1200bytes, sum as 2984bytes per memcg. If multi NUMA node, this also
increase more:
  8bytes * nr_node_ids + 1200bytes * nr_node_ids
This is a little waste.

This patchset add two kmem_cache for their struct alloc.
  patch1 - mem_cgroup named memcg_cachep
  patch2 - mem_cgroup_per_node named memcg_pn_cachep

This benifit can observe by this shell:
  echo 1 > /sys/kernel/tracing/events/kmem/kmem_cache_alloc/enable
  echo 1 > /sys/kernel/tracing/tracing_on
  cat /sys/kernel/tracing/trace_pipe | grep kmem_cache_alloc | grep mem_cgroup
  # In other shell terminal
  echo +memory > /sys/fs/cgroup/cgroup.subtree_control
Then show may like this:
  sh-9827    [000] .....   289.513598: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0xbc/0x5d4 ptr=00000000695c1806
    bytes_req=2312 bytes_alloc=2368 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
    accounted=false
  sh-9827    [000] .....   289.513602: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0x1b8/0x5d4 ptr=000000002989e63a
    bytes_req=2896 bytes_alloc=2944 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
    accounted=false
That mean mem_cgroup request 2312 bytes, given 2368bytes obj, and
mem_cgroup_per_node request 2896 bytes, given 2944bytes obj. Which due to
each kmem_cache with SLAB_HWCACHE_ALIGN.
And if without SLAB_HWCACHE_ALIGN, may show like this:
  sh-9269    [003] .....    80.396366: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0xbc/0x5d4 ptr=000000005b12b475
    bytes_req=2312 bytes_alloc=2312 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
    accounted=false
  sh-9269    [003] .....    80.396411: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0x1b8/0x5d4 ptr=00000000f347adc6
    bytes_req=2896 bytes_alloc=2896 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
    accounted=false

Which bytes_alloc show as expect, but I guess with HWCACHE ALIGN more worth,
so this patchset use it as default. If anything wrong, please correct me.

So, how many memcg may show in real machine? This is depends on how we group
memory resource for task. In our phone, we choice per-app-memcg, so this is
depends on how many app user installed and openned, May 10 - 100.
And if by uid-pid group, this maybe more, may 400 - 1000 or more.

Huan Yang (2):
  mm/memcg: use kmem_cache when alloc memcg
  mm/memcg: use kmem_cache when alloc memcg pernode info

 mm/memcontrol.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)


base-commit: 2c9c612abeb38aab0e87d48496de6fd6daafb00b
--
2.48.1


