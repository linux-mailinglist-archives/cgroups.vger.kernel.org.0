Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658C6D7DB8
	for <lists+cgroups@lfdr.de>; Wed,  5 Apr 2023 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjDEN33 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Apr 2023 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbjDEN32 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Apr 2023 09:29:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE473C0E
        for <cgroups@vger.kernel.org>; Wed,  5 Apr 2023 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b38y5OO+Pu+FU71x7pn6dlqxneSXJJRUN91gQWZb96w=; b=rmEa4H7D6J3xE2N8lZe3eUSXu4
        pq0qlD/LiAA5obGvoNDOiUmTXjINOAWo7Ac16KrFXG37jlYxKAoH66C8dH+ngI5b8P+oMajCufoOz
        UMC6HbIcTNrWrHXzahDN3I7dNQiIIiDNOEGWKr6msxsbfEUWatj6rrcct7v8ocVx1VpYpEdFCsTN5
        E28aAkImO7sB2+Yx+QJb/ANVdVdzZpDMb3DiFc0tcEqzOYOlVHOaEr1x+RuocpJCdTLfsr0vn/sqA
        tIk6D81FHsO8aeqWcNfuSpHaggiKfzawRuMMtzQs/Ksj/yhENst/d48uZ/5+c+mwNA2M0wJ/8s1Y4
        FVBvJmPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk3Bl-00GPkB-33; Wed, 05 Apr 2023 13:28:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C10E8300202;
        Wed,  5 Apr 2023 15:28:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75F7C21440F7B; Wed,  5 Apr 2023 15:28:33 +0200 (CEST)
Date:   Wed, 5 Apr 2023 15:28:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>,
        syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] cgroup,freezer: hold cpu_hotplug_lock before
 freezer_mutex
Message-ID: <20230405132833.GC351571@hirez.programming.kicks-ass.net>
References: <00000000000009483d05ec7a6b93@google.com>
 <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 05, 2023 at 10:15:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between cpu_hotplug_lock
> and freezer_mutex, for commit f5d39b020809 ("freezer,sched: Rewrite core
> freezer logic") replaced atomic_inc() in freezer_apply_state() with
> static_branch_inc() which holds cpu_hotplug_lock.
> 
> cpu_hotplug_lock => cgroup_threadgroup_rwsem => freezer_mutex
> 
>   cgroup_file_write() {
>     cgroup_procs_write() {
>       __cgroup_procs_write() {
>         cgroup_procs_write_start() {
>           cgroup_attach_lock() {
>             cpus_read_lock() {
>               percpu_down_read(&cpu_hotplug_lock);
>             }
>             percpu_down_write(&cgroup_threadgroup_rwsem);
>           }
>         }
>         cgroup_attach_task() {
>           cgroup_migrate() {
>             cgroup_migrate_execute() {
>               freezer_attach() {
>                 mutex_lock(&freezer_mutex);
>                 (...snipped...)
>               }
>             }
>           }
>         }
>         (...snipped...)
>       }
>     }
>   }
> 
> freezer_mutex => cpu_hotplug_lock
> 
>   cgroup_file_write() {
>     freezer_write() {
>       freezer_change_state() {
>         mutex_lock(&freezer_mutex);
>         freezer_apply_state() {
>           static_branch_inc(&freezer_active) {
>             static_key_slow_inc() {
>               cpus_read_lock();
>               static_key_slow_inc_cpuslocked();
>               cpus_read_unlock();
>             }
>           }
>         }
>         mutex_unlock(&freezer_mutex);
>       }
>     }
>   }
> 
> Swap locking order by moving cpus_read_lock() in freezer_apply_state()
> to before mutex_lock(&freezer_mutex) in freezer_change_state().
> 
> Reported-by: syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/cgroup/legacy_freezer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
> index 1b6b21851e9d..936473203a6b 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -22,6 +22,7 @@
>  #include <linux/freezer.h>
>  #include <linux/seq_file.h>
>  #include <linux/mutex.h>
> +#include <linux/cpu.h>
>  
>  /*
>   * A cgroup is freezing if any FREEZING flags are set.  FREEZING_SELF is
> @@ -350,7 +351,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
>  
>  	if (freeze) {
>  		if (!(freezer->state & CGROUP_FREEZING))
> -			static_branch_inc(&freezer_active);
> +			static_branch_inc_cpuslocked(&freezer_active);
>  		freezer->state |= state;
>  		freeze_cgroup(freezer);
>  	} else {
> @@ -361,7 +362,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
>  		if (!(freezer->state & CGROUP_FREEZING)) {
>  			freezer->state &= ~CGROUP_FROZEN;
>  			if (was_freezing)
> -				static_branch_dec(&freezer_active);
> +				static_branch_dec_cpuslocked(&freezer_active);
>  			unfreeze_cgroup(freezer);
>  		}
>  	}
> @@ -379,6 +380,7 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
>  {
>  	struct cgroup_subsys_state *pos;
>  
> +	cpus_read_lock();
>  	/*
>  	 * Update all its descendants in pre-order traversal.  Each
>  	 * descendant will try to inherit its parent's FREEZING state as
> @@ -407,6 +409,7 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
>  	}
>  	rcu_read_unlock();
>  	mutex_unlock(&freezer_mutex);
> +	cpus_read_unlock();
>  }
>  
>  static ssize_t freezer_write(struct kernfs_open_file *of,
> -- 
> 2.34.1
> 
