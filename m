Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171F24833B8
	for <lists+cgroups@lfdr.de>; Mon,  3 Jan 2022 15:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiACOoz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jan 2022 09:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiACOoq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jan 2022 09:44:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65148C061761
        for <cgroups@vger.kernel.org>; Mon,  3 Jan 2022 06:44:46 -0800 (PST)
Date:   Mon, 3 Jan 2022 15:44:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641221085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMUvJRIkEcl/HJeYgUz7jPr4JCoO6K1Up59xnJmJgyk=;
        b=yGq7pCT9OQF2OULtqlUID71JjXUJRRIthcE3nLvs3IsuEMDmm7DKB6BwqR4feaD0QBdqJ6
        9+CnBU37MXDi5u+P8dBMjQ52TujOG/k0wD6fJ9ty2CyVFJ0/t1H75r7XosdVhTDGQZyvDI
        PIwNhBd3XbVr1m43ohKrl2OgtoiaTnXryWDXwzpKEhsMrJtRn5hZv6iVSxgHhpflcddZe2
        vYJ7lfVDp26v45pbMY8WxDdXzSFu+mBw0PqZ36lc1CQLixFDcsZTkpTBRO81wjAN7XxoUt
        tC4CshvqEhjxTRbAIWDjJGeEMrKSZVdzxXWT2z5klLBvclteEdxUQbx9CqLA+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641221085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMUvJRIkEcl/HJeYgUz7jPr4JCoO6K1Up59xnJmJgyk=;
        b=hYVBfawsiIaUZryqk/cOnDY1U28vyW23NzoboozVAU01QeqNXSM4bL0gqFY70HduRTVSkY
        SAC66k1iOvK0NbCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] mm/memcg: Allow the task_obj optimization only
 on non-PREEMPTIBLE kernels.
Message-ID: <YdML2zaU17clEZgt@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-4-bigeasy@linutronix.de>
 <f6bb93c8-3940-6141-d0e0-50144549a4f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6bb93c8-3940-6141-d0e0-50144549a4f5@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-23 16:48:41 [-0500], Waiman Long wrote:
> On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
> > Based on my understanding the optimisation with task_obj for in_task()
> > mask sense on non-PREEMPTIBLE kernels because preempt_disable()/enable()
> > is optimized away. This could be then restricted to !CONFIG_PREEMPTION kernel
> > instead to only PREEMPT_RT.
> > With CONFIG_PREEMPT_DYNAMIC a non-PREEMPTIBLE kernel can also be
> > configured but these kernels always have preempt_disable()/enable()
> > present so it probably makes no sense here for the optimisation.
> > 
> > Restrict the optimisation to !CONFIG_PREEMPTION kernels.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> If PREEMPT_DYNAMIC is selected, PREEMPTION will also be set. My
> understanding is that some distros are going to use PREEMPT_DYNAMIC, but
> default to PREEMPT_VOLUNTARY. So I don't believe it is a good idea to
> disable the optimization based on PREEMPTION alone.

So there is a benefit to this even if preempt_disable() is not optimized
away? My understanding was that this depends on preempt_disable() being
optimized away.
Is there something you recommend as a benchmark where I could get some
numbers?

> Regards,
> Longman

Sebastian
