Return-Path: <cgroups+bounces-16879-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ygHMCpvK2oe9gMAu9opvQ
	(envelope-from <cgroups+bounces-16879-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 04:30:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B78676491
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 04:30:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=os.amperecomputing.com header.s=selector2 header.b=M3EkwOPc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16879-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16879-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amperecomputing.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848FC310EDF2
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F612E7BD9;
	Fri, 12 Jun 2026 02:29:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020142.outbound.protection.outlook.com [40.93.198.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588572FF66A;
	Fri, 12 Jun 2026 02:29:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231394; cv=fail; b=mWJO78MnqQVY2L51RYeBKYZZYPWM1H6hwDbM7L19Y9CrcUlcIzC+b5DlTUjKV6ULymx/IQPCLFPikdEx/jjIqCETTWbwluzCS17XThBLPt+k5K2F0aXgMs987Sg3xpXT0Z6unln430pxMT8WflvAZi3r8+FoQAAfZ4CTthmcqy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231394; c=relaxed/simple;
	bh=UGAO6/47pCyEB9C+NXS0FN0f3/HUxRscOF9zJqaPESc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=U9KlwKfwrC+83EsC8y/xxecsdGyWVJ/nxit2r8JTSxi4HG50OErV3YpBmf6Es6rfInV5CTHIIcedsKGEUaLS7DalmgV/tAPFws1bKU2KB9eVIW27PeeZIqQbJE3ZQ0DKuiy8/IfQpmTkWnM1Wkk/hTaQVm8QQuFNEt73ACC1giM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M3EkwOPc; arc=fail smtp.client-ip=40.93.198.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD21AmFgpPCpbsamXv9MUkldzYw75dWoCpkgNGUUg6YJB7b91BLVdjlXZ2pWDf0PTSxtGOQiQOf8k6Jo9ee2Qz8Qpxu2F14esbxW8QbUj/JWcs5MUeYVFp9t/zESefk9SLTnuEde+YnGDlO2MMyahehmg9LXBkfhnAenOiBRYcG1ZwIxXUGgecjFWHkm0IOwX4tDf6CFop+2NgprshChkM4r4UojENfYypR5DFygKKYmOnqhMtkbXkPUiuj0lamHCVgb9Ciqvsv/4Dvb1JAS02TTlGr3AHtVG7OBA/s5Ua9I9+DpNkBj8psBF1CIR3sj3AB8//eul8uQ/f77mfyteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUsFVx/DIY/7q7JFfbyv876C9xjE1Zg/XtlzZNyXV6o=;
 b=JDr6qaGTMNxO4Bz2qU6xcfdJPYqPkUg5zLXrhoAP1WHgIRiZMO/RBKj3oTBPSiWog8tv1Armrc0SsI/Z4IswR6ldIaWA422nAIOfc5QuDIPWy8891pLIUjrO24I7DHDvD/683dCc94NZeH2ooyBy6lPYOsbSUwhs5aai3u7Xgs3iYjMDlMMCMxid1aEz1l2ACi6y80K6IxfDOuUWLpBi48hsEv4EW4sn18aPULZB6EvjhG+m9q/kNRIXixSVYAP7v0yc+Naoe9up2M/qYluV104QJoTx559dKllM62zaWUFP9Sl/C0UMBwnz/v51JM+K4xDOxqWwBEWLYL6F+Xciyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUsFVx/DIY/7q7JFfbyv876C9xjE1Zg/XtlzZNyXV6o=;
 b=M3EkwOPck6nr9z8SJx8d4zBxXglBqdQvuh0u3N5+LCE3EyHo60HaasXRvxVpQQzmKfzBeKlWtU/KBdqneBrmL/VlhSQGyZ7CEgQCXp2bSQIC1Xt9gVyoMy/smiHa3VGeq9D9WgXq/ScgXw8W3x1Q767rHrtAZ6PWfzrtb/pX6AE=
Received: from DM6PR01MB4953.prod.exchangelabs.com (2603:10b6:5:8::15) by
 DS2PR01MB9254.prod.exchangelabs.com (2603:10b6:8:27d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.18; Fri, 12 Jun 2026 02:29:47 +0000
Received: from DM6PR01MB4953.prod.exchangelabs.com
 ([fe80::4d2:1a2f:e4d1:5f7f]) by DM6PR01MB4953.prod.exchangelabs.com
 ([fe80::4d2:1a2f:e4d1:5f7f%5]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 02:29:47 +0000
Date: Thu, 11 Jun 2026 19:29:41 -0700 (PDT)
From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
cc: longman@redhat.com, chenridong@huaweicloud.com, juri.lelli@redhat.com, 
    vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
    bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
    hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
    linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com, 
    qyousef@layalina.io
Subject: Re: [PATCH v3 0/7] sched: Flatten the pick
In-Reply-To: <20260605105513.354837583@infradead.org>
Message-ID: <6f015e47-e4b6-8fd8-ed36-bac07c2bf372@os.amperecomputing.com>
References: <20260605105513.354837583@infradead.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CYXPR02CA0078.namprd02.prod.outlook.com
 (2603:10b6:930:ce::16) To DM6PR01MB4953.prod.exchangelabs.com
 (2603:10b6:5:8::15)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4953:EE_|DS2PR01MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: d08a6128-ffac-4f79-4de8-08dec82a78af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|3023799007|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	+CsP/N4xk1Je3K7wymLoB9NAmRuUXbYFqVqE37epWGcHHFZRz3tJ0/YEXPqlIrzNB7D1O2+//9W8sym0M/DHyJdj4gsW08P87nmKktfBKalGDM8qc4yVj3Qstw8+D1uXi5Fcp69U9gmT99EFKfihZERagYcGsJirKmpP5D6EAGH6zYwTLZu4o8629IRPMatznh5wrKu/pwXAD2JJlrjhn5R2HWBV1LIQ7oaaoKnvn8aaYYjPjaTLH8GZ0NMimHLBAaPiAjPS/WwLSH2S3bs6DiihFlJ5zqFxIqj2zBLS/BFqqD0ulestQGP4zO39QPbwfkS3W5WUU75U8iuUOVYeUMphJaH/eNkvgjh/DHgvU4ATrgt0bm/i5TWQJQRzIWK+qTKvNi8I4a2SHQYCfPwBQSrrhEHjmViKpD2PMFTkH4GGu4W4L7HcWfB0Td6NhygPa1XPij9B1I2wvLv0RYgqXi5bqQfoJc70QMj6DN2gRUWxEv9R6BF5/y8VBUysqODoqYbVS+7SWnqDlfRh6roYBJ8bRSLvlGfVkhRmL9YrvnC2O98JiLeTnkvYMWQZfAU0iuiYZT3XX4UO/P3yh5kv369FHmYr9zSyceB+a4UbbCLN/P9vc5FQc1q1l2XHz0E02DK0SUkCxnAM3OPsfuCA97xQSWdcVQQJU7VDYJ/8GbqORRrvkADHlIGEZ2fcvoKJr4h+/4xsqsxjYJCrghFhZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4953.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a70xd1jY7S5/Y/kHcoj5Te0dVa5SGMPH/9WAE7Bl2kvvAjRwa7WaxiOn/gpa?=
 =?us-ascii?Q?YhzuYYpJ/zShz6Of9FGOzXVHlXE+qheMyXq13IGjTrw57JqqSxd8KAwTpddD?=
 =?us-ascii?Q?bgai2cAaN0LBrhHV7Bj2AzZ5RvmMJg4iLhL/n7ye93cDspo6mBshZlWJaNyR?=
 =?us-ascii?Q?n6wHs6THDAWmdoaiPaqGeMwuDdDramVukFwchxjaysThA1aGedZJ9L1lwMqV?=
 =?us-ascii?Q?E/2RwUu8eiyW+7CMThtU3IoZKY6qTFts0pu7L7dsL8K2Y11myUBtWLzf8vso?=
 =?us-ascii?Q?YPteEtcVUY+nS7JMgrgq+zLIhGvQsJ6OeINaciILsKDJyWaaG1RiYver/RXk?=
 =?us-ascii?Q?hj/JFZCyJJgUUTSd+7c3OP7k7hOIW0ACgYF4ep411JhMpcTwQhGU/bwniToA?=
 =?us-ascii?Q?TGYDi5E3jUZUDhuF6//SlxNQwq3dFTnMKIPZEVXibXKwVElyMSHxeEBFFRav?=
 =?us-ascii?Q?m8lCsKKDn6gyWWTFbT3dWNi3MFOLKOA2TKp3hqdAthX3ZzwymyBDWy5TVZe6?=
 =?us-ascii?Q?7quodYfeInMqOunAAyaLdKKDOXouF/bsT+rOwGuNKzfRraKQPBiPGNKhoevU?=
 =?us-ascii?Q?IqJnR+73GtpsCpqIvsqhrqRAhOykz1N9xMXw/53w/CeqeubMa50GOALyKCXo?=
 =?us-ascii?Q?QU7VZho/GCZipHOIemFlrlEUT0UzgdUunsotv3gApUug/wfkwKbO0FZrATxJ?=
 =?us-ascii?Q?giiSpR/QD2j8sxpC58QVOOE/AfzHLHM0+rDrQ7QwwqyG6KD/AovxEpl5w8hx?=
 =?us-ascii?Q?jcV/ysbGZYzLw5SAcfvvL/dgXNx8nPNtgJUknnyOPx7hqPnhKSNTGfaPSbHl?=
 =?us-ascii?Q?ApJxnW0Lku225gdyt1w8cBXliOjmnPRPY858U0PYod0a5lrKnNAlJpxLO27J?=
 =?us-ascii?Q?CYgK8oFJGYaYFgkd6j90lOaSZQA+kzKpT3E/eWZ8HvYkg5wzRXN3dTu2GQ2J?=
 =?us-ascii?Q?U3o0Bp3sbgMwf2e76iDcjoO7RkIfF2C5bI4QU5IygZpwL+nmliBg/AnDo0YM?=
 =?us-ascii?Q?ZGD/5LRZMKGMwJIva/a+3qqKg59bl1OQVuO6qZI//XkfcnPxTcyr1KFxwCmM?=
 =?us-ascii?Q?1lwrkg0ERmpZr4lzx3BUiyy8/+JJXEQNGpJ5ZLwgjicDzxYovogQCd7iZk43?=
 =?us-ascii?Q?MyxPy2v4gZb52mVVpajnMXY5IKpNBwsScSIIBEo0mnlacLNQq5a8J7IK8L9r?=
 =?us-ascii?Q?VRNdP9owXScKPJzG7XG7U3Myeu2h8Ofe7rMLjcrvRXlxWVOgRHrmaH9MRUDx?=
 =?us-ascii?Q?0s37uT+P1VJdvpoJGJqQWLNN6qijuetUghqrtspoepDimXqXExMAzNm8HZ6a?=
 =?us-ascii?Q?l65F8crDrDM+bo1Vps1AmWBK+TslfUoJUXVpfl7fDRVdTxbvgLK6a+R6RCL4?=
 =?us-ascii?Q?C6ktDZlITWlpMARxZ+mvzw7U3MvgthVsFM6I/FugQ/XBmmdhLIL1m/dr8d1c?=
 =?us-ascii?Q?jj8GOZ5CC4tfFd4jAJQFVQQWCVWA7b9vu45gHYwuFZq7NNV0eoFYDc4zzA0v?=
 =?us-ascii?Q?GAqzxNt7f9qCo1iB/YxByS8WkIFObQl3rUUczjSeKsmB2cnJ+OQobm+lTcTp?=
 =?us-ascii?Q?7C5VU9UyoWwLxM05ijJe08dUPfGVxyOq4FEnzPk0tQeBvy0kBzmrgEa8d1m3?=
 =?us-ascii?Q?5/JbKj1ZAzm7F5lcNAj/XFwlRi2tRl/nXuyp5v2AazYgHbhDV/Otr79ddxNS?=
 =?us-ascii?Q?sXOq5POGV3Rkc8gaaGGwwMYvVtJz/73kS/7vwqmcCpgi0Ph+0PRb5kKynzL/?=
 =?us-ascii?Q?1/LTDShbJSPds5jaFWsazdMX+M3wRkDzSVDFOe9UZLKujfOlyzvC?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08a6128-ffac-4f79-4de8-08dec82a78af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4953.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 02:29:47.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WhlNoqPGDB4iQo8yAUuHbAEecB2+fVtIykEjTEYOX3N4Q/svrGMfAjdZxmcZj9lxuqhxGk0R8+RFgaDTRPE9w7G2yFIADKKZSvUtAKkOx49m+yORGV+BvQL7E07LDbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9254
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16879-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[shubhang@os.amperecomputing.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubhang@os.amperecomputing.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B78676491

Hello Peter,

I applied the `sched/flat` patchset from your tree on top of the
`tip/sched/core` base commit (9ebe5c3c29f62)/(7.1-rc2)

The evaluation was performed on an 80-core, Ampere Altra
system running Fedora Linux 41.

Benchmark Runs:-

1. Hackbench (Execution time in seconds: lower is better)
     The data reveals a clear architectural pivot point at 4 tasks:
     - Low Concurrency (< 4 tasks): Regresses by +1.8% to +4.0%.
       Removing cgroup isolation boundaries expands the idle CPU search
       adding slight overhead to the wake-up path.
       * 1 Thread:  (+1.8%)
       * 2 Threads: (+4.0%)
       * 2 Procs:   (+3.3%)
     - Tipping Point (4 tasks): Performance is completely flat.
       * 4 Threads: (+0.03%)
       * 4 Procs:   (+0.1%)
     - High Concurrency (>= 8 tasks): Improves by -0.7% to -2.3%.
       Collapsing the tree structure down to a flat layout removes
       multi-layer load tracking updates (update_load_avg), saving cycles
       under load.
       * 8 Threads:  (-0.7%)
       * 16 Threads: (-1.8%)
       * 8 Procs:    (-1.2%)
       * 16 Procs:   (-2.3%)
       * 32 Procs:   (-1.6%)

2. Schbench (Wakeup Tail Latency)
     - 16 Threads (128kb footprint): 99.9th percentile tail latency drops
       significantly by -12.21% (us). Operating on a unified runqueue layer
       prevents induced group-level throttling.
     - 32 Threads (128kb footprint): 99.9th percentile tail latency
       regresses by +5.50% (us). Eliminating nested queues increases lock
       contention during heavy simultaneous wakeups.

3. Sysbench
     - Sysbench RAM: Throughput increases by +1.55% (MiB/sec). Fewer tree
       traversals reduce cache-line bouncing, freeing up cycles.

The patchset trades minor low-load performance for better scaling and
tighter tail latencies under distributed load. However, the majority of
these deltas remain small and sit near the measurement noise floor (<=
4%).

Regards,
Shubhang Kaushik

On Fri, 5 Jun 2026, Peter Zijlstra wrote:

>
> Hi!
>
> New version, same story [1]. TL;DR:
>
> - Adds new cgroup_mode knob and implements new policies to address the
>   hierarchy level weight mismatch.
>
> - Builds upon that base to create a flat / single runqueue scheduler where the
>   cgroup hierarchy is expressed through dynamic weight management.
>
> I'm hoping to be able to merge these patches early in the next cycle (after
> 7.2-rc1).
>
> Random benchmark:
>
> Game vs 'for ((i=0; i<8; i++)) do nice ./spin.sh; done':
>
>  Lutris / GE-Proton10-34 / Steam Runtime 3 (sniper)
>  Intel Core i7-2600K
>  AMD Radeon RX 580
>
>  Shadows Awakening (GOG)
>
> 	  default slice(*)
>
>  FPS min   4.0   29.0
>      avg  47.5   59.2
>      max  83.7   83.7
>
>  FT  min   9.3   10.2
>      avg  34.0   17.0
>      max 121.2   30.0
>
>  FPS (Frames Per Second)
>  FT  (FrameTime)
>
>  [*] Command prefix: 'chrt -o --sched-runtime 100000 0'
>
>
> Changes since v2:
>
> - merged debug and prep patches
> - fixed update_entity_lag() on dequeue (Vincent)
> - fixed throttle vs tick (Prateek)
> - fixed wakeup_preempt_fair()
> - rebased on tip/sched/core
> - rewritten cgroup_mode changelogs
> - reworked cgroup_mode concur
> - added cgroup_mode tasks
> - changed default cgroup_mode
>
>
> [1] - https://lore.kernel.org/r/20260511113104.563854162@infradead.org
>
> Can also be had:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/flat
>
> include/linux/cpuset.h |    6
> include/linux/sched.h  |    1
> kernel/cgroup/cpuset.c |   15
> kernel/sched/core.c    |    5
> kernel/sched/debug.c   |   89 ++++
> kernel/sched/fair.c    |  943 ++++++++++++++++++++++++-------------------------
> kernel/sched/pelt.c    |    6
> kernel/sched/sched.h   |   30 -
> 8 files changed, 607 insertions(+), 488 deletions(-)
>
>

