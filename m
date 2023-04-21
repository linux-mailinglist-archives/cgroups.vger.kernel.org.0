Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E736EAD4C
	for <lists+cgroups@lfdr.de>; Fri, 21 Apr 2023 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDUOll (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Apr 2023 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjDUOl1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Apr 2023 10:41:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD7C654
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 07:40:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4edc63e066fso7011e87.1
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682087938; x=1684679938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uE8L66mYi61Gg000YX9CaB4PguSbhnlIM05Rg2iq/GU=;
        b=g3rmUy97ewR5Qob/EIc0qirnHyGan7c3n7pweFBrjd4IKEX1NVaHijC/5eHO4MNEDW
         Ff3BUAQNyy0m/fGS9YWwhDtiFnB5bLlPAjjH6fTEFwOvUJbkRqH9u3P763jj6of+sfJV
         eh1paFZ6ywkGWJqWKXSSu3i6LkZ0rb1dLjXid+GjA3s3hyJwVUlPonXyw6Cz30d88pjH
         TLOU/sY30TqTHGlXm0/qbIZsfLkAThaztVPBD3OR4nmNuVPX6xNzmzb7bGHzouRJKy77
         iQTEbiCwwv2DBX8+uESfd1BeUMHZ/N3avr3F3IScinfFcGzEoNS/DlIRNt1JSYsaTWTy
         mWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087938; x=1684679938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uE8L66mYi61Gg000YX9CaB4PguSbhnlIM05Rg2iq/GU=;
        b=hZ+N2DN0OtBK4dPcrjdc+i3KB2FKlAIKmV3qYbPqyz6/6goB8fQAw6sA5IzLGpCSKl
         V9lMqHI4A6LaFj4ibwQFUhRRZTtVZZW24mBhYh6OFw235Oi8UAh5M/cutzdy2jpf2FOc
         /v4CZ25RHLZtTiri+AVR+zfPERqyz7J8iKNo0aaw+7t6EZ90CYZhGCaPIH+hifYzwQM4
         dRRQQBqfJUbO9wQ4HNu5zeuAjwAXXtKRxv9KE0ZAa32yWFd6vQiF8tvROUUqlUSSOYNK
         chPjvh6UrZQFMfNNnf1EgfYyA0eTOHkWSBVaMl2etg+1m3ZkqXFnpSa2BnkJ148Iuwps
         XzcQ==
X-Gm-Message-State: AAQBX9elEmG/IFLfOg0h7tbsyPxOdgsbfFTEYgKu0ClcpFS1HLz1e/Xi
        Jn9ucuTSo9M6r652HeMPzdBtMbXQ+23hKgYHJtp4aA==
X-Google-Smtp-Source: AKy350ZyOfS4dtZ34VvdRpYL23nzMtyNO31vto5RCBtSVg3taplS7QBs38rFKaUmF1n0vGPY0tnESQznqaXNiGiGREk=
X-Received: by 2002:a05:6512:110a:b0:4ed:af48:f8bb with SMTP id
 l10-20020a056512110a00b004edaf48f8bbmr104792lfg.5.1682087938324; Fri, 21 Apr
 2023 07:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058b63f05f9d98811@google.com>
In-Reply-To: <00000000000058b63f05f9d98811@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Apr 2023 16:38:45 +0200
Message-ID: <CACT4Y+ZfucZhM60YPphWiCLJr6+SGFhT+jjm8k1P-a_8Kkxsjg@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] KCSAN: data-race in drain_all_stock /
 drain_obj_stock (4)
To:     syzbot <syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 21 Apr 2023 at 16:33, syzbot
<syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    534293368afa Merge tag 'kbuild-fixes-v6.3' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a0c26ec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=85fa20c996a2e46d
> dashboard link: https://syzkaller.appspot.com/bug?extid=774c29891415ab0fd29d
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ec0e584af797/disk-53429336.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/423a67f52f94/vmlinux-53429336.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8409b9716faa/bzImage-53429336.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com

Here this:

stock->cached_objcg = NULL;

runs concurrently with:

if (stock->cached_objcg) {
    memcg = obj_cgroup_memcg(stock->cached_objcg);

If I am reading this correctly, this can cause a NULL deref, if
cached_objcg is reset between the check and the use.



> ==================================================================
> BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock
>
> write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
>  drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
>  refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
>  obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
>  memcg_slab_free_hook mm/slab.h:587 [inline]
>  __cache_free mm/slab.c:3373 [inline]
>  __do_kmem_cache_free mm/slab.c:3577 [inline]
>  kmem_cache_free+0x105/0x280 mm/slab.c:3602
>  __d_free fs/dcache.c:298 [inline]
>  dentry_free fs/dcache.c:375 [inline]
>  __dentry_kill+0x422/0x4a0 fs/dcache.c:621
>  dentry_kill+0x8d/0x1e0
>  dput+0x118/0x1f0 fs/dcache.c:913
>  __fput+0x3bf/0x570 fs/file_table.c:329
>  ____fput+0x15/0x20 fs/file_table.c:349
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
>  obj_stock_flush_required mm/memcontrol.c:3319 [inline]
>  drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
>  try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
>  try_charge mm/memcontrol.c:2837 [inline]
>  mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
>  sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
>  sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
>  udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
>  udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
>  sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
>  __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
>  __do_sys_setsockopt net/socket.c:2282 [inline]
>  __se_sys_setsockopt net/socket.c:2279 [inline]
>  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0xffff8881382d52c0 -> 0xffff888138893740
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000058b63f05f9d98811%40google.com.
