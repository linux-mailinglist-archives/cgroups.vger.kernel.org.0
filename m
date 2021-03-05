Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC632E353
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 09:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEIGr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 03:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhCEIGr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 03:06:47 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C3C061574
        for <cgroups@vger.kernel.org>; Fri,  5 Mar 2021 00:06:46 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id t16so1008812ott.3
        for <cgroups@vger.kernel.org>; Fri, 05 Mar 2021 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6Ntm9TYj9xnK5FJwNfSHccWZk0cH/kRpY9uFJXEGdp4=;
        b=JtDs5SGsyGwpKyZGB+UWCFD0bUCHtF++4j4LEkMR3zxnUbR7upuo3bGIoFiSGBtExy
         Xlu/idUZ+1LErYPG3Cd+Eej2W0DQW2t7bP3RcQmpj9eZu4zrngwcstsiZFWkh71eDLt/
         +nuDyIl5YfMHCEMynjwMtQeeO6PCpHLId8kJOUlmRAn8t86VTxSa7bVNI5eCWjXFbzhI
         KCpyR8GReEwx6f8/TqrakkXvX+xSDklxWlzkQs7H9jr7uriW6UvyRmVeN1EPjJMszwh4
         sar5jzloP5Iz83AbJ/YuFjSfDDuDnnZOE9T5EQ1HK2xhxG5tmJUpTCiIjgvl02WDu9W+
         adnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6Ntm9TYj9xnK5FJwNfSHccWZk0cH/kRpY9uFJXEGdp4=;
        b=A/OFyuR6xDWCqbtM8Qg54Fwn3HnKy5e1WnS+xWh9Rf0Xdm0FRQt10VMyvTddsTZkeP
         ZhPnqlpqcpsH6bodJGgOUZsSi7LCAN6HzSwZgW4AS+SZ3I8JVhrrqKr1p/x6OfIKjE1p
         ODy6AscuHIt+9JsXOfILlaReLXnIcLBCuN5jdh+yZdXgljIVQJSV69fG1vff6FC8YLSP
         ihubWJIw9johV2npO9BIVSTpJoVwqWtdFoZAfxrsXEcm+ibJBARgmgU7il9D+Djdwiv/
         u6YkL/yen2m7Hl9ZMgFOma0NepnQVJvNuFGtVGsr4FIbr759WsT/Oa55ynJgtJjohgH2
         deUQ==
X-Gm-Message-State: AOAM533Bw8DRyH3GnSAV08WDfWeCR0bijW/rLW0L1RsatfPOFUEjplzq
        sQ80VsrT6i1Ti3iGbIn71pu1tA==
X-Google-Smtp-Source: ABdhPJxThJ5wrHrPS0uUauUNUFu56eKAS9O2j6jzhAW+ts6AM6FgX1hw/FEjfEL4rW3W5UQs8HgcbA==
X-Received: by 2002:a9d:701e:: with SMTP id k30mr6969214otj.157.1614931606122;
        Fri, 05 Mar 2021 00:06:46 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d21sm376885oic.54.2021.03.05.00.06.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 05 Mar 2021 00:06:45 -0800 (PST)
Date:   Fri, 5 Mar 2021 00:06:31 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Shakeel Butt <shakeelb@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
In-Reply-To: <20210304014229.521351-1-shakeelb@google.com>
Message-ID: <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
References: <20210304014229.521351-1-shakeelb@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 3 Mar 2021, Shakeel Butt wrote:

> Currently the kernel adds the page, allocated for swapin, to the
> swapcache before charging the page. This is fine but now we want a
> per-memcg swapcache stat which is essential for folks who wants to
> transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> swap counters. In addition charging a page before exposing it to other
> parts of the kernel is a step in the right direction.
> 
> To correctly maintain the per-memcg swapcache stat, this patch has
> adopted to charge the page before adding it to swapcache. One
> challenge in this option is the failure case of add_to_swap_cache() on
> which we need to undo the mem_cgroup_charge(). Specifically undoing
> mem_cgroup_uncharge_swap() is not simple.
> 
> To resolve the issue, this patch introduces transaction like interface
> to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> initiates the charging of the page and mem_cgroup_finish_swapin_page()
> completes the charging process. So, the kernel starts the charging
> process of the page for swapin with mem_cgroup_charge_swapin_page(),
> adds the page to the swapcache and on success completes the charging
> process with mem_cgroup_finish_swapin_page().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Quite apart from helping with the stat you want, what you've ended
up with here is a nice cleanup in several different ways (and I'm
glad Johannes talked you out of __GFP_NOFAIL: much better like this).
I'll say

