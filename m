Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893671B2989
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDUO1u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgDUO1t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 10:27:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EAFC061A10
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 07:27:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l25so14666709qkk.3
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tYoc8FiAIjXlVgfTeNKYehXk8thWQzu26KTwN7jGGoU=;
        b=ih7CuO81dRNdmtkqseEHm0GEMGd6w5JYNzhBZLBwM7rbECi30KoIPMf4qOTX/VDuXs
         iAB6LFwJzYe34nQZxk02W3igOdUCaNlOWKIN9G5rR2cPS7+D1tUJEJYE9+T51YhbzOap
         dunkh69Jv59N44RC8RSmfM3CKgF9q92d+9DiYNT0+2+3btZ5pW6H+aUU1F/ZxeQeyeRY
         BZ562xn5g6/JJ5Ybu/GjjJrDaZfHD+yPY+2Mkhx9m7FUcp+7V/5VFxQkRSzNgdakGPwE
         DWmStcad2qbMI/vwPklhiZlDwnbJZl6p8rPXQXUBcTzLtBoYStjxNPbtWiMGUGwjpMGE
         HR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYoc8FiAIjXlVgfTeNKYehXk8thWQzu26KTwN7jGGoU=;
        b=RsEBpoBHYCI/wn7fEYOorvQam0ePeUqFXoD6GcoedcyusAc5ItVJt62CEoSCWYsXJt
         PftvNtaosht2pzGlFFsBfAwIerDJYrEdvNkGxQmDK/UshRH2F6fWEMlLBK3XwJQXMilA
         mi5LNb4UCCCuLQI9rPeVpQ5bmwmXGYwyegHENkP3f1xD9yjdaORRKU1p+3GpiHZNZB9O
         Wyc3L27vRHbTubs1FTgmkJyOS/2INtahoFBvEjOopqoX5l+blTv1NpeybXF4scfwCh0K
         v3L6hFkXAU7A4aVynNrx4ielXiFzpjemtSl3CB9D8aof22uhTZwRe5kAyiiqeqZmAkPy
         U3BA==
X-Gm-Message-State: AGi0PuZovCN49RKiN2o4Mc9BylTKfk6MV5NBfWh293Md5XiKwmUxkbqv
        zhQdMJNRGiDAs0SnfazpXmucF+Ura8U=
X-Google-Smtp-Source: APiQypJwhsCThGm0fAdiTn/7jaQTrSlnrLkhuf+SiHbZE3xuyaYzV6po8koAnAqTUk1bC7b3WdXWMw==
X-Received: by 2002:a05:620a:1009:: with SMTP id z9mr21033075qkj.270.1587479268412;
        Tue, 21 Apr 2020 07:27:48 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id m25sm1816453qkg.83.2020.04.21.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:27:47 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:27:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200421142746.GA341682@cmpxchg.org>
References: <20200417173615.GB43469@mtj.thefacebook.com>
 <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421110612.GD27314@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 21, 2020 at 01:06:12PM +0200, Michal Hocko wrote:
> On Mon 20-04-20 13:06:50, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Apr 20, 2020 at 07:03:18PM +0200, Michal Hocko wrote:
> > > I have asked about the semantic of this know already and didn't really
> > > get any real answer. So how does swap.high fit into high limit semantic
> > > when it doesn't act as a limit. Considering that we cannot reclaim swap
> > > space I find this really hard to grasp.
> > 
> > memory.high slow down is for the case when memory reclaim can't be depended
> > upon for throttling, right? This is the same. Swap can't be reclaimed so the
> > backpressure is applied by slowing down the source, the same way memory.high
> > does.
> 
> Hmm, but the two differ quite considerably that we do not reclaim any
> swap which means that while no reclaimable memory at all is pretty much
> the corner case (essentially OOM) the no reclaimable swap is always in
> that state. So whenever you hit the high limit there is no other way
> then rely on userspace to unmap swap backed memory or increase the limit.

This is similar to memory.high. The memory.high throttling kicks in
when reclaim is NOT keeping up with allocation rate. There may be some
form of reclaim going on, but it's not bucking the trend, so you also
rely on userspace to free memory voluntarily or increase the limit -
or, of course, the throttling sleeps to grow until oomd kicks in.

> Without that there is always throttling. The question also is what do
> you want to throttle in that case? Any swap backed allocation or swap
> based reclaim? The patch throttles any allocations unless I am
> misreading. This means that also any other !swap backed allocations get
> throttled as soon as the swap quota is reached. Is this really desirable
> behavior? I would find it quite surprising to say the least.

When cache or slab allocations enter reclaim, they also swap.

We *could* be looking whether there are actual anon pages on the LRU
lists at this point. But I don't think it matters in practice, please
read on below.

