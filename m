Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273B44254EC
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbhJGOCR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 10:02:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42838 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbhJGOCR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 10:02:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 591D3200BE;
        Thu,  7 Oct 2021 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633615222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGhSWzI+PuqGNcE+T8UMjVNVsLgxFGP2hreevAIqd60=;
        b=S1aB24FYThKU4At27vhzZmHUc46bEaLhYREZ9O1eI+nEAW61YPhSJYgtcGGZrYwdpNfzDq
        NT4uaUzJrqA7DWyJDBLjsbkMccDwFte58GQvGfxesqQMGNjyH/Roww01s2ei0kCw3EeM5R
        2UiYyRVtLkFrTiZW8WeXpyU6Gh7+7xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633615222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGhSWzI+PuqGNcE+T8UMjVNVsLgxFGP2hreevAIqd60=;
        b=EOQXBkC0oMqI/99qT0eRzoEijjqG87XUpxSptWKxj4c1VnP6mvX7wctQQrVKhjg2MQwcXc
        D65FSGkHW5hfLaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E2A013EAC;
        Thu,  7 Oct 2021 14:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LnN0Cnb9XmFeSQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Oct 2021 14:00:22 +0000
Message-ID: <0668b6d8-6f8c-07c7-75e0-5448ea87cb54@suse.cz>
Date:   Thu, 7 Oct 2021 16:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: memcg memory accounting in vmalloc is broken
Content-Language: en-US
To:     Vasily Averin <vvs@virtuozzo.com>, Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org, Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
 <YV6sIz5UjfbhRyHN@dhcp22.suse.cz> <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
 <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/7/21 10:50, Vasily Averin wrote:
> On 10/7/21 11:16 AM, Michal Hocko wrote:
>> Cc Mel and Uladzislau
>> 
>> On Thu 07-10-21 10:13:23, Michal Hocko wrote:
>>> On Thu 07-10-21 11:04:40, Vasily Averin wrote:
>>>> vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
>>>>
>>>> Is it known issue perhaps?
>>>
>>> No, I think this was just overlooked. Definitely doesn't look
>>> intentional to me.
> 
> I use following patch as a quick fix,
> it helps though it is far from ideal and can be optimized.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..e6abe2cac159 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5290,6 +5290,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  
>  		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
>  								pcp, pcp_list);
> +
> +		if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT) && page &&
> +		    unlikely(__memcg_kmem_charge_page(page, gfp, 0) != 0)) {
> +			__free_pages(page, 0);

It's too early for this here, we didn't go through prep_new_page() yet,
minimally the post_alloc_hook() -> set_page_refcounted() part, required for
put_page_testzero() in __free_pages() to work properly, and probably other
stuff.
Either do the full prep+free or a minimal reversion of  __rmqueue_pcplist -
something to just put the page back to pcplist. Probably the former so we
don't introduce subtle errors.

> +			page = NULL;
> +		}
>  		if (unlikely(!page)) {
>  			/* Try and get at least one page */
>  			if (!nr_populated)
> 

