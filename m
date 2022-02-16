Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717E84B8FDB
	for <lists+cgroups@lfdr.de>; Wed, 16 Feb 2022 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiBPSJK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Feb 2022 13:09:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiBPSJJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Feb 2022 13:09:09 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F452A4A16
        for <cgroups@vger.kernel.org>; Wed, 16 Feb 2022 10:08:57 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a28so3428734qvb.10
        for <cgroups@vger.kernel.org>; Wed, 16 Feb 2022 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CU/AXfwa3Im1uRiNONAlogBiTBFdbTVUfdiUCLuEKiU=;
        b=yiK42wLBMgMpyLohAN1o3Njdrw1GDrndn/LnvGp1r/2/zpQQ19LDq26SHKCoy4MABR
         KnxhFYtTwOz86H7aytfUSLMEqPySVagV3hwu/eHxBVMcZ+urO7BETp5mTcoi4NO/XgkK
         Tv15THJP3UINtYcAQ6rhbrjp0fnwzUYkzGsjWdBC8HSW9U1klmFXz6mTaIZ6VhliM1HV
         Qf7FqeaE4l2ShY8jI6dBkaUF5j9eg0KZcydK99isY/wyAgg/OBAHndTRvv7SYEG49fO7
         nuIfwtpUfWaqZa5ANse9pWfIHdyqGc3Lt3FgZxZ+FRNW3Kk56RBywgCH3RKsxKRAgl/2
         54sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CU/AXfwa3Im1uRiNONAlogBiTBFdbTVUfdiUCLuEKiU=;
        b=mIBtdmUjQkrFXjnIuTFTXsVg9+mHKu5jtHFGzyioV6nlgVAGE1EH1kEHtVFEL9VgD3
         k99LyV9Z/9ErJL5Qy7Dqo0rypSSMFRaQzrQszwCVKaXEiRUuC1mpj0Wq1OxPOMVLRlyJ
         PK15JOZPfgiqtDnZcA2Pcrd01JLLLzoIdq6PZu2iKhQtRvyfNaOdIcXeckMMwznANWEn
         4NTHDitj2BrL9yWrB7XsyCtpA2btjHJdiEFcT43h/4qeSnXF1waxM42tgF6iU5pqXW0e
         YmXOR1z6TPkGT2lNSlma+mXwgn5FGJ9StjkRJDdghx10PL8B2vpzcaWM+tJHBTmM89+Z
         2HRQ==
X-Gm-Message-State: AOAM53296T+rAqE/etQS1qxdxa1o43f5JpP62K9MXLG343tviHSIH6+s
        NyIP8z9+Jx3gjiOLNxIrNsvAFw==
X-Google-Smtp-Source: ABdhPJz8/GbVoZCrQP4OvM+Ha+RfFhBpB2GEpiccs/C8aRkP3wcv/kZSfTgk3i1QLt0I41Lvm86nFw==
X-Received: by 2002:a05:6214:2342:b0:42d:7c8b:9eac with SMTP id hu2-20020a056214234200b0042d7c8b9eacmr2657405qvb.5.1645034936263;
        Wed, 16 Feb 2022 10:08:56 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bm27sm18247425qkb.5.2022.02.16.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:08:55 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:08:55 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/4] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <Yg09t/j5Z0X9L7aX@cmpxchg.org>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-5-bigeasy@linutronix.de>
 <YgqB77SaViGRAtgt@cmpxchg.org>
 <Yg0dctKholvzADYP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg0dctKholvzADYP@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 16, 2022 at 04:51:14PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-02-14 11:23:11 [-0500], Johannes Weiner wrote:
> > Hi Sebastian,
> Hi Johannes,
> 
> > This is a bit dubious in terms of layering. It's an objcg operation,
> > but what's "locked" isn't the objcg, it's the underlying stock. That
> > function then looks it up again, even though we have it right there.
> > 
> > You can open-code it and factor out the stock operation instead, and
> > it makes things much simpler and clearer.
> > 
> > I.e. something like this (untested!):
> 
> This then:
> 
> ------>8------
> 
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 16 Feb 2022 13:25:49 +0100
> Subject: [PATCH] mm/memcg: Opencode the inner part of
>  obj_cgroup_uncharge_pages() in drain_obj_stock()
> 
> Provide the inner part of refill_stock() as __refill_stock() without
> disabling interrupts. This eases the integration of local_lock_t where
> recursive locking must be avoided.
> Open code obj_cgroup_uncharge_pages() in drain_obj_stock() and use
> __refill_stock(). The caller of drain_obj_stock() already disables
> interrupts.
> 
> [bigeasy: Patch body around Johannes' diff ]
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I thought you'd fold it into yours, but separate patch works too,
thanks!

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

One important note, though:

> @@ -3151,8 +3155,17 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>  		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
>  
> -		if (nr_pages)
> -			obj_cgroup_uncharge_pages(old, nr_pages);
> +		if (nr_pages) {
> +			struct mem_cgroup *memcg;
> +
> +			memcg = get_mem_cgroup_from_objcg(old);
> +
> +			if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +				page_counter_uncharge(&memcg->kmem, nr_pages);
> +			__refill_stock(memcg, nr_pages);

This doesn't take "memcg: add per-memcg total kernel memory stat"
queued in -mm into account and so will break kmem accounting.

Make sure to rebase the patches to the -mm tree before sending it
out. You can find it here: https://github.com/hnaz/linux-mm
