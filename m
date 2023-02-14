Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84069580B
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 05:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjBNE6V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 23:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBNE6T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 23:58:19 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E510416
        for <cgroups@vger.kernel.org>; Mon, 13 Feb 2023 20:58:17 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id m15-20020a5e8d0f000000b0073529b4aeaaso9581251ioj.10
        for <cgroups@vger.kernel.org>; Mon, 13 Feb 2023 20:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtU6VmT/Bmi1VOgJWA1PDC6Gjq0Dh9pUAmLLSr3qlsk=;
        b=ce/t17zjlFYXC9iXTgYKU2ljddKUAUBO8KPlLtF/SKU94y/YSHA4CskwC4TCmGKLfR
         R31KLDWvdQM5V4WQdE0BH0vbGlKJrry/mtxdiq6OdS3goosE64u7ht/k3fKaJpSSWkiK
         EHR0UqpCM85Rsvk+R46+I///zZvfLx7VnOWY+Pvkr2AEclPUKcPsTxbfSyiQ19Jl3FzP
         rEx05zZg/Jk0/2j+H8xHsfnz/fiNP2HhIEMb7k8GCL4tZwrSEpmhc9PU/VdRZqm4NFPX
         vijFr3+H/nWC/escZ7sg0otFMc8lReqBUzQssjiZ31QfSafTvu2vhO9W9pEgbGUWqfbv
         torw==
X-Gm-Message-State: AO0yUKUP3PjidAHQYy45ELrgGAWWiY4LIwbRVEY2Ir6pufRzjDq+tIwF
        wq/oGdar6bDk0huei1ZwAKiMB8WejjrPxGducT27kn+oSxlu
X-Google-Smtp-Source: AK7set+CO1eepW5P7vGz298OPFKY/8M2YQzv/Sj4KVeFZLAllJ3OytYs62f45LEbhocxSvSnci1Hsa3FpC996k2at3CY/aYYBzpF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:663:b0:313:fa72:d9aa with SMTP id
 l3-20020a056e02066300b00313fa72d9aamr233892ilt.0.1676350697234; Mon, 13 Feb
 2023 20:58:17 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:58:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3ea0505f4a1cf71@google.com>
Subject: [syzbot] linux-next boot error: general protection fault in blkg_destroy_all
From:   syzbot <syzbot+a45b868a1ffcd86bc989@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3ebb0ac55efa Add linux-next specific files for 20230214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175f3600c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c7c56590b54128
dashboard link: https://syzkaller.appspot.com/bug?extid=a45b868a1ffcd86bc989
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45dd3fc90f5f/disk-3ebb0ac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebf0c2d1789a/vmlinux-3ebb0ac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a27fab195b7/bzImage-3ebb0ac5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a45b868a1ffcd86bc989@syzkaller.appspotmail.com

floppy0: no floppy controllers found
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.2.0-rc8-next-20230214-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:blkg_destroy_all+0xa6/0x260 block/blk-cgroup.c:529
Code: 08 e8 7e 87 14 06 48 8b 44 24 10 80 38 00 0f 85 a5 01 00 00 48 8b 04 24 48 8b 98 80 05 00 00 48 8d 6b f8 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 77 01 00 00 48 8b 03 49 39 dd 4c 8d 78 f8 0f
RSP: 0000:ffffc90000117ad0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81667f94
RDX: 1ffff11003cb8019 RSI: 0000000000000004 RDI: ffffc90000117a60
RBP: fffffffffffffff8 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000022f4c R11: 0000000000000001 R12: dffffc0000000000
R13: ffff88801e5b5580 R14: ffff88801e5b5090 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000c571000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blkcg_exit_disk+0x15/0x50 block/blk-cgroup.c:1352
 disk_release+0xe3/0x490 block/genhd.c:1167
 device_release+0xa3/0x240 drivers/base/core.c:2436
 kobject_cleanup lib/kobject.c:681 [inline]
 kobject_release lib/kobject.c:712 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c2/0x4d0 lib/kobject.c:729
 put_device+0x1f/0x30 drivers/base/core.c:3701
 put_disk+0x45/0x60 block/genhd.c:1453
 do_floppy_init drivers/block/floppy.c:4758 [inline]
 floppy_async_init+0x39e/0x2cc0 drivers/block/floppy.c:4767
 async_run_entry_fn+0x9c/0x530 kernel/async.c:127
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:blkg_destroy_all+0xa6/0x260 block/blk-cgroup.c:529
Code: 08 e8 7e 87 14 06 48 8b 44 24 10 80 38 00 0f 85 a5 01 00 00 48 8b 04 24 48 8b 98 80 05 00 00 48 8d 6b f8 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 77 01 00 00 48 8b 03 49 39 dd 4c 8d 78 f8 0f
RSP: 0000:ffffc90000117ad0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81667f94
RDX: 1ffff11003cb8019 RSI: 0000000000000004 RDI: ffffc90000117a60
RBP: fffffffffffffff8 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000022f4c R11: 0000000000000001 R12: dffffc0000000000
R13: ffff88801e5b5580 R14: ffff88801e5b5090 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000c571000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 e8                	or     %ch,%al
   2:	7e 87                	jle    0xffffff8b
   4:	14 06                	adc    $0x6,%al
   6:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   b:	80 38 00             	cmpb   $0x0,(%rax)
   e:	0f 85 a5 01 00 00    	jne    0x1b9
  14:	48 8b 04 24          	mov    (%rsp),%rax
  18:	48 8b 98 80 05 00 00 	mov    0x580(%rax),%rbx
  1f:	48 8d 6b f8          	lea    -0x8(%rbx),%rbp
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 77 01 00 00    	jne    0x1ac
  35:	48 8b 03             	mov    (%rbx),%rax
  38:	49 39 dd             	cmp    %rbx,%r13
  3b:	4c 8d 78 f8          	lea    -0x8(%rax),%r15
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
