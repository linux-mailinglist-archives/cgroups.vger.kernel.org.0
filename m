Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5055EDBD1
	for <lists+cgroups@lfdr.de>; Wed, 28 Sep 2022 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiI1LdV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Sep 2022 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1LdU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Sep 2022 07:33:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DC82878;
        Wed, 28 Sep 2022 04:33:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CD631F9A5;
        Wed, 28 Sep 2022 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664364798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2mgymyLYQSEBITlSU1B1GuO4Bx/FQHXI8TQ8CJx3tk=;
        b=bN1H8DRBbqY2qZfqYkrDVdsihILQFlH7+D1I6FyL/1qnGLAhzw2Oe3+4jqpCw1uUCBn9b/
        ZceXP1aSUUHTD9cSy4Z5hS8xyPJL8JrN3fZb94Bt5FBYPfm6JbJHAT1jXui1/CJcpq2Xwg
        HvUMNYFdpSLsyG7RVbQDWUaW0a+Imkk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30B0F13677;
        Wed, 28 Sep 2022 11:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ac6jCv4wNGOQJgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 28 Sep 2022 11:33:18 +0000
Date:   Wed, 28 Sep 2022 13:33:16 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] cgroup: Reorganize css_set_lock and kernfs path processing
Message-ID: <YzQw/EvH9Sb58Au2@blackbook>
References: <20220905170944.23071-1-mkoutny@suse.com>
 <Yxd/sUQ/NB3NlC6f@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxd/sUQ/NB3NlC6f@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

(Note this reasoning won't hold for root cgroups in v1 hierarchies but
the path resolution works only with the default hierarchy.)

Fixes: 74e4b956eb1c: ("cgroup: Honor caller's cgroup NS when resolving path")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Hello.

v2: dropped changes around kernfs_path_from_node(), reworded commit
    message

I realized the pinning with reference taking won't really work
generally. The code would get the reference within RCU read section, so
it'd have to be cgroup_get_live() and if that fails there's not much to
do.

So, instead of generalization, I only post special-cased patch that
fixes the introduced bug and doesn't touch the rest.

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c37b8265c0a3..ac71af8ef65c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1392,11 +1392,16 @@ static void cgroup_destroy_root(struct cgroup_root *root)
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
@@ -6673,8 +6678,8 @@ struct cgroup *cgroup_get_from_path(const char *path)
 
 	spin_lock_irq(&css_set_lock);
 	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
-	kn = kernfs_walk_and_get(root_cgrp->kn, path);
 	spin_unlock_irq(&css_set_lock);
+	kn = kernfs_walk_and_get(root_cgrp->kn, path);
 	if (!kn)
 		goto out;
 
-- 
2.37.3

