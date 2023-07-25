Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CFB762327
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjGYUSQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGYUSP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 16:18:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25D1BE2
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 13:18:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403b3273074so1401851cf.1
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690316292; x=1690921092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GPWJuz8CAEYamZihAR0z0R2Kk0EYNWObLkeGgE8Dn0I=;
        b=4NE+YvybWo/g6VcPhh2fy5ZBIK2nXfKjbHIrelje0rqNy4LW0kZXKWbe7Y2Hh0eV/+
         +29ZM018tyUHpbJ4C4PuCBigcTNasPOzQHAnf04mtPxhxxg6kZ0gJiDnhivJEwankALK
         Uovby1CLPABNOOd4W4KiaeQFPHLCgi3Gpiw906LZwfCzGIdW1NApq0YZi+a20oDjVXjo
         e0L44dr1itRsFRxkSm9aFcTI6KXhxJgoxLav3p6wpGjpgrSRmF/B/8GWhfn5iB6LDyS0
         LE5qridIH3lSWZ8zIzT48HV1vyaKIVKi+EwTw1xThMN4P53tGMwX6Z1N7miPOfUZsntY
         M2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316292; x=1690921092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPWJuz8CAEYamZihAR0z0R2Kk0EYNWObLkeGgE8Dn0I=;
        b=ktrbiVn61uyRJbVS+lLlPCwY6kwIJiOzcTTUtNxwk0eq7NvOb4q3eLGcISWT6u3vFH
         JeY6eT/GValfEj7FJvqmbADHYMBEUb3ao+IJqK4+FG6YaBLSAmKv8BCpfZs7jxy3yK6F
         3Edx6E4pTNB/Ruo+jh7KtFVPfdk0+q8FHzPSip1b6WLnOXEfj4VYj9H1HvIV4kCijlvx
         bVVkt+FwDDWwZMmqYnB2mW32UPRUjJrCR2PYna09gk4C6RwCybiS6DnxHQKhFvgBNgsV
         ubKaQFa/ES+GvQ8SBR0UQaNpLhO9s8+jyKxAOcWLKQ8XVjzVR3hDFnbmxiCkc9syLK1I
         4npw==
X-Gm-Message-State: ABy/qLZCF6f+FoelXp5iL9Lr4fbwBReyLZ5I+JVRHM0ZMyo+UdHV+bwY
        3TWmAMBN1MATGvBkqaaGhV1GbzcScvL8f8tl2vMBCQ==
X-Google-Smtp-Source: APBJJlEonHvE95sEnIxdcddfXK3Ru/OM8KynANl6ZnU5hjPfscflgMaIlgpWNikeCdPCdTunJvmkKw==
X-Received: by 2002:ac8:4e85:0:b0:400:9847:59f6 with SMTP id 5-20020ac84e85000000b00400984759f6mr4023893qtp.13.1690316292303;
        Tue, 25 Jul 2023 13:18:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id d23-20020ac851d7000000b00403f4459e33sm4281077qtn.91.2023.07.25.13.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:18:11 -0700 (PDT)
Date:   Tue, 25 Jul 2023 16:18:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <20230725201811.GA1231514@cmpxchg.org>
References: <20230719174613.3062124-1-yosryahmed@google.com>
 <20230725140435.GB1146582@cmpxchg.org>
 <CAJD7tkaYHvaX6SL=A6TsCQHT+rOTp-WhOiQ1XSN+ywOVN=-QBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaYHvaX6SL=A6TsCQHT+rOTp-WhOiQ1XSN+ywOVN=-QBQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 25, 2023 at 12:24:19PM -0700, Yosry Ahmed wrote:
