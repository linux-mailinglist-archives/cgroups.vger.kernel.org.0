Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D997FB009C
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2019 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfIKPzB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Sep 2019 11:55:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40214 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfIKPzB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Sep 2019 11:55:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so25877356qtq.7;
        Wed, 11 Sep 2019 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHtvXZdJhxnSSB+tt58qotfhmjmO1WJZUkRUMqmYHaA=;
        b=rEG1LEpjQqN5rSQBkSx9VcIiZ/LShjkPMMCi0QvFtOoePPn9YEhEAmAHR1z19zuUN7
         t2jm2MM4N/1MqJOKn04Uhfv5xFZk9eCTHNdS4e027HuTZCFpCTrJINKOJmAHtrbgfo3q
         pAb+W050CnfIvQdxNZ7MBMk9lhe/b3I2cc0/s7dy/MsCGsSfj97LUbXXRwI9ALC1Tzvu
         FbyPLY4LWKXgU3ms52KAvgzx7Z4TXKgM9jZDxaXyBJlYmkxgi6oKuQ6f0zp1NLMt1uIQ
         rAQ7bc2jplo5/rB50PQ1MYilA83qY2KmVfR+Lyak4WJlRwWCgYlY5rOwpeoYhFgNlCm/
         QG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHtvXZdJhxnSSB+tt58qotfhmjmO1WJZUkRUMqmYHaA=;
        b=fwTu7y6dk5dwj2Xa0O3X6dWnmKNEbvZhxcJFR3FtqGG+fcHOEHBOiGd6WlBrXzsKg+
         +/n8bZRcmiR9g+AdlaVOLh9EizeA92FMecPfmxeA+J14iFZ2XiAAGH5bwV/aA+niwG7V
         NTsfqml0c7Hem5MPvlAxcN7uoOYJ/QDbpIl1c+bVInmX7B+qSToxhXJ5lPdRgpPtl3G+
         O+olLjDt3lw0QK/5dgzNVGPxMbx2WNuYAzzPJNK+2OObFLVtU3MbRBLWhF2SRhfix3+I
         s7+zvj7oB85OMlYngCJar0NO0C/Keq/NrZdoz6+4QeS9IfUW92plHbDSOvE3/fNjHDD4
         aA2Q==
X-Gm-Message-State: APjAAAUpeYHIzPfF0tmswkIoxkreYzememb43grbiEtM014ZH5HijJgi
        AdDj5Cfwvp+AM86bq2ZcTps=
X-Google-Smtp-Source: APXvYqwjukYuvfUgQ+Aacq2Nz2oOJFjGDm8cUzhW3IoRCsNBhBgx35NaeiQEDfraEPLiLgDD6dAknA==
X-Received: by 2002:ad4:4bca:: with SMTP id l10mr23356580qvw.139.1568217299897;
        Wed, 11 Sep 2019 08:54:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:8b2])
        by smtp.gmail.com with ESMTPSA id f5sm5963815qkg.9.2019.09.11.08.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:54:59 -0700 (PDT)
Date:   Wed, 11 Sep 2019 08:54:57 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, clm@fb.com,
        dennisz@fb.com, newella@fb.com, Li Zefan <lizefan@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20190911155457.GW2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <A69EF8D0-8156-46DB-A4DA-C5334764116E@linaro.org>
 <20190911141630.GV2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911141630.GV2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey,

On Wed, Sep 11, 2019 at 07:16:30AM -0700, Tejun Heo wrote:
> > >  I can implement
> > > the switching if so.
> > 
> > That would be perfect.
> 
> Whichever way it gets decided, this is easy enough.  I'll prep a
> patch.

Here's the patch.

* It disables iocost when bfq iosched is selected.  iocost is only
  re-enabled when bfq module is unloaded.  While it can easily be made
  to flip when there's no bfq queue left, I think minimizing the
  number of switches is likely is better.

* It looks like building bfq as module has been broken for some time
  and I added symbol exports to make it work.  They should be
  separated into a separate patch.

* It doesn't actually rename any of the bfq interface files.  It just
  gets rid of potential conflict from iocost.

Please feel free to use / modify the patch however you see fit.

