Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D864255E1F1
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiF0IZ2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiF0IZZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 04:25:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931E6178;
        Mon, 27 Jun 2022 01:25:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7099B21CA5;
        Mon, 27 Jun 2022 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656318322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdjZ81SzFUwlHNc7CnTKQAx6FQYkKfx1logzGP6DqeY=;
        b=rQn3PD59u/64iGg/OHUj9gw4KyNHEJJhftM7xBja/rSOmM8ZC6tWBdaQollFZlPepOguh2
        Mpv08kDiPaqVBYCA1o1BqfyhFONXhDb0HHGiObc2jGV4xOxMEcYIFP2F5RxWEZRIp2Hv7d
        s+u4et2mc6Wp4MixE9TzMgQ89j8F1zk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9CB892C141;
        Mon, 27 Jun 2022 08:25:21 +0000 (UTC)
Date:   Mon, 27 Jun 2022 10:25:21 +0200
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
Message-ID: <YrlpcdgF1HzA7bHS@dhcp22.suse.cz>
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
 <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
 <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz>
 <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz>
 <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-06-22 10:26:11, Yosry Ahmed wrote:
> On Thu, Jun 23, 2022 at 10:04 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 23-06-22 09:42:43, Shakeel Butt wrote:
> > > On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > > > > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > > > [...]
> > > > > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > > > > psi is handled upstream). We want to make sure this behavior also
> > > > > > > exists in the upstream version so that consolidating them does not
> > > > > > > break our users who rely on vmpressure and will start seeing increased
> > > > > > > pressure due to proactive reclaim.
> > > > > >
> > > > > > These are good reasons to have this patch in your tree. But why is this
> > > > > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > > > > some special casing which will add a maintenance overhead.
> > > > >
> > > > > It is not just Google, any existing vmpressure users will start seeing
> > > > > false pressure notifications with memory.reclaim. The main goal of the
> > > > > patch is to make sure memory.reclaim does not break pre-existing users
> > > > > of vmpressure, and doing it in a way that is consistent with psi makes
> > > > > sense.
> > > >
> > > > memory.reclaim is v2 only feature which doesn't have vmpressure
> > > > interface. So I do not see how pre-existing users of the upstream kernel
> > > > can see any breakage.
> > > >
> > >
> > > Please note that vmpressure is still being used in v2 by the
> > > networking layer (see mem_cgroup_under_socket_pressure()) for
> > > detecting memory pressure.
> >
> > I have missed this. It is hidden quite good. I thought that v2 is
> > completely vmpressure free. I have to admit that the effect of
> > mem_cgroup_under_socket_pressure is not really clear to me. Not to
> > mention whether it should or shouldn't be triggered for the user
> > triggered memory reclaim. So this would really need some explanation.
> 
> vmpressure was tied into socket pressure by 8e8ae645249b ("mm:
> memcontrol: hook up vmpressure to socket pressure"). A quick look at
> the commit log and the code suggests that this is used all over the
> socket and tcp code to throttles the memory consumption of the
> networking layer if we are under pressure.
> 
> However, for proactive reclaim like memory.reclaim, the target is to
> probe the memcg for cold memory. Reclaiming such memory should not
> have a visible effect on the workload performance. I don't think that
> any network throttling side effects are correct here.

Please describe the user visible effects of this change. IIUC this is
changing the vmpressure semantic for pre-existing users (v1 when setting
the hard limit for example) and it really should be explained why
this is good for them after those years. I do not see any actual bug
being described explicitly so please make sure this is all properly
documented.

-- 
Michal Hocko
SUSE Labs
