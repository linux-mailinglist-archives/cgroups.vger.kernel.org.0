Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E621170552
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2020 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgBZRCn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 12:02:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45418 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgBZRCn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 12:02:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id a2so44310qko.12
        for <cgroups@vger.kernel.org>; Wed, 26 Feb 2020 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNn7CxQ+hq//pn/PulZRifgvcQBvCI4+PQUJoEu/xug=;
        b=VjeQVJp/oJaqz7FlhY8YwGK+rS6Lo1HEGw+YrrRnT5qSdFPVs3+TlXx2+jhWvDtadw
         z47wfAnWALLFfLFXohiWEQpvguzD+x+yH6ZkyfaJSDlswp8mXD7+1w4XOv3nBFq+7pZF
         n9/YuRGd69Kj3PhRCU+d+7gbeE8UrPqKu0a7aAYV6ZQS81bvwxuraaK23TCwtR7NIM+s
         W7Qc+gkOtozcx0XJ4RVZyHwX7dd9N8Q62RAnX/cXsnKQlJBbDiLl+uaR4dLIP+3XQBz/
         Uo3TYIGFQrl67CNZnxo60CCEiEWV+Vf0C6DV+WTL5gNm9XG6uXiM8DfiuSHnENcgonWd
         TK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNn7CxQ+hq//pn/PulZRifgvcQBvCI4+PQUJoEu/xug=;
        b=YKKlGxITiYadBw6veTx1dbx6TTbClei1LaYOkKEF1PBvqcPxbTndUwygTzDfSb50p0
         Dnxl3AWA3dLaiU3UD4a0+ZZhQyjP2LhakKZcikRYhdAxE2y2fPPfKY6r6f1ZTjmy2NGK
         tdKVzOX3y4FiXxZnDPjwlsxRbxPBeuM9BPJLiuqpLLcsDMR0IYdLT4MTC0ua62VeYnPE
         AT6FRidsKbjwDLO6DEouTMeOwopJxndx06Ns9TSUbv5Vf3pmc3xl944CB1OiL6v1vpFI
         pcDbPpQgI9JmJ1BpQZJ9b2bphvqUWAPBKa6p494aoB4YMknmFVGB0bDXtjMDCyKWHSAc
         iW3g==
X-Gm-Message-State: APjAAAUMXzHVVlsg187Y0Ll5pNJnZ/cQ6WFMtbjQss3yc8A3vpD+TTO1
        UQJ/HV3jhCgdo66l8yvG9xpO9g==
X-Google-Smtp-Source: APXvYqzQOrfTZe8cBJKFlDC1mkvU8Sj82vKZB8oUY5VfcwoY574xphoXvMbSz/pZXfvGElrnfKVEaw==
X-Received: by 2002:a37:4c81:: with SMTP id z123mr68087qka.320.1582736561890;
        Wed, 26 Feb 2020 09:02:41 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c10sm1450622qkb.4.2020.02.26.09.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:02:41 -0800 (PST)
Message-ID: <1582736558.7365.131.camel@lca.pw>
Subject: Re: [PATCH v3 1/3] loop: Use worker per cgroup instead of kworker
From:   Qian Cai <cai@lca.pw>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Date:   Wed, 26 Feb 2020 12:02:38 -0500
In-Reply-To: <eab018412a0c9feb573d757b1bbd5f58b33e2a8d.1582581887.git.schatzberg.dan@gmail.com>
References: <cover.1582581887.git.schatzberg.dan@gmail.com>
         <eab018412a0c9feb573d757b1bbd5f58b33e2a8d.1582581887.git.schatzberg.dan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-02-24 at 17:17 -0500, Dan Schatzberg wrote:
