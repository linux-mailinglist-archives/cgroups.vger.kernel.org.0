Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2625267E5
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382742AbiEMRIT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356224AbiEMRIS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:08:18 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476AE61294
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:08:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x22so7305695qto.2
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zXhkDIVf27CV50GWaqhnTSClMrVWORrrk1UTjwHnru8=;
        b=cnwlzxqBMjsJ+1WY7JYGk0zmaRis0uxKC7n7kcvotpz3nsqvchPQgSX6XYMUfhDe6C
         zQX+xYwhjdbi9MoF65ZpjqRRK7MJ0XKfxooT6ZqFqqo5RjIKjDa+M6SKyoLVYCac5pnq
         F/Ub9Xe3njx+6EalimZC+4nsWYG/wjM6ZV3DJI5rfIRoltmydpP3cLFDVWHPmw472OJh
         wjt3Bfjw86NWL6eyRuQrhiFfaHCEQEWvic5An3l6SAxg8tWA6OZwBS1CE8KjO+VtdCEW
         IPvb1TfV5UEO/ymbUOlWpPhhEU9+bxxgQMSRElxcmydKAxpio18y2YkuyD7/w+eB4Eo5
         aUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zXhkDIVf27CV50GWaqhnTSClMrVWORrrk1UTjwHnru8=;
        b=BYFucNqGrQf4ArFjKhhlX10RD0eKjMoZ7JwCvfdlEGDTWXLOtQMgXc3aOI3vUr6nLi
         ynbA4nJY19WCLKmMubV3bjerEbgStCotYmDsWPmsEfXvOJLhc7wqGYcxusoKDobU0cN5
         gOQSIn8B+50g+COUK7QYcFAVS5kW8eXA8lf6jCF+A6XnwbqZr/EowmFF+ECxXxCVE12/
         zAMmhIgGu0eD/J08WpLVPGqB1Yrno1qc5tT5A3SDg/KPdv059khkx74fhHO74nIs2qAs
         6xq/yqkzYBaafhym3aFlzauq0gMugNhLkN7/riGzHUUnsdeEqpaWIysHTK91WYk67/fd
         PiQQ==
X-Gm-Message-State: AOAM530slcHKJ4izQjjPfjrU7eYz6H7t4Dj2MG32xZJoIxger3rYs7x7
        uXzv45lKcesAqVdfBrelhNVVkw==
X-Google-Smtp-Source: ABdhPJwyv/gBNDnSk88os8Mohl8nxNU34Bx3dZyO4nXr5WiLiNrjoxWHwBHg3wmq2v0jQwwY7p/mpg==
X-Received: by 2002:a05:622a:104e:b0:2f3:f7a5:62e6 with SMTP id f14-20020a05622a104e00b002f3f7a562e6mr5423719qte.582.1652461695399;
        Fri, 13 May 2022 10:08:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id 143-20020a370995000000b0069fc13ce207sm1622277qkj.56.2022.05.13.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:08:14 -0700 (PDT)
Date:   Fri, 13 May 2022 13:08:13 -0400
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
Message-ID: <Yn6QfdouzkcrygTR@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <20220511173218.GB31592@blackbody.suse.cz>
 <YnwJUL90fuoHs3YW@cmpxchg.org>
 <20220513151426.GC16096@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513151426.GC16096@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Michal,

On Fri, May 13, 2022 at 05:14:26PM +0200, Michal Koutný wrote:
> On Wed, May 11, 2022 at 03:06:56PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Correct. After which the uncompressed page is reclaimed and uncharged.
> > So the zswapout process will reduce the charge bottom line.
> 
> A zswap object falling under memory.current was my first thinking, I was
> confused why it's exported as a separate counter memory.zswap.current
> (which IMO suggests disjoint counting) and it doubles a
> memory.stat:zswap entry.
> 
> Is the separate memory.zswap.current good for anything? (Except maybe
> avoiding global rstat flush on memory.stat read but that'd be an
> undesired precendent.)

Right, it's accounted as a subset rather than fully disjointed. But it
is a limitable counter of its own, so I exported it as such, with a
current and a max knob. This is comparable to the kmem counter in v1.

From an API POV it would be quite strange to have max for a counter
that has no current. Likewise it would be strange for a major memory
consumer to be missing from memory.stat.

> (Ad the eventually reduced footprint, the transitional excursion above
> memcg's (or ancestor's) limit should be limited by number of parallel
> reclaims running (each one at most a page, right?), so it doesn't seem
> necessary to tackle (now).)

Correct.

> > memory.zswap.* are there to configure zswap policy, within the
> > boundaries of available memory - it's by definition a subset.
> 
> I see how the .max works when equal to 0 or "max". The intermediate
> values are more difficult to reason about.

It needs to be configured to the workload's access frequency curve,
which can be done with trial-and-error (reasonable balance between
zswpins and pswpins) or in a more targeted manner using tools such as
page_idle, damon etc.

> Also, I can see that on the global level, zswap is configured relatively
> (/sys/module/zswap/parameters/max_pool_percent).
> You wrote that the actual configured value is workload specific, would
> it be simpler to have also relative zswap limit per memcg?
>
> (Relative wrt memory.max, it'd be rather just a convenience with this
> simple ratio, however, it'd correspond to the top level limit. OTOH, the
> relatives would have counter-intuitive hierarchical behavior. I don't
> mean this should be changed, rather wondering why this variant was
> chosen.)

A percentage isn't a bad way to pick a global default limit for a
kernel feature. But it would have been preferable if zswap had used
the percentage internally and made the knob based in bytes (like
min_free_kbytes for example).

Because for load tuning, bytes make much more sense. That's how you
measure the workingset, so a percentage is an awkward indirection. At
the cgroup level, it makes even less sense: all memcg tunables are in
bytes, it would be quite weird to introduce a "max" that is 0-100. Add
the confusion of how percentages would propagate down the hierarchy...

> > +bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > +{
> > +     struct mem_cgroup *memcg, *original_memcg;
> > +     bool ret = true;
> > +
> > +     original_memcg = get_mem_cgroup_from_objcg(objcg);
> > +     for (memcg = original_memcg; memcg != root_mem_cgroup;
> > +          memcg = parent_mem_cgroup(memcg)) {
> > +             unsigned long max = READ_ONCE(memcg->zswap_max);
> > +             unsigned long pages;
> > +
> > +             if (max == PAGE_COUNTER_MAX)
> > +                     continue;
> > +             if (max == 0) {
> > +                     ret = false;
> > +                     break;
> > +             }
> > +
> > +             cgroup_rstat_flush(memcg->css.cgroup);
> 
> Here, I think it'd be better not to bypass mem_cgroup_flush_stats() (the
> mechanism is approximate and you traverse all ancestors anyway), i.e.
> mem_cgroup_flush_stats() before the loop instead of this.

I don't traverse all ancestors, I bail on disabled groups and skip
unlimited ones. This saves a lot of flushes in practice right now: our
heaviest swapping cgroups have zswap disabled (max=0) because they're
lowpri and forced to disk. Likewise, the zswap users have their zswap
limit several levels down from the root, and I currently don't ever
flush the higher levels (max=PAGE_COUNTER_MAX).

Flushing unnecessary groups with a ratelimit doesn't sound like an
improvement to me.

Thanks
