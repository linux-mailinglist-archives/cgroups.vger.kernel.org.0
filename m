Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDC6A1F55
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBXQHn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 11:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBXQHm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 11:07:42 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FCB55074;
        Fri, 24 Feb 2023 08:07:37 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so2541195wms.1;
        Fri, 24 Feb 2023 08:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlCCq+5MGhDHg6g5LpCh9XqsSczfF671zYGkO5BH54U=;
        b=M6zcrYig0rz9dsqqfQyXQZFcZgR+lTRRlQFD4Kmwf2NUky/MCLJ3EmuY+vLXSJBmft
         Lg4CLm5P1kBfBHAhDfnSd/EGo0KzYHWLAnl3W9QTFmFW4sP0USKV3lUOwO+I+nV9LZ6O
         twAJMzaNRSR1wtgPdvpBLT7maB7wUAwFYGz6wG4oR7r9WDVIGO9wSCKpziurd0YYZrbo
         PKy2WoTnZMYS9xId/TBmcACghDCFki8x0dXI54IvNLap5t3YZ6x2v5hn61yWkY/87au6
         Yw3Eu5Z1gbQ2a1ZoS/3WdVGLgjNqoGIAWrlgIxhnUNyEVlnTdySp/MR1qdUB9awzG3X7
         GtaQ==
X-Gm-Message-State: AO0yUKVU+XC22Abumv+S9tBKlZFZQNfdHViFpgeWWeqPUmgizl2GvsUF
        g9w9AdGLQony1qDx9rVLm0g=
X-Google-Smtp-Source: AK7set+6nRWwW7xZ2BWLKvzBI7rYORkfqcGa82rmwZOBuvL16cx1Fc1rmKVqJ2pbvmA9UmdY80c/Pw==
X-Received: by 2002:a1c:ed1a:0:b0:3ea:f6c4:305e with SMTP id l26-20020a1ced1a000000b003eaf6c4305emr2830997wmh.38.1677254855469;
        Fri, 24 Feb 2023 08:07:35 -0800 (PST)
Received: from localhost (fwdproxy-cln-030.fbsv.net. [2a03:2880:31ff:1e::face:b00c])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d698b000000b002c5a1bd5280sm14334068wru.95.2023.02.24.08.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:07:35 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Cc:     aherrmann@suse.de, linux-kernel@vger.kernel.org, hch@lst.de,
        leit@fb.com
Subject: [PATCH] blk-iocost: initialize rqos before accessing it
Date:   Fri, 24 Feb 2023 08:07:14 -0800
Message-Id: <20230224160714.172884-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
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
a properly initialized ioc->rqos, which is happening later.

ioc_refresh_params() -> ioc_autop_idx() tries to access
ioc->rqos.disk->queue but ioc->rqos.disk is NULL, causing the BUG above.

Move the ioc_refresh_params() call to after rqos is populated
(rq_qos_add).

Fixes: ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more useful")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 block/blk-iocost.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ff534e9d92dc..6cced8a76e9c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2878,11 +2878,6 @@ static int blk_iocost_init(struct gendisk *disk)
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
 
-	spin_lock_irq(&ioc->lock);
-	ioc->autop_idx = AUTOP_INVALID;
-	ioc_refresh_params(ioc, true);
-	spin_unlock_irq(&ioc->lock);
-
 	/*
 	 * rqos must be added before activation to allow ioc_pd_init() to
 	 * lookup the ioc from q. This means that the rqos methods may get
@@ -2893,6 +2888,11 @@ static int blk_iocost_init(struct gendisk *disk)
 	if (ret)
 		goto err_free_ioc;
 
+	spin_lock_irq(&ioc->lock);
+	ioc->autop_idx = AUTOP_INVALID;
+	ioc_refresh_params(ioc, true);
+	spin_unlock_irq(&ioc->lock);
+
 	ret = blkcg_activate_policy(disk, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
-- 
2.30.2

