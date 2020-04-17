Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED31AE413
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgDQRvY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729980AbgDQRvY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 13:51:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96491C061A0C
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 10:51:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so2934086ljd.4
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bvq8GDDyYV41j+5P8OsI6ehsGT+D4XvqiNl9KWPqiw=;
        b=rcPENmuw3uoibqCQ1bei91SZIX5CUxsppMlNgftSQMML52eG74i79y68GqmTEcLfP0
         ULN6ukv+0a58WwyLrgvPd2vyg1NgsO6mTXw02TFLShqH7rTMyLxmJj0pas6ibkeULTuF
         zvL7GDe8Nsjj2H6xwJKjHk1scm/yLizWICpyBkHsDskJnl4p0tKyqkLm3QTxkg8uD3DB
         5WI68ZUgtj++O69DQfmKAb72c7UIxoFYL2VMHIvnMSHyFT3fHtrXZMsF3+Uc1gNI9ySG
         7VYION5mZD2kA76B0mIi1P5r48iacIP98VQkdw0A9e8+QLgsfdukRlPBYqeo5N9elsJs
         2LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bvq8GDDyYV41j+5P8OsI6ehsGT+D4XvqiNl9KWPqiw=;
        b=Rd36Dsz3ru6oWVwlsiMsNskytevhsRedEWw2IDOFxYF+Wc1f/hIpXRLdvF3LM2mW5D
         xQ7s5Ossoektr60X5GuGHUDG6g5goMR8e+/er8Uoyi0g6XZZbdHmiWM0hKIa1NqcveON
         h/DT9lTFikqyACrPc9UaQNcydKmM80CWNpHaPvvfcJvoaqW9+xsGfzjqZuOb9KkZGqiV
         dkXE8lmwt9d9lAMJy2P4bomGgEYX5HUKczrOh5QlrZ2V7OJZYvsqj8PZ6FK2QCfHTm8T
         FkzFlAboH+Wp9vLiO4sR+oJp68xgN/Lyxq8BZK6Z4tu3TpncZ9sdgQSNd8A1fv614fkq
         xN+Q==
X-Gm-Message-State: AGi0PubZRPUoc09zIJry7F80IkhRtqEHfINwk0xTFMD9sQO4lAYC5jDB
        +iSjW+wMAmkTFYJrop1x8sVK6BT2tNA/1KLR6wy/Lw==
X-Google-Smtp-Source: APiQypJFNJn4Za/tJEY0/xUDDM4+G2XMSoYiOKLmeeNO9+iJSvrfOrft0DSH72B8yscUZkbsIPgbTRzs/qAQOub3CS8=
X-Received: by 2002:a2e:9a4a:: with SMTP id k10mr2880113ljj.115.1587145881775;
 Fri, 17 Apr 2020 10:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200417010617.927266-1-kuba@kernel.org> <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
 <20200417162355.GA43469@mtj.thefacebook.com> <CALvZod4ftvXCu8SbQUXwTGVvx5K2+at9h30r28chZLXEB1JdfQ@mail.gmail.com>
 <20200417173615.GB43469@mtj.thefacebook.com>
In-Reply-To: <20200417173615.GB43469@mtj.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Apr 2020 10:51:10 -0700
Message-ID: <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
To:     Tejun Heo <tj@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 17, 2020 at 10:36 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Apr 17, 2020 at 10:18:15AM -0700, Shakeel Butt wrote:
> > > There currently are issues with anonymous memory management which makes them
> > > different / worse than page cache but I don't follow why swapping
> > > necessarily means that isolation is broken. Page refaults don't indicate
> > > that memory isolation is broken after all.
> >
> > Sorry, I meant the performance isolation. Direct reclaim does not
> > really differentiate who to stall and whose CPU to use.
>
> Can you please elaborate concrete scenarios? I'm having a hard time seeing
> differences from page cache.
>

Oh I was talking about the global reclaim here. In global reclaim, any
task can be throttled (throttle_direct_reclaim()). Memory freed by
using the CPU of high priority low latency jobs can be stolen by low
priority batch jobs.

> > > > memcg limit reclaim and memcg limits are overcommitted. Shouldn't
> > > > running out of swap will trigger the OOM earlier which should be
> > > > better than impacting the whole system.
> > >
> > > The primary scenario which was being considered was undercommitted
> > > protections but I don't think that makes any relevant differences.
> > >
> >
> > What is undercommitted protections? Does it mean there is still swap
> > available on the system but the memcg is hitting its swap limit?
>
> Hahaha, I assumed you were talking about memory.high/max and was saying that
> the primary scenarios that were being considered was usage of memory.low
> interacting with swap. Again, can you please give an concrete example so
> that we don't misunderstand each other?
>
> > > This is exactly similar to delay injection for memory.high. What's desired
> > > is slowing down the workload as the available resource is depleted so that
> > > the resource shortage presents as gradual degradation of performance and
> > > matching increase in resource PSI. This allows the situation to be detected
> > > and handled from userland while avoiding sudden and unpredictable behavior
> > > changes.
> > >
> >
> > Let me try to understand this with an example. Memcg 'A' has
>
> Ah, you already went there. Great.
>
> > memory.high = 100 MiB, memory.max = 150 MiB and memory.swap.max = 50
> > MiB. When A's usage goes over 100 MiB, it will reclaim the anon, file
> > and kmem. The anon will go to swap and increase its swap usage until
> > it hits the limit. Now the 'A' reclaim_high has fewer things (file &
> > kmem) to reclaim but the mem_cgroup_handle_over_high() will keep A's
> > increase in usage in check.
> >
> > So, my question is: should the slowdown by memory.high depends on the
> > reclaimable memory? If there is no reclaimable memory and the job hits
> > memory.high, should the kernel slow it down to crawl until the PSI
> > monitor comes and decides what to do. If I understand correctly, the
> > problem is the kernel slow down is not successful when reclaimable
> > memory is very low. Please correct me if I am wrong.
>
> In combination with memory.high, swap slowdown may not be necessary because
> memory.high's slow down mechanism is already there to handle "can't swap"
> scenario whether that's because swap is disabled wholesale, limited or
> depleted. However, please consider the following scenario.
>
> cgroup A has memory.low protection and no other restrictions. cgroup B has
> no protection and has access to swap. When B's memory starts bloating and
> gets the system under memory contention, it'll start consuming swap until it
> can't. When swap becomes depleted for B, there's nothing holding it back and
> B will start eating into A's protection.
>

In this example does 'B' have memory.high and memory.max set and by A
having no other restrictions, I am assuming you meant unlimited high
and max for A? Can 'A' use memory.min?

> The proposed mechanism just plugs another vector for the same condition
> where anonymous memory management breaks down because they can no longer be
> reclaimed due to swap unavailability.
>
> Thanks.
>
> --
> tejun
