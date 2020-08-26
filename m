Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AE0253124
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgHZOVk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgHZOVU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 10:21:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA4C061574
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:21:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t23so1482824qto.3
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9cipQfYQtv7cAiG+G38dpVGRbXrdKVedcuYm2vqWBLE=;
        b=r/aSAxJIwBhxZNYLfslR2WgJGk8qwXY7iEQclmhmk8/Z831e3QGoww9xiThSt0fEU1
         3PCNg6JDfrF1/obSDOg5HsFvZFIVHfQRu1wEC8OOFd01VUmXaBhZfoP40svMW802E1Tf
         3JM0RIrOw2BqmfIUSfn+mz+17yNzZAIeFBAzVEuU92gtGA0FhaBtdyMpFRnKxer1CMCB
         uRQRHSXbROCHtEjVH2hlrpYARZm43Cce7Ri3XnIpVGznmEarT4V3wLqHduh1Bx6VHn2P
         SpXJ+RpUhQnm0DVrncjQNiJ0vYYkEqEu1U1x+3Xu36kJKVEtOiBRhvf0vTaw+hdySoFf
         ns/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cipQfYQtv7cAiG+G38dpVGRbXrdKVedcuYm2vqWBLE=;
        b=CUTdXZXuDutPaJOBGjBADHo8SvgQh1WmsFhD3/W82jEYaZ7hh7G7/XWF8Xfigs8f9i
         LDgOU5Iu459h0nHbVhqvFkxEXRvozYPkmQ7QTgyGUAUe57EEQErVb8sUop2DefPaIqwa
         3/7U7FVLQ0s5lOEJLCehRbf4cBP4meqUvh+7cn8W4TUxpaOpmpQrZkSvbxjXPKYFKyNM
         0KOZBFUQj2I8MXIbtEhpfdm2NA+uGZDlDAn3IXLo2bXUsA0m5aA1nUCy/ofMW4XAv5gb
         nnqhM2PZkai3y3KRC5pnv6ze2M56hLUE2QJXLdy+9BDJ0xlrhCa21uJdRiXKI6t45wwC
         3Kuw==
X-Gm-Message-State: AOAM533PJeWE0GlC3nPGpt5N4TF9mk3fa2abQtctWfhsWPYjdVxQxVAu
        I9UflIV0Y+EWfk79YTEsnuAutg==
X-Google-Smtp-Source: ABdhPJzkL+VbMNqXk0VI6usc3IzWafauyYNT0NkD01Zs9u4SVmyMN6cWX67eat1DeaEj/WIGp5aZEg==
X-Received: by 2002:ac8:7156:: with SMTP id h22mr14460468qtp.36.1598451678946;
        Wed, 26 Aug 2020 07:21:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4a00])
        by smtp.gmail.com with ESMTPSA id x29sm1976087qtv.80.2020.08.26.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:21:17 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:20:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: Use find_get_swap_page in memcontrol
Message-ID: <20200826142002.GA988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-3-willy@infradead.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:44PM +0100, Matthew Wilcox (Oracle) wrote:
> The current code does not protect against swapoff of the underlying
> swap device, so this is a bug fix as well as a worthwhile reduction in
> code complexity.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memcontrol.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b807952b4d43..4075f214a841 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5539,35 +5539,14 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
>  static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
>  			unsigned long addr, pte_t ptent, swp_entry_t *entry)
>  {
> -	struct page *page = NULL;
> -	struct address_space *mapping;
> -	pgoff_t pgoff;
> -
>  	if (!vma->vm_file) /* anonymous vma */
>  		return NULL;
>  	if (!(mc.flags & MOVE_FILE))
>  		return NULL;
>  
> -	mapping = vma->vm_file->f_mapping;
> -	pgoff = linear_page_index(vma, addr);
> -
>  	/* page is moved even if it's not RSS of this task(page-faulted). */
> -#ifdef CONFIG_SWAP
> -	/* shmem/tmpfs may report page out on swap: account for that too. */
> -	if (shmem_mapping(mapping)) {
> -		page = find_get_entry(mapping, pgoff);
> -		if (xa_is_value(page)) {
> -			swp_entry_t swp = radix_to_swp_entry(page);
> -			*entry = swp;
> -			page = find_get_page(swap_address_space(swp),
> -					     swp_offset(swp));
> -		}
> -	} else
> -		page = find_get_page(mapping, pgoff);
> -#else
> -	page = find_get_page(mapping, pgoff);
> -#endif
> -	return page;
> +	return find_get_swap_page(vma->vm_file->f_mapping,
> +			linear_page_index(vma, addr));

The refactor makes sense to me, but the name is confusing. We're not
looking for a swap page, we're primarily looking for a file page in
the page cache mapping that's handed in. Only in the special case
where it's a shmem mapping and there is a swap entry do we consult the
auxiliary swap cache.

How about find_get_page_or_swapcache()? find_get_page_shmemswap()?
Maybe you have a better idea. It's a fairly specialized operation that
isn't widely used, so a longer name isn't a bad thing IMO.
