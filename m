Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B65265C4
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381775AbiEMPOm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381760AbiEMPOb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:14:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A753A6F;
        Fri, 13 May 2022 08:14:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 509C91F385;
        Fri, 13 May 2022 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652454868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyTU5ErQmQ0NdqPj7xjplU/5OPBXUdJ8mJObumbOOaE=;
        b=A6yJ4U9KldExWhFuocfsPhkK8P9HeRgSb8fmB2eY9z7Sp7ko3TqOhgQnKM+TJjvYGD/z3+
        2Je6BK2N+LYUAG7wici8UElgk0u8iqwoqsJtw8+x2adxjqmD0U06Eg+UegyuFNXj9dyMKC
        etWrpypIyhItSwwSEGkVmpbAI6xPQ5M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13F5513446;
        Fri, 13 May 2022 15:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OAzmA9R1fmLxHwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 13 May 2022 15:14:28 +0000
Date:   Fri, 13 May 2022 17:14:26 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <20220513151426.GC16096@blackbody.suse.cz>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <20220511173218.GB31592@blackbody.suse.cz>
 <YnwJUL90fuoHs3YW@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnwJUL90fuoHs3YW@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 03:06:56PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Correct. After which the uncompressed page is reclaimed and uncharged.
> So the zswapout process will reduce the charge bottom line.

A zswap object falling under memory.current was my first thinking, I was
confused why it's exported as a separate counter memory.zswap.current
(which IMO suggests disjoint counting) and it doubles a
memory.stat:zswap entry.

Is the separate memory.zswap.current good for anything? (Except maybe
avoiding global rstat flush on memory.stat read but that'd be an
undesired precendent.)

(Ad the eventually reduced footprint, the transitional excursion above
memcg's (or ancestor's) limit should be limited by number of parallel
reclaims running (each one at most a page, right?), so it doesn't seem
necessary to tackle (now).)

> memory.zswap.* are there to configure zswap policy, within the
> boundaries of available memory - it's by definition a subset.

I see how the .max works when equal to 0 or "max". The intermediate
values are more difficult to reason about.
Also, I can see that on the global level, zswap is configured relatively
(/sys/module/zswap/parameters/max_pool_percent).
You wrote that the actual configured value is workload specific, would
it be simpler to have also relative zswap limit per memcg?

(Relative wrt memory.max, it'd be rather just a convenience with this
simple ratio, however, it'd correspond to the top level limit. OTOH, the
relatives would have counter-intuitive hierarchical behavior. I don't
mean this should be changed, rather wondering why this variant was
chosen.)


> +bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> +{
> +     struct mem_cgroup *memcg, *original_memcg;
> +     bool ret = true;
> +
> +     original_memcg = get_mem_cgroup_from_objcg(objcg);
> +     for (memcg = original_memcg; memcg != root_mem_cgroup;
> +          memcg = parent_mem_cgroup(memcg)) {
> +             unsigned long max = READ_ONCE(memcg->zswap_max);
> +             unsigned long pages;
> +
> +             if (max == PAGE_COUNTER_MAX)
> +                     continue;
> +             if (max == 0) {
> +                     ret = false;
> +                     break;
> +             }
> +
> +             cgroup_rstat_flush(memcg->css.cgroup);

Here, I think it'd be better not to bypass mem_cgroup_flush_stats() (the
mechanism is approximate and you traverse all ancestors anyway), i.e.
mem_cgroup_flush_stats() before the loop instead of this.

Thanks,
Michal

