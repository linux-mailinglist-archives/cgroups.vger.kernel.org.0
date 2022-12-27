Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4987E656AFF
	for <lists+cgroups@lfdr.de>; Tue, 27 Dec 2022 13:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiL0Mel (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Dec 2022 07:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiL0Mek (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Dec 2022 07:34:40 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FECEB2C;
        Tue, 27 Dec 2022 04:34:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NhDcS0VQDz4f3kpQ;
        Tue, 27 Dec 2022 20:34:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbBZ5qpjAnByAg--.34791S6;
        Tue, 27 Dec 2022 20:34:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 2/2] blk-iocost: add refcounting for ioc
Date:   Tue, 27 Dec 2022 20:55:02 +0800
Message-Id: <20221227125502.541931-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221227125502.541931-1-yukuai1@huaweicloud.com>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbBZ5qpjAnByAg--.34791S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fWrW5KFWUuFW3GF1xKrg_yoWrAw48pF
        43W3s8C3ykWrnruwsxJF4xtryrAayY9w1xurs3Grna9F13X3s0q3WkAryjgFy5WFZxXrW3
        ZF1vgrW5JF4j9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfwIDUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

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

Root cause is that blkg_free() can be asynchronously, and it can race
with delete device:

T1			T2		T3
//delete device
del_gendisk
 bdi_unregister
  bdi_remove_from_list
   synchronize_rcu_expedited

			//rmdir cgroup
			blkcg_destroy_blkgs
			 blkg_destroy
			  percpu_ref_kill
			   blkg_release
			    call_rcu
 rq_qos_exit
  ioc_rqos_exit
   kfree(ioc)
					__blkg_release
					 blkg_free
					  blkg_free_workfn
					   pd_free_fn
					    ioc_pd_free
					     spin_lock_irqsave

Fix the problem by add refcounting for ioc, and iocg will grab reference
of ioc, so that ioc won't be freed until all the iocg is exited.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 525e93e1175a..d168d3f5f78e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -404,6 +404,7 @@ struct ioc_pcpu_stat {
 struct ioc {
 	struct rq_qos			rqos;
 
+	refcount_t			ref;
 	bool				enabled;
 
 	struct ioc_params		params;
@@ -2816,6 +2817,12 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
 	spin_unlock_irq(&ioc->lock);
 }
 
+static void ioc_put(struct ioc *ioc)
+{
+	if (refcount_dec_and_test(&ioc->ref))
+		kfree(ioc);
+}
+
 static void ioc_rqos_exit(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
@@ -2828,7 +2835,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&ioc->timer);
 	free_percpu(ioc->pcpu_stat);
-	kfree(ioc);
+	ioc_put(ioc);
 }
 
 static struct rq_qos_ops ioc_rqos_ops = {
@@ -2883,6 +2890,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	ioc->period_at = ktime_to_us(ktime_get());
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
+	refcount_set(&ioc->ref, 1);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->autop_idx = AUTOP_INVALID;
@@ -2983,6 +2991,7 @@ static void iocg_put(struct ioc_gq *iocg)
 		spin_unlock_irqrestore(&ioc->lock, flags);
 
 		hrtimer_cancel(&iocg->waitq_timer);
+		ioc_put(ioc);
 	}
 
 	free_percpu(iocg->pcpu_stat);
@@ -3004,6 +3013,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	ioc_now(ioc, &now);
 
 	iocg->ioc = ioc;
+	refcount_inc(&ioc->ref);
 	atomic64_set(&iocg->vtime, now.vnow);
 	atomic64_set(&iocg->done_vtime, now.vnow);
 	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
-- 
2.31.1

