Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1E13D32E
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2020 05:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgAPEgR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jan 2020 23:36:17 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43335 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgAPEgR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jan 2020 23:36:17 -0500
Received: by mail-pf1-f201.google.com with SMTP id x199so12272611pfc.10
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2020 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iNg4g6cNRZYUNuBsTO74IwcH6tuAcaZ/nzmuUCgI7YQ=;
        b=fN56Jr4nvW06HTQ13RJneqj6X8lflgmq6jlCoKsIPmknMl26RPKWCz8YEw1tHa1jYz
         2FHoKNebeuIlL6IVX9VRKW/oUm9eaZqm+8btqLQ+Nlcd1VZiHbmg/BoKSpmF3FoJIoqo
         6288KMRzjyYttljMBr1z60uAlr8s/UoWzpL6nPgZWUat7AqhnKexYi5cfsk+npyXYqtZ
         3A+h/dAOOUB0LJrFQh2qEQP/OiXhnOm9Q9/zvYNeu8l66371mJxlH2QimcYGjNM3gCyf
         QWaNg/ehOECHaLWi6uhhJ/vhW8Z0wBC8Td+0KrpsYSt+KrXhE1CCQbHvIvlrocKve+JL
         vPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iNg4g6cNRZYUNuBsTO74IwcH6tuAcaZ/nzmuUCgI7YQ=;
        b=Fv7z5X1ltD5BAtVCA+5yyr+mGyeBWDMHSEWc4xu6fR7w2PLz+soDTbIvu2zmrbNNTr
         gxPNxy75YJl/5h3a9xoqpWtu3Iw+tjJWJHy5KIXmVVWSE9b49nO1QWpGPq2eIymx4G22
         cuw2gF9nVUdAP4eZoAC8O4rvjhT5CRdfN+Den/ZYlkaXp0tRYX1oY2RilV+b9i4nPX3u
         VXTURFJ/IJrxn1+Nq6rdhX7lXtlFK30GXy56NGmXpf120x28CI67jtKynGLtFtNSeSv5
         dpuJYdaY88cfvixWSY9g4lFXITmLPPHeubv6czMpBcGEzEhbxug33MAh+yDRt2rDb1gh
         A0ag==
X-Gm-Message-State: APjAAAUiBvFIqM+P5qJw/ep7SLgb8wymYPxKDBqJq8vkZMOZS9RYlerh
        vlVeYEGTlQViiexilEmmZzGYHZGNg1M=
X-Google-Smtp-Source: APXvYqzkI7+HJc2DBEcUiBL1OG8evclCeD08SK626xi0qNNGMKZfjols95ySgh76BxNKtrvJ3r6rUEDzoXM=
X-Received: by 2002:a63:f202:: with SMTP id v2mr36549471pgh.420.1579149376256;
 Wed, 15 Jan 2020 20:36:16 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:36:11 -0800
Message-Id: <20200116043612.52782-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 1/2] cgroup: allow deletion of cgroups containing only dying processes
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        matthias.bgg@gmail.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, shuah@kernel.org, guro@fb.com,
        alex.shi@linux.alibaba.com, mkoutny@suse.com,
        linux-kselftest@vger.kernel.org, linger.lee@mediatek.com,
        tomcherry@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A cgroup containing only dying tasks will be seen as empty when a userspace
process reads its cgroup.procs or cgroup.tasks files. It should be safe to
delete such a cgroup as it is considered empty. However if one of the dying
tasks did not reach cgroup_exit then an attempt to delete the cgroup will
fail with EBUSY because cgroup_is_populated() will not consider it empty
until all tasks reach cgroup_exit. Such a condition can be triggered when
a task consumes large amounts of memory and spends enough time in exit_mm
to create delay between the moment it is flagged as PF_EXITING and the
moment it reaches cgroup_exit.
Fix this by detecting cgroups containing only dying tasks during cgroup
destruction and proceeding with it while postponing the final step of
releasing the last reference until the last task reaches cgroup_exit.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: JeiFeng Lee <linger.lee@mediatek.com>
Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads in PROCS iterations")
---
 include/linux/cgroup-defs.h |  3 ++
 kernel/cgroup/cgroup.c      | 65 +++++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63097cb243cb..f9bcccbac8dd 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -71,6 +71,9 @@ enum {
 
 	/* Cgroup is frozen. */
 	CGRP_FROZEN,
+
+	/* Cgroup is dead. */
+	CGRP_DEAD,
 };
 
 /* cgroup_root->flags */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..a99ebddd37d9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -795,10 +795,11 @@ static bool css_set_populated(struct css_set *cset)
  * that the content of the interface file has changed.  This can be used to
  * detect when @cgrp and its descendants become populated or empty.
  */
