Return-Path: <cgroups+bounces-9959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6427B51F05
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B565462EE2
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFB32F741;
	Wed, 10 Sep 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMQGIhCG"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578232ED44;
	Wed, 10 Sep 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525551; cv=fail; b=CemuiOwVHGNQxeyi9+loAVPw1OGbZ0FdhQdFslepb6aQCeCTSZ0JtgAyPAPJfHn9zSSAXx1R5AWFVZqAkbMnjRMTlZhWzPb5/xBBB+s2yV3EdLhfEQsNaud4QduHAlNFORh71t6IY6SWX//H804WJ69C9C0F/up9a0AtWLaACcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525551; c=relaxed/simple;
	bh=9SqaUiQsiWeVAg3S4tCP2eUuet+i4W4dVU9/GqymHqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8JBzC8nPEoKeUTni5LHLY67cyLwZhG+7vncSpfHuVQ4ImWq/9WUMtMYbXj1fXi6YxgPKFAvYMKp5jRYT3jm6EALK5KQYEZ6V16wmDYmmMvKg8MQL5qLCQVh5KNe0MrLCUtRsQ3wByUwA9EfR3/Qd2JmAOAlfIQx70cS5Yb7cz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMQGIhCG; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC8A+yPruI+ZeLXyzg4cq/qXhIgb822oKlQ5JS8ylAfsJbCDK8t/zRzEQdOqMLYg2rwWMkw+4QJODvp6qbwXzdloRniW1z2+TuC+lXpHjTOCDzZDDgVEKBK0F17slx3I8+0x0JHdZL7CbTa+VjlhK+VdGKCz4UtFwjAsG4vpqTrasRG9gZOFXF2kgwkQ7T0dHT2bjdTBTVhyFEnHPs0dLf0iXvyjwMMxvDC/TutpzxZk6G4Cpxo1koD3U9jBiTwYFdV2yYAFcprVHy2s/mx+vBpCddLZFc8L61mm575yI7cKiZ+nFu5ZA+flRsovc87DgiZxeMHZnU1Olw9seMQfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RjPaec7o2Nv16e9Dj6U5w6RvbYd/Jlcsl2JUO9LM4c=;
 b=qp+9EYqc1SKIX4gnyxkCYVcNSJun/uLZIswr6jGtLemvOF/Gj1flubRe4BKCMTbjl4A23Jt1jHSwSwRCkg5ftvczOKYHG3567bBWuTSOGumiMZDWgkMHIPF7mlDJgeoNpRqDibhTRZJwTdsTCQGLDiWx41c3H5HQPBkhHOPDDyO2ZEK4S9Zkg9XrboNbUGUbH1qAYP0YEgsSHpyV7s2UyeDuzVKEvTEQYnBiAhm+uow2V3/b6RIvjWO5OxYsDWv0PNeaxvHoEokx3mvx7j/HJC7r5kfFBZ2YAXumpZBCDfyFRFIIR3gcIkdoVtr86mrTJ/sdrmZi67neFUjQex0oHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RjPaec7o2Nv16e9Dj6U5w6RvbYd/Jlcsl2JUO9LM4c=;
 b=DMQGIhCGetsBJZT999VrF1KgEjx+0iHmalSuJxnEDQGOr/kKsB/e/nffwS9KrfM8qfs9UAjNhHF3WVSeP1plZ7ikJxLuOtz4840RINDZQh3qVwT0be2ymnHOyIHyY1+S/gvHE0T8ojrng99sqrNOPqyuQwBQO8wU1YpkUc3ncOD+uEKNmtgBf2ChrizfAHueXbl3oNTFPZ4JGJa4zZK81M9QSdqypBgBfcbD3Jk1RRxb6R5q36z/yFpUWbQyH8G7zewNdp61fP79w0UEExQu7+h82KU8OsKvATmyGNEZ9NOnhN97KI0r4yEdiK159dams8sYFPNxrxf56CgDO0VmbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 17:32:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 17:32:25 +0000
