Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F575B41A
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGTQYp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGTQYo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 12:24:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB069E
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 09:24:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403c6a0f3aaso8915851cf.2
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689870282; x=1690475082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s74T/DS0uEk+n6R0wwBy5aetjEjuSLERJS55RIwoaX4=;
        b=IZzpQokKpB0UhARjk1C5AYsxhEoUwekbG1CIGPqpzF+J5EyUNV4fXvSh6ICM60s/l/
         l3LTb+/4oHtXOm/axHhrDe9RYyjLFUcJp/fjdEfH3AfdarB9wYiD6qDHqXQIUGTULJjY
         vw7yjUAGA6a1rzcc8PN64w16jP4JWgFnyix3oUPgbdJpcchORfcHKjhuGO7hDatwjMex
         Tgoo3H3N3xNYsZnI1oMU+JFxWEkqso9+qil3xyi6Lze7Drl2ReIPDqQjSEa8jAMYviY/
         z9eO+nZw1PsJ45lS/RFq6qSgkSD6Jl0gP4PD3UUJ8jAvUFV4u798afEKcJEM6QS2Vj9Y
         5HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870282; x=1690475082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s74T/DS0uEk+n6R0wwBy5aetjEjuSLERJS55RIwoaX4=;
        b=Dmxcx+qBb/xAN8lq4lD8pQvVRz8saYvc1sA08DSHrRD8Wg+bz+sAvDitNoPVEbfHg4
         4QeQjrMsYTLq7b80FhqZ9KxStQ8a5OFng/FvAIFL4K8fuV6Pzt4NgpL+LTdarDSoCfvN
         Sj54yCeGDKw6gJ3TKBx7b25i4T/Ce47fRYojTDX563I5CW9PcnuXZYRcIt2RnLpu/d09
         S7KN1zSJNlS/hTkLj2QFgmZJk4/Jjgc3jyo+rfnSTfuyGwQJ7feORycwbhXbekTkJl3w
         12/nyQiCQ3CyMJWRFL0SNrAkVY5yWKM15LLPWy5FEfx6pQkaQ/f4FWGXV/3vJAxArKek
         11hw==
X-Gm-Message-State: ABy/qLbk2E/cIWmvgo3XVGaTeAsT+6hOYTOfxzMpOfhoKfkiuvpHR9hX
        c7G6HnCtalkfRi6ozqG7DyMiJQ==
X-Google-Smtp-Source: APBJJlFgEYqldxkiOjJHk0bAl/tukxpRZVH2RVuIZHt9j9/eVwHSR5HC6Q+XrizCrjEJ9XxT5shHCA==
X-Received: by 2002:ac8:598d:0:b0:403:b4da:6e53 with SMTP id e13-20020ac8598d000000b00403b4da6e53mr3014943qte.44.1689870281860;
        Thu, 20 Jul 2023 09:24:41 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id s41-20020a05622a1aa900b00405447ee5e8sm457395qtc.55.2023.07.20.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:24:41 -0700 (PDT)
Date:   Thu, 20 Jul 2023 12:24:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Efly Young <yangyifei03@kuaishou.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive
 reclaim
Message-ID: <20230720162440.GA1015794@cmpxchg.org>
References: <20230720072708.55067-1-yangyifei03@kuaishou.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720072708.55067-1-yangyifei03@kuaishou.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 03:27:08PM +0800, Efly Young wrote:
> Before commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim and
> swap floods"), proactive reclaim will extreme overreclaim sometimes.
> But proactive reclaim still inaccurate and some extent overreclaim.
> 
> Problematic case is easy to construct. Allocate lots of anonymous
> memory (e.g., 20G) in a memcg, then swapping by writing memory.recalim
> and there is a certain probability of overreclaim. For example, request
> 1G by writing memory.reclaim will eventually reclaim 1.7G or other
> values more than 1G.
> 
> The reason is that reclaimer may have already reclaimed part of requested
> memory in one loop, but before adjust sc->nr_to_reclaim in outer loop,
> call shrink_lruvec() again will still follow the current sc->nr_to_reclaim
> to work. It will eventually lead to overreclaim. In theory, the amount
> of reclaimed would be in [request, 2 * request).
> 
> Reclaimer usually tends to reclaim more than request. But either direct
> or kswapd reclaim have much smaller nr_to_reclaim targets, so it is
> less noticeable and not have much impact.
> 
> Proactive reclaim can usually come in with a larger value, so the error
> is difficult to ignore. Considering proactive reclaim is usually low
> frequency, handle the batching into smaller chunks is a better approach.
> 
> Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Hey, I didn't write the patch, you did :) Please change it to

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

You can also add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

[quoting remainder for new CCs]

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e24..d36cf88 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6741,8 +6741,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			lru_add_drain_all();
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -						nr_to_reclaim - nr_reclaimed,
> -						GFP_KERNEL, reclaim_options);
> +					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> +					GFP_KERNEL, reclaim_options);
>  
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> -- 
> 1.8.3.1