> I am also not sure about the isolation aspect. Because an external
> memory pressure might have pushed out memory to the swap and then the
> workload is throttled based on an external event. Compare that to the
> memory.high throttling which is not directly affected by the external
> pressure.

Neither memory.high nor swap.high isolate from external pressure. They
are put on cgroups so they don't cause pressure on other cgroups. Swap
is required when either your footprint grows or your available space
shrinks. That's why it behaves like that.

That being said, I think we're getting lost in the implementation
details before we have established what the purpose of this all
is. Let's talk about this first.

Just imagine we had a really slow swap device. Some spinning disk that
is terrible at random IO. From a performance point of view, this would
obviously suck. But from a resource management point of view, this is
actually pretty useful in slowing down a workload that is growing
unsustainably. This is so useful, in fact, that Virtuozzo implemented
virtual swap devices that are artificially slow to emulate this type
of "punishment".

A while ago, we didn't have any swap configured. We set memory.high
and things were good: when things would go wrong and the workload
expanded beyond reclaim capabilities, memory.high would inject sleeps
until oomd would take care of the workload.

Remember that the point is to avoid the kernel OOM killer and do OOM
handling in userspace. That's the difference between memory.high and
memory.max as well.

However, in many cases we now want to overcommit more aggressively
than memory.high would allow us. For this purpose, we're switching to
memory.low, to only enforce limits when *physical* memory is
short. And we've added swap to have some buffer zone at the edge of
this aggressive overcommit.

But swap has been a good news, bad news situation. The good news is
that we have really fast swap, so if the workload is only temporarily
a bit over RAM capacity, we can swap a few colder anon pages to tide
the workload over, without the workload even noticing. This is
fantastic from a performance point of view. It effectively increases
our amount of available memory or the workingset sizes we can support.

But the bad news is also that we have really fast swap. If we have a
misbehaving workload that has a malloc() problem, we can *exhaust*
swap space very, very quickly. Where we previously had those nice
gradual slowdowns from memory.high when reclaim was failing, we now
have very powerful reclaim that can swap at hundreds of megabytes per
second - until swap is suddenly full and reclaim abruptly falls apart.

So while fast swap is an enhancement to our memory capacity, it
doesn't reliably act as that overcommit crumble zone that memory.high
or slower swap devices used to give us.

Should we replace those fast SSDs with crappy disks instead to achieve
this effect? Or add a slow disk as a secondary swap device once the
fast one is full? That would give us the desired effect, but obviously
it would be kind of silly.

That's where swap.high comes in. It gives us the performance of a fast
drive during temporary dips into the overcommit buffer, while also
providing that large rubber band kind of slowdown of a slow drive when
the workload is expanding at an unsustainable trend.

> There is also an aspect of non-determinism. There is no control over
> the file vs. swap backed reclaim decision for memcgs. That means that
> behavior is going to be very dependent on the internal implementation of
> the reclaim. More swapping is going to fill up swap quota quicker.

Haha, I mean that implies that reclaim is arbitrary. While it's
certainly not perfect, we're trying to reclaim the pages that are
least likely to be used again in the future. There is noise in this
heuristic, obviously, but it's still going to correlate with reality
and provide some level of determinism.

The same is true for memory.high, btw. Depending on how effective
reclaim is, we're going to throttle more or less. That's also going to
fluctuate somewhat around implementation changes.

> > It fits together with memory.low in that it prevents runaway anon allocation
> > when swap can't be allocated anymore. It's addressing the same problem that
> > memory.high slowdown does. It's just a different vector.
> 
> I suspect that the problem is more related to the swap being handled as
> a separate resource. And it is still not clear to me why it is easier
> for you to tune swap.high than memory.high. You have said that you do
> not want to set up memory.high because it is harder to tune but I do
> not see why swap is easier in this regards. Maybe it is just that the
> swap is almost never used so a bad estimate is much easier to tolerate
> and you really do care about runaways?

You hit the nail on the head.

We don't want memory.high (in most cases) because we want to utilize
memory to the absolute maximum.

Obviously, the same isn't true for swap because there is no DaX and
most workloads can't run when 80% of their workingset are on swap.

They're not interchangeable resources.

So yes, swap only needs to be roughly sized, and we want to catch
runaways. Sometimes they are caught by the IO slowdown, but for some
access patterns the IO is too efficient and we need a bit of help when
we're coming up against that wall. And we don't really care about not
utilizing swap capacity to the absolute max.

[ Hopefully that also answers your implementation questions above a
  bit better. We could be more specific about which allocations to
  slow down, only slow down if there are actual anon pages etc. But
  our goal isn't to emulate a realistic version of a slow swap device,
  we just want the overcommit crumble zone they provide. ]
