Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B451BDFEA
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD2ODe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgD2ODe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 10:03:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7429C03C1AD
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 07:03:33 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t8so1163919qvw.5
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3AIdfHtqoNsFBzshUFCQLbur342SiMxvBTxBWk02TNs=;
        b=Z29GhzAshaBzwKo0DDBUn+TJtaUBjsuW0107/RWcL4BRG19OLBEyxAdycULUE+WSKj
         cBaOxrI9tgM4HLh4Oap3ItOhRh6fOO8ghJ5gBawufm1ciYNynW0iSO3Hojo2mnCLaylF
         YEwECLyVFEiKYavaRD/vtGTKNyJIIP6DtfEnTNDKrCj5cndhve6ozi8Yq1Gymk7qKzkh
         9nCRNm0q5RFhvgVCbRfVwM9EmcIMYYD90xCU7ObMq59Lxx2JBz4EH3Tjno0hxptvKui7
         SDCZE2HvLnOd61BAFSR0x4m/UaXIlcc5dFs0ow+NXWUAkHs/jxVwux4H/L1zjDSWJ1sN
         w+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AIdfHtqoNsFBzshUFCQLbur342SiMxvBTxBWk02TNs=;
        b=RZRo5v8NKsGvM3szqNGV5Nn7gi+6mzM3xHa8AB9KeybFuEt6dZKuBkyl6fEAnXGgmH
         Z6tzfjf1cqe+OKpZT99r4YdCskF2vKXTwvC35XkcmjGMaJOPt5TF0ypYgxHijFZCbGbI
         lQGxxx+ujL30vmE2Udbn0PLpzchvwp47JJ+QQ9E8e/LW6Z5fmm7D3i96UeK2GPfOLivs
         cE7dxhRA23m8hg/1NatmNFokQASkPevaWAl5QKMufzS1l3v8QYDJ4fYeEeNZyY7JUwXq
         E3j6OQjeoxw+MQJH1i/1FxKddr5M/vQ56tgnorGspcGDhMSq4jOMwRhNau3WnjyK8Zrk
         97lA==
X-Gm-Message-State: AGi0PubQgDTh3pD5XHUFQex5GB5bvS57sOP8tC+wZ91ug3M4JPG76z/j
        C7drd4VwK4ScNBRAE8aL5b6qsw==
X-Google-Smtp-Source: APiQypKIOK7TwOIDU3P3paLnhDob8aiAysD4JgM9FFj9WqckQNqOh6Omw6e6OnHvCun/RfQQUaRfag==
X-Received: by 2002:a0c:c28b:: with SMTP id b11mr32350633qvi.112.1588169012888;
        Wed, 29 Apr 2020 07:03:32 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x8sm15933232qti.51.2020.04.29.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:32 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:03:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200429140330.GA5054@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429101510.GA28637@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 29, 2020 at 12:15:10PM +0200, Michal Hocko wrote:
> On Tue 28-04-20 19:26:47, Chris Down wrote:
> > From: Yafang Shao <laoar.shao@gmail.com>
> > 
> > A cgroup can have both memory protection and a memory limit to isolate
> > it from its siblings in both directions - for example, to prevent it
> > from being shrunk below 2G under high pressure from outside, but also
> > from growing beyond 4G under low pressure.
> > 
> > Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> > implemented proportional scan pressure so that multiple siblings in
> > excess of their protection settings don't get reclaimed equally but
> > instead in accordance to their unprotected portion.
> > 
> > During limit reclaim, this proportionality shouldn't apply of course:
> > there is no competition, all pressure is from within the cgroup and
> > should be applied as such. Reclaim should operate at full efficiency.
> > 
> > However, mem_cgroup_protected() never expected anybody to look at the
> > effective protection values when it indicated that the cgroup is above
> > its protection. As a result, a query during limit reclaim may return
> > stale protection values that were calculated by a previous reclaim cycle
> > in which the cgroup did have siblings.
> > 
> > When this happens, reclaim is unnecessarily hesitant and potentially
> > slow to meet the desired limit. In theory this could lead to premature
> > OOM kills, although it's not obvious this has occurred in practice.
> 
> Thanks this describes the underlying problem. I would be also explicit
> that the issue should be visible only on tail memcgs which have both
> max/high and protection configured and the effect depends on the
> difference between the two (the smaller it is the largrger the effect).
> 
> There is no mention about the fix. The patch resets effective values for
> the reclaim root and I've had some concerns about that
> http://lkml.kernel.org/r/20200424162103.GK11591@dhcp22.suse.cz.
> Johannes has argued that other races are possible and I didn't get to
> think about it thoroughly. But this patch is introducing a new
> possibility of breaking protection. If we want to have a quick and
> simple fix that would be easier to backport to older kernels then I
> would feel much better if we simply workedaround the problem as
> suggested earlier http://lkml.kernel.org/r/20200423061629.24185-1-laoar.shao@gmail.com
> We can rework the effective values calculation to be more robust against
> races on top of that because this is likely a more tricky thing to do.

Well, can you please *do* think more thoroughly about what I wrote,
instead of pushing for an alternative patch on gut feeling alone?

Especially when you imply that this should be a stable patch.

Not only does your alternative patch not protect against the race you
are worried about, the race itself doesn't matter. Racing reclaimers
will write their competing views of the world into the shared state on
all other levels anyway.

And that's okay. If the configuration and memory usage is such that
there is at least one reclaimer that scans without any protection
(like a limit reclaimer), it's not a problem when a second reclaimer
that meant to do protected global reclaim will also do one iteration
without protection. It's no different than if a second thread had
entered limit reclaim through another internal allocation.

There is no semantical violation with the race in your patch or the
race in this patch. Any effective protection that becomes visible is
1) permitted by the configuration, but 2) also triggered *right now*
by an acute need to reclaim memory with these parameters.

The *right now* part is important. That's what's broken before either
patch, and that's what we're fixing: to see really, really *old* stale
that might not be representative of the config semantics anymore.

Since you haven't linked to my email, here is my counter argument to
the alternative patch "fixing" this race somehow.

A reclaim:

  root
     `- A (low=2G, max=3G -> elow=0)
        `- A1 (low=0G -> elow=0)

Global reclaim:

  root
     `- A (low=2G, max=3G -> elow=2G)
        `- A1 (low=0G -> elow=2G)

During global reclaim, A1 is supposed to have 2G effective low
protection. If A limit reclaim races, it can set A1's elow to
0. Global reclaim will now query mem_cgroup_protection(root, A1), the
root == memcg check you insist we add will fail and it'll reclaim A1
without protection.

The alternative patch is nothing except slightly worse code.