Date: Wed, 10 Sep 2025 19:32:12 +0200
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
Message-ID: <aMG2HAWhgAYBdh6Q@gpd4>
References: <20250910154409.446470175@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910154409.446470175@infradead.org>
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 91603434-8e84-4b4a-6c91-08ddf0900138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrGAcNlgU/AqLn34D6Lax1gD5JZi1yu3rborSBvUnyVfdIXeOxaunsIIeJkU?=
 =?us-ascii?Q?xY5bVhNpBGYNJh/K4r/LYcSPJv0lWXLdEtMvguFnXaoJFjJpmbKK3t5uvQ43?=
 =?us-ascii?Q?nHGhoJFv6Chu5hmsWmfBPn2MB+KnTHQBHwiMPDOUEMYYOBKJrkR5DUFcrkpJ?=
 =?us-ascii?Q?tVphwPNdlyXOdt8xaBIfvGipdtP4PeGvDhok7QDf3+254AkQu/Mbw4HNuLXN?=
 =?us-ascii?Q?83slMsZmWOTY+HJpqaUaFSZbJufqNE35oonN5KHrx1vf609ynrSzSMV9F/ll?=
 =?us-ascii?Q?syTtLT+PsuqBA83wm8AkpHwHP4Ha1y67cjhqKVqYL4ErV7JQhlTevFwdMIpD?=
 =?us-ascii?Q?6ga7Bh836FsXaAir6z+YO5D2sGGUXRfBqUZSGAj6WB2Q/a7QVe4NqAe3NvuD?=
 =?us-ascii?Q?OUbF/xarg2FWxEKkFd2zdvuzzCI9xpEzp2K6VeGd2FxHN1Vp2gKN79sZsogI?=
 =?us-ascii?Q?4+GAZU2lvOOV/nhpygfopQRFI+YvWQZHAQ9NS3U4Vdkj97FyObbp8FrUnlRk?=
 =?us-ascii?Q?U/3tPxhZ5JP7yMyTJlVWpB84lNuN1llMd3Z+K1QSdGhAS1+d6JtMrVdFEsZS?=
 =?us-ascii?Q?aEYBgqOhVc4/N4Mrvl7IN6tnXAoUOIo29XzKB0TuQmdUrLYxhKgynN27UiWy?=
 =?us-ascii?Q?oKnBcRMlThqz1SgaDVHg8SQxix7NCjtqiyX73Km3b4n0kXIrZpfTzjxsQMIu?=
 =?us-ascii?Q?2HeEMmm6EaqnzrhiH3E7IUtOdjs3lHdBTkgOc46XUMSHkFd2t0Zyfu5AGgL/?=
 =?us-ascii?Q?QyVKouEQQb28pD63I7hlAjv6XMtCYcYxlZeriocUZn+yHoDtPB5oSkZCb5/2?=
 =?us-ascii?Q?UwritPqCDyjBaq4+Al6rqfhNz4r358Tv4sVR7YrpFBmCliAotOkVq9mY9YUg?=
 =?us-ascii?Q?Sg7oT7KnMkCMq9xGfQTioa2beKVY51gsx4Jj8mBQQhLZfmsJHFiZuUXV/uJa?=
 =?us-ascii?Q?gUZ61ZwcwDQjGHDQRAYUAYA0HTPwEgjiMQAck/348ok0BjIf729XYyhQvvnG?=
 =?us-ascii?Q?+FA2sUy/EJsB6xFmRCYSFEgbsDQxi+jOu0IIj/bLITkx+h03gmuw+r9SjTno?=
 =?us-ascii?Q?m1co+ihLbmqE6zHpaghVu6CYCntu4Hkqm5WatgLF12X9/omN3enkKWbqWyqP?=
 =?us-ascii?Q?f6h/kUf8pBFDzAGdH6NeKHkAskE43ACaoZ3OStGlHCYzCRvitwMt1MKvwTDj?=
 =?us-ascii?Q?bq64gJ4+NzGOuT74oYfklIDOYLyy8a7UBA07Hzijq/eyEoxJAeDRCXtyfDQ3?=
 =?us-ascii?Q?tYEDnZ5E1XzqmOb8H6YNyPSX+jsQW+lbTiAMkWys0dlLERsf93e6JfxhXMrh?=
 =?us-ascii?Q?q3K7qPOn/T3nhBqG9mW1q3LEthma1eywteQ+ZSE9oVhoEi7SGReefKtIO/6W?=
 =?us-ascii?Q?9FQxaRMA1CmiV624kXI42wFmCduI56clzFySZ01qg36AFjOSWVa4xbIUkkb2?=
 =?us-ascii?Q?rPgwdDUKJeg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Web3D72i/IY2vSMUSuRFnO6f16MVCNvAo007AF9ketIsG95W/KTWNgHT+qP8?=
 =?us-ascii?Q?DRG88W5zatw3542NRnXNJL8V2HuRgc0Kz8OC6CvjH1rlvH5UEvhA7gfOYbD5?=
 =?us-ascii?Q?VEmAePwGJodniUuSsuoTdBUw1CM14DepVFCuNV0JOkNGUKk76vQ37G0QnHXT?=
 =?us-ascii?Q?yHKJUVXx5kYPAob2dZK/mh3SpMyfl1jUoxN0ctSU+VTF2k7arjGKq4ObwwGo?=
 =?us-ascii?Q?s6gkRrWmckJXveC9v2cz9XH/0su397B5plAoy+a9L3ekN7QHf+WmR2WRY/1C?=
 =?us-ascii?Q?n5tNHmxOW6JV3dBX24gGdJNN7cg8eYahciEMk2IpbYMD6W8wXZGJz9tcYYNB?=
 =?us-ascii?Q?tgD4JTv8FJFn/rbMgmtPVfEaxM6Td+83dwbmpHWc0GWTO20dpz+GIgygkI1b?=
 =?us-ascii?Q?vVlofXVOqd+iKcbsEblDs74THZ2WHtA5JT/y4YokWBNs1wKUsugByFTjpViu?=
 =?us-ascii?Q?KU9ts5wt4hI600AphYiu98pcCizG08+ZAKEbDg0T5nXiz42zi+t1P/vqRRos?=
 =?us-ascii?Q?n+P8HieiAaDOTMbBQ74dRq2uWuW0kUmA6OZMAxw3YkC9xQwkAAsu8rdc2y4t?=
 =?us-ascii?Q?r8497vQJW/NrPUPV7PMrtQo9cawXx40ig/DLHhHb12r2CAx47UhyNU0fHfZR?=
 =?us-ascii?Q?aSlslhf2dIHCQDZOQWCCTTaynqFi9CdgUQCo41fyPD/lh4cw/DTNpD64OIG6?=
 =?us-ascii?Q?GccVrlVbxU2Y5P4OkENMotntAVbbaF3Y7DwgXeTx07HEiVLqWo4IUNPdl4I/?=
 =?us-ascii?Q?MBm4KOJueFp/oTe39t3qMYMXefByt0/bTjrpbCjlprT6E/OujCU03ULPTjC9?=
 =?us-ascii?Q?872kZEtnIHgJYYWK7ktYGRG4p4Y0PkFwHkbWn9PSLd9f7PDkjB3YEENNwMB/?=
 =?us-ascii?Q?oSqt9hFp4jc1RGlolKeRZDk5Y7hyCLyAeUqRkbjSptZDuVxgjwAPH63Y0DcJ?=
 =?us-ascii?Q?kCVZmgNK5WoYYTshnAmrKyb0NYkzj/zJlBBNFj6m4XV3t03pgzpbQ8ceB17i?=
 =?us-ascii?Q?k5RCx0Lq8fqJzVIVwtkfoTsZlkE0nlWEH4fzAWrEvrHgR7oBQwHtGraVTu5e?=
 =?us-ascii?Q?/vYI4TUt5SHAYHUONFGSK0xaPi4kYZTplGInPa4d6oHmLd0njsLAQZDfXVtt?=
 =?us-ascii?Q?IGfjgZ4Fi1GIFG0W7/jNMm9Hy/rKKpaWLMv5AgSrkHOyx8CqW75U/oV0wO3N?=
 =?us-ascii?Q?0o67osgWNw65BzNuj6t/6UcYD0Up3k+eNLQoXDuMINgBkzGeP5VE2QajQlhn?=
 =?us-ascii?Q?pukzXb6NTxrAcyF9DNHqEowigAt8i4Pu1bhNF+SZtc4A9LucVU9nVENk43hQ?=
 =?us-ascii?Q?+uI0/AToPS7BSNpIZd4sUq2wAZ8yORZktT8EmYOAS7J9s59DzLHEkIKpXt0H?=
 =?us-ascii?Q?pwjHKHzob2auqnjetH9nEXNjTsc7gvldL30XcM2oGlSyXSScCB3E0dQLKHMP?=
 =?us-ascii?Q?HKES1h9aZFUCuBlR8HBJMETbv4VNJbiQNOk77Z4orIdeRh35kyXlaushfQS1?=
 =?us-ascii?Q?N9Ka6w995QYBvO17tTkWjLUT+p5atuVAL11rM9d62t7+2JIBQY4+qCS7pvdS?=
 =?us-ascii?Q?tDeHt27X6uSvnOFKngSIcbxLlCrXYqMl6PKy6LLk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91603434-8e84-4b4a-6c91-08ddf0900138
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 17:32:24.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0+5wwQqhh/zI+NPPONp47JnJGvOC8tX0jRrZRzHhtKgJKa91NgqaO+Tbn6G57sqWVUWXyi1Yjm+nUjBl28jtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

