Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA01B2FD4
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDUTJn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 15:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726195AbgDUTJn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 15:09:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE81C0610D5
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 12:09:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j14so12013859lfg.9
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OZUa0vieQ1Oea0BEF872qJNVIX8tFWB55DM8OOSHUk=;
        b=KJ58xpGkC689uHjFK5ok/5sH7ewV2axjKaDcGUYnOqEBXTKYL3Nmh3lwwtytuKbvqs
         6Px/Gk1cCKOpa4RxMY56SLIseRt9lyyS0SlTzdnGFcCb8do3+TFc4KOqhHoSzwiOWp3A
         0edJuRxoYqbQtA73NGtK9azAD5Q5eBPqSLf6L5R1dkoGOio5nKToPtoZYlnjktnxNZEU
         1RDDNoD2SaissDguu0syitJH/abOvIulsvhXs7T80aRY6bhtWCqgfktfUyT4WwC+DAbJ
         9lPcThw2cM13Ni2DmCG1pAIbAXPozwpZv7wq6lNBLYMMPd8KofxJlmGwf90S5QPCjWrh
         NVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OZUa0vieQ1Oea0BEF872qJNVIX8tFWB55DM8OOSHUk=;
        b=YUPOugcqFMcGD0pcyWaG16I/cS1NTetDnAirnJfHf6YP6FX/XD9jnQvrB4AdiSTLL1
         OV0UsR9GcBGiSGFus9jysjxcyyShrcJu5tBk/cXeO8XJj0h2dFhadV35Oj3Z+fX9xEYi
         ae1AyE6NSDZiHGF6dT1E0qAh/1vwvDvRGLErQFus+DZiEtCtUTwNar5bplntP3Ta3v7a
         77Nj3SCXfoc8scLNbUtf36orMc28gvZfQ7RkBTUXHHAVkBNN495B7A/D/Ule3jDTh+qO
         3tQA8tnaBWN7pzmmwldlAplSKo20KkZWFVoM5ohzEnLtml1iLA7fOLkzD96DbQJoG/UR
         If1Q==
X-Gm-Message-State: AGi0PuYqHFnKHi9EmgtP3YKu1VrMnCAs3tEo9PqLDFGSEt6mIJw2Yn5o
        0O/gFIktUCphVs3AuDx5TsUOXH1FdiKrfrggFbq+cw==
X-Google-Smtp-Source: APiQypLcvmawH3AHRes9/2JHfNXMXbprPwy+Yad27I9KfHfnPLGOmq+gmvjSMEZAhgx9I4Wb2D9O310jQbBjDCKQHX0=
X-Received: by 2002:a19:5206:: with SMTP id m6mr14510533lfb.33.1587496179680;
 Tue, 21 Apr 2020 12:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200417173615.GB43469@mtj.thefacebook.com> <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com> <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com> <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com> <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com> <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
In-Reply-To: <20200421142746.GA341682@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Apr 2020 12:09:27 -0700
Message-ID: <CALvZod650M1_46R4OiS1mug+LKbjD=1s_xqckh9T6V8fPjct2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes,

On Tue, Apr 21, 2020 at 7:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[snip]
>

The following is a very good description and it gave me an idea of how
you (FB) are approaching the memory overcommit problem. The approach
you are taking is very different from ours and I would like to pick
your brain on the why (sorry this might be a bit tangent to the
series).

Please correct me if I am wrong, your memory overcommit strategy is to
let the jobs use memory as much as they want but when the system is
low on memory, slow down everyone (to not let the kernel oom-killer
trigger) and let the userspace oomd take care of releasing the
pressure.

We run multiple latency sensitive jobs along with multiple batch jobs
on the machine. Overcommitting the memory on such machines, we learn
that the battle is already lost when the system starts doing direct
reclaim. Direct reclaim does not differentiate between the reclaimers.
We could have tried the "slow down" approach but our latency sensitive
jobs prefer to die and let the load-balancer handover the request to
some other instance of the job than to stall the request for
non-deterministic time. We could have tried the PSI-like monitor to
trigger oom-kills when latency sensitive jobs start seeing the stalls
but that would be less work-conserving and  non-deterministic behavior
(i.e. sometimes more oom-kills and sometimes more memory
overcommitted). The approach we took was to do proactive reclaim along
with a very low latency refault medium (in-memory compression).

Now as you mentioned, you are trying to be a bit more aggressive in
the memory overcommit and I can see the writing on the wall that you
will be stuffing more jobs of different types on a machine, why do you
think the "slow down" approach will be able to provide the performance
isolation guarantees?

Couple of questions inlined.

