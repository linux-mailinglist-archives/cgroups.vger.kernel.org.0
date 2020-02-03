Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B871511BD
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2020 22:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCVVl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Feb 2020 16:21:41 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:46353 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgBCVVk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Feb 2020 16:21:40 -0500
Received: by mail-qt1-f181.google.com with SMTP id e25so12630579qtr.13
        for <cgroups@vger.kernel.org>; Mon, 03 Feb 2020 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjcsQ7wkV3k+UyEAAc2ikCIF9hs55RZZslpGRj2CEow=;
        b=dt54kiu+yirOyfLDCk0Z1km3LK1KDKHkGdo3BDs0TPWFrYpevfnx8ahy0nh5ePkBB6
         8KWiY3Y3Exdbpvttn360VZM37jG3JwvnoPE+rk40nk89m0LEmdBDyNrE80VEDnF1g/Z9
         idfPuZhsd3BpOqwxdx6XPTfO5kJdmO3gLU9+KEyEtWvRapoOxhgWXW6MTRU0BAFa8+Gs
         n1zZjG6qhCjcsb7hPzG5pmc5jQa2H7RiPAc4VfIDVX81SI0O+NCEDGbQ9jRwdHoK6R7+
         Qtot416msvJhyYnFrqROyBVnui2v+BrfQpy7YBMv5WorjF00pqFEvvQpdmMCGCl6XH8q
         uFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjcsQ7wkV3k+UyEAAc2ikCIF9hs55RZZslpGRj2CEow=;
        b=LbaKbX6aH5Y4e/qVVDxJ6Q+bC6SL0i7KXVOK5Pl7nVAHpfKINJ1cFU9wzbehWkZtzf
         sXzUU2C6sHtmfeQiJPpmIOUrCV9PkAngfT4Gide7yRfvCP9WlMq6SMvq18r6kp0QEWrA
         FcqQOStzUg9iOBLkSUiS101edajidtGe5IJ551f2Cw5elM38EXYIU/PbAt1w0thcGo7J
         ct01gRoJ7y+IlMnunf2mxEyLUv6es9F2iudXuB6ekyDAwDrrix7lXKYMRHWz8ZWA7bML
         4vMCNJzdVwzBOwJn0qP8PnuslK98Hj87AqieB59FqT6Hdzj24JCLXdI2635DSQRm+xnR
         T8fA==
X-Gm-Message-State: APjAAAW3Q1TX+hUT5nhtr88EwLKaLG+IV9ziufD8JIrpmVxnaou4Ig+H
        0gxccO25/xvZQpq3rKhTy+C80w==
X-Google-Smtp-Source: APXvYqyz0EIa1fihnaeXFTtYgKzsIodCuEcXwzFnTPu7ghL7GsJYdlIVB7kYaxpA1I7flVc2zGLwFg==
X-Received: by 2002:ac8:365c:: with SMTP id n28mr25267545qtb.260.1580764898731;
        Mon, 03 Feb 2020 13:21:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id p50sm10950286qtf.5.2020.02.03.13.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:21:37 -0800 (PST)
Date:   Mon, 3 Feb 2020 16:21:36 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] mm: memcontrol: fix memory.low proportional
 distribution
Message-ID: <20200203212136.GC6380@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-2-hannes@cmpxchg.org>
 <20200130114929.GT24244@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130114929.GT24244@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 30, 2020 at 12:49:29PM +0100, Michal Hocko wrote:
> On Thu 19-12-19 15:07:16, Johannes Weiner wrote:
> > When memory.low is overcommitted - i.e. the children claim more
> > protection than their shared ancestor grants them - the allowance is
> > distributed in proportion to how much each sibling uses their own
> > declared protection:
> 
> Has there ever been any actual explanation why do we care about
> overcommitted protection? I have got back to email threads when
> the effective hierarchical protection has been proposed.
> http://lkml.kernel.org/r/20180320223353.5673-1-guro@fb.com talks about
> some "leaf memory cgroups are more valuable than others" which sounds ok
> but it doesn't explain why children have to overcommit parent in the
> first place. Do we have any other documentation to explain the usecase?

