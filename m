Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C194C6E4
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2019 07:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFTFud (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jun 2019 01:50:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfFTFuc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 20 Jun 2019 01:50:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B5A0AC2C;
        Thu, 20 Jun 2019 05:50:31 +0000 (UTC)
Date:   Thu, 20 Jun 2019 07:50:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation failure
Message-ID: <20190620055028.GA12083@dhcp22.suse.cz>
References: <20190619232514.58994-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619232514.58994-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 19-06-19 16:25:14, Shakeel Butt wrote:
> Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> be crashed. This is unnecessary as the kernel can handle the creation
> failures of memcg kmem caches.

AFAICS it will handle those by simply not accounting those objects
right?

> Additionally CONFIG_SLAB does not
> implement this behavior. So, to keep the behavior consistent between
> SLAB and SLUB, removing the panic for memcg kmem cache creation
> failures. The root kmem cache creation failure for SLAB_PANIC correctly
> panics for both SLAB and SLUB.

I do agree that panicing is really dubious especially because it opens
doors to shut the system down from a restricted environment. So the
patch makes sesne to me.

I am wondering whether SLAB_PANIC makes sense in general though. Why is
it any different from any other essential early allocations? We tend to
not care about allocation failures for those on bases that the system
must be in a broken state to fail that early already. Do you think it is
time to remove SLAB_PANIC altogether?

> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/slub.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6a5174b51cd6..84c6508e360d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3640,10 +3640,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  
>  	free_kmem_cache_nodes(s);
>  error:
> -	if (flags & SLAB_PANIC)
> -		panic("Cannot create slab %s size=%u realsize=%u order=%u offset=%u flags=%lx\n",
> -		      s->name, s->size, s->size,
> -		      oo_order(s->oo), s->offset, (unsigned long)flags);
>  	return -EINVAL;
>  }
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 
Michal Hocko
SUSE Labs
