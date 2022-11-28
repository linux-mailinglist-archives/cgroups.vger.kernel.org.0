Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496DD63AC24
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiK1PXf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 10:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiK1PXc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 10:23:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34032AEE;
        Mon, 28 Nov 2022 07:23:31 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLTk36zDZzmW9G;
        Mon, 28 Nov 2022 23:22:51 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 23:23:30 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 23:23:29 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 7/8] blk-iocost: fix possible UAF in ioc_pd_free
Date:   Mon, 28 Nov 2022 23:44:33 +0800
Message-ID: <20221128154434.4177442-8-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128154434.4177442-1-linan122@huawei.com>
References: <20221128154434.4177442-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Our test found the following problem in kernel 5.10, and the same problem
should exist in mainline:

  BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
  Write of size 4 at addr ffff8881432000e0 by task swapper/4/0
  ...
  Call Trace:
   <IRQ>
   dump_stack+0x9c/0xd3
   print_address_description.constprop.0+0x19/0x170
   __kasan_report.cold+0x6c/0x84
   kasan_report+0x3a/0x50
   check_memory_region+0xfd/0x1f0
   _raw_spin_lock_irqsave+0x71/0xe0
   ioc_pd_free+0x9d/0x250
   blkg_free.part.0+0x80/0x100
   __blkg_release+0xf3/0x1c0
   rcu_do_batch+0x292/0x700
   rcu_core+0x270/0x2d0
   __do_softirq+0xfd/0x402
    </IRQ>
   asm_call_irq_on_stack+0x12/0x20
   do_softirq_own_stack+0x37/0x50
   irq_exit_rcu+0x134/0x1a0
   sysvec_apic_timer_interrupt+0x36/0x80
   asm_sysvec_apic_timer_interrupt+0x12/0x20

   Freed by task 57:
   kfree+0xba/0x680
   rq_qos_exit+0x5a/0x80
   blk_cleanup_queue+0xce/0x1a0
   virtblk_remove+0x77/0x130 [virtio_blk]
   virtio_dev_remove+0x56/0xe0
   __device_release_driver+0x2ba/0x450
   device_release_driver+0x29/0x40
   bus_remove_device+0x1d8/0x2c0
   device_del+0x333/0x7e0
   device_unregister+0x27/0x90
   unregister_virtio_device+0x22/0x40
   virtio_pci_remove+0x53/0xb0
   pci_device_remove+0x7a/0x130
   __device_release_driver+0x2ba/0x450
   device_release_driver+0x29/0x40
   pci_stop_bus_device+0xcf/0x100
   pci_stop_and_remove_bus_device+0x16/0x20
   disable_slot+0xa1/0x110
   acpiphp_disable_and_eject_slot+0x35/0xe0
   hotplug_event+0x1b8/0x3c0
   acpiphp_hotplug_notify+0x37/0x70
   acpi_device_hotplug+0xee/0x320
   acpi_hotplug_work_fn+0x69/0x80
   process_one_work+0x3c5/0x730
   worker_thread+0x93/0x650
   kthread+0x1ba/0x210
   ret_from_fork+0x22/0x30

It happened as follow:

	T1		    T2			T3
  //rmdir cgroup
  blkcg_destroy_blkgs
   blkg_destroy
    percpu_ref_kill
     blkg_release
      call_rcu
			//delete device
			del_gendisk
			 rq_qos_exit
			  ioc_rqos_exit
			   kfree(ioc)
					   __blkg_release
					    blkg_free
					     blkg_free_workfn
					      pd_free_fn
					       ioc_pd_free
						spin_lock_irqsave
						 ->ioc is freed

Fix the problem by moving the operation on ioc in ioc_pd_free() to
ioc_pd_offline(), and just free resource in ioc_pd_free() like iolatency
and throttle.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-iocost.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 03977385449f..1b855babfc35 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2978,7 +2978,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
-static void ioc_pd_free(struct blkg_policy_data *pd)
+static void ioc_pd_offline(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct ioc *ioc = iocg->ioc;
@@ -3002,6 +3002,12 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 
 		hrtimer_cancel(&iocg->waitq_timer);
 	}
+}
+
+static void ioc_pd_free(struct blkg_policy_data *pd)
+{
+	struct ioc_gq *iocg = pd_to_iocg(pd);
+
 	free_percpu(iocg->pcpu_stat);
 	kfree(iocg);
 }
@@ -3488,6 +3494,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
 	.cpd_free_fn	= ioc_cpd_free,
 	.pd_alloc_fn	= ioc_pd_alloc,
 	.pd_init_fn	= ioc_pd_init,
+	.pd_offline_fn	= ioc_pd_offline,
 	.pd_free_fn	= ioc_pd_free,
 	.pd_stat_fn	= ioc_pd_stat,
 };
-- 
2.31.1

