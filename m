Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E833B4D711A
	for <lists+cgroups@lfdr.de>; Sat, 12 Mar 2022 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiCLVqg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Mar 2022 16:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiCLVqe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Mar 2022 16:46:34 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887581DC991
        for <cgroups@vger.kernel.org>; Sat, 12 Mar 2022 13:45:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso9389472iox.15
        for <cgroups@vger.kernel.org>; Sat, 12 Mar 2022 13:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ct5lREH82s9udYR1fdl4zYR0ltj+8XZHSKD6BawGeNs=;
        b=4Zb1gjAhuMDKimuKQNGC4QHP7qh4M/Zzv4rUodU5HoDQ3QH62Krtq1bDQPb3E78iAP
         GLHTyHW9QYDzlBTLd38Htf7ox+pwD5/TaXacE8uer41EKJSDRrlegw5gtt9G0Uu8DCt/
         VD0XmTckMhm18e1bmDe4cRUTOi/txj4YOs/c3oSYrz248Nnnb2pxZ5mDSvWF/1lMm8ny
         cpJ1Da6ktFYbojk1Am4pSgdb5vHqwDzRLlnJxCH0S0eIbkXUIzNqdtWN2vtqCcr5u59P
         ErUq8DQ7Hm8mIB3311Gy/1B0NG+V5bmMkc17FJGzUUr8+7v5TCUU3av43PHLNf3iQD2P
         JkcA==
X-Gm-Message-State: AOAM533e2ZcElH8ilmrLc2RBXaTOQKieMl/FCAac4FRz4kMcyg9NqiU6
        jbaBM26D+9b/pzF6TFs0cROmbhbWF0AN3GWni3OTRcLpS80w
X-Google-Smtp-Source: ABdhPJxpp2Prvr0d6VA6nYUKzMcyVjycfSW9ihV8mjo900p/r9Rekh7C89SX9wkxl5SP7oh0D1QrybMsw19+VAdNnvEZ48wptzoM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dc5:b0:313:f8bd:35a7 with SMTP id
 m5-20020a0566380dc500b00313f8bd35a7mr14095224jaj.75.1647121525902; Sat, 12
 Mar 2022 13:45:25 -0800 (PST)
Date:   Sat, 12 Mar 2022 13:45:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007414e805da0c5de4@google.com>
Subject: [syzbot] memory leak in blk_iolatency_init (2)
From:   syzbot <syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    79b00034e9dc Merge tag 'drm-fixes-2022-03-11' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cf8329700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9e1a3a8e38b9582
dashboard link: https://syzkaller.appspot.com/bug?extid=b42749a851a47a0f581b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101cc4ee700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1270b5e9700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.480s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.480s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.560s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.560s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.630s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.630s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.700s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.700s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.770s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.770s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.850s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.850s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.920s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.920s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 504.000s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 504.000s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