> Existing uses of loop device may have multiple cgroups reading/writing
> to the same device. Simply charging resources for I/O to the backing
> file could result in priority inversion where one cgroup gets
> synchronously blocked, holding up all other I/O to the loop device.
> 
> In order to avoid this priority inversion, we use a single workqueue
> where each work item is a "struct loop_worker" which contains a queue of
> struct loop_cmds to issue. The loop device maintains a tree mapping blk
> css_id -> loop_worker. This allows each cgroup to independently make
> forward progress issuing I/O to the backing file.
> 
> There is also a single queue for I/O associated with the rootcg which
> can be used in cases of extreme memory shortage where we cannot allocate
> a loop_worker.
> 
> The locking for the tree and queues is fairly heavy handed - we acquire
> the per-loop-device spinlock any time either is accessed. The existing
> implementation serializes all I/O through a single thread anyways, so I
> don't believe this is any worse.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

The locking in loop_free_idle_workers() will trigger this with sysfs reading,

[ 7080.047167] LTP: starting read_all_sys (read_all -d /sys -q -r 10)
[ 7239.842276] cpufreq transition table exceeds PAGE_SIZE. Disabling

[ 7247.054961] =====================================================
[ 7247.054971] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[ 7247.054983] 5.6.0-rc3-next-20200226 #2 Tainted: G           O     
[ 7247.054992] -----------------------------------------------------
[ 7247.055002] read_all/8513 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[ 7247.055014] c0000006844864c8 (&fs->seq){+.+.}, at: file_path+0x24/0x40
[ 7247.055041] 
               and this task is already holding:
[ 7247.055061] c0002006bab8b928 (&(&lo->lo_lock)->rlock){..-.}, at:
loop_attr_do_show_backing_file+0x3c/0x120 [loop]
[ 7247.055078] which would create a new lock dependency:
[ 7247.055105]  (&(&lo->lo_lock)->rlock){..-.} -> (&fs->seq){+.+.}
[ 7247.055125] 
               but this new dependency connects a SOFTIRQ-irq-safe lock:
[ 7247.055155]  (&(&lo->lo_lock)->rlock){..-.}
[ 7247.055156] 
               ... which became SOFTIRQ-irq-safe at:
[ 7247.055196]   lock_acquire+0x130/0x360
[ 7247.055221]   _raw_spin_lock_irq+0x68/0x90
[ 7247.055230]   loop_free_idle_workers+0x44/0x3f0 [loop]
[ 7247.055242]   call_timer_fn+0x110/0x5f0
[ 7247.055260]   run_timer_softirq+0x8f8/0x9f0
[ 7247.055278]   __do_softirq+0x34c/0x8c8
[ 7247.055288]   irq_exit+0x16c/0x1d0
[ 7247.055298]   timer_interrupt+0x1f0/0x680
[ 7247.055308]   decrementer_common+0x124/0x130
[ 7247.055328]   arch_local_irq_restore.part.8+0x34/0x90
[ 7247.055352]   cpuidle_enter_state+0x11c/0x8f0
[ 7247.055361]   cpuidle_enter+0x50/0x70
[ 7247.055389]   call_cpuidle+0x4c/0x90
[ 7247.055398]   do_idle+0x378/0x470
[ 7247.055414]   cpu_startup_entry+0x3c/0x40
[ 7247.055442]   start_secondary+0x7a8/0xa80
[ 7247.055461]   start_secondary_prolog+0x10/0x14
[ 7247.055478] 
               to a SOFTIRQ-irq-unsafe lock:
[ 7247.055506]  (&fs->seq){+.+.}
[ 7247.055507] 
               ... which became SOFTIRQ-irq-unsafe at:
[ 7247.055541] ...
[ 7247.055542]   lock_acquire+0x130/0x360
[ 7247.055577]   set_fs_pwd+0x98/0x140
[ 7247.055593]   ksys_chdir+0x8c/0x100
[ 7247.055611]   devtmpfsd+0xac/0xe0
[ 7247.055629]   kthread+0x1a8/0x1b0
[ 7247.055645]   ret_from_kernel_thread+0x5c/0x74
[ 7247.055663] 
               other info that might help us debug this:

[ 7247.055685]  Possible interrupt unsafe locking scenario:

