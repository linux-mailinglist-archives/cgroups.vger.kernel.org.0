Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350D3637239
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 07:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKXGDr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 01:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKXGDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 01:03:15 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114B5F844
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 22:03:05 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s4so550100qtx.6
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 22:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJy6vszDoCp46m3JopX1uY8udZeM6fOcw9P3JKhadjs=;
        b=Jvzn8i+eto9wT02o0N73tnQsoWxjvcrnnCDN3aoRmc4emsUiyBKr3H6Z30JhGymYbs
         AtGemDi/cBgL5d0zDL61lbDsKrqtZoU3ejVPDXCDbMgzQSNsmXeETIHc8vIYYW6gfHJo
         WwmU5DEsQ/oG2uW5eERRdx9E3hCK6Y1AC3M4HRiJcBIXnDBCmHRLRGuVAvPTOXRMf96v
         emKKyJRjUx9QDIltDC8iL9MONtVrzo00/xAEoX+MbGdVDPje5IjmaU+aTeOhqyy9Ko8g
         83eFsLblUIj6MpwruchSm+bgXDu1HEPjM2Wxfqztj34UzGT3N0RuaJk3ZFiOG1506/xd
         ky+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJy6vszDoCp46m3JopX1uY8udZeM6fOcw9P3JKhadjs=;
        b=Ye0yxOGkFVu/puJROjo6tXDSH//VV4uNmqCGDEZzdi/JBf6XtybnS9dIvJc4h/tsi8
         ChYGDQF78ZsRQhniBq9ycrrr3PBnqAYNBKYOUR7HvUBXuAVmulPfclnvKd5LGL/A404l
         cyNebllntOXF5ruu9aW1OTI73WdW88lCKcMTMeqYLMy9vmtCL6bnj0isb3tad8oXsHrn
         NK+OLliB8LyrIUFbOc2MYyrXPnbMyqDufhH70tlqw3Kc8NWDIebFqhljgGdLujfICBPt
         RqdIkPgy39yaxh2z+D0EZeNBcfoLkCRxh7fpBph5K8n1hpo1vSZam1i0jbOBmn8o6pmQ
         VX2Q==
X-Gm-Message-State: ANoB5pkYOVMpXKAQfoEZpCI6CyxaqlOtDWeqG+0Wa/YTYtk7jbR11Mj6
        MzzG4JY7sO/+1Wh4ceTN9IBZJRA1CAbraw==
X-Google-Smtp-Source: AA0mqf5smS7eoF6TMtyvNccYdWE/pQH9AIZMl3YnHwgT/NCCQ0QiGIaFm6+XMemAUMwsqQWO/ufOvQ==
X-Received: by 2002:a05:622a:4d0f:b0:3a5:25d4:2f2c with SMTP id fd15-20020a05622a4d0f00b003a525d42f2cmr13194152qtb.112.1669269783513;
        Wed, 23 Nov 2022 22:03:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a2a1600b006eeb3165554sm351606qkp.19.2022.11.23.22.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 22:03:02 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:03:00 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
In-Reply-To: <20221123181838.1373440-1-hannes@cmpxchg.org>
Message-ID: <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 23 Nov 2022, Johannes Weiner wrote:

> rmap changes (mapping and unmapping) of a page currently take
> lock_page_memcg() to serialize 1) update of the mapcount and the
> cgroup mapped counter with 2) cgroup moving the page and updating the
> old cgroup and the new cgroup counters based on page_mapped().
> 
> Before b2052564e66d ("mm: memcontrol: continue cache reclaim from
> offlined groups"), we used to reassign all pages that could be found
> on a cgroup's LRU list on deletion - something that rmap didn't
> naturally serialize against. Since that commit, however, the only
> pages that get moved are those mapped into page tables of a task
> that's being migrated. In that case, the pte lock is always held (and
> we know the page is mapped), which keeps rmap changes at bay already.
> 
> The additional lock_page_memcg() by rmap is redundant. Remove it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thank you, I love it: but with sorrow and shame, NAK to this version.

I was gearing up to rush in the crash fix at the bottom, when testing
showed that the new VM_WARN_ON_ONCE(!folio_mapped(folio)) actually hits.

So I've asked Stephen to drop this mm-unstable commit from -next for
tonight, while we think about what more is needed.

I was disbelieving when I saw the warning, couldn't understand at all.
But a look at get_mctgt_type() shatters my illusion: it's doesn't just
return a page for pte_present(ptent), it goes off looking up swap
cache and page cache; plus I've no idea whether an MC_TARGET_DEVICE
page would appear as folio_mapped() or not.

Does that mean that we just have to reinstate the folio_mapped() checks
in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
commit?  Or does it invalidate the whole project to remove
lock_page_memcg() from mm/rmap.c?

