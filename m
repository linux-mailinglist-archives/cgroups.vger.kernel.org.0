Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CAB1E4897
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgE0Pxm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390408AbgE0PwM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 May 2020 11:52:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23260C05BD1E
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 08:52:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so9670645qtq.11
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdavmOiaMpGhs7wGJxDamxnJAYZBuYUhq0aVlsOCRyA=;
        b=gkwcO4FhZgIhYZsPq0f06YlHsoXzZTZD4TVMFnSEJkWPeA9sHjZUXP6LqDRXrFByd3
         bpkQeH86yIluEzmWNr4jcXijjYwxnwPkG6/eNLkx9SqCD4gTIdChRNBbAOO3TrdVhR4a
         XD5KwE9LvRhJPfvYJIaUtCMjIIaJ15va4wLU8VeM0JpBtqDJKbphSy7WWmuhvJGt0edS
         sWuJlI2k79/88yc9j1dy9VpBs/vk6JSegkfvqmRkjZ4qkZnzIv6fra1YCa4B/t+Vy0A0
         La7L5qUCLlpEhE5HT95drazFP1fL+jFlnNTHluO7f4pD776bkG2cWledK26hTkqE5rdW
         +9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdavmOiaMpGhs7wGJxDamxnJAYZBuYUhq0aVlsOCRyA=;
        b=H8Cb33q1dS6L/2hMfyV/OjRHsEaNmGU88Q77nHvNnk2HQ8+dNE6aoICHHsMilZz4EM
         6knl3BA5odM8Rr68hqS7sOTusV94kw5OXCLrJAh8Yl9eT697UgVRcHFuqWawOzvKWa8U
         fMtt8ZqgN/aZJ4+JDiDPOQAJX/sAhTnA0a6nWYPy8F47PtJ5h3FvwX5+mE1rPT7j9l/V
         RJSPI+D9AB4bJpx/tkA83PfJ/u86CeF9EZH3vx82GU3bTapZLd06+vYSitPUKchyRJ+d
         oqUOwy66hUsnqwwkWtBO2H+HCueDw0OnzL2M9FeW0oaIT6DCD6JlJOutxsl54qO2dg68
         8dLg==
X-Gm-Message-State: AOAM533cq4aJToynRxAjLsYPe3g9MTxRKHlWtZTgvFTwXpR8Hcl73MX3
        MRktQE2yqPfPwr/n0KlPHD6ehQ==
X-Google-Smtp-Source: ABdhPJyrSTROePSMbQ/B5rMJZyiqNj24TJYNMmjay84uQk055AedPAx2sXoVMMIROe4isndGOd7xjg==
X-Received: by 2002:ac8:c09:: with SMTP id k9mr5244596qti.264.1590594730621;
        Wed, 27 May 2020 08:52:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id m82sm2611261qke.3.2020.05.27.08.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:52:09 -0700 (PDT)
Date:   Wed, 27 May 2020 11:51:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org
Subject: Re: [PATCH mm v5 RESEND 4/4] mm: automatically penalize tasks with
 high swap use
Message-ID: <20200527155145.GA42293@cmpxchg.org>
References: <20200521002411.3963032-1-kuba@kernel.org>
 <20200521002411.3963032-5-kuba@kernel.org>
 <20200526153309.GD848026@cmpxchg.org>
 <20200526131157.79c17940@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526131157.79c17940@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 26, 2020 at 01:11:57PM -0700, Jakub Kicinski wrote:
> On Tue, 26 May 2020 11:33:09 -0400 Johannes Weiner wrote:
> > On Wed, May 20, 2020 at 05:24:11PM -0700, Jakub Kicinski wrote:
> > > +	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
> > > +						swap_find_max_overage(memcg));
> > > +
> > >  	/*
> > >  	 * Clamp the max delay per usermode return so as to still keep the
> > >  	 * application moving forwards and also permit diagnostics, albeit
> > > @@ -2585,12 +2608,25 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >  	 * reclaim, the cost of mismatch is negligible.
> > >  	 */
> > >  	do {
> > > -		if (page_counter_is_above_high(&memcg->memory)) {
> > > -			/* Don't bother a random interrupted task */
> > > -			if (in_interrupt()) {
> > > +		bool mem_high, swap_high;
> > > +
> > > +		mem_high = page_counter_is_above_high(&memcg->memory);
> > > +		swap_high = page_counter_is_above_high(&memcg->swap);  
> > 
> > Please open-code these checks instead - we don't really do getters and
> > predicates for these, and only have the setters because they are more
> > complicated operations.
> 
> I added this helper because the calculation doesn't fit into 80 chars. 
> 
> In particular reclaim_high will need a temporary variable or IMHO
> questionable line split.
> 
> static void reclaim_high(struct mem_cgroup *memcg,
> 			 unsigned int nr_pages,
> 			 gfp_t gfp_mask)
> {
> 	do {
> 		if (!page_counter_is_above_high(&memcg->memory))
> 			continue;
> 		memcg_memory_event(memcg, MEMCG_HIGH);
> 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
> 	} while ((memcg = parent_mem_cgroup(memcg)) &&
> 		 !mem_cgroup_is_root(memcg));
> }
> 
> What's your preference? Mine is a helper, but I'm probably not
> sensitive enough to the ontology here :)

		if (page_counter_read(&memcg->memory) <
		    READ_ONCE(memcg->memory.high))
			continue;

should work fine. It's the same formatting in mem_cgroup_swap_full():

		if (page_counter_read(&memcg->swap) * 2 >=
		    READ_ONCE(memcg->swap.max))
