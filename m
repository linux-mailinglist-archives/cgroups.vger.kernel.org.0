Return-Path: <cgroups+bounces-8063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F891AADD37
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E806F506A1E
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DDB233736;
	Wed,  7 May 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmZ2fTlp"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932721A445;
	Wed,  7 May 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616995; cv=none; b=PRk1sQdXFP5tsnHMMglOKMj6ndapfyX9N8dTqFi8JB3EtmUXb2HWoQIkbmE11Huh5+pcWnmedMFcPhnvA7aGw5bn0u9Fj94hQEPEeYmjfnhJBzFKQ/nR/HwOQ3gESqMIvcC3SNKv+xWcHUJ1U5I7kUzu0kxO+FqdNdc0pbLI4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616995; c=relaxed/simple;
	bh=3C2GGR5aDfk5vm3bQx1+6DND+kJFPluApajlM6kBr2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMPX97Rn+CekRuaH6yfsHZWcMpk4M+VelC3z7OhxoD6EwOTckKM3g5wHt9MuGl71aLZCTqyNWkT8fA94KXIvcKPB9cxGkkG4upgpRYLiHdvBAHtFg7yLyeFEmu+ToNswtWIBU6KMHfBRbx1DKH3wVN4PxLlhSF7wO4GdNdF4RRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmZ2fTlp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746616993; x=1778152993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3C2GGR5aDfk5vm3bQx1+6DND+kJFPluApajlM6kBr2w=;
  b=HmZ2fTlpRPjryfHTYvhanY0Bes543rAOKxQChnxtR2oxodLUGJQwvbgB
   X2Uc+9hTqpMyDZDN5FsbIPOC39OVAI01ugVVnAimNXLotwh2Nt3uoSQCz
   djvhTHbCIw6Rvsn0lVFTeMqUr52OFK/JeaUYg9jCAOOGZLURwAV2IEX6i
   uZC/eau9Gg8ZDojbahc3h45B0JDkt+g7v8Z4kn6j7cQuoY91gR2wBzMkS
   TYKGm8mTHSoy6UgProP3BzLaWw4g5PaWRbu3qY7357oPFvqa/DdweYaA+
   XmXupOR+2smD0RL9ptQV09SImKyYBwQf8QVyU4YOHF341luVwXUnliC2H
   w==;
X-CSE-ConnectionGUID: YWZgB60fTci/NzgTwBKKpw==
X-CSE-MsgGUID: pGFuT0SHQz2p89X3GrbWwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48454952"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48454952"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:23:12 -0700
X-CSE-ConnectionGUID: Lxr333HGQUmEx+v4KF9rBg==
X-CSE-MsgGUID: DXV75fmtQkO0Fd77C9xtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135946734"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 04:23:07 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: mkoutny@suse.com,
	Ingo Molnar <mingo@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Chen, Tim C" <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Jain, Ayush" <ayushjai@amd.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.chen.surf@foxmail.com>,
	Ayush Jain <Ayush.jain3@amd.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4 1/2] sched/numa: fix task swap by skipping kernel threads
Date: Wed,  7 May 2025 19:17:15 +0800
Message-Id: <a541cdf9b97f523f6b8067271847a986db5ba768.1746611892.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1746611892.git.yu.c.chen@intel.com>
References: <cover.1746611892.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Libo Chen <libo.chen@oracle.com>

Task swapping is triggered when there are no idle CPUs in
task A's preferred node. In this case, the NUMA load balancer
chooses a task B on A's preferred node and swaps B with A. This
helps improve NUMA locality without introducing load imbalance
between nodes.

In the current implementation, B's NUMA node preference is not
mandatory, and it aims not to increase load imbalance. That is
to say, a kernel thread might be chosen as B. However, kernel
threads are not supposed to be covered by NUMA balancing because
NUMA balancing only considers user pages via VMAs.

Fix this by not considering kernel threads as swap targets in
task_numa_compare(). This can be extended beyond kernel threads
in the future by checking if a swap candidate has a valid NUMA
preference through checking the candidate's numa_preferred_nid
and numa_faults. For now, keep the code simple.

Suggested-by: Michal Koutny <mkoutny@suse.com>
Tested-by: Ayush Jain <Ayush.jain3@amd.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fb9bf995a47..d1af2e084a2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2273,7 +2273,8 @@ static bool task_numa_compare(struct task_numa_env *env,
 
 	rcu_read_lock();
 	cur = rcu_dereference(dst_rq->curr);
-	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
+	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur) ||
+		    !cur->mm))
 		cur = NULL;
 
 	/*
-- 
2.25.1


