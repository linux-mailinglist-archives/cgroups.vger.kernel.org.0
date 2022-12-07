Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C764518E
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 02:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLGBx3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 20:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiLGBxL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 20:53:11 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531FC53EF3
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 17:51:56 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-144b21f5e5fso7712819fac.12
        for <cgroups@vger.kernel.org>; Tue, 06 Dec 2022 17:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPu3F6AaPpr0cGTXbZ0IU965/QfP/00jiQD3p12tubc=;
        b=M0JPuZOBA2Srlf0lA9Wk1yOApsWT0kfaoJhDIY1aDNTsWZ2ShTrfzx4aC5chXquuCB
         QeeXpS8GX8E1Gk3vTDfiaWM0MhbeaHHlzPziuslPDptLyiYvkyzuhDvMsXw8QNuEZ1fW
         qhcE6HJtOFGZ3E0hgilE26lnsfq4jrEGh5GjGKCSnLnL8AcUnslDr0wr6UE743XlFpxP
         otVg2XkHDAkiXINLW29jxCNOgzvTpZyFCyk/Rexe7nGsN5Qen2uevSdqPhEPUdVeMz+x
         enqzQHaRSEMuKLKjWk4Fsa75u3GeZ0YdoJBPr/Ng9HEPhbo5GhrYikS8mTRAVowodFbU
         MWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPu3F6AaPpr0cGTXbZ0IU965/QfP/00jiQD3p12tubc=;
        b=K1uC0gG5Os5DDH3Rhgi1FQPn3FTsNhoNk2krpmkWkORUF232uy1y4a81Y2gD5KqFQ1
         mQTw4gKQGqVu+r6XIDSCZRI0K0+9FpCRGqLOg8TroveqpKNfir376i9YafgiDwxEQV+H
         YFOYT5Z/lQrlB7qsIKVWrOi6y5HH8nMvsjiEPWtrR6eQWtUEDNmpIH04pioembKAmeHl
         IS8U9Kcl2ZyT3S+PkVC5QA7xA44J0/XntRFbDWOcJAzGRdB8GM5BnbKPe8T4C79SOvUV
         WNQJn++tjNJRQZPRJ+B6JgWqUS2IUwkQCitqd/8SdUa7qeOmZZXBN24RcA6ueDKbiiKC
         nAZA==
X-Gm-Message-State: ANoB5pkbYJT44Ya+lhAj52MmEKMjieCFwrpzLIkYqJCjFTNAJE850/nJ
        BqTyM2ScgUfqfepPaHf2K6C84w==
X-Google-Smtp-Source: AA0mqf7XF7f7PoxlbuwsNKMuHDnrvEsJREWazQHWBwsRfHmhm/mAiBwB/UZ+LZBuRYLka7H7I/am6g==
X-Received: by 2002:a05:6870:b00f:b0:13a:f4fd:7d81 with SMTP id y15-20020a056870b00f00b0013af4fd7d81mr41896478oae.139.1670377915407;
        Tue, 06 Dec 2022 17:51:55 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w8-20020a4a2748000000b004a0918698f9sm223949oow.17.2022.12.06.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:51:54 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:51:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: memcontrol: skip moving non-present pages that
 are mapped elsewhere
In-Reply-To: <20221206171340.139790-2-hannes@cmpxchg.org>
Message-ID: <124f63e-ade3-78e5-f223-53668db36217@google.com>
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 6 Dec 2022, Johannes Weiner wrote:

> During charge moving, the pte lock and the page lock cover nearly all
> cases of stabilizing page_mapped(). The only exception is when we're
> looking at a non-present pte and find a page in the page cache or in
> the swapcache: if the page is mapped elsewhere, it can become unmapped
> outside of our control. For this reason, rmap needs lock_page_memcg().
> 
> We don't like cgroup-specific locks in generic MM code - especially in
> performance-critical MM code - and for a legacy feature that's
> unlikely to have many users left - if any.
> 
> So remove the exception. Arguably that's better semantics anyway: the
> page is shared, and another process seems to be the more active user.
> 
> Once we stop moving such pages, rmap doesn't need lock_page_memcg()
> anymore. The next patch will remove it.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Hugh Dickins <hughd@google.com>

It ended up simpler than I'd expected: nice, thank you.

I was going to say that you'd missed the most important detail from
the commit message (that page lock prevents remapping unmapped pages):
but you've gone into good detail on that in the source comment,
so that's fine.

I almost thought you could remove the folio_memcg() check from
mem_cgroup_move_account() itself: but then it looks as if
get_mctgt_type_thp() does things in a slightly different order,
leaving a window open in which folio memcg could have been changed.
Okay, there's no need to go back and rearrange that.

