Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF724793F8
	for <lists+cgroups@lfdr.de>; Fri, 17 Dec 2021 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhLQSVl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Dec 2021 13:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLQSVk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Dec 2021 13:21:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470FC061574;
        Fri, 17 Dec 2021 10:21:40 -0800 (PST)
Date:   Fri, 17 Dec 2021 19:21:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639765299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fm8Ji21c2eiKP0yW1lKrfGVuKLVJyDvJbeQwn/ZsYvM=;
        b=YqrU3fHSQRfaFxUWraZUi980r3t8h7vYSYTYzSR3s0gWO5X9yKrM2rWbqwY39lGVyl0lSX
        ONjIGeqwz29rc6M5TyE4S/cLoCfB9Dckz1DMBhjwSy0asb+U2J3j6IYEjiK4jOfYnQzpwA
        Qi9+Idkz9wWSoDviGb6NrcMSxjOkBxKODW47A99mUb+LDX1V+mNK+rg9+7m5XI/FWfo/ak
        29Qzc4S7++v3EotbBhJ1xtorSGNzhcAsKrH9ISvrSYT+I58TA4csXrlM3Ggtaqx5WK6/ZV
        4o7mi8wdT3FZFilT5Znj32LIkdmV+NKQ28BWl9WBQfaDNg1qFHolx2kunWfE2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639765299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fm8Ji21c2eiKP0yW1lKrfGVuKLVJyDvJbeQwn/ZsYvM=;
        b=9Tm2o/FLsPj4spSSiHLUbXy/DCYZ3PjoY5s5g+ZQy2QGHF7KQk9kTv/yEF/a//9Ryn4TzC
        sA45eR7TuPsNTiDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH-next v3] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Message-ID: <YbzVMURu2b2/++yi@linutronix.de>
References: <20211214144412.447035-1-longman@redhat.com>
 <Ybx3ubNFfGpCqhn0@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ybx3ubNFfGpCqhn0@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-17 12:42:51 [+0100], To Waiman Long wrote:
> On 2021-12-14 09:44:12 [-0500], Waiman Long wrote:
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2096,7 +2096,12 @@ struct obj_stock {

so I made something based on this. Let me clean this up and test it
first. So it is just a heads up :)

Sebastian
