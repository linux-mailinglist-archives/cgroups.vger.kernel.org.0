Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42865A244F
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiHZJ1n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiHZJ12 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 05:27:28 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB204C3F6D
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 02:27:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so619189ioz.8
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 02:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=JYJG5UxiN0a2AO6OxY+5nDjC+apgSZhDXbL9j4TOLYk=;
        b=asgEpwGS6w8mIZEXeE/bIWkrTW/WC7irLrLKNYIj45M9hFsPK2EBsOsXbtRz1gwxK6
         3m91lApN31gmKNC1Vk9Zr8ZTwpdOXtC52S7dPy9RmMPNO/e89Lma7y/8PqMokzA8ylO0
         fP/V3bYeBt/QOC2nzjDLpjyzLkmDjuGFh+L+a7aN4S44IofvfZhuWaDClCAYnigFFjzm
         5CQrZ6fBnQB5aTuSm+lYnGuMTFyS0b5xAr5B7iGYQnah1ztOrXVF1m8SiyUgi0I1Ag4E
         kD/v0Rj/Y0xOcfLF6zs8cRUdCi70b/mQwD6gg6WbZYtyjs+1RffRG2ifR281j/rQ1etS
         CR0A==
X-Gm-Message-State: ACgBeo3BJvGBQ+E7YiPIM3wmOmVbv/Qn4UjLrVPOGvCjkq7uWYIyG511
        SzP5vUnVNoE1k6ylqR2nwyk5qglafiOMS4kbr6a3rS7IIo3h
X-Google-Smtp-Source: AA6agR6eqwrjrpVeMwl7VIFrNYLBEzwhHeODpy8ynmimx1Emvv50z6yX3MEaOBySec/ep1PjTIEFxOXyikHH/wkaDNMqiuXiUZg0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id
 m10-20020a056e02158a00b002d3f1989f39mr3895529ilu.206.1661506045661; Fri, 26
 Aug 2022 02:27:25 -0700 (PDT)
Date:   Fri, 26 Aug 2022 02:27:25 -0700
In-Reply-To: <0000000000002c7abf05e721698d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4d93d05e7218510@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in psi_poll_worker
From:   syzbot <syzbot+dd8e45eb61404849cde9@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
        glider@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3a2b6b904ea7 x86: kmsan: enable KMSAN builds for x86
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d6a513080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e64bc5364a1307e
dashboard link: https://syzkaller.appspot.com/bug?extid=dd8e45eb61404849cde9
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fc7ac7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ea06db080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd8e45eb61404849cde9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in psi_show+0x701/0x810 kernel/sched/psi.c:1082
 psi_show+0x701/0x810 kernel/sched/psi.c:1082
 cgroup_io_pressure_show+0x2b6/0x2f0 kernel/cgroup/cgroup.c:3662
 cgroup_seqfile_show+0x1fe/0x470 kernel/cgroup/cgroup.c:3991
 kernfs_seq_show+0x13b/0x1f0 fs/kernfs/file.c:217
 seq_read_iter+0x926/0x20c0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x1f2/0xa10 fs/kernfs/file.c:299
 call_read_iter include/linux/fs.h:2181 [inline]
 generic_file_splice_read+0x1e5/0x770 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x5b2/0x1190 fs/splice.c:865
 do_splice_direct+0x252/0x3d0 fs/splice.c:974
 do_sendfile+0xbe9/0x1ba0 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64+0x202/0x2a0 fs/read_write.c:1303
 __x64_sys_sendfile64+0xb9/0x110 fs/read_write.c:1303
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

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

CPU: 1 PID: 3493 Comm: syz-executor306 Not tainted 6.0.0-rc2-syzkaller-47460-g3a2b6b904ea7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
=====================================================

