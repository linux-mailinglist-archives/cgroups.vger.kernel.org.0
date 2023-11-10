Return-Path: <cgroups+bounces-328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2237E8508
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 22:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D964EB20C57
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7513C690;
	Fri, 10 Nov 2023 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="lugXL4St"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020B3C681;
	Fri, 10 Nov 2023 21:24:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383574229;
	Fri, 10 Nov 2023 13:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4MGbz+yWBn3wpR5BQqewG7sZGvIFjZNL8a9ScRyrxYcoH1RdqRmhRo8OfrIC8/qAynRFt0dfizuNGANyGwLBq7zQ627gFUJPbS+oWzT4XTqDY+ddMif4gq4R1ha4Vp64fGo1myHVyw9jDauPRJ00y8lq+ZRHxHixn1yDNg/S42rueHNrZ7poRoYqIxNAysVEj3YKdyhhfkhelCrM/eNwQd4Kt9pOz921Ngl8TSirQbL8VgvF1Eu+tcL4pWWPZ3+uLmc+6cn31rAR9F+IVUfTOCq8Sk8hKWO7K23idgVaCXGxXeTjAaq6j4QacGA+SXCaHAmARarXgCdcQecUrunWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf3wfIZu9HrWNhlf17i64kr9XqF+UKOg061jJ9kuGYw=;
 b=YBFE+Ly0337230A8uWiH6qq98ERdtEwvpLkQNSlMLgs0uwLlTRQ6oPeHnPDynyxjag3tHWD3xwjaajyO+gONGO+bwCEfOohgOowebCMYunJHJYcF8xxhai/aJMBHCMOV53g/xDqbW9wil8s8UiXOzRBJrSALbmcBzZPTsIAgRmPAQbSVz+ZDlkEJpZtdFVgNsGXqkkTGfmoXn3FefeHlTVhbljDS6nNZTHeZkPWFai8X5MrgHdNN7E4Es2RQUdBZsj4x6dkLv54/qpT3+MmM6B9W9BhOP1DWnvhuY9V+Yg5HO+a5zJWHtT2cWwZj5Z2SWWtaZSeVMs6Iro9qrVMOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf3wfIZu9HrWNhlf17i64kr9XqF+UKOg061jJ9kuGYw=;
 b=lugXL4St6cALlvoPZ2Cz3L0h2cKTNA1kLWc+7uapp3bj+IQ43vZF/tSc4M0CC46xepmioanvLQhIjQ+wOCqkJ19VOfchbOpuFgbUYNFLW/FVdWx85w/CNIBT00YFrKxNvyhwi/+ZVPYEzbOOLbYAyhz4QxSs5cGTaHuMI/4Vdc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4490.namprd17.prod.outlook.com (2603:10b6:806:e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Fri, 10 Nov
 2023 21:24:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.010; Fri, 10 Nov 2023
 21:24:43 +0000
Date: Fri, 10 Nov 2023 16:24:34 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	ying.huang@intel.com, akpm@linux-foundation.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU6fkqsk6xiDzsnM@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <ZUyuL9_8PPiEflnS@tiehlicka>
 <ZU0J+RU1fg8peGJH@memverge.com>
 <ZU3ydS1Puv2OHgiE@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU3ydS1Puv2OHgiE@tiehlicka>
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: f478c0c5-56b1-4986-d61e-08dbe233742e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CUaaa/2maLfBUVylino0wa5WzV6XQGtmyqZFBtXJcZixsxS/rD2Ae2vWIHuqjX0g8UUoBYUQUBV3j+nPWj8vY2ok7SeVBiwZler8lzC6A9awaHazkJsI/89JHUqn5neWun/yKPi03LzPyItwnoYkN98vl1jrN5+0Yvu537LyK691KM5Xvqd9oGscZuLA4aghJcjl5Ot3V1DKYl542+cIQfnmXkzXyWh1s96hLO3X3My75IBL02jzplVMk1jMA1V1QFlgY2o5uhI+5ktzkceR7M59pJc5mXy4Zp4AxPurG7TpCBrU30WHQmNWq3floVRLxICOG8ZjOdMthTaVgNC0XuebhXX3KS7igLQmE5GEebKoq6e2ggSWtqRmMeQ4XLdKZAmn6HhBJaaEQ2Magc7MBxuBzCBdJmViQOb+3ufyt+NfDTb25gzN/mILBLUOYY1lG/EgQartYE42vQaWFOPG6W0l3wxAvdC1DWDkJ1m62jUP9s8E3MFOSv2MmScDoimG/HszvhKjG8trvAOVIVRKoJQ9CjKDXJhL75TxdrxB/HRz0ihODplY/8DcTzJGJTZd742GKOtboVJLUXJ/EEiXqj535e3oCcYmEhCEafHFFhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39840400004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(86362001)(6506007)(478600001)(6486002)(6666004)(316002)(966005)(41300700001)(2616005)(66476007)(66946007)(6512007)(8676002)(8936002)(66556008)(4326008)(7416002)(44832011)(5660300002)(6916009)(36756003)(83380400001)(38100700002)(26005)(2906002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JG1aN09NJ40JvEu4xLH2JXcA7RBN62mQy6Xc8jvj+pEdxt/p6//LEk9MmZ79?=
 =?us-ascii?Q?DPmOZ/0WlZ76ay/hh7UCO6T1XNM4o5rjCHjQBg3O63I59WJyFx7IUFRTb2fn?=
 =?us-ascii?Q?TEhv+ft+EQgX0P7Xb4hyl65unW9P6etn1E86m+Lt9iZbgSOtoA2juK5Qr0Jo?=
 =?us-ascii?Q?gr8iFPXR9RIuLUwKZPYfFUpFfP1Lo8o39sGx71nz9yMKlmRAtVbi/MRefm0I?=
 =?us-ascii?Q?EAIIiMNQ1PPjG5K+5bPYfILwSjZjNg/n9hsi88hL9VHPJ25PsE+rHgQEH9hv?=
 =?us-ascii?Q?ZVFQyiNOah6RoBZ/S5FGeWk7sdGvsOzTMCv2AqOYlqHQIZl1nHhEq7tJjPri?=
 =?us-ascii?Q?p3w3CeGwVxKR9A1QxUTEU8C362WQoK/LkXFiPG8UzFaf20LtFzqkmmOEEmKX?=
 =?us-ascii?Q?Nz5BRddztKZSaGCwDKO1FubymAEv6AgqZCx7xY4G7Lc9YlwT3g0EbVj/wN42?=
 =?us-ascii?Q?nVx7qK0HvfcGI+hmm9BKC9dBfubjTYtIOGjf+4yrX7P+rCR5PxfK6W85Kq6N?=
 =?us-ascii?Q?plEo218lsoNkwkjz476w7dXpNpGTGJh6LYXujVJEtc+Y4eR5R/xIAkVjeuF4?=
 =?us-ascii?Q?DOfaWLTZ+6+0NB1WKvi/2zXwRC5e0p9WVhTGuZdofx9+XgiAy/FQ6DgzpLG/?=
 =?us-ascii?Q?ysVFAz5HY++eAXX6bIl9woIPlxxIuI2Z1/HI2lUF+tZXEqHa8IaJzyjVId0d?=
 =?us-ascii?Q?SGXol2PtTvvwceTUNtMFm56XaRzv9nrOcYLRUIgc0VlMvaMm2ST9u/U/wXni?=
 =?us-ascii?Q?Jwik44plcZfltWpZGZ8BBmvkzXiX516tC9k6AjBVZCy+DNYZ5G5FTDXR5S46?=
 =?us-ascii?Q?XD2wkQFKjkShu0swdadV59wcjFujnAK9m9JdjrSBRSgeshXIJcjRxlr7HiG2?=
 =?us-ascii?Q?i0IozYB3Bt4brkgI1n0db4AyW977y8JovJ6RWz1eIMRyYrdCgf2JyDi2CbzM?=
 =?us-ascii?Q?JoFHtPoArgMC4mXVMtSmk7XASxhQHfQbm7LIRvyY5GQAk+9uCmEbnyj2Vo+/?=
 =?us-ascii?Q?Env1Oaro1VosPz7bNMGJOdJiD1zg5Z8kCM9v6mhRwR5EVWMPBoWCjHtLC7K3?=
 =?us-ascii?Q?GxrC8wgJ8QHJAiPiEQdM9S/MOrKQPUKMa38AgB94mHB8Euqag9FY0uLB8x2g?=
 =?us-ascii?Q?cV0JVaTu5ZlvcPav3jFuWll4gbdB3aH795WRSenv0J2gkanqKJIDDY1D1hIg?=
 =?us-ascii?Q?4TeleYun4eRb799DeFlzLTo7h4ky4P9eig06F4xyHa+lhVy1tZV3hZyJRY/x?=
 =?us-ascii?Q?x7l6+2pzcFG/fZB3Ces7G8RYKSWMvpuAknOon7BDjIs5YSSJhDvzKBJl3RRz?=
 =?us-ascii?Q?fE49ypmt/siwwy4WC8xGSli4UHhnjaZDoFgzJk+KHZVqh7yWAOhRP+J5zZAr?=
 =?us-ascii?Q?+y1QPvuevMQquPsvpRtAI54Qu1d02JnVYqOIVaOIZaeH/t7t1HOEU2hwQE/d?=
 =?us-ascii?Q?jujeyaZxdyuPEKFIPfZdM6I8DnTt7esYIf4M0tc+uUTtToB2jXevFC9Bh7A4?=
 =?us-ascii?Q?HSr5icPS4Ti10PfzG0ZhVrldeHgObDOriNk2ZNs4PkV+ArjHi7V0gFvbTXGK?=
 =?us-ascii?Q?FNF87veTuunm1m91L+A0wFD2Kq5/4OS3YENoVmi9+EeX+wxzD1LG4OmEETjv?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f478c0c5-56b1-4986-d61e-08dbe233742e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 21:24:42.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSoWXlwmPo4of1RoR3G4VSwGAwuqvqwKInqxPdB8nmWfoQlw292zGjV9NnGT8fs/gkZo0npPMSSI9LMC8JmPJPIhcEH86h+ntPpZRMqMR1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4490

On Fri, Nov 10, 2023 at 10:05:57AM +0100, Michal Hocko wrote:
> On Thu 09-11-23 11:34:01, Gregory Price wrote:
> [...]
> > Anyway, summarizing:  After a bit of reading, this does seem to map
> > better to the "accounting consumption" subsystem than the "constrain"
> > subsystem. However, if you think it's better suited for cpuset, I'm
> > happy to push in that direction.
> 
> Maybe others see it differently but I stick with my previous position.
> Memcg is not a great fit for reasons already mentioned - most notably
> that the controller doesn't control the allocation but accounting what
> has been already allocated. Cpusets on the other hand constrains the
> allocations and that is exactly what you want to achieve. 
> -- 
> Michal Hocko
> SUSE Labs

Digging in a bit, placing it in cpusets has locking requirements that
concerns me.  Maybe I'm being a bit over-cautious, so if none of this
matters, then I'll go ahead and swap the code over to cpusets.
Otherwise, just more food for thought in cpusets vs memcg.

In cpusets.c it states when acquiring read-only access, we have to
acquire the (global) callback lock:

https://github.com/torvalds/linux/blob/master/kernel/cgroup/cpuset.c#L391
* There are two global locks guarding cpuset structures - cpuset_mutex and
* callback_lock. We also require taking task_lock() when dereferencing a
* task's cpuset pointer. See "The task_lock() exception", at the end of this
* comment.

Examples:

cpuset_node_allowed:
https://github.com/torvalds/linux/blob/master/kernel/cgroup/cpuset.c#L4780
    spin_lock_irqsave(&callback_lock, flags);
    rcu_read_lock();
    cs = nearest_hardwall_ancestor(task_cs(current)); <-- walks parents
    allowed = node_isset(node, cs->mems_allowed);
    rcu_read_unlock();
    spin_unlock_irqrestore(&callback_lock, flags);

cpuset_mems_allowed:
https://github.com/torvalds/linux/blob/master/kernel/cgroup/cpuset.c#L4679
    spin_lock_irqsave(&callback_lock, flags);
    rcu_read_lock();
    guarantee_online_mems(task_cs(tsk), &mask); <-- walks parents
    rcu_read_unlock();
    spin_unlock_irqrestore(&callback_lock, flags);

Seems apparent that any form of parent walk in cpusets will require the
acquisition of &callback_lock.  This does not appear true of memcg.

Implementing a similar inheritance structure as described in this patch
set would therefore cause the acquisition of the callback lock during
node selection. So if we want this in cpuset, we're going to eat that
lock acquisition, despite not really needing it.


I'm was not intending to do checks against cpusets.mems_allowed when
acquiring weights, as this is already enforced between cpusets and
mempolicy on hotplug and mask changes, as well as in the allocators via
read_mems_allowed_begin/retry..

This is why I said this was *not* a constraining feature. Additionally,
if the node selected by mpol is exhausted, the allocator will simply
acquire memory from another (allowed) node, disregarding the weights
entirely (which is the correct / expected behavior). Another example of
"this is more of a suggestion" rather than a constraint.

So I'm contending here that putting it in cpusets is overkill.  But if
it likewise doesn't fit in memcg, is it insane to suggest that maybe we
should consider adding cgroup.mpol, and maybe consider migrating features
from mempolicy.c into cgroups (while keeping mpol the way it is).

~Gregory

