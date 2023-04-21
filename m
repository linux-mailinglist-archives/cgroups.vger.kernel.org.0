Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672446EACFE
	for <lists+cgroups@lfdr.de>; Fri, 21 Apr 2023 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDUOdb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Apr 2023 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjDUOda (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Apr 2023 10:33:30 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997C1444E
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 07:32:54 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-32ab644612aso14583355ab.1
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 07:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087574; x=1684679574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrFEuF/VNq5g9FqzV/mufM217urn03OllWFFKpr3C0U=;
        b=FDEY7DmpLr2dw3ZkrSXbkByyQOoubmMES0YPZQRdbWhVhMg9GrkMDpX4RpxfS8Zz0H
         EDHVnnWreXsrfa428yHLkx9oL+ie62IuOQRCswJdZN9J/mQ1g2QcMpNa6GoeCYODoVdl
         E9tEIkOWsKvidWVAqg7/Bzf/PkhL7EdM8gf8WNe+1NzWgGybRof3u9IX91Kcr9hXlV14
         dEUxtyY7Fdo4DhAQ0sLgeBhUqQCQFONElxHA5MiYg694iaVZ4tteSXXcqHWjekKfEasm
         h8081SC694Fte1FeaaEFn1BNLN17LyiEkj29U9HDChqqfExZLuaCa8rFcU6tkWHexRKw
         /jYQ==
X-Gm-Message-State: AAQBX9esb/8D8XSfx/9Y9WQM/GWtE3DZTKoixRr6UTozmj05DeTUSnjP
        Lc8L0Cyglj66PDhF0mBWNsvjNPIy6UoI/j2v64vshsDKY9Pu
X-Google-Smtp-Source: AKy350ZlAsHZRUrWgsrpnW6LYNe4Q395IQtSOVHE70CdCWoO7Ds2bk+VF/Hfu53hvQUp/gFyd/OBHcnpOl5lCXfBIb6rPdoJ2m/9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:6cb:b0:329:654a:1231 with SMTP id
 p11-20020a056e0206cb00b00329654a1231mr2866845ils.5.1682087574284; Fri, 21 Apr
 2023 07:32:54 -0700 (PDT)
Date:   Fri, 21 Apr 2023 07:32:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058b63f05f9d98811@google.com>
Subject: [syzbot] [cgroups?] [mm?] KCSAN: data-race in drain_all_stock /
 drain_obj_stock (4)
From:   syzbot <syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    534293368afa Merge tag 'kbuild-fixes-v6.3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a0c26ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85fa20c996a2e46d
dashboard link: https://syzkaller.appspot.com/bug?extid=774c29891415ab0fd29d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec0e584af797/disk-53429336.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423a67f52f94/vmlinux-53429336.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8409b9716faa/bzImage-53429336.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock

write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
 drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
 refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
 obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
 memcg_slab_free_hook mm/slab.h:587 [inline]
 __cache_free mm/slab.c:3373 [inline]
 __do_kmem_cache_free mm/slab.c:3577 [inline]
 kmem_cache_free+0x105/0x280 mm/slab.c:3602
 __d_free fs/dcache.c:298 [inline]
 dentry_free fs/dcache.c:375 [inline]
 __dentry_kill+0x422/0x4a0 fs/dcache.c:621
 dentry_kill+0x8d/0x1e0
 dput+0x118/0x1f0 fs/dcache.c:913
 __fput+0x3bf/0x570 fs/file_table.c:329
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x123/0x160 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
 obj_stock_flush_required mm/memcontrol.c:3319 [inline]
 drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
 try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
 try_charge mm/memcontrol.c:2837 [inline]
 mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
 sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
 sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
 udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
 udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
 sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
 __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
 __do_sys_setsockopt net/socket.c:2282 [inline]
 __se_sys_setsockopt net/socket.c:2279 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffff8881382d52c0 -> 0xffff888138893740

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
