Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7B32EFFD
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhCEQZm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCEQZN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 11:25:13 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC51C061574
        for <cgroups@vger.kernel.org>; Fri,  5 Mar 2021 08:25:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s15so2167918qtq.0
        for <cgroups@vger.kernel.org>; Fri, 05 Mar 2021 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5GBpYtsOToNXALvaP0yVwWut+4euuVYAomBALxtd1po=;
        b=l5GR7801lJ+iexrPZFrMv2GyBBGWIkMKJrSkR2MfNTsFIDXHUpy3cm/SE8mt8iA8UW
         tX/fInL970tsjCxnzQF+FRUNwkBYl8ssYwqC0WnbEYVWqVCGsXbQPeWx+VWBu956APq5
         mGp7vqfZN32cBBvXjmDpf/1oIPIh2R8ci632Envp0BMPk+oYYwrezZz94yY0QUPCCM5C
         0MdWXR5gQwacJqCZHp30/0E3L+uYsM+aSN4osjQSY2P/XcQXN0bZ63NuW5fVyTMeSvMY
         +wgAS8a9Hke9BxQO5OP3oLzb5rE1rG9b5YRUFu7ogbuZnpaXfViZtSf1xkH9CLZTA469
         WDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GBpYtsOToNXALvaP0yVwWut+4euuVYAomBALxtd1po=;
        b=rrq+lEPbuNF9ZSFy29zS6uFDUf5pYFctnIei4PX8tofJwhyLrbpeXS2O0flc5RidbN
         FwvnqZA+L71KhTmQg0HDR9vj+4gYYokVaxR8QQtMv/56QTC9NZkBBQdvRiMriFqG4i+l
         s4RSmzJ/Cea/mXFHYH7YUh+42p3ykGJosa6pqaZ/SAOKIzeVeZyHlaH50UlC0aOpsUi9
         ClWgl4wP3iX5PReMKIbXgQraM95j1uAI8Ia2E3kNaSmQUnOwkw/k81q1N5o38az1S5nh
         h0uy72M9zS7RbcgKbhSIJz93Ly/Qo7yNNPCaUkzQYCZPcMc6bMy5jM+QlBuLJmX/gtXq
         t6uQ==
X-Gm-Message-State: AOAM531qqH+Cq2lzhzAWmJW/wwqC371sfYr7Njh+Ih+KVFeU2PoEmWM/
        BNQONYMIuf7ZHhIYSr/UkkjZKQ==
X-Google-Smtp-Source: ABdhPJzIotCPAUdL3jV2ZoIemcaQCaIniPbkJAHU9DuUli2t+rjKeNj1R/Nq2yNi6OIpFFy0yPusmw==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr9500637qtx.81.1614961512027;
        Fri, 05 Mar 2021 08:25:12 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a34sm2185343qtc.97.2021.03.05.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 08:25:11 -0800 (PST)
Date:   Fri, 5 Mar 2021 11:25:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
Message-ID: <YEJbZi+tpSATjsT/@cmpxchg.org>
References: <20210304014229.521351-1-shakeelb@google.com>
 <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 05, 2021 at 12:06:31AM -0800, Hugh Dickins wrote:
