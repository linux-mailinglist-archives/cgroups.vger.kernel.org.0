Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4067E784
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjA0N66 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 08:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjA0N6b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 08:58:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EC4C6FA;
        Fri, 27 Jan 2023 05:58:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3AA3820224;
        Fri, 27 Jan 2023 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674827900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oe7n6bwZh97VSySQD2WOfUI5HL86g25YRhUgfhjC8aY=;
        b=lvXhnHvkBwlkDFLQf5BCDvNwgtSPiPjHiGGUjlom9HXiJyNM1RqDZonjH8BPyJ5K2FrYA1
        cA5S3O65stqWvO4kinxFIa1XwDZphQbZef95i9zZBJZdzxVkTQcFvCdc7o2YYmQBr87qB0
        cjBpKCIImonJHZNZ0QC0mPlvNANSy98=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A39D138E3;
        Fri, 27 Jan 2023 13:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h6UdBHzY02OsMwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 27 Jan 2023 13:58:20 +0000
Date:   Fri, 27 Jan 2023 14:58:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9PYe1X7dRQOcahg@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 27-01-23 08:11:04, Michal Hocko wrote:
> [Cc Frederic]
> 
> On Thu 26-01-23 15:12:35, Roman Gushchin wrote:
> > On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> [...]
> > > > Essentially each cpu will try to grab the remains of the memory quota
> > > > and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
> > > > on per-cgroup basis.
> > > 
> > > I think it would be more than sufficient to disable pcp charging on an
> > > isolated cpu.
> > 
> > It might have significant performance consequences.
> 
> Is it really significant?
> 
> > I'd rather opt out of stock draining for isolated cpus: it might slightly reduce
> > the accuracy of memory limits and slightly increase the memory footprint (all
> > those dying memcgs...), but the impact will be limited. Actually it is limited
> > by the number of cpus.
> 
> Hmm, OK, I have misunderstood your proposal. Yes, the overal pcp charges
> potentially left behind should be small and that shouldn't really be a
> concern for memcg oom situations (unless the limit is very small and
> workloads on isolated cpus using small hard limits is way beyond my
> imagination).
> 
> My first thought was that those charges could be left behind without any
> upper bound but in reality sooner or later something should be running
> on those cpus and if the memcg is gone the pcp cache would get refilled
> and old charges gone.
> 
> So yes, this is actually a better and even simpler solution. All we need
> is something like this
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ab457f0394ab..13b84bbd70ba 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2344,6 +2344,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  		struct mem_cgroup *memcg;
>  		bool flush = false;
>  
> +		if (cpu_is_isolated(cpu))
> +			continue;
> +
>  		rcu_read_lock();
>  		memcg = stock->cached;
>  		if (memcg && stock->nr_pages &&

Btw. this would be over pessimistic. The following should make more
sense:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab..55e440e54504 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2357,7 +2357,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
-			else
+			else if (!cpu_is_isolated(cpu))
 				schedule_work_on(cpu, &stock->work);
 		}
 	}
-- 
Michal Hocko
SUSE Labs
