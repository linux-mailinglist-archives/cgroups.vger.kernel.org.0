Return-Path: <cgroups+bounces-10596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85DFBC3877
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 08:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE43C67CE
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 06:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC042DC783;
	Wed,  8 Oct 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qbd6nFuJ"
X-Original-To: cgroups@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720612ED163;
	Wed,  8 Oct 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906705; cv=fail; b=DSNFKXCT/fJjkgNVMUoBLnVsZJCOQ3GRpliTyz8UnQyTQS+0snwViSeZD+m1UXPo0bHf6zBfo893Y2QSwAwmBnSCYHmKNwBNffZ+rVwTQeQZ7xAnIzfFBTjrGUMuqFXh7SSzl7RHMv37Za3wvpYMyNIB+Xei74IRUHCfttt5mAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906705; c=relaxed/simple;
	bh=vFgvBtwpkUdpLmFiju+L5rIZPqoQr4M8WCQ2AQbxp/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DQxM2ZNKwGZQ7L/9TwCkII/E3D6bKkO61IN5rk1Q3InKG+2W4peTBt8PxSQ/xqT/mUv5XVSU0egtQVd5E3IHhy1Q5aZj8W1YdGtZVUskAAVV8I7zcZH2Oqo11kkKC6yOOsEjwngQBrc8npowhvGXbiQlG6j9A8tFgPXb8Jq0if8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qbd6nFuJ; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV9dyFd1reWi/dJu00KdwvoqWmeLIS9LaZKnFipyKpD1ycZg95FTV2S0jOEu1z1Sg7nBlSeIxqS9VJtx+AtSgSnVaPhhaqF3l3JrS3ejqQSixqq7UI3RhiELnKvmWEA58SyV5Q8JNj8xZFzcg6CRwa7cTvsB8foB36XAHEtERzA2/XRxGnIeZchJ/Fo9SqIIMNR0enMPwj3+HEMKEk7xqOrrIzbEFhPOpLml3cpi9EI4ptaYutj8dDD+Mf51JgFmMe8fjS/LHUXjH+rr9j3BoIREBmWAduLx+tcz8ntlHmwMKsIhZqy3FnuR9S4OpGI/KFm2ESrr0FzK6QSRZu5Enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyFG1oGlVSIvqyzrTWTxBzUKfa80YV3GIEwbtkBnmXM=;
 b=Sn4c0OekElKuDveBty1oiIDuQkNKVtbIDLzgje0hIDVlkd56/QlxG8iQOT3wlBEnWYazLQJSWPWRIqI19uLABUFcUCe7kyKpe4KSdnqcD/bpGeIrX9eJUnpHLCu371wWJWoiFYcSfilLKMP9lmhe6Vfn8ZYe1S2c0UOxrz07n3T534wdQ0O4spdrCPjV5teoHjf5oZDd1rnZbu8hJeC4mBkj9YPei7cqkv8Wp9Oz6RO5ODvV/ctPhmqBp8pIVwDg7qvN7qsC38T57YvQg7Zoo1Y1u0xqkZBfxnCnrwykcdaJnWd+ebqwTdLKZM2zvO3mxaiczzig8pO9v86NcDzupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyFG1oGlVSIvqyzrTWTxBzUKfa80YV3GIEwbtkBnmXM=;
 b=Qbd6nFuJc9ltn9QLXbguwMk4KRHhqyWP338vlMm11im+JKHrewnUCGWM9NH7iLJWWM+a+/jtthCtihnv1jWGgjwPWD7hezsbCKupWjQA5kek7znCPLhLYnB0xDtL+fqHWrfbMCIkYJNaWRpPs/AJowMBbMiOjO8lNfETNRgHhh6tusJIu0p4RUolGz4CYKjHkfQQRGegdtGqcQJuQobZIF9NUiE7FEh9Pab4pJbxeWI3Ai6C2GGeHxwM2pDP4jm6t7hROPtAvT922vOREnUtvrALFNxffb8/1vlpDopyg55s5GWW+w/iEDeRFTGE+RDgfUD8hE22aZSYWxMCYXVZwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 06:58:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 06:58:13 +0000
