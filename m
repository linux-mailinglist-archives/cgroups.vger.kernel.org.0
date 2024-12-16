Return-Path: <cgroups+bounces-5924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0DE9F3A99
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F156C18812F1
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB91D7992;
	Mon, 16 Dec 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VhRkQidi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEA1D5AC6
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380002; cv=none; b=GUUDHb52h9mhqoEMc9dfU79gX0VDRURGtQ1G2atow97LsMK1Ft+/ERrEY3ceSeX4wNgc/MCi7xIDxZ9J5V4MCo0U12brCTr2X434cV6npy9poE//FgiaHKR5et6VspsnKKaayY+PkMPufGRIfF9vqcS29W6RItiob0Psad7YtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380002; c=relaxed/simple;
	bh=kgkb/U2cImJvjDQzwb8/y9+msWpDFa2mSq28GSAc/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBntIvsiSsTfeosfunqVa3JevZpePN/t5duCMof8tjG5/Bxa/xl8qPeds72VR8x1LOxX6UxTO5/Ol4EEWuv2KR7bAxGrtvDuPfAq+KRQX+KFtujzPGRbCoJKWfRXnliaY0bj2td5cqqMEiIKO5F9frb5EesTPaJF0oHrb3NMfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VhRkQidi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43634b570c1so20229155e9.0
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379996; x=1734984796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcO2b6bGyel//lc1A0Ez4rBVc7IGRT8q21dTkVTikaM=;
        b=VhRkQidiGWPYcJ9IIIzhgYGLRKgM2w4nOb14HB5O/N9dGsfwmKuDtdGxxwFQ/fjG31
         RzDjrNz/TPkcarDFKOGwwrlfmmHIOagcUITIoxRhX2aenUXQMS7q+s1OEJ8ZAIaDSbff
         I0zVFMddEEGwYUN6DzKqxB/bX/tShF7p5nkcxWeqU2jND/ztxbA+23K8JEoyP5u6LY+l
         dqYwaMmEkR03fZYlitifcaNXIJUV0pPGZlBT7sMDM5jujBP5PxBxefxHrjR6KqdPFg+r
         /FrCuEOmwZoq9GX841roG0ByncxjA7S22mQSh/1gbod2NHdkT0muodD5U2N7s0UuJocd
         1fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379996; x=1734984796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcO2b6bGyel//lc1A0Ez4rBVc7IGRT8q21dTkVTikaM=;
        b=wtk5YGhXG2fVacfI8IXx2hnVPOpN9q4tW65rJXyAHZP4vsiCAlQSuoZH5UM/rg0qr5
         NbiWJyXz+rRV8YneWbRFTsAZNCLwuZ8FDWuFhWvcPLfbpnPjOBfyO3M/rvDiMbBYlLV9
         wIaHRZdCp+U8zRkoJrrnmZO4Hck/9MuXZWbnrMDHzK/3DFwpZ0/JRFO6KmpEc+IlczpA
         Em2jahs4JdOFRePBjEzXDzmh89a1O4uDKYok5hiHMJH4lcdGVnmDCms4O1Ze+Escodxf
         ZN0bIARU2l87rRRnkwnvGpbv/SBp56sTNlu7K25IKpyn+QaiNviUHgLSGXAHzey4xPhj
         TAsg==
X-Gm-Message-State: AOJu0Yz0j0kIYfbG57ao5X6Qxlq8vHyz/ap4RqmlO95Mw5p/IcppeEan
	JLH4e3ICqAiRt2/7xb8W7mdo2Rru83YgmMDx0FRbf6+y4u/WKa1/PQvUe2mJdRTrcrB2+lUSiC1
	O
X-Gm-Gg: ASbGncvoaQ+ctV6QWFbIDD+kQnYPqoWuAdMvuuUaZirLhRAoxgRWPTOI04HNSR2sUv7
	NQ3kjPk/8pZjIOGh4zzQ8t/ukgWD/YKy8x05sVD+dPR5Yi/06fZFLLkqYoudkqktBR+Xw2LDJLN
	1DhnssJEXtTCS/drocu5ou/3FSrWvLqWWLD86n9q6qDc8R1a9jPZ/gLpRkEYe3Nmk3ls1pSy9Ls
	tSAVQaFc8VA6InQl5Wm5LINOihkKkt6cHeudorFvSvNHkcilLTx996Afg==
