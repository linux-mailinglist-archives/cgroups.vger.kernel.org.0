Return-Path: <cgroups+bounces-6026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCB2A00284
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711CB7A1B42
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE5154C0F;
	Fri,  3 Jan 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuHifNbE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A91E49F
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869035; cv=none; b=mxeOgVF9b2RFcR1YyKHt1R2DFRjbaVpuzVuUmsqW+oLPVHZa+sx3CJpnqzak3+u96zQQvNW91pf1Q6HNy4BPzXOMbRTe/YsFHG/ojaEbaWK6dI0igCx68G8/2ZneLCROxfqmjeE0LXixV0gP1yhU0oR2V2uE0pFTgPRtlkI2DjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869035; c=relaxed/simple;
	bh=A3uDAoW3kGVXgPn1nSuP6/tST5tnt4fpL/tkp+TtbnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKKeos+Ue7U3Jnu8ymKZsL1newC0/v+x5DHP6LLl9T/+c6t7uregmxLhAGc2AQfT6Ox0wutzQcF5S7NDE1nMLHg883tVnAvAbWdJ3zYZ1r7Msk7Q3rCgzBfR+m1/MjibL9kDbLMi66uFXfdRcPyOqYw4ZaXgfESixiQ0eZt9DWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuHifNbE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so16582708a91.1
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869033; x=1736473833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgCq5Td2Z/AmRDTJOLyjzlVyZ7Vs1foFuhquS5rZUBM=;
        b=HuHifNbEJVody49R+IayZhlGGLACgjToFQsVc+25dqij04Q56//Qies8EoB01qUiGy
         lvatK+93S4FSdiruU9zF3yBvGs7DyewFhqJD7iJxOcf95mBNkRUDNg/ZBPb50le0nkpk
         /oRIkk2tfLI2V+AfGmIELbq5FVbi1CmNUmf/1t2SPgYXbMW62AMEdfqhKeBzXxZk7MZ3
         jK5SAJftQbSGo9xX3DTmSIym28hcO48FuunmwDm4Lw9Y+0Mx6nelQy3YhHR0STcPFn/M
         RMVNOSIY1s5bR/arMNvtKO4mmXpfqjIKYMQJhVADcM9HnRLoLNIDCPHfFB0NkV+xcKsI
         cBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869033; x=1736473833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgCq5Td2Z/AmRDTJOLyjzlVyZ7Vs1foFuhquS5rZUBM=;
        b=RSde1bePVqLNibHsAEruDjs7/xUtztreqq2QZd9FghmiXKWrCnC20QRHpJxiL5bDxL
         ld+uJv7oC3J69eth4r8b0yUpvavaA/Uaes1QTi3ExILg4JtUBAD8sJcLPMsNJE/HLUW/
         s/7SboTmLwGJgd7O19C/UWJZadC1zuW8sfKBp5x2eAdfsl5+wndAMQbPFBQMasXsMWSp
         GrkSUIJbx3n0PQuehlYmTs6Dir5Jxmimve3Z/V0kdCr0EE1qb14GB2soylpAyuXLwijU
         57fbpyQ+5wB+EVpUQGk23lC9FS1EasGaeMKfdmEmrYENFoIKnz3CMZYsZtmVYrgW2aAK
         AMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8R5haS4+rWR+RO9nFYnWt9pw0UmofKh/RsHRVtaGVdvZ9FKA/AhXGzr3mjwdtCaZxBB+ywkR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TcdHq/kZTSyicP8qzC1Cx0Ga/nPK55qroRYaVYwQ/JWBybXD
	95a7kjHqBtLho/BWo2rVoB6Fqg3HfdI0qR81nWaXxxHyKAN57fHe
X-Gm-Gg: ASbGnctvm0TRaBryIA8QCHEhzxYksYa9KXxAqZI3myK2rJO3Bnh7C3MuobRDbsGAGKw
	hr3BwVXWMgy2kH1xxqtL9e9F3YuAjoUmbfnMrgTv+D0hMibSIvG8LocyWOgU1nhTkMIkSwCpeS8
	9LAXqbm3P1ldyweRJirKWCo2yh7tx75QXO+zV1dzlgpa2GxkHDlA2fTmuGXUGSHG1dYONvmXywO
	CBZi5Wht3L+VNxURnX8CkGFGNBsmMKVm44Tk1Kla6ZEiBmP3ktJuGiD/4tDeZ6oBRpyP93nV+Bp
	FfdXrfhG4T+rd87OcQ==
X-Google-Smtp-Source: AGHT+IGkWtACbpMmHueLMAjxpHU9KrMkr+iF3LJPrQIgx8bENjfG+waIs+Dzt0sDPxQQ6X70fr4+hw==
X-Received: by 2002:a17:90a:e18f:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-2f452debd4fmr80002639a91.8.1735869033613;
        Thu, 02 Jan 2025 17:50:33 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:33 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 2/9 v2] cgroup: change cgroup to css in rstat internal flush and lock funcs
Date: Thu,  2 Jan 2025 17:50:13 -0800
Message-ID: <20250103015020.78547-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change internal rstat functions to accept a cgroup_subsys_state instead of a
cgroup.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 45 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1ed0f3aab0d9..1b7ef8690a09 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -201,8 +201,10 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
  * within the children list and terminated by the parent cgroup. An exception
  * here is the cgroup root whose updated_next can be self terminated.
  */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
+static struct cgroup *cgroup_rstat_updated_list(struct cgroup_subsys_state *root_css,
+				int cpu)
 {
+	struct cgroup *root = root_css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
 	struct cgroup *head = NULL, *parent, *child;
@@ -280,9 +282,11 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+static inline void __cgroup_rstat_lock(struct cgroup_subsys_state *css,
+				int cpu_in_loop)
 	__acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
 	bool contended;
 
 	contended = !spin_trylock_irq(&cgroup_rstat_lock);
@@ -293,15 +297,18 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
-static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
+static inline void __cgroup_rstat_unlock(struct cgroup_subsys_state *css,
+				int cpu_in_loop)
 	__releases(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
 	int cpu;
@@ -309,27 +316,27 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup *pos = cgroup_rstat_updated_list(css, cpu);
 
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup_subsys_state *css;
+			struct cgroup_subsys_state *css_iter;
 
 			cgroup_base_stat_flush(pos, cpu);
 			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
 			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos->rstat_css_list,
+			list_for_each_entry_rcu(css_iter, &pos->rstat_css_list,
 						rstat_css_node)
-				css->ss->css_rstat_flush(css, cpu);
+				css_iter->ss->css_rstat_flush(css_iter, cpu);
 			rcu_read_unlock();
 		}
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(cgrp, cpu);
+			__cgroup_rstat_unlock(css, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(css, cpu);
 		}
 	}
 }
@@ -349,13 +356,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
-
 	might_sleep();
 
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_lock(css, -1);
+	cgroup_rstat_flush_locked(css);
+	__cgroup_rstat_unlock(css, -1);
 }
 
 /**
@@ -370,11 +375,9 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 	__acquires(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = css->cgroup;
-
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	__cgroup_rstat_lock(css, -1);
+	cgroup_rstat_flush_locked(css);
 }
 
 /**
@@ -384,9 +387,7 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = css->cgroup;
-
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_unlock(css, -1);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
-- 
2.47.1


