Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EEA7755E5
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHIIvS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIIvQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 04:51:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEB71BD9;
        Wed,  9 Aug 2023 01:51:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAD911F45A;
        Wed,  9 Aug 2023 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691571073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNFE+i+WwtgcHn5Rj+LGuGTsx7FtrFv3sviTgeepiYo=;
        b=qnZnaGnS4J4MTbOYIfnDmj0JDfOtjkYuNESsya/JKY/fC0CJea40S3ZNfi5BL2ROwQ99Yo
        A+Kqlj/kNqEaQ99nNFSp2J0jViYuoMPjBWN7zmPu6XUws9D0aQ9un1VhrKrqFlaPndu73+
        +ZNVOAqk0JnQiUgLgxo9m+62w5cHj/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC99513251;
        Wed,  9 Aug 2023 08:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M2P6LoFT02RCfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 09 Aug 2023 08:51:13 +0000
Date:   Wed, 9 Aug 2023 10:51:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZNNTgZVPZipTL/UM@dhcp22.suse.cz>
References: <20230809045810.1659356-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809045810.1659356-1-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 09-08-23 04:58:10, Yosry Ahmed wrote:
> Over time, the memcg code added multiple optimizations to the stats
> flushing path that introduce a tradeoff between accuracy and
> performance. In some contexts (e.g. dirty throttling, refaults, etc), a
> full rstat flush of the stats in the tree can be too expensive. Such
> optimizations include [1]:
> (a) Introducing a periodic background flusher to keep the size of the
> update tree from growing unbounded.
> (b) Allowing only one thread to flush at a time, and other concurrent
> flushers just skip the flush. This avoids a thundering herd problem
> when multiple reclaim/refault threads attempt to flush the stats at
> once.
> (c) Only executing a flush if the magnitude of the stats updates exceeds
> a certain threshold.
> 
> These optimizations were necessary to make flushing feasible in
> performance-critical paths, and they come at the cost of some accuracy
> that we choose to live without. On the other hand, for flushes invoked
> when userspace is reading the stats, the tradeoff is less appealing
> This code path is not performance-critical, and the inaccuracies can
> affect userspace behavior. For example, skipping flushing when there is
> another ongoing flush is essentially a coin flip. We don't know if the
> ongoing flush is done with the subtree of interest or not.

I am not convinced by this much TBH. What kind of precision do you
really need and how much off is what we provide?

More expensive read of stats from userspace is quite easy to notice
and usually reported as a regression. So you should have a convincing
argument that an extra time spent is really worth it. AFAIK there are
many monitoring (top like) tools which simply read those files regularly
just to show numbers and they certainly do not need a high level of
precision.

[...]
> @@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  	}
>  }
>  
> -static void do_flush_stats(void)
> +static void do_flush_stats(bool full)
>  {
> +	if (!atomic_read(&stats_flush_ongoing) &&
> +	    !atomic_xchg(&stats_flush_ongoing, 1))
> +		goto flush;
> +
>  	/*
> -	 * We always flush the entire tree, so concurrent flushers can just
> -	 * skip. This avoids a thundering herd problem on the rstat global lock
> -	 * from memcg flushers (e.g. reclaim, refault, etc).
> +	 * We always flush the entire tree, so concurrent flushers can choose to
> +	 * skip if accuracy is not critical. Otherwise, wait for the ongoing
> +	 * flush to complete. This avoids a thundering herd problem on the rstat
> +	 * global lock from memcg flushers (e.g. reclaim, refault, etc).
>  	 */
> -	if (atomic_read(&stats_flush_ongoing) ||
> -	    atomic_xchg(&stats_flush_ongoing, 1))
> -		return;
> -
> +	while (full && atomic_read(&stats_flush_ongoing) == 1) {
> +		if (!cond_resched())
> +			cpu_relax();

You are reinveting a mutex with spinning waiter. Why don't you simply
make stats_flush_ongoing a real mutex and make use try_lock for !full
flush and normal lock otherwise?

> +	}
> +	return;
> +flush:
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
>  
>  	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
[...]
-- 
Michal Hocko
SUSE Labs
