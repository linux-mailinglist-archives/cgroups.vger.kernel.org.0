Return-Path: <cgroups+bounces-9997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D05B53654
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0646F18882B6
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32180340DAB;
	Thu, 11 Sep 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OS3lySmH"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFE33CE8A;
	Thu, 11 Sep 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602321; cv=fail; b=UwF4L3Q7+xYwIlrmPgbIvl8Fbgc5bM4Xbu752S4nTnXMWyyy3vg/Szp6pJRqSYUfmg3qhWU6Sb4zUwHuJZAtb8eoJkVR6NGCfN3U/e2cYVw7n3NXph9Vrp1sNBjRyQXsIhxd3xGzd48tWBXxWiK1L3R5xazlui5DUNqFaw8xXOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602321; c=relaxed/simple;
	bh=hvROQ8QUnOsH5jldVNhQTRpoFHh3Wi8hdJBiTqBanXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDBp7ZneGHsoGllZRdpV4lD0/+qiAEbZZdwANx7xYGWDyNlkSobJIaW/7s2UTXZAOSQDtuIRub+MEadwLqSKcpUQbclvFJZLc1iTOC4GaKyYr3LBxX6dz80t5eGnmWt64yewQg2MsF4Acl3snOEMGJd/5qwD3gEyhlumVBRsRG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OS3lySmH; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlEsRis6U8gHJn0LSXS3zCXRTonCOr5tU14QiHv5Ex6USZdV4NiIp+jlQyioEh/4M5FHlVr+JZIxPF9/+v7JPcBqg9H0x6tljFkh+suWvBKzvgZgjTxgT/wnb2I+9ZO8oSkG+1edZT4rH2ugzg9rTXZJRvz7Ij5dHbfs1r3EQOW/HFGHKm1BxOS5ecy19XhO20fZCGenmhcI8yUhBrO8EWYS8Az8+m21X98pA4CRh7mAzJ+lspv8wcZ97RV6KkSDdEckpFsxoNrjHW+sqCmwliqBcWMKyXbtJNSj6NHqVNzzA/P2kvxLbrRMbsH3U+hmcisnH0ZEWjJw9tlfLLqrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E9XhgS+jpyAEs7nRlNC+hqRC7xlR/MUQQ3TQ3pu55o=;
 b=fgT1r0n7ORibD5Oy+VxbKmm9SMeyVlsAUAsaMRpNz5V+CA1AkeD6rfOACfnGpuMBJcSE7/NwfVnaA2giHR31Yp23+7Wg85qbbDkXSNYHSqPGw+g9Kse6gHAiKNDn+9X7jJ476VV7fAaX3EH9cyLLIM3sGmrnvparR+xB6YYY4858msZ++6qsYKXXEcM9bjk9Jv80ZruPvLioyXqsZpxLRcga+NAnguKv7houdD5Vsh7C56j3zEPyth00Z3CaIRJeaoEYp4P14rwVBiIV7NO3JlmJcvyNppOK4d4rCr/KO+shAepQRob72FqzRPI6uXXBAVBWAChtr9q1N8v9u+ZY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E9XhgS+jpyAEs7nRlNC+hqRC7xlR/MUQQ3TQ3pu55o=;
 b=OS3lySmHmzjkSdqjbruj5SJGKb9bW2FGzR6tpf/mMvW+wmWkf92oKF0TSWogVyof403TpOADLs71xvqhs/sr7wtiNGdXRZ1tWw9nZh7fl1Kq23eiJaWWsPDtSzmN1qD/lmH2qq9vITi1NyeMP/7oEcKm68Qst7ioGpX7mHiWGnc6LTFB4IUhWXpnCtjnA0WZM2KlcMC+1/uZ0D36mzP6SbxjcsMrV5c3tCCDY9sYA6cZk0ewi5IOVwLpy4FABiGBYBzpPnOiEz7PunXfmxUFoNYaBZsfbH379yDUtaxFIAUi5ufAYKkngIdfqhHXUbHj8L7KsgBpYNIg9FuWoijMtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 14:51:53 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:51:53 +0000
