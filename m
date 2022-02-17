Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4392E4B9C0C
	for <lists+cgroups@lfdr.de>; Thu, 17 Feb 2022 10:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiBQJ3R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Feb 2022 04:29:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiBQJ3Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Feb 2022 04:29:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E11C55AA
        for <cgroups@vger.kernel.org>; Thu, 17 Feb 2022 01:29:02 -0800 (PST)
Date:   Thu, 17 Feb 2022 10:28:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645090139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rfvk1TOpsNNoE1/dc+0M3aPmjLaMlI/s+kkO3n5aMnQ=;
        b=ahyvfRlUu+y1KuuXpCSjq/hC1mJ3pNLNUyJvxv/xP4hYG6KeYo59Dj4gUndCvKWWUZdF1p
        EPzoK4ASLFCn3+4Zbgqv9k2m9pMI1ajmY/+SpyTonH2vfz2jhWTGg15JeT462vIjsHFsAH
        BWBV7oTuNRfvO7mEyPsLBiHrsmDPHidirIJ8JL0BYVl/POyR06dg+XdIFquu17PHBqhOch
        Lny7nvsdX2Flzu4avyejdflrLAuzTqBfDXP4/4weyxp0TgXrMneEkreuzdiL+7zVbbDt2e
        k/iO/2mDhnWgOEglvVuWk6b14ZNS4BgvV9SVMkAYaeVtlZmx0fiNCnhh6gSSNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645090139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rfvk1TOpsNNoE1/dc+0M3aPmjLaMlI/s+kkO3n5aMnQ=;
        b=i+s1ymebTXcUUlUub/3iQBKh1aNTNiyfZAF8JndxUG78GwiZI+oPjOskJmV/LT8enJ8XXZ
        sU3FfP1KL5y5AHBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/4] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <Yg4VWfeCLGFnjQ1W@linutronix.de>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-5-bigeasy@linutronix.de>
 <YgqB77SaViGRAtgt@cmpxchg.org>
 <Yg0dctKholvzADYP@linutronix.de>
 <Yg09t/j5Z0X9L7aX@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg09t/j5Z0X9L7aX@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-16 13:08:55 [-0500], Johannes Weiner wrote:
> I thought you'd fold it into yours, but separate patch works too,
> thanks!
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thank you.

> One important note, though:
> 
> > @@ -3151,8 +3155,17 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> >  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> >  		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> >  
> > -		if (nr_pages)
> > -			obj_cgroup_uncharge_pages(old, nr_pages);
> > +		if (nr_pages) {
> > +			struct mem_cgroup *memcg;
> > +
> > +			memcg = get_mem_cgroup_from_objcg(old);
> > +
> > +			if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +				page_counter_uncharge(&memcg->kmem, nr_pages);
> > +			__refill_stock(memcg, nr_pages);
> 
> This doesn't take "memcg: add per-memcg total kernel memory stat"
> queued in -mm into account and so will break kmem accounting.
>
> Make sure to rebase the patches to the -mm tree before sending it
> out. You can find it here: https://github.com/hnaz/linux-mm

Thank you, rebased on-top.

Sebastian
