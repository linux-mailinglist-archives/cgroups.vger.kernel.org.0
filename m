Return-Path: <cgroups+bounces-15191-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FsiNCLA1Wmi9QcAu9opvQ
	(envelope-from <cgroups+bounces-15191-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 04:40:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE93B6441
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76243015898
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2026 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2135E949;
	Wed,  8 Apr 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQTM5ksY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEF19F40B;
	Wed,  8 Apr 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616030; cv=none; b=mAL+Z7eeAB0mdWF7xbDkGartSpNcYyvQkK41GZAh+asp+hcmXwIC/1N29DcLzAmROS+0m5VMOs2BK2ExkJZpOj4Nx0qk2S9hQAuhPGq3aPwdWDCOfSZXuXd0EpkgAK5PLVUdfzwVsul7WIKs+sQluW6VlYG7G8BBMWSkNXABolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616030; c=relaxed/simple;
	bh=EUzf7XILl/73QfjDDoALzxB1Kjg3AYvxj5Nc0rcI6wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raF0VyCeh6i689M5LS/TLa1wM0tLKmh3bgaNrMqz8g1s/i9+PiK0sZgYAzosaaslD0uJbzoVrHRbbkZTld8XX4UzgzW1kX1UAwobVmkQIs2YtHtzyqsUwG9nUCaF7xYwjuqb+/2pUfs2fWBn2NMVm9X3gwfAnX1XuM91mKaVT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQTM5ksY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93949C116C6;
	Wed,  8 Apr 2026 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775616030;
	bh=EUzf7XILl/73QfjDDoALzxB1Kjg3AYvxj5Nc0rcI6wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQTM5ksY/zhLyKmTxaZ1GRwI6jIeVneI2kjQUcsN/o5ADMABGMhtZCUK1M46ink0v
	 BryrEsxfwPmUbf+Gvm2ojjHaaWpnfN86ju3tLvcQH9nXrUB3RNzHQ4s1aO1WFOY0B/
	 rxNTqQzvsLUFn6xnCF1exq3eL5qffV+ESyGbinSEZ/zyxdS1eE3RDg/yj+Iv1tu5Oj
	 qKhaT68or7BNSfk/eTsZRnagEaNJGSz4Fm+vS5K++j2iR7vbVkHW+DPy9Mfjr/OdA6
	 D6aiilcxvPA7PE32tFziJiHBdfVpA41IXwHtFZGpCdP+XQ45y8C1TJfmrelyNZq35m
	 qINs1+gtkboFQ==
Date: Wed, 8 Apr 2026 11:40:27 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Yosry Ahmed <yosry@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/percpu, memcontrol: Per-memcg-lruvec percpu
 accounting
Message-ID: <adXAG52R6WVHd0n9@hyeyoo>
References: <20260404033844.1892595-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404033844.1892595-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15191-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30BE93B6441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 08:38:43PM -0700, Joshua Hahn wrote:
> enum memcg_stat_item includes memory that is tracked on a per-memcg
> level, but not at a per-node (and per-lruvec) level. Diagnosing
> memory pressure for memcgs in multi-NUMA systems can be difficult,
> since not all of the memory accounted in memcg can be traced back
> to a node. In scenarios where numa nodes in an memcg are asymmetrically
> stressed, this difference can be invisible to the user.
> 
> Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> to give visibility into per-node breakdowns for percpu allocations.
> 
> This will get us closer to being able to know the memcg and physical
> association of all memory on the system. Specifically for percpu, this
> granularity will help demonstrate footprint differences on systems with
> asymmetric NUMA nodes.
> 
> Because percpu memory is accounted at a sub-PAGE_SIZE level, we must
> account node level statistics (accounted in PAGE_SIZE units) and
> memcg-lruvec statistics separately. Account node statistics when the pcpu
> pages are allocated, and account memcg-lruvec statistics when pcpu
> objects are handed out.
> 
> To do account these separately, expose mod_memcg_lruvec_state to be
> used outside of memcontrol.
> 
> The memory overhead of this patch is small; it adds 16 bytes
> per-cgroup-node-cpu. For an example machine with 200 CPUs split across
> 2 nodes and 50 cgroups in the system, we see a 312.5 kB increase. Note
> that this is the same cost as any other item in memcg_node_stat_item.
> 
> Performance impact is also negligible. These are results from a kernel
> module which performs 100k percpu allocations via __alloc_percpu_gfp
> with GFP_KERNEL | __GFP_ACCOUNT in a cgroup, across 20 trials.
> Batched performs 100k allocations followed by 100k frees, while
> interleaved performs allocation --> free --> allocation ...
> 
> +-------------+----------------+--------------+--------------+
> |    Test     | linus-upstream |    patch     |     diff     |
> +-------------+----------------+--------------+--------------+
> | Batched     | 6586 +/- 51    | 6595 +/- 35  | +9 (0.13%)   |
> | Interleaved | 1053 +/- 126   | 1085 +/- 113 | +32 (+0.85%) |
> +-------------+----------------+--------------+--------------+
> 
> One functional change is that there can be a tiny inconsistency between
> the size of the allocation used for memcg limit checking and what is
> charged to each lruvec due to dropping fractional charges when rounding.
> In reality this value is very very small and always lies on the side of
> memory checking at a higher threshold, so there is no behavioral change
> from userspace.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/linux/memcontrol.h |  4 +++-
>  include/linux/mmzone.h     |  4 +++-
>  mm/memcontrol.c            | 12 +++++-----
>  mm/percpu-vm.c             | 14 ++++++++++--
>  mm/percpu.c                | 45 ++++++++++++++++++++++++++++++++++----
>  mm/vmstat.c                |  1 +
>  6 files changed, 66 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 4f5937090590d..e36b639f521dd 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -65,6 +66,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
>  				__free_page(page);
>  		}
>  	}
> +
> +	for_each_node(nid)
> +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> +				-1L * nr_pages * nr_cpus_node(nid) * PAGE_SIZE);

Can this end up with mis-accounting due to CPU hotplug?

>  }
>  
>  /**
> @@ -84,7 +89,8 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
>  			    gfp_t gfp)
>  {
>  	unsigned int cpu, tcpu;
> -	int i;
> +	int nr_pages = page_end - page_start;
> +	int i, nid;
>  
>  	gfp |= __GFP_HIGHMEM;
>  
> @@ -97,6 +103,10 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
>  				goto err;
>  		}
>  	}
> +
> +	for_each_node(nid)
> +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> +				    nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
>  	return 0;
>  
>  err:

-- 
Cheers,
Harry / Hyeonggon