[ 7247.055695]        CPU0                    CPU1
[ 7247.055712]        ----                    ----
[ 7247.055719]   lock(&fs->seq);
[ 7247.055748]                                local_irq_disable();
[ 7247.055776]                                lock(&(&lo->lo_lock)->rlock);
[ 7247.055805]                                lock(&fs->seq);
[ 7247.055825]   <Interrupt>
[ 7247.055840]     lock(&(&lo->lo_lock)->rlock);
[ 7247.055867] 
                *** DEADLOCK ***

[ 7247.055896] 5 locks held by read_all/8513:
[ 7247.055913]  #0: c000001afc46d708 (&p->lock){+.+.}, at: seq_read+0x60/0x620
[ 7247.055944]  #1: c000000f6ce00e80 (&of->mutex){+.+.}, at:
kernfs_seq_start+0x40/0x130
[ 7247.055981]  #2: c0002011b81e0010 (kn->count#685){.+.+}, at:
kernfs_seq_start+0x4c/0x130
[ 7247.056013]  #3: c0002006bab8b928 (&(&lo->lo_lock)->rlock){..-.}, at:
loop_attr_do_show_backing_file+0x3c/0x120 [loop]
[ 7247.056048]  #4: c000000001500888 (rcu_read_lock){....}, at:
d_path+0xa0/0x3f0
[ 7247.056072] 
               the dependencies between SOFTIRQ-irq-safe lock and the holding
lock:
[ 7247.056104] -> (&(&lo->lo_lock)->rlock){..-.} ops: 196198 {
[ 7247.056144]    IN-SOFTIRQ-W at:
[ 7247.056161]                     lock_acquire+0x130/0x360
[ 7247.056180]                     _raw_spin_lock_irq+0x68/0x90
[ 7247.056208]                     loop_free_idle_workers+0x44/0x3f0 [loop]
[ 7247.056238]                     call_timer_fn+0x110/0x5f0
[ 7247.056271]                     run_timer_softirq+0x8f8/0x9f0
[ 7247.056290]                     __do_softirq+0x34c/0x8c8
[ 7247.056318]                     irq_exit+0x16c/0x1d0
[ 7247.056337]                     timer_interrupt+0x1f0/0x680
[ 7247.056366]                     decrementer_common+0x124/0x130
[ 7247.056394]                     arch_local_irq_restore.part.8+0x34/0x90
[ 7247.056432]                     cpuidle_enter_state+0x11c/0x8f0
[ 7247.056460]                     cpuidle_enter+0x50/0x70
[ 7247.056480]                     call_cpuidle+0x4c/0x90
[ 7247.056498]                     do_idle+0x378/0x470
[ 7247.056516]                     cpu_startup_entry+0x3c/0x40
[ 7247.056535]                     start_secondary+0x7a8/0xa80
[ 7247.056554]                     start_secondary_prolog+0x10/0x14
[ 7247.056572]    INITIAL USE at:
[ 7247.056589]                    lock_acquire+0x130/0x360
[ 7247.056618]                    _raw_spin_lock_irq+0x68/0x90
[ 7247.056671]                    loop_queue_rq+0xf4/0x540 [loop]
[ 7247.056737]                    __blk_mq_try_issue_directly+0x1ac/0x2e0
[ 7247.056850]                    blk_mq_request_issue_directly+0x64/0xb0
[ 7247.056924]                    blk_mq_try_issue_list_directly+0x90/0x140
[ 7247.056988]                    blk_mq_sched_insert_requests+0x1c0/0x4b0
[ 7247.057070]                    blk_mq_flush_plug_list+0x1d0/0x4b0
[ 7247.057155]                    blk_flush_plug_list+0x148/0x1a0
[ 7247.057221]                    blk_finish_plug+0x50/0x6c
[ 7247.057285]                    read_pages+0xac/0x320
[ 7247.057344]                    __do_page_cache_readahead+0x198/0x350
[ 7247.057428]                    force_page_cache_readahead+0xcc/0x1b0
[ 7247.057505]                    generic_file_buffered_read+0x7d4/0xdd0
[ 7247.057577]                    blkdev_read_iter+0x50/0x80
[ 7247.057658]                    new_sync_read+0x15c/0x1f0
[ 7247.057723]                    vfs_read+0xac/0x170
[ 7247.057786]                    ksys_read+0x7c/0x140
[ 7247.057856]                    system_call+0x5c/0x68
[ 7247.057902]  }
[ 7247.057935]  ... key      at: [<c00800000fa6bbc8>]
__key.50783+0x0/0xffffffffffffc9b8 [loop]
[ 7247.058028]  ... acquired at:
[ 7247.058074]    lock_acquire+0x130/0x360
[ 7247.058126]    d_path+0x194/0x3f0
[ 7247.058174]    file_path+0x24/0x40
[ 7247.058225]    loop_attr_do_show_backing_file+0x5c/0x120 [loop]
[ 7247.058305]    dev_attr_show+0x44/0xb0
[ 7247.058354]    sysfs_kf_seq_show+0xbc/0x1d0
[ 7247.058421]    kernfs_seq_show+0x44/0x60
[ 7247.058458]    seq_read+0x1c4/0x620
[ 7247.058504]    kernfs_fop_read+0x40/0x2b0
[ 7247.058559]    __vfs_read+0x3c/0x70
[ 7247.058607]    vfs_read+0xac/0x170
[ 7247.058659]    ksys_read+0x7c/0x140
[ 7247.058722]    system_call+0x5c/0x68

