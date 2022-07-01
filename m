Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7245563CAE
	for <lists+cgroups@lfdr.de>; Sat,  2 Jul 2022 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGAXJx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 19:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiGAXJv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 19:09:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6871BF1;
        Fri,  1 Jul 2022 16:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B67BFB8321E;
        Fri,  1 Jul 2022 23:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD699C3411E;
        Fri,  1 Jul 2022 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656716988;
        bh=4nB0U7nhrm6VCb6tiMM+/XZLx4kueqSVr4+hr+wiTWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rmqt7SRzy8UX3MGyyYcpwqkGOOwD33znN26rtMMJE+WjxrfG547paZYOkVmgLGK9q
         TyB8p5PrTf2zhjjJ5CluZBO1gEbEy5bjSrvfrE1fuoPBqUQYBA+TsHzmrG10wW8xM9
         Q9oNEUhltPuJzvreon2BKDVDd1L6udVESo8+Wnf4=
Date:   Fri, 1 Jul 2022 16:09:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
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
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: vmpressure: don't count proactive reclaim in
 vmpressure
Message-Id: <20220701160947.e4902e5b0484ed084db5d41f@linux-foundation.org>
In-Reply-To: <20220630083044.997474-1-yosryahmed@google.com>
References: <20220630083044.997474-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 30 Jun 2022 08:30:44 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> vmpressure is used in cgroup v1 to notify userspace of reclaim
> efficiency events, and is also used in both cgroup v1 and v2 as a signal
> for memory pressure for networking, see
> mem_cgroup_under_socket_pressure().
> 
> Proactive reclaim intends to probe memcgs for cold memory, without
> affecting their performance. Hence, reclaim caused by writing to
> memory.reclaim should not trigger vmpressure.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2319,6 +2319,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>  				  gfp_t gfp_mask)
>  {
>  	unsigned long nr_reclaimed = 0;
> +	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  
>  	do {
>  		unsigned long pflags;
> @@ -2331,7 +2332,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>  
>  		psi_memstall_enter(&pflags);
>  		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
> -							     gfp_mask, true);
> +							     gfp_mask,
> +							     reclaim_options);

It's a bit irksome to create all these unneeded local variables.  Why
not simply add the constant arg to the try_to_free_mem_cgroup_pages()
call?

>  		psi_memstall_leave(&pflags);
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
> @@ -2576,7 +2578,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	struct page_counter *counter;
>  	unsigned long nr_reclaimed;
>  	bool passed_oom = false;
> -	bool may_swap = true;
> +	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  	bool drained = false;
>  	unsigned long pflags;
>  
> @@ -2593,7 +2595,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		mem_over_limit = mem_cgroup_from_counter(counter, memory);
>  	} else {
>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> -		may_swap = false;
> +		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;

	reclaim_options = 0

would be clearer?


