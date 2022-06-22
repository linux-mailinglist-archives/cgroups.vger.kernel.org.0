Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51E554048
	for <lists+cgroups@lfdr.de>; Wed, 22 Jun 2022 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiFVB4J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 21:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiFVB4I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 21:56:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D7F30544
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 18:56:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c205so8007045pfc.7
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 18:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8l0sHLsI5nt4bCI9BzXsB64fMhOx0Yd7NKy6ByuMOqg=;
        b=RhuQIzEeWjGxYVLOfnWJ9uW6hf9PpTO+gr3LP0FQEMCwSoXrD9Ekkz1KtgGCc4K+eg
         aenMB9VbXhAKOxEAcESN6OoWbGSMHKolLvOYSkv4E+KsMOMhiDFogbpqI2f82mejinFt
         y/asp8JUIri/lYrodGrAk/6R0fZH+F/O4K+U/pVeFi21qN/8TlA1RpHDrABgY5OYD53T
         40YG1BebjLQrNHIXvnnLRqAtWxAl/xVb7d3SEBmSTyhJLBIcj6Ili+L9MtIx/nFXEU2J
         TKUp26kr2M4G2QfCDrlYx7lwoJ1bc2kwISGKrJBvLKEQyp5oMARbRVS+3Vw3nN3zIHig
         pBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8l0sHLsI5nt4bCI9BzXsB64fMhOx0Yd7NKy6ByuMOqg=;
        b=upYPfisSvKth6pjLoXum4Y0yvuhuBXv4k/3uOy+E3JsTSUJgnoGOAVpYHWHoboIZVr
         8SLLdotkaCQjGucr/abQdbllAusSRd6DcWGeM2ZmsUSL0m4WKbgOLa8lJeBaYq6XYfVe
         QehkFNq7LrNmgxdYbHQIsALlUqlxJh9ByNjh9Xmqr3x1+s7lrcI0mHm4OK5369AjHqyP
         9ydwCz5+4B5N8m6OXDsqTHojGZGJOgOgveXSEUnabyvkAsV8QM3A7vN5CwEHsA59SWB3
         lh+ufqppEbaVmT/Eml8EkFEvZhevjKcLA1qZCB2wl8l3JycNBzshES8plIrq5xDyKEBo
         Z6jg==
X-Gm-Message-State: AJIora9M/3IQCeB3I+kNjPk/+JI7pVjUYteXiVNnyOUhItrXn3VhdKc0
        ySX3W3lXC9uXIXpjNw5VlttBrw==
X-Google-Smtp-Source: AGRyM1v3+OZcWzqhC2OKd9TlPEvdYWhsz42Lgd/bJA4Jab5KpsVkDnzWqGAK++a76s+nAkFbYeW/0w==
X-Received: by 2002:a63:6943:0:b0:40c:3020:d0b with SMTP id e64-20020a636943000000b0040c30200d0bmr854124pgc.34.1655862967459;
        Tue, 21 Jun 2022 18:56:07 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7924f000000b0050dc76281d3sm12250713pfp.173.2022.06.21.18.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:56:06 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rdunlap@infradead.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] sched: RT bandwidth interface for cgroup unified hierarchy
Date:   Wed, 22 Jun 2022 09:55:57 +0800
Message-Id: <20220622015557.7497-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We need to run RT threads in cgroup unified hierarchy, but we can't
since the default rt_bandwidth.rt_runtime of non-root task_group is 0
and we haven't interface to update it.

This patch add RT bandwidth interface "cpu.max.rt" and update the
documentation accordingly.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - minor fix for documentation per Randy's review. Thanks.
---
 Documentation/admin-guide/cgroup-v2.rst | 13 +++++++++++
 kernel/sched/core.c                     | 31 +++++++++++++++++++++++++
 kernel/sched/rt.c                       |  2 +-
 kernel/sched/sched.h                    |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 176298f2f4de..3d67366c99e1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1055,6 +1055,19 @@ All time durations are in microseconds.
 
 	The burst in the range [0, $MAX].
 
+  cpu.max.rt
+	A read-write two-value file which exists on all cgroups when
+	CONFIG_RT_GROUP_SCHED is enabled, to control CPU bandwidth for
+	RT threads in the task group.
+
+	The maximum bandwidth limit.  It's in the following format::
+
+	  $MAX $PERIOD
+
+	which indicates that RT threads in the group may consume up to
+	$MAX in each $PERIOD duration.  "max" for $MAX indicates no
+	limit.  If only one number is written, $MAX is updated.
+
   cpu.pressure
 	A read-write nested-keyed file.
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daadedc78fd9..c16f8cc5de08 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11047,6 +11047,30 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 }
 #endif
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static int cpu_max_rt_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	cpu_period_quota_print(sf, sched_group_rt_period(tg), sched_group_rt_runtime(tg));
+	return 0;
+}
+
+static ssize_t cpu_max_rt_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct task_group *tg = css_tg(of_css(of));
+	u64 period = sched_group_rt_period(tg);
+	u64 runtime;
+	int ret;
+
+	ret = cpu_period_quota_parse(buf, &period, &runtime);
+	if (!ret)
+		ret = tg_set_rt_bandwidth(tg, period, runtime);
+	return ret ?: nbytes;
+}
+#endif
+
 static struct cftype cpu_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -11082,6 +11106,13 @@ static struct cftype cpu_files[] = {
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
 #endif
+#ifdef CONFIG_RT_GROUP_SCHED
+	{
+		.name = "max.rt",
+		.seq_show = cpu_max_rt_show,
+		.write = cpu_max_rt_write,
+	},
+#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..319ce586446f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2819,7 +2819,7 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
 	return ret;
 }
 
-static int tg_set_rt_bandwidth(struct task_group *tg,
+int tg_set_rt_bandwidth(struct task_group *tg,
 		u64 rt_period, u64 rt_runtime)
 {
 	int i, err = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7b19a72408b1..317480d535b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -486,6 +486,7 @@ extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
 		struct sched_rt_entity *parent);
+extern int tg_set_rt_bandwidth(struct task_group *tg, u64 rt_period, u64 rt_runtime);
 extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us);
 extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
-- 
2.36.1

