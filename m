Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D254A68C8
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 00:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiBAXtj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 18:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBAXti (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 18:49:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550BFC061714
        for <cgroups@vger.kernel.org>; Tue,  1 Feb 2022 15:49:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z19so37006499lfq.13
        for <cgroups@vger.kernel.org>; Tue, 01 Feb 2022 15:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuDNjPJawgy9D+r4jnnOrp6Ldz6J1fdOgUQgLaNhBWY=;
        b=jRvFkIVHvY2LFgD7nF7fURn/TddgGOCPcQeLKp7Zysw9Cui01wUuN1lgu3KnFNhs3D
         TzPFm4kKsf9oXuHh6ItE3znYAqw4MFB0622YgZmhR8pJl1BUjWz/RBjXmLIVaIahfeQP
         qbPgo6TPj3a6tQLVVHsdWcSLz/k6sILtUi1mdgK+89RURf9kwA+14PsZSSQK2Pyw7LrH
         d+ZOLio1k89+tlN3oGOtwA9xxPLsGGGt9LwxyaeDcCEfW5YA0LIVStdtsxYVlvoO2GBP
         L+WH6JFAJDOiv310Dm2+zkiBbgO+rozy8tZaB3JQa3BXG63VmvtMHm6F6AovBUXbkFI2
         3JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuDNjPJawgy9D+r4jnnOrp6Ldz6J1fdOgUQgLaNhBWY=;
        b=AIy1YKSjBzNncoDdNObL66oPbBHVwwyEtMl48cZbGMj8qi5mL4TZCL5yAD3IwiIkPX
         1oOvoicdZ7kRT76YdZXjDLVzdBPDjUaIUeNwCIFBSntP0gRWruLXeZc4TLl9k+bnEo3/
         vXjFFj93Jtmmv5ntxurSyilPRwMSoZjYZEcg/DYYtYBgBzpjYhMzEIeyUY7e9oWKeQ9m
         3PwFe0IkOzpQa6NmEpqrKkunIQpX1FpULPHK8VynAeaGKXOSr4TqZcoFcVKCyslLPXV3
         03+19CnRAdrwuxQ5wtjbcTU1zGwQ9VfMHRYnGpXS0+85QsjUEWginWRLJtExvyLISR++
         VbVw==
X-Gm-Message-State: AOAM533AMOmKIOD1aWpZXskYljg6c2ol8crCUVKUkU5Xpktgl15v80uC
        7Rn9o+jE085lBF+KGCV/VL27eZx2B9919tINuYLi7A==
X-Google-Smtp-Source: ABdhPJzLYtIe/Qd8mcpyl5xP/4AaDTSUDh8U+8ENJ4yZauHq18jhY1kfbqczHcwrSs20ztu5ZYzFKLnFF1g0+UF1GcU=
X-Received: by 2002:a05:6512:33ce:: with SMTP id d14mr21772638lfg.264.1643759376434;
 Tue, 01 Feb 2022 15:49:36 -0800 (PST)
MIME-Version: 1.0
References: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
In-Reply-To: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Feb 2022 15:49:24 -0800
Message-ID: <CALvZod5xXihut1mw1Q9vn9wuB0qOsm8ir63obf3_vv9rGZoacg@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm: memcg: synchronize objcg lists with a
 dedicated spinlock
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 1, 2022 at 2:33 PM Roman Gushchin <guro@fb.com> wrote:
>
> Alexander reported a circular lock dependency revealed by the mmap1
> ltp test:
>   LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
>           WARNING: possible circular locking dependency detected
>           5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1 Not tainted
>           ------------------------------------------------------
>           mmap1/202299 is trying to acquire lock:
>           00000001892c0188 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x4a/0xe0
>           but task is already holding lock:
>           00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
>           which lock already depends on the new lock.
>           the existing dependency chain (in reverse order) is:
>           -> #1 (&sighand->siglock){-.-.}-{2:2}:
>                  __lock_acquire+0x604/0xbd8
>                  lock_acquire.part.0+0xe2/0x238
>                  lock_acquire+0xb0/0x200
>                  _raw_spin_lock_irqsave+0x6a/0xd8
>                  __lock_task_sighand+0x90/0x190
>                  cgroup_freeze_task+0x2e/0x90
>                  cgroup_migrate_execute+0x11c/0x608
>                  cgroup_update_dfl_csses+0x246/0x270
>                  cgroup_subtree_control_write+0x238/0x518
>                  kernfs_fop_write_iter+0x13e/0x1e0
>                  new_sync_write+0x100/0x190
>                  vfs_write+0x22c/0x2d8
>                  ksys_write+0x6c/0xf8
>                  __do_syscall+0x1da/0x208
>                  system_call+0x82/0xb0
>           -> #0 (css_set_lock){..-.}-{2:2}:
>                  check_prev_add+0xe0/0xed8
>                  validate_chain+0x736/0xb20
>                  __lock_acquire+0x604/0xbd8
>                  lock_acquire.part.0+0xe2/0x238
>                  lock_acquire+0xb0/0x200
>                  _raw_spin_lock_irqsave+0x6a/0xd8
>                  obj_cgroup_release+0x4a/0xe0
>                  percpu_ref_put_many.constprop.0+0x150/0x168
>                  drain_obj_stock+0x94/0xe8
>                  refill_obj_stock+0x94/0x278
>                  obj_cgroup_charge+0x164/0x1d8
>                  kmem_cache_alloc+0xac/0x528
>                  __sigqueue_alloc+0x150/0x308
>                  __send_signal+0x260/0x550
>                  send_signal+0x7e/0x348
>                  force_sig_info_to_task+0x104/0x180
>                  force_sig_fault+0x48/0x58
>                  __do_pgm_check+0x120/0x1f0
>                  pgm_check_handler+0x11e/0x180
>           other info that might help us debug this:
>            Possible unsafe locking scenario:
>                  CPU0                    CPU1
>                  ----                    ----
>             lock(&sighand->siglock);
>                                          lock(css_set_lock);
>                                          lock(&sighand->siglock);
>             lock(css_set_lock);
>            *** DEADLOCK ***
>           2 locks held by mmap1/202299:
>            #0: 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
>            #1: 00000001892ad560 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x168
>           stack backtrace:
>           CPU: 15 PID: 202299 Comm: mmap1 Not tainted 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1
>           Hardware name: IBM 3906 M04 704 (LPAR)
>           Call Trace:
>            [<00000001888aacfe>] dump_stack_lvl+0x76/0x98
>            [<0000000187c6d7be>] check_noncircular+0x136/0x158
>            [<0000000187c6e888>] check_prev_add+0xe0/0xed8
>            [<0000000187c6fdb6>] validate_chain+0x736/0xb20
>            [<0000000187c71e54>] __lock_acquire+0x604/0xbd8
>            [<0000000187c7301a>] lock_acquire.part.0+0xe2/0x238
>            [<0000000187c73220>] lock_acquire+0xb0/0x200
>            [<00000001888bf9aa>] _raw_spin_lock_irqsave+0x6a/0xd8
>            [<0000000187ef6862>] obj_cgroup_release+0x4a/0xe0
>            [<0000000187ef6498>] percpu_ref_put_many.constprop.0+0x150/0x168
>            [<0000000187ef9674>] drain_obj_stock+0x94/0xe8
>            [<0000000187efa464>] refill_obj_stock+0x94/0x278
>            [<0000000187eff55c>] obj_cgroup_charge+0x164/0x1d8
>            [<0000000187ed8aa4>] kmem_cache_alloc+0xac/0x528
>            [<0000000187bf2eb8>] __sigqueue_alloc+0x150/0x308
>            [<0000000187bf4210>] __send_signal+0x260/0x550
>            [<0000000187bf5f06>] send_signal+0x7e/0x348
>            [<0000000187bf7274>] force_sig_info_to_task+0x104/0x180
>            [<0000000187bf7758>] force_sig_fault+0x48/0x58
>            [<00000001888ae160>] __do_pgm_check+0x120/0x1f0
>            [<00000001888c0cde>] pgm_check_handler+0x11e/0x180
>           INFO: lockdep is turned off.
>
> In this example a slab allocation from __send_signal() caused a
> refilling and draining of a percpu objcg stock, resulted in a
> releasing of another non-related objcg. Objcg release path requires
> taking the css_set_lock, which is used to synchronize objcg lists.
>
> This can create a circular dependency with the sighandler lock,
> which is taken with the locked css_set_lock by the freezer code
> (to freeze a task).
>
> In general it seems that using css_set_lock to synchronize objcg lists
> makes any slab allocations and deallocation with the locked
> css_set_lock and any intervened locks risky.
>
> To fix the problem and make the code more robust let's stop using
> css_set_lock to synchronize objcg lists and use a new dedicated
> spinlock instead.
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: cgroups@vger.kernel.org

Reviewed-by: Shakeel Butt <shakeelb@google.com>