I don't think we properly documented it, no. Maybe Roman can elaborate
on that a bit more since he added it.

What I can see is that it makes configuration a bit more forgiving and
easier to set up. At the top-level you tend to configure a share of
available host memory, and at the leaf level you tend to communicate a
requirement of the workload. In practice, these two aren't always
perfectly in sync, with workloads coming and going, the software being
changed and configs tuned by different teams.

Now obviously, they cannot be completely out of wack - you can't set
aside 1G of host memory, and then have 30 workloads that need 1G each
to run comfortably. But as long as the ballpark is correct, it's nice
if things keep working when you're off by a couple MB here and there.

> > 	low_usage = min(memory.low, memory.current)
> > 	elow = parent_elow * (low_usage / siblings_low_usage)
> > 
> > However, siblings_low_usage is not the sum of all low_usages. It sums
> > up the usages of *only those cgroups that are within their memory.low*
> > That means that low_usage can be *bigger* than siblings_low_usage, and
> > consequently the total protection afforded to the children can be
> > bigger than what the ancestor grants the subtree.
> > 
> > Consider three groups where two are in excess of their protection:
> > 
> >   A/memory.low = 10G
> >   A/A1/memory.low = 10G, memory.current = 20G
> >   A/A2/memory.low = 10G, memory.current = 20G
> >   A/A3/memory.low = 10G, memory.current =  8G
> >   siblings_low_usage = 8G (only A3 contributes)
> > 
> >   A1/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(8G) = 12.5G -> 10G
> >   A2/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(8G) = 12.5G -> 10G
> >   A3/elow = parent_elow(10G) * low_usage(8G) / siblings_low_usage(8G) = 10.0G
> > 
> >   (the 12.5G are capped to the explicit memory.low setting of 10G)
> > 
> > With that, the sum of all awarded protection below A is 30G, when A
> > only grants 10G for the entire subtree.
> > 
> > What does this mean in practice? A1 and A2 would still be in excess of
> > their 10G allowance and would be reclaimed, whereas A3 would not. As
> > they eventually drop below their protection setting, they would be
> > counted in siblings_low_usage again and the error would right itself.
> > 
> > When reclaim was applied in a binary fashion (cgroup is reclaimed when
> > it's above its protection, otherwise it's skipped) this would actually
> > work out just fine. However, since 1bc63fb1272b ("mm, memcg: make scan
> > aggression always exclude protection"), reclaim pressure is scaled to
> > how much a cgroup is above its protection. As a result this
> > calculation error unduly skews pressure away from A1 and A2 toward the
> > rest of the system.
> 
> Just to make sure I fully follow. The overall excess over protection is
> 38G in your example (for A) while the reclaim would only scan 20G for
> this hierarchy until the error starts to fixup because
> siblings_low_usage would get back into sync, correct?

Exactly right.

> > But why did we do it like this in the first place?
> > 
> > The reasoning behind exempting groups in excess from
> > siblings_low_usage was to go after them first during reclaim in an
> > overcommitted subtree:
> > 
> >   A/memory.low = 2G, memory.current = 4G
> >   A/A1/memory.low = 3G, memory.current = 2G
> >   A/A2/memory.low = 1G, memory.current = 2G
> > 
> >   siblings_low_usage = 2G (only A1 contributes)
> >   A1/elow = parent_elow(2G) * low_usage(2G) / siblings_low_usage(2G) = 2G
> >   A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G
> > 
> > While the children combined are overcomitting A and are technically
> > both at fault, A2 is actively declaring unprotected memory and we
> > would like to reclaim that first.
> > 
> > However, while this sounds like a noble goal on the face of it, it
> > doesn't make much difference in actual memory distribution: Because A
> > is overcommitted, reclaim will not stop once A2 gets pushed back to
> > within its allowance; we'll have to reclaim A1 either way. The end
> > result is still that protection is distributed proportionally, with A1
> > getting 3/4 (1.5G) and A2 getting 1/4 (0.5G) of A's allowance.
> > 
> > [ If A weren't overcommitted, it wouldn't make a difference since each
> >   cgroup would just get the protection it declares:
> > 
> >   A/memory.low = 2G, memory.current = 3G
> >   A/A1/memory.low = 1G, memory.current = 1G
> >   A/A2/memory.low = 1G, memory.current = 2G
> > 
> >   With the current calculation:
> > 
> >   siblings_low_usage = 1G (only A1 contributes)
> >   A1/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(1G) = 2G -> 1G
> >   A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(1G) = 2G -> 1G
> > 
> >   Including excess groups in siblings_low_usage:
> > 
> >   siblings_low_usage = 2G
> >   A1/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G -> 1G
> >   A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G -> 1G ]
> > 
> > Simplify the calculation and fix the proportional reclaim bug by
> > including excess cgroups in siblings_low_usage.
> 
> I think it would be better to also show the initial example with the
> overcommitted protection because this is the primary usecase this patch
> is targeting in the first place.
>    A/memory.low = 10G
>    A/A1/memory.low = 10G, memory.current = 20G
>    A/A2/memory.low = 10G, memory.current = 20G
>    A/A3/memory.low = 10G, memory.current =  8G
>    siblings_low_usage = 28G
>  
>    A1/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(28G) = 3.5G
>    A2/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(28G) = 3.5G
>    A3/elow = parent_elow(10G) * low_usage(8G) / siblings_low_usage(28G) = 2.8G

Good idea, I added this. Attaching the updated patch below.

> so wrt the global reclaim we have 38G of reclaimable memory with 38G
> excess over A's protection. It is true that A3 will get reclaimed way
> before A1, A2 reach their protection which might be just good enough to
> satisfy the external memory pressure because it is not really likely
> that the global pressure would require more than 20G dropped all at
> once, right?

I think the key realization is that in this configuration, neither A1,
A2 nor A3 *have* 10G of protection. So at this point it's fair to
reclaim them all at once.

> That being said I can see the problem with the existing implementation
> and how you workaround it. I am still unclear about why should we care
> about overcommit on the protection that much and in that light the patch
> makes more sense because it doesn't overflow the memory pressure to
> outside.
> Longer term, though, do we really have to care about this scenario? If
> yes, can we have it documented?

Yes, I think that's a good idea. This patch is not because I have a
strong case for overcommit, but because of the bug of escaping
pressure and to simplify things for patch #3.

> Do we want a fixes tag here? There are two changes that need to be
> applied together to have a visible effect.
> 
> Fixes: 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection")
> Fixes: 230671533d64 ("mm: memory.low hierarchical behavior")
> 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for your review, Michal!

Updated patch incorporating your feedback:

---

From 46513e8afdc0f325be7007bdbb4e85a009e17dcc Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 9 Dec 2019 15:18:58 -0500
Subject: [PATCH] mm: memcontrol: fix memory.low proportional distribution

When memory.low is overcommitted - i.e. the children claim more
protection than their shared ancestor grants them - the allowance is
distributed in proportion to how much each sibling uses their own
declared protection:

	low_usage = min(memory.low, memory.current)
	elow = parent_elow * (low_usage / siblings_low_usage)

However, siblings_low_usage is not the sum of all low_usages. It sums
up the usages of *only those cgroups that are within their memory.low*
That means that low_usage can be *bigger* than siblings_low_usage, and
consequently the total protection afforded to the children can be
bigger than what the ancestor grants the subtree.

Consider three groups where two are in excess of their protection:

  A/memory.low = 10G
  A/A1/memory.low = 10G, memory.current = 20G
  A/A2/memory.low = 10G, memory.current = 20G
  A/A3/memory.low = 10G, memory.current =  8G
  siblings_low_usage = 8G (only A3 contributes)

  A1/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(8G) = 12.5G -> 10G
  A2/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(8G) = 12.5G -> 10G
  A3/elow = parent_elow(10G) * low_usage(8G) / siblings_low_usage(8G) = 10.0G

  (the 12.5G are capped to the explicit memory.low setting of 10G)

With that, the sum of all awarded protection below A is 30G, when A
only grants 10G for the entire subtree.

What does this mean in practice? A1 and A2 would still be in excess of
their 10G allowance and would be reclaimed, whereas A3 would not. As
they eventually drop below their protection setting, they would be
counted in siblings_low_usage again and the error would right itself.

When reclaim was applied in a binary fashion (cgroup is reclaimed when
it's above its protection, otherwise it's skipped) this would actually
work out just fine. However, since 1bc63fb1272b ("mm, memcg: make scan
aggression always exclude protection"), reclaim pressure is scaled to
how much a cgroup is above its protection. As a result this
calculation error unduly skews pressure away from A1 and A2 toward the
rest of the system.

But why did we do it like this in the first place?

The reasoning behind exempting groups in excess from
siblings_low_usage was to go after them first during reclaim in an
overcommitted subtree:

  A/memory.low = 2G, memory.current = 4G
  A/A1/memory.low = 3G, memory.current = 2G
  A/A2/memory.low = 1G, memory.current = 2G

  siblings_low_usage = 2G (only A1 contributes)
  A1/elow = parent_elow(2G) * low_usage(2G) / siblings_low_usage(2G) = 2G
  A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G

While the children combined are overcomitting A and are technically
both at fault, A2 is actively declaring unprotected memory and we
would like to reclaim that first.

However, while this sounds like a noble goal on the face of it, it
doesn't make much difference in actual memory distribution: Because A
is overcommitted, reclaim will not stop once A2 gets pushed back to
within its allowance; we'll have to reclaim A1 either way. The end
result is still that protection is distributed proportionally, with A1
getting 3/4 (1.5G) and A2 getting 1/4 (0.5G) of A's allowance.

[ If A weren't overcommitted, it wouldn't make a difference since each
  cgroup would just get the protection it declares:

  A/memory.low = 2G, memory.current = 3G
  A/A1/memory.low = 1G, memory.current = 1G
  A/A2/memory.low = 1G, memory.current = 2G

  With the current calculation:

  siblings_low_usage = 1G (only A1 contributes)
  A1/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(1G) = 2G -> 1G
  A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(1G) = 2G -> 1G

  Including excess groups in siblings_low_usage:

  siblings_low_usage = 2G
  A1/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G -> 1G
  A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G -> 1G ]

Simplify the calculation and fix the proportional reclaim bug by
including excess cgroups in siblings_low_usage.

After this patch, the effective memory.low distribution from the
example above would be as follows:

  A/memory.low = 10G
  A/A1/memory.low = 10G, memory.current = 20G
  A/A2/memory.low = 10G, memory.current = 20G
  A/A3/memory.low = 10G, memory.current =  8G
  siblings_low_usage = 28G

  A1/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(28G) = 3.5G
  A2/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(28G) = 3.5G
  A3/elow = parent_elow(10G) * low_usage(8G) / siblings_low_usage(28G) = 2.8G

Fixes: 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection")
Fixes: 230671533d64 ("mm: memory.low hierarchical behavior")
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c   |  4 +---
 mm/page_counter.c | 12 ++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74cfd4d..874a0b00f89b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6236,9 +6236,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * elow = min( memory.low, parent->elow * ------------------ ),
  *                                        siblings_low_usage
  *
- *             | memory.current, if memory.current < memory.low
- * low_usage = |
- *	       | 0, otherwise.
+ * low_usage = min(memory.low, memory.current)
  *
  *
  * Such definition of the effective memory.low provides the expected
diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..75d53f15f040 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
 		return;
 
 	if (c->min || atomic_long_read(&c->min_usage)) {
-		if (usage <= c->min)
-			protected = usage;
-		else
-			protected = 0;
-
+		protected = min(usage, c->min);
 		old_protected = atomic_long_xchg(&c->min_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
@@ -35,11 +31,7 @@ static void propagate_protected_usage(struct page_counter *c,
 	}
 
 	if (c->low || atomic_long_read(&c->low_usage)) {
-		if (usage <= c->low)
-			protected = usage;
-		else
-			protected = 0;
-
+		protected = min(usage, c->low);
 		old_protected = atomic_long_xchg(&c->low_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
-- 
2.24.1

