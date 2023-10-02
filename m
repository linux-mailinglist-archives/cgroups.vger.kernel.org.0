Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E087B5437
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbjJBNnY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbjJBNnY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 09:43:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2DAD;
        Mon,  2 Oct 2023 06:43:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B77E32185E;
        Mon,  2 Oct 2023 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696254199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=caakDTqPQiiqSKbfuYgVTeM3IkU7B/tdKX/DWu+ptPg=;
        b=mftAFFZeLc7dpw7U7ba2KaL8anrudYFIbm8u+J+/kblE3rVxtHFiYu+9utSCfI8EwdsCWZ
        hW+KUdT5id10aCyLZEhUWNgzHRIkMdA9d3veD2tJYxxnH0YMNYnt6CgY8vT8bWLtRWKCV4
        /4gLkQNoELYuWRV/vevKHB2Y8avyPa8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9355613456;
        Mon,  2 Oct 2023 13:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3YcEIffIGmVzTgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 02 Oct 2023 13:43:19 +0000
Date:   Mon, 2 Oct 2023 15:43:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928005723.1709119-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 27-09-23 17:57:22, Nhat Pham wrote:
> Currently, hugetlb memory usage is not acounted for in the memory
> controller, which could lead to memory overprotection for cgroups with
> hugetlb-backed memory. This has been observed in our production system.
> 
> This patch rectifies this issue by charging the memcg when the hugetlb
> folio is allocated, and uncharging when the folio is freed (analogous to
> the hugetlb controller).

This changelog is missing a lot of information. Both about the usecase
(we do not want to fish that out from archives in the future) and the
actual implementation and the reasoning behind that.

AFAICS you have decided to charge on the hugetlb use rather than hugetlb
allocation to the pool. I suspect the underlying reasoning is that pool
pages do not belong to anybody. This is a deliberate decision and it
should be documented as such.

It is also very important do describe subtle behavior properties that
might be rather unintuitive to users. Most notably 
- there is no hugetlb pool management involved in the memcg
  controller. One has to use hugetlb controller for that purpose.
  Also the pre allocated pool as such doesn't belong to anybody so the
  memcg host overcommit management has to consider it when configuring
  hard limits.
- memcg limit reclaim doesn't assist hugetlb pages allocation when
  hugetlb overcommit is configured (i.e. pages are not consumed from the
  pool) which means that the page allocation might disrupt workloads
  from other memcgs.
- failure to charge a hugetlb page results in SIGBUS rather
  than memcg oom killer. That could be the case even if the
  hugetlb pool still has pages available and there is
  reclaimable memory in the memcg.
- hugetlb pages are contributing to memory reclaim protection 
  implicitly. This means that the low,min limits tunning has to consider
  hugetlb memory as well.

I suspect there is more than the above. To be completely honest I am
still not convinced this is a good idea.

I do recognize that this might work in a very limited environments but
hugetlb management is quite challenging on its own and this just adds
another layer of complexity which is really hard to see through without
an intimate understanding of both memcg and hugetlb. The reason that
hugetlb has been living outside of the core MM (and memcg) is not just
because we like it that way. And yes I do fully understand that users
shouldn't really care about that because this is just a memory to them.

We should also consider the global control for this functionality. I am
especially worried about setups where a mixed bag of workloads
(containers) is executed. While some of them will be ready for the new
accounting mode many will leave in their own world without ever being
modified. How do we deal with that situation?

All that being said, I am not going to ack nor nack this but I really do
prefer to be much more explicit about the motivation and current
implementation specifics so that we can forward users to something
they can digest.

> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
[...]

a minor implementation detail below. I couldn't spot anything obviously
broken with the rest of the hugetlb specific code. restore_reserve_on_memcg_failure
is rather clumsy and potentially error prone but I will leave that out
to Mike as he is much more familiar with that behavior than me.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index de220e3ff8be..ff88ea4df11a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
[...]
> @@ -3119,6 +3121,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					pages_per_huge_page(h), folio);
>  	}
> +
> +	/* undo allocation if memory controller disallows it. */
> +	if (mem_cgroup_hugetlb_charge_folio(folio, GFP_KERNEL)) {

htlb_alloc_mask(h) rather than GFP_KERNEL. Ideally with
__GFP_RETRY_MAYFAIL which is a default allocation policy.

> +		if (restore_reserve_on_memcg_failure)
> +			restore_reserve_on_error(h, vma, addr, folio);
> +		folio_put(folio);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	return folio;
>  
>  out_uncharge_cgroup:

-- 
Michal Hocko
SUSE Labs
