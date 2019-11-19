Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7500101A10
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 08:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKSHLK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 02:11:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41826 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfKSHLJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 02:11:09 -0500
Received: by mail-il1-f199.google.com with SMTP id o185so18519991ila.8
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2019 23:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1v1aJGS9HsUrUeldziyx6a61zXZusa4khlXNwtE+IaY=;
        b=h759zYjoDNa/3S6NkpXhxlCmPgNQpD7xWoA0oSfdFRiD616azliZ1nep+s8o8Cx9FC
         /kgg/9fWNHFgg6cLRJOEHidWDKSih8+WX6qJxSFOQ1Hu+XQBBPsnANp4vs+2doAQfdsN
         P/xOzItjf12Q5hm24OQwiT6DrMieo1tKsDelCaZeBnvvU+uSFBut5oDr8HxMeFdl64Gs
         DCsCVpaNGqZdvYaBrJy1mYZFUx9SCc8xjs13Eo4/8Lr4g5rcHDVrYrPMm/Zw4OqyWPN9
         /xHgAXB6cUoGjadAEAtNBW3jvTK92UQgSn15yaUCUWSnBNqm8YhwtJNTcYJppoAUgfSv
         080Q==
X-Gm-Message-State: APjAAAUhcbNsbk1+4xmnTolikFDKwIgGtQ5U7LIg8yQle430Z7mXH+k4
        yPYcn7rDwBmSFTrUCbY4a5bAd8WEHOEDUZBphpaFhNsRa2EQ
X-Google-Smtp-Source: APXvYqxdZZYLE8OwNy2FHsJ6YSwh9lfsT9xQC0okfneLSAj5kdGsa3xWwAJ48k79fXa8r+kRMVUkJ2bjDtHRQJYu9sPljXFHVOaK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cd0:: with SMTP id c16mr22275430ilj.226.1574147466718;
 Mon, 18 Nov 2019 23:11:06 -0800 (PST)
Date:   Mon, 18 Nov 2019 23:11:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093f8c20597adc469@google.com>
Subject: KASAN: use-after-free Read in blkcg_print_stat (2)
From:   syzbot <syzbot+9bfadf534cf2fd1b5eb8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fe30021c Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1196cb3ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1aab6d4187ddf667
dashboard link: https://syzkaller.appspot.com/bug?extid=9bfadf534cf2fd1b5eb8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bfadf534cf2fd1b5eb8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dev_name include/linux/device.h:1342 [inline]
BUG: KASAN: use-after-free in blkg_dev_name block/blk-cgroup.c:498 [inline]
BUG: KASAN: use-after-free in blkcg_print_stat+0xb26/0xc00  
block/blk-cgroup.c:942
Read of size 8 at addr ffff8880a01b2050 by task syz-executor.1/16053

CPU: 0 PID: 16053 Comm: syz-executor.1 Not tainted 5.4.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  dev_name include/linux/device.h:1342 [inline]
  blkg_dev_name block/blk-cgroup.c:498 [inline]
  blkcg_print_stat+0xb26/0xc00 block/blk-cgroup.c:942
  cgroup_seqfile_show+0x1a8/0x300 kernel/cgroup/cgroup.c:3816
  kernfs_seq_show+0x14f/0x1b0 fs/kernfs/file.c:167
  seq_read+0x4ca/0x1110 fs/seq_file.c:229
  kernfs_fop_read+0xed/0x560 fs/kernfs/file.c:251
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  vfs_readv+0xf0/0x160 fs/read_write.c:997
  do_readv+0x15b/0x330 fs/read_write.c:1034
  __do_sys_readv fs/read_write.c:1125 [inline]
  __se_sys_readv fs/read_write.c:1122 [inline]
  __x64_sys_readv+0x75/0xb0 fs/read_write.c:1122
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a639
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd336772c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a639
RDX: 00000000000001a5 RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd3367736d4
R13: 00000000004c7ecd R14: 00000000004de160 R15: 00000000ffffffff

Allocated by task 12327:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3550
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  device_create_groups_vargs+0x8e/0x270 drivers/base/core.c:2828
  device_create_vargs+0x45/0x60 drivers/base/core.c:2886
  bdi_register_va.part.0+0x91/0x940 mm/backing-dev.c:940
  bdi_register_va mm/backing-dev.c:976 [inline]
  bdi_register+0x12a/0x140 mm/backing-dev.c:973
  bdi_register_owner+0x6a/0x110 mm/backing-dev.c:983
  __device_add_disk+0xe09/0x1230 block/genhd.c:739
  device_add_disk+0x2b/0x40 block/genhd.c:763
  add_disk include/linux/genhd.h:429 [inline]
  loop_add+0x635/0x8d0 drivers/block/loop.c:2061
  loop_control_ioctl drivers/block/loop.c:2162 [inline]
  loop_control_ioctl+0x165/0x360 drivers/block/loop.c:2144
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 16049:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  device_create_release+0x16/0x20 drivers/base/power/wakeup_stats.c:130
  device_release+0x7a/0x210 drivers/base/core.c:1101
  kobject_cleanup lib/kobject.c:693 [inline]
  kobject_release lib/kobject.c:722 [inline]
  kref_put include/linux/kref.h:65 [inline]
  kobject_put.cold+0x289/0x2e6 lib/kobject.c:739
  put_device drivers/base/core.c:2301 [inline]
  device_unregister+0x28/0x40 drivers/base/core.c:2409
  bdi_unregister+0x428/0x610 mm/backing-dev.c:1016
  del_gendisk+0x896/0xb30 block/genhd.c:810
  loop_remove+0x3c/0xd0 drivers/block/loop.c:2079
  loop_control_ioctl drivers/block/loop.c:2178 [inline]
  loop_control_ioctl+0x320/0x360 drivers/block/loop.c:2144
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a01b2000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 80 bytes inside of
  2048-byte region [ffff8880a01b2000, ffff8880a01b2800)
The buggy address belongs to the page:
page:ffffea0002806c80 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 01fffc0000000200 ffffea0002374088 ffffea0002730148 ffff8880aa400e00
raw: 0000000000000000 ffff8880a01b2000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a01b1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a01b1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a01b2000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff8880a01b2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a01b2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
