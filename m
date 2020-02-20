Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2522F1669A2
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBTVOa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 16:14:30 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:47062 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgBTVOa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 16:14:30 -0500
Received: by mail-vs1-f67.google.com with SMTP id t12so3629799vso.13
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 13:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktuN17gmiqlKE/I4GYw0sVSSXcxY6RgmY2JpLivgLB4=;
        b=F18pix32o4K9RJdf3Ge/L+3NgYmCrMt8y8HZvV7+XlYsyAkPvClxTvbluEB0EVBNoS
         9+5z76T7v66vZmEXr5Fa4C/xKMwaD8hX4VGSvj8eZYiZhBSzZACB9ZEorWg+DVYqunsU
         RFZh8hBBTc1wggIAqZQ8fPUMT+E336fsvX6EBArXEQTHs+Q6GmOMMeP/F2BbTvjRp3yP
         38VdoqNYXn7SI2xBaY09WCr+qilbJTaiNEXxjdzAV9AQQ9JUqPWXdte/fUYO6KBM0A0C
         FpO9xdOiWJLrQSK1axpfwR42CRT4jmUVITnSPFR0HZjupTxdP02SIacYzr13JUNGmFkW
         yvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktuN17gmiqlKE/I4GYw0sVSSXcxY6RgmY2JpLivgLB4=;
        b=hFIWibp6vn9zD6deqsOO36jiVwoxQmdUbyIvfRima+zOKy76CSFAL+tL3gpU8Ppz6u
         tyK9bDgPrJUzmMVUHt8TLCIOoYT9HuSwf/FtepcjR1ITH19RIbXYsU3OEqdeNroQJODm
         /dhJdefCbVatJD1l6nDW0VnyAaFo43qP6oF8MpYLCU8oPwfLKXTkwet5tydiCNtUKYEx
         VmhhI89/w7qn9aUQyvlRKBhukynu/ywpG4J5thQiq6OiC6mheZyT8afmv81U7EEAG4Hn
         rBMBS7YQHByMN+t8MjEIFPZNuq7FpHek8OkG7AZpqLSIrgqBLwxwKaqbFiE0UcJ5198O
         OX0Q==
X-Gm-Message-State: APjAAAWF+oVtgN8BwD8W4pVgMrjh06V+7gb/U+5vVUSxlZubdF62+Zlz
        CmreG3mWccj1HpfwoPud6SZs8rvmbeXpjghDy5rJyg==
X-Google-Smtp-Source: APXvYqz36y/bjwSmf4YA26Hzf3Na7uNT93GpIDlzKWJuYGCdukm8wFMJ3Hp3KJ5ZZyx0QkIHmybvHgs4qnksLGR44Kc=
X-Received: by 2002:a67:fbcf:: with SMTP id o15mr17597426vsr.13.1582233268659;
 Thu, 20 Feb 2020 13:14:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
 <CALvZod5bDQvYHTMCHoWbhiEbcBs4KATv=QLdjjivJ33kb6ZY+w@mail.gmail.com> <20200220210344.GK54486@cmpxchg.org>
In-Reply-To: <20200220210344.GK54486@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Feb 2020 13:14:17 -0800
Message-ID: <CALvZod5_AgaS_=uvXsfsL1bthxMUk3DiD90Ach=cdMkaync5vQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes,

On Thu, Feb 20, 2020 at 1:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hey Shakeel!
>
> On Thu, Feb 20, 2020 at 10:14:45AM -0800, Shakeel Butt wrote:
> > On Thu, Feb 20, 2020 at 8:52 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > >
> > > memalloc_use_memcg() worked for kernel allocations but was silently
> > > ignored for user pages.
> > >
> > > This patch establishes a precedence order for who gets charged:
> > >
> > > 1. If there is a memcg associated with the page already, that memcg is
> > >    charged. This happens during swapin.
> > >
> > > 2. If an explicit mm is passed, mm->memcg is charged. This happens
> > >    during page faults, which can be triggered in remote VMs (eg gup).
> > >
> > > 3. Otherwise consult the current process context. If it has configured
> > >    a current->active_memcg, use that.
> >
> > What if css_tryget_online(current->active_memcg) in
> > get_mem_cgroup_from_current() fails? Do we want to change this to
> > css_tryget() and even if that fails should we fallback to
> > root_mem_cgroup or current->mm->memcg?
>
> Good questions.
>
> I think we can switch to css_tryget(). If a cgroup goes offline
> between issuing the IO and the loop layer executing that IO, the
> resources used could end up in the root instead of the closest
> ancestor of the offlined group. However, the risk of that actually
> happening and causing problems is probably pretty small, and the
> behavior isn't really worse than before Dan's patches.

Agreed.

>
> Would you mind sending a separate patch for this? AFAICS similar
> concerns apply to all users of foreign charging.

Sure and yes similar concerns apply to other users as well.

>
> As for tryget failing: can that actually happen? AFAICS, all current
> users acquire a reference first (get_memcg_from_somewhere()) that they
> assign to current->active_memcg. We should probably codify this rule
> and do WARN_ON(!css_tryget()) /* current->active_memcg must hold a ref */

Yes, we should WARN_ON().

Shakeel
