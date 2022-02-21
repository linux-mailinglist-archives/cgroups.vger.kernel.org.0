Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39CA4BE8D1
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 19:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378191AbiBUOq7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 09:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378288AbiBUOq4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 09:46:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A812BD
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 06:46:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E74621127;
        Mon, 21 Feb 2022 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645454791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqsD0+PUucg5iQZfEeVVmjRSWohazjOc9cWwEfg7gWQ=;
        b=S9RSPoFRigrL5qMv/KMVZC7pUGpUkd/8yaw0GTN00pBHVYNtVUVkqFaUKo5sOpLFxhaNEP
        C3MbcBsSyVJnzwDSA0jGAX/qFbmIl7vZ4hdBnEY4g+Jvez705ER6wV3LCJSOJurw8Enq1u
        b5Rasq4exl90T33lXZSWWnyCQbWx40w=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6EB88A3B83;
        Mon, 21 Feb 2022 14:46:31 +0000 (UTC)
Date:   Mon, 21 Feb 2022 15:46:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <YhOlxsLOOU/OVSzu@dhcp22.suse.cz>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217094802.3644569-6-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-02-22 10:48:02, Sebastian Andrzej Siewior wrote:
[...]
> @@ -2266,7 +2273,6 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  	 * as well as workers from this path always operate on the local
>  	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
>  	 */
> -	curcpu = get_cpu();

Could you make this a separate patch?

>  	for_each_online_cpu(cpu) {
>  		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
>  		struct mem_cgroup *memcg;
> @@ -2282,14 +2288,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  		rcu_read_unlock();
>  
>  		if (flush &&
> -		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> -			if (cpu == curcpu)
> -				drain_local_stock(&stock->work);
> -			else
> -				schedule_work_on(cpu, &stock->work);
> -		}
> +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
> +			schedule_work_on(cpu, &stock->work);

Maybe I am missing but on !PREEMPT kernels there is nothing really
guaranteeing that the worker runs so there should be cond_resched after
the mutex is unlocked. I do not think we want to rely on callers to be
aware of this subtlety.

An alternative would be to split out __drain_local_stock which doesn't
do local_lock.

-- 
Michal Hocko
SUSE Labs
