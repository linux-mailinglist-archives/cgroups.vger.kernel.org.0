Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE55A2CD5
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbiHZQxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344615AbiHZQxB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 12:53:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32212AD6;
        Fri, 26 Aug 2022 09:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46B12336B4;
        Fri, 26 Aug 2022 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661532779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAT+HbYA8AiuL1IZx0uK6pAdzXLKQU6eTml9pacvrDQ=;
        b=E2icuEnaJOofHI7HbH7GmPRTqNDQ6cuVu/tzJk/IGT4qxLXxpxiP6CiTWWTXoomAMgmzvF
        TGmuEwwVED6BQApstrm0xs1lHvruBWuj+5qGkVD0r/BS56ypSf/s5S+2pF7FGbd52LDg+r
        HE5pByM8aeXv+r7JFPf/t20xJPO8E1A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BD7A13A7E;
        Fri, 26 Aug 2022 16:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yB+PAWv6CGMofAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 26 Aug 2022 16:52:59 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for ancestors
Date:   Fri, 26 Aug 2022 18:52:38 +0200
Message-Id: <20220826165238.30915-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220826165238.30915-1-mkoutny@suse.com>
References: <20220826165238.30915-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The iterator with BPF_CGROUP_ITER_ANCESTORS_UP can traverse up across a
cgroup namespace level, which may be surprising within a non-init cgroup
namespace.

Introduce and use a new cgroup_parent_ns() helper that stops according
to cgroup namespace boundary. With BPF_CGROUP_ITER_ANCESTORS_UP. We use
the cgroup namespace of the iterator caller, not that one of the creator
(might be different, the former is relevant).

Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup.h   |  3 +++
 kernel/bpf/cgroup_iter.c |  9 ++++++---
 kernel/cgroup/cgroup.c   | 32 +++++++++++++++++++++++---------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b6a9528374a8..b63a80e03fae 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -858,6 +858,9 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
 int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 		   struct cgroup_namespace *ns);
 
+struct cgroup *cgroup_parent_ns(struct cgroup *cgrp,
+				struct cgroup_namespace *ns);
+
 #else /* !CONFIG_CGROUPS */
 
 static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index c69bce2f4403..06ee4a0c5870 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -104,6 +104,7 @@ static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct cgroup_subsys_state *curr = (struct cgroup_subsys_state *)v;
 	struct cgroup_iter_priv *p = seq->private;
+	struct cgroup *parent;
 
 	++*pos;
 	if (p->terminate)
@@ -113,9 +114,11 @@ static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return css_next_descendant_pre(curr, p->start_css);
 	else if (p->order == BPF_CGROUP_ITER_DESCENDANTS_POST)
 		return css_next_descendant_post(curr, p->start_css);
-	else if (p->order == BPF_CGROUP_ITER_ANCESTORS_UP)
-		return curr->parent;
-	else  /* BPF_CGROUP_ITER_SELF_ONLY */
+	else if (p->order == BPF_CGROUP_ITER_ANCESTORS_UP) {
+		parent = cgroup_parent_ns(curr->cgroup,
+					  current->nsproxy->cgroup_ns);
+		return parent ? &parent->self : NULL;
+	} else  /* BPF_CGROUP_ITER_SELF_ONLY */
 		return NULL;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c0377726031f..d60b5dfbbbc9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1417,11 +1417,11 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 }
 
 /*
- * look up cgroup associated with current task's cgroup namespace on the
+ * look up cgroup associated with given cgroup namespace on the
  * specified hierarchy
  */
-static struct cgroup *
-current_cgns_cgroup_from_root(struct cgroup_root *root)
+static struct cgroup *cgns_cgroup_from_root(struct cgroup_root *root,
+					    struct cgroup_namespace *ns)
 {
 	struct cgroup *res = NULL;
 	struct css_set *cset;
@@ -1430,7 +1430,7 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 
 	rcu_read_lock();
 
-	cset = current->nsproxy->cgroup_ns->root_cset;
+	cset = ns->root_cset;
 	res = __cset_cgroup_from_root(cset, root);
 
 	rcu_read_unlock();
@@ -1852,15 +1852,15 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	int len = 0;
 	char *buf = NULL;
 	struct cgroup_root *kf_cgroot = cgroup_root_from_kf(kf_root);
-	struct cgroup *ns_cgroup;
+	struct cgroup *root_cgroup;
 
 	buf = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	spin_lock_irq(&css_set_lock);
-	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
-	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
+	root_cgroup = cgns_cgroup_from_root(kf_cgroot, current->nsproxy->cgroup_ns);
+	len = kernfs_path_from_node(kf_node, root_cgroup->kn, buf, PATH_MAX);
 	spin_unlock_irq(&css_set_lock);
 
 	if (len >= PATH_MAX)
@@ -2330,6 +2330,18 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 }
 EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
+struct cgroup *cgroup_parent_ns(struct cgroup *cgrp,
+				   struct cgroup_namespace *ns)
+{
+	struct cgroup *root_cgrp;
+
+	spin_lock_irq(&css_set_lock);
+	root_cgrp = cgns_cgroup_from_root(cgrp->root, ns);
+	spin_unlock_irq(&css_set_lock);
+
+	return cgrp == root_cgrp ? NULL : cgroup_parent(cgrp);
+}
+
 /**
  * task_cgroup_path - cgroup path of a task in the first cgroup hierarchy
  * @task: target task
@@ -6031,7 +6043,8 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		goto out;
 
 	spin_lock_irq(&css_set_lock);
-	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
+	root_cgrp = cgns_cgroup_from_root(&cgrp_dfl_root,
+					  current->nsproxy->cgroup_ns);
 	spin_unlock_irq(&css_set_lock);
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
 		cgroup_put(cgrp);
@@ -6612,7 +6625,8 @@ struct cgroup *cgroup_get_from_path(const char *path)
 	struct cgroup *root_cgrp;
 
 	spin_lock_irq(&css_set_lock);
-	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
+	root_cgrp = cgns_cgroup_from_root(&cgrp_dfl_root,
+					  current->nsproxy->cgroup_ns);
 	kn = kernfs_walk_and_get(root_cgrp->kn, path);
 	spin_unlock_irq(&css_set_lock);
 	if (!kn)
-- 
2.37.0

