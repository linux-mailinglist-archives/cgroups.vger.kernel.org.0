Return-Path: <cgroups+bounces-6578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF18A3912F
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C777A22ED
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8220EB;
	Tue, 18 Feb 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCDsTfxO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418314831E
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848509; cv=none; b=NL9MUKL9Lh/lUhlVXGM5ZnSgabNQ+D/rIRFX0sOA2dB8fTEX/zprxB20KMUVFqIKZcQDFhstlWxZbowpoPogmqzoddZmFWmpYVBpDl5hXQMgR9JK9xF7Jlp0zBHyKFLYo2HfstIjfMovJotc6LptNLQF0PlMwqJWjjPvl/L79gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848509; c=relaxed/simple;
	bh=VoVX6MNR+emAy0o61YG8GJ1aMk5sBTbwVC0nZt2LFVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbUecBwfMS+JmqKbf2lgMQLBZF5hwsZNzol48o9x8SZzBoIQDbhDMX8RpbOUFkfjQ85PzBtEZSDO85zXnIsgsJNODRd1GUZfU9xSDIaFBaCIchT5yCeAnBr2S/i+1HRdMh0sjTCzeMutH1dvlelmI76TQSqTsQKh/8QGJVZO/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCDsTfxO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa48404207so10005427a91.1
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848507; x=1740453307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAioZutszBaS0Z/YoqfTJqqVrbVraKzr8HB8FcWf8VM=;
        b=PCDsTfxOJ1fOP+9s3PJ06vq5Ks4U2T9nvULYgZ2eUhdqS9N3rCMmq/SS5eAZprkwzt
         gTiMF8MTQWfpvS/XbCnVjlHvnz1Da/usX7+SnCobNN8uBsx6r5o1zhNBU8UU2UfwvL2Y
         gBcS6cLptfbq22klp7tPDvD5mmUsL/vujJnDzhaVML9h7lfNHvOlEvLqTLBKAvseU4Pg
         LO1IkHGEiuBQ8xSmM/LfbEoMwWiwzo/W7lZJYaMDwDpawqm7Efz5CKNbkIcbM/eDI8fy
         aqrDeYiJ/wfWwCmYGYvQVu6UUcQYVCgEVBp/occUFkwvCItnds0UAaIiVxaIyOMD5WuI
         pUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848507; x=1740453307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAioZutszBaS0Z/YoqfTJqqVrbVraKzr8HB8FcWf8VM=;
        b=CVk9vuQ5aj5AW2McDznXPyQ/dYh98l9Qmgs9eGtcpX8bHEFQ1PV5a77jqRLlaePDR5
         /Urmkg61belHcmE+SnNq1diwhyMv2qosir5xdtYD7MaxdMSen/KYaY8Pn+Z1DLwFu/Gb
         CrZQxgApFTHw8bp8umDcMprjvuYwdukI/g6+IBjUBUfWH7vlYv1sp5/bvx9JLSaN/Fe4
         zVYQtviwwQlVXgghANjkLjk/9MuPw7rnW1PXG/0GDrr8zVWvfIjkY6BlXI8mmNW4bn6p
         c5JMA0KROKDSLACjIbwsqeHG9lRfji8S8oGeTmyjnF5NXJ0QcVDtLwQbMnjdD8x36+je
         4uew==
X-Forwarded-Encrypted: i=1; AJvYcCU9vUaCl+SH/IZSySXW1NRPONsut4A0qBpSi3kelRHmeVvj5kkQ3mvp2WfVm13rpZI5ZxTWbsHF@vger.kernel.org
X-Gm-Message-State: AOJu0YyEApY9iWIETWLAEmjbE9Rog185DbKfCX7T3fgRGaYLDP6i+/YG
	M6GMFEm0yrSSgYwnnkPxFJ5Ct3xVmfs4ti6TouKtifd/VUvqMZSS
X-Gm-Gg: ASbGncvnxmRf3i9cQiHJsujocvbZGjtuDD+gn3PoZmoEBblWBcUTKXD584Hwnsj1hJn
	smpj0gHuZ2I1nk8awk90Cp4lD4pmafHMF2ri6YhCG2vsTvGg7sYOGonRPdGdqULP6JjHViI6jwC
	AiZyxEJbmMkPBLQCR0F2fO3mie4EVP5Dm+BWu1dvJb01lrzWjI2cG1q72QgpNMFyDEItg+feWPk
	tNSNlQjFivDexYrhHukGa24tg7bY7c2yx+3P4ISN4RM0gDlZ3Qa6JpeiprdzCcdm4JWp7j/SSHd
	aQP7egJpfyQQaguF8xOuD5xwRetkfa6/R9K6vzzGYOaJXGmG0O1P
