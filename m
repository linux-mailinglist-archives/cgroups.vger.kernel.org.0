Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8B752C4B5
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiERUmu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbiERUmt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 16:42:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E07356D;
        Wed, 18 May 2022 13:42:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so3175366pfe.13;
        Wed, 18 May 2022 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6HxZzpngw/etNChNibsDXhKswEW/6aIadFsBJdrJJo4=;
        b=awWcNKqjy2oRaHWNaqLwLD6wKR1D/z59/WTk7SitzgIT2rrcSjEAzKnmIANUYPI594
         Za9zLKSXvw9xDbb6WAqjfnsaqa+LcQ85oop4z3ut4hYBrcONqxF0sv1J7v9CRmQAgFwS
         JPhO4DcmtuiP+C8flQBkc7mV9fcXvo5etKLQ23hS9bAof2A9TG7qkYj4gGtRwoaYvbhi
         qnQSQ41jmnAtz4N2LC6bnhJSxOh4NBimWb3ryXPExRgj4MHexjRknJtWD35Pdw6VfcIA
         JwZ/xcXEkCG2cEPoyKjmIaBjOMiXjmim/5dVWzOCqBtKv2aKMnyA4ctLcHfI3Su9ySpC
         JLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6HxZzpngw/etNChNibsDXhKswEW/6aIadFsBJdrJJo4=;
        b=lorOMfdCfU/nPTVahKcev8noXNJWAWPoa5gJAMd2pPhNbL0fE83HN7L1t5qHicpjta
         1f0yk0z3xBwjgAC75gTj4yUUqscpSvqjUsnmqYvQ2rJvIJU1FPc62rGSJDc9cbV6tub3
         Xh7FKHNptMNf25k+lnzngJUb/KOenL9n9LnM6RLVjbk7Xicjnwe6dGZlhRr15dn7jaPN
         OwfAorjdORfCeTv71bM9UWUgAx7iVj4z1vrwx43CDb8ixxL4o6wp5QT/ADV041D5Anm6
         x95iFJlAD50JotWpuge2BOK+aw7xFBgOX1ag0R4/bskgc8kk+nWq4MoQ409MCBIcJNs4
         Qr8g==
X-Gm-Message-State: AOAM530D3eeUNrpbW6guP1WupLbLyo4EnrGFhzMRiU16uwtA9Qug/OGy
        ljLUaYrFcItOgRsguJCW8fegfo1ErNOvbPVFU78=
X-Google-Smtp-Source: ABdhPJwr3C01INAi6GC0hkskroZFNDJuYcDLl778oO2SYsFl1Sm5OI4jxNpbq7dQJneYf4lpbm0rmakb/7lTkLilevw=
X-Received: by 2002:a65:4b81:0:b0:3c6:19aa:ea37 with SMTP id
 t1-20020a654b81000000b003c619aaea37mr1007895pgq.75.1652906567807; Wed, 18 May
 2022 13:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220518190911.82400-1-hannes@cmpxchg.org>
In-Reply-To: <20220518190911.82400-1-hannes@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 May 2022 13:42:35 -0700
Message-ID: <CAHbLzko400euGGZt-=q9AgSKpv0PAbgKvc7OJ7nOJCX3gQz2oQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 18, 2022 at 12:09 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This reverts commit 3a235693d3930e1276c8d9cc0ca5807ef292cf0a.
>
> Its premise was that cgroup reclaim cares about freeing memory inside
> the cgroup, and demotion just moves them around within the cgroup
> limit. Hence, pages from toptier nodes should be reclaimed directly.

Yes, exactly.

>
> However, with NUMA balancing now doing tier promotions, demotion is
> part of the page aging process. Global reclaim demotes the coldest
> toptier pages to secondary memory, where their life continues and from
> which they have a chance to get promoted back. Essentially, tiered
> memory systems have an LRU order that spans multiple nodes.
>
> When cgroup reclaims pages coming off the toptier directly, there can
> be colder pages on lower tier nodes that were demoted by global
> reclaim. This is an aging inversion, not unlike if cgroups were to
> reclaim directly from the active lists while there are inactive pages.

Thanks for pointing this out, makes sense to me.

>
> Proactive reclaim is another factor. The goal of that it is to offload
> colder pages from expensive RAM to cheaper storage. When lower tier
> memory is available as an intermediate layer, we want offloading to
> take advantage of it instead of bypassing to storage.
>
> Revert the patch so that cgroups respect the LRU order spanning the
> memory hierarchy.
>
> Of note is a specific undercommit scenario, where all cgroup limits in
> the system add up to <= available toptier memory. In that case,
> shuffling pages out to lower tiers first to reclaim them from there is
> inefficient. This is something could be optimized/short-circuited
> later on (although care must be taken not to accidentally recreate the
> aging inversion). Let's ensure correctness first.

Some side effects we might keep an eye with this revert:
  - Limit reclaim may experience longer latency since it has to do
demotion + reclaim to uncharge enough memory
  - Higher max usage due to the force charge from migration (of course
other migrations, i.e. NUMA fault, could have similar effect, but
anyway one more contributing factor)

They may not be noticeable hopefully, but I tend to agree that keeping
aging correct may be more important.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> ---
>  mm/vmscan.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6918fff06e1..7a4090712177 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -528,13 +528,8 @@ static bool can_demote(int nid, struct scan_control *sc)
>  {
>         if (!numa_demotion_enabled)
>                 return false;
> -       if (sc) {
> -               if (sc->no_demotion)
> -                       return false;
> -               /* It is pointless to do demotion in memcg reclaim */
> -               if (cgroup_reclaim(sc))
> -                       return false;
> -       }
> +       if (sc && sc->no_demotion)
> +               return false;
>         if (next_demotion_node(nid) == NUMA_NO_NODE)
>                 return false;
>
> --
> 2.36.1
>
>
