Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFBA6CD8E9
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjC2L5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjC2L5H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 07:57:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826A4C33;
        Wed, 29 Mar 2023 04:56:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DF99219D6;
        Wed, 29 Mar 2023 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680090965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MgoqW9i5PP+a88cpUieall/Y5VXNVR+ZmdLSTwQcCUk=;
        b=gPDY7Zoa+PX03ws7DqJY76AlRsJnW8njixlmMYQFSry0Sm7LYXBffaSrEiEddrRh93lQ4b
        ta0+tMP2rFqm3q5t+9Dfe+XUHMrnimp8Y7siBb2qRrh+CyK+th4RsUG//OZ8FQ4e5R54q8
        ObR9oKGkhhZrGoyU+nMqPxNH4q//bhU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CAA5138FF;
        Wed, 29 Mar 2023 11:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KZZ/ClUnJGSOXQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 29 Mar 2023 11:56:05 +0000
Date:   Wed, 29 Mar 2023 13:56:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to
 "ratelimited"
Message-ID: <ZCQnVNH9NMg4D9TB@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328221644.803272-3-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-03-23 22:16:37, Yosry Ahmed wrote:
> mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
> but this is actually sometimes flushing directly from the callsite.
> 
> What it's doing is ratelimited calls. A better name would be
> mem_cgroup_flush_stats_ratelimited().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c            | 2 +-
>  mm/workingset.c            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6eda2ab205d..ac3f3b3a45e2 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1037,7 +1037,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  }
>  
>  void mem_cgroup_flush_stats(void);
> -void mem_cgroup_flush_stats_delayed(void);
> +void mem_cgroup_flush_stats_ratelimited(void);
>  
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			      int val);
> @@ -1535,7 +1535,7 @@ static inline void mem_cgroup_flush_stats(void)
>  {
>  }
>  
> -static inline void mem_cgroup_flush_stats_delayed(void)
> +static inline void mem_cgroup_flush_stats_ratelimited(void)
>  {
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0205e58ea430..c3b6aae78901 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -653,7 +653,7 @@ void mem_cgroup_flush_stats(void)
>  		__mem_cgroup_flush_stats();
>  }
>  
> -void mem_cgroup_flush_stats_delayed(void)
> +void mem_cgroup_flush_stats_ratelimited(void)
>  {
>  	if (time_after64(jiffies_64, flush_next_time))
>  		mem_cgroup_flush_stats();
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 00c6f4d9d9be..af862c6738c3 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -462,7 +462,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>  
>  	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
>  
> -	mem_cgroup_flush_stats_delayed();
> +	mem_cgroup_flush_stats_ratelimited();
>  	/*
>  	 * Compare the distance to the existing workingset size. We
>  	 * don't activate pages that couldn't stay resident even if
> -- 
> 2.40.0.348.gf938b09366-goog

-- 
Michal Hocko
SUSE Labs
