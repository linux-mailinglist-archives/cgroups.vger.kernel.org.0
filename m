Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053BD63FEC9
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiLBD0j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 22:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiLBD0j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 22:26:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DAD9B01;
        Thu,  1 Dec 2022 19:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669951598; x=1701487598;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=G2O1ipvqOEkk0tycNq2YMbH51tXGO4FlNOqpgufvoTY=;
  b=jS+Fq5i6gqSl4gmxg2t0sR8aN17hXeQhH/mn1QhSE1qeRnwu/xS3ufXd
   xzK30XTZeGZON249wECcmWP3yk1Hx5/WB3KGABaYlDS9unA15iDysZzVP
   Sd6d9euJM8oH06J1MMXIsBDfiQ8lWCfhauyvyzMo0+cs8ZWcGoodYANxR
   c8MPeu2Xu0n3gkzegR1Fgrc3XW+c0Xo0UBHoHd+Q/8pqVrcmxxjzvt8dW
   KnrhvRtfTTVRoj27F47rL94yjWtdKrtwdNK8fRd6+mEn2oP6l1Zlr6Us6
   /8uZKMPXwg3keVp4e965QQ63yWB6c4DPuKH3VX9xSlaYhsvaATApKqu+E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402141889"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="402141889"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 19:26:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733661676"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733661676"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 19:26:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
References: <20221130020328.1009347-1-almasrymina@google.com>
Date:   Fri, 02 Dec 2022 11:25:44 +0800
In-Reply-To: <20221130020328.1009347-1-almasrymina@google.com> (Mina Almasry's
        message of "Tue, 29 Nov 2022 18:03:27 -0800")
