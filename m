Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32325F9AFE
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJJI3Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 04:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiJJI3Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 04:29:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC45FADA;
        Mon, 10 Oct 2022 01:29:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CF1621941;
        Mon, 10 Oct 2022 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665390562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0+wxjXvZ2b1azfCMhNMsVGmzlC6W42MvNjIgBFeRTo=;
        b=AfLrtPQiwpodUPdDAwLKLscDoCuhxd2V1PvYuUJhPxSt2//G8QE10PRDG6xe6jDXqoo2kN
        r51ir81dTFUVCp9bfkqBw2y1j7SyrT3S7MdG7L4qVvs2sbB2N28Qzw6GX/aXJNGRfcY5XA
        2ZnlE4DiCD9gRu9XEF8AibJd4tqdyvs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D94D13ACA;
        Mon, 10 Oct 2022 08:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gyn5BeLXQ2N/bwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 10 Oct 2022 08:29:22 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     tj@kernel.org
Cc:     cgroups@vger.kernel.org, dan.carpenter@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, mkoutny@suse.com
Subject: [PATCH v3] cgroup: Reorganize css_set_lock and kernfs path processing
Date:   Mon, 10 Oct 2022 10:29:18 +0200
Message-Id: <20221010082918.3821-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Yz21I9UpXafWMU0K@slm.duckdns.org>
References: <Yz21I9UpXafWMU0K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit 74e4b956eb1c incorrectly wrapped kernfs_walk_and_get
(might_sleep) under css_set_lock (spinlock). css_set_lock is needed by
__cset_cgroup_from_root to ensure stable cset->cgrp_links but not for
kernfs_walk_and_get.

We only need to make sure that the returned root_cgrp won't be freed
under us. This is given in the case of global root because it is static
(cgrp_dfl_root.cgrp). When the root_cgrp is lower in the hierarchy, it
is pinned by cgroup_ns->root_cset (and `current` task cannot switch
namespace asynchronously so ns_proxy pins cgroup_ns).

Note this reasoning won't hold for root cgroups in v1 hierarchies,
therefore create a special-cased helper function just for the default
hierarchy.

Fixes: 74e4b956eb1c ("cgroup: Honor caller's cgroup NS when resolving path")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

Tested only with test_core selftests (i.e. the path/id resolution not
checed, only the migration code).

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c37b8265c0a3..a7ec96f26997 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1392,6 +1392,9 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	cgroup_free_root(root);
 }
 
+/*
+ * Returned cgroup is without refcount but it's valid as long as cset pins it.
+ */
 static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 					    struct cgroup_root *root)
 {
@@ -1403,6 +1406,7 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 		res_cgroup = cset->dfl_cgrp;
 	} else {
 		struct cgrp_cset_link *link;
+		lockdep_assert_held(&css_set_lock);
 
 		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 			struct cgroup *c = link->cgrp;
@@ -1414,6 +1418,7 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
+	BUG_ON(!res_cgroup);
 	return res_cgroup;
 }
 
@@ -1436,23 +1441,37 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 
 	rcu_read_unlock();
 
-	BUG_ON(!res);
 	return res;
 }
 
+/*
+ * look up cgroup associated with current task's cgroup namespace on the
+ * default hierarchy
+ *
+ * Note this doesn't need locks unlike generic colleagues. Why?
+ * - Internal rcu_read_lock is unnecessary because we don't dereference any rcu
+ *   pointers.
+ * - css_set_lock is not needed because we just read cset->dfl_cgrp.
+ * - As a bonus returned cgrp is pinned with the current because it cannot
+ *   switch cgroup_ns asynchronously.
+ */
+static struct cgroup *
+current_cgns_cgroup_dfl(void)
+{
+	struct css_set *cset;
+
+	cset = current->nsproxy->cgroup_ns->root_cset;
+	return __cset_cgroup_from_root(cset, &cgrp_dfl_root);
+}
+
 /* look up cgroup associated with given css_set on the specified hierarchy */
 static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 					    struct cgroup_root *root)
 {
-	struct cgroup *res = NULL;
-
 	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
-	res = __cset_cgroup_from_root(cset, root);
-
-	BUG_ON(!res);
-	return res;
+	return __cset_cgroup_from_root(cset, root);
 }
 
 /*
@@ -6085,9 +6104,7 @@ struct cgroup *cgroup_get_from_id(u64 id)
 	if (!cgrp)
 		return ERR_PTR(-ENOENT);
 
-	spin_lock_irq(&css_set_lock);
-	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
-	spin_unlock_irq(&css_set_lock);
+	root_cgrp = current_cgns_cgroup_dfl();
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
 		cgroup_put(cgrp);
 		return ERR_PTR(-ENOENT);
@@ -6671,10 +6688,8 @@ struct cgroup *cgroup_get_from_path(const char *path)
 	struct cgroup *cgrp = ERR_PTR(-ENOENT);
 	struct cgroup *root_cgrp;
 
-	spin_lock_irq(&css_set_lock);
-	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
+	root_cgrp = current_cgns_cgroup_dfl();
 	kn = kernfs_walk_and_get(root_cgrp->kn, path);
-	spin_unlock_irq(&css_set_lock);
 	if (!kn)
 		goto out;
 
-- 
2.37.3

