Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808D6F3868
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKGTSS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:18:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35757 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGTSR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:18:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id i19so3047767qki.2;
        Thu, 07 Nov 2019 11:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vMqhWfpdfuPCtzz4h4xpyfgHaJP+ivcOVe0R+amrObc=;
        b=HdZZU5I5vTMc9Ex/54W/e4TkSETgqYkiFfEYhMgNaJhQdd+onKikiaU2ZwcyX78T9f
         Oa5tYEbglcQ7BNDDmKYsg/Cddj4nl1MvSwmLTVYa42IO8g21JU45R62X7j4feTUwd/zr
         tr5/FsGA/y5AtFuz/eKR/ftmqQYxPlAtdqhorB/H7Px+w5ma+bMxZ5jMwQUIRnEmiSPB
         t/A585WVXN8hr39fuKUNgmJ6HaC9CkgBbGu2mU2xpF+rsF/pUxKQ9P3EUPFYdJyr1X34
         0ZR5335OuQ1I1sXKrBq99pb+4E3nds0D8vMjbXXIm/0D9bLv16oZBtAzgPHGpC0l2pJo
         /tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=vMqhWfpdfuPCtzz4h4xpyfgHaJP+ivcOVe0R+amrObc=;
        b=HobgxKEy3cszSoaVko0FcZVSzyl5xz4/oQ96gl7T0naL34fFVML+PqG/vPXaYbLfd2
         AC/iEQGCHL0FhyUex9aJn8jQYDa4083gDuJJ/uzzZWR1RBDxriP1El1ZdRXzBAt5UHeb
         2IgUV4nHidiLVD7nNqxlHi5grT4lSHNNVM0N/0oaccFrPYg1k9WU8YcPnvJ/xMorKeTy
         xMTjjUZBoGIWPnQinrn8dwbQWTohLV74y/FkdqzLHNnFSmenZewvcFyfEOp3lipz9yJ3
         dklpq4bKKrs+W7QxKRPahc95idAUvkRewXFwdWzDKfOa8VopRQuMOZjrnFGcD6OwW5Ju
         FevQ==
X-Gm-Message-State: APjAAAXWnOZ9ap2rm2kBjgbM/9dmrEWTtKllPodTyhVpusxYgXR/XAQ/
        J5w5c0xU8JhFhr6EC4MrssU=
X-Google-Smtp-Source: APXvYqyT8RfabQyfXaqXK3nxD/nlxlEXGgLKxtX6I8z10xCWd3gY3I2Nj7MqXa7u8++c1LH12VeHGg==
X-Received: by 2002:ae9:c203:: with SMTP id j3mr4661629qkg.12.1573154295635;
        Thu, 07 Nov 2019 11:18:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id 23sm1607427qkj.52.2019.11.07.11.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:18:14 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] blk-throtl: stop using blkg->stat_bytes and ->stat_ios
Date:   Thu,  7 Nov 2019 11:18:01 -0800
Message-Id: <20191107191804.3735303-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107191804.3735303-1-tj@kernel.org>
References: <20191107191804.3735303-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When used on cgroup1, blk-throtl uses the blkg->stat_bytes and
->stat_ios from blk-cgroup core to populate four stat knobs.
blk-cgroup core is moving away from blkg_rwstat to improve scalability
and won't be able to support this usage.

It isn't like the sharing gains all that much.  Let's break them out
to dedicated rwstat counters which are updated when on cgroup1.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 70 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 18f773e52dfb..2d0fc73d9781 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -176,6 +176,9 @@ struct throtl_grp {
 	unsigned int bio_cnt; /* total bios */
 	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
 	unsigned long bio_cnt_reset_time;
+
+	struct blkg_rwstat stat_bytes;
+	struct blkg_rwstat stat_ios;
 };
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -489,6 +492,12 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
 	if (!tg)
 		return NULL;
 