Message-ID: <878rjq32rr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> The nodes= arg instructs the kernel to only scan the given nodes for
> proactive reclaim. For example use cases, consider a 2 tier memory system:
>
> nodes 0,1 -> top tier
> nodes 2,3 -> second tier
>
> $ echo "1m nodes=0" > memory.reclaim
>
> This instructs the kernel to attempt to reclaim 1m memory from node 0.
> Since node 0 is a top tier node, demotion will be attempted first. This
> is useful to direct proactive reclaim to specific nodes that are under
> pressure.
>
> $ echo "1m nodes=2,3" > memory.reclaim
>
> This instructs the kernel to attempt to reclaim 1m memory in the second tier,
> since this tier of memory has no demotion targets the memory will be
> reclaimed.
>
> $ echo "1m nodes=0,1" > memory.reclaim
>
> Instructs the kernel to reclaim memory from the top tier nodes, which can
> be desirable according to the userspace policy if there is pressure on
> the top tiers. Since these nodes have demotion targets, the kernel will
> attempt demotion first.
>
> Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim""), the proactive reclaim interface memory.reclaim does both
> reclaim and demotion. Reclaim and demotion incur different latency costs
> to the jobs in the cgroup. Demoted memory would still be addressable
> by the userspace at a higher latency, but reclaimed memory would need to
> incur a pagefault.
>
> The 'nodes' arg is useful to allow the userspace to control demotion
> and reclaim independently according to its policy: if the memory.reclaim
> is called on a node with demotion targets, it will attempt demotion first;
> if it is called on a node without demotion targets, it will only attempt
> reclaim.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 15 +++---
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 67 ++++++++++++++++++++-----
>  mm/vmscan.c                             |  4 +-
>  4 files changed, 68 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 74cec76be9f2..ac5fcbcd5ae6 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1245,17 +1245,13 @@ PAGE_SIZE multiple when read back.
>  	This is a simple interface to trigger memory reclaim in the
>  	target cgroup.
>
> -	This file accepts a single key, the number of bytes to reclaim.
> -	No nested keys are currently supported.
> +	This file accepts a string which contains the number of bytes to
> +	reclaim.
>
>  	Example::
>
>  	  echo "1G" > memory.reclaim
>
> -	The interface can be later extended with nested keys to
> -	configure the reclaim behavior. For example, specify the
> -	type of memory to reclaim from (anon, file, ..).
> -
>  	Please note that the kernel can over or under reclaim from
>  	the target cgroup. If less bytes are reclaimed than the
>  	specified amount, -EAGAIN is returned.
> @@ -1267,6 +1263,13 @@ PAGE_SIZE multiple when read back.
>  	This means that the networking layer will not adapt based on
>  	reclaim induced by memory.reclaim.
>
> +	This file also allows the user to specify the nodes to reclaim from,
> +	via the 'nodes=' key, example::
> +
> +	  echo "1G nodes=0,1" > memory.reclaim
> +
> +	The above instructs the kernel to reclaim memory from nodes 0,1.
> +
>    memory.peak
>  	A read-only single value file which exists on non-root
>  	cgroups.
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b61e2007d156..f542c114dffd 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -419,7 +419,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  						  unsigned long nr_pages,
>  						  gfp_t gfp_mask,
> -						  unsigned int reclaim_options);
> +						  unsigned int reclaim_options,
> +						  nodemask_t nodemask);
>  extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  						gfp_t gfp_mask, bool noswap,
>  						pg_data_t *pgdat,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 23750cec0036..a0d7850173a9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -63,6 +63,7 @@
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
>  #include <linux/seq_buf.h>
> +#include <linux/parser.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -2392,7 +2393,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>  		psi_memstall_enter(&pflags);
>  		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
>  							gfp_mask,
> -							MEMCG_RECLAIM_MAY_SWAP);
> +							MEMCG_RECLAIM_MAY_SWAP,
> +							NODE_MASK_ALL);
>  		psi_memstall_leave(&pflags);
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
> @@ -2683,7 +2685,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>
>  	psi_memstall_enter(&pflags);
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> -						    gfp_mask, reclaim_options);
> +						    gfp_mask, reclaim_options,
> +						    NODE_MASK_ALL);
>  	psi_memstall_leave(&pflags);
>
>  	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> @@ -3503,7 +3506,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  		}
>
>  		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
> +					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
> +					NODE_MASK_ALL)) {
>  			ret = -EBUSY;
>  			break;
>  		}
> @@ -3614,7 +3618,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  			return -EINTR;
>
>  		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -						  MEMCG_RECLAIM_MAY_SWAP))
> +						  MEMCG_RECLAIM_MAY_SWAP,
> +						  NODE_MASK_ALL))
>  			nr_retries--;
>  	}
>
> @@ -6407,7 +6412,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  		}
>
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
> +					NODE_MASK_ALL);
>
>  		if (!reclaimed && !nr_retries--)
>  			break;
> @@ -6456,7 +6462,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>
>  		if (nr_reclaims) {
>  			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
> -					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
> +					NODE_MASK_ALL))
>  				nr_reclaims--;
>  			continue;
>  		}
> @@ -6579,21 +6586,54 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>
> +enum {
> +	MEMORY_RECLAIM_NODES = 0,
> +	MEMORY_RECLAIM_NULL,
> +};
> +
> +static const match_table_t if_tokens = {
> +	{ MEMORY_RECLAIM_NODES, "nodes=%s" },
> +	{ MEMORY_RECLAIM_NULL, NULL },
> +};
> +
>  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			      size_t nbytes, loff_t off)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>  	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>  	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> -	unsigned int reclaim_options;
> -	int err;
> +	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
> +				       MEMCG_RECLAIM_PROACTIVE;
> +	char *old_buf, *start;
> +	substring_t args[MAX_OPT_ARGS];
> +	int token;
> +	char value[256];
> +	nodemask_t nodemask = NODE_MASK_ALL;
>
>  	buf = strstrip(buf);
> -	err = page_counter_memparse(buf, "", &nr_to_reclaim);
> -	if (err)
> -		return err;
>
> -	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
> +	old_buf = buf;
> +	nr_to_reclaim = memparse(buf, &buf) / PAGE_SIZE;
> +	if (buf == old_buf)
> +		return -EINVAL;
> +
> +	buf = strstrip(buf);
> +
> +	while ((start = strsep(&buf, " ")) != NULL) {
> +		if (!strlen(start))
> +			continue;
> +		token = match_token(start, if_tokens, args);
> +		match_strlcpy(value, args, sizeof(value));

Per my understanding, we don't need to copy the string, because strsep()
has replaced " " with "\0".  Right?

Best Regards,
Huang, Ying

> +		switch (token) {
> +		case MEMORY_RECLAIM_NODES:
> +			if (nodelist_parse(value, nodemask) < 0)
> +				return -EINVAL;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
>  	while (nr_reclaimed < nr_to_reclaim) {
>  		unsigned long reclaimed;
>
> @@ -6610,7 +6650,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
>  						nr_to_reclaim - nr_reclaimed,
> -						GFP_KERNEL, reclaim_options);
> +						GFP_KERNEL, reclaim_options,
> +						nodemask);
>
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7b8e8e43806b..23fc5b523764 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   unsigned long nr_pages,
>  					   gfp_t gfp_mask,
> -					   unsigned int reclaim_options)
> +					   unsigned int reclaim_options,
> +					   nodemask_t nodemask)
>  {
>  	unsigned long nr_reclaimed;
>  	unsigned int noreclaim_flag;
> @@ -6750,6 +6751,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  		.may_unmap = 1,
>  		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>  		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +		.nodemask = &nodemask,
>  	};
>  	/*
>  	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> --
> 2.38.1.584.g0f3c55d4c2-goog
