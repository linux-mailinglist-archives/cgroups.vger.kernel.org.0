Return-Path: <cgroups+bounces-8812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CFB0CF30
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825471C211BD
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 01:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6831C1AB4;
	Tue, 22 Jul 2025 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfY07OaC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6801A76D4;
	Tue, 22 Jul 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148450; cv=none; b=TrKZkLDVX9xmvIYGiiex/Ze9MfoVWTZQlaamTMRKpyxd2y+1JLQKUSg96TzLilj81dL0wC2Y5Hysr4T/Mvm1c62WlWgprJPX3DrCwyuIunLwWM6m1Y0cWON5mouFRpVlKFUxLRzHzzxHQ+4qs4vl+DQvVu69agX2QsQX2iSnrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148450; c=relaxed/simple;
	bh=3hu7wHkhpX+aYHmMAybjtrvkJSA+unVqx8yFgpVZLSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cozuaLxNbq9OU+tyJr938VeQ/aVuOJghT1DccPggRGFbG67v+UbdkJeidoNe4rGG4/HD46WeIvGBpcR0qEJRB286mNPSyHcAxFfMk8AeesbYCSXZ709lTHo5CaBdbJAe7cZPrfDySF64kYX5kxPZB6pKVwYb1YigdhARFph4fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfY07OaC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b52bf417cso3257057b3a.0;
        Mon, 21 Jul 2025 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753148448; x=1753753248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpioRhlrYEnhflNoi/6xqIajRAkPUX1YjkOJ/I3fK4E=;
        b=gfY07OaCl4Jfq+sJVAaoKdzNmBSUqB25rHwvb6ShFuz/HURClOGrW702OhhoiN2zGn
         NUCNBgwps1mTCnpUidx3Ws6fTpXwaxEkFrm6mWQMVyO8/CZelknoLU5KstgnjYuUpPFf
         uwuTuSNZH9OCkn9+/OtdB3SzNbKR54WZWoMzyyM1n3Pp/xekHjde/w0PPsdz6QHBf4um
         kvmJLL3jSMjDpvDtemjzV49FOd3Jil5blNGsRPoArxjYE8Id2esBBkftAWXXZt/3SX3/
         eJ+qlDE4HLD7FLCiNQyWHs2T2zk1ZA3Mj5bhXcN5UXbL5cvTc96orytxir0mNP4d5n6T
         3qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148448; x=1753753248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpioRhlrYEnhflNoi/6xqIajRAkPUX1YjkOJ/I3fK4E=;
        b=ZUaxnnRohfX0DBW9r3I79I91VTGuGpZa9wGBVB9qvUOp9JzSOWE+/M0Sl8FSTAv2fn
         W4ApHxPSajeihT0LJ95eHH9IU5X3kSHSI5f6CYlGvTKdBVWVqCsiZXEjd2mRKndmOmBe
         bvbamo7dyUZDWpzAATefBCj8UG+ow9XtcUxGTNstPE7S8D75+XFUxXT4ihZGyYqBMtUb
         H3CGZsCJLrmpNlTVpyZ7s9mFFeMUzbqZGVBBiE1RYsdQeu5KJuRmjGoBOMkh/r/2ocmS
         cMtsT+XIoui6BYah/3biWFt2Srt9M9m5Fs6BfchZ4iGBWEK9CjsDAA+TfJM3On2VyVYV
         v5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWcN0AmzgKC0wpleDdb371fKBnkPXm+YWIg9fpZ+IqOU5ZgJu5Cm6n4nyQlJAVVvHWbN+9+M3DJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/l6iDyWQAQ3A4yLwACjTrOSc6MBbnoVOaMUMbmlE5Cq8nG9G
	xGvICveOD/ctds2IOEl09cq7PFRD+HP9yC5kebbdoW5/uX2npQU60aEq
X-Gm-Gg: ASbGncv91jg8vwcjH8z/LwcgXFNvwnpfUXS0PW9gWqVOg1L2cNTGaXyUPIfCa9yLBoO
	uBHkoq49rQBqP/2s1he7aNR33/3RDHIqQSZ1ekaJwbpCih7XAqfGjcuwKTbOQ2uVZVW4zUZiusm
	xMWWH12lmXRsR+KpWUrw3Ygb3l5jhaqJKaJmR6gKlyumZJN3sVbcbOXkA7cQwVUsmp0e8hya3He
	5kMzW+MpCqlfOkfGDAkesWKP2CglV6XqBXP0fDq9ZxCjMTj2+xfWmdmT/u2EI30ZBTBFvAbpW4i
	o0uj32FTDmJ2WRgKjwnJhkN3ObxFjCsM099Wgv2nAW9/0KzcUtvkGhfzSZl504UZNsNA9amNqr4
	hd0Q66GZFOaw7p251CBNNzV3IbN/ANBhO7ZpSblQvi7TPKaZQ