X-Google-Smtp-Source: AGHT+IHo+onZRqN7Qw0BKGqYOQIOyp+AShjQ0rjEZCDEjA45rubie5vL5mfqBgXSfDiXivgdQ4eXKg==
X-Received: by 2002:aa7:8893:0:b0:730:a40f:e6dc with SMTP id d2e1a72fcca58-732618f3469mr19540551b3a.23.1739848506699;
        Mon, 17 Feb 2025 19:15:06 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:06 -0800 (PST)
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
Subject: [PATCH 04/11] cgroup: introduce cgroup_rstat_ops
Date: Mon, 17 Feb 2025 19:14:41 -0800
Message-ID: <20250218031448.46951-5-inwardvessel@gmail.com>
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

The cgroup_rstat_ops interface provides a way for type-specific
operations to be hidden from the common rstat operations. Use it to
decouple the cgroup_subsys_type from within the internal rstat
updated/flush routines. The new ops interface allows for greater
extensibility in terms of future changes. i.e. public updated/flush
api's can be created that accept a arbitrary types, as long as that type
has an associated ops interface.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 131 +++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 46 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a32bcd7942a5..a8bb304e49c4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,6 +9,12 @@
 
 #include <trace/events/cgroup.h>
 
+struct cgroup_rstat_ops {
+	struct cgroup_rstat *(*parent_fn)(struct cgroup_rstat *);
+	struct cgroup *(*cgroup_fn)(struct cgroup_rstat *);
+	void (*flush_fn)(struct cgroup_rstat *, int);
+};
+
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
@@ -19,7 +25,17 @@ static struct cgroup_rstat_cpu *rstat_cpu(struct cgroup_rstat *rstat, int cpu)
 	return per_cpu_ptr(rstat->rstat_cpu, cpu);
 }
 
-static struct cgroup_rstat *rstat_parent(struct cgroup_rstat *rstat)
+static inline bool is_base_css(struct cgroup_subsys_state *css)
+{
+	/* css for base stats has no subsystem */
+	if (!css->ss)
+		return true;
+
+	return false;
+}
+
+static struct cgroup_rstat *rstat_parent_via_css(
+		struct cgroup_rstat *rstat)
 {
 	struct cgroup_subsys_state *css = container_of(
 			rstat, typeof(*css), rstat);
@@ -30,6 +46,33 @@ static struct cgroup_rstat *rstat_parent(struct cgroup_rstat *rstat)
 	return &(css->parent->rstat);
 }
 
+static struct cgroup *rstat_cgroup_via_css(struct cgroup_rstat *rstat)
+{
+	struct cgroup_subsys_state *css =
+		container_of(rstat, struct cgroup_subsys_state, rstat);
+
+	return css->cgroup;
+}
+
+static void rstat_flush_via_css(struct cgroup_rstat *rstat, int cpu)
+{
+	struct cgroup_subsys_state *css = container_of(
+			rstat, typeof(*css), rstat);
+
+	if (is_base_css(css)) {
+		cgroup_base_stat_flush(css->cgroup, cpu);
+		return;
+	}
+
+	css->ss->css_rstat_flush(css, cpu);
+}
+
+static struct cgroup_rstat_ops rstat_css_ops = {
+	.parent_fn = rstat_parent_via_css,
+	.cgroup_fn = rstat_cgroup_via_css,
+	.flush_fn = rstat_flush_via_css,
+};
+
 /*
  * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
  *
@@ -84,11 +127,11 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 }
 
-static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
+static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
+		struct cgroup_rstat_ops *ops)
 {
-	struct cgroup_subsys_state *css = container_of(
-			rstat, typeof(*css), rstat);
-	struct cgroup *cgrp = css->cgroup;
+	struct cgroup *cgrp;
+
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -103,12 +146,13 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
 	if (data_race(rstat_cpu(rstat, cpu)->updated_next))
 		return;
 
+	cgrp = ops->cgroup_fn(rstat);
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
 	/* put @rstat and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct cgroup_rstat_cpu *rstatc = rstat_cpu(rstat, cpu);
-		struct cgroup_rstat *parent = rstat_parent(rstat);
+		struct cgroup_rstat *parent = ops->parent_fn(rstat);
 		struct cgroup_rstat_cpu *prstatc;
 
 		/*
@@ -145,7 +189,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
  */
 __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	__cgroup_rstat_updated(&css->rstat, cpu);
