Return-Path: <cgroups+bounces-6581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3374A39132
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876C2188F147
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B31684AC;
	Tue, 18 Feb 2025 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE1oxPDC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727C18132A
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848514; cv=none; b=NkCjUi3UYZ3NgihnAuA94R+FJu7qfXYNhM+Ow8zVJ2Agr8MQHJXXxjzaTvYE6TeoaA2Fa8fqkQZmDnch+frGni0UWEiqk3NYivu2sA8dRpL6TDSpcUgEMtUPWVOWUw5MDPR806Mo5RxY/j611pZX6x+6Tc3dpnDRycjCqufbdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848514; c=relaxed/simple;
	bh=z2C3KB8rEFJR29xgX1pLE4DeDFfZxWCQY1djtwjftfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKrCPUkPRhCEbZTGBBUC3eqljWh+pcpwZ4+NJYdg4lTY1cz8nlvyOKmQ7rYbIW4JmfEV7yx1MSmO7fXf/3A4NRQbvRg9XGYBCW0JsusCxOx3kEIZ/4E1BhBiR/F8lFHzEJkjM7PtfjaHEHNj/9HFRxuJZtc85z6tp8Y8p8GCh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE1oxPDC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ecbdb4c2so96432065ad.3
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848512; x=1740453312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6fGNeZWtM3FGTNz/p/Bk400jphjU7NfeytH78W3bTI=;
        b=IE1oxPDCiCRyyHMWTtT7vOWy9SMbICCBDwijtEITyxKztuD5UVIyp2oLwlM8FsNddK
         KV8CJNdP6N/nIqL+iBB+Woc7zDX7urZGp4tR+diUJXROFhsQVeRaDd6NnJO4vqg82OXR
         DWj14Znk9SjQCQWlIXVJmL8r3GE6ijuspho8wI9OOxYrSIrsMGF2ockaYvGCMkCiTazH
         5Hh1V++CGe69XTVREKMx/9xRS2jLPx4HtfTIXIsZXUisBmWPVQd3WYx1yGgl3Y2Y9k4S
         zEXi1N8Kti43p1MADSGpGhuD4mN2b8FD2W48bqdUlBNyYc4+g/CxfBSIQFK+QfL3a5I3
         1dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848512; x=1740453312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6fGNeZWtM3FGTNz/p/Bk400jphjU7NfeytH78W3bTI=;
        b=YZoxkqxz0+f/fHk0o+6Rb6qjgSQwbzXBccD5N3XJntW9vSJliN1CON42fHJ9sBHy0h
         lHZM7pehnfB3I0p/YbXdjN3hg8prT8v4UxlwD/pDvMyhfd2xcQrQFuCkNWwwT5cSPdh8
         o77v8LF5c9i+vMKYKKUDocHQvDNXM2kibR4xwaO4S/z41FSZeHNMsTjr5w0d2D+fB46K
         ySkkm/aOSr/b+J6bD1xFlSddwakK4Mob4D2youEcF7vvbZG++KXiHCJLB4HWCZVs8Zo+
         Phc7DISIXdQVrPn9Lgcm2C55b30JY6yZR5Kjeb0TbP9Hq4vX2dPD8GWgxRFZIOg899eO
         xcqw==
X-Forwarded-Encrypted: i=1; AJvYcCUNofBsrU24g0i3CQjzfIJXLzPGgihGw+x8TWy1EddbM0FJPLMCRIgFabzeyPP6Q3c3I8CO4CpW@vger.kernel.org
X-Gm-Message-State: AOJu0YwxGH9knZ2RlckxkWCLzO36RWWqZCjptFwZ/ViLBn4Otegi/5qf
	GEzfMWDey5gBqbsRC/UFkNItKJCYCmHqgSYEd45wX/6kHemlUQgW
X-Gm-Gg: ASbGnctD+HBiDbqr5FZGmYHPAbpGJBZD1LP4tHS7tCGVasKIBtB2GBNDzvI42WvhtMB
	rUokeMip3xob7kxgULGcdbqu1jN2A75Fv2p3xkzvDDX9uPysx9A4874Q4537eyFJy6y2NkF2yx7
	vApuU+lxm/ocuynP6fHePgqk/R9YOmkkl9j2oCk6UK53nH0lUXZhLNy+o1/CIc6pvpLhwyI0Im/
	GUlQRqiyeM8fLzTw1I6TL7RQL1uU3K04214Lf0oOcM/jMv8H+t/3O/puZHVeXg2l8/+j+q1wRmV
	HOZCYWjlC2kFrVk3k3XYpv2UdESYNdiz6Lfh3gvEVhxsIzrqPoTl
