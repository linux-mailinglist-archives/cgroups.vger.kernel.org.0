Return-Path: <cgroups+bounces-13725-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHYLH49QhWn5/gMAu9opvQ
	(envelope-from <cgroups+bounces-13725-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:23:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4513F93BD
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D88303BA53
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 02:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9623EAB4;
	Fri,  6 Feb 2026 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk2jSRTQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA2273F9;
	Fri,  6 Feb 2026 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344515; cv=none; b=S5LaJZru/JShSB9EAIbYqwsrzoXRopkhK0rJ+yLiEmnhfe7ob30E9Yv0eV2TB6M8Cjm+KYsJCk/IdSmURzNUc6B6o4qjtBzSI9nBrc9wpMzsuTEE7o1XkGlA0z/7RucHNsBC3O7SQbpk/AGscA2KZe8/kjOulzN4ReDp75b98b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344515; c=relaxed/simple;
	bh=YrlI3yBeNTgWfQVpjlQawqIA17VuSw3ki8nDUSsk8Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAOswkDDpn2g9+I8hzT4472iXRuDfWeNt8DqMQiAaLNYAzQVWk8dkuoIYp4VSNZsawp3sV2wjAolupFFdy+f1THvO+HEtVt/3rERMELZu6G3VLtzcG4fbMAVH/Jwug7M0GY9l9wFut8Zx6gfK4sEmu1xLJ9FgfQ1o3Og1tS2LcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk2jSRTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44283C4CEF7;
	Fri,  6 Feb 2026 02:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344514;
	bh=YrlI3yBeNTgWfQVpjlQawqIA17VuSw3ki8nDUSsk8Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bk2jSRTQ7fnmwvmvb7lXbQLA03HtBYzQpEBdKc1xSYXE1/nThiPnvYFoADxoWiUi5
	 S4ckrO0mjLz33wsYhur/G6UTqNR5VSVgytQEl+tecSnJVSW9oIiRNGQiV81CWRDtKw
	 EUQsfK4sLApZyXkfpOt0CcZRvFHuZoy/XLKag6hkzGucXq0RHXe2bMMhd0FycimYa/
	 s7xKeMGAUhQvAoZ8+BHXSvjiN1u6VEnHJChj1UcMw75qyB3pihi5XOEu6vuzcQwf5Y
	 V5wcfz1HaexVvXzmKWyMRq70V0P1XvnB9j4x2YCM+0g7zvGpGFOGOZ9tc0/L4KqZBG
	 OzrAGp5ykz0ng==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible pages
Date: Thu,  5 Feb 2026 18:21:51 -0800
Message-ID: <20260206022152.67992-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205053013.25134-1-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,shopee.com,cmpxchg.org,linux.dev,gmail.com,linux-foundation.org,fb.com,suse.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13725-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,shopee.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4513F93BD
X-Rspamd-Action: no action

On Thu,  5 Feb 2026 13:30:12 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> The global zswap_stored_incompressible_pages counter was added in commit
> dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is")
> to track how many pages are stored in raw (uncompressed) form in zswap.
> However, in containerized environments, knowing which cgroup is
> contributing incompressible pages is essential for effective resource
> management.
> 
> Add a new memcg stat 'zswpraw' to track incompressible pages per cgroup.
> This helps administrators and orchestrators to:
> 
> 1. Identify workloads that produce incompressible data (e.g., encrypted
>    data, already-compressed media, random data) and may not benefit from
>    zswap.
> 
> 2. Make informed decisions about workload placement - moving
>    incompressible workloads to nodes with larger swap backing devices
>    rather than relying on zswap.
> 
> 3. Debug zswap efficiency issues at the cgroup level without needing to
>    correlate global stats with individual cgroups.
> 
> While the compression ratio can be estimated from existing stats
> (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> "uniformly poor compression" and "a few completely incompressible pages
> mixed with highly compressible ones". The zswpraw stat provides direct
> visibility into the latter case.
> 
> Changes
> -------
> 
> 1. Add zswap_is_raw() helper (include/linux/zswap.h)
>    - Abstract the PAGE_SIZE comparison logic for identifying raw entries
>    - Keep the incompressible check in one place for maintainability
> 
> 2. Add MEMCG_ZSWAP_RAW stat definition (include/linux/memcontrol.h,
>    mm/memcontrol.c)
>    - Add MEMCG_ZSWAP_RAW to memcg_stat_item enum
>    - Register in memcg_stat_items[] and memory_stats[] arrays
>    - Export as "zswpraw" in memory.stat
> 
> 3. Update statistics accounting (mm/memcontrol.c, mm/zswap.c)
>    - Track MEMCG_ZSWAP_RAW in obj_cgroup_charge/uncharge_zswap()
>    - Use zswap_is_raw() helper in zswap.c for consistency
> 
> Test
> ----
> 
> I wrote a simple test program[1] that allocates memory and compresses it
> with zstd, so kernel zswap cannot compress further.
> 
>   $ cgcreate -g memory:test
>   $ cgexec -g memory:test ./test_zswpraw &
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 0
>   zswpin 0
>   zswpout 0
>   zswpwb 0
> 
>   $ echo "100M" > /sys/fs/cgroup/test/memory.reclaim
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 104800256
>   zswpin 0
>   zswpout 51222
>   zswpwb 0
> 
>   $ pkill test_zswpraw
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 0
>   zswpin 1
>   zswpout 51222
>   zswpwb 0
> 
> [1] https://gist.github.com/mrpre/00432c6154250326994fbeaf62e0e6f1
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  include/linux/memcontrol.h | 1 +
>  include/linux/zswap.h      | 9 +++++++++
>  mm/memcontrol.c            | 6 ++++++
>  mm/zswap.c                 | 6 +++---
>  4 files changed, 19 insertions(+), 3 deletions(-)

As others also mentioned, the documentation of the new stat would be needed.

> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6c82c8f73e1..83d1328f81d1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +	MEMCG_ZSWAP_RAW,
>  	MEMCG_NR_STAT,
>  };
>  
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 30c193a1207e..94f84b154b71 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,6 +7,15 @@
>  
>  struct lruvec;
>  
> +/*
> + * Check if a zswap entry is stored in raw (uncompressed) form.
> + * This happens when compression doesn't reduce the size.
> + */
> +static inline bool zswap_is_raw(size_t size)
> +{
> +	return size == PAGE_SIZE;
> +}
> +

No strong opinion, but I'm not really sure if the helper is needed, because it
feels quite simple logic:

    "If an object is compressed and the size is same to the original one, the
    object is incompressible."

I also feel the function name bit odd, given the type of the parameter.  Based
on the function name and the comment, I'd expect it to receive a zswap_entry
object.  I understand it is better to receive a size_t, to be called from
obj_cgroup_[un]charge_zswap(), though.  Even in the case, I think the name can
be better (e.g., zswap_compression_failed() or zswap_was_incompressible() ?),
or at least the coment can be more kindly explain the fact that the parameter
is the size of object after the compression attempt.

>  extern atomic_long_t zswap_stored_pages;
>  
>  #ifdef CONFIG_ZSWAP
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 007413a53b45..32fb801530a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -341,6 +341,7 @@ static const unsigned int memcg_stat_items[] = {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +	MEMCG_ZSWAP_RAW,
>  };

No strong opinion, but I think Shakeel's suggestion of other names is
reasonable.

>  
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[] = {
>  #ifdef CONFIG_ZSWAP
>  	{ "zswap",			MEMCG_ZSWAP_B			},
>  	{ "zswapped",			MEMCG_ZSWAPPED			},
> +	{ "zswpraw",			MEMCG_ZSWAP_RAW			},

Ditto.

>  #endif
>  	{ "file_mapped",		NR_FILE_MAPPED			},
>  	{ "file_dirty",			NR_FILE_DIRTY			},
> @@ -5458,6 +5460,8 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>  	memcg = obj_cgroup_memcg(objcg);
>  	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
>  	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> +	if (zswap_is_raw(size))
> +		mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, 1);

I understand the helper function is better to receive size_t rather than
zswap_entry for this.

>  	rcu_read_unlock();
>  }
>  
> @@ -5481,6 +5485,8 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
>  	memcg = obj_cgroup_memcg(objcg);
>  	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
>  	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
> +	if (zswap_is_raw(size))
> +		mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, -1);
>  	rcu_read_unlock();
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3d2d59ac3f9c..54ab4d126f64 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -723,7 +723,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>  		obj_cgroup_put(entry->objcg);
>  	}
> -	if (entry->length == PAGE_SIZE)
> +	if (zswap_is_raw(entry->length))
>  		atomic_long_dec(&zswap_stored_incompressible_pages);
>  	zswap_entry_cache_free(entry);
>  	atomic_long_dec(&zswap_stored_pages);
> @@ -941,7 +941,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	zs_obj_read_sg_begin(pool->zs_pool, entry->handle, input, entry->length);
>  
>  	/* zswap entries of length PAGE_SIZE are not compressed. */
> -	if (entry->length == PAGE_SIZE) {
> +	if (zswap_is_raw(entry->length)) {
>  		WARN_ON_ONCE(input->length != PAGE_SIZE);
>  		memcpy_from_sglist(kmap_local_folio(folio, 0), input, 0, PAGE_SIZE);
>  		dlen = PAGE_SIZE;

Below this part, I show 'dlen == PAGE_SIZE'.  Should it also be converted to
use the helper function?

> @@ -1448,7 +1448,7 @@ static bool zswap_store_page(struct page *page,
>  		obj_cgroup_charge_zswap(objcg, entry->length);
>  	}
>  	atomic_long_inc(&zswap_stored_pages);
> -	if (entry->length == PAGE_SIZE)
> +	if (zswap_is_raw(entry->length))
>  		atomic_long_inc(&zswap_stored_incompressible_pages);
>  
>  	/*
> -- 
> 2.43.0

Looks good to me overall, though.  Thank you for this patch.


Thanks,
SJ

