Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B453461908E
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 06:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKDF5X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 4 Nov 2022 01:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKDF47 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 01:56:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3729342;
        Thu,  3 Nov 2022 22:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C572EB82BE8;
        Fri,  4 Nov 2022 05:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F7FC433C1;
        Fri,  4 Nov 2022 05:56:36 +0000 (UTC)
Date:   Fri, 4 Nov 2022 01:56:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC][PATCH v3 04/33] timers: block: Use timer_shutdown_sync()
 before freeing timer
Message-ID: <20221104015635.66243b5b@rorschach.local.home>
In-Reply-To: <20221104054912.617055044@goodmis.org>
References: <20221104054053.431922658@goodmis.org>
        <20221104054912.617055044@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[ Once again, quilt fails the MIME coding ]

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, timer_shutdown_sync() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Cc: linux-block@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 block/blk-iocost.c             | 2 +-
 block/blk-iolatency.c          | 2 +-
 block/blk-stat.c               | 2 +-
 block/blk-throttle.c           | 2 +-
 block/kyber-iosched.c          | 2 +-
 drivers/block/drbd/drbd_main.c | 2 +-
 drivers/block/loop.c           | 2 +-
 drivers/block/sunvdc.c         | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 495396425bad..7edc695b3a3d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2814,7 +2814,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	ioc->running = IOC_STOP;
 	spin_unlock_irq(&ioc->lock);
 
-	del_timer_sync(&ioc->timer);
+	timer_shutdown_sync(&ioc->timer);
 	free_percpu(ioc->pcpu_stat);
 	kfree(ioc);
 }
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 571fa95aafe9..c7049ab18312 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -645,7 +645,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 
-	del_timer_sync(&blkiolat->timer);
+	timer_shutdown_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
 	kfree(blkiolat);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 2ea01b5c1aca..855da21de5dc 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -165,7 +165,7 @@ void blk_stat_remove_callback(struct request_queue *q,
 		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
 	spin_unlock_irqrestore(&q->stats->lock, flags);
 
-	del_timer_sync(&cb->timer);
+	timer_shutdown_sync(&cb->timer);
 }
 
 static void blk_stat_free_callback_rcu(struct rcu_head *head)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..38740c4f517a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -490,7 +490,7 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 
-	del_timer_sync(&tg->service_queue.pending_timer);
+	timer_shutdown_sync(&tg->service_queue.pending_timer);
 	blkg_rwstat_exit(&tg->stat_bytes);
 	blkg_rwstat_exit(&tg->stat_ios);
 	kfree(tg);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index b05357bced99..2146969237bf 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -434,7 +434,7 @@ static void kyber_exit_sched(struct elevator_queue *e)
 	struct kyber_queue_data *kqd = e->elevator_data;
 	int i;
 
-	del_timer_sync(&kqd->timer);
+	timer_shutdown_sync(&kqd->timer);
 	blk_stat_disable_accounting(kqd->q);
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f3e4db16fd07..2dc5be89a001 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2184,7 +2184,7 @@ void drbd_destroy_device(struct kref *kref)
 	struct drbd_resource *resource = device->resource;
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 
-	del_timer_sync(&device->request_timer);
+	timer_shutdown_sync(&device->request_timer);
 
 	/* paranoia asserts */
 	D_ASSERT(device, device->open_cnt == 0);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..3ea087cd1f99 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1755,7 +1755,7 @@ static void lo_free_disk(struct gendisk *disk)
 	if (lo->workqueue)
 		destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
-	del_timer_sync(&lo->timer);
+	timer_shutdown_sync(&lo->timer);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index fb855da971ee..e14fe5d968d8 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1067,7 +1067,7 @@ static void vdc_port_remove(struct vio_dev *vdev)
 
 		flush_work(&port->ldc_reset_work);
 		cancel_delayed_work_sync(&port->ldc_reset_timer_work);
-		del_timer_sync(&port->vio.timer);
+		timer_shutdown_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
 		put_disk(port->disk);
-- 
2.35.1
