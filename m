Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75579229332
	for <lists+cgroups@lfdr.de>; Wed, 22 Jul 2020 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGVIM4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jul 2020 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGVIMz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jul 2020 04:12:55 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB227C0619DC
        for <cgroups@vger.kernel.org>; Wed, 22 Jul 2020 01:12:55 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j186so666928vsd.10
        for <cgroups@vger.kernel.org>; Wed, 22 Jul 2020 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=W076aF0pkVnevDwhzxCKbE8g4hkBp73FmZlkbs1P7qI=;
        b=EJvmytfSokKO7JKn01fpIGNNcDIwYqddu5VHauVWUGc3goiTFLOMh/jS6GOMU5u8fV
         afUX5FEujNCgFhe9IgKVk11AmYBxs8SDVZ/33xRJ6fclZI3iEbvd+I8JWZ20P0Ogp99k
         05OkW1+TJbQB4wziG5tBJqCUqnu5Fum6fhYrItkEX/Ql7rPQB4gvVgUNgCGTAMu+a46G
         Cr8+kEDVxXB23qpVtdjFhmN6gyaVIdYUQ+p2S9hJ9W1JAllvSfFHvBr3FN7arjqVvM27
         38sPnVTONLxWzS/9Og5FqICPliuMHrY9n5ft9bEcJaBY87UGztv5oI/Nj+JfPpUqQNZA
         eovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=W076aF0pkVnevDwhzxCKbE8g4hkBp73FmZlkbs1P7qI=;
        b=ulpSBGEyFrRCXrQGtQ2ACAhyzXzRdrJ3ikg5E3w8Kt1UGMV1l+QXtdLBb3Kqq/8nOg
         PONrswKC7pj6yqR4kYPCUJ+JrDe6r0ZBC5gUUzcvsNhlRV92tVBBovTncuvUagb2W7Gh
         RzhITj+h7xLc+faZL0TJ3FtRwLmPA771IiZnUw24iAO70sQw3sbeHOwyshnFDLCy3PL0
         ybKjib3GXXyKz5Owh2VyIF+VgiP1jCJzCd94zGI7Coj4e2tBLM6y1yAwRunjHbtRw0/T
         bUNLOo9Vcd2asBAESpUbVExaXu27pdWMnb/vWy5oEys+wDeagaEFBhoQad+6AqDGZjZ1
         qZ0Q==
X-Gm-Message-State: AOAM532snYKC0/2Hkda5AuNUkkeOtJURMQrHHhniAh89pOrlZhTV/KXL
        VCFkW4+5Wv4EJGgZwjjcMcvbuWJb81EBuLIf3C9/Vg==
X-Google-Smtp-Source: ABdhPJzouE3ayXob168ZiUBCBR5VEnzkMxo5l6S3qNRk39xqgecbpgIN4va5/wubbhAfJjSUa2F7SfeShPjXI+/Oo+8=
X-Received: by 2002:a67:2d0e:: with SMTP id t14mr21191740vst.22.1595405574822;
 Wed, 22 Jul 2020 01:12:54 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jul 2020 13:42:42 +0530
