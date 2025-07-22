Return-Path: <cgroups+bounces-8814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EEBB0CF34
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 03:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C717B5465F6
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87CB1A76D4;
	Tue, 22 Jul 2025 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAs+iEEI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC581DE3AB;
	Tue, 22 Jul 2025 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148454; cv=none; b=XSk2TIpTHXG4yocTBSA7YHu5vYYFRV6l5c8ZsdiCnPbe9cZXQTuIKJQjncqYtCyU14TF1xuUNHzH3m1RY8z3kBmhaIs3Od0Anq0OeebwhYucK+yffyq1HKtA7bk0Bbw+ZJBk+xPaEGAmPB35d/K4jI3KIl8dDfuX20chPz/hb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148454; c=relaxed/simple;
	bh=ISAX7fKcvxJYGebYef7SJczmeqKoTClEaeP3mts1XKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1pCQmaDyZUOknK4LJ7uyg76FPd4sGTP2MmSLcpbIuelTUgF5SYJLh2VAs7d06X6jU1F2NMPvP74U6aTJWsatxIHspCcDXPgGXfg6Z08JpR0QV5CJHzGGxdOHwjGWTQhuO3Jwb5g5Dua6U8HfQTuPFCufcIs228Jgf8zPdtJ4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAs+iEEI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-75ce8f8a3a1so951805b3a.3;
        Mon, 21 Jul 2025 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753148452; x=1753753252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpVNDn7PZTho9MNu8qCg7LCZBl9gEjfCHcUDBMSEILQ=;
        b=eAs+iEEIUjBy+WxL/wUwZj9eH/3zUd8jHI2+SW5W38J1s1dHer2GJc7J5o76LKE9MF
         QVvwDfm8toZWV9QtO182m/QWE6nPXI5voPM5OgmSyjKnlNMJHso92MhA94wHGuMjHsuL
         cAZo3Zzu+GCmBybPeHaF12JPTRjG9wIXZNZ/xweiUSM5MLqNN/CDYJCf7I21kVTP/nDf
         53Kuf0yl9iuv8amAe6lxiypbwpkscONZcKqH4e5z33MzvrBmmrm0cWU836sl94cC+36f
         EHmMI7f7YuCjywYjzE9H1fgJSNDHBr1zrslgzDAJgQMwIZkrv18N7qwN4tfBxHhN9VRd
         iP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148452; x=1753753252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpVNDn7PZTho9MNu8qCg7LCZBl9gEjfCHcUDBMSEILQ=;
        b=S9p5Tj30Gezf7Y3w9m0gS+ynDkl9vp4j2VlG1YWoF8uRo0kYYz4Opyp1iubDhOehh3
         HfNn2Oa66UTZjJq97G89jtcTOUS+wR2KkRAAkZYoxGe6QzkVKKnaUkZQawkUoqjkiYqu
         AxBlQiYsJK0e76K25dYdTCweJiLO95CcJXtyzD4fjj84FLXWl0R+fXwP/Wv9y5mqpTBO
         DcvdSLEB8DCO3LZ/IRTjtb4DwJNu1ftNnmkEDJ7laUxMcj2UqqOfsXgxdPfXeWQY4OX0
         a/5lAjh9e0nptBIGaWn1QTBqmTzxd/H4OCLMQ4iQjqxoQwT5CR0evmi9JOU1KBJkgiCg
         3Mjw==
X-Forwarded-Encrypted: i=1; AJvYcCVMndFiaiUmJE0kPIRz7no82VTP/b/Ub6cQPQ9SOZ+VerWbTHNLJ/NMvMZKWAoXUH24/9U8sGyZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KU8UG/8mNtWhJdNe2dbHaOHn0WNWUaJsyEz3ZpzSW+S9y/XP
	h306O/7DHUNGowZPlo+TCpAJOaM/FWDvmd4XRCqWA2Lebn5egRD4saq+