Date: Thu, 11 Sep 2025 16:51:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <aMLiAVNliSxzbTWU@gpd4>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
 <20250910183555.GV3289052@noisy.programming.kicks-ass.net>
 <20250911095845.GC1386988@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911095845.GC1386988@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR0P278CA0057.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4ac9cd-878a-4775-5ffe-08ddf142bea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8sTf9KGqP5H3IsU/SMySrVUfMKcfPmXc9FNLOyTFvLTLPjJIkyp0NypiZ3y5?=
 =?us-ascii?Q?lpLh+sTsvDq1tz+cZr+xVmhigfhmLT33Apcix/9q10xLNBr65LqsRqiBBSFt?=
 =?us-ascii?Q?GyG+VRjLULtHP4oUecZ9u/4qGifRgvIWyYl7uGMn7NKCTrmlnhCWP7vx7Tpm?=
 =?us-ascii?Q?5/ra0/dzusjl+7ETmB/wpLNgIkxZInNqbrPYkNzMT2MAGvx3kQwOl100vfWN?=
 =?us-ascii?Q?dB1ss2G8c30JP3XqXIFYZ2vQAdWOjkiD7/t3Gy/eNsk00vJz1LV9F6719uVN?=
 =?us-ascii?Q?M8PNzmoSeQTAK8P/szRsgydaRbr1ozA2nk7LT79eFgWKF3zWOEEaW5ChYpEH?=
 =?us-ascii?Q?JtlVnCEDpSKJ4qTQ7j5Yqn85H3JiNC4HbdyvD+wtBWBCVixczaSkhRKCss7G?=
 =?us-ascii?Q?6wpT0RED/Ly1HE9ESP9AO2Hn0/NSK8Td8A+II6CViGwDDBSjFIS16Pzp6TQM?=
 =?us-ascii?Q?1Moxl1whIeiNu07tkx9frYWRw7Ffg0tUKZub8Bm2rtVBvQGPDa2QZhSavSeF?=
 =?us-ascii?Q?PYn+ckmx98MsCfkPwC0DKSFRFFoEEotDtfZWVc9+0TVHzIkRyDCmwBnuvATl?=
 =?us-ascii?Q?o5IaxY3VPNZM7wnpDcFAA9zcuu7bvmMFA6zWCP1hVHb6aY6kBsqaW0VbfLVI?=
 =?us-ascii?Q?LHzTrMvXPNEyvSoFR41pvoVXGjiu6FobXjN2HikpThbC5fMRYzF8e5d1DdOj?=
 =?us-ascii?Q?OKK2WCGIrNCj/VrK8Vnxn0LDBuYwWbi699+muHgNrJvk8Row7JJJXy02HDUu?=
 =?us-ascii?Q?RgiR9/JSHhQVJJJe6WKltbqtwzU0ZE0Zx269M+FEpvG15K7ddkz8psCSTZpt?=
 =?us-ascii?Q?8h70gy1toAbetBxSGZdrw1ktINB8zT/QXnHKKkHuvQkerpbXE4AO6hhsdNcm?=
 =?us-ascii?Q?a7TNHaWHQptvUtkGwZMkDUldDsEE117n3RB3HSkv6awC2lkFnpNEwosTT5sp?=
 =?us-ascii?Q?BVe/Mu0ujorRDjVXaIIeoFC4naiNJ8ffk5i2B74AacUAzCYFycwj6jhMKTSV?=
 =?us-ascii?Q?hWLA/aRZiWV5ZJGMAIU8t8hkrWxNbtgnDyO1S6B20lkZ0+RR0LV6ROgDRB99?=
 =?us-ascii?Q?aA1F7MyjM3EtJBfB6njNBPwxnCw9k/a0Mep85Ys9EhoipEsx88uRNHQ86GcY?=
 =?us-ascii?Q?k7J0eK9RTuuHoRcJRCtx7K7ACfyLnpFkp6IfC/h2egIhUwBPgiGNFKN6ePXD?=
 =?us-ascii?Q?NYLWhNcU7ClAz4MdXeM/r/TEVAmyZc+hT6dDxV3TIfoFcoMhG2J9jrm4ywoz?=
 =?us-ascii?Q?0O9UiVIrfnib46dRW6MBxYb8TNjmlgayOIRlkNPj6Ag/Z/lz1EerjYfz5PUR?=
 =?us-ascii?Q?7erCpZiUza1FQEAKhQrHGsxTfIUEVJS2qdNAOh/yPFG5IgXvtEN3digsJzzw?=
 =?us-ascii?Q?/T/QBVWcAt/zBbcmEEXdeeBnaPF758BBZkywuUa40lBJ2DYJVB6bhw7e+akf?=
 =?us-ascii?Q?Na4Uz4zWwZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AENSws0+w/wYhesp6CqBqDjFtQle2ePgAeestn4vuPoBQRkids8SzGBt/bSD?=
 =?us-ascii?Q?6Y1p/tnG1jyhmKZiH+fzFgjIdY7M25ukyiD2VfLsDnBa6ucp3mIsXECQ1IG9?=
 =?us-ascii?Q?Kk5R6DRI20/5bVWzeZz37vJ5Og4L2C8uiqeoAAqI/Y7diT0xzxQT4ygE+eKx?=
 =?us-ascii?Q?dA/eeKg+aTQhELKNTqNhXmfDcos0LGko1jaNVua6dGchW8fWpo8ighh853Qc?=
 =?us-ascii?Q?UkkmkkZnLyFJ7zFiQvMGKO3DQDcWRKmJr9ZZM67C8csbhJiXrQ+pqZ0yoGWA?=
 =?us-ascii?Q?32ZA9NKBIG8HCWmhf4di8pa6Qr6rN3Rh7ROa1vJUyU88rB3ANOQzGPEO/WrN?=
 =?us-ascii?Q?fXFd1IAUmZTyEpRHylT/SJmaQ033XuSOuShJMejSPP05/Y78vXmusZGoIcWx?=
 =?us-ascii?Q?7yPdCsZdDnV7IgfXb9gk0dQ9YOOpClan8mTYrWvPeb894jYvou0DAtlEL9Wp?=
 =?us-ascii?Q?oJF3Bt9Di9NkdBnxqmRfMX5o7c8ZgUtQQpcGeL6pV9hLM/U39ScetUgPODM5?=
 =?us-ascii?Q?kfI47Nl69tfeQeZ7IN7vJ7dxpUsStbAR6EQ+DiStkO13D0im2+Ej3lI13C60?=
 =?us-ascii?Q?STrfnCGEMdPjPFn9y9aeJMjkh5rYuTAvoOeM7xKG8cjpFN74l2+65dWh3qKg?=
 =?us-ascii?Q?wkwQluBLW8D7Fx4WSKe2bU6Fc4nsDtZbASklRwKr5SFlYG4c4wTqnOunbjup?=
 =?us-ascii?Q?tmQxjxbrTh7r89UoYSds/J5Ku6VhCgbR9YjD1LEZMBdRAplpwHeM5BY1OqRQ?=
 =?us-ascii?Q?6powxja0bvs/jXIAGJRbhtrxBkjJiQSnOaEVwCAbFqt5+RkYtxbuZV4p0OJa?=
 =?us-ascii?Q?vWokqSN22fUjG1CwuaPQbigB2KigvAgtpmKW2yNfPxJP4tYgQkEpVoQSJqKo?=
 =?us-ascii?Q?57pJgdwfc3tLJoHiDE4xEAZWi01eGq8uzZkmkFbYcuTUH6YM5TFtgDR2ccfF?=
 =?us-ascii?Q?kpj8wdSyezavRTHvC6eZwlBkpXjBZFMjwQfQOuyFV28j9osEfyi07k2zFo6M?=
 =?us-ascii?Q?8nB6RX9HqgID7TMbQbHYkcCUWkrxn5qhPG+5IkavVFPtPDLeGCFKOSP38JKP?=
 =?us-ascii?Q?rW1wei4Hi+8oxCDrfKIiZlFg9EzxoT1BrgV76q1dQHqCqvSxNkGlswE829Qb?=
 =?us-ascii?Q?co2bdJE2fc9aIX2iyMMWbYiCTS6LEHfuQWBr8XYd+5eRNyWO3hvwqfOrd6aE?=
 =?us-ascii?Q?y5VkqJeSgP3JJVdQ3XfGwy1AFtOpjL0S+cM5D9zdnLUw2kw7ud3cwdfdaomo?=
 =?us-ascii?Q?tUmp/ryoy3BG2kTsVE20lSnezWiH0LhsFi4JnPi+GYbM2moC9X39D0zxnC93?=
 =?us-ascii?Q?qhVqGx0mtiDYxBsPGgDdaR8A3/WcNx/sh7HBax9k+bPF3hzW3sDmRMDPCS42?=
 =?us-ascii?Q?LaRP5xiEq2Ri7Lq0ohr4023J3Gfnum1E3uCejLYoitTz9Zj4YaTxMMjM4chq?=
 =?us-ascii?Q?d53U+5esFR46I1G0kh6TbPfR8S2UO879Tu5ZCSk1gsjSoxo/XB4Lg42KcbWx?=
 =?us-ascii?Q?vgZGVLdpvwOaaXYxQio9wl1fVcKESuHd3/mXmyk/X9qwignXKav8HaF4OQ89?=
 =?us-ascii?Q?V5gAzudkPmy6y4sua5pqA+EQnG2Pt83oqOB5fczf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4ac9cd-878a-4775-5ffe-08ddf142bea3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:51:53.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHYUsJC8EHohZzCqdwV1aK8CASpkdIzfnUmkFuOQrg+FaWpL06+GKBnNt8wMPZkdD3ATbckLwJWJQ2dQCV7e0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

