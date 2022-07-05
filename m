Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CEC5678D2
	for <lists+cgroups@lfdr.de>; Tue,  5 Jul 2022 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGEUwR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGEUwP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 16:52:15 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91AA1B1;
        Tue,  5 Jul 2022 13:52:10 -0700 (PDT)
Date:   Tue, 5 Jul 2022 13:51:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657054328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XQLP0LMyl8MnEcyS+UNpbGDzxmEbywyn31NiQU5Lx0=;
        b=JSr8O0thgf/8K240RoHRwhrkNoV024GJhwM/fP5acSkn/ZlhiUCb5TdczmMwSDNlrpGuXu
        G7GwKy3IX13X5RNdKmf5nh9Zu48Mq1X/TRdewiKS5uZfzwpdcZ1Oxrp+bp6rhrbcaN46Pj
        xjy2u5+H4Mk43OwREgYrJ00f2vBjN8E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsSkaiL00Jk45zNd@castle>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle>
 <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsMHkXJ0vAPG0lyM@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsMHkXJ0vAPG0lyM@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 04, 2022 at 05:30:25PM +0200, Michal Hocko wrote:
> On Mon 04-07-22 17:07:32, Michal Hocko wrote:
> > On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > >
> > > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > > events are not raised.
> > > > >
> > > > > It's not/less of an issue in a generic case because consequent
> > > > > allocations from a process context will trigger the reclaim and
> > > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > > memory cgroup, so it might never happen.
> > > > 
> > > > The patch looks good but the above sentence is confusing. What might
> > > > never happen? Reclaim or MAX event on dying memcg?
> > > 
> > > Direct reclaim and MAX events. I agree it might be not clear without
> > > looking into the code. How about something like this?
> > > 
> > > "It's not/less of an issue in a generic case because consequent
> > > allocations from a process context will trigger the direct reclaim
> > > and MEMCG_MAX events will be raised. However a bpf map can belong
> > > to a dying/abandoned memory cgroup, so there will be no allocations
> > > from a process context and no MEMCG_MAX events will be triggered."
> > 
> > Could you expand little bit more on the situation? Can those charges to
> > offline memcg happen indefinetely? How can it ever go away then? Also is
> > this something that we actually want to encourage?
> 
> One more question. Mostly out of curiosity. How is userspace actually
> acting on those events? Are watchers still active on those dead memcgs?

Idk, the whole problem was reported by Yafang, so he probably has a better
answer. But in general events are recursive and the cgroup doesn't have
to be dying, it can be simple abandoned.

Thanks!