+	if (blkg_rwstat_init(&tg->stat_bytes, gfp))
+		goto err_free_tg;
+
+	if (blkg_rwstat_init(&tg->stat_ios, gfp))
+		goto err_exit_stat_bytes;
+
 	throtl_service_queue_init(&tg->service_queue);
 
 	for (rw = READ; rw <= WRITE; rw++) {
@@ -513,6 +522,12 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
 	tg->idletime_threshold_conf = DFL_IDLE_THRESHOLD;
 
 	return &tg->pd;
+
+err_exit_stat_bytes:
+	blkg_rwstat_exit(&tg->stat_bytes);
+err_free_tg:
+	kfree(tg);
+	return NULL;
 }
 
 static void throtl_pd_init(struct blkg_policy_data *pd)
@@ -611,6 +626,8 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 	struct throtl_grp *tg = pd_to_tg(pd);
 
 	del_timer_sync(&tg->service_queue.pending_timer);
+	blkg_rwstat_exit(&tg->stat_bytes);
+	blkg_rwstat_exit(&tg->stat_ios);
 	kfree(tg);
 }
 
@@ -1464,6 +1481,32 @@ static ssize_t tg_set_conf_uint(struct kernfs_open_file *of,
 	return tg_set_conf(of, buf, nbytes, off, false);
 }
 
+static int tg_print_rwstat(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  blkg_prfill_rwstat, &blkcg_policy_throtl,
+			  seq_cft(sf)->private, true);
+	return 0;
+}
+
+static u64 tg_prfill_rwstat_recursive(struct seq_file *sf,
+				      struct blkg_policy_data *pd, int off)
+{
+	struct blkg_rwstat_sample sum;
+
+	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_throtl, off,
+				  &sum);
+	return __blkg_prfill_rwstat(sf, pd, &sum);
+}
+
+static int tg_print_rwstat_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  tg_prfill_rwstat_recursive, &blkcg_policy_throtl,
+			  seq_cft(sf)->private, true);
+	return 0;
+}
+
 static struct cftype throtl_legacy_files[] = {
 	{
 		.name = "throttle.read_bps_device",
@@ -1491,23 +1534,23 @@ static struct cftype throtl_legacy_files[] = {
 	},
 	{
 		.name = "throttle.io_service_bytes",
-		.private = (unsigned long)&blkcg_policy_throtl,
-		.seq_show = blkg_print_stat_bytes,
+		.private = offsetof(struct throtl_grp, stat_bytes),
+		.seq_show = tg_print_rwstat,
 	},
 	{
 		.name = "throttle.io_service_bytes_recursive",
-		.private = (unsigned long)&blkcg_policy_throtl,
-		.seq_show = blkg_print_stat_bytes_recursive,
+		.private = offsetof(struct throtl_grp, stat_bytes),
+		.seq_show = tg_print_rwstat_recursive,
 	},
 	{
 		.name = "throttle.io_serviced",
-		.private = (unsigned long)&blkcg_policy_throtl,
-		.seq_show = blkg_print_stat_ios,
+		.private = offsetof(struct throtl_grp, stat_ios),
+		.seq_show = tg_print_rwstat,
 	},
 	{
 		.name = "throttle.io_serviced_recursive",
-		.private = (unsigned long)&blkcg_policy_throtl,
-		.seq_show = blkg_print_stat_ios_recursive,
+		.private = offsetof(struct throtl_grp, stat_ios),
+		.seq_show = tg_print_rwstat_recursive,
 	},
 	{ }	/* terminate */
 };
@@ -2127,7 +2170,16 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	/* see throtl_charge_bio() */
-	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
+	if (bio_flagged(bio, BIO_THROTTLED))
+		goto out;
+
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+				bio->bi_iter.bi_size);
+		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	}
+
+	if (!tg->has_rules[rw])
 		goto out;
 
 	spin_lock_irq(&q->queue_lock);
-- 
2.17.1

