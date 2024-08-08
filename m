Return-Path: <cgroups+bounces-4161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70E94B429
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C17B21A72
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649B443D;
	Thu,  8 Aug 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCr6+unw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6B1854;
	Thu,  8 Aug 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076757; cv=none; b=Ct2nDh5cyi6eVQFf8WqSisUrT0vPUN1HV1TjF2rE0rRprH0dWRW5B0VuP4NiF1V+BjAoptPbbezpf/XsKOotj4tXwH0NHCFhjrgGKDNpfpDdyZeuupCsXDWodOuZco28svW6e3Dn42QgoW/ZZ22xE21z378tgp/77wutgH1JIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076757; c=relaxed/simple;
	bh=zc2+k0LBxe1VXt7mayz15R47D08xCVFkOkWJq3wEIOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYq+jQYZRRuW6/K2fLLFs4IOz76QXuCF8A/LJ0G3ypq0lIDNrvs4HATxNMYwsFLjtvcAzDJZzELzTMl730qqW4wjaQVvodAU6LV11VmbkVpzX+rJ6+R6vEbB+FfZGAxrhSGB/MSPYX5o3hhd8QGy5AoCo52m0ZkJar3wBdgVVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCr6+unw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d2b921c48so395402b3a.1;
        Wed, 07 Aug 2024 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076755; x=1723681555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZPoyBgOBR8pJ95WJqw4Y8e3Xbe7lz0xxN9y25SLFYU=;
        b=kCr6+unwqusam/w02Ckh3LtS4mJZ7NUE23TJ3oPdfTttXE9k89WsjYONPnO5evbt5U
         0QsqCq25yAn9tg/Rk9vnH9AlmT7eGhF80npH7OqqMgJvn+k1K4yC7gBm7d44Yn094SYH
         weSnypHMv6haNZJzg6rQYsrlFFaxNBNJPfqxlo0B+w20XMn7WBWh4PQdmmAH3ZB4imKl
         XGgKNBBIGzx2yUsPqr6fHaA7pIlcQqfrJrEG7X9h/CTvEBW12lSoacGPfCg/PcJ3sw0u
         1EbSK+FMepnQ9cY3XQESKm5XjTDfi+szh6Lc2rn2vFpDuoBnbvVL5MbdEM2s0rYaSs6q
         5Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076755; x=1723681555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZPoyBgOBR8pJ95WJqw4Y8e3Xbe7lz0xxN9y25SLFYU=;
        b=ca4m3tENlBLL9wGaQuLlMERnDeWNBKjWucLYWUPFoo51dJzmray9RAlChPZ+7TWWPT
         /X/06+jvdHjxnfHgsiloC04evKuxjaJ+mG8r59OwXNNBB/1+RfieXdCty6j7d6tvNZcJ
         nkUNQnk+rGlPI+tCxlhNL+TjXbU5mDFZz8/1m1zRnOWFBy8HSBxdKbfG3HBTUxbLVR0F
         SdLUBn41l26cGJqoc5H1Ih7KyCfJPwIIPEHE+vZySjVMuvDH/6Kz3rjU7H8x3TduUbxY
         vtzNP2NgPN+bmKC0uLB6y3Z2x7IhZj282CjtATLSu9RycGVy1FKMVcPGGZaLEmIoUEHV
         t1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh9sl0yir3yZ53h+20CezTnVRAc60njZagU4EsyvDJJihNABJRzjC9PYzRW8eickIQVHJ0Ju9erd2/Sg+9wHBLbOqRITsEL7lMlQ9R
X-Gm-Message-State: AOJu0YzgJk8WSqnaZtFZ3QybhbjeV3nM5dpbPqr5dSLzHkGtemKj5JNE
	qTtGn719sAY+lEYfj7VQl2UFN1bJr58o87qgDWU/CL0+uJo1qTTWgrXSzQ==
X-Google-Smtp-Source: AGHT+IFdqBIaAi8haxLRgAt7bw3MTMBrfEWPE4gCG+b+fjanqrnlrvVheJb/CkUrqICUVgifCgHTDQ==
X-Received: by 2002:a05:6a00:390a:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-710cae379b0mr426979b3a.24.1723076755259;
        Wed, 07 Aug 2024 17:25:55 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22b213sm87200b3a.62.2024.08.07.17.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:25:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>
Subject: [PATCH 1/7] cgroup: Implement cgroup_show_cftypes()
Date: Wed,  7 Aug 2024 14:25:23 -1000
Message-ID: <20240808002550.731248-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808002550.731248-1-tj@kernel.org>
References: <20240808002550.731248-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cgroup_show_cftypes() which shows and hides all cgroup files
associated with the specified set of cgroup file types. CFTYPE_HIDDEN flag
is added so that files can be created hidden from the get-go.

cgroup_show_cftypes() can be used whether the cftypes are added or not. It
also combines with cgroup_show_file() so that a given file is visible iff
both its cftype and cfile are visible.

