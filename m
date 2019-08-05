Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3381F26
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfHEOcm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 10:32:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbfHEOcm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Aug 2019 10:32:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2405AF3E;
        Mon,  5 Aug 2019 14:32:40 +0000 (UTC)
Date:   Mon, 5 Aug 2019 16:32:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190805143239.GS7597@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz>
 <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz>
 <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
 <20190729184850.GH9330@dhcp22.suse.cz>
 <CAHbLzkp9xFV2sE0TdKfWNRVcAwaYNKwDugRiBBoEKx6A_Hr3Jw@mail.gmail.com>
 <20190802093507.GF6461@dhcp22.suse.cz>
 <CAHbLzkrjh7KEvdfXackaVy8oW5CU=UaBucERffxcUorgq1vdoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrjh7KEvdfXackaVy8oW5CU=UaBucERffxcUorgq1vdoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 02-08-19 11:56:28, Yang Shi wrote:
> On Fri, Aug 2, 2019 at 2:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 01-08-19 14:00:51, Yang Shi wrote:
> > > On Mon, Jul 29, 2019 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Mon 29-07-19 10:28:43, Yang Shi wrote:
> > > > [...]
> > > > > I don't worry too much about scale since the scale issue is not unique
> > > > > to background reclaim, direct reclaim may run into the same problem.
> > > >
> > > > Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
> > > > You can have thousands of memcgs and I do not think we really do want
> > > > to create one kswapd for each. Once we have a kswapd thread pool then we
> > > > get into a tricky land where a determinism/fairness would be non trivial
> > > > to achieve. Direct reclaim, on the other hand is bound by the workload
> > > > itself.
> > >
> > > Yes, I agree thread pool would introduce more latency than dedicated
> > > kswapd thread. But, it looks not that bad in our test. When memory
> > > allocation is fast, even though dedicated kswapd thread can't catch
> > > up. So, such background reclaim is best effort, not guaranteed.
> > >
> > > I don't quite get what you mean about fairness. Do you mean they may
> > > spend excessive cpu time then cause other processes starvation? I
> > > think this could be mitigated by properly organizing and setting
> > > groups. But, I agree this is tricky.
> >
> > No, I meant that the cost of reclaiming a unit of charges (e.g.
> > SWAP_CLUSTER_MAX) is not constant and depends on the state of the memory
> > on LRUs. Therefore any thread pool mechanism would lead to unfair
> > reclaim and non-deterministic behavior.
> 
> Yes, the cost depends on the state of pages, but I still don't quite
> understand what does "unfair" refer to in this context. Do you mean
> some cgroups may reclaim much more than others?

> Or the work may take too long so it can't not serve other cgroups in time?

exactly.
-- 
Michal Hocko
SUSE Labs
