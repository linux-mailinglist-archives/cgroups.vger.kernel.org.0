Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D3367D2D
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhDVJG4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhDVJGz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 05:06:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54FC06174A
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z16so32368424pga.1
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BNCpox+Q4e8hYikN+nhg8PF+MLOBfs4k+9TqIvGhtE=;
        b=btTOT05HMemuwbHYCb2mPjUrw/63sacWVxqhXZD3iPMjcg4U9gW2ZeRbL0EbO97mdr
         b9SJTY4H0lyJoXxgcxu9R9Xer4PwHpj1qK2UPhYbyn1AlctU8BDQsqKAHQOTlUQALVSK
         NiReesIJk5nrCG915MRPoWrxUBYNp1am+b42iGPEgg+2V5HvoEBhiSB1TBHOtzmfZiHB
         l1O3+/wcJ/DLazkXk/4BdirNJ39KGBdGr+hvQRNJY/1EBq13drewLqLtZevWu7eKsg2y
         GvDwH9mgpc83FZZssWySS6jNwtqoiTq7385cSXxCZmqPPiszxnCjuPOUiBM5jx+REvRx
         WTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BNCpox+Q4e8hYikN+nhg8PF+MLOBfs4k+9TqIvGhtE=;
        b=VEd8iJYO5DsELRSrr3dA7YspV/8XPKYqTrgf/kYTgNm2wnxVK3ICA4JprGUEaIysF5
         KPTy3n3y3/ELgZtumYpPvRok8MPh1CqPFzLey/CX6z7htoUH6pgE8VWoqOS0cu44+vDt
         si+ZmhU7E43eaaEGdxJwncKtOhsoOt5UxlT4GnImLMOy22/fFuA+CEM8jKuyd40E3ew/
         WLOCPF/Vs2jeF9qoCFqJEHHqHI+mEnD29LULStgKJTiz6XpWEYuRX8a77S3ygLyyBE2B
         fEpMU5GX8V04b44Lo5Z1dN8SkGOyo4EhrDL7X1yb9V3CO3eFIU389CaqmNab7vYPRf98
         60FA==
X-Gm-Message-State: AOAM533ArnXS/p7+Pp8KwIDqZlvOmDovM1Ngpa7gWH9iHjhGpDgMvVjq
        0EDgiqADAOgqxdhmFDwhZKoBUg==
X-Google-Smtp-Source: ABdhPJxK+DeadLf9GyTrtbaiBLpLybvZoNyKy+NoxtowOmP+Dcbv9ma7k5UsNPm0zKzgZf2LpvblcQ==
X-Received: by 2002:a62:f249:0:b029:249:acb4:98b6 with SMTP id y9-20020a62f2490000b0290249acb498b6mr2414480pfl.55.1619082380780;
        Thu, 22 Apr 2021 02:06:20 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x2sm1514348pfu.77.2021.04.22.02.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:06:20 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     akpm@linux-foundation.org, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] cgroup/cpuset: introduce cpuset.mems.migration
Date:   Thu, 22 Apr 2021 17:06:07 +0800
Message-Id: <20210422090608.7160-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422090608.7160-1-wuyun.abel@bytedance.com>
References: <20210422090608.7160-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Some of our services are quite performance sensitive and
actually NUMA-aware designed, aka numa-services. The SLOs
can be easily violated when co-locate these services with
other workloads. Thus they are granted to occupy the whole
one or several NUMA nodes according to their quota.

When a NUMA node is assigned to numa-service, the workload
on that node needs to be moved away fast and complete. The
main aspects we cared about on the eviction are as follows:

a) it should complete soon enough so that numa-services
   won’t wait too long to hurt user experience
b) the workloads to be evicted could have massive usage on
   memory, and migrating such amount of memory may lead to
   a sudden severe performance drop lasting tens of seconds
   that some certain workloads may not afford
c) the impact of the eviction should be limited within the
   source and destination nodes
d) cgroup interface is preferred

So we come to a thought that:

1) fire up numa-services without waiting for memory migration
2) memory migration can be done asynchronously by using spare
   memory bandwidth

AutoNUMA seems to be a solution, but its scope is global which
violates c&d. And cpuset.memory_migrate performs in a synchronous
fashion which breaks a&b. So a mixture of them, the new cgroup2
interface cpuset.mems.migration, is introduced.