This will be used by a new sched_class to selectively show and hide CPU
controller interface files depending on whether they're supported.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/cgroup-defs.h |  8 +++
 include/linux/cgroup.h      |  1 +
 kernel/cgroup/cgroup.c      | 97 ++++++++++++++++++++++++++++++++++---
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ae04035b6cbe..03ff1e447cc5 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -137,12 +137,18 @@ enum {
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
 
+	CFTYPE_HIDDEN		= (1 << 6),	/* file type hidden, see cgroup_show_cftypes() */
+
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
 	__CFTYPE_ADDED		= (1 << 18),
 };
 
+enum cfile_flags {
+	CFILE_HIDDEN		= (1 << 0),	/* file instance hidden */
+};
+
 /*
  * cgroup_file is the handle for a file instance created in a cgroup which
  * is used, for example, to generate file changed notifications.  This can
@@ -150,7 +156,9 @@ enum {
  */
 struct cgroup_file {
 	/* do not access any fields from outside cgroup core */
+	struct cftype *cft;
 	struct kernfs_node *kn;
+	unsigned int flags;
 	unsigned long notified_at;
 	struct timer_list notify_timer;
 };
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7139b33cb104..83745574ad86 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -113,6 +113,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
+void cgroup_show_cftype(struct cftype *cft, bool show);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..bbef072ecdae 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4221,10 +4221,13 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
+	kernfs_show(kn, !(cft->flags & CFTYPE_HIDDEN));
+
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
+		cfile->cft = cft;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
 		cfile->kn = kn;
@@ -4500,6 +4503,24 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
+static struct kernfs_node *cfile_kn_get(struct cgroup_file *cfile)
+{
+	struct kernfs_node *kn;
+
+	spin_lock_irq(&cgroup_file_kn_lock);
+	kn = cfile->kn;
+	kernfs_get(kn);
+	spin_unlock_irq(&cgroup_file_kn_lock);
+
+	return kn;
+}
+
+static bool cfile_visible(struct cgroup_file *cfile)
+{
+	return !(cfile->cft->flags & CFTYPE_HIDDEN) &&
+		!(cfile->flags & CFILE_HIDDEN);
+}
+
 /**
  * cgroup_file_show - show or hide a hidden cgroup file
  * @cfile: target cgroup_file obtained by setting cftype->file_offset
@@ -4509,15 +4530,20 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 {
 	struct kernfs_node *kn;
 
-	spin_lock_irq(&cgroup_file_kn_lock);
-	kn = cfile->kn;
-	kernfs_get(kn);
-	spin_unlock_irq(&cgroup_file_kn_lock);
+	mutex_lock(&cgroup_mutex);
 
-	if (kn)
-		kernfs_show(kn, show);
+	if (show)
+		cfile->flags &= ~CFILE_HIDDEN;
+	else
+		cfile->flags |= CFILE_HIDDEN;
 
-	kernfs_put(kn);
+	kn = cfile_kn_get(cfile);
+	if (kn) {
+		kernfs_show(kn, cfile_visible(cfile));
+		kernfs_put(kn);
+	}
+
+	mutex_unlock(&cgroup_mutex);
 }
 
 /**
@@ -5542,6 +5568,63 @@ static void offline_css(struct cgroup_subsys_state *css)
 	wake_up_all(&css->cgroup->offline_waitq);
 }
 
+/**
+ * cgroup_show_cftype - show or hide a cgroup file type
+ * @cft: cftype to show or hide
+ * @show: whether to show or hide
+ *
+ * Sets %CFTYPE_HIDDEN and shows/hides the matching files according to @show.
+ * @cft may or may not be added at the time of this call. After hiding, it's
+ * guaranteed that there are no in-flight operations on the hidden files.
+ */
+void cgroup_show_cftype(struct cftype *cft, bool show)
+{
+	struct cgroup_subsys *ss = cft->ss;
+	struct cgroup *root = ss ? &ss->root->cgrp : &cgrp_dfl_root.cgrp;
+	struct cgroup_subsys_state *css;
+
+	mutex_lock(&cgroup_mutex);
+
+	if (show)
+		cft->flags &= ~CFTYPE_HIDDEN;
+	else
+		cft->flags |= CFTYPE_HIDDEN;
+
+	if (!(cft->flags & __CFTYPE_ADDED))
+		goto out_unlock;
+
+	css_for_each_descendant_pre(css, cgroup_css(root, ss)) {
+		struct cgroup *cgrp = css->cgroup;
+		struct kernfs_node *kn;
+
+		if (!(css->flags & CSS_VISIBLE))
+			continue;
+
+		if (cft->file_offset) {
+			struct cgroup_file *cfile =
+				(void *)css + cft->file_offset;
+
+			kn = cfile_kn_get(cfile);
+			if (kn) {
+				kernfs_show(kn, cfile_visible(cfile));
+				kernfs_put(kn);
+			}
+		} else {
+			char buf[CGROUP_FILE_NAME_MAX];
+
+			kn = kernfs_find_and_get(cgrp->kn,
+					cgroup_file_name(cgrp, cft, buf));
+			if (kn) {
+				kernfs_show(kn, show);
+				kernfs_put(kn);
+			}
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&cgroup_mutex);
+}
+
 /**
  * css_create - create a cgroup_subsys_state
  * @cgrp: the cgroup new css will be associated with
-- 
2.46.0


