Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491D6F5839
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 14:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjECMyX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjECMyU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 08:54:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107BA59FB;
        Wed,  3 May 2023 05:54:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7B38227F7;
        Wed,  3 May 2023 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683118442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XGQuVbsJSpb3XLS+PmIsQvClRUbeKXxErey9Ewqz9fM=;
        b=chZi2O4e9/GB1oKRKC9Hfqkl6IfrkSSPGMUBfDu9Vj7bOqk3o22tv2oyX3AvbbHqWiE8xK
        FQGsfFkRsAvGEXzIwnGGKoI7/5atVK12eFnEpLC8iBeRSvv6QsESycZXHZ6S2Wa/i/OSIU
        OexiNAKjs9f7vG6vfdJfQ4anBsioP8M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 983AE13584;
        Wed,  3 May 2023 12:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ojRRJGpZUmSWDQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 03 May 2023 12:54:02 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: [RFC PATCH] cgroup: Return error when attempting to migrate a zombie process
Date:   Wed,  3 May 2023 14:53:59 +0200
Message-Id: <20230503125359.14789-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Zombies aren't migrated. However, return value of a migration write may
suggest a zombie process was migrated and causing confusion about lack
of cgroup.events:populated between origin and target cgroups (e.g.
target cgroup rmdir).

Notify the users about no effect of their action by a return value.
(update_dfl_csses migration of zombies still silently passes since it is
not meant to be user-visible migration anyway.)

Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Reasons for RFC:
1) Some users may notice the change,
2) EINVAL vs ESCHR,
3) add a selftest?

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..306547dd7b76 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2968,7 +2968,8 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 * become trapped in a cpuset, or RT kthread may be born in a
 	 * cgroup with no rt_runtime allocated.  Just say no.
 	 */
-	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
+	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY) ||
+	    !atomic_read(&tsk->signal->live)) {
 		tsk = ERR_PTR(-EINVAL);
 		goto out_unlock_threadgroup;
 	}
-- 
2.40.1