Message-ID: <CA+G9fYuj3bHUMz8XQztbmTgF0c5+rZ5-FkUjFyvEftej2jLT+Q@mail.gmail.com>
Subject: BUG at mm/vmalloc.c:3089! - invalid opcode: 0000 [#1] SMP KASAN PTI
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>,
        Cgroups <cgroups@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, urezki@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        oleksiy.avramchenko@sonymobile.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.ibm.com,
        david@redhat.com, Joerg Roedel <jroedel@suse.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Kernel BUG at mm/vmalloc.c:3089! on x86_64 Kasan configured kernel reported
this while testing LTP cgroup_fj_stress_memory_4_4_none test cases.

Also found on arm64 and i386 devices and qemu.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: de2e69cfe54a8f2ed4b75f09d3110c514f45d38e
  git describe: next-20200721
  make_kernelversion: 5.8.0-rc6
  kernel-config:
https://builds.tuxbuild.com/zU-I3LEfC1AaKQ59Er60ZQ/kernel.config

crash log,
[ 1421.080221] ------------[ cut here ]------------
[ 1421.084874] kernel BUG at mm/vmalloc.c:3089!
[ 1421.090356] invalid opcode: 0000 [#1] SMP KASAN PTI
[ 1421.096009] CPU: 1 PID: 19100 Comm: kworker/1:1 Not tainted
5.8.0-rc6-next-20200721 #1
[ 1421.103933] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[ 1421.111418] Workqueue: events pcpu_balance_workfn
[ 1421.116138] RIP: 0010:free_vm_area+0x2d/0x30
[ 1421.120413] Code: e5 41 54 49 89 fc 48 83 c7 08 e8 9e 5e 04 00 49
8b 7c 24 08 e8 74 f8 ff ff 49 39 c4 75 0c 4c 89 e7 e8 97 d2 03 00 41
5c 5d c3 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 49
89 fe
[ 1421.139154] RSP: 0018:ffff88840142fc80 EFLAGS: 00010282
[ 1421.144381] RAX: 0000000000000000 RBX: ffff88841b843738 RCX: ffffffff86ca1d78
[ 1421.151515] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8883bfacd630
[ 1421.158647] RBP: ffff88840142fc88 R08: 0000000000000001 R09: ffffed1080285f7e
[ 1421.165780] R10: 0000000000000003 R11: ffffed1080285f7d R12: ffff888409e89880
[ 1421.172913] R13: ffff88841b843730 R14: 0000000000000080 R15: 0000000000000080
[ 1421.180045] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
knlGS:0000000000000000
[ 1421.188132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1421.193876] CR2: 00007f1230b41080 CR3: 000000025d40e002 CR4: 00000000003706e0
[ 1421.201008] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1421.208132] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1421.215255] Call Trace:
[ 1421.217703]  pcpu_free_vm_areas+0x30/0x44
[ 1421.221714]  pcpu_balance_workfn+0x7bd/0x8f0
[ 1421.225987]  ? pcpu_create_chunk+0x2f0/0x2f0
[ 1421.230261]  ? read_word_at_a_time+0x12/0x20
[ 1421.234531]  ? strscpy+0xc1/0x190
[ 1421.237842]  process_one_work+0x474/0x7b0
[ 1421.241856]  worker_thread+0x7b/0x6a0
[ 1421.245521]  ? wake_up_process+0x10/0x20
[ 1421.249448]  ? process_one_work+0x7b0/0x7b0
[ 1421.253635]  kthread+0x1aa/0x200
[ 1421.256867]  ? kthread_create_on_node+0xd0/0xd0
[ 1421.261400]  ret_from_fork+0x22/0x30
[ 1421.264978] Modules linked in: x86_pkg_temp_thermal
[ 1421.269869] ---[ end trace 6352cf97284f07da ]---
[ 1421.274955] RIP: 0010:free_vm_area+0x2d/0x30
[ 1421.281026] Code: e5 41 54 49 89 fc 48 83 c7 08 e8 9e 5e 04 00 49
8b 7c 24 08 e8 74 f8 ff ff 49 39 c4 75 0c 4c 89 e7 e8 97 d2 03 00 41
5c 5d c3 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 49
89 fe
[ 1421.300553] RSP: 0018:ffff88840142fc80 EFLAGS: 00010282
[ 1421.307051] RAX: 0000000000000000 RBX: ffff88841b843738 RCX: ffffffff86ca1d78
[ 1421.314184] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8883bfacd630
[ 1421.321317] RBP: ffff88840142fc88 R08: 0000000000000001 R09: ffffed1080285f7e
[ 1421.328477] R10: 0000000000000003 R11: ffffed1080285f7d R12: ffff888409e89880
[ 1421.335639] R13: ffff88841b843730 R14: 0000000000000080 R15: 0000000000000080
[ 1421.342777] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
knlGS:0000000000000000
[ 1421.350870] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1421.356643] CR2: 00007f1230b41080 CR3: 000000025d40e002 CR4: 00000000003706e0
[ 1421.363811] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1421.370951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200721/testrun/2972982/suite/linux-log-parser/test/check-kernel-bug-1594684/log

--
Linaro LKFT
https://lkft.linaro.org