+	__cgroup_rstat_updated(&css->rstat, cpu, &rstat_css_ops);
 }
 
 /**
@@ -161,7 +205,8 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
  * cgroups into a stack. The root is pushed by the caller.
  */
 static struct cgroup_rstat *cgroup_rstat_push_children(
-	struct cgroup_rstat *head, struct cgroup_rstat *child, int cpu)
+	struct cgroup_rstat *head, struct cgroup_rstat *child, int cpu,
+	struct cgroup_rstat_ops *ops)
 {
 	struct cgroup_rstat *chead = child;	/* Head of child cgroup level */
 	struct cgroup_rstat *ghead = NULL;	/* Head of grandchild cgroup level */
@@ -174,7 +219,7 @@ static struct cgroup_rstat *cgroup_rstat_push_children(
 	while (chead) {
 		child = chead;
 		chead = child->rstat_flush_next;
-		parent = rstat_parent(child);
+		parent = ops->parent_fn(child);
 
 		/* updated_next is parent cgroup terminated */
 		while (child != parent) {
@@ -220,16 +265,15 @@ static struct cgroup_rstat *cgroup_rstat_push_children(
  * here is the cgroup root whose updated_next can be self terminated.
  */
 static struct cgroup_rstat *cgroup_rstat_updated_list(
-		struct cgroup_rstat *root, int cpu)
+		struct cgroup_rstat *root, int cpu, struct cgroup_rstat_ops *ops)
 {
-	struct cgroup_subsys_state *css = container_of(
-			root, typeof(*css), rstat);
-	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
 	struct cgroup_rstat *head = NULL, *parent, *child;
+	struct cgroup *cgrp;
 	unsigned long flags;
 
+	cgrp = ops->cgroup_fn(root);
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
@@ -240,7 +284,7 @@ static struct cgroup_rstat *cgroup_rstat_updated_list(
 	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
 	 */
-	parent = rstat_parent(root);
+	parent = ops->parent_fn(root);
 	if (parent) {
 		struct cgroup_rstat_cpu *prstatc;
 		struct cgroup_rstat **nextp;
@@ -265,7 +309,7 @@ static struct cgroup_rstat *cgroup_rstat_updated_list(
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
-		head = cgroup_rstat_push_children(head, child, cpu);
+		head = cgroup_rstat_push_children(head, child, cpu, ops);
 unlock_ret:
 	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
 	return head;
@@ -323,34 +367,30 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat)
+static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat,
+		struct cgroup_rstat_ops *ops)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
-	struct cgroup_subsys_state *css = container_of(
-			rstat, typeof(*css), rstat);
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat *pos = cgroup_rstat_updated_list(rstat, cpu);
+		struct cgroup_rstat *pos = cgroup_rstat_updated_list(
+				rstat, cpu, ops);
 
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup_subsys_state *pos_css = container_of(
-					pos, typeof(*pos_css), rstat);
-			struct cgroup *pos_cgroup = pos_css->cgroup;
-
-			if (!pos_css->ss)
-				cgroup_base_stat_flush(pos_cgroup, cpu);
-			else
-				pos_css->ss->css_rstat_flush(pos_css, cpu);
+			struct cgroup *pos_cgroup = ops->cgroup_fn(pos);
 
+			ops->flush_fn(pos, cpu);
 			bpf_rstat_flush(pos_cgroup, cgroup_parent(pos_cgroup), cpu);
 		}
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
+			struct cgroup *cgrp;
+
+			cgrp = ops->cgroup_fn(rstat);
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
@@ -359,16 +399,15 @@ static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat)
 	}
 }
 
-static void __cgroup_rstat_flush(struct cgroup_rstat *rstat)
+static void __cgroup_rstat_flush(struct cgroup_rstat *rstat,
+		struct cgroup_rstat_ops *ops)
 {
-	struct cgroup_subsys_state *css = container_of(
-			rstat, typeof(*css), rstat);
-	struct cgroup *cgrp = css->cgroup;
+	struct cgroup *cgrp;
 
 	might_sleep();
-
+	cgrp = ops->cgroup_fn(rstat);
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(rstat);
+	cgroup_rstat_flush_locked(rstat, ops);
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
@@ -387,19 +426,19 @@ static void __cgroup_rstat_flush(struct cgroup_rstat *rstat)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush(&css->rstat);
+	__cgroup_rstat_flush(&css->rstat, &rstat_css_ops);
 }
 
-static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat)
+static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat,
+		struct cgroup_rstat_ops *ops)
 	__acquires(&cgroup_rstat_lock)
 {
-	struct cgroup_subsys_state *css = container_of(
-			rstat, typeof(*css), rstat);
-	struct cgroup *cgrp = css->cgroup;
+	struct cgroup *cgrp;
 
 	might_sleep();
+	cgrp = ops->cgroup_fn(rstat);
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(rstat);
+	cgroup_rstat_flush_locked(rstat, ops);
 }
 
 /**
@@ -413,20 +452,20 @@ static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat)
  */
 void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_hold(&css->rstat);
+	__cgroup_rstat_flush_hold(&css->rstat, &rstat_css_ops);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  * @rstat: rstat node used to find associated cgroup used by tracepoint
  */
-static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat)
+static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat,
+		struct cgroup_rstat_ops *ops)
 	__releases(&cgroup_rstat_lock)
 {
-	struct cgroup_subsys_state *css = container_of(
-			rstat, typeof(*css), rstat);
-	struct cgroup *cgrp = css->cgroup;
+	struct cgroup *cgrp;
 
+	cgrp = ops->cgroup_fn(rstat);
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
@@ -436,7 +475,7 @@ static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat)
  */
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_release(&css->rstat);
+	__cgroup_rstat_flush_release(&css->rstat, &rstat_css_ops);
 }
 
 static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
-- 
2.48.1