X-Gm-Gg: ASbGncvrjD0BX41GFmVrbNiXicGfB91xJ8/9CIiOtJbn+p6CtRMTKy6WGCY/C71QoKP
	3tscMOvAS6+MG7pUGUbreF7IbXXKozUVQM0qxKH8UIAuA3plQX4hbydZRsqONk3rVpElJ4KI8w6
	kvw3H+f9yBT/qzQVYDLwpx5SyMrU6nrr9v82dh3ciVeYh0eNi/BpFLvzFkXB+tRty3dhe4fWPSk
	lWFHARiVK8IK47Ohro2B2lvAYBC+Ycqz5cW+fh6dU6FWneoZLJoLWTz+/wDOg3GwDNwq30Cz7Se
	zk7gqOy3NZ75gFkfSwpyrUxtX/JEwuyuAjqCSClZiCw/k4jqgbxtt93IBxfq0PlRAVyyIkUT3vM
	2+iYl50s336K0Emvd4qJDS38zwQgKtWlx9sbtrhNZrKk6913h
X-Google-Smtp-Source: AGHT+IGCss3lZ7t1Z9Z+ms6vwllYpjQ7KiwnLlw3ogzBFFE0uLP5/w6oP0Q6HZxTipquAPk4Y4dChQ==
X-Received: by 2002:a05:6a00:4f89:b0:74d:247f:fae4 with SMTP id d2e1a72fcca58-759ab639673mr21340841b3a.4.1753148451979;
        Mon, 21 Jul 2025 18:40:51 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm6584089b3a.82.2025.07.21.18.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:40:51 -0700 (PDT)
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
Subject: [PATCH 3/5 cgroup/for-6.16-fixes] cgroup: split init_and_link_css()
Date: Mon, 21 Jul 2025 18:40:28 -0700
Message-ID: <20250722014030.297537-4-inwardvessel@gmail.com>
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

Just as its name implies, init_and_link_css() has two responsibilities.
One is defining default values for some of the given css's fields. The
other is defining the cgroup, parent, and subsystem relationships (linking)
while incrementing the newly associated cgroup refcounts (including
parent). Once the refcounts are changed, cleanup of the css has to be
performed asynchronously in a series of workqueue functions.

The cleanup constraint impacts the error handling of the the css_create()
function. Code that follows init_and_link_css() must jump to the async
cleanup path in the case of an error. This leaves the call to
css_rstat_init() in a bad position. If it fails or if any other function
between it and init_and_link_css() fails, the async cleanup sequence will
ultimately reach a call to css_rstat_exit() on an uninitialized css.

Split init_and_link_css() into separate functions for each of its two
responsibilies. This allows for handling errors without having to resort to
the async cleanup sequence. More specifically, css_rstat_init() could be
called before async cleanup becomes necessary within css_create(). This
patch serves as preparation for the change in where css_rstat_init() will
be called.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b034f47580f6..1990c6113c7f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5568,21 +5568,25 @@ static void css_release(struct percpu_ref *ref)
 	queue_work(cgroup_destroy_wq, &css->destroy_work);
 }
 
-static void init_and_link_css(struct cgroup_subsys_state *css,
+static void init_css(struct cgroup_subsys_state *css)
+{
+	memset(css, 0, sizeof(*css));
+	css->id = -1;
+	INIT_LIST_HEAD(&css->sibling);
+	INIT_LIST_HEAD(&css->children);
+	css->serial_nr = css_serial_nr_next++;
+	atomic_set(&css->online_cnt, 0);
+}
+
+static void link_css(struct cgroup_subsys_state *css,
 			      struct cgroup_subsys *ss, struct cgroup *cgrp)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
 	cgroup_get_live(cgrp);
 
-	memset(css, 0, sizeof(*css));
 	css->cgroup = cgrp;
 	css->ss = ss;
-	css->id = -1;
-	INIT_LIST_HEAD(&css->sibling);
-	INIT_LIST_HEAD(&css->children);
-	css->serial_nr = css_serial_nr_next++;
-	atomic_set(&css->online_cnt, 0);
 
 	if (cgroup_parent(cgrp)) {
 		css->parent = cgroup_css(cgroup_parent(cgrp), ss);
@@ -5670,7 +5674,8 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 	if (IS_ERR(css))
 		return css;
 
-	init_and_link_css(css, ss, cgrp);
+	init_css(css);
+	link_css(css, ss, cgrp);
 
 	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
 	if (err)
@@ -6130,7 +6135,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	css = ss->css_alloc(NULL);
 	/* We don't handle early failures gracefully */
 	BUG_ON(IS_ERR(css));
-	init_and_link_css(css, ss, &cgrp_dfl_root.cgrp);
+	init_css(css);
+	link_css(css, ss, &cgrp_dfl_root.cgrp);
 
 	/*
 	 * Root csses are never destroyed and we can't initialize
-- 
2.47.1


