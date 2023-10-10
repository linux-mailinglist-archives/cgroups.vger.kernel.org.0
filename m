Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4D7BFF00
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjJJOVA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjJJOU6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 10:20:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D49106
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 07:20:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d75a77b69052e-41959feaae2so36318491cf.0
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696947652; x=1697552452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RauVDwCZ6u0rcUr+gmJviY5+pWPqnBMyOCfnWtt3YIs=;
        b=ig5K0gMlG6fJxAPuwdhBMEEeN8Ai8RQC4EBAr6jXEZ+4Zm1kQ6IqhAbaXOb8pc81/O
         CnyifNI5WWjMqCkk83otepqaLXsONwYeat6o5MVZLm52pLGdBFnZPDJWwh/ecK4Vo8a2
         AXw/CvHe3YcdjQ8B6W9CHUgnHU62Y617mrsfM6qV6pd8H2MtM002yPhyy2OQI/1E06/L
         jDB25klQp843QYF3MpD21Q2Nq48G7/w2Yc/dh6VLmObp3mi7R6npOAvBQK1vbWrM3Hdm
         ogzSk48iDrUylQrzQC8uzfIyTrgPcNnPyJmDeNMSLjHr52GsPyIrT60cjNEiaTY9U9PO
         Lgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947652; x=1697552452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RauVDwCZ6u0rcUr+gmJviY5+pWPqnBMyOCfnWtt3YIs=;
        b=bgH3BHYQd1yTvVbyrNnqcG8MjxzKoXI1whdGWTo3YeRY5ueCdx8FUwqi2O+nnhHRAD
         DLWNKamsUILj8grTeNDngiIZttigomtYz9lObmOZj+n6PVBRyuFwQFopebWHAxQ8eWRt
         GAIU1OEITqdj6tExjmBnKs11wTEPOzWalqucEtcdduGIfqcQeVDmf2BMDDDBjQVpf50y
         K7TKcSwY0wrWw5LjvUIlbirUuqx+if1NDHISGiV5lqAHFKKtXu6fJeaOV7c85UTYwvcN
         Td1gH69DdjEJUeSJRozVxVjZyFK2hdgGKCSzitfDbcGeIelWvG7lVRfjG9MzYFo6fdxs
         601A==
X-Gm-Message-State: AOJu0YzMPm7L/GIWXniuDdScuK2ObLNGd/Trs2UXK9LCFjO2IRdF63PM
        at60+qur3+M/8iRvrZ+bLYZLuQ==
X-Google-Smtp-Source: AGHT+IEliuUCFDxSpOfLDRYhT6ks1EAn9dsueLogYHl/+td/ofq+7V4XKDqQRhN9MtOWA3xWnn5cdw==
X-Received: by 2002:ac8:1383:0:b0:418:11de:ce1 with SMTP id h3-20020ac81383000000b0041811de0ce1mr16506979qtj.24.1696947651775;
        Tue, 10 Oct 2023 07:20:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id q5-20020ac84505000000b0041b0a7d1872sm3563448qtn.70.2023.10.10.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:20:51 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:20:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     syzbot <syzbot+831ba898b5db8d5617ea@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        roman.gushchin@linux.dev, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in mem_cgroup_migrate
Message-ID: <20231010142050.GA128254@cmpxchg.org>
References: <0000000000001db97f06075bf98b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001db97f06075bf98b@google.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 05:37:43AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1716036e680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=831ba898b5db8d5617ea
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+831ba898b5db8d5617ea@syzkaller.appspotmail.com
> 
>  kernel_init+0x1c/0x2a0 init/main.c:1437
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5208 at mm/memcontrol.c:7552 mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552

This is the earlier version of the hugetlb cgroup accounting patches
that trigger on an uncharged hugetlbfs:

  7547          /*
  7548           * Note that it is normal to see !memcg for a hugetlb folio.
  7549           * It could have been allocated when memory_hugetlb_accounting was not
  7550           * selected, for e.g.
  7551           */
  7552          VM_WARN_ON_ONCE_FOLIO(!memcg, old);

It's been fixed in the revision that's in the latest next release:

  7539          /*
  7540           * Note that it is normal to see !memcg for a hugetlb folio.
  7541           * For e.g, itt could have been allocated when memory_hugetlb_accounting
  7542           * was not selected.
  7543           */
  7544          VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg, old);
  7545          if (!memcg)
  7546                  return;

> Modules linked in:
> CPU: 1 PID: 5208 Comm: syz-executor.1 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> RIP: 0010:mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
> Code: f7 ff e9 36 ff ff ff 80 3d 84 b2 d1 0c 00 0f 85 54 ff ff ff 48 c7 c6 a0 9e 9b 8a 48 89 ef e8 0d 5c df ff c6 05 68 b2 d1 0c 01 <0f> 0b e9 37 ff ff ff 48 c7 c6 e0 9a 9b 8a 48 89 df e8 f0 5b df ff
> RSP: 0018:ffffc90004b2fa38 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffffea0005338000 RCX: ffffc90005439000
> RDX: 0000000000040000 RSI: ffffffff81e76463 RDI: ffffffff8ae96da0
> RBP: ffffea0001d98000 R08: 0000000000000000 R09: fffffbfff1d9db9a
> R10: ffffffff8ecedcd7 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000200 R14: 0000000000000000 R15: ffffea0001d98018
> FS:  00007fc15e89d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31820000 CR3: 000000007f5e1000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  hugetlbfs_migrate_folio fs/hugetlbfs/inode.c:1066 [inline]
>  hugetlbfs_migrate_folio+0xd0/0x120 fs/hugetlbfs/inode.c:1049
>  move_to_new_folio+0x183/0x690 mm/migrate.c:966
>  unmap_and_move_huge_page mm/migrate.c:1428 [inline]
>  migrate_hugetlbs mm/migrate.c:1546 [inline]
>  migrate_pages+0x16ac/0x27c0 mm/migrate.c:1900
>  migrate_to_node mm/mempolicy.c:1072 [inline]
>  do_migrate_pages+0x43e/0x690 mm/mempolicy.c:1171
>  kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1682
>  __do_sys_migrate_pages mm/mempolicy.c:1700 [inline]
>  __se_sys_migrate_pages mm/mempolicy.c:1696 [inline]
>  __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1696
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fc15da7cae9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc15e89d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
> RAX: ffffffffffffffda RBX: 00007fc15db9bf80 RCX: 00007fc15da7cae9
> RDX: 0000000020000340 RSI: 0000000000000080 RDI: 0000000000000000
> RBP: 00007fc15dac847a R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000200003c0 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fc15db9bf80 R15: 00007ffd87d7c058
>  </TASK>
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
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: next-20231010
