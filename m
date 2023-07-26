Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401F7628A6
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGZCP7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 22:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGZCP6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 22:15:58 -0400
Received: from out-56.mta0.migadu.com (out-56.mta0.migadu.com [IPv6:2001:41d0:1004:224b::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D11BD6
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 19:15:56 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:15:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690337752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkLUCGJT74cllQvTQ6MTx9QgnJE9Fo6dHQUygyCQSWc=;
        b=P59UCGFim3QDtZSMOt0VwRb3ocDo8l1wi2zSA6eSN/BqU/YIRayerwirvZbuLcLx1R37DN
        YdCcgNxDBq30Q2BEtIH4BuGRjBqYNWesRuyquAwbIs9iakR3r3SbyA4SCffn+s846tmvRs
        qjD5LYy9+6Me2P46VLNrPfjgPrgZvp8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <ZMCBzUH7qIdc3Y2X@P9FQF9L96D>
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726002904.655377-2-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 26, 2023 at 12:29:04AM +0000, Yosry Ahmed wrote:
> Currently, memcg uses rstat to maintain hierarchical stats. Counters are
> maintained for hierarchical stats at each memcg. Rstat tracks which
> cgroups have updates on which cpus to keep those counters fresh on the
> read-side.
> 
> For non-hierarchical stats, we do not maintain counters. Instead, the
                                                global?
> percpu counters for a given stat need to be summed to get the
> non-hierarchical stat value. The original implementation did the same.
> At some point before rstat, non-hierarchical counters were introduced by
> commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> memory.stat reporting"). However, those counters were updated on the
> performance critical write-side, which caused regressions, so they were
> later removed by commit 815744d75152 ("mm: memcontrol: don't batch
> updates of local VM stats and events"). See [1] for more detailed
> history.
> 
> Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a
> half) enjoyed cheap reads of non-hierarchical stats, specifically on
> cgroup v1. When moving to more recent kernels, a performance regression
> for reading non-hierarchical stats is observed.
> 
> Now that we have rstat, we know exactly which percpu counters have
> updates for each stat. We can maintain non-hierarchical counters again,
> making reads much more efficient, without affecting the performance
> critical write-side. Hence, add non-hierarchical (i.e local) counters
> for the stats, and extend rstat flushing to keep those up-to-date.
> 
> A caveat is that we now a stats flush before reading
                         need?
> local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> or memcg_events_local(), where we previously only needed a flush to
> read hierarchical stats. Most contexts reading non-hierarchical stats
> are already doing a flush, add a flush to the only missing context in
> count_shadow_nodes().
> 
> With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> machine with 256 cpus on cgroup v1:
>  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
>  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
>  real	 0m0.125s
>  user	 0m0.005s
>  sys	 0m0.120s
> 
> After:
>  real	 0m0.032s
>  user	 0m0.005s
>  sys	 0m0.027s
> 
> [1]https://lore.kernel.org/lkml/20230725201811.GA1231514@cmpxchg.org/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