X-Google-Smtp-Source: AGHT+IE1+7v6rC9j0mpAzs7abmQ8Ecbmx3mX7nPYgbcuKpdGXUfmDxdl7UNMEdc42gIrM1YtJroZEA==
X-Received: by 2002:a05:600c:1da1:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-4362aa4386dmr122477995e9.11.1734379996481;
        Mon, 16 Dec 2024 12:13:16 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:16 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 4/9] sched: Add commadline option for RT_GROUP_SCHED toggling
Date: Mon, 16 Dec 2024 21:13:00 +0100
Message-ID: <20241216201305.19761-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only simple implementation with a static key wrapper, it will be wired
in later.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 init/Kconfig                                  | 11 ++++++++
 kernel/sched/core.c                           | 25 +++++++++++++++++++
 kernel/sched/sched.h                          | 17 +++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d6..1c890c9ad8716 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5937,6 +5937,11 @@
 			Memory area to be used by remote processor image,
 			managed by CMA.
 
+	rt_group_sched=	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
+			when CONFIG_RT_GROUP_SCHED=y. Defaults to
+			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
+			Format: <bool>
+
 	rw		[KNL] Mount root device read-write on boot
 
 	S		[KNL] Run init in single mode
diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0fb..7823e5ac0311d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1076,6 +1076,17 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
+config RT_GROUP_SCHED_DEFAULT_DISABLED
+	bool "Require boot parameter to enable group scheduling for SCHED_RR/FIFO"
+	depends on RT_GROUP_SCHED
+	default n
+	help
+	  When set, the RT group scheduling is disabled by default. The option
+	  is in inverted form so that mere RT_GROUP_SCHED enables the group
+	  scheduling.
+
+	  Say N if unsure.
+
 config EXT_GROUP_SCHED
 	bool
 	depends on SCHED_CLASS_EXT && CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6d8232ad9eea..47898f895a5a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9844,6 +9844,31 @@ static struct cftype cpu_legacy_files[] = {
 	{ }	/* Terminate */
 };
 
+#ifdef CONFIG_RT_GROUP_SCHED
+# ifdef RT_GROUP_SCHED_DEFAULT_DISABLED
+DEFINE_STATIC_KEY_FALSE(rt_group_sched);
+# else
+DEFINE_STATIC_KEY_TRUE(rt_group_sched);
+# endif
+
+static int __init setup_rt_group_sched(char *str)
+{
+	long val;
+
+	if (kstrtol(str, 0, &val) || val < 0 || val > 1) {
+		pr_warn("Unable to set rt_group_sched\n");
+		return 1;
+	}
+	if (val)
+		static_branch_enable(&rt_group_sched);
+	else
+		static_branch_disable(&rt_group_sched);
+
+	return 1;
+}
+__setup("rt_group_sched=", setup_rt_group_sched);
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 static int cpu_extra_stat_show(struct seq_file *sf,
 			       struct cgroup_subsys_state *css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38325bd32a0e0..1c457dc1472a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1501,6 +1501,23 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 }
 
 #endif /* !CONFIG_SCHED_CORE */
+#ifdef CONFIG_RT_GROUP_SCHED
+# ifdef RT_GROUP_SCHED_DEFAULT_DISABLED
+DECLARE_STATIC_KEY_FALSE(rt_group_sched);
+static inline bool rt_group_sched_enabled(void)
+{
+	return static_branch_unlikely(&rt_group_sched);
+}
+# else
+DECLARE_STATIC_KEY_TRUE(rt_group_sched);
+static inline bool rt_group_sched_enabled(void)
+{
+	return static_branch_likely(&rt_group_sched);
+}
+# endif /* RT_GROUP_SCHED_DEFAULT_DISABLED */
+#else
+# define rt_group_sched_enabled()	false
+#endif /* CONFIG_RT_GROUP_SCHED */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
-- 
2.47.1