X-Google-Smtp-Source: AGHT+IEdc2CfR68/O4SRSN2xNZsygVxwsIe5F71fhvH7zgtYBNKyQ2HCTgHwt2ieGZ7qbMGNDozeDQ==
X-Received: by 2002:a05:6a20:4323:b0:1ee:83b8:7c6b with SMTP id adf61e73a8af0-1ee8cc084demr18831160637.39.1739848512098;
        Mon, 17 Feb 2025 19:15:12 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:11 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 07/11] cgroup: fetch cpu-specific lock in rstat cpu lock helpers
Date: Mon, 17 Feb 2025 19:14:44 -0800
Message-ID: <20250218031448.46951-8-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock/unlock helper functions for per-cpu locks accept a cpu
argument. This makes them appear as if the cpu will be used as the
offset off of the base per-cpu pointer. But in fact, the cpu is only
used as a tracepoint argument. Change the functions so that the cpu is
also used primarily for looking up the lock specific to this cpu. This
means the call sites can be adjusted to not have to perform the offset
prior to calling this function. Note that this follows suit with other
functions in the rstat source - functions that accept a cpu argument
perform the per-cpu pointer lookup within as opposed to having clients
lookup in advance.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 26c75629bca2..4cb0f3ffc1db 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -115,7 +115,12 @@ static struct cgroup_rstat_ops rstat_bpf_ops = {
 #endif /* CONFIG_CGROUP_BPF */
 
 /*
- * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
+ * Helper functions for rstat per-cpu locks.
+ * @lock: pointer to per-cpu lock variable
+ * @cpu: the cpu to use for getting the cpu-specific lock
+ * @cgrp: the associated cgroup
+ * @fast_path: whether this function is called while updating
+ *	in the fast path or flushing in the NON-fast path
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments. The parameter @fast_path determine the
@@ -123,19 +128,20 @@ static struct cgroup_rstat_ops rstat_bpf_ops = {
  * operations without handling high-frequency fast-path "update" events.
  */
 static __always_inline
-unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
+unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *lock, int cpu,
 				     struct cgroup *cgrp, const bool fast_path)
 {
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(lock, cpu);
 	unsigned long flags;
 	bool contended;
 
 	/*
-	 * The _irqsave() is needed because cgroup_rstat_lock is
-	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-	 * this lock with the _irq() suffix only disables interrupts on
-	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-	 * interrupts on both configurations. The _irqsave() ensures
-	 * that interrupts are always disabled and later restored.
+	 * The _irqsave() is needed because the locks used for flushing
+	 * are spinlock_t which is a sleeping lock on PREEMPT_RT.
+	 * Acquiring this lock with the _irq() suffix only disables
+	 * interrupts on a non-PREEMPT_RT kernel. The raw_spinlock_t below
+	 * disables interrupts on both configurations. The _irqsave()
+	 * ensures that interrupts are always disabled and later restored.
 	 */
 	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
 	if (contended) {
@@ -156,10 +162,12 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
 }
 
 static __always_inline
-void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
+void _cgroup_rstat_cpu_unlock(raw_spinlock_t *lock, int cpu,
 			      struct cgroup *cgrp, unsigned long flags,
 			      const bool fast_path)
 {
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(lock, cpu);
+
 	if (fast_path)
 		trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
 	else
@@ -172,8 +180,6 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
 		struct cgroup_rstat_ops *ops)
 {
 	struct cgroup *cgrp;
-
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
 	/*
@@ -188,7 +194,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
 		return;
 
 	cgrp = ops->cgroup_fn(rstat);
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
+	flags = _cgroup_rstat_cpu_lock(&cgroup_rstat_cpu_lock, cpu, cgrp, true);
 
 	/* put @rstat and all ancestors on the corresponding updated lists */
 	while (true) {
@@ -216,7 +222,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
 		rstat = parent;
 	}
 
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
+	_cgroup_rstat_cpu_unlock(&cgroup_rstat_cpu_lock, cpu, cgrp, flags, true);
 }
 
 /**
@@ -315,14 +321,13 @@ static struct cgroup_rstat *cgroup_rstat_push_children(
 static struct cgroup_rstat *cgroup_rstat_updated_list(
 		struct cgroup_rstat *root, int cpu, struct cgroup_rstat_ops *ops)
 {
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
 	struct cgroup_rstat *head = NULL, *parent, *child;
 	struct cgroup *cgrp;
 	unsigned long flags;
 
 	cgrp = ops->cgroup_fn(root);
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
+	flags = _cgroup_rstat_cpu_lock(&cgroup_rstat_cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -359,7 +364,7 @@ static struct cgroup_rstat *cgroup_rstat_updated_list(
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu, ops);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
+	_cgroup_rstat_cpu_unlock(&cgroup_rstat_cpu_lock, cpu, cgrp, flags, false);
 	return head;
 }
 
-- 
2.48.1