Date: Wed, 8 Oct 2025 08:58:05 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
Message-ID: <aOYLfSfePpgL4gMQ@gpd4>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
 <aOTNXPTyk4zth-1C@gpd4>
 <20251008065103.GQ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008065103.GQ4067720@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MR1P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f5da38-b47f-4852-3a5c-08de06380c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lhe1gMaXSZsb7Vl/MNrgJkXSOFzsTi3ViIKxHpXX6yFKNkOmROk7n4A2Nu5d?=
 =?us-ascii?Q?xVx12TKBG/7bVHaxAIiAo+oUmfDWZ7/5+RCVXTCGhhOqpCwfII9phfjLSZ6S?=
 =?us-ascii?Q?CF4vjipN1xT7v3giAtxk9cJInE3Cni4h58RI/bUkjP20YgYGAo1gE/KddIwm?=
 =?us-ascii?Q?VRGhMLgcBEJPdCeoV9pPI+pYvRUMWf8InfJSSBGnxQ23bAq+FiBu7fMsSzgR?=
 =?us-ascii?Q?k2I/6nG02j+GaHBOJHxpGLWXa0IvomgSLSRTDKtRHilAybn1/ll5gztgd3al?=
 =?us-ascii?Q?M58en0Q0X0l7qmVtN+quTx5dP/E3Uyka+l2Vl2CgPi1jnMZSzDQrxRe6qqKp?=
 =?us-ascii?Q?jke2c84opItp+6Yc77I2k/AAU4EOYOmNWqx16GWaEKwYNV+gLLOcO8yNQ4Mc?=
 =?us-ascii?Q?yM8ELkEopizpv63naMlLEh8kjtJ00Y9yr9RToHMH4n3L24rFKrXjAKFk3yfB?=
 =?us-ascii?Q?mHVwdX8+ZA/Q4CpW9viqbyd1p8wCyvZ0N3T8fdHvkuSgADe8WkIDGK3/XKNm?=
 =?us-ascii?Q?jcA4u9KoYtCRFGk3SSS/81v/lsqWdVT9PtUoRP7+lGzoSJIYE9UroXEz6QI4?=
 =?us-ascii?Q?GtKDsEsqeYz4+/1TnGFTBEwxS06jvxXh1ILPWBcMxmS8Ca3E4pTndV2uhzoO?=
 =?us-ascii?Q?5OsEskHJEzP6pmSatPDCPoFfx3gJfppXnyCpsDm3fCWzuAQVcqu7QL0/JWDo?=
 =?us-ascii?Q?Y8fRibrbtYjutqc6yApHverIPNYG7RUSPuCI5YVXUB5vlHeMLqS942bQQN4n?=
 =?us-ascii?Q?xQrax8gIs6FKqfqTm8ckweN6ic7QX0WjA7lV5L0juZGF7zLzexk6jD0HMY6Y?=
 =?us-ascii?Q?6Xo+dFmJ925NIsatFYbFx36HKHqszt3H2DhJv1YRXwCit4fFc42XjejjHotT?=
 =?us-ascii?Q?5s7ZPQPYXxmIQ2QSth1NzCNRHAhwMd6pAIu/8PT/BIbQHRGmaylYz+vobcg+?=
 =?us-ascii?Q?PA8mhL4ZulHGKx1jQ3U3yuft5wUBI+ZJH60J8WrAx5hDvtzrGDQ504AZYT5y?=
 =?us-ascii?Q?FOZ51FczPPge1ewGjJH0ILcfzKv5S2zMqzLHUu2tnsO+M1sKw022wW5GJWRx?=
 =?us-ascii?Q?p0lNlDBJd1mHPKRPKEQ/WGkhBIDY8uNLk2CpoRPAonvHdc91gX+kmo2iJP3x?=
 =?us-ascii?Q?WR2itJWPCBxQgl4OURfZT52ylX4ON3DeY6TV78TvYiTVFnaB07uOCHlnJTLj?=
 =?us-ascii?Q?ouERtMlPz6MA8l5bUeBdacUR3sUJlJPnBbuNvw8QqfGK+QNSwtuAs21no9aN?=
 =?us-ascii?Q?KnLNQh4fDZOE21CCuS3+Sq60bDmc/U8v55ZBsVxfObQ1glDLPLqObro/45y1?=
 =?us-ascii?Q?9bAbJ9kSBCwIqQGwnPSMgPpMCA5dh6VeBO7C1LmvjJZdWEZzq+cQNssdYdvP?=
 =?us-ascii?Q?Scgi4RkjCYjvtQEP/IFUnpvfN27HQflHU629VkytMg1x08pcsg2DKwWjJyYE?=
 =?us-ascii?Q?31wM7x+vqgwVPzG5Ch3ow9ptXupKOcxO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QT7ikVfjaZN1UBTSJZ7dASG4UJk5VChr54kakUTSrJ1ZBEUjTzY947MJG9+k?=
 =?us-ascii?Q?H0vS4i+Acd5lCLbm/wOsSnK4Z0hz0qpGKprbb3Iaqz01z8FWMSvyTaEwbJKH?=
 =?us-ascii?Q?8LmkpmxO/JGWeHjFTeCAHcPfxBK3xVPg46Ff/QKeGc5kdBVLe0bmBJCDb24c?=
 =?us-ascii?Q?Ca+dvnSQTVIpwvJJxilj/nNd0RquIQaBEE17xHjhCXnJdE6aXLRFb8XVHdAG?=
 =?us-ascii?Q?auqu/hOTb490NP4ajVa9//A12mLVg7rAXCMZTLWf3NhqoAdvPR1uNFpsJ9BS?=
 =?us-ascii?Q?aLU0ACsnrmO5lE1NOChqner1yAU7howgNinyK6v4WjT4JwXB7kec99wwkeVA?=
 =?us-ascii?Q?ovSx2L/kOOqLkkAA3lUA3Z0KSONlrrab6h9aLmzAo4baGDu4VeqY2+DBPO4x?=
 =?us-ascii?Q?HjdNNNpWP5Phl3tbwN5Ej9sKJlWOOwIhkzWVk+wde9Zox48yb6YPqBTAXyhV?=
 =?us-ascii?Q?pidAty2wLguLfaGKULEgGaREiLGvYWHfvMRZCTPGUmjEUckpw6lynx3FYYtx?=
 =?us-ascii?Q?imF8tGCoQcga4AhvdUUy+vvsPQT2BCQGjpJ0ZzKyLNgL5tpJUWxM1YLpszH6?=
 =?us-ascii?Q?SInir89nJ/hGnjQZfLBjEa0Sq1zZyzm4xD01w05BbEOaw6nkG6fslyov92Sb?=
 =?us-ascii?Q?6xqHS3vmE0IoDFZSTQELg2RA0hvUo0TSISsm1j/5F0N/n2fElTtXtiv9eVlK?=
 =?us-ascii?Q?PW6+RNUjS8n2XkcAkGV3RlfhJ0+4WrP4iMSqsUaSohh7TZvAiq8K0kbkY4GK?=
 =?us-ascii?Q?rMv7l482niO1NvmsOXSiPV/PhuYk21969Mhuo1qf82RG9B+gQ58OGCMj4KL6?=
 =?us-ascii?Q?8v417yLz/Zj80NsgO8LDlnb0fkyUQzdLnFZsRjX+pABfBn06RJORHtVvbwDy?=
 =?us-ascii?Q?VWmpoRwFNM2amlWyAOtSMFr5ZX2r1aVFcYUZZRSkPJ0pvSY2Z2I1CYpU+fLU?=
 =?us-ascii?Q?erR/GwalHRDMnUub3yy1BLiZNjjO2pTiGFaPDmeFpbxLmSB3xBRIwzuMzLwB?=
 =?us-ascii?Q?sGNeFNBW/3MHm0zsgwSsIvMZH9G5Vsyl/im00hDDcmFsalfL7/25hXtIPdAS?=
 =?us-ascii?Q?U4DPeuaVGXQ4lUDTvA/Mv+k8FOQXQ5HuOCfvTMmKppG2W8mwU0vytTA8Gu8D?=
 =?us-ascii?Q?M3YjSlJJiwwI3xWpXBkcuiDjCq1uGZS3yRgezOtHZRJUNPStVB9ziQbP+QnP?=
 =?us-ascii?Q?vkVSzpfDOHb+xd/J/tSHzDze3M6Ohp5iOpvnVrZ9WQaViBiBfZcgvXU0Z+8M?=
 =?us-ascii?Q?TfR/kQfDrxMeNm/qlcWCj80Xtge7TkF1UZM/EBIR12CEJ7ZMpGlTjmTzd5Fp?=
 =?us-ascii?Q?cDrzL9tNumfiGt8zKhAaoHHreqwEAQBdmjOKum6Y2l1bZ+SNgEQDlopDdFkq?=
 =?us-ascii?Q?D/iLluXlkRVBr/XOolFNj/nxU0NAkRMAXlnd/LSweuc+WqWT/PX9WiwFlWqM?=
 =?us-ascii?Q?hF+oDc3bQrSWoyzmqpFRSVWFyG4zdZC/cPDQlqCftcsT1DEcuiQHZBXmW956?=
 =?us-ascii?Q?2AGxRhNXE9/0Q3hed2QK+xhuN8nYvaBzP7sjo/CmKu1nfBVk3SUI7rGiU7Mc?=
 =?us-ascii?Q?VRNs27FrI37BXKWzOeBm20TzQy7PQm44rkFYLPkS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f5da38-b47f-4852-3a5c-08de06380c6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 06:58:13.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwRIqB0a9sTeC3KygGqH7o7gcrgf/t9kasUXPyiCcRIF5RAHi6dZyMjnJkhq63BHUqLrMF2KkmAd33ckOmCLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526

