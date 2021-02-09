Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4457E3153FE
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhBIQfs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 11:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhBIQfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 11:35:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9FC061793
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 08:33:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v206so6870031qkb.3
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoxwI0nES4Hx21nz5hFrVEbR6q3U+ATuwnBq1WqiBSo=;
        b=JEGh5aBSlUc0YLYixdyqw/xzahcK0uaeG+hw0TEsjqKFTzzP36AoxgqEAzDplt7L/b
         R53iTdq/RKxEVr8FlOQ8XJHKLxlTMaibaWRJQrenVN4v4vaMQcRym6aQrZKrgsPL4kOt
         Z+URDgU5QK7aVX9Z7dT+nN2cE8xRzlG9/G+DQ2J8hAPRJK5gpr2aGEaXvkOWog8VshxB
         4lvjUPXBafPUauCZQIUGTFIzC/0cAcmsqZQxeDpWCimO9dW/RrKYwSGWvI3pkPdx6jiY
         9c9zvViQ4Mqc6lYUujzhyfmcaNROIYI00xvnIQq8rEOVu6ZyeAXrmdyP7AelOVgQRr2U
         +N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoxwI0nES4Hx21nz5hFrVEbR6q3U+ATuwnBq1WqiBSo=;
        b=dw9dXr5/6D8PzmDVWQyFRjJo7sBBDS07skOfj1Xj5U427NAKbNf5uKy4zLuuIbM6+d
         3nI3eo45hfhvNgAeTPTLXbWXo7KJtO/xiAqGtxdGXBDUmqD2/qRNfIjd0mNROMXtlKEo
         7WFwufxuhjL46rkUIe2KmF6NkjEaiUlSDkgUM6cMMpWkK6Bneg6e5Y89H2D6giRpYKo9
         LlH8R2hMxbtUoaCXDW3zVQUsn1UcpemA3yMYofiVYT2vl5z6c9LxpQER8Fr1aEyGXKZK
         toHZK27aCDOpZDX5JA2SYfWTtzwgahsIgvME0Ql5bbBlD0oOsninmxsQd4NNy87pedMM
         RxLg==
X-Gm-Message-State: AOAM533n0+UW8g+twPesMUPba9RTjQJ5TS+sKRP3A8aj9HViwBgk/DVn
        ils8qbkj6mBWfyQ9nzuWT326gw==
X-Google-Smtp-Source: ABdhPJxtbFicxB3FjhdFv+V5RyYR98K5+Ha4zIdUItu9q0SOHyIbyp1J/nc3TIB9gazSI+gagzpJ2w==
X-Received: by 2002:a37:a9d6:: with SMTP id s205mr23278961qke.162.1612888412871;
        Tue, 09 Feb 2021 08:33:32 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 82sm2310585qkd.48.2021.02.09.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:32 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 4/8] cgroup: rstat: support cgroup1
Date:   Tue,  9 Feb 2021 11:33:00 -0500
Message-Id: <20210209163304.77088-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Rstat currently only supports the default hierarchy in cgroup2. In
order to replace memcg's private stats infrastructure - used in both
cgroup1 and cgroup2 - with rstat, the latter needs to support cgroup1.

The initialization and destruction callbacks for regular cgroups are
already in place. Remove the cgroup_on_dfl() guards to handle cgroup1.

The initialization of the root cgroup is currently hardcoded to only
handle cgrp_dfl_root.cgrp. Move those callbacks to cgroup_setup_root()
and cgroup_destroy_root() to handle the default root as well as the
various cgroup1 roots we may set up during mounting.

The linking of css to cgroups happens in code shared between cgroup1
and cgroup2 as well. Simply remove the cgroup_on_dfl() guard.

Linkage of the root css to the root cgroup is a bit trickier: per
default, the root css of a subsystem controller belongs to the default
hierarchy (i.e. the cgroup2 root). When a controller is mounted in its
cgroup1 version, the root css is stolen and moved to the cgroup1 root;
on unmount, the css moves back to the default hierarchy. Annotate
rebind_subsystems() to move the root css linkage along between roots.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c | 34 +++++++++++++++++++++-------------
 kernel/cgroup/rstat.c  |  2 --
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20e5cc6..e049edd66776 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1339,6 +1339,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	mutex_unlock(&cgroup_mutex);
 
+	cgroup_rstat_exit(cgrp);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -1751,6 +1752,12 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 				       &dcgrp->e_csets[ss->id]);
 		spin_unlock_irq(&css_set_lock);
 
+		if (ss->css_rstat_flush) {
+			list_del_rcu(&css->rstat_css_node);
+			list_add_rcu(&css->rstat_css_node,
+				     &dcgrp->rstat_css_list);
+		}
+
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
 		if (dst_root == &cgrp_dfl_root) {
@@ -1971,10 +1978,14 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = rebind_subsystems(root, ss_mask);
+	ret = cgroup_rstat_init(root_cgrp);
 	if (ret)
 		goto destroy_root;
 
+	ret = rebind_subsystems(root, ss_mask);
+	if (ret)
+		goto exit_stats;
+
 	ret = cgroup_bpf_inherit(root_cgrp);
 	WARN_ON_ONCE(ret);
 
@@ -2006,6 +2017,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	ret = 0;
 	goto out;
 
+exit_stats:
+	cgroup_rstat_exit(root_cgrp);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -4934,8 +4947,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			if (cgroup_on_dfl(cgrp))
-				cgroup_rstat_exit(cgrp);
+			cgroup_rstat_exit(cgrp);
 			kfree(cgrp);
 		} else {
 			/*
@@ -4976,8 +4988,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		if (cgroup_on_dfl(cgrp))
-			cgroup_rstat_flush(cgrp);
+		cgroup_rstat_flush(cgrp);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5034,7 +5045,7 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (cgroup_on_dfl(cgrp) && ss->css_rstat_flush)
+	if (ss->css_rstat_flush)
 		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
 
 	BUG_ON(cgroup_css(cgrp, ss));
@@ -5159,11 +5170,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	if (cgroup_on_dfl(parent)) {
-		ret = cgroup_rstat_init(cgrp);
-		if (ret)
-			goto out_cancel_ref;
-	}
+	ret = cgroup_rstat_init(cgrp);
+	if (ret)
+		goto out_cancel_ref;
 
 	/* create the directory */
 	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
@@ -5250,8 +5259,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	if (cgroup_on_dfl(parent))
-		cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(cgrp);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d51175cedfca..faa767a870ba 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -285,8 +285,6 @@ void __init cgroup_rstat_boot(void)
 
 	for_each_possible_cpu(cpu)
 		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
-
-	BUG_ON(cgroup_rstat_init(&cgrp_dfl_root.cgrp));
 }
 
 /*
-- 
2.30.0

