Return-Path: <cgroups+bounces-6940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A536A59BF3
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE631889F70
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513123314B;
	Mon, 10 Mar 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HB8MzNc0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D379230BE3
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626306; cv=none; b=kNLrTH0S6VSZHqNVoqmTOLN+n5DKhtGSL/B+Ff6BtqQNsZmxXjm9nojoUlgNigw87jfQx90vyLs0TkUsBTb+JYYlMx6PvcDAU3obz1AKmvEgTdPbq/ej2JkKf4GrK15aG2S5kLfCqIdhyKk2EqA+c+XYglj+6lRpRTL2x0LLH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626306; c=relaxed/simple;
	bh=vRXJ9uOsy6Io5CIxOYOD8ydZyDCFHZfM3eEnQt7c5sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxD3sTQtppnJBpuLV8BBjxFNV8tieFcVv+KDdnqvMw6helI27AsFTbazWXgqbGkkuFSEbOgEZBTtAkwE6Ht/F10X9/p0rcZPnKWYobWE/+o+b4KiMyoNQYOEknqoIIJUyAxa8yoJQ97eZeWnhiD4Es2xMFCXlPc2FbqNwoYtTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HB8MzNc0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso18009905e9.2
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626302; x=1742231102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnS8Fb21gYaFTzUKkHBeeupETZBcyFIfLsl4jvQZsEE=;
        b=HB8MzNc0vyFxUhNiAfjeT2JRliOlnrWDAUrLyF6sRgeaNTdRfT60fyyP5CdIX1c7nF
         VbRfgoJx6pQc93Ft6BlGaCeUqKJvPCpk25QBD5D9aQ91JSZxvEiYb5feSOj8O96Cc5fv
         Vlb4ylVwKCnximn3NbaoZ8CmrlE83GPgOHkZglVJAd/VTAyDr2wzCd+dEEpS0k0JWN3+
         r5DDVIBsCSd+W99WqyTZfrCgaYoaI/UfMwifvInK2qK7cmP/P8TR26RQASI5s+G6qXCh
         e5OKY390h7Mv8D/1Gi9SkmKZqAurCjwy9Ee1ijf/ISvrrpBgwuR9HKOxWuibgMcWZ3qD
         Nv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626302; x=1742231102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnS8Fb21gYaFTzUKkHBeeupETZBcyFIfLsl4jvQZsEE=;
        b=LM2BHE0Uz32KW68Zhk3GwWoLOhzu47mKx306e0qDxzOFbAYGX0FwnoGNQyPM0tDKSi
         Vv0n6mVmuzDBV/UVmQ7T/kxih/fnzcSENwILeBaHCOXmr5/Vlv0XrFbd0h/oHEEgBuEG
         Ei4OivBJJR+QxxA80cHN2jESeEvnBJ/hJiqXetnPvJoMGEkqrpMQpRGt+vejAodSbdSS
         VFNFEFW13wo8mm5cAAYHtugiP4JYnRjccWgEQck4y/S3v7IurXxPX/XyiwWLDqqqzpOC
         NQDKHVZQ6VR8EXItP42gJUxN8Ov0pHA+8E2Gl48YYN4t2iFf7DekIbZprkz+McWBidYJ
         wptQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMLeAV0ye+ZFJS76ApLXQXuAoB9SfgXxyrHlT41+MT12rVrdtBybpbwrVCCdKiF9qEHJFst9eb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0R9+3s+t+rxlLdGpfQaFv18fjngE0jUvXptRXaTgC0V3ItDK
	qN72/3F9YbSq61hf/WTJJP0GyT9vIiULlv+mBX+/aINUFW98jodstFEnBv9/GbY=
X-Gm-Gg: ASbGnctoh4YwCWxxRDLROj44pDycpQu+9AQAj/xJFtQL05yAOReYs1RxiZrGVEGIIqE
	kSR1HFRtJtB64KgrcLtw+j99An+fZG1y5W7JbNMm655pbkYL8akDVX106uUEpYIQN5EFy+Iz37y
	JIsWI/fXzyJQepQIY6cUzg0ZAWU719QOhiRart6h5Yfo03UHaldzzWeaYrCNyf8CIXGamRmrurf
	qCcIMMdaPxdtpI7J6oKbNttiEhWjcCaqgnTIRFp/FcwM/2hxL7fOWoF94r6musMtk07xtzpBd7F
	+Jmf1jJFTdkb5qflzbQZvivBLbWR9/al4rUhi6H6WVBGc+Q=
X-Google-Smtp-Source: AGHT+IF0OGZqoq6RwuNzak2w/irNE5ETyBPEb/aCYUD1mY+IM+doxWcqUB1WAHbBBc6Lw3aP2WuzVw==
X-Received: by 2002:a5d:64c7:0:b0:391:11b:c7e9 with SMTP id ffacd0b85a97d-39132d6011emr11818862f8f.28.1741626302086;
        Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:01 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 04/10] sched: Add commadline option for RT_GROUP_SCHED toggling
Date: Mon, 10 Mar 2025 18:04:36 +0100
Message-ID: <20250310170442.504716-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
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
index fb8752b42ec85..6f734c57e6ce2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6235,6 +6235,11 @@
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
index 4dbc059d2de5c..5461e232d325a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1079,6 +1079,17 @@ config RT_GROUP_SCHED
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
index 165c90ba64ea9..e6e072e618a00 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9852,6 +9852,31 @@ static struct cftype cpu_legacy_files[] = {
 	{ }	/* Terminate */
 };
 
+#ifdef CONFIG_RT_GROUP_SCHED
+# ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
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
index 4453e79ff65a3..e4f6c0b1a3163 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1508,6 +1508,23 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 }
 
 #endif /* !CONFIG_SCHED_CORE */
+#ifdef CONFIG_RT_GROUP_SCHED
+# ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
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
+# endif /* CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED */
+#else
+# define rt_group_sched_enabled()	false
+#endif /* CONFIG_RT_GROUP_SCHED */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
-- 
2.48.1


