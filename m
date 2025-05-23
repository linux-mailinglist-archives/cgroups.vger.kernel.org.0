Return-Path: <cgroups+bounces-8325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453AAC2337
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 14:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165F3A26189
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6C7DA93;
	Fri, 23 May 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtWbk54x"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC210A1F;
	Fri, 23 May 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005060; cv=none; b=dRwcPVT8ZK6xEHh6+jn3o961aUILDgngmJj5LZriZDwSjwv1e0YN58LoEcBHnFZcFt9Nh95CJD7s1CdfpLA175hJe/JSE4zdUG2vDcGY+3+0s3zkGDz1pAioJ3Zej4nzCnt/pkBowYMTQ4VZsONiZG1lCel6VV8HKY/BPwvqlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005060; c=relaxed/simple;
	bh=uAzqmQ27CSJpty7RbW9XS5900LTZJ6jxrKZ6Q4FYnfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcVrTKwKNJ/6uIzCyCEvwih0XEcd3uDdMnYYBRzgOkxXF//Jja+IlR6IFxi2oyC6FNFurGSc8gZU+eX2LGq8LGvZHDgoxfwDzUXm/tRLCORr1TDjIt78NHYk0Ijf89utkj2O0idWpJds+80WUz5O2snnNKRZG4rKiwlUy8kJbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtWbk54x; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748005058; x=1779541058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAzqmQ27CSJpty7RbW9XS5900LTZJ6jxrKZ6Q4FYnfw=;
  b=LtWbk54xwQ8c4EhRXMPno6zrl0M5yCns7o4KbbP7/e7gTtZjSUucCwFt
   qJsKUYwPFrTpVSJ7/dJyyqP38PTwDlXzCEVW48tV1itg89OrKeqN1CFkp
   HF5dJs7LSQ8nneyayWZZ2kdw8noIb/GL1sSeLld63yxjT/utJPCSh8WJA
   ohw9Xbnm9z3haJUN182MI+7TzOuTDmwbq2wOiCkX0EKQp7hLWJCiGd5+k
   aGFBhOsg5yGdJ/J15AF90oJq4E+Olh4yJNNzjnluWYo5Qzzzfpp8Og5AR
   2j/5MAycwWpzQ3++EADR4j0vq2S0kf+ynzytJPpGtFsTiY78UIx9Jc6wR
   g==;
X-CSE-ConnectionGUID: sDU0/jOuTPu4f9X43pYYvg==
X-CSE-MsgGUID: 4ixFsvwBRgeSWelzKYqHzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61464589"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="61464589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 05:57:37 -0700
X-CSE-ConnectionGUID: +g9hGL3ySHW33/mWARsHNg==
X-CSE-MsgGUID: SXlsmNlyRpOEtkAbRj4YxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141196204"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa007.fm.intel.com with ESMTP; 23 May 2025 05:57:32 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: peterz@infradead.org,
	akpm@linux-foundation.org
Cc: mkoutny@suse.com,
	mingo@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mgorman@suse.de,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tim.c.chen@intel.com,
	aubrey.li@intel.com,
	libo.chen@oracle.com,
	kprateek.nayak@amd.com,
	vineethr@linux.ibm.com,
	venkat88@linux.ibm.com,
	ayushjai@amd.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yu.chen.surf@foxmail.com,
	Ayush Jain <Ayush.jain3@amd.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v5 1/2] sched/numa: fix task swap by skipping kernel threads
Date: Fri, 23 May 2025 20:51:01 +0800
Message-Id: <eaacc9c9bd37bac92d43a671867d85b2fdad3b06.1748002400.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1748002400.git.yu.c.chen@intel.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
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
between nodes. In the current implementation, B's NUMA node
preference is not mandatory. That is to say, a kernel thread
might be incorrectly chosen as B. However, kernel thread and
user space thread that does not have mm are not supposed to be
covered by NUMA balancing because NUMA balancing only considers
user pages via VMAs.

According to Peter's suggestion for fixing this issue, we use
PF_KTHREAD to skip the kernel thread. curr->mm is also checked
because it is possible that user_mode_thread() might create a
user thread without an mm. As per Prateek's analysis, after
adding the PF_KTHREAD check, there is no need to further check
the PF_IDLE flag:
"
- play_idle_precise() already ensures PF_KTHREAD is set before adding
  PF_IDLE

- cpu_startup_entry() is only called from the startup thread which
  should be marked with PF_KTHREAD (based on my understanding looking at
  commit cff9b2332ab7 ("kernel/sched: Modify initial boot task idle
  setup"))
"

In summary, the check in task_numa_compare() now aligns with
task_tick_numa().

Suggested-by: Michal Koutny <mkoutny@suse.com>
Tested-by: Ayush Jain <Ayush.jain3@amd.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4->v5:
Add PF_KTHREAD check, and remove PF_IDLE check.
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fb9bf995a47..03d9a49a68b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2273,7 +2273,8 @@ static bool task_numa_compare(struct task_numa_env *env,
 
 	rcu_read_lock();
 	cur = rcu_dereference(dst_rq->curr);
-	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
+	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
+		    !cur->mm))
 		cur = NULL;
 
 	/*
-- 
2.25.1


