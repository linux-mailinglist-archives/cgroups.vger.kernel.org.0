Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1335E1D5D1A
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2020 02:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEPAN0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 20:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgEPAN0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 20:13:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7AC05BD09
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 17:13:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d21so4038577ljg.9
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTdULXcDq8mWIqVt/vb5iveO+2D6SqGvUKrtXPTBlEY=;
        b=khnNG9GzJUWCDxebtBF/4SavVHZ5K1XVmzcmgB8knXpmAzpoznXX+GI9LUIEsyDAcp
         GUkYxYruKzYaE5t9D9vzn9Z7zJ7WMbaTwiH7VLJ9NQc8HeZWG7+fDpWgURK/eWD/DH4O
         ejsL7skauXPqicLPunbijV2jvsyfstyagkjzmcTAr/665lf8yhJBCrE07ofIUASR7iA2
         BOkXaXCY41lrexJKBFg1zxnhmDIfyPzIKpXlLzSFJ/VPZ51QjyNaGayYpEKSTbDZlDkb
         FFO1Lh0zAS2dlKKwpAwHMOdvzL+cLdkPzJCUogXkEGptCbxijQgqiaBsvY72KFyF0FX2
         1ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTdULXcDq8mWIqVt/vb5iveO+2D6SqGvUKrtXPTBlEY=;
        b=Vd3Hl+1LtRoFCh31DYETd0q1rJ4H6dCvJMSI6TyS70n/sBoeAuiYd8sYn+dnCtk06Q
         PbFKi4Y/Teb5xape645zLmBD6GvaTH2Tn7G8np4m/hxxSYNi0ODWcqgzIHqZRhuabhms
         YEuAIxyxxUfOQm56HuZMUf4rOcl3oXmIvmPkvMwSvAHl7FmXlvPaQeVt3p8oIGyD/C4K
         i2Ld33ZPdYmBJyK+3Ct59JVVRjJkGVhG26aluGUDhLBy7YFAz8RI+7geaDnwRKrXVTDI
         chH98+oxcwCrZ1gUOVAlZ2P79JZOIsO/23flA289KofH05lm1E2Z+s+s60UWkjj7APkk
         MN0w==
X-Gm-Message-State: AOAM532Vhm49VexGpg0ZW5ZCYxl32JhyJTyLbMcaP4VvlD/yUkQKSDU0
        ffqK+ueeN/WGve3xypFON/yZMNLgdb4bGFtGkEJPig==
X-Google-Smtp-Source: ABdhPJzCemLFHNysuQhPLwnUO9alB3xOu3pbsEDmt8LRl23pPio5lzKzbN+sh/P7UI1NHgHk+9B8IC1XAG146ugHLaw=
X-Received: by 2002:a2e:9795:: with SMTP id y21mr3714912lji.115.1589588003829;
 Fri, 15 May 2020 17:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz> <20200515132421.GC591266@cmpxchg.org>
 <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
 <20200515150026.GA94522@carbon.DHCP.thefacebook.com> <CALvZod5EHzK-UzS9WgkzpZ2T+WwA8LottxrTzUi3qFwvUbOk4w@mail.gmail.com>
 <20200515180906.GA630613@cmpxchg.org>
In-Reply-To: <20200515180906.GA630613@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 May 2020 17:13:12 -0700
Message-ID: <CALvZod7rCcs+-1mmu4w3wRpuZ=op6LE2y3sG1xA2ZrSNJOG-mw@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 11:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 15, 2020 at 10:49:22AM -0700, Shakeel Butt wrote:
> > On Fri, May 15, 2020 at 8:00 AM Roman Gushchin <guro@fb.com> wrote:
> > > On Fri, May 15, 2020 at 06:44:44AM -0700, Shakeel Butt wrote:
> > > > On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > You're right. It should only bypass the page_counter, but still set
> > > > > page->mem_cgroup = root_mem_cgroup, just like user pages.
> > >
> > > What about kernel threads? We consider them belonging to the root memory
> > > cgroup. Should their memory consumption being considered in root-level stats?
> > >
> > > I'm not sure we really want it, but I guess we need to document how
> > > kernel threads are handled.
> >
> > What will be the cons of updating root-level stats for kthreads?
>
> Should kernel threads be doing GFP_ACCOUNT allocations without
> memalloc_use_memcg()? GFP_ACCOUNT implies that the memory consumption
> can be significant and should be attributed to userspace activity.
>
> If the kernel thread has no userspace entity to blame, it seems to
> imply the same thing as a !GFP_ACCOUNT allocation: shared public
> infrastructure, not interesting to account to any specific cgroup.
>
> I'm not sure if we have such allocations right now. But IMO we should
> not account anything from kthreads, or interrupts for that matter,
> /unless/ there is a specific active_memcg that was set by the kthread
> or the interrupt.

I totally agree with you but I think your response is about memory
charging in IRQ/kthread context, a topic of a parallel patch from
Zefan Li at [1].

Here we are discussing stats update for kthreads e.g. should we update
root memcg's MEMCG_KERNEL_STACK_KB stat when we allocate stack for
kernel threads?

[1] http://lkml.kernel.org/r/3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com
