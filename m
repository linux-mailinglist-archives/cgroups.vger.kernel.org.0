Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094C5F5612
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJEOEJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJEOEI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 10:04:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E06CF75
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 07:04:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id hh9so1554340qtb.13
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FXi0XoAQOBYrGesfkJtJr1D/6fSwUi+ciVYcxjp3MmE=;
        b=mJHIld8cSRSCYaAW4MMM2N5yWGRlbk2nS1p0K7//H9ccXyb44BcbTd5JtB+mm91SHc
         vj4bKWYfab3HIaX1/tARDmcGIzlgnXluW22totZD2rYJHXsO53Ld0KGtv4vDjlHyvPgc
         3h+0Z0GJG709ND7TPCiWA8Jl0OKqaVCJXUu5rLUK7hIrff6saZStgRN01tRn/upSvqRY
         ZLTSDrP0oEm9eagXypT89rzH+C0lLbywPuE/sIzA157xwrOa2+dK8MGvO2cNgJfGKkGy
         MIqr4F3cSF0X2KflYeEwEBag+4GX52eT00MimlhMUH8EdhC7N2gXHX8jIa2e/AqbJ7rb
         zDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FXi0XoAQOBYrGesfkJtJr1D/6fSwUi+ciVYcxjp3MmE=;
        b=SzdMB1n1d/VuKVwThzPIcbxPpfr5u+CUlV2eWhA5SWB3N9LUlZlnG+lNrwfasH+2ZQ
         SS2n6zaAlO5lUKneCmLKgLfx+Eukp2mSa48RRncZsWEapNW8izfcIJ/59E5FkSfi4d3w
         PytMUgdMynpGnifgnM3X0nzc6xtIfTa53nOmkjtBq6jaPfOceJu06b6i2bJqXKUb5/Yd
         vELTMYBLfjvjLDfYmROw3b5K6HLRurJisbOwFzISmZC2V8AH5E8KIZH6pZRlSk9a61fy
         roMBPIT/jTj3lopS6tx1pyH4QiWCaA1yfr7iNtfD4kowSDeotUwVJp7AvQf45vSEF6HJ
         8Q6g==
X-Gm-Message-State: ACrzQf37bglIOc4Kvmn7t41pwdr1/AjwSkincTxwI6/kp1dLUoRl4JfL
        BdGS6uyQ/g1mNFP/5Ra6fr0zzQ==
X-Google-Smtp-Source: AMsMyM7lJxCMUao8hqwiJsKbtmbmGv/p79yHVubsvJEB+tYhpAuTKmk+hxrJ0RZRC7ZS8teDJzoHFw==
X-Received: by 2002:a05:622a:1111:b0:35c:b860:8468 with SMTP id e17-20020a05622a111100b0035cb8608468mr23640504qty.141.1664978646396;
        Wed, 05 Oct 2022 07:04:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::282f])
        by smtp.gmail.com with ESMTPSA id g12-20020a05620a40cc00b006ce3f1af120sm8634629qko.44.2022.10.05.07.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:04:05 -0700 (PDT)
Date:   Wed, 5 Oct 2022 10:04:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/vmscan: check references from all memcgs for
 swapbacked memory
Message-ID: <Yz2O1dGeBGBTh6SM@cmpxchg.org>
References: <20221004233446.787056-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004233446.787056-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yosry,

