Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB31479512
	for <lists+cgroups@lfdr.de>; Fri, 17 Dec 2021 20:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhLQTsv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Dec 2021 14:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhLQTsv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Dec 2021 14:48:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDCC061574;
        Fri, 17 Dec 2021 11:48:51 -0800 (PST)
Date:   Fri, 17 Dec 2021 20:48:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639770528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOhtWEVpE/nHvAfkcQxgjTO8DE1E/CE1cP2TvinWtt8=;
        b=usmzDClfjRh8F0bmnhmCivgUEzP3w2hcvpAvIrtYeBpsuLRJn+4DKo6fxqVSJatueqh/bL
        y1U2c4vzTmXRimDg8GVoBZvKtFqEsvVdMgGej6G+EsDFhT6W1diHNgOIC0KfMfDjz5E2FR
        LWiq5pgDeVvuMmhGNiV9JI4DhVFmCJsTUFwyFHUab0bBZlhSSIZ2p4TXkp81D4DCO0Q8/D
        EuJEQqKeReqTl4+hXBoQ8YifN5FDSYOaMWrWNq9b2jedjnGk4vLa7oJhW6jbL2Ajeycnmm
        xF2VpEjm7wkrWwBTi+0oC4IPzUPaxG3GIo2P4qGbXGEE7KUOGmmWiY2Hg7lQqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639770528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOhtWEVpE/nHvAfkcQxgjTO8DE1E/CE1cP2TvinWtt8=;
        b=/FtWHAeSunsf+hn8FNtZSk94a8f3FndZKtc38HIXjF5iIq4qp6jb4YV269837n+ncw/jYU
        wuiXPn983+tX6xDQ==
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
Message-ID: <Ybzpn59+ecDCnULt@linutronix.de>
References: <20211214144412.447035-1-longman@redhat.com>
 <Ybx3ubNFfGpCqhn0@linutronix.de>
 <b82efbad-1eb2-9441-ab0b-cbb3d2b5eac6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b82efbad-1eb2-9441-ab0b-cbb3d2b5eac6@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-17 13:46:53 [-0500], Waiman Long wrote:
> > annotation. Looking at the history, I'm also impressed by that fact that
> > disabling/ enabling interrupts is *so* expensive that all this is
> > actually worth it.
> 
> For !RT with voluntary or no preemption, preempt_disable() is just a
> compiler barrier. So it is definitely cheaper than disabling interrupt. The
> performance benefit is less with preemptible but !RT kernel. Microbenchmark
> testing shows a performance improvement of a few percents depending on the
> exact benchmark.

Thanks for confirming. I got the feeling that this optimisation is for
!CONFIG_PREEMPTION. So I instead of depending on CONFIG_PREEMPT_RT I'm
leaning towards CONFIG_PREEMPT instead.

> Cheers,
> Longman

Sebastian