(I notice that get_mctgt_type_thp() has never been updated
for shmem and file THPs, so will move them iff MOVE_ANON:
but that's irrelevant to your changes, and probably something
we're not at all interested in fixing, now it's deprecated code.)

My tmpfs swapping load has been running for five hours on this
(and the others) so far: going fine.  I hacked in some stats to
verify that it really is moving anon and shmem and file, mapped
and unmapped: yes it is, and the unmapped numbers are big enough
that I'm glad that we chose to include them.

> ---
>  mm/memcontrol.c | 52 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 48c44229cf47..b696354c1b21 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5681,7 +5681,7 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
>   * @from: mem_cgroup which the page is moved from.
>   * @to:	mem_cgroup which the page is moved to. @from != @to.
>   *
> - * The caller must make sure the page is not on LRU (isolate_page() is useful.)
> + * The page must be locked and not on the LRU.
>   *
>   * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
>   * from old cgroup.
> @@ -5698,20 +5698,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	int nid, ret;
>  
>  	VM_BUG_ON(from == to);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  	VM_BUG_ON(compound && !folio_test_large(folio));
>  
> -	/*
> -	 * Prevent mem_cgroup_migrate() from looking at
> -	 * page's memory cgroup of its source page while we change it.
> -	 */
> -	ret = -EBUSY;
> -	if (!folio_trylock(folio))
> -		goto out;
> -
>  	ret = -EINVAL;
>  	if (folio_memcg(folio) != from)
> -		goto out_unlock;
> +		goto out;
>  
>  	pgdat = folio_pgdat(folio);
>  	from_vec = mem_cgroup_lruvec(from, pgdat);
> @@ -5798,8 +5791,6 @@ static int mem_cgroup_move_account(struct page *page,
>  	mem_cgroup_charge_statistics(from, -nr_pages);
>  	memcg_check_events(from, nid);
>  	local_irq_enable();
> -out_unlock:
> -	folio_unlock(folio);
>  out:
>  	return ret;
>  }
> @@ -5848,6 +5839,29 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>  	else if (is_swap_pte(ptent))
>  		page = mc_handle_swap_pte(vma, ptent, &ent);
>  
> +	if (target && page) {
> +		if (!trylock_page(page)) {
> +			put_page(page);
> +			return ret;
> +		}
> +		/*
> +		 * page_mapped() must be stable during the move. This
> +		 * pte is locked, so if it's present, the page cannot
> +		 * become unmapped. If it isn't, we have only partial
> +		 * control over the mapped state: the page lock will
> +		 * prevent new faults against pagecache and swapcache,
> +		 * so an unmapped page cannot become mapped. However,
> +		 * if the page is already mapped elsewhere, it can
> +		 * unmap, and there is nothing we can do about it.
> +		 * Alas, skip moving the page in this case.
> +		 */
> +		if (!pte_present(ptent) && page_mapped(page)) {
> +			unlock_page(page);
> +			put_page(page);
> +			return ret;
> +		}
> +	}
> +
>  	if (!page && !ent.val)
>  		return ret;
>  	if (page) {
> @@ -5864,8 +5878,11 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>  			if (target)
>  				target->page = page;
>  		}
> -		if (!ret || !target)
> +		if (!ret || !target) {
> +			if (target)
> +				unlock_page(page);
>  			put_page(page);
> +		}
>  	}
>  	/*
>  	 * There is a swap entry and a page doesn't exist or isn't charged.
> @@ -5905,6 +5922,10 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
>  		ret = MC_TARGET_PAGE;
>  		if (target) {
>  			get_page(page);
> +			if (!trylock_page(page)) {
> +				put_page(page);
> +				return MC_TARGET_NONE;
> +			}
>  			target->page = page;
>  		}
>  	}
> @@ -6143,6 +6164,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>  				}
>  				putback_lru_page(page);
>  			}
> +			unlock_page(page);
>  			put_page(page);
>  		} else if (target_type == MC_TARGET_DEVICE) {
>  			page = target.page;
> @@ -6151,6 +6173,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>  				mc.precharge -= HPAGE_PMD_NR;
>  				mc.moved_charge += HPAGE_PMD_NR;
>  			}
> +			unlock_page(page);
>  			put_page(page);
>  		}
>  		spin_unlock(ptl);
> @@ -6193,7 +6216,8 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>  			}
>  			if (!device)
>  				putback_lru_page(page);
> -put:			/* get_mctgt_type() gets the page */
> +put:			/* get_mctgt_type() gets & locks the page */
> +			unlock_page(page);
>  			put_page(page);
>  			break;
>  		case MC_TARGET_SWAP:
> -- 
> 2.38.1
> 
> 
> 
