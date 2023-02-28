Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9786A579E
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 12:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjB1LSK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Feb 2023 06:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjB1LSH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Feb 2023 06:18:07 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF3C8691;
        Tue, 28 Feb 2023 03:18:05 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id j3so6146660wms.2;
        Tue, 28 Feb 2023 03:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECVBbBNg+qpreZ+NjEHmoaNJonyP/UdTvTXnKWGxr1Q=;
        b=mXV/hce3APRKGxudMZqnB9+uvdYyC+NXMAFCTzfo1DVIGpCmLdTbIpR8zhTHfKMug+
         4PBX1o3kLPvtHi+WwaOE8NnqmKg/b7nknPXrH8kHf0IVDqyLw/Bc97qS+qd/cMgTWnpZ
         xgp7YJJpsLV3PExBJ6SYLWMPSPL54jCjns+9oNFSDQPfjiuVUqvr/PafXEzfKpM9FVH0
         wvojHZUae8oHBFJvoHJG2fnX2UqpvtOv5YK1KqSJoGzDyS7FEc5tE8DS/VguSGzL/uY4
         P2kdYyrLzU95iICdvmk51Fa1qcEIK4kHp+hIs7gfLX0DlmHL0iP9oWChgVbhSA4Xogv1
         xKhQ==
X-Gm-Message-State: AO0yUKWaJArRvsNPF0pfyLDA3KJ93R6WzkOde4fo6tjT9tkjMy3ygIGL
        VEnftrmMGixtPZ4v/Lq2DWI=
X-Google-Smtp-Source: AK7set9HUtbmG90OrsFVGQTxfvQa9SM/NLVvSJ1z5FQ7smftlbjuhUqTA7Zkj6YfZ0hQ7Ijb+oaF0A==
X-Received: by 2002:a05:600c:1d28:b0:3e2:147f:ac1a with SMTP id l40-20020a05600c1d2800b003e2147fac1amr1966364wms.21.1677583083691;
        Tue, 28 Feb 2023 03:18:03 -0800 (PST)
Received: from localhost (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b003e1f6e18c95sm16309443wmb.21.2023.02.28.03.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:18:03 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Cc:     aherrmann@suse.de, linux-kernel@vger.kernel.org, hch@lst.de,
        leit@fb.com
Subject: [PATCH v4] blk-iocost: Pass gendisk to ioc_refresh_params
Date:   Tue, 28 Feb 2023 03:16:54 -0800
Message-Id: <20230228111654.1778120-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current kernel (d2980d8d826554fa6981d621e569a453787472f8) crashes
when blk_iocost_init for `nvme1` disk.

	BUG: kernel NULL pointer dereference, address: 0000000000000050
	#PF: supervisor read access in kernel mode
	#PF: error_code(0x0000) - not-present page

	blk_iocost_init (include/asm-generic/qspinlock.h:128
			 include/linux/spinlock.h:203
			 include/linux/spinlock_api_smp.h:158
			 include/linux/spinlock.h:400
			 block/blk-iocost.c:2884)
	ioc_qos_write (block/blk-iocost.c:3198)
	? kretprobe_perf_func (kernel/trace/trace_kprobe.c:1566)
	? kernfs_fop_write_iter (include/linux/slab.h:584 fs/kernfs/file.c:311)
	? __kmem_cache_alloc_node (mm/slab.h:? mm/slub.c:3452 mm/slub.c:3491)
	? _copy_from_iter (arch/x86/include/asm/uaccess_64.h:46
			   arch/x86/include/asm/uaccess_64.h:52
			   lib/iov_iter.c:183 lib/iov_iter.c:628)
	? kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1693)
	cgroup_file_write (kernel/cgroup/cgroup.c:4061)
	kernfs_fop_write_iter (fs/kernfs/file.c:334)
	vfs_write (include/linux/fs.h:1849 fs/read_write.c:491
		   fs/read_write.c:584)
	ksys_write (fs/read_write.c:637)
	do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

This happens because ioc_refresh_params() is being called without
a properly initialized ioc->rqos, which is happening later in the callee
side.

ioc_refresh_params() -> ioc_autop_idx() tries to access
ioc->rqos.disk->queue but ioc->rqos.disk is NULL, causing the BUG above.

Create function, called ioc_refresh_params_disk(), that is similar to
ioc_refresh_params() but where the "struct gendisk" could be passed as
an explicit argument. This function will be called when ioc->rqos.disk
is not initialized.

Fixes: ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more useful")

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

---
Changelog
v1->v2: Pass the struct request_queue explictly to ioc_refresh_params()
v2->v3: Use struct gendisk instead of struct request_queue
v3->v4: Rename _ioc_refresh_params() to ioc_refresh_params_disk()

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ff534e9d92dc..4442c7a85112 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -800,7 +800,11 @@ static void ioc_refresh_period_us(struct ioc *ioc)
 	ioc_refresh_margins(ioc);
 }
 
-static int ioc_autop_idx(struct ioc *ioc)
+/*
+ *  ioc->rqos.disk isn't initialized when this function is called from
+ *  the init path.
+ */
+static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 {
 	int idx = ioc->autop_idx;
 	const struct ioc_params *p = &autop[idx];
@@ -808,11 +812,11 @@ static int ioc_autop_idx(struct ioc *ioc)
 	u64 now_ns;
 
 	/* rotational? */
-	if (!blk_queue_nonrot(ioc->rqos.disk->queue))
+	if (!blk_queue_nonrot(disk->queue))
 		return AUTOP_HDD;
 
 	/* handle SATA SSDs w/ broken NCQ */
-	if (blk_queue_depth(ioc->rqos.disk->queue) == 1)
+	if (blk_queue_depth(disk->queue) == 1)
 		return AUTOP_SSD_QD1;
 
 	/* use one of the normal ssd sets */
@@ -901,14 +905,19 @@ static void ioc_refresh_lcoefs(struct ioc *ioc)
 		    &c[LCOEF_WPAGE], &c[LCOEF_WSEQIO], &c[LCOEF_WRANDIO]);
 }
 
-static bool ioc_refresh_params(struct ioc *ioc, bool force)
+/*
+ * struct gendisk is required as an argument because ioc->rqos.disk
+ * is not properly initialized when called from the init path.
+ */
+static bool ioc_refresh_params_disk(struct ioc *ioc, bool force,
+				    struct gendisk *disk)
 {
 	const struct ioc_params *p;
 	int idx;
 
 	lockdep_assert_held(&ioc->lock);
 
-	idx = ioc_autop_idx(ioc);
+	idx = ioc_autop_idx(ioc, disk);
 	p = &autop[idx];
 
 	if (idx == ioc->autop_idx && !force)
@@ -939,6 +948,11 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
 	return true;
 }
 
+static bool ioc_refresh_params(struct ioc *ioc, bool force)
+{
+	return ioc_refresh_params_disk(ioc, force, ioc->rqos.disk);
+}
+
 /*
  * When an iocg accumulates too much vtime or gets deactivated, we throw away
  * some vtime, which lowers the overall device utilization. As the exact amount
@@ -2880,7 +2894,7 @@ static int blk_iocost_init(struct gendisk *disk)
 
 	spin_lock_irq(&ioc->lock);
 	ioc->autop_idx = AUTOP_INVALID;
-	ioc_refresh_params(ioc, true);
+	ioc_refresh_params_disk(ioc, true, disk);
 	spin_unlock_irq(&ioc->lock);
 
 	/*
-- 
2.39.2

