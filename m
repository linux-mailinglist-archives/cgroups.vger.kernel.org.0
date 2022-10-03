Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D989D5F2BD5
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 10:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJCIbV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJCIa7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 04:30:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1D2AEF;
        Mon,  3 Oct 2022 01:03:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CF0521981;
        Mon,  3 Oct 2022 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664783912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0W/orMGDszrbG870Kbie6WQX0dTaRilbBx3yXyCdt4=;
        b=Pgv831AuqqOIVIh9rq+eja+PfJIma+3j0scQ+PU2C6+NX1x14TZyq7XkUeyPPE/3gbZYzd
        Gr7nHR7zc9ee1GCSyQPQPsTJ8psik1Go2p01at/LtN1+xxojKLHmnvGJgPTqVF6UcZ41H8
        rPgQZmpeMSgzTdug5xwK6qIiFSyizbU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EE9E1332F;
        Mon,  3 Oct 2022 07:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iyBKBSiWOmO6UwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 03 Oct 2022 07:58:32 +0000
Date:   Mon, 3 Oct 2022 09:58:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: use mem_cgroup_is_root() helper
Message-ID: <YzqWJ8D1rabeZ6TL@dhcp22.suse.cz>
References: <20220930134433.338103-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930134433.338103-1-kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 30-09-22 19:14:33, Kamalesh Babulal wrote:
> Replace the checks for memcg is root memcg, with mem_cgroup_is_root()
> helper.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b69979c9ced5..99b3d0cbd426 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1148,7 +1148,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
>  	 * cgroup root (root_mem_cgroup). So we have to handle
>  	 * dead_memcg from cgroup root separately.
>  	 */
> -	if (last != root_mem_cgroup)
> +	if (!mem_cgroup_is_root(last))
>  		__invalidate_reclaim_iterators(root_mem_cgroup,
>  						dead_memcg);
>  }
> @@ -1172,7 +1172,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  	struct mem_cgroup *iter;
>  	int ret = 0;
>  
> -	BUG_ON(memcg == root_mem_cgroup);
> +	BUG_ON(mem_cgroup_is_root(memcg));
>  
>  	for_each_mem_cgroup_tree(iter, memcg) {
>  		struct css_task_iter it;
> @@ -1201,7 +1201,7 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>  	memcg = folio_memcg(folio);
>  
>  	if (!memcg)
> -		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
> +		VM_BUG_ON_FOLIO(!mem_cgroup_is_root(lruvec_memcg(lruvec)), folio);
>  	else
>  		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
>  }
> @@ -1982,7 +1982,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  	rcu_read_lock();
>  
>  	memcg = mem_cgroup_from_task(victim);
> -	if (memcg == root_mem_cgroup)
> +	if (mem_cgroup_is_root(memcg))
>  		goto out;
>  
>  	/*
> @@ -2940,7 +2940,7 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg = NULL;
>  
> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>  		objcg = rcu_dereference(memcg->objcg);
>  		if (objcg && obj_cgroup_tryget(objcg))
>  			break;
> @@ -7073,7 +7073,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_task(current);
> -	if (memcg == root_mem_cgroup)
> +	if (mem_cgroup_is_root(memcg))
>  		goto out;
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
>  		goto out;
> @@ -7208,7 +7208,7 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>  		 * The root cgroup cannot be destroyed, so it's refcount must
>  		 * always be >= 1.
>  		 */
> -		if (WARN_ON_ONCE(memcg == root_mem_cgroup)) {
> +		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
>  			VM_BUG_ON(1);
>  			break;
>  		}
> @@ -7369,7 +7369,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  
>  	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return nr_swap_pages;
> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
>  		nr_swap_pages = min_t(long, nr_swap_pages,
>  				      READ_ONCE(memcg->swap.max) -
>  				      page_counter_read(&memcg->swap));
> @@ -7391,7 +7391,7 @@ bool mem_cgroup_swap_full(struct page *page)
>  	if (!memcg)
>  		return false;
>  
> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>  		unsigned long usage = page_counter_read(&memcg->swap);
>  
>  		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
> @@ -7556,7 +7556,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  		return true;
>  
>  	original_memcg = get_mem_cgroup_from_objcg(objcg);
> -	for (memcg = original_memcg; memcg != root_mem_cgroup;
> +	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
>  	     memcg = parent_mem_cgroup(memcg)) {
>  		unsigned long max = READ_ONCE(memcg->zswap_max);
>  		unsigned long pages;
> 
> base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
> -- 
> 2.34.3

-- 
Michal Hocko
SUSE Labs