> Just imagine we had a really slow swap device. Some spinning disk that
> is terrible at random IO. From a performance point of view, this would
> obviously suck. But from a resource management point of view, this is
> actually pretty useful in slowing down a workload that is growing
> unsustainably. This is so useful, in fact, that Virtuozzo implemented
> virtual swap devices that are artificially slow to emulate this type
> of "punishment".
>
> A while ago, we didn't have any swap configured. We set memory.high
> and things were good: when things would go wrong and the workload
> expanded beyond reclaim capabilities, memory.high would inject sleeps
> until oomd would take care of the workload.
>
> Remember that the point is to avoid the kernel OOM killer and do OOM
> handling in userspace. That's the difference between memory.high and
> memory.max as well.
>
> However, in many cases we now want to overcommit more aggressively
> than memory.high would allow us. For this purpose, we're switching to
> memory.low, to only enforce limits when *physical* memory is
> short. And we've added swap to have some buffer zone at the edge of
> this aggressive overcommit.
>
> But swap has been a good news, bad news situation. The good news is
> that we have really fast swap, so if the workload is only temporarily
> a bit over RAM capacity, we can swap a few colder anon pages to tide
> the workload over, without the workload even noticing. This is
> fantastic from a performance point of view. It effectively increases
> our amount of available memory or the workingset sizes we can support.
>
> But the bad news is also that we have really fast swap. If we have a
> misbehaving workload that has a malloc() problem, we can *exhaust*
> swap space very, very quickly. Where we previously had those nice
> gradual slowdowns from memory.high when reclaim was failing, we now
> have very powerful reclaim that can swap at hundreds of megabytes per
> second - until swap is suddenly full and reclaim abruptly falls apart.

I think the concern is kernel oom-killer will be invoked too early and
not giving the chance to oomd. I am wondering if the PSI polling
interface is usable here as it can give events in milliseconds. Will
that be too noisy?

>
> So while fast swap is an enhancement to our memory capacity, it
> doesn't reliably act as that overcommit crumble zone that memory.high
> or slower swap devices used to give us.
>
> Should we replace those fast SSDs with crappy disks instead to achieve
> this effect? Or add a slow disk as a secondary swap device once the
> fast one is full? That would give us the desired effect, but obviously
> it would be kind of silly.
>
> That's where swap.high comes in. It gives us the performance of a fast
> drive during temporary dips into the overcommit buffer, while also
> providing that large rubber band kind of slowdown of a slow drive when
> the workload is expanding at an unsustainable trend.
>

BTW can you explain why is the system level low swap slowdown not
sufficient and a per-cgroup swap.high is needed? Or maybe you want to
slow down only specific cgroups.

> > There is also an aspect of non-determinism. There is no control over
> > the file vs. swap backed reclaim decision for memcgs. That means that
> > behavior is going to be very dependent on the internal implementation of
> > the reclaim. More swapping is going to fill up swap quota quicker.
>
> Haha, I mean that implies that reclaim is arbitrary. While it's
> certainly not perfect, we're trying to reclaim the pages that are
> least likely to be used again in the future. There is noise in this
> heuristic, obviously, but it's still going to correlate with reality
> and provide some level of determinism.
>
> The same is true for memory.high, btw. Depending on how effective
> reclaim is, we're going to throttle more or less. That's also going to
> fluctuate somewhat around implementation changes.
>
> > > It fits together with memory.low in that it prevents runaway anon allocation
> > > when swap can't be allocated anymore. It's addressing the same problem that
> > > memory.high slowdown does. It's just a different vector.
> >
> > I suspect that the problem is more related to the swap being handled as
> > a separate resource. And it is still not clear to me why it is easier
> > for you to tune swap.high than memory.high. You have said that you do
> > not want to set up memory.high because it is harder to tune but I do
> > not see why swap is easier in this regards. Maybe it is just that the
> > swap is almost never used so a bad estimate is much easier to tolerate
> > and you really do care about runaways?
>
> You hit the nail on the head.
>
> We don't want memory.high (in most cases) because we want to utilize
> memory to the absolute maximum.
>
> Obviously, the same isn't true for swap because there is no DaX and
> most workloads can't run when 80% of their workingset are on swap.
>
> They're not interchangeable resources.
>

What do you mean by not interchangeable? If I keep the hot memory (or
workingset) of a job in DRAM and cold memory in swap and control the
rate of refaults by controlling the definition of cold memory then I
am using the DRAM and swap interchangeably and transparently to the
job (that is what we actually do).

I am also wondering if you guys explored the in-memory compression
based swap medium and if there are any reasons to not follow that
route.

Oh you mentioned DAX, that brings to mind a very interesting topic.
Are you guys exploring the idea of using PMEM as a cheap slow memory?
It is byte-addressable, so, regarding memcg accounting, will you treat
it as a memory or a separate resource like swap in v2? How does your
memory overcommit model work with such a type of memory?

thanks,
Shakeel
