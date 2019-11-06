Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19D2F2136
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 22:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbfKFV6u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 16:58:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44979 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbfKFV6t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 16:58:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id o11so20617qtr.11;
        Wed, 06 Nov 2019 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCorZkPJP9TGXujGHT7jjDnVUj1sFVQI/cg2WsPyUwQ=;
        b=O6u3QL+pWqJ27s+9Qlg6Ls4d/hivEDiry+YmAEebwOq0HAth8LCImFLsCGflFQhMxP
         JPNwH/gdlL4PIslS1JrSBX1m8LqYlCnEY+qL+LY71V17cdjaz80gaFT4Bpoixkz6Igjy
         aiwdEBX56IE6oNxlpRJJLI0JLRXyJoPPHvgJV7g1z0x4pd4KsRH3EC9q+fx+RXplCFDG
         VaMDS9AWRV9YjY8W+Ih5eKph4DpX8vqU8kf5ryf5ta8Ix4HlWUEYKTLGT7c+/4u0/dS6
         bLrPduUyEtv0p+NC7Yz0Wrcix42r09BcSzCXrz7Hu71a+PYBPtZbw5kHC3PPudWRBlDA
         oAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SCorZkPJP9TGXujGHT7jjDnVUj1sFVQI/cg2WsPyUwQ=;
        b=LOOXfVuhDETU/GZqK2fCMnoPap/x/B+VtYXGZXE5t1Qe6w7eXZCdno1cImxMbE/jkN
         PGtUXa1PdkpRenIjyKdoCzZdgP7fdVHPCeVYcHKMzJeAoJHvZpHDuXBLW9mcbKcq3pNL
         6Cb9ibuMpfC2sPxYaxppBMr8ObTPt2KHFHWsxYc6dAliXxrfni3S6Mx/+PQzBhl/Ukap
         bnLIdbX4na8y8v/4W9KhEGmPzdUoeYjg4xhg+3FIdaclg5f1cT/v0e5dqFQWycS1NkMz
         XbQ5dM1yWlL+OyweF8NSSRZLknCOI/TuTFg3tzFz1ddNRlV2YFZlzHFilfo6QdXrkzHv
         YL4Q==
X-Gm-Message-State: APjAAAUdybtTcGqi4m4FBp2q/Dnv3UEJ4wSC4q0dwLxqkMCg2rZYkvk7
        Lap+O9cSvsIyx3zm74rNS90=
X-Google-Smtp-Source: APXvYqwFDsVmuewko/pZ72OMIKO9NdcI2o4RGW5iInddgdJKdV9+XZkER7gbgYkseDLDi59FS6cEYQ==
X-Received: by 2002:ac8:2d19:: with SMTP id n25mr262090qta.144.1573077527943;
        Wed, 06 Nov 2019 13:58:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5bd1])
        by smtp.gmail.com with ESMTPSA id x39sm147919qth.92.2019.11.06.13.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:58:46 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] blk-throtl: stop using blkg->stat_bytes and ->stat_ios
Date:   Wed,  6 Nov 2019 13:58:35 -0800
Message-Id: <20191106215838.3973497-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106215838.3973497-1-tj@kernel.org>
References: <20191106215838.3973497-1-tj@kernel.org>
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
index 0445c998c377..6ac5b5d56170 100644
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

