Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AB43D83A7
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhG0XEy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 19:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhG0XEx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 19:04:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5EC061757;
        Tue, 27 Jul 2021 16:04:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m1so2293882pjv.2;
        Tue, 27 Jul 2021 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+zPcJpoAXidsAZrfmunhWmzWmAmlPVvmu9gYFGmOupg=;
        b=coS26sfi4q47AesZECMQbJnXpLJ7/LBavvccUdZakqOPGCA1I6W1t7XMnnOtrm0Et9
         odHOTcXdUEyDQlPinWYi7S/H+tr1CI1xhbvqBmgWuGwjOD4DY+UcFZFqcfIEtc/jy8Pr
         32sYeLMHHs8xNDiGlI0k05xmJss0esdtcOj1Jc505JLSG9sRoM8FjuueGMBC9EI6Oi+a
         uM+WsGI30f65296dIL2R9f+K8Pz4E58lT2azagUvpqK8SWYitxu9grLqRJUk6FQMEOck
         kMLNy43EAHxMBsNnfou5gXygu4N7XcdF3Nw6t82Y196CL8FS3rnftPgUS5LFYky/H6z9
         3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+zPcJpoAXidsAZrfmunhWmzWmAmlPVvmu9gYFGmOupg=;
        b=juOT3qhteyDCynhEsSeYadTYsoaHv711b0qzR09zPQvHafnRBlSu4sAfwbMWZpneUQ
         dQM3xJtIz95fB7AzXHKfee0OxzKiwB3g71SgtogYSI6MclEautujIUuvLyUSNaTnnHk3
         2KzP6RAnjRjEkNLSqR1yOEgNa9FqGaEm2WWDtcZlEec3lFv00nMIaMtWzqGWZFa4nY3B
         znKtoeu9rphwTdETUpE5113e6T8rN+RWqYPQeRmxYs9wqNNUur/fvnckd851lXzuSIf/
         coFsTiAb52EMkjRonicEC3gjUqViEG7KZ9l2HpNEuU2+z6HTmWlzgJO1ieF+OFjPk40y
         UkNw==
X-Gm-Message-State: AOAM530lFEQxKe12V2f3NQ5TCq387pQ+NPx4kAor8XyfYk8HHw6bCb7n
        QLvhAIc3SYOZHwIRRvFZxVlnNYrI64k=
X-Google-Smtp-Source: ABdhPJwwbDG/wG2ihmsvvWP3UH8uFmJ3J9EaInjSv0ju6+uYUVfdAXr4+1yOEbOYpaMe7P58ViIyrw==
X-Received: by 2002:aa7:848e:0:b029:333:4742:edb3 with SMTP id u14-20020aa7848e0000b02903334742edb3mr25152947pfn.12.1627427091522;
        Tue, 27 Jul 2021 16:04:51 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id e12sm3931655pjh.33.2021.07.27.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:04:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 13:04:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH cgroup/for-5.14-fixes] cgroup: rstat: fix A-A deadlock on
 32bit around u64_stats_sync
Message-ID: <YQCREXMBq1EPoQWu@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex with a spinlock") added
cgroup_rstat_flush_irqsafe() allowing flushing to happen from the irq
context. However, rstat paths use u64_stats_sync to synchronize access to
64bit stat counters on 32bit machines. u64_stats_sync is implemented using
seq_lock and trying to read from an irq context can lead to A-A deadlock if
the irq happens to interrupt the stat update.

