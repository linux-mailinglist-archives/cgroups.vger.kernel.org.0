Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D145FB7A5
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJKPrs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJKPr2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 11:47:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DD12606;
        Tue, 11 Oct 2022 08:39:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 205E21F8E0;
        Tue, 11 Oct 2022 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665502782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vB0AXXBtm0Hrdk0bg6YG9HeCQbPU+AcCqyHQMZO7aHU=;
        b=AOyiExVT8ICluY29f7EISViuBP4fZfaDGjWt/zgw/wKFtAhm86QAWBAMm3OGNO88yDbw4L
        dCppJmVuT0D38ZQBGQ4D/GsypMU9r0HpZIlyL+USdsMoBBwX+vizkRdpijHy57HK/3+fS7
        wQVsY/OckiDS1Src/EUzygFkKRStZJs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9FF813AAC;
        Tue, 11 Oct 2022 15:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6uS9Nj2ORWNyWwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Oct 2022 15:39:41 +0000
Date:   Tue, 11 Oct 2022 17:39:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm/memcontrol: Don't increase effective low/min if no
 protection needed
Message-ID: <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
References: <20221011143015.1152968-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011143015.1152968-1-longman@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-10-22 10:30:15, Waiman Long wrote:
> Since commit bc50bcc6e00b ("mm: memcontrol: clean up and document
> effective low/min calculations"), the effective low/min protections can
> be non-zero even if the corresponding memory.low/min values are 0. That
> can surprise users to see MEMCG_LOW events even when the memory.low
> value is not set. One example is the LTP's memcontrol04 test which fails
> because it detects some MEMCG_LOW events for a cgroup with a memory.min
> value of 0.

Is this with memory_recursiveprot mount option?

> Fix this by updating effective_protection() to not returning a non-zero
> low/min protection values if the corresponding memory.low/min values
> or those of its parent are 0.
> 
> Fixes: bc50bcc6e00b ("mm: memcontrol: clean up and document effective low/min calculations")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b69979c9ced5..893d4d5e518a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6660,6 +6660,9 @@ static unsigned long effective_protection(unsigned long usage,
>  	unsigned long protected;
>  	unsigned long ep;
>  
> +	if (!setting || !parent_effective)
> +		return 0UL;	/* No protection is needed */
> +

This will break the above memory_recursiveprot AFAICS.

>  	protected = min(usage, setting);
>  	/*
>  	 * If all cgroups at this level combined claim and use more
> -- 
> 2.31.1

-- 
Michal Hocko
SUSE Labs
