Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A202534026
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiEYPPd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiEYPP3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 11:15:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BCDB043B;
        Wed, 25 May 2022 08:15:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6ED0B1F897;
        Wed, 25 May 2022 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653491727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U46sVGA1KUZXQikRUajt78EcsqZuBl8M4p/DB6/tVgE=;
        b=C4m3v6uP9vSwVlZGU1QI7oR1B8lKsARQbrKwIPAyVOq4Zywe1QM7r5RuFo4rfrcFeB+oK1
        b92ZdIszTgbTgGCVvszf0KkL5V95soSXeZgur3d/X49AtEvhF0Zdo8b9fGPd7hUeCITXTy
        +71UMub165Q2Vn/W590QZNe0rh21SWI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41D3A13B2B;
        Wed, 25 May 2022 15:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPIUDw9IjmLXAwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 25 May 2022 15:15:27 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH 2/2] cgroup: Use separate work structs on css release path
Date:   Wed, 25 May 2022 17:15:17 +0200
Message-Id: <20220525151517.8430-3-mkoutny@suse.com>
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

The cgroup_subsys_state of cgroup subsystems (not cgroup->self) use both
kill and release callbacks on their release path (see comment for
css_free_rwork_fn()).

When the last reference is also the base reference, we run into issues
when active work_struct (1) is re-initialized from css_release (2).

// ref=1: only base reference
kill_css()
  css_get() // fuse, ref+=1 == 2
  percpu_ref_kill_and_confirm
    // ref -= 1 == 1: kill base references
  [via rcu]
  css_killed_ref_fn == refcnt.confirm_switch
    queue_work(css->destroy_work)               (1)
    [via css->destroy_work]
    css_killed_work_fn == wq.func
      offline_css() // needs fuse
      css_put // ref -= 1 == 0: de-fuse, was last
        ...
        percpu_ref_put_many
           css_release
             queue_work(css->destroy_work)      (2)
             [via css->destroy_work]
             css_release_work_fn == wq.func

Despite we take a fuse reference in css_killed_work_fn() it serves
for pinning the css until only after offline_css().

We could check inside css_release whether destroy_work is active
(WORK_STRUCT_PENDING_BIT) and daisy-chain css_release_work_fn from
css_release(). In order to avoid clashes with various stages of the work
item processing, we just spend some space in css (my config's css grows
to 232B + 32B) and create a separate work entry for each user.

Reported-by: syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
Reported-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Link: https://lore.kernel.org/r/20220412192459.227740-1-tadeusz.struk@linaro.org/
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h |  5 +++--
 kernel/cgroup/cgroup.c      | 14 +++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1bfcfb1af352..16b99aa04305 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -178,8 +178,9 @@ struct cgroup_subsys_state {
 	 */
 	atomic_t online_cnt;
 
-	/* percpu_ref killing and RCU release */
-	struct work_struct destroy_work;
+	/* percpu_ref killing, css release, and RCU release work structs */
+	struct work_struct killed_ref_work;
+	struct work_struct release_work;
 	struct rcu_work destroy_rwork;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a5b0d5d54fbc..33b3a44391d7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5102,7 +5102,7 @@ static struct cftype cgroup_base_files[] = {
  *    css_free_work_fn().
  *
  * It is actually hairier because both step 2 and 4 require process context
- * and thus involve punting to css->destroy_work adding two additional
+ * and thus involve punting to css->release_work adding two additional
  * steps to the already complex sequence.
  */
 static void css_free_rwork_fn(struct work_struct *work)
@@ -5157,7 +5157,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 static void css_release_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+		container_of(work, struct cgroup_subsys_state, release_work);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
@@ -5213,8 +5213,8 @@ static void css_release(struct percpu_ref *ref)
 	struct cgroup_subsys_state *css =
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
-	INIT_WORK(&css->destroy_work, css_release_work_fn);
-	queue_work(cgroup_destroy_wq, &css->destroy_work);
+	INIT_WORK(&css->release_work, css_release_work_fn);
+	queue_work(cgroup_destroy_wq, &css->release_work);
 }
 
 static void init_and_link_css(struct cgroup_subsys_state *css,
@@ -5549,7 +5549,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 static void css_killed_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+		container_of(work, struct cgroup_subsys_state, killed_ref_work);
 
 	mutex_lock(&cgroup_mutex);
 
@@ -5570,8 +5570,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	if (atomic_dec_and_test(&css->online_cnt)) {
-		INIT_WORK(&css->destroy_work, css_killed_work_fn);
-		queue_work(cgroup_destroy_wq, &css->destroy_work);
+		INIT_WORK(&css->killed_ref_work, css_killed_work_fn);
+		queue_work(cgroup_destroy_wq, &css->killed_ref_work);
 	}
 }
 
-- 
2.35.3

