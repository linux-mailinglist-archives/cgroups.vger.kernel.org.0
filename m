Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F25A2CD0
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiHZQxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344476AbiHZQxB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 12:53:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE3D13E;
        Fri, 26 Aug 2022 09:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08C541F949;
        Fri, 26 Aug 2022 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661532779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ji1E7MsAjBcqVqSFC5OGyfterDo89Vpl5wgi0w24b2M=;
        b=Io6WW/lReFEVoh0tfyG65yeK5q597USr4Ezze431kIQSvyKY1QYxepjQxV3ql44sWtofbX
        hNVvKkQfzzU0rpNHiECt8GFBaNvlmnpadC5ihjwByiJMu3sJtF5lb5fx+HO9UYgkl9e49E
        KIrXDEF6vjiXxrjlkJq/9h74MgAHJDE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0DE613A82;
        Fri, 26 Aug 2022 16:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QDM2Lmr6CGMofAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 26 Aug 2022 16:52:58 +0000
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
Subject: [PATCH 3/4] cgroup: Homogenize cgroup_get_from_id() return value
Date:   Fri, 26 Aug 2022 18:52:37 +0200
Message-Id: <20220826165238.30915-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220826165238.30915-1-mkoutny@suse.com>
References: <20220826165238.30915-1-mkoutny@suse.com>
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

Cgroup id is user provided datum hence extend its return domain to
include possible error reason (similar to cgroup_get_from_fd()).

This change also fixes commit d4ccaf58a847 ("bpf: Introduce cgroup
iter") that would use NULL instead of proper error handling in
d4ccaf58a847 ("bpf: Introduce cgroup iter").

Additionally, neither of: fc_appid_store, bpf_iter_attach_cgroup,
mem_cgroup_get_from_ino (callers of cgroup_get_from_fd) is built without
CONFIG_CGROUPS (depends via CONFIG_BLK_CGROUP, direct, transitive
CONFIG_MEMCG respectively) transitive, so drop the singular definition
not needed with !CONFIG_CGROUPS.

Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup-fc-appid.c | 4 ++--
 include/linux/cgroup.h      | 5 -----
 kernel/cgroup/cgroup.c      | 4 ++--
 mm/memcontrol.c             | 4 ++--
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/block/blk-cgroup-fc-appid.c b/block/blk-cgroup-fc-appid.c
index 760a2e1878dd..842e5e1c0f3c 100644
--- a/block/blk-cgroup-fc-appid.c
+++ b/block/blk-cgroup-fc-appid.c
@@ -19,8 +19,8 @@ int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
 		return -EINVAL;
 
 	cgrp = cgroup_get_from_id(cgrp_id);
-	if (!cgrp)
-		return -ENOENT;
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
 	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
 	if (!css) {
 		ret = -ENOENT;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed53bfe7c46c..b6a9528374a8 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -752,11 +752,6 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 
 static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {}
-
-static inline struct cgroup *cgroup_get_from_id(u64 id)
-{
-	return NULL;
-}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4ca90ee6b902..c0377726031f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6006,7 +6006,7 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup_get_from_id : get the cgroup associated with cgroup id
  * @id: cgroup id
- * On success return the cgrp, on failure return NULL
+ * On success return the cgrp or ERR_PTR on failure
  * Only cgroups within current task's cgroup NS are valid.
  */
 struct cgroup *cgroup_get_from_id(u64 id)
@@ -6038,7 +6038,7 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		cgrp = NULL;
 	}
 out:
-	return cgrp;
+	return cgrp ?: ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL_GPL(cgroup_get_from_id);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..86f5ca8c6fa6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5110,8 +5110,8 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 	struct mem_cgroup *memcg;
 
 	cgrp = cgroup_get_from_id(ino);
-	if (!cgrp)
-		return ERR_PTR(-ENOENT);
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
 
 	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
 	if (css)
-- 
2.37.0

