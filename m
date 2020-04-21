Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080561B2D67
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 18:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgDUQ4F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729092AbgDUQ4E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 12:56:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03D5C061A41
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 09:56:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g74so15209476qke.13
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5YsErbRArUE2+GC6FlBmkOaHOswqc+e8W+qkPL1BdUY=;
        b=i4vuKbCBOlVZbRJEiiXWMVkJ5mGngXr65l72dVNgOMaMJ+LdqWS886x3ZJe2jqLISd
         2SrUgkYEx3GrdPv+TLIJrFQ3R/E7jXMVfjPXBLjI+FyrhL8ZTZ6mNHNBsaH8yI6F4P0M
         dfKboRNRzTZoXT8ry+hpYtrU/MN5eW1nYOQP9BFVwX+pTuUyPbEEs0nB9zNErrHQp/XB
         skciCbr2QoNzXtFkASB1p6ciQ16W0Up4FJvxo5Ifg0eWV+l0hYMoH0oXLjNyWdM3/U/H
         IMvepSAqViCCfITH+HBwYc+r1hME2W60rRCXKpTrLCbmTi/OqKbtM7FMa8jNCSV3nn6B
         S+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YsErbRArUE2+GC6FlBmkOaHOswqc+e8W+qkPL1BdUY=;
        b=RDNL7v27wVlTOwCWB6+hJIT3OStebYGo26qszGDmFwsH8Ow4ztWK8VHz0nO715uj+W
         tun9F+KCWA7mk8Cy4tl6dpjHSGk/tXKTQb8bBVA2e0ZSE3Vskq20yc0hfSC4C7kkukIP
         tdctXdE10acToveBS36eWwZDsGlTtM53JEA6yCJ1MAycMbQ1hVDrkws7b0qxYSG6grE5
         qLfTqvg1wWHsGEShW2OIMoobE6VW/lhQ9JcpYmMPwoqsFTcq6u+2wNjDsvvtOCYbHVbb
         DK0KgW5dBG4CyZuqcEcZab/7VBmcRs4o6h5PFQd4ZH8TRvx2sAkhDZydbLY0o7YFUP3J
         BASw==
X-Gm-Message-State: AGi0Pua7/9PXo8tMTW1hYxg0vUFTAvJVRn7963BpYNZsfhYXZzoXTk9c
        sRlqBii+yPcpy5NLK/m7dUiW9Q==
X-Google-Smtp-Source: APiQypJAdsMsc5tcfv69BQzWiGYRU8oz8l23NLMallHxZZ+MoTPhAkCSasTer+2gMvpOwTVwcAjmJw==
X-Received: by 2002:a37:a486:: with SMTP id n128mr22577446qke.140.1587488163121;
        Tue, 21 Apr 2020 09:56:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:708f])
        by smtp.gmail.com with ESMTPSA id i5sm2030410qtw.97.2020.04.21.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:56:02 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:56:01 -0400
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
Message-ID: <20200421165601.GA345998@cmpxchg.org>
References: <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421161138.GL27314@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 21, 2020 at 06:11:38PM +0200, Michal Hocko wrote:
> On Tue 21-04-20 10:27:46, Johannes Weiner wrote:
> > On Tue, Apr 21, 2020 at 01:06:12PM +0200, Michal Hocko wrote:
> [...]
> > > I am also not sure about the isolation aspect. Because an external
> > > memory pressure might have pushed out memory to the swap and then the
> > > workload is throttled based on an external event. Compare that to the
> > > memory.high throttling which is not directly affected by the external
> > > pressure.
> > 
> > Neither memory.high nor swap.high isolate from external pressure.
> 
> I didn't say they do. What I am saying is that an external pressure
> might punish swap.high memcg because the external memory pressure would
> eat up the quota and trigger the throttling.

External pressure could also push a cgroup into a swap device that
happens to be very slow and cause the cgroup to be throttled that way.

But that effect is actually not undesirable. External pressure means
that something more important runs and needs the memory of something
less important (otherwise, memory.low would deflect this intrusion).

So we're punishing/deprioritizing the right cgroup here. The one that
isn't protected from memory pressure.

> It is fair to say that this externally triggered interference is already
> possible with swap.max as well though. It would likely be just more
> verbose because of the oom killer intervention rather than a slowdown.

Right.

> > They
> > are put on cgroups so they don't cause pressure on other cgroups. Swap
> > is required when either your footprint grows or your available space
> > shrinks. That's why it behaves like that.
> > 
> > That being said, I think we're getting lost in the implementation
> > details before we have established what the purpose of this all
> > is. Let's talk about this first.
> 
> Thanks for describing it in the length. I have a better picture of the
> intention (this should have been in the changelog ideally). I can see
> how the swap consumption throttling might be useful but I still dislike the
> proposed implementation. Mostly because of throttling of all allocations
> regardless whether they can contribute to the swap consumption or not.

I mean, even if they're not swappable, they can still contribute to
swap consumption that wouldn't otherwise have been there. Each new
page that comes in displaces another page at the end of the big LRU
pipeline and pushes it into the mouth of reclaim - which may swap. So
*every* allocation has a certain probability of increasing swap usage.

The fact that we have reached swap.high is a good hint that reclaim
has indeed been swapping quite aggressively to accomodate incoming
allocations, and probably will continue to do so.

We could check whether there are NO anon pages left in a workload, but
that's such an extreme and short-lived case that it probably wouldn't
make a difference in practice.

We could try to come up with a model that calculates a probabilty of
each new allocation to cause swap. Whether that new allocation itself
is swapbacked would of course be a factor, but there are other factors
as well: the millions of existing LRU pages, the reclaim decisions we
will make, swappiness and so forth.

Of course, I agree with you, if all you have coming in is cache
allocations, you'd *eventually* run out of pages to swap.

However, 10G of new active cache allocations can still cause 10G of
already allocated anon pages to get swapped out. For example if a
malloc() leak happened *before* the regular cache workingset is
established. We cannot retro-actively throttle those anon pages, we
can only keep new allocations from pushing old ones into swap.
