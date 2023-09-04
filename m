Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D43791A02
	for <lists+cgroups@lfdr.de>; Mon,  4 Sep 2023 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjIDOuV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Sep 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjIDOuU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Sep 2023 10:50:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223641A5;
        Mon,  4 Sep 2023 07:50:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D258721858;
        Mon,  4 Sep 2023 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693839015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Rqxt2fKuHu+fMkXB1ABsmiC5CJA+FwEMGNI3T54CYQ=;
        b=YK/bkj5FbjjMVmedwWleIXDzouuBOnGEzArXL+4TxwuX2/8ac/VoPq5zgf84SuAIqqSIVe
        Un1PE1PblYMz3htUnajK+Ea30KZjpx8e7xaHcbzI13bEsasUkZFAru6LqpVxubJBlSNPsz
        ExMcCBemZIczMo64i+MOBBV7+loOwRU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B01B213425;
        Mon,  4 Sep 2023 14:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id opN1KKfu9WRyOgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 14:50:15 +0000
Date:   Mon, 4 Sep 2023 16:50:15 +0200
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
Subject: Re: [PATCH v4 3/4] mm: memcg: let non-unified root stats flushes
 help unified flushes
Message-ID: <ZPXupwjewuLgksAI@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831165611.2610118-4-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-08-23 16:56:10, Yosry Ahmed wrote:
> Unified flushing of memcg stats keeps track of the magnitude of pending
> updates, and only allows a flush if that magnitude exceeds a threshold.
> It also keeps track of the time at which ratelimited flushing should be
> allowed as flush_next_time.
> 
> A non-unified flush on the root memcg has the same effect as a unified
> flush, so let it help unified flushing by resetting pending updates and
> kicking flush_next_time forward. Move the logic into the common
> do_stats_flush() helper, and do it for all root flushes, unified or
> not.

I have hard time to follow why we really want/need this. Does this cause
any observable changes to the behavior?

> 
> There is a subtle change here, we reset stats_flush_threshold before a
> flush rather than after a flush. This probably okay because:
> 
> (a) For flushers: only unified flushers check stats_flush_threshold, and
> those flushers skip anyway if there is another unified flush ongoing.
> Having them also skip if there is an ongoing non-unified root flush is
> actually more consistent.
> 
> (b) For updaters: Resetting stats_flush_threshold early may lead to more
> atomic updates of stats_flush_threshold, as we start updating it
> earlier. This should not be significant in practice because we stop
> updating stats_flush_threshold when it reaches the threshold anyway. If
> we start early and stop early, the number of atomic updates remain the
> same. The only difference is the scenario where we reset
> stats_flush_threshold early, start doing atomic updates early, and then
> the periodic flusher kicks in before we reach the threshold. In this
> case, we will have done more atomic updates. However, since the
> threshold wasn't reached, then we did not do a lot of updates anyway.
> 
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/memcontrol.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c046feeaae7..94d5a6751a9e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -647,6 +647,11 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>   */
>  static void do_stats_flush(struct mem_cgroup *memcg)
>  {
> +	/* for unified flushing, root non-unified flushing can help as well */
> +	if (mem_cgroup_is_root(memcg)) {
> +		WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> +		atomic_set(&stats_flush_threshold, 0);
> +	}
>  	cgroup_rstat_flush(memcg->css.cgroup);
>  }
>  
> @@ -665,11 +670,8 @@ static void do_unified_stats_flush(void)
>  	    atomic_xchg(&stats_unified_flush_ongoing, 1))
>  		return;
>  
> -	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> -
>  	do_stats_flush(root_mem_cgroup);
>  
> -	atomic_set(&stats_flush_threshold, 0);
>  	atomic_set(&stats_unified_flush_ongoing, 0);
>  }
>  
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog

-- 
Michal Hocko
SUSE Labs
