Return-Path: <cgroups+bounces-8457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379BAD0683
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527D13B1FED
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009E28A1CC;
	Fri,  6 Jun 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvfOMurp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287628A1CE;
	Fri,  6 Jun 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226742; cv=none; b=Q02eMB5WQN/efE4OvnIR6SUSknxpogN25O/LTGyJRF2VpzShogqHe4jgg+dWTGTPBoTVZWJMaWlzh/VMlfTtSHl0Uqq585T3ct75dNKNss/ZizMd/qghHzhRI8g1FFMDyezgnU+AAzA8KKdfQpW374yMYQX9vQgvYWcl1w+3OOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226742; c=relaxed/simple;
	bh=lLb+jNOrtfcqwgNscb056qIBxvga8xPQUWy2hvwYULk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv3YVW3lgYZJoyRLRMTuhllY5n85asDFThUerTbmrK3XJi4l+pSx4jnhC3LEgUnLBOrVwjXpf4Ed/frHCD9IxXlGvHNXLbp3chCswOsrE27Vx9KmgX832ohhJfKxV0xDEZ7T+8xZdg7gvg9CsTgwOgdgAu1RTjU1S6ZazkmGXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvfOMurp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso1912247b3a.2;
        Fri, 06 Jun 2025 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226740; x=1749831540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmddC+fvugcNh6NPL5Z6V5D8fMLub+35xnJ4f4NuuCY=;
        b=JvfOMurpwNZkdo5/SkBpxrhg7n1NReDOujg2lnxmifhJ3zThO6fnSOiZv2L1KmTO13
         4OLlmAWhz9GmC7T/RRMRQetl5UsWT8G0AGzYDEUAbN5NIqOprard2nTtVVAwvGzU4lFI
         8q43M5m1jpioPfu0AxgmFmi6ieFiz5aIcBdkiDcbnww7/CO7bA6SPR5gMhO9oaX2DYDf
         /UXxFwiVSELirSkpMD2oKWdvJDJTZrpOYS3zxbua0mj/SgHKLdkOZhpzU8XmjKd4+7He
         aVDdo2nHURy7kVVJJpOO4q5hyO/y/oo3Kcfx51jhm5a/CXoi/r6uVfKyFMDxGUtfkyHZ
         sNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226740; x=1749831540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmddC+fvugcNh6NPL5Z6V5D8fMLub+35xnJ4f4NuuCY=;
        b=Rz4/X62ozB8MM0JudsOZETocJ9I3QgwpMvqS2RBHtUQcozIXaKnark066tZeAoAS/E
         YLBcQMcw3qfz6Hq4rvki1U5dOQqkanR5Lpc+mSXgkLzbAImLiXR3ydtY00VAORcXhf/L
         yyxnSVYxSXTbqOfvTni5kvLPe2K5uZrDX0wiJBg1yyh/+o6HwAiNExaYkf7e6G4/Hs0H
         yWpvgzj38R1IzasSLHe+yTJQfkRd9gfP/C/A167aGwcWS5d3OGqYNJYahyWCeQ5cnIT6
         gejxIACPKUwpVEXPsQvpbn8/jwoXNWvtSD0xER3d45e3h7bYk1v3+JtaFeu2wcUS2h//
         oDsg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Gr4k06cbg1Etx70if3399gHw4xwo/W5xdvvGy8dv+6qBIKMfX6RC/qJjfUW2Fma27Di0dtlfXAbBRzUu@vger.kernel.org, AJvYcCWQklR7TqNtjESjFp3v13ZpXkv+EbFOMdLm0izv2L8ihr2fn6CjgqkbkaFZB4DKdtWVgGyZM+s3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1LqKXP38TQtVk7RJXjurUEc++RVE+tpVi9ZSmYJ/Iby3Ny0x
	9lKtwMaYAkpNd5UhvunBwrHVM+Ir97bct4c24tqYHcVMEX+bJTe9wRKd
X-Gm-Gg: ASbGncvpRSHkXfqav0egCunitZ8nsfOmeCw7T18/CN5/pwe0zkc5a29b9TojNGDTurF
	3AXj/8TBnV1/aimswrA8NfvhiY4EP6fYB/FtEcgl5YDje6l8Ez3UYh50ekYuwhxN8Ni2CK4Dbi8
	DTYBKCfuMqwZ6Ud2Hq2eOKXYtrHhP886hhIupbcaQST3yGMxR/zMKW9lrpKq9jPn2m3P4hvXjVM
	wIaRzvk1zvfBa3BaArhGp7dXAdsACLEPnMDmrqNJ1tAt4aEz+r4/1RoCCoR2/UHibWJbb1c3kug
	/LDADIhjsmCfkUYfWFXUbeY76gxmDeYTqzWeP6Ae/Fz+bwGYvXK023lTph22cA==
