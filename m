Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15F33C6E6
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhCOTfW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 15:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233709AbhCOTfR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 15:35:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02D9164F4B;
        Mon, 15 Mar 2021 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615836917;
        bh=WTbVaWsn2s6L40UENjvSIP12aHJ+ixP4fEvzAyMwqdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9U3lx/SRExGNl7ANONDuDDsz1cwP6og9RBlgLxmJt4k6lsk1KW4zl7F7oRpdv2nI
         1lCuP+7sRGjGRZ1gh1PMqr+vBmkB1hVIS0vinUPxFxHHMG4m3Pqyo7xXdsp1GbConZ
         20Jx7Xmza4070aeJBRf+7t6pE0A4G7/1szsLQPfbQeDtIziTdk9WJvsAGx4BlCRViu
         SZeUccNGREYMqlurXWLft5HmfWpoDq6LJL0xay+tWxTqEWaHQ0Iv20WitZOf4fJ+6k
         1onK0XWAcycey/B3fS9UfoxB7glddVb7fmYZLbIt0hv7HHBQ7nLA6YJVGjVaD+i0EC
         OXgVmxXknEk8Q==
Date:   Mon, 15 Mar 2021 12:35:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
Message-ID: <20210315123516.6264ba0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <YE+2N0zb9wKTriDH@carbon.dhcp.thefacebook.com>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
        <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
        <20210315100942.3cc98bb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CALvZod4ct6X_M1fzKufX1jKoO2JEE_ONwEmiDWTbpt-fut85yA@mail.gmail.com>
        <YE+2N0zb9wKTriDH@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 15 Mar 2021 12:32:07 -0700 Roman Gushchin wrote:
> On Mon, Mar 15, 2021 at 12:24:31PM -0700, Shakeel Butt wrote:
> > On Mon, Mar 15, 2021 at 10:09 AM Jakub Kicinski <kuba@kernel.org> wrote:  
> > > Sorry for a random question, I didn't get the cover letter.
> > >
> > > What's the overhead of adding SLAB_ACCOUNT?
> > 
> > The potential overhead is for MEMCG users where we need to
> > charge/account each allocation from SLAB_ACCOUNT kmem caches. However
> > charging is done in batches, so the cost is amortized. If there is a
> > concern about a specific workload then it would be good to see the
> > impact of this patch for that workload.
> >   
> > > Please make sure you CC netdev on series which may impact networking.  
> 
> In general the overhead is not that big, so I don't think we should argue
> too much about every new case where we want to enable the accounting and
> rather focus on those few examples (if any?) where it actually hurts
> the performance in a meaningful way.

Ack, no serious concerns about this particular case.

I was expecting you'd have micro benchmark numbers handy so I was
curious to learn what they are, but that appears not to be the case.
