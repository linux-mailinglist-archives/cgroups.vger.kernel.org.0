Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1C72B21F
	for <lists+cgroups@lfdr.de>; Sun, 11 Jun 2023 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjFKNtM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 11 Jun 2023 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKNtL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 11 Jun 2023 09:49:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CE187
        for <cgroups@vger.kernel.org>; Sun, 11 Jun 2023 06:49:09 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35BDmUaO019460;
        Sun, 11 Jun 2023 22:48:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 11 Jun 2023 22:48:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35BDmEfx019412
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Jun 2023 22:48:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <69ab449f-1981-2d53-79fb-b2ac91ea9cef@I-love.SAKURA.ne.jp>
Date:   Sun, 11 Jun 2023 22:48:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH] cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in
 freezer_css_{online,offline}()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
References: <000000000000bd448705fda123f5@google.com>
 <000000000000d1565005fda9cef1@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d1565005fda9cef1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot is again reporting circular locking dependency between
cpu_hotplug_lock and freezer_mutex. Do like what we did with
commit 57dcd64c7e036299 ("cgroup,freezer: hold cpu_hotplug_lock
before freezer_mutex").

Reported-by: syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=2ab700fe1829880a2ec6
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
---
 kernel/cgroup/legacy_freezer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 936473203a6b..122dacb3a443 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -108,16 +108,18 @@ static int freezer_css_online(struct cgroup_subsys_state *css)
 	struct freezer *freezer = css_freezer(css);
 	struct freezer *parent = parent_freezer(freezer);
 
+	cpus_read_lock();
 	mutex_lock(&freezer_mutex);
 
 	freezer->state |= CGROUP_FREEZER_ONLINE;
 
 	if (parent && (parent->state & CGROUP_FREEZING)) {
 		freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
-		static_branch_inc(&freezer_active);
+		static_branch_inc_cpuslocked(&freezer_active);
 	}
 
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 	return 0;
 }
 
@@ -132,14 +134,16 @@ static void freezer_css_offline(struct cgroup_subsys_state *css)
 {
 	struct freezer *freezer = css_freezer(css);
 
+	cpus_read_lock();
 	mutex_lock(&freezer_mutex);
 
 	if (freezer->state & CGROUP_FREEZING)
-		static_branch_dec(&freezer_active);
+		static_branch_dec_cpuslocked(&freezer_active);
 
 	freezer->state = 0;
 
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 }
 
 static void freezer_css_free(struct cgroup_subsys_state *css)
-- 
2.18.4

