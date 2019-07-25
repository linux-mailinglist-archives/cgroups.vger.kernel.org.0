Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE14757BF
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfGYTVx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 15:21:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41969 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfGYTVx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 15:21:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so13167792pgg.8
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2019 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oGHvXz6QY8yyU12xNOnBNgRuqe7bQDmZ9acd6qSKLZE=;
        b=kNHq2tFmDFYrcObiMGAAoLyrW9UaAeMYDD95/2Rd2GDqqTVmw+Ld/zwO++rKmRklu4
         WBHKZmgJGCSesLgQl5X4MLkJCCSFME6/fh0kYpxCl4m3U4io6GbA1rlnfPPTuLd5Sh/n
         60BUKJREITr4LFmJYbvtrVKVnkMiBazqklw3YWDdbSXssonwgxy4SxYkKMLPPXE87aBi
         Lz6pTcspsNAnh4JHU93TSE5m+WzB85yNJ5emKZ7jEri0GpT2/fmtm2q7Kt+YWZDeXyGb
         jP7R+FYFWoFpzXsTAnAZGcNmHZbYX8lIJC/0Rbk7zFRMWNgLff8upK10WS1mwT/Nw5y4
         xA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oGHvXz6QY8yyU12xNOnBNgRuqe7bQDmZ9acd6qSKLZE=;
        b=FPaDlxNoXEzicbCR+C71LyTRO5pJRhZ9pARPxjNhMmF3zmBC6+9ntGS0KTOMk6clKZ
         UEGq9VSj3NQwOd+B3FpLXlvtrtePo4/7j/yV+sDPiD3gMe3OA5D68ECIVWNqpe8zpXOS
         aMK9q5nLTC0gwvTbqmRQljMTokURqQFc1vfyv6UY4UjIxgE2t5yNvFTkDJbGiLi7terB
         5m2vUaEWKB/toOJpxtUiZSpx5fudAK4by2LJsIJ2H5jV6vpaMLsLiSN8dOOHqPnRGfKJ
         mmh8krhbfBVf2X4IshFhgcnENXnuuXpaCpdxvq7zrBvib4oW9A3pNeA3C5uz8O/TlWGa
         pHrg==
X-Gm-Message-State: APjAAAVcwEBEIe6NmKzS+ayoy4StL8g4z50bp1z88uQ2wvHD4WQx/7Lh
        wbVUYqAaNjpYRtBmIbNI4QE=
X-Google-Smtp-Source: APXvYqyMXS3EBHKLpBkNJXf0uLU2EFCslZc/j9gnfUngwQoFUg2Y3Jpiz/S7Zdc2EgO4uC8pXfF00w==
X-Received: by 2002:a63:188:: with SMTP id 130mr86429952pgb.231.1564082512055;
        Thu, 25 Jul 2019 12:21:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:4ca3])
        by smtp.gmail.com with ESMTPSA id z63sm18174440pfb.98.2019.07.25.12.21.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 12:21:51 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:21:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     miles.chen@mediatek.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH] mm: memcontrol: fix use after free in
 mem_cgroup_iter()
