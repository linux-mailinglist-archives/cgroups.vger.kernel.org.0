Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88010557AA8
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiFWMtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 08:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFWMty (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 08:49:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A197AF7;
        Thu, 23 Jun 2022 05:49:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5775321CF0;
        Thu, 23 Jun 2022 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655988592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BpiM3WaUUrILmHdp2lQvwMWVmqbs3l954A33quMGSGc=;
        b=tGaK1rJF5yQLBwU3wsJb/DC1CovTKZR2kv5oNn202GvQV1fxqwnUFJ0eR8tYrObFN1JUdO
        uCFcgVAWjs44/9iBd/5Mbp/9p+7CGwocTSCrYzm9a+iXnGQsZ1wdwoGbo+crUxA+hVZ1wy
        3YI6OfhQFBSg/Ex3HSzeIT2cfHNU8Fg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22B7C13461;
        Thu, 23 Jun 2022 12:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mW+vBnBhtGKMFQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 23 Jun 2022 12:49:52 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] cpuset: Allow setscheduler regardless of manipulated task
Date:   Thu, 23 Jun 2022 14:49:44 +0200
Message-Id: <20220623124944.2753-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
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

When we migrate a task between two cgroups, one of the checks is a
verification that we can modify task's scheduler settings
(cap_task_setscheduler()).

An implicit migration occurs also when enabling a controller on the
unified hierarchy (think of parent to child migration). The
aforementioned check may be problematic if the caller of the migration
(enabling a controller) has no permissions over migrated tasks.
For instance, user's cgroup that ends up running a process of a
different user. Although cgroup permissions are configured favorably,
the enablement fails due to the foreign process [1].

Change the behavior by relaxing the permissions check on the unified
hierarchy (or in v2 mode). This is in accordance with unified hierarchy
attachment behavior when permissions of the source to target cgroups are
decisive whereas the migrated task is opaque (for contrast, see more
restrictive check in __cgroup1_procs_write()).

[1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649

Reasons for RFC:

1) The unified hierarchy attachment behavior -- is that the
   right/consented model that migrated objects don't matter?

2) If 1) is true, have I missed any danger in allowing cpuset'ing a
   possibly privileged processes?

2.2) cpuset may be in v2 mode even on v1 hierarchy with different
   migration control rules (but checking migratee's creds in v1
   eliminates effect of this patch).

3) Alternative approach would be to allow cpuset migrations only when
   nothing effectively changes (which is the case for parent->child
   migration upon controller enablement).

4) This is just idea draft, not tested in the real case.

Thanks.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71a418858a5e..dbe78577de5b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2232,7 +2232,9 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 
 	percpu_down_write(&cpuset_rwsem);
 
-	/* allow moving tasks into an empty cpuset if on default hierarchy */
+	/* allow moving tasks into an empty cpuset if on default hierarchy,
+	 * also bypass permission check (access is controlled via cgroup(s)
+	 * owner in cgroup_procs_write_permission()) */
 	ret = -ENOSPC;
 	if (!is_in_v2_mode() &&
 	    (cpumask_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed)))
@@ -2242,6 +2244,9 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		ret = task_can_attach(task, cs->cpus_allowed);
 		if (ret)
 			goto out_unlock;
+
+		if (is_in_v2_mode())
+			continue;
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
-- 
2.35.3

