Return-Path: <cgroups+bounces-6732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128AA48AEA
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D9716CE6B
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E4272911;
	Thu, 27 Feb 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHG74U0X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A271821
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693362; cv=none; b=uvfl1htrkF1vT8DU4/MCKjA7tDd3dqPSTfaJs+HrT83BniFaZYsgACJiT94r6wrMg9KFkJcFMBhBpXW1D0JCoMSt9lDlbi06ke/OipH+HPZQG39PR64jKiTbLsPkBJpF1XYLqLJk67OcqBuvoWxIKrqEXzKavl/1wwDzoKKp0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693362; c=relaxed/simple;
	bh=H45fQUpu2yYLERO0rcDLhbwER9fAYsxGG0zPViIYczU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIc94RE37/ct4SzJ5ivBJx35uowCyMfPWccQ1Eu+yMb7xH5JZu/RIoDn1EeiM7JuOQsXsbaIO3Np4I7UG4lIfx6HPKxNeuOz11yVhdulsuDMznDv682mmo/8/x04IlBKqol4vNTWUizwgtlq2dZTWSyEqJtWKKRU2LCJcZ63Eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHG74U0X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235908a30aso25506875ad.3
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693360; x=1741298160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG5vp9T1tPNWJYl4dV5u9R8irLnKVTPrFYBdhD+XKBw=;
        b=DHG74U0XLrm4DW22POHiO0tj0Bj/CR72NhsWNn4M1RpoMAdI5nbb6XIzHDAc/JiohB
         i+6NVT3enzDfuikYGBk4MBGa+h3dX8b6LN7mzTVAUaAWQQMFJnozi0JryJ5ZkXyhyrwE
         jmM+iWxuft2X7Fl6pq+Z822DPAZdQCIcAkyDspRP7qrpVS+zLqcL3kk7ZjM2dn2jBvSy
         YdnAMPeyJjtGceBNPDFI2jyn1V8jm0uVZDqPxKx7qhYoXpx4w853NksimoQmcClD1f3s
         r3/sRHTAfUhe3qOGucTgzAXrJEFpXTlAaky8EQKCjcQlzflvV6lKVYFVpXJx2vW8DFrW
         kDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693360; x=1741298160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG5vp9T1tPNWJYl4dV5u9R8irLnKVTPrFYBdhD+XKBw=;
        b=GBbg+u7PAmEu+8opjkcozCLdWo9Xc4CvNVrrZjUzxT+BFaQzL6uLRJTwzhD64EbOpY
         9efx2wZB/dB+41nbZNOjcqrpEQknt0Kx2if3Zexu0N+1reb6075GQ8VekM96vwTUJ8Eg
         pWGJ6FlLurxy6nViqSzyKoTzcg3Xfgrk/GvwV3Vln9CHK9JQTa7q+2/sEQ/bjSLkLg1d
         uJJrSmLyMTVX1VVosbpKkukKP5IdHKn9FHn2I2iDMincLH0dzeroUHkLfJxDiQvdTBGk
         jJ9xU/34uJO9h3ltNicVESD0NAJf7lEP/SBvzKonspAGBdKb8KoGDhC3eWLygS2i1k9d
         IZiA==
X-Forwarded-Encrypted: i=1; AJvYcCWxFR8uDS7ZCVkeSgGWfyYOLG0G14sW7OZeARX56Sw9ql9O+V//3ylL9j7vvknGQGsDThM/3uM3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/we0hxkL/q5pVdpmB2exaXroE/jN6WOCvhDZKVI5P/mezQCU5
	ZMxOpWyPqAP9+lvC499wMiioV3r2hOxYm1CEqhe+GFUde5nA86iK
X-Gm-Gg: ASbGnctUwzBRHDBS1lB7sh4djeYIcREkEHWCzDABfRMjYv6OOYGihn/oprrWkfq9lHe
	JUVNRvm36GdFCQ7GzTeSHlM3r8zC6SG2aEACFWGlnFY0j6cr19xz5QRm/Px9svqhlAYcC/sWPeB
	GuFEXcgHnnKRY20r5k8hPN4MNaA59GspyooHSjLD+zKPolN99BtOpE5wLSDE2qXnzuwyyxQjTpU
	1hN01jtcx/ArD8kKhf0doybBo9ZTdZH5jp+aYJOiluDyQw/aD6x2PuYRV97bmf205SfP7KnNJ7V
	lCLH2gbyylS4Losoj/AHLV/h1K2PEdCFemhErbE21NjexuCw0BdeVg==
X-Google-Smtp-Source: AGHT+IF+ODqFionKKWEwTTB+YdOdfH0lHB5SMuZxWTz9E/RuYeTRSAvL8fa3TKA7DBGZe3irBXJCIw==
X-Received: by 2002:a17:902:db0e:b0:223:619e:71da with SMTP id d9443c01a7336-2236921eb84mr13886465ad.49.1740693359918;
        Thu, 27 Feb 2025 13:55:59 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:4d60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb65sm2301321b3a.149.2025.02.27.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:55:59 -0800 (PST)
From: inwardvessel <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Date: Thu, 27 Feb 2025 13:55:42 -0800
Message-ID: <20250227215543.49928-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215543.49928-1-inwardvessel@gmail.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