X-Google-Smtp-Source: AGHT+IH5hk/c/I6OKPgLS9u4RoARnHXIWja8vD1Mb7zDk6Fp0Qi0jcGgkmA52GvBYzfRi6ilZZv9wg==
X-Received: by 2002:a05:6a00:2387:b0:746:3025:6576 with SMTP id d2e1a72fcca58-75723d7d236mr28114641b3a.14.1753148448131;
        Mon, 21 Jul 2025 18:40:48 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm6584089b3a.82.2025.07.21.18.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:40:47 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/5 cgroup/for-6.16-fixes] cgroup: add exclusive css rstat init/exit api for base stats
Date: Mon, 21 Jul 2025 18:40:26 -0700
Message-ID: <20250722014030.297537-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014030.297537-1-inwardvessel@gmail.com>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is known at call sites of css_rstat_init/exit() whether the given css is
associated with the base stats or a formal subsystem. Instead of passing
&cgrp->self or css to a shared API, offer an additional init/exit API pair
for exclusive use with the base stats.

Make use of this new API to make existing code more readable and also to
prepare for refactoring the complex css rstat init/exit logic.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup-internal.h |  2 ++
 kernel/cgroup/cgroup.c          | 11 ++++++-----
 kernel/cgroup/rstat.c           | 27 +++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b14e61c64a34..24fca840bf1c 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -270,6 +270,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
+int cgroup_rstat_base_init(struct cgroup *cgrp);
+void cgroup_rstat_base_exit(struct cgroup *cgrp);
 int css_rstat_init(struct cgroup_subsys_state *css);
 void css_rstat_exit(struct cgroup_subsys_state *css);
 int ss_rstat_init(struct cgroup_subsys *ss);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..d684d33236b8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2149,7 +2149,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = css_rstat_init(&root_cgrp->self);
+	ret = cgroup_rstat_base_init(root_cgrp);
 	if (ret)
 		goto destroy_root;
 
@@ -2190,7 +2190,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	css_rstat_exit(&root_cgrp->self);
+	cgroup_rstat_base_exit(root_cgrp);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -5446,13 +5446,13 @@ static void css_free_rwork_fn(struct work_struct *work)
 	struct cgroup *cgrp = css->cgroup;
 
 	percpu_ref_exit(&css->refcnt);
-	css_rstat_exit(css);
 
 	if (!css_is_self(css)) {
 		/* css free path */
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
+		css_rstat_exit(css);
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
@@ -5477,6 +5477,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
+			cgroup_rstat_base_exit(cgrp);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5742,7 +5743,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	 * Now that init_cgroup_housekeeping() has been called and cgrp->self
 	 * is setup, it is safe to perform rstat initialization on it.
 	 */
-	ret = css_rstat_init(&cgrp->self);
+	ret = cgroup_rstat_base_init(cgrp);
 	if (ret)
 		goto out_kernfs_remove;
 
@@ -5818,7 +5819,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_psi_free:
 	psi_cgroup_free(cgrp);
 out_stat_exit:
-	css_rstat_exit(&cgrp->self);
+	cgroup_rstat_base_exit(cgrp);
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_cancel_ref:
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cbeaa499a96a..8c3cb4a989ad 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -437,11 +437,10 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 	}
 }
 
-int css_rstat_init(struct cgroup_subsys_state *css)
+static int __css_rstat_init(struct cgroup_subsys_state *css, bool is_self)
 {
 	struct cgroup *cgrp = css->cgroup;
 	int cpu;
-	bool is_self = css_is_self(css);
 
 	if (is_self) {
 		/* the root cgrp has rstat_base_cpu preallocated */
@@ -481,7 +480,7 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 	return 0;
 }
 
-void css_rstat_exit(struct cgroup_subsys_state *css)
+static void __css_rstat_exit(struct cgroup_subsys_state *css, bool is_self)
 {
 	int cpu;
 
@@ -499,7 +498,7 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 			return;
 	}
 
-	if (css_is_self(css)) {
+	if (is_self) {
 		struct cgroup *cgrp = css->cgroup;
 
 		free_percpu(cgrp->rstat_base_cpu);
@@ -510,6 +509,26 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 	css->rstat_cpu = NULL;
 }
 
+int css_rstat_init(struct cgroup_subsys_state *css)
+{
+	return __css_rstat_init(css, false);
+}
+
+void css_rstat_exit(struct cgroup_subsys_state *css)
+{
+	return __css_rstat_exit(css, false);
+}
+
+int cgroup_rstat_base_init(struct cgroup *cgrp)
+{
+	return __css_rstat_init(&cgrp->self, true);
+}
+
+void cgroup_rstat_base_exit(struct cgroup *cgrp)
+{
+	__css_rstat_exit(&cgrp->self, true);
+}
+
 /**
  * ss_rstat_init - subsystem-specific rstat initialization
  * @ss: target subsystem
-- 
2.47.1