On Thu, Sep 11, 2025 at 11:58:45AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 10, 2025 at 08:35:55PM +0200, Peter Zijlstra wrote:
> 
> > I'll go untangle it, but probably something for tomorrow, I'm bound to
> > make a mess of it now :-)
> 
> Best I could come up with is something like this. I tried a few other
> approaches, but they all turned into a bigger mess.
> 
> Let me go try and run this.

With this one it's complaining about lockdep_assert_held(p->srq_lock):

[   19.055730] WARNING: CPU: 2 PID: 368 at kernel/sched/core.c:10840 sched_change_begin+0x2ac/0x3e0
...
[   19.056468] RIP: 0010:sched_change_begin+0x2ac/0x3e0
...
[   19.057217] RSP: 0018:ffffa9f7805bbde8 EFLAGS: 00010046
[   19.057359] RAX: 0000000000000000 RBX: ffff97ae04880000 RCX: 0000000000000001
[   19.057464] RDX: 0000000000000046 RSI: ffff97ae01715518 RDI: ffff97ae027f0b68
[   19.057568] RBP: 0000000000000082 R08: 0000000000000001 R09: 0000000000000001
[   19.057706] R10: 0000000000000001 R11: 0000000000000001 R12: ffff97ae3bdbcc80
[   19.057833] R13: ffff97ae93c48000 R14: ffff97ae3b717f20 R15: 0000000000000000
[   19.057973] FS:  00007f18999edb00(0000) GS:ffff97ae93c48000(0000) knlGS:0000000000000000
[   19.058112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.058223] CR2: 000055e1e6b0246c CR3: 0000000102ce8000 CR4: 0000000000750ef0
[   19.058460] PKRU: 55555554
[   19.058561] Call Trace:
[   19.058604]  <TASK>
[   19.058675]  __set_cpus_allowed_ptr_locked+0x17c/0x230
[   19.058769]  __set_cpus_allowed_ptr+0x64/0xa0
[   19.058853]  __sched_setaffinity+0x72/0x100
[   19.058920]  sched_setaffinity+0x261/0x2f0
[   19.058985]  __x64_sys_sched_setaffinity+0x50/0x80
[   19.059084]  do_syscall_64+0xbb/0x370
[   19.059158]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   19.059236] RIP: 0033:0x7f189a3bd25b

