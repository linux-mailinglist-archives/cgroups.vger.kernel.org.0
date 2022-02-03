Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416E4A87E5
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiBCPqy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 10:46:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40252 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiBCPqy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 10:46:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAAEF21123;
        Thu,  3 Feb 2022 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643903212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qag6tkHAZgc8uXx2cxv+vocoYireohjHqFyNa8NETMI=;
        b=IJEnoj6Ibm8O0mi19d4TNUqFyp2wpMTSCVGmu9cHcTlRkWY0oDReLijm6fDsu8yDJTR4Z/
        KJ3e2YFJHaSfaRfK878zktY5ktc0HrNMFgmm2xpgAAwIa1N3opczoy2jUl/P/QJGOh8tRh
        qkCHq1CJu4GamRMXZWGd0h+Ei44tdCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643903212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qag6tkHAZgc8uXx2cxv+vocoYireohjHqFyNa8NETMI=;
        b=Q69+nu2srD89INEG52kptlrsTaoOM/1DpVHi2Uck2IJEmU41qsb3pcMazGHaZH0ak1J3zv
        A7bw+lIbHiGm2LDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 943A213A07;
        Thu,  3 Feb 2022 15:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G6hhI+z4+2H8DgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 15:46:52 +0000
Message-ID: <5c03fa31-35a5-4cbc-6b0e-872d5db82a41@suse.cz>
Date:   Thu, 3 Feb 2022 16:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-3-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 2/4] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
In-Reply-To: <20220202203036.744010-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/22 21:30, Waiman Long wrote:
> The snprintf() function can return a length greater than the given
> input size. That will require a check for buffer overrun after each
> invocation of snprintf(). scnprintf(), on the other hand, will never
> return a greater length. By using scnprintf() in selected places, we
> can avoid some buffer overrun checks except after stack_depot_snprint()
> and after the last snprintf().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Looks like this will work, but note that if the purpose of patch 1/4 was
that after the first scnprintf() that overflows the following calls will be
short-cut thanks to passing the size as 0, AFAICS that won't work. Because
scnprintf() returns the number without trailing zero, 'ret' will be 'count -
1' after the overflow, so 'count - ret' will be 1, never 0.

> ---
>  mm/page_owner.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 99e360df9465..28dac73e0542 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -338,19 +338,16 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> -	ret = snprintf(kbuf, count,
> +	ret = scnprintf(kbuf, count,
>  			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
>  			&page_owner->gfp_mask, page_owner->pid,
>  			page_owner->ts_nsec, page_owner->free_ts_nsec);
>  
> -	if (ret >= count)
> -		goto err;
> -
>  	/* Print information relevant to grouping pages by mobility */
>  	pageblock_mt = get_pageblock_migratetype(page);
>  	page_mt  = gfp_migratetype(page_owner->gfp_mask);
> -	ret += snprintf(kbuf + ret, count - ret,
> +	ret += scnprintf(kbuf + ret, count - ret,
>  			"PFN %lu type %s Block %lu type %s Flags %pGp\n",
>  			pfn,
>  			migratetype_names[page_mt],
> @@ -358,19 +355,14 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  			migratetype_names[pageblock_mt],
>  			&page->flags);
>  
> -	if (ret >= count)
> -		goto err;
> -
>  	ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
>  	if (ret >= count)
>  		goto err;
>  
>  	if (page_owner->last_migrate_reason != -1) {
> -		ret += snprintf(kbuf + ret, count - ret,
> +		ret += scnprintf(kbuf + ret, count - ret,
>  			"Page has been migrated, last migrate reason: %s\n",
>  			migrate_reason_names[page_owner->last_migrate_reason]);
> -		if (ret >= count)
> -			goto err;
>  	}
>  
>  	ret += snprintf(kbuf + ret, count - ret, "\n");

