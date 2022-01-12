Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21048BD88
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 04:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349064AbiALDGf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 22:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349059AbiALDGf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 22:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641956794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hLUxMC+s0pjFSC8kaV/VAZ/OjH+3iQwtRfE6QrexVRQ=;
        b=CbTvkKSwsGdKG6kpTLJugZ4XuOeJRudt5m7p30PWh49X2QCCdY1VplQLLGURauvcEkTCDv
        RZ+Ooy8AfZl9Hrst5UzgFmJFDdMJGSLVp0pJY2VZrpsFwwrYjd8tVWnQECWUE6O0ptjm7k
        HhWt2f9IjShz8JcRf8EBoRDkaIiawEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-BVlO2JIgPpuRso4p7ARE6A-1; Tue, 11 Jan 2022 22:06:31 -0500
X-MC-Unique: BVlO2JIgPpuRso4p7ARE6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F321853028;
        Wed, 12 Jan 2022 03:06:29 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C73E5E24E;
        Wed, 12 Jan 2022 03:05:58 +0000 (UTC)
Date:   Wed, 12 Jan 2022 11:05:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     mkoutny@suse.com, paulmck@kernel.org, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <Yd5FkuhYX9YcgQkZ@T590>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134758.2233758-3-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Yu Kuai,

On Mon, Jan 10, 2022 at 09:47:58PM +0800, Yu Kuai wrote:
> Throttled bios can't be issued after del_gendisk() is done, thus
> it's better to cancel them immediately rather than waiting for
> throttle is done.
> 
> For example, if user thread is throttled with low bps while it's
> issuing large io, and the device is deleted. The user thread will
> wait for a long time for io to return.
> 
> Noted this patch is mainly from revertion of commit 32e3374304c7
> ("blk-throttle: remove tg_drain_bios") and commit b77412372b68
> ("blk-throttle: remove blk_throtl_drain").
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-throttle.h |  2 ++
>  block/genhd.c        |  2 ++
>  3 files changed, 81 insertions(+)

Just wondering why not take the built-in way in throtl_upgrade_state() for
canceling throttled bios? Something like the following, then we can avoid
to re-invent the wheel.

 block/blk-throttle.c | 38 +++++++++++++++++++++++++++++++-------
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  3 +++
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cf7e20804f1b..17e56b2e44c4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1816,16 +1816,11 @@ static void throtl_upgrade_check(struct throtl_grp *tg)
 		throtl_upgrade_state(tg->td);
 }
 
-static void throtl_upgrade_state(struct throtl_data *td)
+static void __throtl_cancel_bios(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 
-	throtl_log(&td->service_queue, "upgrade to max");
-	td->limit_index = LIMIT_MAX;
-	td->low_upgrade_time = jiffies;
-	td->scale = 0;
-	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
@@ -1834,12 +1829,41 @@ static void throtl_upgrade_state(struct throtl_data *td)
 		throtl_select_dispatch(sq);
 		throtl_schedule_next_dispatch(sq, true);
 	}
-	rcu_read_unlock();
 	throtl_select_dispatch(&td->service_queue);
 	throtl_schedule_next_dispatch(&td->service_queue, true);
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+	spin_lock_irq(&q->queue_lock);
+	__throtl_cancel_bios(q->td);
+	spin_unlock_irq(&q->queue_lock);
+	rcu_read_unlock();
+
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg)
+		del_timer_sync(&blkg_to_tg(blkg)->service_queue.pending_timer);
+	del_timer_sync(&q->td->service_queue.pending_timer);
+
+	throtl_shutdown_wq(q);
+}
+
+static void throtl_upgrade_state(struct throtl_data *td)
+{
+	throtl_log(&td->service_queue, "upgrade to max");
+	td->limit_index = LIMIT_MAX;
+	td->low_upgrade_time = jiffies;
+	td->scale = 0;
+
+	rcu_read_lock();
+	__throtl_cancel_bios(td);
+	rcu_read_unlock();
+}
+
 static void throtl_downgrade_state(struct throtl_data *td)
 {
 	td->scale /= 2;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index b23a9f3abb82..525ac607c518 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -162,11 +162,13 @@ static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+static inline void blk_throtl_cancel_bios(struct request_queue *q) {}
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
 bool __blk_throtl_bio(struct bio *bio);
+void blk_throtl_cancel_bios(struct request_queue *q);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..1395cbd8eacf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -30,6 +30,7 @@
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
+#include "blk-throttle.h"
 
 static struct kobject *block_depr;
 
@@ -622,6 +623,8 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
+	blk_throtl_cancel_bios(q);
+
 	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();

Thanks,
Ming

