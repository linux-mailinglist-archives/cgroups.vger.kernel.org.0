Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37975290FA
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiEPUIx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351246AbiEPUCI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 16:02:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7EE403EA
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 13:01:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id s5so1037008qvo.12
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZkVPoKiRyxZYCKFlzur2Du6imn3HJo9Ujd09H1rvEZI=;
        b=vZTbPP2pWMooTwGBeObJt4v/OCxVqBMUtRl4gbZrrAlmglNAeFTKpKTvI8pBBQYN9c
         iqwo0hsTQ6M2urOAjmu0s5oyECHNDKV4KnVlwY6nOMTEdrAJ9NqVkrSARYKkYn/wwoFO
         m+zVXG2ALswGiW+CS9Jh21tKovWXrZW+YRHz4yMcE/Ggs4ybkWkJUMkfbsZ5s90LQn77
         e2o98eTC86/Ft/yL5wJbt69b21smwsBJNqGNjMH+Zm1QxWMvkFIlIIgSML55tuD2zjKt
         83b5fFamCTAEiXM24TcMDjWVlr3rXOlwoXH0BafPlBO8IAUs6LbNf+qDt89E1wHEDtRT
         pLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZkVPoKiRyxZYCKFlzur2Du6imn3HJo9Ujd09H1rvEZI=;
        b=FnQA32O0U2axb5pdJcCHfn5ILKL3zPe+6aacB91Dj4Xa6ThwcMkqT7zC0s37fYnzjA
         YYyZSxPi5X8MyuOzX5nciTJsNIYrbEwJYAfrp98WzogHiZaCBUTDeaIVLjgfDQnadlrb
         htptZK3wRbr7P5y0jatNb2L85R3f7LiqPMYc+xF0PMtD7ucsdizpZ9meF76Q6gg7n+hj
         2MpP0EUPAD5SG3NSvEUiXPxeJMfYBmJreGtAAHbneSf26u9oGgmcAifKnltd/HJP+lxV
         j/VHQ7Bb4BepW6YAh+5rODqM5D8ZGD2A7zlTAdaiy6ooxNghJ/EJOISQlRaDOfiFlxdn
         1hQA==
X-Gm-Message-State: AOAM532gTkVMLEFFWZ/SMx6p+31S2gIkqQLKmj822zuHeX9/XTer1HCw
        IWIwCbqhbEsw9ftDxpAc9jgElA==
X-Google-Smtp-Source: ABdhPJzSaErJBPK04dhEePAY++sXZsgqj/slLG7+mogeCU5HoTJdC06dGiGJMgPvAoEOV/vqfzjCNg==
X-Received: by 2002:a05:6214:e6b:b0:45b:474:1035 with SMTP id jz11-20020a0562140e6b00b0045b04741035mr17194607qvb.39.1652731267078;
        Mon, 16 May 2022 13:01:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:fcf2])
        by smtp.gmail.com with ESMTPSA id o7-20020a37be07000000b0069fc13ce203sm6698397qkf.52.2022.05.16.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:01:06 -0700 (PDT)
Date:   Mon, 16 May 2022 16:01:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <YoKtgaxOAMBVKiCf@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <20220511173218.GB31592@blackbody.suse.cz>
 <YnwJUL90fuoHs3YW@cmpxchg.org>
 <20220513151426.GC16096@blackbody.suse.cz>
 <Yn6QfdouzkcrygTR@cmpxchg.org>
 <20220516143459.GA17557@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516143459.GA17557@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Michal,

On Mon, May 16, 2022 at 04:34:59PM +0200, Michal Koutný wrote:
> On Fri, May 13, 2022 at 01:08:13PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Right, it's accounted as a subset rather than fully disjointed. But it
> > is a limitable counter of its own, so I exported it as such, with a
> > current and a max knob. This is comparable to the kmem counter in v1.
> 
> That counter and limit didn't turn out well. I liked the analogy to
> writeback (and dirty limit) better.

Right, I was only talking about the design decision to add a usage
knob alongside the limit. The counter failed for a different reason.

> > From an API POV it would be quite strange to have max for a counter
> > that has no current. Likewise it would be strange for a major memory
> > consumer to be missing from memory.stat.
> 
> My understanding would be to have all memory.stat entries as you
> propose, no extra .current counter and the .max knob for zswap
> configuration.

There is a longer-term advantage of sticking to the usage+limit pair
precedent. Even though the usage knob happens to correspond to a
memory.stat item in this case, we had also discussed the possibility
of breaking out a "Compressed" item in memory.stat instead, of which
zswap would only be a subset. It didn't pan out this way this time -
for unrelated reasons. But it's conceivable this will happen in
another scenario down the line, and then you'd need a separate usage
knob anyway. It's a good idea to stay consistent.

There is also an immediate practical advantage. zswap is limitable, so
an auto-tuning service might want to monitor its usage at a higher
frequency, with a higher precision, and with a higher urgency than
memory stats are ususally logged. A dedicated usage knob allows doing
that. memory.stat does not: it is a bigger file that needs to be
searched with a string parser for every sample; it's flushed lazily,
so it can be less precise than desired; yet, when it does flush, it
flushes the entire tree rather than just the target group, making it
more expensive an erratic than desired as well.

> > It needs to be configured to the workload's access frequency curve,
> > which can be done with trial-and-error (reasonable balance between
> > zswpins and pswpins) or in a more targeted manner using tools such as
> > page_idle, damon etc.
> > [...]
> > Because for load tuning, bytes make much more sense. That's how you
> > measure the workingset, so a percentage is an awkward indirection. At
> > the cgroup level, it makes even less sense: all memcg tunables are in
> > bytes, it would be quite weird to introduce a "max" that is 0-100. Add
> > the confusion of how percentages would propagate down the hierarchy...
> 
> Thanks for the explanation. I guess there's no simple tranformation of
> in-kernel available information that'd allow a more semantic
> configuration of this value. The rather crude absolute value requires
> (but also simply allows) some calibration or responsive tuning.

Right.

If you think about it, the same can be said about the memory limit
itself. It's a crude, absolute number the kernel asks of you. Yet the
optimal setting depends on the workload's ever-changing access
frequency histogram, the speed of the storage backend for paging and
swapping, and the workload's tolerances for paging latencies.

Hopefully one day we'll be able to set a pressure/latency threshold on
the cgroup, and have the kernel optimally distribute the workingset
across RAM, zswap, second-tier memory, and storage - preferring the
cheapest and slowest possible backing for every page while meeting the
SLA. The proactive reclaim and memory offloading work is pursuing this.

For now, we need the interface that allows tuning and exploring from
userspace. When there is something that's ready for a general purpose
OS kernel, those absolute knobs won't get in the way - just like
memory.max doesn't get in the way of proactive reclaim today.

Anyway, I'm just outlining where I'm coming from with this. It looks
like we agree on the end result.

> > Flushing unnecessary groups with a ratelimit doesn't sound like an
> > improvement to me.
> 
> Then I'm only concerned about a situation when there's a single deep
> memcg that undergoes both workingset_refault() and zswap querying.
> The latter (bare call to cgroup_rstat_flush()) won't reset
> stats_flush_threshold, so the former (or the async flush more likely)
> would attempt a flush too. The flush work (on the leaf memcg) would be
> done twice even though it may be within the tolerance of cumulated
> error the second time.
> 
> This is a thing that might require attention in the future (depending on
> some data how it actually performs). I see how the current approach is
> justified.

Yes, we can optimize it should the need arise. So far it's been fine.

Thanks for your thoughts, Michal.