> On Tue, Jul 25, 2023 at 7:04 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > We used to maintain *all* stats in per-cpu counters at the local
> > level. memory.stat reads would have to iterate and aggregate the
> > entire subtree every time. This was obviously very costly, so we added
> > batched upward propagation during stat updates to simplify reads:
> >
> > commit 42a300353577ccc17ecc627b8570a89fa1678bec
> > Author: Johannes Weiner <hannes@cmpxchg.org>
> > Date:   Tue May 14 15:47:12 2019 -0700
> >
> >     mm: memcontrol: fix recursive statistics correctness & scalabilty
> >
> > However, that caused a regression in the stat write path, as the
> > upward propagation would bottleneck on the cachelines in the shared
> > parents. The fix for *that* re-introduced the per-cpu loops in the
> > local stat reads:
> >
> > commit 815744d75152078cde5391fc1e3c2d4424323fb6
> > Author: Johannes Weiner <hannes@cmpxchg.org>
> > Date:   Thu Jun 13 15:55:46 2019 -0700
> >
> >     mm: memcontrol: don't batch updates of local VM stats and events
> >
> > So I wouldn't say it's a regression from rstat. Except for that short
> > period between the two commits above, the read side for local stats
> > was always expensive.
> 
> I was comparing from an 4.15 kernel, so I assumed the major change was
> from rstat, but that was not accurate. Thanks for the history.
> 
> However, in that 4.15 kernel the local (non-hierarchical) stats were
> readily available without iterating percpu counters. There is a
> regression that was introduced somewhere.
> 
> Looking at the history you described, it seems like up until
> 815744d75152 we used to maintain "local" (aka non-hierarchical)
> counters, so reading local stats was reading one counter, and starting
> 815744d75152 we started having to loop percpu counters for that.
> 
> So it is not a regression of rstat, but seemingly it is a regression
> of 815744d75152. Is my understanding incorrect?

Yes, it actually goes back further. Bear with me.

For the longest time, it used to be local per-cpu counters. Every
memory.stat read had to do nr_memcg * nr_cpu aggregation. You can
imagine that this didn't scale in production.

We added local atomics and turned the per-cpu counters into buffers:

commit a983b5ebee57209c99f68c8327072f25e0e6e3da
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed Jan 31 16:16:45 2018 -0800

    mm: memcontrol: fix excessive complexity in memory.stat reporting

Local counts became a simple atomic_read(), but the hierarchy counts
would still have to aggregate nr_memcg counters.

That was of course still too much read-side complexity, so we switched
to batched upward propagation during the stat updates:

commit 42a300353577ccc17ecc627b8570a89fa1678bec
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue May 14 15:47:12 2019 -0700

    mm: memcontrol: fix recursive statistics correctness & scalabilty

This gave us two atomics at each level: one for local and one for
hierarchical stats.

However, that went too far the other direction: too many counters
touched during stat updates, and we got a regression report over memcg
cacheline contention during MM workloads. Instead of backing out
42a300353 - since all the previous versions were terrible too - we
dropped write-side aggregation of *only* the local counters:

commit 815744d75152078cde5391fc1e3c2d4424323fb6
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu Jun 13 15:55:46 2019 -0700

    mm: memcontrol: don't batch updates of local VM stats and events

In effect, this kept all the stat optimizations for cgroup2 (which
doesn't have local counters), and reverted cgroup1 back to how it was
for the longest time: on-demand aggregated per-cpu counters.

For about a year, cgroup1 didn't have to per-cpu the local stats on
read. But for the recursive stats, it would either still have to do
subtree aggregation on read, or too much upward flushing on write.

So if I had to blame one commit for a cgroup1 regression, it would
probably be 815744d. But it's kind of a stretch to say that it worked
well before that commit.

For the changelog, maybe just say that there was a lot of back and
forth between read-side aggregation and write-side aggregation. Since
with rstat we now have efficient read-side aggregation, attempt a
conceptual revert of 815744d.

> > But I want to be clear: this isn't a regression fix. It's a new
> > performance optimization for the deprecated cgroup1 code. And it comes
> > at the cost of higher memory footprint for both cgroup1 AND cgroup2.
> 
> I still think it is, but I can easily be wrong. I am hoping that the
> memory footprint is not a problem. There are *roughly* 80 per-memcg
> stats/events (MEMCG_NR_STAT + NR_MEMCG_EVENTS) and 55 per-lruvec stats
> (NR_VM_NODE_STAT_ITEMS). For each stat there is an extra 8 bytes, so
> on a two-node machine that's  8 * (80 + 55 * 2) ~= 1.5 KiB per memcg.
> 
> Given that struct mem_cgroup is already large, and can easily be 100s
> of KiBs on a large machine with many cpus, I hope there won't be a
> noticeable regression.

Yes, the concern wasn't so much the memory consumption but the
cachelines touched during hot paths.

However, that was mostly because we either had a) write-side flushing,
which is extremely hot during MM stress, or b) read-side flushing with
huuuge cgroup subtrees due to zombie cgroups. A small cacheline
difference would be enormously amplified by these factors.

Rstat is very good at doing selective subtree flushing on reads, so
the big coefficients from a) and b) are no longer such a big concern.
A slightly bigger cache footprint is probably going to be okay.