Thanks.

---
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 86a607cf19a1..decda96770f4 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1194,7 +1194,9 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
+#ifndef CONFIG_BLK_CGROUP_IOCOST
 	.dfl_cftypes		= bfq_blkg_files,
+#endif
 	.legacy_cftypes		= bfq_blkcg_legacy_files,
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b33be928d164..b4aaeef1fb87 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6365,6 +6365,36 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->sched_data.bfq_class_idle_last_service = jiffies;
 }
 
+#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_BLK_CGROUP_IOCOST)
+static bool bfq_enabled = false;
+
+static void bfq_enable(void)
+{
+	static DEFINE_MUTEX(bfq_enable_mutex);
+
+	mutex_lock(&bfq_enable_mutex);
+	if (!bfq_enabled) {
+		pr_info("bfq-iosched: Overriding iocost\n");
+		blkcg_policy_unregister(&blkcg_policy_iocost);
+		cgroup_add_dfl_cftypes(&io_cgrp_subsys, bfq_blkg_files);
+		bfq_enabled = true;
+	}
+	mutex_unlock(&bfq_enable_mutex);
+}
+
+static void __exit bfq_disable(void)
+{
+	if (bfq_enabled) {
+		pr_info("bfq-iosched: Restoring iocost\n");
+		cgroup_rm_cftypes(bfq_blkg_files);
+		blkcg_policy_register(&blkcg_policy_iocost);
+	}
+}
+#else
+static void bfq_enable(void) {}
+static void __exit bfq_disable(void) {}
+#endif
+
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
@@ -6489,6 +6519,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
 	wbt_disable_default(q);
+	bfq_enable();
 	return 0;
 
 out_free:
@@ -6806,6 +6837,7 @@ static void __exit bfq_exit(void)
 	blkcg_policy_unregister(&blkcg_policy_bfq);
 #endif
 	bfq_slab_kill();
+	bfq_disable();
 }
 
 module_init(bfq_init);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0e2619c1a422..b6f20be0fc78 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -900,6 +900,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
 /**
  * blkg_conf_finish - finish up per-blkg config update
@@ -915,6 +916,7 @@ void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 	rcu_read_unlock();
 	put_disk_and_module(ctx->disk);
 }
+EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3b39deb8b9f8..1ef5b443c09a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -605,8 +605,6 @@ static u32 vrate_adj_pct[] =
 	  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
 	  4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 16 };
 
-static struct blkcg_policy blkcg_policy_iocost;
-
 /* accessors and helpers */
 static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 {
@@ -2434,7 +2432,7 @@ static struct cftype ioc_files[] = {
 	{}
 };
 
-static struct blkcg_policy blkcg_policy_iocost = {
+struct blkcg_policy blkcg_policy_iocost = {
 	.dfl_cftypes	= ioc_files,
 	.cpd_alloc_fn	= ioc_cpd_alloc,
 	.cpd_free_fn	= ioc_cpd_free,
@@ -2442,6 +2440,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
 	.pd_init_fn	= ioc_pd_init,
 	.pd_free_fn	= ioc_pd_free,
 };
+EXPORT_SYMBOL_GPL(blkcg_policy_iocost);
 
 static int __init ioc_init(void)
 {
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index bed9e43f9426..5669e3cfa1bc 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -815,6 +815,11 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
+
+#ifdef CONFIG_BLK_CGROUP_IOCOST
+extern struct blkcg_policy blkcg_policy_iocost;
+#endif
+
 #else	/* CONFIG_BLK_CGROUP */
 
 struct blkcg {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549f..ced23229f359 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4059,6 +4059,7 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cgroup_rm_cftypes);
 
 /**
  * cgroup_add_cftypes - add an array of cftypes to a subsystem
@@ -4115,6 +4116,7 @@ int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 		cft->flags |= __CFTYPE_ONLY_ON_DFL;
 	return cgroup_add_cftypes(ss, cfts);
 }
+EXPORT_SYMBOL_GPL(cgroup_add_dfl_cftypes);
 
 /**
  * cgroup_add_legacy_cftypes - add an array of cftypes for legacy hierarchies
