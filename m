Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF0569C10
	for <lists+cgroups@lfdr.de>; Thu,  7 Jul 2022 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiGGHra (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jul 2022 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGGHrW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jul 2022 03:47:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7A32EE5;
        Thu,  7 Jul 2022 00:47:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C03C01FA93;
        Thu,  7 Jul 2022 07:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657180036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEd2Na7ZICW0cPoFXBq3xNRf0e9K1vxcQxK9+w/pQcI=;
        b=hCVarrs4y/FY6SmlaBkGnrAWX3Sk5hubEwYhKsTJb62VdDHL+aJngsV0bEiPEOfhy/YYhV
        oBReVvZuCQeBjWbP7T6ZvocSNnsTZzkkRNq3CQvD4pqTp/MXqTc9q9Xe7CHeSDWm44VhDR
        5aGIVC7go5KC9Z14yDAq0U1DJsFK+E4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 48B112C141;
        Thu,  7 Jul 2022 07:47:16 +0000 (UTC)
Date:   Thu, 7 Jul 2022 09:47:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsaPhF1KQFe+ses0@dhcp22.suse.cz>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle>
 <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsMHkXJ0vAPG0lyM@dhcp22.suse.cz>
 <YsSkaiL00Jk45zNd@castle>
 <CALOAHbBrctf_wOiAxUvXD0JSjgEV46YdDQh9QnUK0XZ+Jsapnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBrctf_wOiAxUvXD0JSjgEV46YdDQh9QnUK0XZ+Jsapnw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 06-07-22 10:40:48, Yafang Shao wrote:
> On Wed, Jul 6, 2022 at 4:52 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Mon, Jul 04, 2022 at 05:30:25PM +0200, Michal Hocko wrote:
> > > On Mon 04-07-22 17:07:32, Michal Hocko wrote:
> > > > On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > > > > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > > > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > > >
> > > > > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > > > > events are not raised.
> > > > > > >
> > > > > > > It's not/less of an issue in a generic case because consequent
> > > > > > > allocations from a process context will trigger the reclaim and
> > > > > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > > > > memory cgroup, so it might never happen.
> > > > > >
> > > > > > The patch looks good but the above sentence is confusing. What might
> > > > > > never happen? Reclaim or MAX event on dying memcg?
> > > > >
> > > > > Direct reclaim and MAX events. I agree it might be not clear without
> > > > > looking into the code. How about something like this?
> > > > >
> > > > > "It's not/less of an issue in a generic case because consequent
> > > > > allocations from a process context will trigger the direct reclaim
> > > > > and MEMCG_MAX events will be raised. However a bpf map can belong
> > > > > to a dying/abandoned memory cgroup, so there will be no allocations
> > > > > from a process context and no MEMCG_MAX events will be triggered."
> > > >
> > > > Could you expand little bit more on the situation? Can those charges to
> > > > offline memcg happen indefinetely? How can it ever go away then? Also is
> > > > this something that we actually want to encourage?
> > >
> > > One more question. Mostly out of curiosity. How is userspace actually
> > > acting on those events? Are watchers still active on those dead memcgs?
> >
> > Idk, the whole problem was reported by Yafang, so he probably has a better
> > answer. But in general events are recursive and the cgroup doesn't have
> > to be dying, it can be simple abandoned.
> >
> 
> Regarding the pinned bpf programs, it can run without a user agent.
> That means the cgroup may not be dead, but just not populated.
> (But in our case, the cgroup will be deleted after the user agent exits.)

OK, that makes sense.
-- 
Michal Hocko
SUSE Labs