[ 7247.058778] 
               the dependencies between the lock to be acquired
[ 7247.058779]  and SOFTIRQ-irq-unsafe lock:
[ 7247.058924] -> (&fs->seq){+.+.} ops: 22599070 {
[ 7247.058992]    HARDIRQ-ON-W at:
[ 7247.059043]                     lock_acquire+0x130/0x360
[ 7247.059108]                     set_fs_pwd+0x98/0x140
[ 7247.059179]                     ksys_chdir+0x8c/0x100
[ 7247.059262]                     devtmpfsd+0xac/0xe0
[ 7247.059318]                     kthread+0x1a8/0x1b0
[ 7247.059369]                     ret_from_kernel_thread+0x5c/0x74
[ 7247.059453]    SOFTIRQ-ON-W at:
[ 7247.059498]                     lock_acquire+0x130/0x360
[ 7247.059545]                     set_fs_pwd+0x98/0x140
[ 7247.059614]                     ksys_chdir+0x8c/0x100
[ 7247.059675]                     devtmpfsd+0xac/0xe0
[ 7247.059745]                     kthread+0x1a8/0x1b0
[ 7247.059804]                     ret_from_kernel_thread+0x5c/0x74
[ 7247.059884]    INITIAL USE at:
[ 7247.059929]                    lock_acquire+0x130/0x360
[ 7247.059994]                    set_root+0x118/0x220
[ 7247.060066]                    nd_jump_root+0x100/0x170
[ 7247.060111]                    path_init+0x640/0x7b0
[ 7247.060193]                    path_lookupat+0x3c/0x1b0
[ 7247.060257]                    filename_lookup.part.60+0xa0/0x170
[ 7247.060323]                    do_mount+0xa8/0xc00
[ 7247.060381]                    devtmpfsd+0x94/0xe0
[ 7247.060436]                    kthread+0x1a8/0x1b0
[ 7247.060481]                    ret_from_kernel_thread+0x5c/0x74
[ 7247.060563]  }
[ 7247.060597]  ... key      at: [<c00000000509c9e8>] __key.27999+0x0/0x10
[ 7247.060676]  ... acquired at:
[ 7247.060723]    lock_acquire+0x130/0x360
[ 7247.060768]    d_path+0x194/0x3f0
[ 7247.060810]    file_path+0x24/0x40
[ 7247.060869]    loop_attr_do_show_backing_file+0x5c/0x120 [loop]
[ 7247.060931]    dev_attr_show+0x44/0xb0
[ 7247.060988]    sysfs_kf_seq_show+0xbc/0x1d0
[ 7247.061042]    kernfs_seq_show+0x44/0x60
[ 7247.061116]    seq_read+0x1c4/0x620
[ 7247.061155]    kernfs_fop_read+0x40/0x2b0
[ 7247.061204]    __vfs_read+0x3c/0x70
[ 7247.061249]    vfs_read+0xac/0x170
[ 7247.061292]    ksys_read+0x7c/0x140
[ 7247.061341]    system_call+0x5c/0x68

