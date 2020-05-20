Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C121DC016
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgETU0x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETU0w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 16:26:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A437C061A0E
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 13:26:52 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so5819764eji.6
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyAjRlnWUUT1mywco3FJeiLGJZLmkRz0VQZk3yUWI70=;
        b=PGibgYQ1AtG2afha5buPGXZKWooA7vXxvQmNmO1Idq+C1zDslsESBmlsaVApchVa1L
         glQJr13dgRd6TvmwuLCmKqJbXvyxIQU3mUqKj5WsYxSaRPgBreBPMdk+Dj13fIlUFGXk
         IeF+KqfHBc9dvaXAutyupqPzuLkHNVKW3WeOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyAjRlnWUUT1mywco3FJeiLGJZLmkRz0VQZk3yUWI70=;
        b=F7Q5JL45/a1Xj4FqYYqhQLjoaQh0ur2MOp86g8nhga1x8f/saGF3lLwciBtZNjxVqm
         V+nFsSWFz6yxkgC83BimaRwydteUDanCnuBZ2Sd5Sw+feiuZcyCafMbbGReMAaZrAhSr
         2I/4jPkjtWwZegON5jKEn6A7jvgG2Pk5ePj5pd+E9bEtmQ/dkaOtT7jYOXC6Vki6EDp1
         v/P4KWZbmc7AR8VQ+kJWtLhBBu2B0dqEhy9BvR1wiv1NODJdXW184aZppHx5TxZUHJeX
         Hfym3fBottVZF6o+hwxpkWlIIVUXjO0FZI8z9uav6TdFCITXesVv2wK5DOweuN8GqM/N
         gRlg==
X-Gm-Message-State: AOAM532NoG+WGlHhh7ogZFvb7u+qJSkuOn2y9BXlihJvcQ2zQBXeAldt
        n0nkAl8knN4gM+LcYFcfMCEJnA==
X-Google-Smtp-Source: ABdhPJwgeeyXXyd9EvAUvOOxDLmw29QD9rJLdjvxlqGZ1Pj+7iwL+qGPnFCbaSDWyDov/XvQHBVs0A==
X-Received: by 2002:a17:906:7a1c:: with SMTP id d28mr756450ejo.10.1590006410840;
        Wed, 20 May 2020 13:26:50 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:758d])
        by smtp.gmail.com with ESMTPSA id dt12sm2822454ejb.102.2020.05.20.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:26:50 -0700 (PDT)
Date:   Wed, 20 May 2020 21:26:50 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200520202650.GB558281@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200520160756.GE6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>Let me try to understand the actual problem. The high memory reclaim has
>a target which is proportional to the amount of charged memory. For most
>requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
>N is the number of memcgs in excess up the hierarchy). I can see to be
>insufficient if the memcg is already in a large excess but if the
>reclaim can make a forward progress this should just work fine because
>each charging context should reclaim at least the contributed amount.
>
>Do you have any insight on why this doesn't work in your situation?
>Especially with such a large inactive file list I would be really
>surprised if the reclaim was not able to make a forward progress.

Reclaim can fail for any number of reasons, which is why we have retries 
sprinkled all over for it already. It doesn't seem hard to believe that it 
might just fail for transient reasons and drive us deeper into the hole as a 
result.

In this case, a.) the application is producing tons of dirty pages, and b.) we 
have really heavy systemwide I/O contention on the affected machines. This high 
load is one of the reasons that direct and kswapd reclaim cannot keep up, and 
thus nr_pages can become a number of orders of magnitude larger than 
SWAP_CLUSTER_MAX. This is trivially reproducible on these machines, it's not an 
edge case.

Putting a trace_printk("%d\n", __LINE__) at non-successful reclaim in 
shrink_page_list shows that what's happening is always (and I really mean 
always) the "dirty page and you're not kswapd" check, as expected:

	if (PageDirty(page)) {
		/*
		 * Only kswapd can writeback filesystem pages
		 * to avoid risk of stack overflow. But avoid
		 * injecting inefficient single-page IO into
		 * flusher writeback as much as possible: only
		 * write pages when we've encountered many
		 * dirty pages, and when we've already scanned
		 * the rest of the LRU for clean pages and see
		 * the same dirty pages again (PageReclaim).
		 */
		if (page_is_file_lru(page) &&
			(!current_is_kswapd() || !PageReclaim(page) ||
			!test_bit(PGDAT_DIRTY, &pgdat->flags))) {
			/*
			 * Immediately reclaim when written back.
			 * Similar in principal to deactivate_page()
			 * except we already have the page isolated
			 * and know it's dirty
			 */
			inc_node_page_state(page, NR_VMSCAN_IMMEDIATE);
			SetPageReclaim(page);

			goto activate_locked;
		}

>Now to your patch. I do not like it much to be honest.
>MEM_CGROUP_RECLAIM_RETRIES is quite arbitrary and I neither like it in
>memory_high_write because the that is an interruptible context so there
>shouldn't be a good reason to give up after $FOO number of failed
>attempts. try_charge and memory_max_write are slightly different because
>we are invoking OOM killer based on the number of failed attempts.

As Johannes mentioned, the very intent of memory.high is to have it managed 
using a userspace OOM killer, which monitors PSI. As such, I'm not sure this 
distinction means much.
