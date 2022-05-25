Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE6534028
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiEYPPc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbiEYPP3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 11:15:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10722B0433;
        Wed, 25 May 2022 08:15:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E407219EE;
        Wed, 25 May 2022 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653491727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tls0/nqHOIQNk1w3ReHoYvYzJRQedtJDKDjgdFYZ8bY=;
        b=XVCkXOLy6j3sLPyCCTKlGK2VYVNWbMyG053XXSuCzHKN7oLawqrxNsOE8CPr/MGxwIp+P0
        IFMV3sYal8Rya+zWeKRkik30FqoEwdhr6xXGge0P2g2UR2A6yuFc+vBLKonZuqFLkzN7lT
        HEHhxVeM7MwQHTLlWXs17J429qsjtOs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1214E13ADF;
        Wed, 25 May 2022 15:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qFtsAw9IjmLXAwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 25 May 2022 15:15:27 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH 1/2] cgroup: Wait for cgroup_subsys_state offlining on unmount
Date:   Wed, 25 May 2022 17:15:16 +0200
Message-Id: <20220525151517.8430-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525151517.8430-1-mkoutny@suse.com>
References: <20220525151517.8430-1-mkoutny@suse.com>
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

The reported problem here occurs when cgroup hierarchy is unmounted
quickly after last cgroup removal. The last cgroup prevents the root
cgroup css->refcnt from being killed. The respective cgroup root thus
remains permanently in existence.

This is actually intended behavior for memory controller whose state is
long-lived and there is no better option to attach it later (see also
commit 3c606d35fe97 ("cgroup: prevent mount hang due to memory
controller lifetime")).

We can make the situation better by checking children list only after
any cgroups in the middle of removal are gone, detected via
cgroup_destroy_wq.

Reported-by: Bui Quang Minh <minhquangbui99@gmail.com>
Link: https://lore.kernel.org/r/20220404142535.145975-1-minhquangbui99@gmail.com
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..a5b0d5d54fbc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2205,11 +2205,14 @@ static void cgroup_kill_sb(struct super_block *sb)
 	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
 
 	/*
-	 * If @root doesn't have any children, start killing it.
+	 * If @root doesn't have any children held by residual state (e.g.
+	 * memory controller), start killing it, flush workqueue to filter out
+	 * transiently offlined children.
 	 * This prevents new mounts by disabling percpu_ref_tryget_live().
 	 *
 	 * And don't kill the default root.
 	 */
+	flush_workqueue(cgroup_destroy_wq);
 	if (list_empty(&root->cgrp.self.children) && root != &cgrp_dfl_root &&
 	    !percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
 		cgroup_bpf_offline(&root->cgrp);
-- 
2.35.3

