Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E273A421646
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhJDSXK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhJDSXK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 14:23:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EAC061745;
        Mon,  4 Oct 2021 11:21:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so553372pjb.1;
        Mon, 04 Oct 2021 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2VzbwvFNZu13mZZTP9Y+UENOKafpTTohfJbme2kfEgk=;
        b=Nw7b1+oJPMMyD4gdc1HlxMBGwqpg1a0O8BDrm4iOUJ1zhJvddhzC1gjb3wgFj/rSLo
         dMrdraj87cftAtFT19pLNJJltx3epgPhpDJc/ESkdDN+jKkXbdMEh9mCQe9/39u7CcNQ
         3SSzmFkAPeLC/QXWVH5ZO7iMK2XECt1jqDu3PmYLY5dEHrM8RCLm+1YMwKQmey12c9PG
         IOQ9bU2N14yMYDeg+dmB9FwsLRtz0Q6i6sKT/Se/I6tIjbqgS0mWaIPQZLrIMTDbhraG
         hjRvxhRmhu9UaSENJr1e9ei59xgDzy8PQZazWr1/FOuQiu3ofrRr0tpvmugBV9ezplmv
         0UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2VzbwvFNZu13mZZTP9Y+UENOKafpTTohfJbme2kfEgk=;
        b=xaeq/FabWzu2ihxGpEPKeNdYQl8Z3lX4MtvsLtbPhF7Ug+uy0E3fCA21sqW9IcerRR
         q3Mi3Id2gCyc8N1+6CYA+kyNDXn8+pMYJamtiheMqE6s7Us7DukTRsBaAX97TDL/q3w7
         tI6bITWUOLHtLZNQ0z0xP9bIQRZpCasiHs/Y9xlMO3RvfOhYr8LYmX36b/zvk9wODR3/
         FwqrzRCRsf6uCg+A8gbLRBwRw4rIXuUcMKZrtCUP4FECEhL7MTcntwjJ5yqIVZ3rv579
         QyVnzL7iBXyLdtHg2tP8VHDJfvoYaRqNea/9zQ9+HiX07OyhqI0o6vUbXGeloCJMEZsH
         53Jw==
X-Gm-Message-State: AOAM533IuG1y3udRpnMvipWKx68y6ZXhLH0DUBb/m0SeTfWD2Kz2Xjqj
        g74V+DOEj2Evmy/V6e+eRLU=
X-Google-Smtp-Source: ABdhPJwFXWCd7ePQrHU47XKSgcqWmQOZ8h/2VcZ1PGqhPhoqBHDVAnHHViCzFTfnDJ6WbxpAQZxitQ==
X-Received: by 2002:a17:902:7611:b0:13e:ce2e:1f85 with SMTP id k17-20020a170902761100b0013ece2e1f85mr1064621pll.22.1633371680343;
        Mon, 04 Oct 2021 11:21:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 23sm14605421pgk.89.2021.10.04.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:21:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 08:21:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
Message-ID: <YVtGHoboSix3rexr@slm.duckdns.org>
References: <20210929235936.2859271-1-shakeelb@google.com>
 <YVszNI97NAAYpHpm@slm.duckdns.org>
 <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
 <YVs9eJnNJYwF/3f3@slm.duckdns.org>
 <CALvZod47r=9j_MhZz9ngWv_JE4oqF1CrXTOQ2GpSSNFftZAsVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod47r=9j_MhZz9ngWv_JE4oqF1CrXTOQ2GpSSNFftZAsVA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 04, 2021 at 11:07:45AM -0700, Shakeel Butt wrote:
> > Sorry for being so slow but can you point to the exact call path which gets
> > slowed down so significantly?
> 
> This is the mem_cgroup_flush_stats() inside workingset_refault() in
> mm/workingset.c.

I see. Was looking at a repo which was too old.

> > I'm mostly wondering whether we need some sort
> > of time-batched flushes because even with lock avoidance the flush path
> > really isn't great when called frequently. We can mitigate it further if
> > necessary - e.g. by adding an "updated" bitmap so that the flusher doesn't
> > have to go around touching the cachelines for all the cpus.
> 
> For the memcg stats, I already proposed a batched flush at [1].
> 
> I actually did perform the same experiment with the proposed patch
> along with [1] and it improves around just 1%. More specifically for
> memcg stats [1] is good enough but that is memcg specific and this
> patch has merits on its own.

So, the current rstat code doesn't pay a lot of attention to optimizing the
read path - the reasoning being that as long as we avoid O(nr_cgroups), the
flush operations aren't frequent enough to be problematic. The use in
refault path seems to change that balance and it likely is worthwhile to
update rstat accordingly. As I mentioned above, a next step could be adding
a cpumask which tracks cpus with populated updated list, which should add
pretty small cost to the writers while making frequent flushes significantly
cheaper.

What do you think about that approach? While the proposed patch looks fine,
it kinda bothers me that it's a very partial optimization - ie. if flush
frequency is high enough for this to matter, that for_each_possible_cpu()
scanning loop really isn't appropriate.

Thanks.

-- 
tejun
