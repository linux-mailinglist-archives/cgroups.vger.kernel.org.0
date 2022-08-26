Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3E5A241C
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiHZJTb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343520AbiHZJT3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 05:19:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4D4D741B
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 02:19:28 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id l15-20020a0566022dcf00b00688e70a26deso607163iow.12
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 02:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=7awWSOHLPnAjg3OIqppgmOG9YBZWnjkmLUSpTqU3g/U=;
        b=h7430J36RMCh+ZU2NIXUkIEht03lmZV4mW4tlcWdmeeEnJ4z3YXCTQCZUYfSrLLNBE
         7JVg0I/tTFlViBi9WqAxJEY9BEjMk5fquGxJhxbDCtukimC3LUvey4VAiyEn2ucwG+3U
         JTWWJEskRE22YLx8Ed5dTU3EuuqrJ2ifsHTBUT4Dhq6It/Tz83vTGgUhFg3UHdxx7dfX
         4TW6Vi2T1EQOvFlzBjPluWTR3i4pxoF4BXhE0siSVv9aGmf9wCQK2I4rj0Kj+8TRbydm
         u2HFA+BloQzA/XXxYIYOxAFVOqJj44cO4UuGg+JOVqWvlUkDTk7MysYaFtoEcG3WNgnm
         fLwQ==
X-Gm-Message-State: ACgBeo3vRjrl5vC5Mc8WlNgP6gdD9FW8MrokKAlcUqZTzx3oVTWBeFz9
        ETHgsv7vtTyuqbFowlBA2j/QVC5HGCvWleAzjg0o/gKhcSJO
X-Google-Smtp-Source: AA6agR7pWosGxbwJcVkZzs0IfYElXo5vIiEU4cXBP2pG9isPQ6jF+KiGcl/yCCX6hd6UyGuGdM6EwGdqUar6HS0gYGviz1tfg664
MIME-Version: 1.0
X-Received: by 2002:a6b:510d:0:b0:689:5a18:1150 with SMTP id
 f13-20020a6b510d000000b006895a181150mr3075634iob.73.1661505568010; Fri, 26
 Aug 2022 02:19:28 -0700 (PDT)
Date:   Fri, 26 Aug 2022 02:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c7abf05e721698d@google.com>
Subject: [syzbot] KMSAN: uninit-value in psi_poll_worker
From:   syzbot <syzbot+dd8e45eb61404849cde9@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
        glider@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a2b6b904ea7 x86: kmsan: enable KMSAN builds for x86
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13f51a33080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e64bc5364a1307e
dashboard link: https://syzkaller.appspot.com/bug?extid=dd8e45eb61404849cde9
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd8e45eb61404849cde9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in update_triggers kernel/sched/psi.c:525 [inline]
BUG: KMSAN: uninit-value in psi_poll_work kernel/sched/psi.c:626 [inline]
BUG: KMSAN: uninit-value in psi_poll_worker+0x972/0x16a0 kernel/sched/psi.c:648
 update_triggers kernel/sched/psi.c:525 [inline]
 psi_poll_work kernel/sched/psi.c:626 [inline]
 psi_poll_worker+0x972/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
 psi_poll_work kernel/sched/psi.c:604 [inline]
 psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
 psi_poll_work kernel/sched/psi.c:604 [inline]
 psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3258 [inline]
 slab_alloc mm/slub.c:3266 [inline]
 kmem_cache_alloc_trace+0x696/0xdf0 mm/slub.c:3297
 kmalloc include/linux/slab.h:600 [inline]
 psi_cgroup_alloc+0x83/0x250 kernel/sched/psi.c:960
 cgroup_create kernel/cgroup/cgroup.c:5430 [inline]
 cgroup_mkdir+0x10a3/0x3080 kernel/cgroup/cgroup.c:5550
 kernfs_iop_mkdir+0x2ba/0x520 fs/kernfs/dir.c:1185
 vfs_mkdir+0x62a/0x870 fs/namei.c:4013
 do_mkdirat+0x466/0x7b0 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0xc4/0x120 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 0 PID: 19765 Comm: psimon Not tainted 6.0.0-rc2-syzkaller-47460-g3a2b6b904ea7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