Hi Peter,

thanks for jumping on this. Comment below.

On Wed, Sep 10, 2025 at 05:44:09PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> As mentioned [1], a fair amount of sched ext weirdness (current and proposed)
> is down to the core code not quite working right for shared runqueue stuff.
> 
> Instead of endlessly hacking around that, bite the bullet and fix it all up.
> 
> With these patches, it should be possible to clean up pick_task_scx() to not
> rely on balance_scx(). Additionally it should be possible to fix that RT issue,
> and the dl_server issue without further propagating lock breaks.
> 
> As is, these patches boot and run/pass selftests/sched_ext with lockdep on.
> 
> I meant to do more sched_ext cleanups, but since this has all already taken
> longer than I would've liked (real life interrupted :/), I figured I should
> post this as is and let TJ/Andrea poke at it.
> 
> Patches are also available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
> 
> 
> [1] https://lkml.kernel.org/r/20250904202858.GN4068168@noisy.programming.kicks-ass.net

I've done a quick test with this patch set applied and I was able to
trigger this:

[   49.746281] ============================================
[   49.746457] WARNING: possible recursive locking detected
[   49.746559] 6.17.0-rc4-virtme #85 Not tainted
[   49.746666] --------------------------------------------
[   49.746763] stress-ng-race-/5818 is trying to acquire lock:
[   49.746856] ffff890e0adacc18 (&dsq->lock){-.-.}-{2:2}, at: dispatch_dequeue+0x125/0x1f0
[   49.747052]
[   49.747052] but task is already holding lock:
[   49.747234] ffff890e0adacc18 (&dsq->lock){-.-.}-{2:2}, at: task_rq_lock+0x6c/0x170
[   49.747416]
[   49.747416] other info that might help us debug this:
[   49.747557]  Possible unsafe locking scenario:
[   49.747557]
[   49.747689]        CPU0
[   49.747740]        ----
[   49.747793]   lock(&dsq->lock);
[   49.747867]   lock(&dsq->lock);
[   49.747950]
[   49.747950]  *** DEADLOCK ***
[   49.747950]
[   49.748086]  May be due to missing lock nesting notation
[   49.748086]
[   49.748197] 3 locks held by stress-ng-race-/5818:
[   49.748335]  #0: ffff890e0f0fce70 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock+0x38/0x170
[   49.748474]  #1: ffff890e3b6bcc98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x20/0xa0
[   49.748652]  #2: ffff890e0adacc18 (&dsq->lock){-.-.}-{2:2}, at: task_rq_lock+0x6c/0x170

Reproducer:

 $ cd tools/sched_ext
 $ make scx_simple
 $ sudo ./build/bin/scx_simple
 ... and in another shell
 $ stress-ng --race-sched 0

I added an explicit BUG_ON() to see where the double locking is happening:

[   15.160400] Call Trace:
[   15.160706]  dequeue_task_scx+0x14a/0x270
[   15.160857]  move_queued_task+0x7d/0x2d0
[   15.160952]  affine_move_task+0x6ca/0x700
[   15.161210]  __set_cpus_allowed_ptr+0x64/0xa0
[   15.161348]  __sched_setaffinity+0x72/0x100
[   15.161459]  sched_setaffinity+0x261/0x2f0
[   15.161569]  __x64_sys_sched_setaffinity+0x50/0x80
[   15.161705]  do_syscall_64+0xbb/0x370
[   15.161816]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Are we missing a DEQUEUE_LOCKED in the sched_setaffinity() path?

Thanks,
-Andrea