Thanks,
-Andrea

> 
> ---
>  kernel/sched/core.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2481,11 +2481,11 @@ static inline bool is_cpu_allowed(struct
>   * Returns (locked) new rq. Old rq's lock is released.
>   */
>  static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> -				   struct task_struct *p, int new_cpu)
> +				   struct task_struct *p, int new_cpu, int flags)
>  {
>  	lockdep_assert_rq_held(rq);
>  
> -	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
> +	deactivate_task(rq, p, flags | DEQUEUE_NOCLOCK);
>  	set_task_cpu(p, new_cpu);
>  	rq_unlock(rq, rf);
>  
> @@ -2493,7 +2493,7 @@ static struct rq *move_queued_task(struc
>  
>  	rq_lock(rq, rf);
>  	WARN_ON_ONCE(task_cpu(p) != new_cpu);
> -	activate_task(rq, p, 0);
> +	activate_task(rq, p, flags);
>  	wakeup_preempt(rq, p, 0);
>  
>  	return rq;
> @@ -2533,7 +2533,7 @@ static struct rq *__migrate_task(struct
>  	if (!is_cpu_allowed(p, dest_cpu))
>  		return rq;
>  
> -	rq = move_queued_task(rq, rf, p, dest_cpu);
> +	rq = move_queued_task(rq, rf, p, dest_cpu, 0);
>  
>  	return rq;
>  }
> @@ -3007,7 +3007,7 @@ static int affine_move_task(struct rq *r
>  
>  		if (!is_migration_disabled(p)) {
>  			if (task_on_rq_queued(p))
> -				rq = move_queued_task(rq, rf, p, dest_cpu);
> +				rq = move_queued_task(rq, rf, p, dest_cpu, DEQUEUE_LOCKED);
>  
>  			if (!pending->stop_pending) {
>  				p->migration_pending = NULL;

