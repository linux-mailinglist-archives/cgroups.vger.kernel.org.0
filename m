Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D534168E0E2
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 20:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBGTJa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 14:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBGTJ3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 14:09:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644D12331E
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 11:09:27 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 5so8024924qtp.9
        for <cgroups@vger.kernel.org>; Tue, 07 Feb 2023 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHT39fVUOFivmWp0T2APCxSGcvkCC5wF/f/HBMo6Tws=;
        b=Vp05VAn6WPp0SmeMs6zBO1/zMqsCjxnlRpMUhGA4RfkU/2QVMx/BYcetk634lgBMzN
         vGz6qsKafYu7zUfeujZ3CIqZTXkTP6o0ij0PMX/IvndsILFd6gCgqw18boVzyjeQv16a
         IHK+fG9BfR2TVN78eQehT1uheb7Wt0mSJ52hL2fG9GJzUlDQmqlbJjAJC0F5RzcniEYa
         XEjJ2WA3Cv/0vvaPoyFCqgaA9JCIC5flfTf5cwM89obqinQOXV9beq/i14349me5r0UG
         uLnU8sc6RhBSHcQLRDB+EwLxUZqzOrcHe82azdOEo1M7P34MMzZybD8rV3arSC7NkQ2k
         nxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHT39fVUOFivmWp0T2APCxSGcvkCC5wF/f/HBMo6Tws=;
        b=eWQ1v/VZZ+Hf6AY1p2ZlSykVjYgWIR8bS/TCN8yMh8RVZByxR6TatdzjcBCGHAH2MY
         feowpFnEGU6YbAusSWyVFrVoZGBmon1z8EQqp+A4SlTb6yOQinCLHz7ib3obB5+ihNk8
         31l9FEE1ufxJun6386L2kXKmwJ/hGGTrYeSrtmeafCLP+KkEjVjTiTUu1pEXIcKfChhG
         KjWWE0yRpQtN8H98BQrXfQEyDuLABeOUILUXQMQx0JBaw1yUT2gBoRA+u52cpRTNzlOy
         +vf9tM3pN05v4B0SIkBIQoEkacfkNkZetSD9pJG7JZfUYlVEfQz8ochHTXIbSodLd77f
         KNBQ==
X-Gm-Message-State: AO0yUKVD4ad8XWzRB9shOXFZiriY6y8ZE+PgUACX4F2NjFTIBt8Xem94
        jIePepLHJYsFlq5ONBEx/QVB9Q==
X-Google-Smtp-Source: AK7set+I80oe4Te9IWaWr60Et6KkoZKBvtfpwbbD7emZupy7T1ZULkHsPTNzZZaZtz5wj39Guwoh+g==
X-Received: by 2002:ac8:5cd2:0:b0:3b6:30dd:d472 with SMTP id s18-20020ac85cd2000000b003b630ddd472mr7219677qta.44.1675796966427;
        Tue, 07 Feb 2023 11:09:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id dw27-20020a05620a601b00b00706c1f7a608sm10022286qkb.89.2023.02.07.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:09:26 -0800 (PST)
Date:   Tue, 7 Feb 2023 14:09:25 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <Y+Kh5atM0TQmkR+R@cmpxchg.org>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
 <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 10:30:40AM -0800, Yosry Ahmed wrote:
> On Thu, Feb 2, 2023 at 7:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Christian reports the following situation in a cgroup that doesn't
> > have memory.swap.max configured:
> >
> >   $ cat memory.swap.events
> >   high 0
> >   max 0
> >   fail 6218
> >
> > Upon closer examination, this is an ARM64 machine that doesn't support
> > swapping out THPs. In that case, the first get_swap_page() fails, and
> > the kernel falls back to splitting the THP and swapping the 4k
> > constituents one by one. /proc/vmstat confirms this with a high rate
> > of thp_swpout_fallback events.
> >
> > While the behavior can ultimately be explained, it's unexpected and
> > confusing. I see three choices how to address this:
> >
> > a) Specifically exlude THP fallbacks from being counted, as the
> >    failure is transient and the memory is ultimately swapped.
> >
> >    Arguably, though, the user would like to know if their cgroup's
> >    swap limit is causing high rates of THP splitting during swapout.
> 
> We have the option to add THP_SWPOUT_FALLBACK (and THP_SWPOUT for
> completeness) to memcg events for this if/when a use case arises,
> right?

Yes, we can add that to memory.stat.

> > b) Only count cgroup swap events when they are actually due to a
> >    cgroup's own limit. Exclude failures that are due to physical swap
> >    shortage or other system-level conditions (like !THP_SWAP). Also
> >    count them at the level where the limit is configured, which may be
> >    above the local cgroup that holds the page-to-be-swapped.
> >
> >    This is in line with how memory.swap.high, memory.high and
> >    memory.max events are counted.
> >
> >    However, it's a change in documented behavior.
> 
> This option makes sense to me, but I can't speak to the change of
> documented behavior. However, looking at the code, it seems like if we do this
> the "max" & "fail" counters become effectively the same. "fail" would
> not provide much value then.

Right.

> I wonder if it makes sense to have both, and clarify that "fail" -
> "max" would be non-limit based failures (e.g. ran out of swap space),
> or would this cause confusion as to whether those non-limit failures
> were transient (THP fallback) or eventual?

If we add the fallback events, the user can calculate it. I wouldn't
split the fail counter itself. There are too many reasons why swap can
fail, half of them implementation-defined (as in the ARM example).

So I think I'll send patches either way to:

1. Fix the hierarchical accounting of the events to make it consistent
   with other counters.

2. Add THP swap/fallback counts to memory.stat

We could consider excluding THP fallbacks from the fail count. But it
seems really wrong for the cgroup controller to start classifying
individual types of failures in the swap layer and make decisions on
how to report them to the user. Cgroups really shouldn't be in the
business of making up its own MM events. I should provide per-cgroup
accounting of native MM events. And nobody has felt the need to add
native swap failure counts yet.

So I'd argue we should either remove the swap fail count altogether
for all the reasons mentioned, or just leave it as is and as a
documented interface that is unfortunately out the door.

Thoughts?
