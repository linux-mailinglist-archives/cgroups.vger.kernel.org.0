Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F84E9438
	for <lists+cgroups@lfdr.de>; Mon, 28 Mar 2022 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiC1L0l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Mar 2022 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiC1LYJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Mar 2022 07:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B655BC7;
        Mon, 28 Mar 2022 04:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B1661126;
        Mon, 28 Mar 2022 11:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4588FC340F3;
        Mon, 28 Mar 2022 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466509;
        bh=ocxmqrhFe+3/lIramiGQhKBRQ/Os4hCCByY+saZzH/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDDsVHFIlUNfLwt8bxLcjxCLTubCirpY6l6nVRIx3D+4OEfoVwpDshKEPg2r+2xGU
         BEH4x9W2ys6/un0rapn1A45loErghSgJ2VVzu1tSacvirvXTPLW2QSkke5j4hgMRNg
         lF9Bdo23yxV9CiRGKA2Dp83oDJ5j7wdvrKCdptUcJaXFqAmGfDWg7MjhNMH+4hJmvZ
         yw3isEMi2aOfyj/PzkaC1NMaPhqSRXqlsKYG/ur16nJPS6nGVy5xzlEnwJu+MfeNq4
         Tgam7RzLddPTHys3LHOvM0vKWQCg+S3TgZtzEQaRYmRu3Gke78du53o8APADsmu2fK
         D7zsU8vHRJs5w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        tj@kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/29] block, bfq: don't move oom_bfqq
Date:   Mon, 28 Mar 2022 07:21:12 -0400
Message-Id: <20220328112132.1555683-10-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328112132.1555683-1-sashal@kernel.org>
References: <20220328112132.1555683-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 8410f70977734f21b8ed45c37e925d311dfda2e7 ]

Our test report a UAF:

[ 2073.019181] ==================================================================
[ 2073.019188] BUG: KASAN: use-after-free in __bfq_put_async_bfqq+0xa0/0x168
[ 2073.019191] Write of size 8 at addr ffff8000ccf64128 by task rmmod/72584
[ 2073.019192]
[ 2073.019196] CPU: 0 PID: 72584 Comm: rmmod Kdump: loaded Not tainted 4.19.90-yk #5
[ 2073.019198] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 2073.019200] Call trace:
[ 2073.019203]  dump_backtrace+0x0/0x310
[ 2073.019206]  show_stack+0x28/0x38
[ 2073.019210]  dump_stack+0xec/0x15c
[ 2073.019216]  print_address_description+0x68/0x2d0
[ 2073.019220]  kasan_report+0x238/0x2f0
[ 2073.019224]  __asan_store8+0x88/0xb0
[ 2073.019229]  __bfq_put_async_bfqq+0xa0/0x168
[ 2073.019233]  bfq_put_async_queues+0xbc/0x208
[ 2073.019236]  bfq_pd_offline+0x178/0x238
[ 2073.019240]  blkcg_deactivate_policy+0x1f0/0x420
[ 2073.019244]  bfq_exit_queue+0x128/0x178
[ 2073.019249]  blk_mq_exit_sched+0x12c/0x160
[ 2073.019252]  elevator_exit+0xc8/0xd0
[ 2073.019256]  blk_exit_queue+0x50/0x88
[ 2073.019259]  blk_cleanup_queue+0x228/0x3d8
[ 2073.019267]  null_del_dev+0xfc/0x1e0 [null_blk]
[ 2073.019274]  null_exit+0x90/0x114 [null_blk]
[ 2073.019278]  __arm64_sys_delete_module+0x358/0x5a0
[ 2073.019282]  el0_svc_common+0xc8/0x320
[ 2073.019287]  el0_svc_handler+0xf8/0x160
[ 2073.019290]  el0_svc+0x10/0x218
[ 2073.019291]
[ 2073.019294] Allocated by task 14163:
[ 2073.019301]  kasan_kmalloc+0xe0/0x190
[ 2073.019305]  kmem_cache_alloc_node_trace+0x1cc/0x418
[ 2073.019308]  bfq_pd_alloc+0x54/0x118
[ 2073.019313]  blkcg_activate_policy+0x250/0x460
[ 2073.019317]  bfq_create_group_hierarchy+0x38/0x110
[ 2073.019321]  bfq_init_queue+0x6d0/0x948
[ 2073.019325]  blk_mq_init_sched+0x1d8/0x390
[ 2073.019330]  elevator_switch_mq+0x88/0x170
[ 2073.019334]  elevator_switch+0x140/0x270
[ 2073.019338]  elv_iosched_store+0x1a4/0x2a0
[ 2073.019342]  queue_attr_store+0x90/0xe0
[ 2073.019348]  sysfs_kf_write+0xa8/0xe8
[ 2073.019351]  kernfs_fop_write+0x1f8/0x378
[ 2073.019359]  __vfs_write+0xe0/0x360
[ 2073.019363]  vfs_write+0xf0/0x270
[ 2073.019367]  ksys_write+0xdc/0x1b8
[ 2073.019371]  __arm64_sys_write+0x50/0x60
[ 2073.019375]  el0_svc_common+0xc8/0x320
[ 2073.019380]  el0_svc_handler+0xf8/0x160
[ 2073.019383]  el0_svc+0x10/0x218
[ 2073.019385]
[ 2073.019387] Freed by task 72584:
[ 2073.019391]  __kasan_slab_free+0x120/0x228
[ 2073.019394]  kasan_slab_free+0x10/0x18
[ 2073.019397]  kfree+0x94/0x368
[ 2073.019400]  bfqg_put+0x64/0xb0
[ 2073.019404]  bfqg_and_blkg_put+0x90/0xb0
[ 2073.019408]  bfq_put_queue+0x220/0x228
[ 2073.019413]  __bfq_put_async_bfqq+0x98/0x168
[ 2073.019416]  bfq_put_async_queues+0xbc/0x208
[ 2073.019420]  bfq_pd_offline+0x178/0x238
[ 2073.019424]  blkcg_deactivate_policy+0x1f0/0x420
[ 2073.019429]  bfq_exit_queue+0x128/0x178
[ 2073.019433]  blk_mq_exit_sched+0x12c/0x160
[ 2073.019437]  elevator_exit+0xc8/0xd0
[ 2073.019440]  blk_exit_queue+0x50/0x88
[ 2073.019443]  blk_cleanup_queue+0x228/0x3d8
[ 2073.019451]  null_del_dev+0xfc/0x1e0 [null_blk]
[ 2073.019459]  null_exit+0x90/0x114 [null_blk]
[ 2073.019462]  __arm64_sys_delete_module+0x358/0x5a0
[ 2073.019467]  el0_svc_common+0xc8/0x320
[ 2073.019471]  el0_svc_handler+0xf8/0x160
[ 2073.019474]  el0_svc+0x10/0x218
[ 2073.019475]
[ 2073.019479] The buggy address belongs to the object at ffff8000ccf63f00
 which belongs to the cache kmalloc-1024 of size 1024
