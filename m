Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B773B6A1041
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 20:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjBWTL2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 14:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjBWTLR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 14:11:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3858493
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q16so1210908wrw.2
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m64jqOrcIRXu/umTrAuoSeK+k4rXGOgELajP5IUVuyY=;
        b=MyvXH+hQVkIQRKbJjbYTPtiglbnMkCk1P9i3U9PkHMjHXNyQD/lee1mo5nndiHoIh4
         dyVFkvuRsfpb5Bh5uIbICL0NVmRckTwZPnQcnxulOOo+pi9Y17Mmz3pdFKKGghBGwMK1
         NJvW5hdcddQXnhoi+eReTiBg+fteuSLmHmici8k3/0tUyvf5sf6IebIMFmtz9KlYE1+W
         LkKLFODQjL5WbUOmSYr8eN3/654C9wlbCW22U28jO8cbBEXfXPkYk7Zrsvf6RY4eaNrI
         T9WduuT8znu2vdTCAScS2NYYYFLOKzdsXszzLlKk+ciYsu/bDTtwWohelNF5gc9ZhAoJ
         w5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m64jqOrcIRXu/umTrAuoSeK+k4rXGOgELajP5IUVuyY=;
        b=Q1dwrmyFL5Vjc3nD+hEdPaekH7mgFSKaxQdw63sbWoUXUfazNxx8G0wORJDoWeu3Nn
         LvOVrpLBa1iKV751YIp5nFlLHWD6tqS5w8hFmRzm4N5hSxHcNu/F0JwvbmCC0EOteSMt
         nl3UwbGRYnK0C7ZDVxjbwUKBiRvCUuKPqI3nit7c5C61+nMkijFKqO7S0CffTFvvUyNZ
         /QD2UXwXjxsWmP9KLGPhcjoTBnX+bUToS1sfRUCl49rQerHwuk3coR9MH6br/gjm7Van
         kR/u+4Sr4qCk2b2Hq4Uuc0g8IiMsJdUZDmFzDbMgSGPx5vw5fJX/3GkvO45jYyMxe2Pj
         JQug==
X-Gm-Message-State: AO0yUKXlSBU0IxdsAk4Jdf/U2zWHG1NB4t34fB/8Wv9WXSoyyK9/pJXD
        d59bezKy6duE87VoN/9unYUsqg==
X-Google-Smtp-Source: AK7set+affTXRXYF+WjxSIHCwNBB1HL+mU8P7SPfTvPa4jKz5DlADUFtAeGVy2gHq4bQjiIgBCIxpA==
X-Received: by 2002:adf:efca:0:b0:2bf:b92b:8a8a with SMTP id i10-20020adfefca000000b002bfb92b8a8amr12679582wrp.7.1677179453910;
        Thu, 23 Feb 2023 11:10:53 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:53 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v11 6/8] sched/fair: Add sched group latency support
Date:   Thu, 23 Feb 2023 20:10:39 +0100
Message-Id: <20230223191041.577305-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223191041.577305-1-vincent.guittot@linaro.org>
References: <20230223191041.577305-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Task can set its latency priority with sched_setattr(), which is then used
to set the latency offset of its sched_enity, but sched group entities
still have the default latency offset value.

Add a latency.nice field in cpu cgroup controller to set the latency
priority of the group similarly to sched_setattr(). The latency priority
is then used to set the offset of the sched_entities of the group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++
 kernel/sched/core.c                     | 30 +++++++++++++++++++++++
 kernel/sched/fair.c                     | 32 +++++++++++++++++++++++++
 kernel/sched/sched.h                    |  4 ++++
 4 files changed, 76 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1b3ed1c3b3f1..c08424593e4a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1121,6 +1121,16 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.latency.nice
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	The nice value is in the range [-20, 19].
+
+	This interface file allows reading and setting latency using the
+	same values used by sched_setattr(2). The latency_nice of a group is
+	used to limit the impact of the latency_nice of a task outside the
+	group.
 
 
 Memory
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d5b7e237d79b..093cc1af73dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11059,6 +11059,25 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
+				    struct cftype *cft)
+{
+	return LATENCY_TO_NICE(css_tg(css)->latency_prio);
+}
+
+static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
+				     struct cftype *cft, s64 nice)
+{
+	int prio;
+
+	if (nice < MIN_LATENCY_NICE || nice > MAX_LATENCY_NICE)
+		return -ERANGE;
+
+	prio = NICE_TO_LATENCY(nice);
+
+	return sched_group_set_latency(css_tg(css), prio);
+}
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -11073,6 +11092,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency.nice",
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -11290,6 +11314,12 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency.nice",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 414b6243208b..dc7570f43ebe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12274,6 +12274,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_prio = DEFAULT_LATENCY_PRIO;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -12372,6 +12373,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = calc_latency_offset(tg->latency_prio);
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -12502,6 +12506,34 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
+int sched_group_set_latency(struct task_group *tg, int prio)
+{
+	long latency_offset;
+	int i;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+
+	if (tg->latency_prio == prio) {
+		mutex_unlock(&shares_mutex);
+		return 0;
+	}
+
+	tg->latency_prio = prio;
+	latency_offset = calc_latency_offset(prio);
+
+	for_each_possible_cpu(i) {
+		struct sched_entity *se = tg->se[i];
+
+		WRITE_ONCE(se->latency_offset, latency_offset);
+	}
+
+	mutex_unlock(&shares_mutex);
+	return 0;
+}
+
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
 void free_fair_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3f42f86105d4..9a2e71231083 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -378,6 +378,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency priority of the group. */
+	int			latency_prio;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -488,6 +490,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, int prio);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.34.1