The new cpuset.mems.migration supports three modes:

 - "none" mode, meaning migration disabled
 - "sync" mode, which is exactly the same as the cgroup v1
   interface cpuset.memory_migrate
 - "lazy" mode, when walking through all the pages, unlike
   cpuset.memory_migrate, it only sets pages to protnone,
   and numa faults triggered by later touch will handle the
   movement.

See next patch for detailed information.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/cgroup/cpuset.c | 104 ++++++++++++++++++++++++++++++++---------
 mm/mempolicy.c         |   2 +-
 2 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a945504c0ae7..ee84f168eea8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -212,6 +212,7 @@ typedef enum {
 	CS_MEM_EXCLUSIVE,
 	CS_MEM_HARDWALL,
 	CS_MEMORY_MIGRATE,
+	CS_MEMORY_MIGRATE_LAZY,
 	CS_SCHED_LOAD_BALANCE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
@@ -248,6 +249,11 @@ static inline int is_memory_migrate(const struct cpuset *cs)
 	return test_bit(CS_MEMORY_MIGRATE, &cs->flags);
 }
 
+static inline int is_memory_migrate_lazy(const struct cpuset *cs)
+{
+	return test_bit(CS_MEMORY_MIGRATE_LAZY, &cs->flags);
+}
+
 static inline int is_spread_page(const struct cpuset *cs)
 {
 	return test_bit(CS_SPREAD_PAGE, &cs->flags);
@@ -1594,6 +1600,7 @@ struct cpuset_migrate_mm_work {
 	struct mm_struct	*mm;
 	nodemask_t		from;
 	nodemask_t		to;
+	int			flags;
 };
 
 static void cpuset_migrate_mm_workfn(struct work_struct *work)
@@ -1602,21 +1609,29 @@ static void cpuset_migrate_mm_workfn(struct work_struct *work)
 		container_of(work, struct cpuset_migrate_mm_work, work);
 
 	/* on a wq worker, no need to worry about %current's mems_allowed */
-	do_migrate_pages(mwork->mm, &mwork->from, &mwork->to, MPOL_MF_MOVE_ALL);
+	do_migrate_pages(mwork->mm, &mwork->from, &mwork->to, mwork->flags);
 	mmput(mwork->mm);
 	kfree(mwork);
 }
 
-static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
-							const nodemask_t *to)
+static void cpuset_migrate_mm(struct cpuset *cs, struct mm_struct *mm,
+			      const nodemask_t *from, const nodemask_t *to)
 {
-	struct cpuset_migrate_mm_work *mwork;
+	struct cpuset_migrate_mm_work *mwork = NULL;
+	int flags = 0;
 
-	mwork = kzalloc(sizeof(*mwork), GFP_KERNEL);
+	if (is_memory_migrate_lazy(cs))
+		flags = MPOL_MF_LAZY;
+	else if (is_memory_migrate(cs))
+		flags = MPOL_MF_MOVE_ALL;
+
+	if (flags)
+		mwork = kzalloc(sizeof(*mwork), GFP_KERNEL);
 	if (mwork) {
 		mwork->mm = mm;
 		mwork->from = *from;
 		mwork->to = *to;
+		mwork->flags = flags;
 		INIT_WORK(&mwork->work, cpuset_migrate_mm_workfn);
 		queue_work(cpuset_migrate_mm_wq, &mwork->work);
 	} else {
@@ -1690,7 +1705,6 @@ static void update_tasks_nodemask(struct cpuset *cs)
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it))) {
 		struct mm_struct *mm;
-		bool migrate;
 
 		cpuset_change_task_nodemask(task, &newmems);
 
@@ -1698,13 +1712,8 @@ static void update_tasks_nodemask(struct cpuset *cs)
 		if (!mm)
 			continue;
 
-		migrate = is_memory_migrate(cs);
-
 		mpol_rebind_mm(mm, &cs->mems_allowed);
-		if (migrate)
-			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
-		else
-			mmput(mm);
+		cpuset_migrate_mm(cs, mm, &cs->old_mems_allowed, &newmems);
 	}
 	css_task_iter_end(&it);
 
@@ -1911,6 +1920,11 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	else
 		clear_bit(bit, &trialcs->flags);
 
