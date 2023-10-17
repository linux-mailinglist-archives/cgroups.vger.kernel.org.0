Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD56F7CCA0D
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjJQRoM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQRoL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 13:44:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D4A7A4;
        Tue, 17 Oct 2023 10:44:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C66182F4;
        Tue, 17 Oct 2023 10:44:47 -0700 (PDT)
Received: from [10.57.66.147] (unknown [10.57.66.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7AA3F64C;
        Tue, 17 Oct 2023 10:44:04 -0700 (PDT)
Message-ID: <21606fe5-fb9b-4d37-98ab-38c96819893b@arm.com>
Date:   Tue, 17 Oct 2023 18:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
Content-Language: en-GB
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20230919171447.2712746-1-nphamcs@gmail.com>
 <20230919171447.2712746-2-nphamcs@gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230919171447.2712746-2-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 19/09/2023 18:14, Nhat Pham wrote:
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> 
> Currently, we only have a single global LRU for zswap. This makes it
> impossible to perform worload-specific shrinking - an memcg cannot
> determine which pages in the pool it owns, and often ends up writing
> pages from other memcgs. This issue has been previously observed in
> practice and mitigated by simply disabling memcg-initiated shrinking:
> 
> https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u
> 
> This patch fully resolves the issue by replacing the global zswap LRU
> with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
> 
> a) When a store attempt hits an memcg limit, it now triggers a
>    synchronous reclaim attempt that, if successful, allows the new
>    hotter page to be accepted by zswap.
> b) If the store attempt instead hits the global zswap limit, it will
>    trigger an asynchronous reclaim attempt, in which an memcg is
>    selected for reclaim in a round-robin-like fashion.
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/list_lru.h   |  39 +++++++
>  include/linux/memcontrol.h |   5 +
>  include/linux/zswap.h      |   9 ++
>  mm/list_lru.c              |  46 ++++++--
>  mm/swap_state.c            |  19 ++++
>  mm/zswap.c                 | 221 +++++++++++++++++++++++++++++--------
>  6 files changed, 287 insertions(+), 52 deletions(-)
> 

[...]

> @@ -1199,8 +1272,10 @@ bool zswap_store(struct folio *folio)
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
>  	struct obj_cgroup *objcg = NULL;
> +	struct mem_cgroup *memcg = NULL;
>  	struct zswap_pool *pool;
>  	struct zpool *zpool;
> +	int lru_alloc_ret;
>  	unsigned int dlen = PAGE_SIZE;
>  	unsigned long handle, value;
>  	char *buf;
> @@ -1218,14 +1293,15 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_enabled || !tree)
>  		return false;
>  
> -	/*
> -	 * XXX: zswap reclaim does not work with cgroups yet. Without a
> -	 * cgroup-aware entry LRU, we will push out entries system-wide based on
> -	 * local cgroup limits.
> -	 */
>  	objcg = get_obj_cgroup_from_folio(folio);
> -	if (objcg && !obj_cgroup_may_zswap(objcg))
> -		goto reject;
> +	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (shrink_memcg(memcg)) {
> +			mem_cgroup_put(memcg);
> +			goto reject;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
>  
>  	/* reclaim space if needed */
>  	if (zswap_is_full()) {
> @@ -1240,7 +1316,11 @@ bool zswap_store(struct folio *folio)
>  		else
>  			zswap_pool_reached_full = false;
>  	}
> -
> +	pool = zswap_pool_current_get();
> +	if (!pool) {
> +		ret = -EINVAL;
> +		goto reject;
> +	}


Hi, I'm working to add support for large folios within zswap, and noticed this
piece of code added by this change. I don't see any corresponding put. Have I
missed some detail or is there a bug here?


>  	/* allocate entry */
>  	entry = zswap_entry_cache_alloc(GFP_KERNEL);
>  	if (!entry) {
> @@ -1256,6 +1336,7 @@ bool zswap_store(struct folio *folio)
>  			entry->length = 0;
>  			entry->value = value;
>  			atomic_inc(&zswap_same_filled_pages);
> +			zswap_pool_put(pool);

I see you put it in this error path, but after that, there is no further mention.

>  			goto insert_entry;
>  		}
>  		kunmap_atomic(src);
> @@ -1264,6 +1345,15 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_non_same_filled_pages_enabled)
>  		goto freepage;
>  
> +	if (objcg) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		lru_alloc_ret = memcg_list_lru_alloc(memcg, &pool->list_lru, GFP_KERNEL);
> +		mem_cgroup_put(memcg);
> +
> +		if (lru_alloc_ret)
> +			goto freepage;
> +	}
> +
>  	/* if entry is successfully added, it keeps the reference */
>  	entry->pool = zswap_pool_current_get();

The entry takes it's reference to the pool here.

Thanks,
Ryan