X-Google-Smtp-Source: AGHT+IFcXtPfFGYXvkgSpvJ7vtSOpxnnhRLikBp1U3gJWE6ad36suuVrBjAV85Ov9GEOGtdfNwEpHg==
X-Received: by 2002:a05:6a00:4646:b0:73e:1566:5960 with SMTP id d2e1a72fcca58-748280ab71bmr6362559b3a.19.1749226739523;
        Fri, 06 Jun 2025 09:18:59 -0700 (PDT)
Received: from jemmy.. ([180.172.46.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38353sm1518675b3a.10.2025.06.06.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:18:59 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] cgroup: add lock guard support for others
Date: Sat,  7 Jun 2025 00:18:41 +0800
Message-ID: <20250606161841.44354-4-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606161841.44354-1-jemmywong512@gmail.com>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---
 kernel/cgroup/cgroup-internal.h |  8 ++--
 kernel/cgroup/cgroup-v1.c       | 11 +++--
 kernel/cgroup/cgroup.c          | 73 ++++++++++++---------------------
 3 files changed, 35 insertions(+), 57 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b14e61c64a34..5430454d38ca 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -198,8 +198,6 @@ void put_css_set_locked(struct css_set *cset);
 
 static inline void put_css_set(struct css_set *cset)
 {
-	unsigned long flags;
-
 	/*
 	 * Ensure that the refcount doesn't hit zero while any readers
 	 * can see it. Similar to atomic_dec_and_lock(), but for an
@@ -208,9 +206,9 @@ static inline void put_css_set(struct css_set *cset)
 	if (refcount_dec_not_one(&cset->refcount))
 		return;
 
-	spin_lock_irqsave(&css_set_lock, flags);
-	put_css_set_locked(cset);
-	spin_unlock_irqrestore(&css_set_lock, flags);
+	scoped_guard(spinlock_irqsave, &css_set_lock) {
+		put_css_set_locked(cset);
+	}
 }
 
 /*
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fcc2d474b470..91c6ba4e441d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1291,7 +1291,6 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
 {
 	struct cgroup *cgrp = ERR_PTR(-ENOENT);
 	struct cgroup_root *root;
-	unsigned long flags;
 
 	guard(rcu)();
 	for_each_root(root) {
@@ -1300,11 +1299,11 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
 			continue;
 		if (root->hierarchy_id != hierarchy_id)
 			continue;
-		spin_lock_irqsave(&css_set_lock, flags);
-		cgrp = task_cgroup_from_root(tsk, root);
-		if (!cgrp || !cgroup_tryget(cgrp))
-			cgrp = ERR_PTR(-ENOENT);
-		spin_unlock_irqrestore(&css_set_lock, flags);
+		scoped_guard(spinlock_irqsave, &css_set_lock) {
+			cgrp = task_cgroup_from_root(tsk, root);
+			if (!cgrp || !cgroup_tryget(cgrp))
+				cgrp = ERR_PTR(-ENOENT);
+		}
 		break;
 	}
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 46b677a066d1..ea98679b01e1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -335,28 +335,23 @@ static int cgroup_idr_alloc(struct idr *idr, void *ptr, int start, int end,
 	int ret;
 
 	idr_preload(gfp_mask);
-	spin_lock_bh(&cgroup_idr_lock);
-	ret = idr_alloc(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
-	spin_unlock_bh(&cgroup_idr_lock);
+	scoped_guard(spinlock_bh, &cgroup_idr_lock) {
+		ret = idr_alloc(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
+	}
 	idr_preload_end();
 	return ret;
 }
 
 static void *cgroup_idr_replace(struct idr *idr, void *ptr, int id)
 {
-	void *ret;
-
-	spin_lock_bh(&cgroup_idr_lock);
-	ret = idr_replace(idr, ptr, id);
-	spin_unlock_bh(&cgroup_idr_lock);
-	return ret;
+	guard(spinlock_bh)(&cgroup_idr_lock);
+	return idr_replace(idr, ptr, id);
 }
 
 static void cgroup_idr_remove(struct idr *idr, int id)
 {
-	spin_lock_bh(&cgroup_idr_lock);
+	guard(spinlock_bh)(&cgroup_idr_lock);
 	idr_remove(idr, id);
-	spin_unlock_bh(&cgroup_idr_lock);
 }
 
 static bool cgroup_has_tasks(struct cgroup *cgrp)
@@ -583,20 +578,19 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	if (!CGROUP_HAS_SUBSYS_CONFIG)
 		return NULL;
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	do {
 		css = cgroup_css(cgrp, ss);
 
 		if (css && css_tryget_online(css))
-			goto out_unlock;
+			return css;
 		cgrp = cgroup_parent(cgrp);
 	} while (cgrp);
 
 	css = init_css_set.subsys[ss->id];
 	css_get(css);
-out_unlock:
-	rcu_read_unlock();
+
 	return css;
 }
 EXPORT_SYMBOL_GPL(cgroup_get_e_css);
@@ -1691,9 +1685,9 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		struct cgroup_subsys_state *css = cgroup_css(cgrp, cft->ss);
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
-		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = NULL;
-		spin_unlock_irq(&cgroup_file_kn_lock);
+		scoped_guard(spinlock_irq, &cgroup_file_kn_lock) {
+			cfile->kn = NULL;
+		}
 
 		timer_delete_sync(&cfile->notify_timer);
 	}
@@ -4277,9 +4271,9 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
 
-		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = kn;
-		spin_unlock_irq(&cgroup_file_kn_lock);
+		scoped_guard(spinlock_irq, &cgroup_file_kn_lock) {
+			cfile->kn = kn;
+		}
 	}
 
 	return 0;
@@ -4534,9 +4528,7 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
  */
 void cgroup_file_notify(struct cgroup_file *cfile)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
+	guard(spinlock_irqsave)(&cgroup_file_kn_lock);
 	if (cfile->kn) {
 		unsigned long last = cfile->notified_at;
 		unsigned long next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
@@ -4548,7 +4540,6 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 			cfile->notified_at = jiffies;
 		}
 	}
-	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
 /**
@@ -4560,10 +4551,10 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 {
 	struct kernfs_node *kn;
 
-	spin_lock_irq(&cgroup_file_kn_lock);
-	kn = cfile->kn;
-	kernfs_get(kn);
-	spin_unlock_irq(&cgroup_file_kn_lock);
+	scoped_guard(spinlock_irq, &cgroup_file_kn_lock) {
+		kn = cfile->kn;
+		kernfs_get(kn);
+	}
 
 	if (kn)
 		kernfs_show(kn, show);
@@ -4987,11 +4978,10 @@ static void css_task_iter_advance(struct css_task_iter *it)
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it)
 {
-	unsigned long irqflags;
 
 	memset(it, 0, sizeof(*it));
 
-	spin_lock_irqsave(&css_set_lock, irqflags);
+	guard(spinlock_irqsave)(&css_set_lock);
 
 	it->ss = css->ss;
 	it->flags = flags;
@@ -5004,8 +4994,6 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 	it->cset_head = it->cset_pos;
 
 	css_task_iter_advance(it);
-
-	spin_unlock_irqrestore(&css_set_lock, irqflags);
 }
 
 /**
@@ -5018,14 +5006,12 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
  */
 struct task_struct *css_task_iter_next(struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	if (it->cur_task) {
 		put_task_struct(it->cur_task);
 		it->cur_task = NULL;
 	}
 
-	spin_lock_irqsave(&css_set_lock, irqflags);
+	guard(spinlock_irqsave)(&css_set_lock);
 
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
@@ -5038,8 +5024,6 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
 		css_task_iter_advance(it);
 	}
 
-	spin_unlock_irqrestore(&css_set_lock, irqflags);
-
 	return it->cur_task;
 }
 
@@ -5051,13 +5035,10 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
  */
 void css_task_iter_end(struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	if (it->cur_cset) {
-		spin_lock_irqsave(&css_set_lock, irqflags);
+		guard(spinlock_irqsave)(&css_set_lock);
 		list_del(&it->iters_node);
 		put_css_set_locked(it->cur_cset);
-		spin_unlock_irqrestore(&css_set_lock, irqflags);
 	}
 
 	if (it->cur_dcset)
@@ -6737,10 +6718,10 @@ void cgroup_post_fork(struct task_struct *child,
 				 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
 				 * get the task into the frozen state.
 				 */
-				spin_lock(&child->sighand->siglock);
-				WARN_ON_ONCE(child->frozen);
-				child->jobctl |= JOBCTL_TRAP_FREEZE;
-				spin_unlock(&child->sighand->siglock);
+				scoped_guard(spinlock, &child->sighand->siglock) {
+					WARN_ON_ONCE(child->frozen);
+					child->jobctl |= JOBCTL_TRAP_FREEZE;
+				}
 
 				/*
 				 * Calling cgroup_update_frozen() isn't required here,
-- 
2.43.0


