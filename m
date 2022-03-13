Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46794D742D
	for <lists+cgroups@lfdr.de>; Sun, 13 Mar 2022 11:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiCMKL2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Mar 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCMKL2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Mar 2022 06:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A6E45061
        for <cgroups@vger.kernel.org>; Sun, 13 Mar 2022 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647166219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2FADEf28TqJAPkif0KyeCNyGcMlkFHLeXIWnUuPnn8=;
        b=bQVre+b6qcEEGxEDKCDrJpA+yKgEfwC98ImDZfcUq3FHTFCehxwoSIgbdD5xtPQsem1hNG
        kfrZmYvvD5a+lgG3Q7aElD2To4wraCG3PaRzWanEicKayH8nOwX4s+bGD7ZVSArEHZO6T2
        XKWd0beUNZtdNUvwC+FpH5xgQvXWUSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-dTHlVspjN6SRUFTa_5iuKA-1; Sun, 13 Mar 2022 06:10:18 -0400
X-MC-Unique: dTHlVspjN6SRUFTa_5iuKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DFB4801597;
        Sun, 13 Mar 2022 10:10:17 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6410400F3F8;
        Sun, 13 Mar 2022 10:10:11 +0000 (UTC)
Date:   Sun, 13 Mar 2022 18:10:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     syzbot <syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] memory leak in blk_iolatency_init (2)
Message-ID: <Yi3C/Xai8TepwBeE@T590>
References: <0000000000007414e805da0c5de4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007414e805da0c5de4@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 12, 2022 at 01:45:25PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    79b00034e9dc Merge tag 'drm-fixes-2022-03-11' of git://ano..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15cf8329700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9e1a3a8e38b9582
> dashboard link: https://syzkaller.appspot.com/bug?extid=b42749a851a47a0f581b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101cc4ee700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1270b5e9700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888103f8fa00 (size 96):
>   comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.480s)
>   hex dump (first 32 bytes):
>     40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
>     [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
>     [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
>     [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
>     [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
>     [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
>     [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
>     [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
>     [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
>     [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
>     [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
>     [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
>     [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
>     [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
>     [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
>     [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
>     [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
>     [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
>     [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

This is caused by 8e141f9eb803 ("block: drain file system I/O on del_gendisk").

rq_qos_exit() is for calling blkcg_iolatency_exit() to release data
allocated in blk_iolatency_init(). Since 8e141f9eb803, rq_qos_exit() is
moved to del_gendisk() from blk_cleanup_queue, it becomes not possible
to free the data when scanning un-present luns.

The following patch should fix it for v5.16/v5.17, and V5.18 needn't that
since v5.18 will move blkcg init/uninit into gendisk alloc/release.


diff --git a/block/blk-core.c b/block/blk-core.c
index ce08f0aa9dfc..1ea7e523960c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -321,6 +321,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 
+	rq_qos_exit(q);
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
 	blk_sync_queue(q);


Thanks,
Ming