Message-ID: <20190725192149.GA24234@cmpxchg.org>
References: <20190725142703.27276-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725142703.27276-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 25, 2019 at 10:27:03PM +0800, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> This RFC patch is sent to report an use after free in mem_cgroup_iter()
> after merging commit: be2657752e9e "mm: memcg: fix use after free in
> mem_cgroup_iter()".
> 
> I work with android kernel tree (4.9 & 4.14), and the commit:
> be2657752e9e "mm: memcg: fix use after free in mem_cgroup_iter()" has
> been merged to the trees. However, I can still observe use after free
> issues addressed in the commit be2657752e9e.
> (on low-end devices, a few times this month)
> 
> backtrace:
> 	css_tryget <- crash here
> 	mem_cgroup_iter
> 	shrink_node
> 	shrink_zones
> 	do_try_to_free_pages
> 	try_to_free_pages
> 	__perform_reclaim
> 	__alloc_pages_direct_reclaim
> 	__alloc_pages_slowpath
> 	__alloc_pages_nodemask
> 
> To debug, I poisoned mem_cgroup before freeing it:
> 
> static void __mem_cgroup_free(struct mem_cgroup *memcg)
> 	for_each_node(node)
> 	free_mem_cgroup_per_node_info(memcg, node);
> 	free_percpu(memcg->stat);
> +       /* poison memcg before freeing it */
> +       memset(memcg, 0x78, sizeof(struct mem_cgroup));
> 	kfree(memcg);
> }
> 
> The coredump shows the position=0xdbbc2a00 is freed.
> 
> (gdb) p/x ((struct mem_cgroup_per_node *)0xe5009e00)->iter[8]
> $13 = {position = 0xdbbc2a00, generation = 0x2efd}
> 
> 0xdbbc2a00:     0xdbbc2e00      0x00000000      0xdbbc2800      0x00000100
> 0xdbbc2a10:     0x00000200      0x78787878      0x00026218      0x00000000
> 0xdbbc2a20:     0xdcad6000      0x00000001      0x78787800      0x00000000
> 0xdbbc2a30:     0x78780000      0x00000000      0x0068fb84      0x78787878
> 0xdbbc2a40:     0x78787878      0x78787878      0x78787878      0xe3fa5cc0
> 0xdbbc2a50:     0x78787878      0x78787878      0x00000000      0x00000000
> 0xdbbc2a60:     0x00000000      0x00000000      0x00000000      0x00000000
> 0xdbbc2a70:     0x00000000      0x00000000      0x00000000      0x00000000
> 0xdbbc2a80:     0x00000000      0x00000000      0x00000000      0x00000000
> 0xdbbc2a90:     0x00000001      0x00000000      0x00000000      0x00100000
> 0xdbbc2aa0:     0x00000001      0xdbbc2ac8      0x00000000      0x00000000
> 0xdbbc2ab0:     0x00000000      0x00000000      0x00000000      0x00000000
> 0xdbbc2ac0:     0x00000000      0x00000000      0xe5b02618      0x00001000
> 0xdbbc2ad0:     0x00000000      0x78787878      0x78787878      0x78787878
> 0xdbbc2ae0:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2af0:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b00:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b10:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b20:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b30:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b40:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b50:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b60:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b70:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2b80:     0x78787878      0x78787878      0x00000000      0x78787878
> 0xdbbc2b90:     0x78787878      0x78787878      0x78787878      0x78787878
> 0xdbbc2ba0:     0x78787878      0x78787878      0x78787878      0x78787878
> 
> In the reclaim path, try_to_free_pages() does not setup
> sc.target_mem_cgroup and sc is passed to do_try_to_free_pages(), ...,
> shrink_node().
> 
> In mem_cgroup_iter(), root is set to root_mem_cgroup because
> sc->target_mem_cgroup is NULL.
> It is possible to assign a memcg to root_mem_cgroup.nodeinfo.iter in
> mem_cgroup_iter().
> 
> 	try_to_free_pages
> 		struct scan_control sc = {...}, target_mem_cgroup is 0x0;
> 	do_try_to_free_pages
> 	shrink_zones
> 	shrink_node
> 		 mem_cgroup *root = sc->target_mem_cgroup;
> 		 memcg = mem_cgroup_iter(root, NULL, &reclaim);
> 	mem_cgroup_iter()
> 		if (!root)
> 			root = root_mem_cgroup;
> 		...
> 
> 		css = css_next_descendant_pre(css, &root->css);
> 		memcg = mem_cgroup_from_css(css);
> 		cmpxchg(&iter->position, pos, memcg);
> 
> My device uses memcg non-hierarchical mode.
> When we release a memcg: invalidate_reclaim_iterators() reaches only
> dead_memcg and its parents. If non-hierarchical mode is used,
> invalidate_reclaim_iterators() never reaches root_mem_cgroup.
> 
> static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> {
> 	struct mem_cgroup *memcg = dead_memcg;
> 
> 	for (; memcg; memcg = parent_mem_cgroup(memcg)
> 	...
> }
> 
> So the use after free scenario looks like:
> 
> CPU1						CPU2
> 
> try_to_free_pages
> do_try_to_free_pages
> shrink_zones
> shrink_node
> mem_cgroup_iter()
>     if (!root)
>     	root = root_mem_cgroup;
>     ...
>     css = css_next_descendant_pre(css, &root->css);
>     memcg = mem_cgroup_from_css(css);
>     cmpxchg(&iter->position, pos, memcg);
> 
> 					invalidate_reclaim_iterators(memcg);
> 					...
> 					__mem_cgroup_free()
> 						kfree(memcg);
> 
> try_to_free_pages
> do_try_to_free_pages
> shrink_zones
> shrink_node
> mem_cgroup_iter()
>     if (!root)
>     	root = root_mem_cgroup;
>     ...
>     mz = mem_cgroup_nodeinfo(root, reclaim->pgdat->node_id);
>     iter = &mz->iter[reclaim->priority];
>     pos = READ_ONCE(iter->position);
>     css_tryget(&pos->css) <- use after free
> 
> To avoid this, we should also invalidate root_mem_cgroup.nodeinfo.iter in
> invalidate_reclaim_iterators().
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This looks good to me, but please add a comment that documents why you
need to handle root_mem_cgroup separately:

> +static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> +{
> +	struct mem_cgroup *memcg = dead_memcg;
> +	int invalid_root = 0;
> +
> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> +		__invalidate_reclaim_iterators(memcg, dead_memcg);
> +		if (memcg == root_mem_cgroup)
> +			invalid_root = 1;
> +	}
> +
> +	if (!invalid_root)
> +		__invalidate_reclaim_iterators(root_mem_cgroup, dead_memcg);

^ This block should have a comment that mentions that non-hierarchy
mode in cgroup1 means that parent_mem_cgroup doesn't walk all the way
up to the cgroup root.
