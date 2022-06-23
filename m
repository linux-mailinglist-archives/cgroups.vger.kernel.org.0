Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D8556F5E
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 02:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbiFWAZf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAZe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 20:25:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49562657C
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 17:25:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r7-20020a1c4407000000b003a02cc49774so569051wma.1
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 17:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGc760CUzqfAXiBkGN4MiPEho4dLgNkLq+hTF2lwnHA=;
        b=gQuswyeZ2unJsJtQNdmDZ13sMjSqQo1RWSPOiC/NK2N6itjLR5J+1pYFpBUaOk6nGg
         z+eBGxEETPfbh6+Q/63zwgCuErxr1n5GlLO2m24RI9cwyao/BcBdP5QxFZb4hbKT5u9S
         5ZWz9nJuRU6vErz7/qraQ8ex4nAKDzu/I6waUlkUe/Dymw127vM04k6MDKa8JQQVJNRp
         MEM20FVHD7SEBwGul5ytxZpGM2ExN8pkl9+MfLjZOGxUCQK6nCy5A5DDHQGfFFkEUd7s
         twcRMDz8TGTNcaoADcabM6Q7zjLE+6dLSgcXdTT+XOe04JLMDh6byVctoHADa4HYUVNS
         GfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGc760CUzqfAXiBkGN4MiPEho4dLgNkLq+hTF2lwnHA=;
        b=DOiRLmP6vCJFg3HnaDfz12pvg2F/0q68m54cz0mla8F0rhIYexA6OGLMA4UFR/NtFz
         tGWiDGGabJLmcnGTIwR30uprsbBoAW0tw5dwiYwEkLu29P8F74qt4Gf4K/3V7T1tDUWT
         PQ1v/P33g0DXgzH2j+EfkIVwMBgC8yqHZPN5zybM8FIcFbHs/dcUADMp+r90iSLYm+lo
         VfVWNVqBt3dbKg0J0xZy7CSBeI4z34aCOuF2EuCR8tYSeDmc0xAxaclygeeuJq1dSKXZ
         de3JYXrOQ5S7tIZJyG+p8Frs8ABxsPg5Ctj27CDp7c5dTIIoGAXVYGyiitxessPa2l7L
         YfHA==
X-Gm-Message-State: AJIora+CJ5ogwRJRpSUj6fZADGMJqS7LRE+RXJ3vma1e0eyio0dNsr4m
        ujK4Peqh1Li6zsjS/JuKUvNJpfqDw279rX2ZPaMiXQ==
X-Google-Smtp-Source: AGRyM1uhhmG98sWEyp+Tt/TaRm3zA+KfVhcjnxuRunOrr071IyYR489kEobIjYMc0JTmKOgMrzlUlKJIg0kh6lv6qh0=
X-Received: by 2002:a05:600c:34cc:b0:39c:832c:bd92 with SMTP id
 d12-20020a05600c34cc00b0039c832cbd92mr991182wmq.24.1655943931730; Wed, 22 Jun
 2022 17:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com> <20220622171624.fc7de8d0ab18a5cf663f8ab8@linux-foundation.org>
In-Reply-To: <20220622171624.fc7de8d0ab18a5cf663f8ab8@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Jun 2022 17:24:55 -0700
Message-ID: <CAJD7tkag2sj86FXnMb+v4GhDJWOZ_tNpMMCde8faEgqdQ9=uEg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
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

On Wed, Jun 22, 2022 at 5:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 23 Jun 2022 00:05:30 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > as memory pressure") made sure that memory reclaim that is induced by
> > userspace (limit-setting, proactive reclaim, ..) is not counted as
> > memory pressure for the purposes of psi.
> >
> > Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
> > from try_charge() and reclaim_high() wrap the call to
> > try_to_free_mem_cgroup_pages() with psi handlers.
> >
> > However, vmpressure is still counted in these cases where reclaim is
> > directly induced by userspace. This patch makes sure vmpressure is not
> > counted in those operations, in the same way as psi. Since vmpressure
> > calls need to happen deeper within the reclaim path, the same approach
> > could not be followed. Hence, a new "controlled" flag is added to struct
> > scan_control to flag a reclaim operation that is controlled by
> > userspace. This flag is set by limit-setting and proactive reclaim
> > operations, and is used to count vmpressure correctly.
> >
> > To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
> > ("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
> > is effectively reverted and the same flag is used to control psi as
> > well.
>
> I'll await reviewer input on this, but I can always do trivia!

Thanks for taking a look so quickly, will address and send v2 soon!

>
> > @@ -3502,6 +3497,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> >  static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
> >  {
> >       int nr_retries = MAX_RECLAIM_RETRIES;
> > +     unsigned int reclaim_options = MEMCG_RECLAIM_CONTROLLED |
> > +             MEMCG_RECLAIM_MAY_SWAP;
>
> If it doesn't fit, it's nicer to do
>
>         unsigned int reclaim_options;
>         ...
>
>         reclaim_options = MEMCG_RECLAIM_CONTROLLED | MEMCG_RECLAIM_MAY_SWAP;
>
> (several places)
>
> > @@ -3751,6 +3757,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >               .may_writepage = !laptop_mode,
> >               .may_unmap = 1,
> >               .may_swap = 1,
> > +             .controlled = 0,
> >       };
>
> Let's just skip all these initializations to zero, let the compiler take
> care of it.
>
> > @@ -4095,6 +4112,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >               .gfp_mask = GFP_KERNEL,
> >               .order = order,
> >               .may_unmap = 1,
> > +             .controlled = 0,
> >       };
> >
> >       set_task_reclaim_state(current, &sc.reclaim_state);
> > @@ -4555,6 +4573,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
> >               .may_unmap = 1,
> >               .may_swap = 1,
> >               .hibernation_mode = 1,
> > +             .controlled = 0,
> >       };
> >       struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
> >       unsigned long nr_reclaimed;
> > @@ -4707,6 +4726,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >               .may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
> >               .may_swap = 1,
> >               .reclaim_idx = gfp_zone(gfp_mask),
> > +             .controlled = 0,
> >       };
> >       unsigned long pflags;
>
>
