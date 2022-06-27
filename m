Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0C55C15F
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiF0JUU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiF0JUS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 05:20:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7963C9;
        Mon, 27 Jun 2022 02:20:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 796ED1F8AC;
        Mon, 27 Jun 2022 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656321616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ip8pLkFfGo3udAybET0DcFxP24OgBPosKfbnpHmeU5g=;
        b=g/XzIsEKNH7ZBTbbN8VhSwNb+dPzHHR+Ke1jfbeOQtFY92SL3NWbl4eLtT50+EFSR5OW/F
        4WTK+6mgSOqi47vyGeFnDKJ7AkAlCQvm8nVdqvYJUY26kIbSLl+aYYLp3eYvzzLZ5bRIpS
        KmIDnjQYBfa5FpvUxj31f71rmewzbpY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ED6692C141;
        Mon, 27 Jun 2022 09:20:15 +0000 (UTC)
Date:   Mon, 27 Jun 2022 11:20:15 +0200
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
Message-ID: <Yrl2T632Vfv8QGPn@dhcp22.suse.cz>
References: <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
 <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
 <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz>
 <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz>
 <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz>
 <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 27-06-22 01:39:46, Yosry Ahmed wrote:
> On Mon, Jun 27, 2022 at 1:25 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 23-06-22 10:26:11, Yosry Ahmed wrote:
> > > On Thu, Jun 23, 2022 at 10:04 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 23-06-22 09:42:43, Shakeel Butt wrote:
> > > > > On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > > > > > > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > >
> > > > > > > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > > > > > [...]
> > > > > > > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > > > > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > > > > > > psi is handled upstream). We want to make sure this behavior also
> > > > > > > > > exists in the upstream version so that consolidating them does not
> > > > > > > > > break our users who rely on vmpressure and will start seeing increased
> > > > > > > > > pressure due to proactive reclaim.
> > > > > > > >
> > > > > > > > These are good reasons to have this patch in your tree. But why is this
> > > > > > > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > > > > > > some special casing which will add a maintenance overhead.
> > > > > > >
> > > > > > > It is not just Google, any existing vmpressure users will start seeing
> > > > > > > false pressure notifications with memory.reclaim. The main goal of the
> > > > > > > patch is to make sure memory.reclaim does not break pre-existing users
> > > > > > > of vmpressure, and doing it in a way that is consistent with psi makes
> > > > > > > sense.
> > > > > >
> > > > > > memory.reclaim is v2 only feature which doesn't have vmpressure
> > > > > > interface. So I do not see how pre-existing users of the upstream kernel
> > > > > > can see any breakage.
> > > > > >
> > > > >
> > > > > Please note that vmpressure is still being used in v2 by the
> > > > > networking layer (see mem_cgroup_under_socket_pressure()) for
> > > > > detecting memory pressure.
> > > >
> > > > I have missed this. It is hidden quite good. I thought that v2 is
> > > > completely vmpressure free. I have to admit that the effect of
> > > > mem_cgroup_under_socket_pressure is not really clear to me. Not to
> > > > mention whether it should or shouldn't be triggered for the user
> > > > triggered memory reclaim. So this would really need some explanation.
> > >
> > > vmpressure was tied into socket pressure by 8e8ae645249b ("mm:
> > > memcontrol: hook up vmpressure to socket pressure"). A quick look at
> > > the commit log and the code suggests that this is used all over the
> > > socket and tcp code to throttles the memory consumption of the
> > > networking layer if we are under pressure.
> > >
> > > However, for proactive reclaim like memory.reclaim, the target is to
> > > probe the memcg for cold memory. Reclaiming such memory should not
> > > have a visible effect on the workload performance. I don't think that
> > > any network throttling side effects are correct here.
> >
> > Please describe the user visible effects of this change. IIUC this is
> > changing the vmpressure semantic for pre-existing users (v1 when setting
> > the hard limit for example) and it really should be explained why
> > this is good for them after those years. I do not see any actual bug
> > being described explicitly so please make sure this is all properly
> > documented.
> 
> In cgroup v1, user-induced reclaim that is caused by limit-setting (or
> memory.reclaim for systems that choose to expose it in cgroup v1) will
> no longer cause vmpressure notifications, which makes the vmpressure
> behavior consistent with the current psi behavior.

Yes it makes the behavior consistent with PSI. But is this what existing
users really want or need? This is a user visible long term behavior
change for a legacy interface and there should be a very good reason to
change that.

> In cgroup v2, user-induced reclaim (limit-setting, memory.reclaim, ..)
> would currently cause the networking layer to perceive the memcg as
> being under memory pressure, reducing memory consumption and possibly
> causing throttling. This patch makes the networking layer only
> perceive the memcg as being under pressure when the "pressure" is
> caused by increased memory usage, not limit-setting or proactive
> reclaim, which also makes the definition of memcg memory pressure
> consistent with psi today.

I do understand the argument about the pro-active reclaim.
memory.reclaim is a new interface and it a) makes sense to exclude it
from different memory pressure notification interfaces and b) there are
unlikely too many user applications depending on the exact behavior so
changes are still rather low on the risk scale.

> In short, the purpose of this patch is to unify the definition of
> memcg memory pressure across psi and vmpressure (which indirectly also
> defines the definition of memcg memory pressure for the networking
> layer). If this sounds good to you, I can add this explanation to the
> commit log, and possibly anywhere you see appropriate in the
> code/docs.

The consistency on its own sounds like a very weak argument to change a
long term behavior. I do not really see any serious arguments or
evaluation what kind of fallout this change can have on old applications
that are still sticking with v1.

After it has been made clear that the vmpressure is still used for the
pro-active reclaim in v2 I do agree that this is likely something we
want to have addressed. But I wouldn't touch v1 semantics as this
doesn't really buy much and it can potentially break existing users.

-- 
Michal Hocko
SUSE Labs
