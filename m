Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49FF5AD824
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIERKG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIERKG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 13:10:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56281580F;
        Mon,  5 Sep 2022 10:10:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C03535025;
        Mon,  5 Sep 2022 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662397803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3OBVlzrdocXXXTKTLgX42mUjjVVDDyYNMpF+eKmmtCQ=;
        b=TI8brioUhcbTj37ERGLmMeQ2UJM6oYa0WDG5ztQJfuPzEBQ12TugPu5sLcrLplpMvQ7eS/
        Kud9kF71PFFvZndsFipFQv52uLTLbx3TMiCwxg4XR2m3pPmsrHu2tcrH66+Wrp5CFYLIC0
        uejAfimdJr9AN0+Uw9yU/5qKSRtuBfk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DDD413A66;
        Mon,  5 Sep 2022 17:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D3VPDmstFmNmBwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 05 Sep 2022 17:10:03 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] cgroup: Reorganize css_set_lock and kernfs path processing
Date:   Mon,  5 Sep 2022 19:09:44 +0200
Message-Id: <20220905170944.23071-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit 74e4b956eb1c incorrectly wrapped kernfs_walk_and_get
(might_sleep) under css_set_lock (spinlock). css_set_lock is needed by
__cset_cgroup_from_root to ensure stable cset->cgrp_links. The returned
cgroup object is pinned by the css_set (*).

Because current cannot switch namespace asynchronously, the css_set is
also pinned by ns_proxy->cgroup_ns (regardless of current's cgroup
migration).

Kernfs code that traverses paths with relative root_cgroup not need
css_set_lock.

(*) Except for root cgroups. The default hierarchy root (under which
cgroup id and path resolution only happens) is eternal so it's moot.
cgroup_show_path (VFS callback) is expected to be synchronized (**) wrt
kill_sb (VFS callback) (mnt_namespace.list with namespace_sem).
(**) If not, it's still an independent issue from this and the fixed one.

Fixes: 74e4b956eb1c: ("cgroup: Honor caller's cgroup NS when resolving path")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

I considered adding get_cgroup() into current_cgns_cgroup_from_root to
avoid reliance on the transitive pinning via css_set. 
After reasoning about no asynchronous NS switch and v1 hiearchies kill_sb it
didn't seem to bring that much benefit (it didn't compose well with
BUG_ON(!cgrp) neither).

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e0b72eb5d283..8c9497f01332 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1391,11 +1391,16 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	cgroup_free_root(root);
 }
 
+/*
+ * Returned cgroup is without refcount but it's valid as long as cset pins it.
+ */
 static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 					    struct cgroup_root *root)
 {
 	struct cgroup *res_cgroup = NULL;
 
+	lockdep_assert_held(&css_set_lock);
+
 	if (cset == &init_css_set) {
 		res_cgroup = &root->cgrp;
 	} else if (root == &cgrp_dfl_root) {
@@ -1426,8 +1431,6 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 	struct cgroup *res = NULL;
 	struct css_set *cset;
 
-	lockdep_assert_held(&css_set_lock);
-
 	rcu_read_lock();
 
 	cset = current->nsproxy->cgroup_ns->root_cset;
@@ -1446,7 +1449,6 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 	struct cgroup *res = NULL;
 
 	lockdep_assert_held(&cgroup_mutex);
-	lockdep_assert_held(&css_set_lock);
 
 	res = __cset_cgroup_from_root(cset, root);
 
@@ -1861,8 +1863,8 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 
 	spin_lock_irq(&css_set_lock);
 	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
-	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
 	spin_unlock_irq(&css_set_lock);
+	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
 
 	if (len >= PATH_MAX)
 		len = -ERANGE;
@@ -6649,8 +6651,8 @@ struct cgroup *cgroup_get_from_path(const char *path)
 
 	spin_lock_irq(&css_set_lock);
 	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
-	kn = kernfs_walk_and_get(root_cgrp->kn, path);
 	spin_unlock_irq(&css_set_lock);
+	kn = kernfs_walk_and_get(root_cgrp->kn, path);
 	if (!kn)
 		goto out;
 

base-commit: a8c52eba880a6e8c07fc2130604f8e386b90b763
-- 
2.37.0