Too disappointed to think about it more tonight :-(
Hugh


> ---
>  mm/memcontrol.c | 35 ++++++++++++++++++++---------------
>  mm/rmap.c       | 12 ------------
>  2 files changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 23750cec0036..52b86ca7a78e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5676,7 +5676,10 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
>   * @from: mem_cgroup which the page is moved from.
>   * @to:	mem_cgroup which the page is moved to. @from != @to.
>   *
> - * The caller must make sure the page is not on LRU (isolate_page() is useful.)
> + * This function acquires folio_lock() and folio_lock_memcg(). The
> + * caller must exclude all other possible ways of accessing
> + * page->memcg, such as LRU isolation (to lock out isolation) and
> + * having the page mapped and pte-locked (to lock out rmap).
>   *
>   * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
>   * from old cgroup.
> @@ -5696,6 +5699,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  	VM_BUG_ON(compound && !folio_test_large(folio));
>  
> +	/*
> +	 * We're only moving pages mapped into the moving process's
> +	 * page tables. The caller's pte lock prevents rmap from
> +	 * removing the NR_x_MAPPED state while we transfer it.
> +	 */
> +	VM_WARN_ON_ONCE(!folio_mapped(folio));
> +
>  	/*
>  	 * Prevent mem_cgroup_migrate() from looking at
>  	 * page's memory cgroup of its source page while we change it.
> @@ -5715,30 +5725,25 @@ static int mem_cgroup_move_account(struct page *page,
>  	folio_memcg_lock(folio);
>  
>  	if (folio_test_anon(folio)) {
> -		if (folio_mapped(folio)) {
> -			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> -			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> -			if (folio_test_transhuge(folio)) {
> -				__mod_lruvec_state(from_vec, NR_ANON_THPS,
> -						   -nr_pages);
> -				__mod_lruvec_state(to_vec, NR_ANON_THPS,
> -						   nr_pages);
> -			}
> +		__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> +
> +		if (folio_test_transhuge(folio)) {
> +			__mod_lruvec_state(from_vec, NR_ANON_THPS, -nr_pages);
> +			__mod_lruvec_state(to_vec, NR_ANON_THPS, nr_pages);
>  		}
>  	} else {
>  		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
>  		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
>  
> +		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
> +
>  		if (folio_test_swapbacked(folio)) {
>  			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
>  			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
>  		}
>  
> -		if (folio_mapped(folio)) {
> -			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
> -			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
> -		}
> -
>  		if (folio_test_dirty(folio)) {
>  			struct address_space *mapping = folio_mapping(folio);
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 459dc1c44d8a..11a4894158db 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1222,9 +1222,6 @@ void page_add_anon_rmap(struct page *page,
>  	bool compound = flags & RMAP_COMPOUND;
>  	bool first = true;
>  
> -	if (unlikely(PageKsm(page)))
> -		lock_page_memcg(page);
> -
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
>  		first = atomic_inc_and_test(&page->_mapcount);
> @@ -1254,9 +1251,6 @@ void page_add_anon_rmap(struct page *page,
>  	if (nr)
>  		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>  
> -	if (unlikely(PageKsm(page)))
> -		unlock_page_memcg(page);
> -
>  	/* address might be in next vma when migration races vma_adjust */
>  	else if (first)
>  		__page_set_anon_rmap(page, vma, address,
> @@ -1321,7 +1315,6 @@ void page_add_file_rmap(struct page *page,
>  	bool first;
>  
>  	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> -	lock_page_memcg(page);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
> @@ -1349,7 +1342,6 @@ void page_add_file_rmap(struct page *page,
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
>  	if (nr)
>  		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
> -	unlock_page_memcg(page);
>  
>  	mlock_vma_page(page, vma, compound);
>  }
> @@ -1378,8 +1370,6 @@ void page_remove_rmap(struct page *page,
>  		return;
>  	}
>  
> -	lock_page_memcg(page);
> -
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>  	if (likely(!compound)) {
>  		last = atomic_add_negative(-1, &page->_mapcount);
> @@ -1427,8 +1417,6 @@ void page_remove_rmap(struct page *page,
>  	 * and remember that it's only reliable while mapped.
>  	 */
>  
> -	unlock_page_memcg(page);
> -
>  	munlock_vma_page(page, vma, compound);
>  }
>  
> -- 
> 2.38.1

[PATCH] mm: remove lock_page_memcg() from rmap - fix

Blame me for the hidden "else", which now does the wrong thing, leaving
page's anon_vma unset, then VM_BUG_ON before do_swap_page's set_pte_at.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 11a4894158db..5a8d27fdc644 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1251,13 +1251,14 @@ void page_add_anon_rmap(struct page *page,
 	if (nr)
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 
-	/* address might be in next vma when migration races vma_adjust */
-	else if (first)
-		__page_set_anon_rmap(page, vma, address,
-				     !!(flags & RMAP_EXCLUSIVE));
-	else
-		__page_check_anon_rmap(page, vma, address);
-
+	if (!PageKsm(page)) {
+		/* address may be in next vma if migration races vma_adjust */
+		if (first)
+			__page_set_anon_rmap(page, vma, address,
+					     !!(flags & RMAP_EXCLUSIVE));
+		else
+			__page_check_anon_rmap(page, vma, address);
+	}
 	mlock_vma_page(page, vma, compound);
 }
 
-- 
2.35.3