On Tue, Oct 04, 2022 at 11:34:46PM +0000, Yosry Ahmed wrote:
> During page/folio reclaim, we check folio is referenced using
> folio_referenced() to avoid reclaiming folios that have been recently
> accessed (hot memory). The ratinale is that this memory is likely to be
> accessed soon, and hence reclaiming it will cause a refault.
> 
> For memcg reclaim, we pass in sc->target_mem_cgroup to
> folio_referenced(), which means we only check accesses to the folio
> from processes in the subtree of the target memcg. This behavior was
> originally introduced by commit bed7161a519a ("Memory controller: make
> page_referenced() cgroup aware") a long time ago. Back then, refaulted
> pages would get charged to the memcg of the process that was faulting them
> in. It made sense to only consider accesses coming from processes in the
> subtree of target_mem_cgroup. If a page was charged to memcg A but only
> being accessed by a sibling memcg B, we would reclaim it if memcg A is
> under pressure. memcg B can then fault it back in and get charged for it
> appropriately.
> 
> Today, this behavior still makes sense for file pages. However, unlike
> file pages, when swapbacked pages are refaulted they are charged to the
> memcg that was originally charged for them during swapout. Which
> means that if a swapbacked page is charged to memcg A but only used by
> memcg B, and we reclaim it when memcg A is under pressure, it would
> simply be faulted back in and charged again to memcg A once memcg B
> accesses it. In that sense, accesses from all memcgs matter equally when
> considering if a swapbacked page/folio is a viable reclaim target.
> 
> Add folio_referenced_memcg() which decides what memcg we should pass to
> folio_referenced() based on the folio type, and includes an elaborate
> comment about why we should do so. This should help reclaim make better
> decision and reduce refaults when reclaiming swapbacked memory that is
> used by multiple memcgs.

Great observation, and I agree with this change.

Just one nitpick:

> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/vmscan.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c5a4bff11da6..f9fa0f9287e5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1443,14 +1443,43 @@ enum folio_references {
>  	FOLIOREF_ACTIVATE,
>  };
>  
> +/* What memcg should we pass to folio_referenced()? */
> +static struct mem_cgroup *folio_referenced_memcg(struct folio *folio,
> +						 struct mem_cgroup *target_memcg)
> +{
> +	/*
> +	 * We check references to folios to make sure we don't reclaim hot
> +	 * folios that are likely to be refaulted soon. We pass a memcg to
> +	 * folio_referenced() to only check references coming from processes in
> +	 * that memcg's subtree.
> +	 *
> +	 * For file folios, we only consider references from processes in the
> +	 * subtree of the target memcg. If a folio is charged to
> +	 * memcg A but is only referenced by processes in memcg B, we reclaim it
> +	 * if memcg A is under pressure. If it is later accessed by memcg B it
> +	 * will be faulted back in and charged to memcg B. For memcg A, this is
> +	 * called memory that should be reclaimed.
> +	 *
> +	 * On the other hand, when swapbacked folios are faulted in, they get
> +	 * charged to the memcg that was originally charged for them at the time
> +	 * of swapping out. This means that if a folio that is charged to
> +	 * memcg A gets swapped out, it will get charged back to A when *any*
> +	 * memcg accesses it. In that sense, we need to consider references from
> +	 * *all* processes when considering whether to reclaim a swapbacked
> +	 * folio.
> +	 */
> +	return folio_test_swapbacked(folio) ? NULL : target_memcg;
> +}
> +
>  static enum folio_references folio_check_references(struct folio *folio,
>  						  struct scan_control *sc)
>  {
>  	int referenced_ptes, referenced_folio;
>  	unsigned long vm_flags;
> +	struct mem_cgroup *memcg = folio_referenced_memcg(folio,
> +						sc->target_mem_cgroup);
>  
> -	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
> -					   &vm_flags);
> +	referenced_ptes = folio_referenced(folio, 1, memcg, &vm_flags);
>  	referenced_folio = folio_test_clear_referenced(folio);
>  
>  	/*
> @@ -2581,6 +2610,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  
>  	while (!list_empty(&l_hold)) {
>  		struct folio *folio;
> +		struct mem_cgroup *memcg;
>  
>  		cond_resched();
>  		folio = lru_to_folio(&l_hold);
> @@ -2600,8 +2630,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  		}
>  
>  		/* Referenced or rmap lock contention: rotate */
> -		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> -				     &vm_flags) != 0) {
> +		memcg = folio_referenced_memcg(folio, sc->target_mem_cgroup);
> +		if (folio_referenced(folio, 0, memcg, &vm_flags) != 0) {

Would you mind moving this to folio_referenced() directly? There is
already a comment and branch in there that IMO would extend quite
naturally to cover the new exception:

	/*
	 * If we are reclaiming on behalf of a cgroup, skip
	 * counting on behalf of references from different
	 * cgroups
	 */
	if (memcg) {
		rwc.invalid_vma = invalid_folio_referenced_vma;
	}

That would keep the decision-making and doc in one place.

Thanks!
Johannnes