> ---
>  drivers/block/loop.c | 207 +++++++++++++++++++++++++++++++++++++------
>  drivers/block/loop.h |  11 ++-
>  2 files changed, 188 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 739b372a5112..a9b05cacc393 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -70,7 +70,6 @@
>  #include <linux/writeback.h>
>  #include <linux/completion.h>
>  #include <linux/highmem.h>
> -#include <linux/kthread.h>
>  #include <linux/splice.h>
>  #include <linux/sysfs.h>
>  #include <linux/miscdevice.h>
> @@ -83,6 +82,8 @@
>  
>  #include <linux/uaccess.h>
>  
> +#define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
> +
>  static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
>  
> @@ -891,27 +892,100 @@ static void loop_config_discard(struct loop_device *lo)
>  
>  static void loop_unprepare_queue(struct loop_device *lo)
>  {
> -	kthread_flush_worker(&lo->worker);
> -	kthread_stop(lo->worker_task);
> -}
> -
> -static int loop_kthread_worker_fn(void *worker_ptr)
> -{
> -	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
> -	return kthread_worker_fn(worker_ptr);
> +	destroy_workqueue(lo->workqueue);
>  }
>  
>  static int loop_prepare_queue(struct loop_device *lo)
>  {
> -	kthread_init_worker(&lo->worker);
> -	lo->worker_task = kthread_run(loop_kthread_worker_fn,
> -			&lo->worker, "loop%d", lo->lo_number);
> -	if (IS_ERR(lo->worker_task))
> +	lo->workqueue = alloc_workqueue("loop%d",
> +					WQ_UNBOUND | WQ_FREEZABLE |
> +					WQ_MEM_RECLAIM,
> +					lo->lo_number);
> +	if (IS_ERR(lo->workqueue))
>  		return -ENOMEM;
> -	set_user_nice(lo->worker_task, MIN_NICE);
> +
>  	return 0;
>  }
>  
> +struct loop_worker {
> +	struct rb_node rb_node;
> +	struct work_struct work;
> +	struct list_head cmd_list;
> +	struct list_head idle_list;
> +	struct loop_device *lo;
> +	struct cgroup_subsys_state *css;
> +	unsigned long last_ran_at;
> +};
> +
> +static void loop_workfn(struct work_struct *work);
> +static void loop_rootcg_workfn(struct work_struct *work);
> +static void loop_free_idle_workers(struct timer_list *timer);
> +
> +static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> +{
> +	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
> +	struct loop_worker *cur_worker, *worker = NULL;
> +	struct work_struct *work;
> +	struct list_head *cmd_list;
> +
> +	spin_lock_irq(&lo->lo_lock);
> +
> +	if (!cmd->css)
> +		goto queue_work;
> +
> +	node = &lo->worker_tree.rb_node;
> +
> +	while (*node) {
> +		parent = *node;
> +		cur_worker = container_of(*node, struct loop_worker, rb_node);
> +		if (cur_worker->css == cmd->css) {
> +			worker = cur_worker;
> +			break;
> +		} else if ((long)cur_worker->css < (long)cmd->css) {
> +			node = &(*node)->rb_left;
> +		} else {
> +			node = &(*node)->rb_right;
> +		}
> +	}
> +	if (worker)
> +		goto queue_work;
> +
> +	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
> +	/*
> +	 * In the event we cannot allocate a worker, just queue on the
> +	 * rootcg worker
> +	 */
> +	if (!worker)
> +		goto queue_work;
> +
> +	worker->css = cmd->css;
> +	css_get(worker->css);
> +	INIT_WORK(&worker->work, loop_workfn);
> +	INIT_LIST_HEAD(&worker->cmd_list);
> +	INIT_LIST_HEAD(&worker->idle_list);
> +	worker->lo = lo;
> +	rb_link_node(&worker->rb_node, parent, node);
> +	rb_insert_color(&worker->rb_node, &lo->worker_tree);
> +queue_work:
> +	if (worker) {
> +		/*
> +		 * We need to remove from the idle list here while
> +		 * holding the lock so that the idle timer doesn't
> +		 * free the worker
> +		 */
> +		if (!list_empty(&worker->idle_list))
> +			list_del_init(&worker->idle_list);
> +		work = &worker->work;
> +		cmd_list = &worker->cmd_list;
> +	} else {
> +		work = &lo->rootcg_work;
> +		cmd_list = &lo->rootcg_cmd_list;
> +	}
> +	list_add_tail(&cmd->list_entry, cmd_list);
> +	queue_work(lo->workqueue, work);
> +	spin_unlock_irq(&lo->lo_lock);
> +}
> +
>  static void loop_update_rotational(struct loop_device *lo)
>  {
>  	struct file *file = lo->lo_backing_file;
> @@ -993,6 +1067,12 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  
>  	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
>  
> +	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
> +	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
> +	INIT_LIST_HEAD(&lo->idle_worker_list);
> +	lo->worker_tree = RB_ROOT;
> +	timer_setup(&lo->timer, loop_free_idle_workers,
> +		TIMER_DEFERRABLE);
>  	lo->use_dio = false;
>  	lo->lo_device = bdev;
>  	lo->lo_flags = lo_flags;
> @@ -1101,6 +1181,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	int err = 0;
>  	bool partscan = false;
>  	int lo_number;
> +	struct loop_worker *pos, *worker;
>  
>  	mutex_lock(&loop_ctl_mutex);
>  	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
> @@ -1117,9 +1198,28 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	/* freeze request queue during the transition */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> +	/*
> +	 * Ordering here is a bit tricky:
> +	 *
> +	 * 1) flush/destroy workqueue without lock held so outstanding
> +	 * I/O is issued and all active workers go idle
> +	 *
> +	 * 2) Grab lock, free all idle workers
> +	 *
> +	 * 3) unlock, del_timer_sync so if timer raced it will be a no-op
> +	 */
> +	loop_unprepare_queue(lo);
>  	spin_lock_irq(&lo->lo_lock);
>  	lo->lo_backing_file = NULL;
> +	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> +				idle_list) {
> +		list_del(&worker->idle_list);
> +		rb_erase(&worker->rb_node, &lo->worker_tree);
> +		css_put(worker->css);
> +		kfree(worker);
> +	}
>  	spin_unlock_irq(&lo->lo_lock);
> +	del_timer_sync(&lo->timer);
>  
>  	loop_release_xfer(lo);
>  	lo->transfer = NULL;
> @@ -1154,7 +1254,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  
>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
>  	lo_number = lo->lo_number;
> -	loop_unprepare_queue(lo);
>  out_unlock:
>  	mutex_unlock(&loop_ctl_mutex);
>  	if (partscan) {
> @@ -1932,7 +2031,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	} else
>  #endif
>  		cmd->css = NULL;
> -	kthread_queue_work(&lo->worker, &cmd->work);
> +	loop_queue_work(lo, cmd);
>  
>  	return BLK_STS_OK;
>  }
> @@ -1958,26 +2057,82 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>  	}
>  }
>  
> -static void loop_queue_work(struct kthread_work *work)
> +static void loop_set_timer(struct loop_device *lo)
> +{
> +	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
> +}
> +
> +static void loop_process_work(struct loop_worker *worker,
> +			struct list_head *cmd_list, struct loop_device *lo)
>  {
> -	struct loop_cmd *cmd =
> -		container_of(work, struct loop_cmd, work);
> +	int orig_flags = current->flags;
> +	struct loop_cmd *cmd;
>  
> -	loop_handle_cmd(cmd);
> +	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
> +	spin_lock_irq(&lo->lo_lock);
> +	while (!list_empty(cmd_list)) {
> +		cmd = container_of(
> +			cmd_list->next, struct loop_cmd, list_entry);
> +		list_del(cmd_list->next);
> +		spin_unlock_irq(&lo->lo_lock);
> +
> +		loop_handle_cmd(cmd);
> +		cond_resched();
> +
> +		spin_lock_irq(&lo->lo_lock);
> +	}
> +
> +	/*
> +	 * We only add to the idle list if there are no pending cmds
> +	 * *and* the worker will not run again which ensures that it
> +	 * is safe to free any worker on the idle list
> +	 */
> +	if (worker && !work_pending(&worker->work)) {
> +		worker->last_ran_at = jiffies;
> +		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
> +		loop_set_timer(lo);
> +	}
> +	spin_unlock_irq(&lo->lo_lock);
> +	current->flags = orig_flags;
>  }
>  
> -static int loop_init_request(struct blk_mq_tag_set *set, struct request *rq,
> -		unsigned int hctx_idx, unsigned int numa_node)
> +static void loop_workfn(struct work_struct *work)
>  {
> -	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
> +	struct loop_worker *worker =
> +		container_of(work, struct loop_worker, work);
> +	loop_process_work(worker, &worker->cmd_list, worker->lo);
> +}
>  
> -	kthread_init_work(&cmd->work, loop_queue_work);
> -	return 0;
> +static void loop_rootcg_workfn(struct work_struct *work)
> +{
> +	struct loop_device *lo =
> +		container_of(work, struct loop_device, rootcg_work);
> +	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
> +}
> +
> +static void loop_free_idle_workers(struct timer_list *timer)
> +{
> +	struct loop_device *lo = container_of(timer, struct loop_device, timer);
> +	struct loop_worker *pos, *worker;
> +
> +	spin_lock_irq(&lo->lo_lock);
> +	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> +				idle_list) {
> +		if (time_is_after_jiffies(worker->last_ran_at +
> +						LOOP_IDLE_WORKER_TIMEOUT))
> +			break;
> +		list_del(&worker->idle_list);
> +		rb_erase(&worker->rb_node, &lo->worker_tree);
> +		css_put(worker->css);
> +		kfree(worker);
> +	}
> +	if (!list_empty(&lo->idle_worker_list))
> +		loop_set_timer(lo);
> +	spin_unlock_irq(&lo->lo_lock);
>  }
>  
>  static const struct blk_mq_ops loop_mq_ops = {
>  	.queue_rq       = loop_queue_rq,
> -	.init_request	= loop_init_request,
>  	.complete	= lo_complete_rq,
>  };
>  
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index af75a5ee4094..87fd0e372227 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -14,7 +14,6 @@
>  #include <linux/blk-mq.h>
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
> -#include <linux/kthread.h>
>  #include <uapi/linux/loop.h>
>  
>  /* Possible states of device */
> @@ -54,8 +53,12 @@ struct loop_device {
>  
>  	spinlock_t		lo_lock;
>  	int			lo_state;
> -	struct kthread_worker	worker;
> -	struct task_struct	*worker_task;
> +	struct workqueue_struct *workqueue;
> +	struct work_struct      rootcg_work;
> +	struct list_head        rootcg_cmd_list;
> +	struct list_head        idle_worker_list;
> +	struct rb_root          worker_tree;
> +	struct timer_list       timer;
>  	bool			use_dio;
>  	bool			sysfs_inited;
>  
> @@ -65,7 +68,7 @@ struct loop_device {
>  };
>  
>  struct loop_cmd {
> -	struct kthread_work work;
> +	struct list_head list_entry;
>  	bool use_aio; /* use AIO interface to handle I/O */
>  	atomic_t ref; /* only for aio */
>  	long ret;
