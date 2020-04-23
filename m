Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5191B5E79
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2020 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgDWPAT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728551AbgDWPAS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 11:00:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BAC08E934
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2020 08:00:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s63so6679874qke.4
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2020 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oENiaGCCgBNwU5CHpSWbzNiCtZrcoAbIQaEpyFI4Zyc=;
        b=F2+EdRXA4b1rXFir1jFJSgrXJrJ5o9riv22KqA2p86kWQCyPvSUKy4wKB5WLOdHwtU
         7D96mkRjvmaweBXzPi2GEsXuxbq388HMxcRU83Er8dCV4lcCg2/DOORi0sDl7O8iRp+5
         vbtBgli28f2Zs+HaIMLOMCfturcG/BAnCI32bf3pSvbAReVR0eDHy8HtNXzG0/QRSBH+
         qWU3i1iD+MXHatIKUEESuiFrTAosErCOciZ8HryVPP9t0jX8GY7r407zg/uK0sxKkAYo
         C2Bu6rQN59Wzr3dWDCUOUHAgilY68HaBE2geARf+DZppq7vAmSW8D9fq7H4C3yZFmVK6
         SaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oENiaGCCgBNwU5CHpSWbzNiCtZrcoAbIQaEpyFI4Zyc=;
        b=GR95BgUo4mCu2VTE9jwSyt2qlHSuikjIdTvRshFjCWP+tw8AGrtHWzaDgE0rOvPsmp
         YvFBSXnwAtrpTAXMjYpbTtcEmdNzmrjqk403q1X2xLdyzDRyMhg6RFUZ/BnYB+Mfarx7
         nCDW08UcFj+1VlIg1zyKTESit7aRemXPixljk/FfYM78QCeHremD1OS7WHPX875M38ax
         GJMUJrnleY1ZhvyaCNECanMBZWfQ7ZDhlXymSv9JTkZM/MpkPbEyDKtho77XwTi1c4uQ
         98xNTLC1DiSLiDycj6mHBUlt+40dpFGbk7ipiMF8XANunta1UoyHeKw6A65joQr9Fij3
         fYhQ==
X-Gm-Message-State: AGi0PuaWgLXBaoVKMhZrfhhGBtJ86NC8xRYNBQTWnFFQwlhwNQ6iyPqy
        /9HvRUJgifOqNaBHGcJcOjxcFQ==
X-Google-Smtp-Source: APiQypIGMXWgb+JOCSTClLpsOynuZyyO0/tNOhTAuVj8e6LOlXkdiIgMHPZYM2Rc499Hi3Ex5IcfiA==
X-Received: by 2002:a37:9d08:: with SMTP id g8mr4014670qke.138.1587654017733;
        Thu, 23 Apr 2020 08:00:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id h2sm1695542qkh.91.2020.04.23.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:00:16 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:00:15 -0400
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
Message-ID: <20200423150015.GE362484@cmpxchg.org>
References: <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
 <20200422154318.GK30312@dhcp22.suse.cz>
 <20200422171328.GC362484@cmpxchg.org>
 <20200422184921.GB4206@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422184921.GB4206@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 22, 2020 at 08:49:21PM +0200, Michal Hocko wrote:
> On Wed 22-04-20 13:13:28, Johannes Weiner wrote:
> > On Wed, Apr 22, 2020 at 05:43:18PM +0200, Michal Hocko wrote:
> > > On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
> > > I am also missing some information about what the user can actually do
> > > about this situation and call out explicitly that the throttling is
> > > not going away until the swap usage is shrunk and the kernel is not
> > > capable of doing that on its own without a help from the userspace. This
> > > is really different from memory.high which has means to deal with the
> > > excess and shrink it down in most cases. The following would clarify it
> > 
> > I think we may be talking past each other. The user can do the same
> > thing as in any OOM situation: wait for the kill.
> 
> That assumes that reaching swap.high is going to converge to the OOM
> eventually. And that is far from the general case. There might be a
> lot of other reclaimable memory to reclaim and stay in the current
> state.

No, that's really the general case. And that's based on what users
widely experience, including us at FB. When swap is full, it's over.
Multiple parties have independently reached this conclusion.

This will be the default assumption in major distributions soon:
https://fedoraproject.org/wiki/Changes/EnableEarlyoom

> > > for me
> > > 	"Once the limit is exceeded it is expected that the userspace
> > > 	 is going to act and either free up the swapped out space
> > > 	 or tune the limit based on needs. The kernel itself is not
> > > 	 able to do that on its own.
> > > 	"
> > 
> > I mean, in rare cases, maybe userspace can do some loadshedding and be
> > smart about it. But we certainly don't expect it to.
> 
> I really didn't mean to suggest any clever swap management.  All I
> wanted so say and have documented is that users of swap.high should
> be aware of the fact that kernel is not able to do much to reduce the
> throttling. This is really different from memory.high where the kernel
> pro-actively tries to keep the memory usage below the watermark.  So a
> certain level of userspace cooperation is really needed unless you can
> tolerate a workload to be throttled to the end of times.

That's exactly what happens with memory.high. We've seen this. The
workload can go into a crawl and just stay there.

It's not unlike disabling the oom killer in cgroup1 without anybody
handling it. With memory.high, workloads *might* recover, but you have
to handle the ones that don't. Again, we inject sleeps into
memory.high when reclaim *is not* pushing back the workload anymore,
when reclaim is *failing*. The state isn't as stable as with
oom_control=0, but these indefinite hangs really happen in practice.
Realistically, you cannot use memory.high without an OOM manager.

The assymetry you see between memory.high and swap.high comes from the
page cache. memory.high can set a stop to the mindless expansion of
the file cache and remove *unused* cache pages from the application's
workingset. It cannot permanently remove used cache pages, they'll
just refault. So unused cache is where reclaim is useful.

Once the workload expands its set of *used* pages past memory.high, we
are talking about indefinite slowdowns / OOM situations. Because at
that point, reclaim cannot push the workload back and everything will
be okay: the pages it takes off mean refaults and continued reclaim,
i.e. throttling. You get slowed down either way, and whether you
reclaim or sleep() is - to the workload - an accounting difference.

Reclaim does NOT have the power to help the workload get better. It
can only do amputations to protect the rest of the system, but it
cannot reduce the number of pages the workload is trying to access.

The only sustainable way out of such a throttling situation is either
an OOM kill or the workload voluntarily shrinking and reducing the
total number of pages it uses. And doesn't that sound familiar? :-)

The actual, observable effects of memory.high and swap.high semantics
are much more similar than you think they are: When the workload's
true workingset (not throwaway cache) grows past capacity (memory or
swap), we slow down further expansion until it either changes its mind
and shrinks, or userspace OOM handling takes care of it.
