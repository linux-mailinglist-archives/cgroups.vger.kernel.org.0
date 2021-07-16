Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDD3CB97B
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 17:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhGPPRb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhGPPRb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 11:17:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D17C06175F
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 08:14:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y42so16586783lfa.3
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5lvtqvNHgwnprByXaUchwc7++4x2TnzEwQL9H4ZASQ=;
        b=hObCBLU8vhQ3DhnNnjvSg7B3axm6THGsz2MeMxUiAGIg67loWCPw5KdkdNiJoeFYcr
         +KjxiGoOq8ss/mdCvb2FtkcRcYrj2/5V/c83RcHvpX7Z/qSEMdwiTHjd8XN2IJxlK4hi
         360mtiZaSfUXs+NL4QtafyL1LHLHJLkaLiyRSc4+QhMvRPc00Cj/0VIsgcFkIs9XRQz4
         Vou1+tl8dfKZPa3XHoi2G546FRTN5/HZ2eEV1stlWHsMD2lZ0UyWHrW4DuiPCxpTtLao
         xWUfE7VZcfhw1OBuLhqP7XTWVpx7aMFbOK+y0IQB4cgZv0/kQKuhbuOWHUjXZ7b1oMiQ
         tZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5lvtqvNHgwnprByXaUchwc7++4x2TnzEwQL9H4ZASQ=;
        b=HzC7twAO7jbAgdQj/OzzoCAvQqCCmYe2sceshSp4yLVLDEJ5qS6NzdDwaKAh1zx7+X
         Rn1ZWQoP0AxFVlbYBJ+dKPa55XrwcvDE6TWEIUu6Ppi9pMPi6w0BgdACy7L/wYvqImYX
         5OW9PY9g79+/Z1NZ2UwPmYLxHTIddR4oGzoH8Ypqvhea8BaSJPn5CtYCvmOcMtCUhnjw
         zwh1zxkiRomzbhBHGMqKwjs6BEFVPkNHTuaFdV39LULul4qTysCSiH40DtdmI9ne2dSK
         bAAf2TEOWrZSus701COLTmgbhrhIM16T0VDHVMMp6/gMzJIKYOoNidyhaZtUG1OIJlxW
         wNfg==
X-Gm-Message-State: AOAM533EQYfQQ5i0hhtnK4R64smyCL/PmrTdVtRHe/3G81S8nOzR9cWC
        imPPXE+Kyxl8ptXJbG4YC3J8OcFO44ceZyLGLLuXnw==
X-Google-Smtp-Source: ABdhPJyFcWPJKSYK9E51fJOsh1nWZad+he4FUY35nVwim6R2qrnt9JpgRiZJLC0QyXSYAf+f4gdjKImMNi+q0HZ7Cik=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr8179914lfc.117.1626448474507;
 Fri, 16 Jul 2021 08:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210714013948.270662-1-shakeelb@google.com> <CGME20210716150353eucas1p2c9ad1d1021ee584de587e5ec10b8467b@eucas1p2.samsung.com>
 <20210714013948.270662-2-shakeelb@google.com> <78005c4c-9233-7bc8-d50e-e3fe11f30b5d@samsung.com>
In-Reply-To: <78005c4c-9233-7bc8-d50e-e3fe11f30b5d@samsung.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 16 Jul 2021 08:14:23 -0700
Message-ID: <CALvZod5SONQ6=ewesLhMSampu=sxbA3iDS3f+rsHkEUY5G2Cyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] memcg: infrastructure to flush memcg stats
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Marek

On Fri, Jul 16, 2021 at 8:03 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi,
>
> On 14.07.2021 03:39, Shakeel Butt wrote:
> > At the moment memcg stats are read in four contexts:
> >
> > 1. memcg stat user interfaces
> > 2. dirty throttling
> > 3. page fault
> > 4. memory reclaim
> >
> > Currently the kernel flushes the stats for first two cases. Flushing the
> > stats for remaining two casese may have performance impact. Always
> > flushing the memcg stats on the page fault code path may negatively
> > impacts the performance of the applications. In addition flushing in the
> > memory reclaim code path, though treated as slowpath, can become the
> > source of contention for the global lock taken for stat flushing because
> > when system or memcg is under memory pressure, many tasks may enter the
> > reclaim path.
> >
> > This patch uses following mechanisms to solve these challenges:
> >
> > 1. Periodically flush the stats from root memcg every 2 seconds. This
> > will time limit the out of sync stats.
> >
> > 2. Asynchronously flush the stats after fixed number of stat updates.
> > In the worst case the stat can be out of sync by O(nr_cpus * BATCH) for
> > 2 seconds.
> >
> > 3. For avoiding thundering herd to flush the stats particularly from the
> > memory reclaim context, introduce memcg local spinlock and let only one
> > flusher active at a time. This could have been done through
> > cgroup_rstat_lock lock but that lock is used by other subsystem and for
> > userspace reading memcg stats. So, it is better to keep flushers
> > introduced by this patch decoupled from cgroup_rstat_lock.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> This patch landed in today's linux-next (next-20210716) as commit
> 42265e014ac7 ("memcg: infrastructure to flush memcg stats"). On my test
> system's I found that it triggers a kernel BUG on all ARM64 boards:
>
>   BUG: sleeping function called from invalid context at
> kernel/cgroup/rstat.c:200
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 7, name:
> kworker/u8:0
>   3 locks held by kworker/u8:0/7:
>    #0: ffff00004000c938 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
> process_one_work+0x200/0x718
>    #1: ffff80001334bdd0 ((stats_flush_dwork).work){+.+.}-{0:0}, at:
> process_one_work+0x200/0x718
>    #2: ffff8000124f6d40 (stats_flush_lock){+.+.}-{2:2}, at:
> mem_cgroup_flush_stats+0x20/0x48
>   CPU: 2 PID: 7 Comm: kworker/u8:0 Tainted: G        W 5.14.0-rc1+ #3713
>   Hardware name: Raspberry Pi 4 Model B (DT)
>   Workqueue: events_unbound flush_memcg_stats_dwork
>   Call trace:
>    dump_backtrace+0x0/0x1d0
>    show_stack+0x14/0x20
>    dump_stack_lvl+0x88/0xb0
>    dump_stack+0x14/0x2c
>    ___might_sleep+0x1dc/0x200
>    __might_sleep+0x4c/0x88
>    cgroup_rstat_flush+0x2c/0x58
>    mem_cgroup_flush_stats+0x34/0x48
>    flush_memcg_stats_dwork+0xc/0x38
>    process_one_work+0x2a8/0x718
>    worker_thread+0x48/0x460
>    kthread+0x12c/0x160
>    ret_from_fork+0x10/0x18
>
> This can be also reproduced with QEmu. Please let me know if I can help
> fixing this issue.
>

Thanks for the report. The issue can be fixed by changing
cgroup_rstat_flush() to cgroup_rstat_flush_irqsafe() in
mem_cgroup_flush_stats(). I will send out the updated patch in a
couple of hours after a bit more testing.