+	if (bit == CS_MEMORY_MIGRATE)
+		clear_bit(CS_MEMORY_MIGRATE_LAZY, &trialcs->flags);
+	if (bit == CS_MEMORY_MIGRATE_LAZY)
+		clear_bit(CS_MEMORY_MIGRATE, &trialcs->flags);
+
 	err = validate_change(cs, trialcs);
 	if (err < 0)
 		goto out;
@@ -2237,11 +2251,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 			 * @old_mems_allowed is the right nodesets that we
 			 * migrate mm from.
 			 */
-			if (is_memory_migrate(cs))
-				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
-						  &cpuset_attach_nodemask_to);
-			else
-				mmput(mm);
+			cpuset_migrate_mm(cs, mm, &oldcs->old_mems_allowed,
+					  &cpuset_attach_nodemask_to);
 		}
 	}
 
@@ -2258,6 +2269,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 typedef enum {
 	FILE_MEMORY_MIGRATE,
+	FILE_MEMORY_MIGRATE_LAZY,
 	FILE_CPULIST,
 	FILE_MEMLIST,
 	FILE_EFFECTIVE_CPULIST,
@@ -2275,11 +2287,8 @@ typedef enum {
 	FILE_SPREAD_SLAB,
 } cpuset_filetype_t;
 
-static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
-			    u64 val)
+static int __cpuset_write_u64(struct cpuset *cs, cpuset_filetype_t type, u64 val)
 {
-	struct cpuset *cs = css_cs(css);
-	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
 	get_online_cpus();
@@ -2305,6 +2314,9 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	case FILE_MEMORY_MIGRATE:
 		retval = update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
+	case FILE_MEMORY_MIGRATE_LAZY:
+		retval = update_flag(CS_MEMORY_MIGRATE_LAZY, cs, val);
+		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
 		cpuset_memory_pressure_enabled = !!val;
 		break;
@@ -2324,6 +2336,12 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
+static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			    u64 val)
+{
+	return __cpuset_write_u64(css_cs(css), cft->private, val);
+}
+
 static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 			    s64 val)
 {
@@ -2473,6 +2491,8 @@ static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 		return is_sched_load_balance(cs);
 	case FILE_MEMORY_MIGRATE:
 		return is_memory_migrate(cs);
+	case FILE_MEMORY_MIGRATE_LAZY:
+		return is_memory_migrate_lazy(cs);
 	case FILE_MEMORY_PRESSURE_ENABLED:
 		return cpuset_memory_pressure_enabled;
 	case FILE_MEMORY_PRESSURE:
@@ -2555,6 +2575,40 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	return retval ?: nbytes;
 }
 
+static int cpuset_mm_migration_show(struct seq_file *seq, void *v)
+{
+	struct cpuset *cs = css_cs(seq_css(seq));
+
+	if (is_memory_migrate_lazy(cs))
+		seq_puts(seq, "lazy\n");
+	else if (is_memory_migrate(cs))
+		seq_puts(seq, "sync\n");
+	else
+		seq_puts(seq, "none\n");
+	return 0;
+}
+
+static ssize_t cpuset_mm_migration_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	struct cpuset *cs = css_cs(of_css(of));
+	cpuset_filetype_t type = FILE_MEMORY_MIGRATE;
+	int turning_on = 1;
+	int retval;
+
+	buf = strstrip(buf);
+
+	if (!strcmp(buf, "none"))
+		turning_on = 0;
+	else if (!strcmp(buf, "lazy"))
+		type = FILE_MEMORY_MIGRATE_LAZY;
+	else if (strcmp(buf, "sync"))
+		return -EINVAL;
+
+	retval = __cpuset_write_u64(cs, type, turning_on);
+	return retval ?: nbytes;
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
@@ -2711,6 +2765,14 @@ static struct cftype dfl_files[] = {
 		.flags = CFTYPE_DEBUG,
 	},
 
+	{
+		.name = "mems.migration",
+		.seq_show = cpuset_mm_migration_show,
+		.write = cpuset_mm_migration_write,
+		.private = FILE_MEMORY_MIGRATE,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
 	{ }	/* terminate */
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e0ae6997bbfb..f816b2ac5f52 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1097,7 +1097,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
-	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
+	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL | MPOL_MF_LAZY)));
 	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
-- 
2.31.1