Let the existing locks be dedicated to the base stats and rename them as
such. Also add new rstat locks for each enabled subsystem. When handling
cgroup subsystem states, distinguish between formal subsystems (memory,
io, etc) and the base stats subsystem state (represented by
cgroup::self) to decide on which locks to take. This change is made to
prevent contention between subsystems when updating/flushing stats.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 93 +++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 88908ef9212d..b3eaefc1fd07 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,8 +9,12 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(cgroup_rstat_lock);
-static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static DEFINE_SPINLOCK(cgroup_rstat_base_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock);
+
+static spinlock_t cgroup_rstat_subsys_lock[CGROUP_SUBSYS_COUNT];
+static DEFINE_PER_CPU(raw_spinlock_t,
+		cgroup_rstat_subsys_cpu_lock[CGROUP_SUBSYS_COUNT]);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -20,8 +24,13 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
 	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
+static inline bool is_base_css(struct cgroup_subsys_state *css)
+{
+	return css->ss == NULL;
+}
+
 /*
- * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
+ * Helper functions for rstat per CPU locks.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments. The parameter @fast_path determine the
@@ -36,12 +45,12 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
 	bool contended;
 
 	/*
-	 * The _irqsave() is needed because cgroup_rstat_lock is
-	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-	 * this lock with the _irq() suffix only disables interrupts on
-	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-	 * interrupts on both configurations. The _irqsave() ensures
-	 * that interrupts are always disabled and later restored.
+	 * The _irqsave() is needed because the locks used for flushing are
+	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring this lock
+	 * with the _irq() suffix only disables interrupts on a non-PREEMPT_RT
+	 * kernel. The raw_spinlock_t below disables interrupts on both
+	 * configurations. The _irqsave() ensures that interrupts are always
+	 * disabled and later restored.
 	 */
 	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
 	if (contended) {
@@ -87,7 +96,7 @@ __bpf_kfunc void cgroup_rstat_updated(
 		struct cgroup_subsys_state *css, int cpu)
 {
 	struct cgroup *cgrp = css->cgroup;
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	raw_spinlock_t *cpu_lock;
 	unsigned long flags;
 
 	/*
@@ -101,6 +110,12 @@ __bpf_kfunc void cgroup_rstat_updated(
 	if (data_race(cgroup_rstat_cpu(css, cpu)->updated_next))
 		return;
 
+	if (is_base_css(css))
+		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
+	else
+		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
+			css->ss->id;
+
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
 	/* put @css and all ancestors on the corresponding updated lists */
@@ -208,11 +223,17 @@ static struct cgroup_subsys_state *cgroup_rstat_updated_list(
 		struct cgroup_subsys_state *root, int cpu)
 {
 	struct cgroup *cgrp = root->cgroup;
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
 	struct cgroup_subsys_state *head = NULL, *parent, *child;
+	raw_spinlock_t *cpu_lock;
 	unsigned long flags;
 
+	if (is_base_css(root))
+		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
+	else
+		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
+			root->ss->id;
+
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
@@ -315,7 +336,7 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
 	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_lock);
+	lockdep_assert_held(&lock);
 
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos;
@@ -356,12 +377,18 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
 	struct cgroup *cgrp = css->cgroup;
+	spinlock_t *lock;
+
+	if (is_base_css(css))
+		lock = &cgroup_rstat_base_lock;
+	else
+		lock = &cgroup_rstat_subsys_lock[css->ss->id];
 
 	might_sleep();
 
-	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
-	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
-	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
+	__cgroup_rstat_lock(lock, cgrp, -1);
+	cgroup_rstat_flush_locked(css, lock);
+	__cgroup_rstat_unlock(lock, cgrp, -1);
 }
 
 /**
@@ -376,10 +403,16 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
 	struct cgroup *cgrp = css->cgroup;
+	spinlock_t *lock;
+
+	if (is_base_css(css))
+		lock = &cgroup_rstat_base_lock;
+	else
+		lock = &cgroup_rstat_subsys_lock[css->ss->id];
 
 	might_sleep();
-	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
-	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
+	__cgroup_rstat_lock(lock, cgrp, -1);
+	cgroup_rstat_flush_locked(css, lock);
 }
 
 /**
@@ -389,7 +422,14 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
 	struct cgroup *cgrp = css->cgroup;
-	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
+	spinlock_t *lock;
+
+	if (is_base_css(css))
+		lock = &cgroup_rstat_base_lock;
+	else
+		lock = &cgroup_rstat_subsys_lock[css->ss->id];
+
+	__cgroup_rstat_unlock(lock, cgrp, -1);
 }
 
 int cgroup_rstat_init(struct cgroup_subsys_state *css)
@@ -435,10 +475,21 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 
 void __init cgroup_rstat_boot(void)
 {
-	int cpu;
+	struct cgroup_subsys *ss;
+	int cpu, ssid;
 
-	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+	for_each_subsys(ss, ssid) {
+		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
+	}
+
+	for_each_possible_cpu(cpu) {
+		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
+
+		for_each_subsys(ss, ssid) {
+			raw_spin_lock_init(
+					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);
+		}
+	}
 }
 
 /*
-- 
2.43.5


