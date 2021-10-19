Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163DB432BCB
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 04:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhJSCbS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 22:31:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14826 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhJSCbR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 22:31:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYHcS0hhCz90Jb;
        Tue, 19 Oct 2021 10:24:08 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 10:28:58 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 10:28:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <avanzini.arianna@gmail.com>, <fchecconi@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 -next 2/2] blk-cgroup: synchoronize blkg creation against policy deactivation
Date:   Tue, 19 Oct 2021 10:41:32 +0800
Message-ID: <20211019024132.432458-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019024132.432458-1-yukuai3@huawei.com>
References: <20211019024132.432458-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Out test report a null pointer dereference:

[  168.534653] ==================================================================
[  168.535614] Disabling lock debugging due to kernel taint
[  168.536346] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  168.537274] #PF: supervisor read access in kernel mode
[  168.537964] #PF: error_code(0x0000) - not-present page
[  168.538667] PGD 0 P4D 0
[  168.539025] Oops: 0000 [#1] PREEMPT SMP KASAN
[  168.539656] CPU: 13 PID: 759 Comm: bash Tainted: G    B             5.15.0-rc2-next-202100
[  168.540954] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_0738364
[  168.542736] RIP: 0010:bfq_pd_init+0x88/0x1e0
[  168.543318] Code: 98 00 00 00 e8 c9 e4 5b ff 4c 8b 65 00 49 8d 7c 24 08 e8 bb e4 5b ff 4d0
[  168.545803] RSP: 0018:ffff88817095f9c0 EFLAGS: 00010002
[  168.546497] RAX: 0000000000000001 RBX: ffff888101a1c000 RCX: 0000000000000000
[  168.547438] RDX: 0000000000000003 RSI: 0000000000000002 RDI: ffff888106553428
[  168.548402] RBP: ffff888106553400 R08: ffffffff961bcaf4 R09: 0000000000000001
[  168.549365] R10: ffffffffa2e16c27 R11: fffffbfff45c2d84 R12: 0000000000000000
[  168.550291] R13: ffff888101a1c098 R14: ffff88810c7a08c8 R15: ffffffffa55541a0
[  168.551221] FS:  00007fac75227700(0000) GS:ffff88839ba80000(0000) knlGS:0000000000000000
[  168.552278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.553040] CR2: 0000000000000008 CR3: 0000000165ce7000 CR4: 00000000000006e0
[  168.554000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  168.554929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  168.555888] Call Trace:
[  168.556221]  <TASK>
[  168.556510]  blkg_create+0x1c0/0x8c0
[  168.556989]  blkg_conf_prep+0x574/0x650
[  168.557502]  ? stack_trace_save+0x99/0xd0
[  168.558033]  ? blkcg_conf_open_bdev+0x1b0/0x1b0
[  168.558629]  tg_set_conf.constprop.0+0xb9/0x280
[  168.559231]  ? kasan_set_track+0x29/0x40
[  168.559758]  ? kasan_set_free_info+0x30/0x60
[  168.560344]  ? tg_set_limit+0xae0/0xae0
[  168.560853]  ? do_sys_openat2+0x33b/0x640
[  168.561383]  ? do_sys_open+0xa2/0x100
[  168.561877]  ? __x64_sys_open+0x4e/0x60
[  168.562383]  ? __kasan_check_write+0x20/0x30
[  168.562951]  ? copyin+0x48/0x70
[  168.563390]  ? _copy_from_iter+0x234/0x9e0
[  168.563948]  tg_set_conf_u64+0x17/0x20
[  168.564467]  cgroup_file_write+0x1ad/0x380
[  168.565014]  ? cgroup_file_poll+0x80/0x80
[  168.565568]  ? __mutex_lock_slowpath+0x30/0x30
[  168.566165]  ? pgd_free+0x100/0x160
[  168.566649]  kernfs_fop_write_iter+0x21d/0x340
[  168.567246]  ? cgroup_file_poll+0x80/0x80
[  168.567796]  new_sync_write+0x29f/0x3c0
[  168.568314]  ? new_sync_read+0x410/0x410
[  168.568840]  ? __handle_mm_fault+0x1c97/0x2d80
[  168.569425]  ? copy_page_range+0x2b10/0x2b10
[  168.570007]  ? _raw_read_lock_bh+0xa0/0xa0
[  168.570622]  vfs_write+0x46e/0x630
[  168.571091]  ksys_write+0xcd/0x1e0
[  168.571563]  ? __x64_sys_read+0x60/0x60
[  168.572081]  ? __kasan_check_write+0x20/0x30
[  168.572659]  ? do_user_addr_fault+0x446/0xff0
[  168.573264]  __x64_sys_write+0x46/0x60
[  168.573774]  do_syscall_64+0x35/0x80
[  168.574264]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  168.574960] RIP: 0033:0x7fac74915130
[  168.575456] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 444
[  168.577969] RSP: 002b:00007ffc3080e288 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  168.578986] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007fac74915130
[  168.579937] RDX: 0000000000000009 RSI: 000056007669f080 RDI: 0000000000000001
[  168.580884] RBP: 000056007669f080 R08: 000000000000000a R09: 00007fac75227700
[  168.581841] R10: 000056007655c8f0 R11: 0000000000000246 R12: 0000000000000009
[  168.582796] R13: 0000000000000001 R14: 00007fac74be55e0 R15: 00007fac74be08c0
[  168.583757]  </TASK>
[  168.584063] Modules linked in:
[  168.584494] CR2: 0000000000000008
[  168.584964] ---[ end trace 2475611ad0f77a1a ]---

This is because blkg_alloc() is called from blkg_conf_prep() without
holding 'q->queue_lock', and elevator is exited before blkg_create():

thread 1                            thread 2
blkg_conf_prep
 spin_lock_irq(&q->queue_lock);
 blkg_lookup_check -> return NULL
 spin_unlock_irq(&q->queue_lock);

 blkg_alloc
  blkcg_policy_enabled -> true
  pd = ->pd_alloc_fn
  blkg->pd[i] = pd
                                   blk_mq_exit_sched
                                    bfq_exit_queue
                                     blkcg_deactivate_policy
                                      spin_lock_irq(&q->queue_lock);
                                      __clear_bit(pol->plid, q->blkcg_pols);
                                      spin_unlock_irq(&q->queue_lock);
                                    q->elevator = NULL;
  spin_lock_irq(&q->queue_lock);
   blkg_create
    if (blkg->pd[i])
     ->pd_init_fn -> q->elevator is NULL
  spin_unlock_irq(&q->queue_lock);

Because blkcg_deactivate_policy() require queue to be freezed, thus grab
q_usage_counter to synchoronize blkg_conf_prep() against
blkcg_deactivate_policy().

Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ca60233c8392..e11b7e28b1b2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -634,6 +634,14 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 	q = bdev_get_queue(bdev);
 
+	/*
+	 * blkcg_deactivate_policy() require queue to be freezed, thus grab
+	 * q_usage_counter to prevent concurrent with blkcg_deactivate_policy().
+	 */
+	ret = blk_queue_enter(q, 0);
+	if (ret)
+		return ret;
+
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
@@ -703,6 +711,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto success;
 	}
 success:
+	blk_queue_exit(q);
 	ctx->bdev = bdev;
 	ctx->blkg = blkg;
 	ctx->body = input;
@@ -715,6 +724,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	rcu_read_unlock();
 fail:
 	blkdev_put_no_open(bdev);
+	blk_queue_exit(q);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
-- 
2.31.1