-static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
+static bool cgroup_update_populated(struct cgroup *cgrp, bool populated)
 {
 	struct cgroup *child = NULL;
 	int adj = populated ? 1 : -1;
+	bool state_change = false;
 
 	lockdep_assert_held(&css_set_lock);
 
@@ -817,6 +818,7 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 		if (was_populated == cgroup_is_populated(cgrp))
 			break;
 
+		state_change = true;
 		cgroup1_check_for_release(cgrp);
 		TRACE_CGROUP_PATH(notify_populated, cgrp,
 				  cgroup_is_populated(cgrp));
@@ -825,6 +827,21 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 		child = cgrp;
 		cgrp = cgroup_parent(cgrp);
 	} while (cgrp);
+
+	return state_change;
+}
+
+static void cgroup_prune_dead(struct cgroup *cgrp)
+{
+	lockdep_assert_held(&css_set_lock);
+
+	do {
+		/* put the base reference if cgroup was already destroyed */
+		if (!cgroup_is_populated(cgrp) &&
+		    test_bit(CGRP_DEAD, &cgrp->flags))
+			percpu_ref_kill(&cgrp->self.refcnt);
+		cgrp = cgroup_parent(cgrp);
+	} while (cgrp);
 }
 
 /**
@@ -838,11 +855,15 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 static void css_set_update_populated(struct css_set *cset, bool populated)
 {
 	struct cgrp_cset_link *link;
+	bool state_change;
 
 	lockdep_assert_held(&css_set_lock);
 
-	list_for_each_entry(link, &cset->cgrp_links, cgrp_link)
-		cgroup_update_populated(link->cgrp, populated);
+	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
+		state_change = cgroup_update_populated(link->cgrp, populated);
+		if (state_change && !populated)
+			cgroup_prune_dead(link->cgrp);
+	}
 }
 
 /*
@@ -5458,8 +5479,26 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	 * Only migration can raise populated from zero and we're already
 	 * holding cgroup_mutex.
 	 */
-	if (cgroup_is_populated(cgrp))
-		return -EBUSY;
+	if (cgroup_is_populated(cgrp)) {
+		struct css_task_iter it;
+		struct task_struct *task;
+
+		/*
+		 * cgroup_is_populated does not account for exiting tasks
+		 * that did not reach cgroup_exit yet. Check if all the tasks
+		 * in this cgroup are exiting.
+		 */
+		css_task_iter_start(&cgrp->self, 0, &it);
+		do {
+			task = css_task_iter_next(&it);
+		} while (task && (task->flags & PF_EXITING));
+		css_task_iter_end(&it);
+
+		if (task) {
+			/* cgroup is indeed populated */
+			return -EBUSY;
+		}
+	}
 
 	/*
 	 * Make sure there's no live children.  We can't test emptiness of
@@ -5510,8 +5549,20 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 
 	cgroup_bpf_offline(cgrp);
 
-	/* put the base reference */
-	percpu_ref_kill(&cgrp->self.refcnt);
+	/*
+	 * Take css_set_lock because of the possible race with
+	 * cgroup_update_populated.
+	 */
+	spin_lock_irq(&css_set_lock);
+	/* The last task might have died since we last checked */
+	if (cgroup_is_populated(cgrp)) {
+		/* mark cgroup for future destruction */
+		set_bit(CGRP_DEAD, &cgrp->flags);
+	} else {
+		/* put the base reference */
+		percpu_ref_kill(&cgrp->self.refcnt);
+	}
+	spin_unlock_irq(&css_set_lock);
 
 	return 0;
 };
-- 
2.25.0.rc1.283.g88dfdc4193-goog

