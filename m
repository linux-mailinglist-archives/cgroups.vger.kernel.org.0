Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419AE1DCF9C
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgEUOW4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgEUOWz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 10:22:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C5FC061A0E
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 07:22:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 190so7402081qki.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U/6NedCyVsI+0YkMzEAK7ggM0PF9cTiNN+iBTzo3mhQ=;
        b=HKlbWpODtHg46IMgN/NvH6FHVnVIIjO+J/a63pC9b5E8qEo5aU4nEbChPuBFMpCyzS
         TZdAmtPN3MdK2G+W0S4bW0S7kozkbXR16HNI+POPVjncQgo89V2PyXe0xb6R84F06zTl
         ESDfjA+WhdaK/1aDO72ui3jORP0g8vDjoyqESndrZ2THE81f5SjJFrMWqjRK5P/QagSN
         QH3prFs99TDjrdbJyhmuyEcnxysJl7MePDKj6S5KWxsr/66EnaT7ASNBv0te5t26Vrdy
         lQqjVxigICd6uukzUcO1FSOZVnOM5OJDDb8ZHaroStLqqWiSjIQbuZI25txwkGM+fdEv
         9+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/6NedCyVsI+0YkMzEAK7ggM0PF9cTiNN+iBTzo3mhQ=;
        b=mtIBxclwcQAHEgMZvHX/w9gcgLmPT+nu5D6m8LQE7Yk+qVBgTexAGo+Q1gd5i3VFc4
         pYBTeB5z6wycXRUCGAdD21WdM+skhtJbycM2vFCix931FUMGqMGkgpvC0FGBZukMoiDF
         EL9MACwYdXf73pmJDBAiVNA6kBJ2SDP5JKMTfRR9NrqZLFMARmtQT3AEYYvcvcPkedXY
         0kb1NNGkJgHlvfXKM2Vp9i5PAvfy8hCAbXD0GipUVxra0WTITAJVAZ6fLQ3fPPSO4i3U
         go69wLzaraJ2U5g/yW8zccjbH/qjSLS3b9mCJvkD/PXeffo9ufx+IqldABJiLf+fawgo
         fiHw==
X-Gm-Message-State: AOAM531NcVwzdUn61FsUOH9xqgdSDe9tbpPJNOvI5LcDWKygOwBCKkef
        /bAgC1+YOmnFL5Z2JN0pMFQoFA==
X-Google-Smtp-Source: ABdhPJzBJLW5orlVKn31d8v/EyCt2GNJvpjt/a5XjXH2j9VDLeyuEWfE7oHn19UMnae1EG4lJgOTkw==
X-Received: by 2002:a37:a753:: with SMTP id q80mr10383765qke.492.1590070974552;
        Thu, 21 May 2020 07:22:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id m13sm5851729qtm.12.2020.05.21.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:22:53 -0700 (PDT)
Date:   Thu, 21 May 2020 10:22:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521142231.GA812233@cmpxchg.org>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521135152.GA810429@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 21, 2020 at 09:51:55AM -0400, Johannes Weiner wrote:
> On Thu, May 21, 2020 at 09:32:45AM +0200, Michal Hocko wrote:
> > I wouldn't mind to loop over try_to_free_pages to meet the requested
> > memcg_nr_pages_over_high target.
> 
> Should we do the same for global reclaim? Move reclaim to userspace
> resume where there are no GFP_FS, GFP_NOWAIT etc. restrictions and
> then have everybody just reclaim exactly what they asked for, and punt
> interrupts / kthread allocations to a worker/kswapd?

Oof, typo: I meant limit reclaim by memory.max and
memory.limit_in_bytes. Not physical memory reclaim of course.

> > > > > > Also if the current high reclaim scaling is insufficient then we should
> > > > > > be handling that via memcg_nr_pages_over_high rather than effectivelly
> > > > > > unbound number of reclaim retries.
> > > > > 
> > > > > ???
> > > > 
> > > > I am not sure what you are asking here.
> > > 
> > > You expressed that some alternate solution B would be preferable,
> > > without any detail on why you think that is the case.
> > > 
> > > And it's certainly not obvious or self-explanatory - in particular
> > > because Chris's proposal *is* obvious and self-explanatory, given how
> > > everybody else is already doing loops around page reclaim.
> > 
> > Sorry, I could have been less cryptic. I hope the above and my response
> > to Chris goes into more details why I do not like this proposal and what
> > is the alternative. But let me summarize. I propose to use memcg_nr_pages_over_high
> > target. If the current calculation of the target is unsufficient - e.g.
> > in situations where the high limit excess is very large then this should
> > be reflected in memcg_nr_pages_over_high.
> > 
> > Is it more clear?
> 
> Well you haven't made a good argument why memory.high is actually
> different than any other form of reclaim, and why it should be the
> only implementation of page reclaim that has special-cased handling
> for the inherent "unfairness" or rather raciness of that operation.
> 
> You cut these lines from the quote:
> 
>   Under pressure, page reclaim can struggle to satisfy the reclaim
>   goal and may return with less pages reclaimed than asked to.
> 
>   Under concurrency, a parallel allocation can invalidate the reclaim
>   progress made by a thread.
> 
> Even if we *could* invest more into trying to avoid any unfairness,
> you haven't made a point why we actually should do that here
> specifically, yet not everywhere else.
> 
> (And people have tried to do it for global reclaim[1], but clearly
> this isn't a meaningful problem in practice.)
> 
> I have a good reason why we shouldn't: because it's special casing
> memory.high from other forms of reclaim, and that is a maintainability
> problem. We've recently been discussing ways to make the memory.high
> implementation stand out less, not make it stand out even more. There
> is no solid reason it should be different from memory.max reclaim,
> except that it should sleep instead of invoke OOM at the end. It's
> already a mess we're trying to get on top of and straighten out, and
> you're proposing to add more kinks that will make this work harder.
> 
> I have to admit, I'm baffled by this conversation. I consider this a
> fairly obvious, idiomatic change, and I cannot relate to the
> objections or counter-proposals in the slightest.
> 
> [1] http://lkml.iu.edu/hypermail//linux/kernel/0810.0/0169.html
