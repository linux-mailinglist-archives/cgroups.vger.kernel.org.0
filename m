Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0A64519E
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 02:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLGB6T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 20:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLGB6S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 20:58:18 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58498532C6
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 17:58:17 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1442977d77dso18558312fac.6
        for <cgroups@vger.kernel.org>; Tue, 06 Dec 2022 17:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8963QVuWzMlre8yLN4891ujCBmWo5SyqcLZ8tSbZjQ=;
        b=eBRBdaHXvgKpW6/nBEGd/saUzFoozLpzIKQmkJccf22pFYLqqUwQmUXP7zz+NHarWr
         y6oNwxxTkbGSuO+M05BGsjg+XcnEor7+ZxHUaOF9F0dTgXN7JIhH9mxY69OxgcpyIJtb
         qj/GNdr7md0XD0zM0Hpy6wzMv9vqEvJfEd51lxXbNqMjf1P3z2dC4uoPY6R4fKcFL2FB
         9h3S323dKwW0PyiDSM/OYs9Vn6du77A0CRL7M/dX4DwA8nNcujWN5Rkdp2SbA9XC6Lsj
         UTrD1polfnjmptxxWF4CLi5v3jR2pGansFPDF0QCUdjds6TL4/tG/rF5tcpCKINWjhf6
         5Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8963QVuWzMlre8yLN4891ujCBmWo5SyqcLZ8tSbZjQ=;
        b=vUlviM3H8x65bpoZEZoanbUd1HCYQZF9uyDV5qHyssqbFBkHtB6eM4aWkSw6DTDi1Y
         z7LWj6+szw2pzbCJF1VWMK0n5wgceh9zU7lN0j6/91IWiEZXDQlbo14JOaC/o8ZGt2F7
         +DxXW6Rwot6a84ko34OAp+u544kgg3QzGetf91dcMPZ5EWgAPT8c2CoGKxaCAvfxVHRy
         QyTLfcJU4eaSo7phEdlpfHUcu9AvdIZO+rZtCNE2UcHz+5+Z6zoyZ+QDj4HQowtwIEkL
         c5I1KQ3aYhjtNMoD2n7W+lN6X69bKgoGyRGEPAMwr6PqxvWlm7NTjFOaLDBshRwvqbJC
         DMrg==
X-Gm-Message-State: ANoB5pnjgd6wEAEsA1lAC4EsM79xyrBngjQewLcawfqQuVd3cJskzxbP
        OE5pdDj10EZ/d/bvVNvLFEbOTA==
X-Google-Smtp-Source: AA0mqf5/RI59FAboxfx2566HImOLKq9uSfCZXsGND07TLSEOb93NMRKIOCrF49q2VX8skzs0kz/enw==
X-Received: by 2002:a05:6870:8882:b0:132:6f79:9ffb with SMTP id m2-20020a056870888200b001326f799ffbmr41793603oam.61.1670378296550;
        Tue, 06 Dec 2022 17:58:16 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k7-20020a056830168700b006705cddb73fsm1205278otr.31.2022.12.06.17.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:58:16 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:58:14 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcontrol: deprecate charge moving
In-Reply-To: <20221206171340.139790-4-hannes@cmpxchg.org>
Message-ID: <02b9663-4377-bd67-8da2-aad72240da@google.com>
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 6 Dec 2022, Johannes Weiner wrote:

> Charge moving mode in cgroup1 allows memory to follow tasks as they
> migrate between cgroups. This is, and always has been, a questionable
> thing to do - for several reasons.
> 
> First, it's expensive. Pages need to be identified, locked and
> isolated from various MM operations, and reassigned, one by one.
> 
> Second, it's unreliable. Once pages are charged to a cgroup, there
> isn't always a clear owner task anymore. Cache isn't moved at all, for
> example. Mapped memory is moved - but if trylocking or isolating a
> page fails, it's arbitrarily left behind. Frequent moving between
> domains may leave a task's memory scattered all over the place.
> 
> Third, it isn't really needed. Launcher tasks can kick off workload
> tasks directly in their target cgroup. Using dedicated per-workload
> groups allows fine-grained policy adjustments - no need to move tasks
> and their physical pages between control domains. The feature was
> never forward-ported to cgroup2, and it hasn't been missed.
> 
> Despite it being a niche usecase, the maintenance overhead of
> supporting it is enormous. Because pages are moved while they are live
> and subject to various MM operations, the synchronization rules are
> complicated. There are lock_page_memcg() in MM and FS code, which
> non-cgroup people don't understand. In some cases we've been able to
> shift code and cgroup API calls around such that we can rely on native
> locking as much as possible. But that's fragile, and sometimes we need
> to hold MM locks for longer than we otherwise would (pte lock e.g.).
> 
> Mark the feature deprecated. Hopefully we can remove it soon.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Hugh Dickins <hughd@google.com>

but I wonder if it would be helpful to mention move_charge_at_immigrate
in the deprecation message: maybe the first line should be
"Cgroup memory moving (move_charge_at_immigrate) is deprecated.\n"

> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 11 ++++++++++-
>  mm/memcontrol.c                                |  4 ++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 60370f2c67b9..87d7877b98ec 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -86,6 +86,8 @@ Brief summary of control files.
>   memory.swappiness		     set/show swappiness parameter of vmscan
>  				     (See sysctl's vm.swappiness)
>   memory.move_charge_at_immigrate     set/show controls of moving charges
> +                                     This knob is deprecated and shouldn't be
> +                                     used.
>   memory.oom_control		     set/show oom controls.
>   memory.numa_stat		     show the number of memory usage per numa
>  				     node
> @@ -717,9 +719,16 @@ Soft limits can be setup by using the following commands (in this example we
>         It is recommended to set the soft limit always below the hard limit,
>         otherwise the hard limit will take precedence.
>  
> -8. Move charges at task migration
> +8. Move charges at task migration (DEPRECATED!)
>  =================================
>  
> +THIS IS DEPRECATED!
> +
> +It's expensive and unreliable! It's better practice to launch workload
> +tasks directly from inside their target cgroup. Use dedicated workload
> +cgroups to allow fine-grained policy adjustments without having to
> +move physical pages between control domains.
> +
>  Users can move charges associated with a task along with task migration, that
>  is, uncharge task's pages from the old cgroup and charge them to the new cgroup.
>  This feature is not supported in !CONFIG_MMU environments because of lack of
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b696354c1b21..e650a38d9a90 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3919,6 +3919,10 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
> +	pr_warn_once("Cgroup memory moving is deprecated. "
> +		     "Please report your usecase to linux-mm@kvack.org if you "
> +		     "depend on this functionality.\n");
> +
>  	if (val & ~MOVE_MASK)
>  		return -EINVAL;
>  
> -- 
> 2.38.1
> 
> 
