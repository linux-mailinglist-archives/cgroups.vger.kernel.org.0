Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733DA5A2CC8
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbiHZQxD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbiHZQxB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 12:53:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21CB3D;
        Fri, 26 Aug 2022 09:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE3A81F940;
        Fri, 26 Aug 2022 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661532778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqsTghk3lUf2zHqs/aiods7p+Uf7TePr7J7612j6zrs=;
        b=p34Dq3Vuy2HqGPFdeYH7O52fSFA8g/UAZmA7N24XfyIGdml3BtgZVdhx2Ej3Y+oAbrTlKY
        Ex0mtRWCzPU8+v7ioOeQRhqkNknKuL4HiP1/msumCtrA/zMXjEFZl3H51bRZznXNrCWaPm
        cepNDpurKY/9ucFIoDCyWyVnaQi/rus=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86C8113A7E;
        Fri, 26 Aug 2022 16:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OL79H2r6CGMofAAAMHmgww
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
Subject: [PATCH 2/4] cgroup: cgroup: Honor caller's cgroup NS when resolving cgroup id
Date:   Fri, 26 Aug 2022 18:52:36 +0200
Message-Id: <20220826165238.30915-3-mkoutny@suse.com>
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

Cgroup ids are resolved in the global scope. That may be needed sometime
(in future) but currently it violates virtual view provided through
cgroup namespaces.

There are currently following users of the resolution:
- fc_appid_store
- bpf_iter_attach_cgroup
- mem_cgroup_get_from_ino

None of the is a called on behalf of kernel but the resolution is made
with proper userspace context, hence the default to current->nsproxy
makes sens. (This doesn't rule out cgroup_get_from_id with cgroup NS
parameter in the future.)

Since cgroup ids are defined on v2 hierarchy only, we simply check
existence in the cgroup namespace by looking at ancestry on the default
hierarchy.

Fixes: 6b658c4863c1 ("scsi: cgroup: Add cgroup_get_from_id()")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1a8b50d15ebf..4ca90ee6b902 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6007,11 +6007,12 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  * cgroup_get_from_id : get the cgroup associated with cgroup id
  * @id: cgroup id
  * On success return the cgrp, on failure return NULL
+ * Only cgroups within current task's cgroup NS are valid.
  */
 struct cgroup *cgroup_get_from_id(u64 id)
 {
 	struct kernfs_node *kn;
-	struct cgroup *cgrp = NULL;
+	struct cgroup *cgrp = NULL, *root_cgrp;
 
 	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
@@ -6024,8 +6025,18 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		cgrp = NULL;
 
 	rcu_read_unlock();
-
 	kernfs_put(kn);
+
+	if (!cgrp)
+		goto out;
+
+	spin_lock_irq(&css_set_lock);
+	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
+	spin_unlock_irq(&css_set_lock);
+	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
+		cgroup_put(cgrp);
+		cgrp = NULL;
+	}
 out:
 	return cgrp;
 }
-- 
2.37.0

