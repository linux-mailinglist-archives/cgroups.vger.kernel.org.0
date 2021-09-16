Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32F40DBD4
	for <lists+cgroups@lfdr.de>; Thu, 16 Sep 2021 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhIPNz2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbhIPNz1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 09:55:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19DC0613C1;
        Thu, 16 Sep 2021 06:54:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so6923574pjb.2;
        Thu, 16 Sep 2021 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rykHFh6yFE4CaM814tm8TY2UWUMlofffOYtoxuMYRSo=;
        b=O1dUMib0ofHE7WN6YIT5myCn0PW1FFOUSWt9/aXuJYikEjQwlS84Rs8++m498iU71I
         CVhBwagbZapM5vM9TTwNDIYVY/jRI8wtib5XSkTrOtjUxSKdBH54n+0ib6yOHFIzshZ/
         f1a5zXy1IZQBFenwnyKnHVCuc2nXlKChOBTVoubeltWFKPpFLB59wzukZEZQeVLLR+Gu
         fWajzwMXF+0akOFaWaGoNF2qvj6UTGXXt0vW+f0Xk20oRA64JnijsZkhtetxR9AaQMv+
         zriJAUuC3OrP8l/ZV3cZNAsumC1W2zJ8SXimO1amnQho5X3ZG/hGSSbEFQMnsnzIMOON
         Eiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rykHFh6yFE4CaM814tm8TY2UWUMlofffOYtoxuMYRSo=;
        b=aB14ZrFtbnKehaZdTtcQK83TCeHf51yP9sCpRuyyOsiVaWkxT4qCLbaAReLsl5YHkZ
         iCgnQV51FSpUHSgfPOBtC8mQasetsmhH1hChVM0pG+j3Uwr4Z4yip/rpki9Uwj8pq3vo
         SrICSceYYn+xp4b5No8tyHy4bi+wBnrpfmDKL8PaXjvX3Mgs4AhdgfhR8EaujfEOQy9e
         l/8uBLtUnhocCZBlR6aGDAiv3lxCCC9XGQRS2VhoQ6S0EgR5FjzUuSV3XkR4WplY4rFe
         WmCGmnmIweS9brMlxda/w1heC1+FqmsGxFfJ3Mz/s/QuKdNKowXe1SN1s683OVQ4A+Og
         SXGw==
X-Gm-Message-State: AOAM533tNwuhoqFpiY7K5Tx1WpMJ+/Slhqtv3wpXwnRbsMSYWKW6F0LI
        pypp7vJL6xP8vk4pfikLadU+5OssjWKDNDY28KgrhnHIrDIH3vQ=
X-Google-Smtp-Source: ABdhPJwummHGKN9LWNX624Z0eif8Ms3fSLwDqq5mODHYqZ9Rv9I4hgwmePucilocF5PL1+G1qEt+mURSVm/T8Ap4whc=
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr6184468pjb.112.1631800446177;
 Thu, 16 Sep 2021 06:54:06 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 16 Sep 2021 21:53:55 +0800
Message-ID: <CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com>
Subject: KCSAN: data-race in cgroup_rstat_flush_locked / cgroup_rstat_updated
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

KCSAN reported the following data race during the kernel booting when
using Healer to fuzz the latest Linux kernel.

HEAD commit: ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915'
git tree: upstream
console output: https://paste.ubuntu.com/p/s4kFHrHCNh/
kernel config: https://paste.ubuntu.com/p/FjTsrWnBVM/

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

==================================================================
BUG: KCSAN: data-race in cgroup_rstat_flush_locked / cgroup_rstat_updated

write to 0xffffe8ffffc194d0 of 8 bytes by task 8 on cpu 1:
 cgroup_rstat_cpu_pop_updated kernel/cgroup/rstat.c:139 [inline]
 cgroup_rstat_flush_locked+0x282/0x760 kernel/cgroup/rstat.c:161
 cgroup_rstat_flush_irqsafe+0x24/0x40 kernel/cgroup/rstat.c:218
 mem_cgroup_flush_stats mm/memcontrol.c:5354 [inline]
 flush_memcg_stats_work+0x34/0x60 mm/memcontrol.c:5366
 process_one_work+0x402/0x910 kernel/workqueue.c:2297
 worker_thread+0x638/0xac0 kernel/workqueue.c:2444
 kthread+0x243/0x280 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

read to 0xffffe8ffffc194d0 of 8 bytes by task 1245 on cpu 0:
 cgroup_rstat_updated+0x53/0x1b0 kernel/cgroup/rstat.c:38
 __count_memcg_events+0x43/0x50 mm/memcontrol.c:788
 __activate_page+0x50b/0x5f0 mm/swap.c:309
 pagevec_lru_move_fn+0x1c4/0x2d0 mm/swap.c:197
 activate_page mm/swap.c:338 [inline]
 mark_page_accessed+0x47d/0x550 mm/swap.c:422
 zap_pte_range+0x5cc/0xdb0 mm/memory.c:1359
 zap_pmd_range mm/memory.c:1481 [inline]
 zap_pud_range mm/memory.c:1510 [inline]
 zap_p4d_range mm/memory.c:1531 [inline]
 unmap_page_range+0x2dc/0x3d0 mm/memory.c:1552
 unmap_single_vma+0x157/0x210 mm/memory.c:1597
 unmap_vmas+0xd0/0x180 mm/memory.c:1629
 exit_mmap+0x235/0x470 mm/mmap.c:3171
 __mmput+0x27/0x1d0 kernel/fork.c:1115
 mmput+0x3d/0x50 kernel/fork.c:1136
 exit_mm+0x2dc/0x3d0 kernel/exit.c:501
 do_exit+0x3e0/0x14f0 kernel/exit.c:812
 do_group_exit+0xa4/0x1a0 kernel/exit.c:922
 __do_sys_exit_group+0xb/0x10 kernel/exit.c:933
 __se_sys_exit_group+0x5/0x10 kernel/exit.c:931
 __x64_sys_exit_group+0x16/0x20 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0xffff888101bc2010 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1245 Comm: syz-executor Not tainted 5.15.0-rc1+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
