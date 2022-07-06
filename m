Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04656932F
	for <lists+cgroups@lfdr.de>; Wed,  6 Jul 2022 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiGFUUf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Jul 2022 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiGFUUf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Jul 2022 16:20:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3E71EEDC
        for <cgroups@vger.kernel.org>; Wed,  6 Jul 2022 13:20:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so12221305wmp.3
        for <cgroups@vger.kernel.org>; Wed, 06 Jul 2022 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zN05oMg9A5eMExVvuhLNwOOx17/+XHETTJXVnUtgWnA=;
        b=T6LSPKDIQlfkCde1dkkcPrJsSgkHNqUSJpiXKz/0vT1OX0fc18YBReSbC51uYTchM9
         /gQT9y8WsL8XZQPIyiTT2IU6yDNYMTHbdkW4gKnLR0WEBfSxw0mcKXEyrIVwnn6Bov8U
         IpqUrIX6zjWpKYr3tV3SGFvdrx2ZvGxsSPDVC7jOAeSy6CcZtY//HpliLN50I4rR+KpV
         xW/f9UEvQHE52zXqJGyZKMr7jZhWHUAs9uWPj51w0ZZFp8GYPDTG3N3b8v9O5wyBf2QR
         RD0vMPEqy0M85Z3kt0tDYjQre0PGe7u18n6V4HvBonyimUFpLgkq7R0p1ENxG7VI13To
         8fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN05oMg9A5eMExVvuhLNwOOx17/+XHETTJXVnUtgWnA=;
        b=SI1idm7KQaKYJMddhf9MKBVNYBZsqJ6rb0xG4UOEizsdzcsiB01QWNAG5Scey6bBqC
         s/ONGVJX9EqnBjkzVb8Jrw1Fwimj4NbmZTaSi2un0VsVwZM/qjw0H0RGYilbu3lWifNE
         JZtN9gTTc5oE5xHaYf3qngfpb1ckl/2C2m3d0j9vwXuoE3eap1tvy/HVOVWF4cKOIQmC
         bqKSmaZWMpQcDU2Yjkv6wf3Nen2cUjQRDq3QwY2GQIanRbctPkrKxPKrsJ2bLZK4cOar
         aYh3jdzb/+r+fIYPpHTFhgP8E+XAQKHvP6tI9OoHqYb71TncxWcrwt4GM/CULdEq5I/o
         JCXA==
X-Gm-Message-State: AJIora8P8U77KG+idAFuxMRxoRtEWMPFdYrDoMJWE7YxmUDAfDFlL8sC
        NpFwKePSXih25+S9PR1TYGNyI4LZODwBKUx/9YRnOg==
X-Google-Smtp-Source: AGRyM1uHudEeLtBIqriGM1ShXbu7TbT6VofLjKwqY3M+ttN0eioirnkaGM47kiambaWwwsJG2xJ5dDvyBP0v3Qw4IKA=
X-Received: by 2002:a05:600c:1e8e:b0:3a2:c1b4:922c with SMTP id
 be14-20020a05600c1e8e00b003a2c1b4922cmr417065wmb.24.1657138832379; Wed, 06
 Jul 2022 13:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220630083044.997474-1-yosryahmed@google.com> <20220701160947.e4902e5b0484ed084db5d41f@linux-foundation.org>
In-Reply-To: <20220701160947.e4902e5b0484ed084db5d41f@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 6 Jul 2022 13:19:56 -0700
Message-ID: <CAJD7tkZ7haRwRgE5723Sfqr4WzeoATy-3SUROgAZpinyxsMt2Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 1, 2022 at 4:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 30 Jun 2022 08:30:44 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > vmpressure is used in cgroup v1 to notify userspace of reclaim
> > efficiency events, and is also used in both cgroup v1 and v2 as a signal
> > for memory pressure for networking, see
> > mem_cgroup_under_socket_pressure().
> >
> > Proactive reclaim intends to probe memcgs for cold memory, without
> > affecting their performance. Hence, reclaim caused by writing to
> > memory.reclaim should not trigger vmpressure.
> >
> > ...
> >
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2319,6 +2319,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
> >                                 gfp_t gfp_mask)
> >  {
> >       unsigned long nr_reclaimed = 0;
> > +     unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
> >
> >       do {
> >               unsigned long pflags;
> > @@ -2331,7 +2332,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
> >
> >               psi_memstall_enter(&pflags);
> >               nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
> > -                                                          gfp_mask, true);
> > +                                                          gfp_mask,
> > +                                                          reclaim_options);
>
> It's a bit irksome to create all these unneeded local variables.  Why
> not simply add the constant arg to the try_to_free_mem_cgroup_pages()
> call?
>

I was trying to improve readability by trying to have consistent
reclaim_options local variable passed into
try_to_free_mem_cgroup_pages(), and also to avoid nested line-wrapping
in cases where reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
MEMCG_RECLAIM_PROACTIVE (like in memory_reclaim()). Since you found it
irksome, I obviously failed :)

Will remove the local variables where possible and send a v4. Thanks
for taking a look!

> >               psi_memstall_leave(&pflags);
> >       } while ((memcg = parent_mem_cgroup(memcg)) &&
> >                !mem_cgroup_is_root(memcg));
> > @@ -2576,7 +2578,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       struct page_counter *counter;
> >       unsigned long nr_reclaimed;
> >       bool passed_oom = false;
> > -     bool may_swap = true;
> > +     unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
> >       bool drained = false;
> >       unsigned long pflags;
> >
> > @@ -2593,7 +2595,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >               mem_over_limit = mem_cgroup_from_counter(counter, memory);
> >       } else {
> >               mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> > -             may_swap = false;
> > +             reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>
>         reclaim_options = 0
>
> would be clearer?
>

I feel like the current code is more clear to the reader and
future-proof. If we can't swap, we want to remove the MAY_SWAP flag,
we don't want to remove all existing flags. In this case it's the
same, but maybe in the future it won't be and someone will miss
updating this line. Anyway, I don't have a strong opinion, let me know
what you prefer for v4.
