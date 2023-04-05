Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6AE6D7D7C
	for <lists+cgroups@lfdr.de>; Wed,  5 Apr 2023 15:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbjDENPj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Apr 2023 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjDENPj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Apr 2023 09:15:39 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030624203
        for <cgroups@vger.kernel.org>; Wed,  5 Apr 2023 06:15:36 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 335DFYEb075646;
        Wed, 5 Apr 2023 22:15:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 05 Apr 2023 22:15:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 335DFYqQ075643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Apr 2023 22:15:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
Date:   Wed, 5 Apr 2023 22:15:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH] cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <00000000000009483d05ec7a6b93@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000009483d05ec7a6b93@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot is reporting circular locking dependency between cpu_hotplug_lock
and freezer_mutex, for commit f5d39b020809 ("freezer,sched: Rewrite core
freezer logic") replaced atomic_inc() in freezer_apply_state() with
static_branch_inc() which holds cpu_hotplug_lock.

cpu_hotplug_lock => cgroup_threadgroup_rwsem => freezer_mutex

  cgroup_file_write() {
    cgroup_procs_write() {
      __cgroup_procs_write() {
        cgroup_procs_write_start() {
          cgroup_attach_lock() {
            cpus_read_lock() {
              percpu_down_read(&cpu_hotplug_lock);
            }
            percpu_down_write(&cgroup_threadgroup_rwsem);
          }
        }
        cgroup_attach_task() {
          cgroup_migrate() {
            cgroup_migrate_execute() {
              freezer_attach() {
                mutex_lock(&freezer_mutex);
                (...snipped...)
              }
            }
          }
        }
        (...snipped...)
      }
    }
  }

freezer_mutex => cpu_hotplug_lock

  cgroup_file_write() {
    freezer_write() {
      freezer_change_state() {
        mutex_lock(&freezer_mutex);
        freezer_apply_state() {
          static_branch_inc(&freezer_active) {
            static_key_slow_inc() {
              cpus_read_lock();
              static_key_slow_inc_cpuslocked();
              cpus_read_unlock();
            }
          }
        }
        mutex_unlock(&freezer_mutex);
      }
    }
  }

Swap locking order by moving cpus_read_lock() in freezer_apply_state()
to before mutex_lock(&freezer_mutex) in freezer_change_state().

Reported-by: syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
Suggested-by: Hillf Danton <hdanton@sina.com>
Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/cgroup/legacy_freezer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 1b6b21851e9d..936473203a6b 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -22,6 +22,7 @@
 #include <linux/freezer.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
+#include <linux/cpu.h>
 
 /*
  * A cgroup is freezing if any FREEZING flags are set.  FREEZING_SELF is
@@ -350,7 +351,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
 
 	if (freeze) {
 		if (!(freezer->state & CGROUP_FREEZING))
-			static_branch_inc(&freezer_active);
+			static_branch_inc_cpuslocked(&freezer_active);
 		freezer->state |= state;
 		freeze_cgroup(freezer);
 	} else {
@@ -361,7 +362,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
 		if (!(freezer->state & CGROUP_FREEZING)) {
 			freezer->state &= ~CGROUP_FROZEN;
 			if (was_freezing)
-				static_branch_dec(&freezer_active);
+				static_branch_dec_cpuslocked(&freezer_active);
 			unfreeze_cgroup(freezer);
 		}
 	}
@@ -379,6 +380,7 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
 {
 	struct cgroup_subsys_state *pos;
 
+	cpus_read_lock();
 	/*
 	 * Update all its descendants in pre-order traversal.  Each
 	 * descendant will try to inherit its parent's FREEZING state as
@@ -407,6 +409,7 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
 	}
 	rcu_read_unlock();
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 }
 
 static ssize_t freezer_write(struct kernfs_open_file *of,
-- 
2.34.1