[ 2073.019484] The buggy address is located 552 bytes inside of
 1024-byte region [ffff8000ccf63f00, ffff8000ccf64300)
[ 2073.019486] The buggy address belongs to the page:
[ 2073.019492] page:ffff7e000333d800 count:1 mapcount:0 mapping:ffff8000c0003a00 index:0x0 compound_mapcount: 0
[ 2073.020123] flags: 0x7ffff0000008100(slab|head)
[ 2073.020403] raw: 07ffff0000008100 ffff7e0003334c08 ffff7e00001f5a08 ffff8000c0003a00
[ 2073.020409] raw: 0000000000000000 00000000001c001c 00000001ffffffff 0000000000000000
[ 2073.020411] page dumped because: kasan: bad access detected
[ 2073.020412]
[ 2073.020414] Memory state around the buggy address:
[ 2073.020420]  ffff8000ccf64000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020424]  ffff8000ccf64080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020428] >ffff8000ccf64100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020430]                                   ^
[ 2073.020434]  ffff8000ccf64180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020438]  ffff8000ccf64200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020439] ==================================================================

The same problem exist in mainline as well.

This is because oom_bfqq is moved to a non-root group, thus root_group
is freed earlier.

Thus fix the problem by don't move oom_bfqq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Link: https://lore.kernel.org/r/20220129015924.3958918-4-yukuai3@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 85b8e1c3a762..e37af3f8a733 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -644,6 +644,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
+	/*
+	 * oom_bfqq is not allowed to move, oom_bfqq will hold ref to root_group
+	 * until elevator exit.
+	 */
+	if (bfqq == &bfqd->oom_bfqq)
+		return;
 	/*
 	 * Get extra reference to prevent bfqq from being freed in
 	 * next possible expire or deactivate.
-- 
2.34.1