> On Wed, 3 Mar 2021, Shakeel Butt wrote:
> 
> > Currently the kernel adds the page, allocated for swapin, to the
> > swapcache before charging the page. This is fine but now we want a
> > per-memcg swapcache stat which is essential for folks who wants to
> > transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> > swap counters. In addition charging a page before exposing it to other
> > parts of the kernel is a step in the right direction.
> > 
> > To correctly maintain the per-memcg swapcache stat, this patch has
> > adopted to charge the page before adding it to swapcache. One
> > challenge in this option is the failure case of add_to_swap_cache() on
> > which we need to undo the mem_cgroup_charge(). Specifically undoing
> > mem_cgroup_uncharge_swap() is not simple.
> > 
> > To resolve the issue, this patch introduces transaction like interface
> > to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> > initiates the charging of the page and mem_cgroup_finish_swapin_page()
> > completes the charging process. So, the kernel starts the charging
> > process of the page for swapin with mem_cgroup_charge_swapin_page(),
> > adds the page to the swapcache and on success completes the charging
> > process with mem_cgroup_finish_swapin_page().
> > 
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> 
> Quite apart from helping with the stat you want, what you've ended
> up with here is a nice cleanup in several different ways (and I'm
> glad Johannes talked you out of __GFP_NOFAIL: much better like this).
> I'll say
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> but I am quite unhappy with the name mem_cgroup_finish_swapin_page():
> it doesn't finish the swapin, it doesn't finish the page, and I'm
> not persuaded by your paragraph above that there's any "transaction"
> here (if there were, I'd suggest "commit" instead of "finish"'; and
> I'd get worried by the css_put before it's called - but no, that's
> fine, it's independent).
> 
> How about complementing mem_cgroup_charge_swapin_page() with
> mem_cgroup_uncharge_swapin_swap()?  I think that describes well
> what it does, at least in the do_memsw_account() case, and I hope
> we can overlook that it does nothing at all in the other case.

Yes, that's better. The sequence is still somewhat mysterious for
people not overly familiar with memcg swap internals, but it's much
clearer for people who are.

I mildly prefer swapping the swapin bit:

mem_cgroup_swapin_charge_page()
mem_cgroup_swapin_uncharge_swap()

But either way works for me.

> And it really doesn't need a page argument: both places it's called
> have just allocated an order-0 page, there's no chance of a THP here;
> but you might have some idea of future expansion, or matching
> put_swap_page() - I won't object if you prefer to pass in the page.

Agreed.

> > + * mem_cgroup_finish_swapin_page - complete the swapin page charge transaction
> > + * @page: page charged for swapin
> > + * @entry: swap entry for which the page is charged
> > + *
> > + * This function completes the transaction of charging the page allocated for
> > + * swapin.
> > + */
> > +void mem_cgroup_finish_swapin_page(struct page *page, swp_entry_t entry)
> > +{
> >  	/*
> >  	 * Cgroup1's unified memory+swap counter has been charged with the
> >  	 * new swapcache page, finish the transfer by uncharging the swap
> > @@ -6760,20 +6796,14 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >  	 * correspond 1:1 to page and swap slot lifetimes: we charge the
> >  	 * page to memory here, and uncharge swap when the slot is freed.
> >  	 */
> > -	if (do_memsw_account() && PageSwapCache(page)) {
> > -		swp_entry_t entry = { .val = page_private(page) };
> > +	if (!mem_cgroup_disabled() && do_memsw_account()) {
> 
> I understand why you put that !mem_cgroup_disabled() check in there,
> but I have a series of observations on that.
> 
> First I was going to say that it would be better left to
> mem_cgroup_uncharge_swap() itself.
> 
> Then I was going to say that I think it's already covered here
> by the cgroup_memory_noswap check inside do_memsw_account().
> 
> Then, going back to mem_cgroup_uncharge_swap(), I realized that 5.8's
> 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of
> memory control") removed the do_swap_account or cgroup_memory_noswap
> checks from mem_cgroup_uncharge_swap() and swap_cgroup_swapon() and
> swap_cgroup_swapoff() - so since then we have been allocating totally
> unnecessary swap_cgroup arrays when mem_cgroup_disabled() (and
> mem_cgroup_uncharge_swap() has worked by reading the zalloced array).
> 
> I think, or am I confused? If I'm right on that, one of us ought to
> send another patch putting back, either cgroup_memory_noswap checks
> or mem_cgroup_disabled() checks in those three places - I suspect the
> static key mem_cgroup_disabled() is preferable, but I'm getting dozy.

You're right, that patch was overzealous.

The point behind it was to ALWAYS track swap ownership when memcg is
enabled, so that even if swap space COUNTING has been disabled, we'll
charge pages back to their original owners during swap readahead and
on swapoff. Therefor, we have to allocate the arrays even if the user
requested cgroup_memory_noswap.

But we certainly don't need to allocate and maintain the array when
mem_cgroup_disabled() altogether. I'll send a patch to add those back.

I'd also rename cgroup_memory_noswap to cgroup_swapaccount - to match
the commandline and (hopefully) make a bit clearer what it effects.

> Whatever we do with that - and it's really not any business for this
> patch - I think you can drop the mem_cgroup_disabled() check from
> mem_cgroup_uncharge_swapin_swap().

Yes. do_memsw_account() implies !mem_cgroup_disabled(), as disabling
memcg sets cgroup_memory_noswap.