Acked-by: Hugh Dickins <hughd@google.com>

but I am quite unhappy with the name mem_cgroup_finish_swapin_page():
it doesn't finish the swapin, it doesn't finish the page, and I'm
not persuaded by your paragraph above that there's any "transaction"
here (if there were, I'd suggest "commit" instead of "finish"'; and
I'd get worried by the css_put before it's called - but no, that's
fine, it's independent).

How about complementing mem_cgroup_charge_swapin_page() with
mem_cgroup_uncharge_swapin_swap()?  I think that describes well
what it does, at least in the do_memsw_account() case, and I hope
we can overlook that it does nothing at all in the other case.

And it really doesn't need a page argument: both places it's called
have just allocated an order-0 page, there's no chance of a THP here;
but you might have some idea of future expansion, or matching
put_swap_page() - I won't object if you prefer to pass in the page.

But more interesting, though off-topic, comments on it below...

> +/*
> + * mem_cgroup_finish_swapin_page - complete the swapin page charge transaction
> + * @page: page charged for swapin
> + * @entry: swap entry for which the page is charged
> + *
> + * This function completes the transaction of charging the page allocated for
> + * swapin.
> + */
> +void mem_cgroup_finish_swapin_page(struct page *page, swp_entry_t entry)
> +{
>  	/*
>  	 * Cgroup1's unified memory+swap counter has been charged with the
>  	 * new swapcache page, finish the transfer by uncharging the swap
> @@ -6760,20 +6796,14 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  	 * correspond 1:1 to page and swap slot lifetimes: we charge the
>  	 * page to memory here, and uncharge swap when the slot is freed.
>  	 */
> -	if (do_memsw_account() && PageSwapCache(page)) {
> -		swp_entry_t entry = { .val = page_private(page) };
> +	if (!mem_cgroup_disabled() && do_memsw_account()) {

I understand why you put that !mem_cgroup_disabled() check in there,
but I have a series of observations on that.

First I was going to say that it would be better left to
mem_cgroup_uncharge_swap() itself.

Then I was going to say that I think it's already covered here
by the cgroup_memory_noswap check inside do_memsw_account().

Then, going back to mem_cgroup_uncharge_swap(), I realized that 5.8's
2d1c498072de ("mm: memcontrol: make swap tracking an integral part of
memory control") removed the do_swap_account or cgroup_memory_noswap
checks from mem_cgroup_uncharge_swap() and swap_cgroup_swapon() and
swap_cgroup_swapoff() - so since then we have been allocating totally
unnecessary swap_cgroup arrays when mem_cgroup_disabled() (and
mem_cgroup_uncharge_swap() has worked by reading the zalloced array).

I think, or am I confused? If I'm right on that, one of us ought to
send another patch putting back, either cgroup_memory_noswap checks
or mem_cgroup_disabled() checks in those three places - I suspect the
static key mem_cgroup_disabled() is preferable, but I'm getting dozy.

Whatever we do with that - and it's really not any business for this
patch - I think you can drop the mem_cgroup_disabled() check from
mem_cgroup_uncharge_swapin_swap().

>  		/*
>  		 * The swap entry might not get freed for a long time,
>  		 * let's not wait for it.  The page already received a
>  		 * memory+swap charge, drop the swap entry duplicate.
>  		 */
> -		mem_cgroup_uncharge_swap(entry, nr_pages);
> +		mem_cgroup_uncharge_swap(entry, thp_nr_pages(page));
>  	}
> -
> -out_put:
> -	css_put(&memcg->css);
> -out:
> -	return ret;
>  }