Fix it by using the irqsafe variants - u64_stats_update_begin_irqsave() and
u64_stats_update_end_irqrestore() - in the update paths. Note that none of
this matters on 64bit machines. All these are just for 32bit SMP setups.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Rik van Riel <riel@surriel.com>
---
 block/blk-cgroup.c    |   14 ++++++++------
 kernel/cgroup/rstat.c |   19 +++++++++++--------
 2 files changed, 19 insertions(+), 14 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -790,6 +790,7 @@ static void blkcg_rstat_flush(struct cgr
 		struct blkcg_gq *parent = blkg->parent;
 		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
 		struct blkg_iostat cur, delta;
+		unsigned long flags;
 		unsigned int seq;
 
 		/* fetch the current per-cpu values */
@@ -799,21 +800,21 @@ static void blkcg_rstat_flush(struct cgr
 		} while (u64_stats_fetch_retry(&bisc->sync, seq));
 
 		/* propagate percpu delta to global */
-		u64_stats_update_begin(&blkg->iostat.sync);
+		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
 		blkg_iostat_set(&delta, &cur);
 		blkg_iostat_sub(&delta, &bisc->last);
 		blkg_iostat_add(&blkg->iostat.cur, &delta);
 		blkg_iostat_add(&bisc->last, &delta);
-		u64_stats_update_end(&blkg->iostat.sync);
+		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 
 		/* propagate global delta to parent (unless that's root) */
 		if (parent && parent->parent) {
-			u64_stats_update_begin(&parent->iostat.sync);
+			flags = u64_stats_update_begin_irqsave(&parent->iostat.sync);
 			blkg_iostat_set(&delta, &blkg->iostat.cur);
 			blkg_iostat_sub(&delta, &blkg->iostat.last);
 			blkg_iostat_add(&parent->iostat.cur, &delta);
 			blkg_iostat_add(&blkg->iostat.last, &delta);
-			u64_stats_update_end(&parent->iostat.sync);
+			u64_stats_update_end_irqrestore(&parent->iostat.sync, flags);
 		}
 	}
 
@@ -848,6 +849,7 @@ static void blkcg_fill_root_iostats(void
 		memset(&tmp, 0, sizeof(tmp));
 		for_each_possible_cpu(cpu) {
 			struct disk_stats *cpu_dkstats;
+			unsigned long flags;
 
 			cpu_dkstats = per_cpu_ptr(bdev->bd_stats, cpu);
 			tmp.ios[BLKG_IOSTAT_READ] +=
@@ -864,9 +866,9 @@ static void blkcg_fill_root_iostats(void
 			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
 
-			u64_stats_update_begin(&blkg->iostat.sync);
+			flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
 			blkg_iostat_set(&blkg->iostat.cur, &tmp);
-			u64_stats_update_end(&blkg->iostat.sync);
+			u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 		}
 	}
 }
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -347,19 +347,20 @@ static void cgroup_base_stat_flush(struc
 }
 
 static struct cgroup_rstat_cpu *
-cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp)
+cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
 {
 	struct cgroup_rstat_cpu *rstatc;
 
 	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
-	u64_stats_update_begin(&rstatc->bsync);
+	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
 
 static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_cpu *rstatc)
+						 struct cgroup_rstat_cpu *rstatc,
+						 unsigned long flags)
 {
-	u64_stats_update_end(&rstatc->bsync);
+	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
 	cgroup_rstat_updated(cgrp, smp_processor_id());
 	put_cpu_ptr(rstatc);
 }
@@ -367,18 +368,20 @@ static void cgroup_base_stat_cputime_acc
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
 	struct cgroup_rstat_cpu *rstatc;
+	unsigned long flags;
 
-	rstatc = cgroup_base_stat_cputime_account_begin(cgrp);
+	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
 	rstatc->bstat.cputime.sum_exec_runtime += delta_exec;
-	cgroup_base_stat_cputime_account_end(cgrp, rstatc);
+	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
 }
 
 void __cgroup_account_cputime_field(struct cgroup *cgrp,
 				    enum cpu_usage_stat index, u64 delta_exec)
 {
 	struct cgroup_rstat_cpu *rstatc;
+	unsigned long flags;
 
-	rstatc = cgroup_base_stat_cputime_account_begin(cgrp);
+	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
 
 	switch (index) {
 	case CPUTIME_USER:
@@ -394,7 +397,7 @@ void __cgroup_account_cputime_field(stru
 		break;
 	}
 
-	cgroup_base_stat_cputime_account_end(cgrp, rstatc);
+	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
 }
 
 /*
