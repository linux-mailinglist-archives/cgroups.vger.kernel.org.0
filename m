Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054BC5614D7
	for <lists+cgroups@lfdr.de>; Thu, 30 Jun 2022 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiF3IWk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiF3IWZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 04:22:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF914328;
        Thu, 30 Jun 2022 01:22:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A57CD21CA3;
        Thu, 30 Jun 2022 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656577340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VazjpIcq3Rp1eYxn5z7a3G7XqRklXOW4+Iv+aLJycac=;
        b=Z4q7b7Tv2K4y6bML5JDMKNXAp/3cMhrw1YjTHkivEtZmt0HRHEcPn1LT7wVU5jJ+CuX9AX
        ZGMpT+XS8r5g90JtJgzl+AR29D1omYEZ+O9qayyZTh/y+Ubo1diTU+Y6QJjnphzSqTeo1E
        Fc1wPLLAl5HxlD1w1Y1Anr89gy5iC/E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF5A32C141;
        Thu, 30 Jun 2022 08:22:19 +0000 (UTC)
Date:   Thu, 30 Jun 2022 10:22:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
Message-ID: <Yr1dOxHo0HsyG2X7@dhcp22.suse.cz>
References: <YrSdFy3qYdG+rGR6@dhcp22.suse.cz>
 <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz>
 <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
 <Yrl2T632Vfv8QGPn@dhcp22.suse.cz>
 <CAJD7tkZzwzHq7Q7KKUdVSdO4LWTPkrGprp0Q-ze_SWhUd_mTMw@mail.gmail.com>
 <YrmjH2FZF7iNn8da@dhcp22.suse.cz>
 <CAJD7tkYemNQqu_O2nYG3cqxPWGELvc6Lh5i+KKNCtv6cgSPmdA@mail.gmail.com>
 <CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com>
 <CAJD7tkZeySa9V+nuoGfmugrOcxaiaXFspPKLkgTFkvsrri=J3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZeySa9V+nuoGfmugrOcxaiaXFspPKLkgTFkvsrri=J3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 29-06-22 19:08:42, Yosry Ahmed wrote:
> On Wed, Jun 29, 2022 at 6:07 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 10:04 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 5:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > [...]
> > > >
> > > > I can see clear arguments for memory.reclaim opt out for vmpressure
> > > > because we have established that this is not a measure to express a
> > > > memory pressure on the cgroup.
> > > >
> > > > Max/High are less clear to me, TBH. I do understand reasoning for PSI
> > > > exclusion because considering the calling process to be stalled and
> > > > non-productive is misleading. It just does its work so in a way it is
> > > > a productive time in the end. For the vmpressure, which measures how
> > > > hard/easy it is to reclaim memory why this should special for this
> > > > particular reclaim?
> > > >
> > > > Again, an explanation of the effect on the socket pressure could give a
> > > > better picture. Say that I somebody reduces the limit (hard/high) and it
> > > > takes quite some effort to shrink the consumption down. Should the
> > > > networking layer react to that in any way or should it wait for the
> > > > active allocation during that process to find that out?
> > >
> > > I am out of my depth here. Any answer on my side would be purely
> > > speculation at this point. Shakeel, can you help us here or tag some
> > > networking people?
> >
> > So, the effect of returning true from mem_cgroup_under_socket_pressure() are:
> >
> > 1. Reducing send and receive buffers of the current socket.
> > 2. May drop packets on the rx path.
> > 3. May throttle current thread on the tx path.
> >
> > Now regarding the behavior from the reclaim due to reducing max or
> > high, I think the kernel should not ignore vmpressure. Please note
> > that unlike PSI which is associated with the current process,
> > vmpressure is associated with the target memcg. So, any reclaim on
> > that memcg due to real shortage of memory should not be ignored. That
> > reclaim can be global reclaim or limit reclaim of ancestor or itself
> > or reclaim due to lowering the limit of ancestor or itself.
> 
> So it seems like we should only ignore vmpressure for proactive
> reclaim (aka memory.reclaim).
> 
> Michal, let me know what you think here, I can drop psi and
> limit-setting changes in v3 and basically just ignore vmpressure for
> memory.reclaim (MEMCG_RECLAIM_PROACTIVE / sc->proactive instead of
> MEMCG_RECLAIM_CONTROLLED / sc->controlled maybe).

Yes, that makes much more sense to me.

-- 
Michal Hocko
SUSE Labs
