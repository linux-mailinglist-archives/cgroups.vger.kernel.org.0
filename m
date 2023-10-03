Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C655C7B6846
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 13:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjJCLuJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 07:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJCLuI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 07:50:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A19A3;
        Tue,  3 Oct 2023 04:50:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7ED931F893;
        Tue,  3 Oct 2023 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696333802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qfhBTjtqZ1w+rEZSeLMsz30Wmz7KFxJaJmOo6kihjq8=;
        b=lG3T7cPF94enFMo7dJXXGhFEIumBrGIKh1kJNwPUkk2GvNjZFgO2dFLZQ2FZFgK07D07D9
        1wT7sIzJH7pMG4V6Ln7ip2CHtX484aS6dnTElPoScUbd7bZgwBLpJzsvae5BpDjNLVVA/q
        SSxDF9kaw2+Kmf/KSVPpF6CFUgkMWxI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ED2F139F9;
        Tue,  3 Oct 2023 11:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Ii9Eur/G2V0CgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Oct 2023 11:50:02 +0000
Date:   Tue, 3 Oct 2023 13:50:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 1/3] memcontrol: add helpers for hugetlb memcg
 accounting
Message-ID: <ZRv/6aKEDJGGIeyq@dhcp22.suse.cz>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003001828.2554080-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-10-23 17:18:26, Nhat Pham wrote:
> This patch exposes charge committing and cancelling as parts of the
> memory controller interface. These functionalities are useful when the
> try_charge() and commit_charge() stages have to be separated by other
> actions in between (which can fail). One such example is the new hugetlb
> accounting behavior in the following patch.
> 
> The patch also adds a helper function to obtain a reference to the
> current task's memcg.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

OK, makes sense.
Acked-by: Michal Hocko <mhocko@suse.com>

Usually we prefer to have newly introduced functions along with their
users but I do understand that this split just makes it easier to review
the main patch for the feature.

> ---
>  include/linux/memcontrol.h | 21 ++++++++++++++
>  mm/memcontrol.c            | 59 ++++++++++++++++++++++++++++++--------
>  2 files changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e0cfab58ab71..42bf7e9b1a2f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -653,6 +653,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
>  		page_counter_read(&memcg->memory);
>  }
>  
> +void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
> +
>  int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
>  
>  /**
> @@ -704,6 +706,8 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
>  	__mem_cgroup_uncharge_list(page_list);
>  }
>  
> +void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
> +
>  void mem_cgroup_migrate(struct folio *old, struct folio *new);
>  
>  /**
> @@ -760,6 +764,8 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>  
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
>  
> +struct mem_cgroup *get_mem_cgroup_from_current(void);
> +
>  struct lruvec *folio_lruvec_lock(struct folio *folio);
>  struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
>  struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
> @@ -1245,6 +1251,11 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
>  	return false;
>  }
>  
> +static inline void mem_cgroup_commit_charge(struct folio *folio,
> +		struct mem_cgroup *memcg)
> +{
> +}
> +
>  static inline int mem_cgroup_charge(struct folio *folio,
>  		struct mm_struct *mm, gfp_t gfp)
>  {
> @@ -1269,6 +1280,11 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
>  {
>  }
>  
> +static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
> +		unsigned int nr_pages)
> +{
> +}
> +
>  static inline void mem_cgroup_migrate(struct folio *old, struct folio *new)
>  {
>  }
> @@ -1306,6 +1322,11 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  	return NULL;
>  }
>  
> +static inline struct mem_cgroup *get_mem_cgroup_from_current(void)
> +{
> +	return NULL;
> +}
> +
>  static inline
>  struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d1a322a75172..0219befeae38 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1086,6 +1086,27 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>  
> +/**
> + * get_mem_cgroup_from_current - Obtain a reference on current task's memcg.
> + */
> +struct mem_cgroup *get_mem_cgroup_from_current(void)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +
> +again:
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_task(current);
> +	if (!css_tryget(&memcg->css)) {
> +		rcu_read_unlock();
> +		goto again;
> +	}
> +	rcu_read_unlock();
> +	return memcg;
> +}
> +
>  static __always_inline bool memcg_kmem_bypass(void)
>  {
>  	/* Allow remote memcg charging from any context. */
> @@ -2873,7 +2894,12 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return try_charge_memcg(memcg, gfp_mask, nr_pages);
>  }
>  
> -static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
> +/**
> + * mem_cgroup_cancel_charge() - cancel an uncommitted try_charge() call.
> + * @memcg: memcg previously charged.
> + * @nr_pages: number of pages previously charged.
> + */
> +void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	if (mem_cgroup_is_root(memcg))
>  		return;
> @@ -2898,6 +2924,22 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  	folio->memcg_data = (unsigned long)memcg;
>  }
>  
> +/**
> + * mem_cgroup_commit_charge - commit a previously successful try_charge().
> + * @folio: folio to commit the charge to.
> + * @memcg: memcg previously charged.
> + */
> +void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
> +{
> +	css_get(&memcg->css);
> +	commit_charge(folio, memcg);
> +
> +	local_irq_disable();
> +	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
> +	memcg_check_events(memcg, folio_nid(folio));
> +	local_irq_enable();
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  /*
>   * The allocated objcg pointers array is not accounted directly.
> @@ -6105,7 +6147,7 @@ static void __mem_cgroup_clear_mc(void)
>  
>  	/* we must uncharge all the leftover precharges from mc.to */
>  	if (mc.precharge) {
> -		cancel_charge(mc.to, mc.precharge);
> +		mem_cgroup_cancel_charge(mc.to, mc.precharge);
>  		mc.precharge = 0;
>  	}
>  	/*
> @@ -6113,7 +6155,7 @@ static void __mem_cgroup_clear_mc(void)
>  	 * we must uncharge here.
>  	 */
>  	if (mc.moved_charge) {
> -		cancel_charge(mc.from, mc.moved_charge);
> +		mem_cgroup_cancel_charge(mc.from, mc.moved_charge);
>  		mc.moved_charge = 0;
>  	}
>  	/* we must fixup refcnts and charges */
> @@ -7020,20 +7062,13 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>  			gfp_t gfp)
>  {
> -	long nr_pages = folio_nr_pages(folio);
>  	int ret;
>  
> -	ret = try_charge(memcg, gfp, nr_pages);
> +	ret = try_charge(memcg, gfp, folio_nr_pages(folio));
>  	if (ret)
>  		goto out;
>  
> -	css_get(&memcg->css);
> -	commit_charge(folio, memcg);
> -
> -	local_irq_disable();
> -	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, folio_nid(folio));
> -	local_irq_enable();
> +	mem_cgroup_commit_charge(folio, memcg);
>  out:
>  	return ret;
>  }
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
