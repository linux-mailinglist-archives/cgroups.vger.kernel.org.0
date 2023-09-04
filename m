Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2B7919EC
	for <lists+cgroups@lfdr.de>; Mon,  4 Sep 2023 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbjIDOpX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Sep 2023 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjIDOpW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Sep 2023 10:45:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A41BE;
        Mon,  4 Sep 2023 07:45:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 297B11F74D;
        Mon,  4 Sep 2023 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693838715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSixAjVtVtfBwEqUtETr7utTBGs453Bf8e7AyvXCIfg=;
        b=hnXnfiKkyovgWnaOElnC8H6D5iP+jTVvwybpfB2qyJcRyAQnX37i2H2bAOqzxktGv28NjF
        96YNowWYuMT2KNQPWD80TK1qkpQ0HJEHQqtJOujInksPH5N+atrrezecobwiJvuS50Oa0o
        Q0hwb+MovOybiYKL20NWwduVbXq/2N4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08F3313425;
        Mon,  4 Sep 2023 14:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PMPSOnrt9WSLNwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 14:45:14 +0000
Date:   Mon, 4 Sep 2023 16:45:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mm: memcg: add a helper for non-unified stats
 flushing
Message-ID: <ZPXtejIUIKg/IyZ6@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831165611.2610118-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-08-23 16:56:09, Yosry Ahmed wrote:
> Some contexts flush memcg stats outside of unified flushing, directly
> using cgroup_rstat_flush(). Add a helper for non-unified flushing, a
> counterpart for do_unified_stats_flush(), and use it in those contexts,
> as well as in do_unified_stats_flush() itself.
> 
> This abstracts the rstat API and makes it easy to introduce
> modifications to either unified or non-unified flushing functions
> without changing callers.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2d0ec828a1c4..8c046feeaae7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -639,6 +639,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  	}
>  }
>  
> +/*
> + * do_stats_flush - do a flush of the memory cgroup statistics
> + * @memcg: memory cgroup to flush
> + *
> + * Only flushes the subtree of @memcg, does not skip under any conditions.
> + */
> +static void do_stats_flush(struct mem_cgroup *memcg)
> +{
> +	cgroup_rstat_flush(memcg->css.cgroup);
> +}
> +
>  /*
>   * do_unified_stats_flush - do a unified flush of memory cgroup statistics
>   *
> @@ -656,7 +667,7 @@ static void do_unified_stats_flush(void)
>  
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
>  
> -	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> +	do_stats_flush(root_mem_cgroup);
>  
>  	atomic_set(&stats_flush_threshold, 0);
>  	atomic_set(&stats_unified_flush_ongoing, 0);
> @@ -7790,7 +7801,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  			break;
>  		}
>  
> -		cgroup_rstat_flush(memcg->css.cgroup);
> +		do_stats_flush(memcg);
>  		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
>  		if (pages < max)
>  			continue;
> @@ -7855,8 +7866,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
>  			      struct cftype *cft)
>  {
> -	cgroup_rstat_flush(css->cgroup);
> -	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +
> +	do_stats_flush(memcg);
> +	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
>  }
>  
>  static int zswap_max_show(struct seq_file *m, void *v)
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog

-- 
Michal Hocko
SUSE Labs