Hi Peter,

On Wed, Oct 08, 2025 at 08:51:03AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 07, 2025 at 10:20:44AM +0200, Andrea Righi wrote:
> > Hi Peter,
> > 
> > On Mon, Oct 06, 2025 at 12:44:03PM +0200, Peter Zijlstra wrote:
> > > As proposed a long while ago -- and half done by scx -- wrap the
> > > scheduler's 'change' pattern in a guard helper.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > > ---
> > ...
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -3885,23 +3885,22 @@ extern void check_class_changed(struct r
> > >  extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
> > >  extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
> > >  
> > > -#ifdef CONFIG_SCHED_CLASS_EXT
> > > -/*
> > > - * Used by SCX in the enable/disable paths to move tasks between sched_classes
> > > - * and establish invariants.
> > > - */
> > > -struct sched_enq_and_set_ctx {
> > 
> > Not necessarily for this patch, we can add it later, but I kinda liked the
> > comment that briefly explained how the context is used. Maybe having
> > something along these lines could be helpful?
> 
> I have changed it thus:
> 
> 
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3885,6 +3885,22 @@ extern void check_class_changed(struct r
>  extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
>  extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
>  
> +/*
> + * The 'sched_change' pattern is the safe, easy and slow way of changing a
> + * task's scheduling properties. It dequeues a task, such that the scheduler
> + * is fully unaware of it; at which point its properties can be modified;
> + * after which it is enqueued again.
> + *
> + * Typically this must be called while holding task_rq_lock, since most/all
> + * properties are serialized under those locks. There is currently one
> + * exception to this rule in sched/ext which only holds rq->lock.
> + */
> +
> +/*
> + * This structure is a temporary, used to preserve/convey the queueing state
> + * of the task between sched_change_begin() and sched_change_end(). Ensuring
> + * the task's queueing state is idempotent across the operation.
> + */

Looks great and very clear, thanks!

-Andrea

