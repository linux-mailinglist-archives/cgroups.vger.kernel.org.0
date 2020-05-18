Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE11D889C
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgERT6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgERT6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 15:58:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3127DC061A0C
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 12:58:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c12so5723457lfc.10
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEA6Z37n+dIxoPy/cAeV7r3f9kjOxgmoOifLY8ksphk=;
        b=qY3JbU7V0zMxmIoiyAzyLmkPij7GBgHYB9z+V5VwZqHRUkhRp0nvcxt9N/lbiW5DCW
         tfebzN7RM85+b6AWVY3bQOfruCuiMw/NdWeOqOcWRmdjg0mmmDb1xmIifeO2rZH2zoaY
         9Eytct9wIzcvnLiI3nWXGKcnCucaVXGoc55UUkIoLjyILNRau2eciaAcqqMKFu/J0lmq
         guy6ia/x2XcltdPpR+C7EJ2d6Y9gZZ/iwyvrNEgeNnn56ejd7PEVPG+HWNN0M7Qebg52
         qODN0rWU2yz/WCBO9rWzp32AhMcndZBlBbiblLOYCqU9sfdd5PLmruOomEz8hPkio4Yr
         R2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEA6Z37n+dIxoPy/cAeV7r3f9kjOxgmoOifLY8ksphk=;
        b=lwQoI5LLxlXzutM8irO2LhsmdAKtZLF45KJuIWaGNCMm+ROdC70Ym4q/bVywZO9d7q
         xzzACOQOQAcdPFIEVxbOJ7FVpPL1tPQ4aNA7uDHSLLx/O9rO0tYHRGJKTtz6ZivAFHnQ
         15H+BNjiKPzrFJE48gnA7iew6qKlplQeyDl7IXjJF9yBsV9OfKNBnWdC2PLc+CIHrsDc
         Z3oDl6nMo2aOI5zeuHtOUEk3Hfmt04r73p4M72oF4p/GGVQNPEamBGHEEtZ1IDSbIn63
         MUD85Hx49+eX984mMZZSlJDk+P+TAbELEtod2jR7WV0QXJiAHd2GCNlZ8LoIWrP1YOP7
         WWTg==
X-Gm-Message-State: AOAM530pUGzgQblawDiOqHq1OIPjn5iwQyslNT/32Mj7rBWdZIJU3z1k
        ebAvy2C+4z3Q/01zYwxkDXc5nk8XCAD35wlQ9linnQ==
X-Google-Smtp-Source: ABdhPJw4iCNv/AyFBNFA72RWG6uowVWqdMhyiCQqroGvKY5OvTYfA811hd+5ZD2FbCXR0dRQPan3ZQAd6NyokqjF/6E=
X-Received: by 2002:ac2:5ccf:: with SMTP id f15mr12602516lfq.216.1589831892371;
 Mon, 18 May 2020 12:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200515202027.3217470-1-kuba@kernel.org> <20200515202027.3217470-4-kuba@kernel.org>
 <CALvZod5Dcee8CaNfkhQQbvC1OuOTO7qE9bJw9NAa8nd2Cru6hA@mail.gmail.com> <20200518124210.37335d0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200518124210.37335d0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 May 2020 12:58:01 -0700
Message-ID: <CALvZod7AMhBKCGXB4FuZYTzYcgeMypCXSWqyzJSzyQDGqm8bOA@mail.gmail.com>
Subject: Re: [PATCH mm v3 3/3] mm: automatically penalize tasks with high swap use
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 18, 2020 at 12:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun, 17 May 2020 06:44:52 -0700 Shakeel Butt wrote:
> > > Use one counter for number of pages allocated under pressure
> > > to save struct task space and avoid two separate hierarchy
> > > walks on the hot path.
> >
> > The above para seems out of place. It took some time to realize you
> > are talking about current->memcg_nr_pages_over_high. IMO instead of
> > this para, a comment in code would be much better.
>
> Where would you like to see the comment? In struct task or where
> counter is bumped?
>

I think the place where the counter is bumped.

> > > Take the new high limit into account when determining if swap
> > > is "full". Borrowing the explanation from Johannes:
> > >
> > >   The idea behind "swap full" is that as long as the workload has plenty
> > >   of swap space available and it's not changing its memory contents, it
> > >   makes sense to generously hold on to copies of data in the swap
> > >   device, even after the swapin. A later reclaim cycle can drop the page
> > >   without any IO. Trading disk space for IO.
> > >
> > >   But the only two ways to reclaim a swap slot is when they're faulted
> > >   in and the references go away, or by scanning the virtual address space
> > >   like swapoff does - which is very expensive (one could argue it's too
> > >   expensive even for swapoff, it's often more practical to just reboot).
> > >
> > >   So at some point in the fill level, we have to start freeing up swap
> > >   slots on fault/swapin.
> >
> > swap.high allows the user to force the kernel to start freeing swap
> > slots before half-full heuristic, right?
>
> I'd say that the definition of full is extended to include swap.high.
