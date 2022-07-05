Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD215678C8
	for <lists+cgroups@lfdr.de>; Tue,  5 Jul 2022 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiGEUvQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGEUvD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 16:51:03 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234731EC5E;
        Tue,  5 Jul 2022 13:50:02 -0700 (PDT)
Date:   Tue, 5 Jul 2022 13:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657054193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZL1inWFLGV9UgwEooxuzbRN3JK3YNLKuwki2WG5dOXg=;
        b=kCVke3t5FDKaxkIrHS1H/14RQTV84TwUH51/tbwRWowp4YhthXpkcyZ3YxaDl8vOo/RrLa
        azzizRzOZe9hDPtZ/UAxb/bpngZ0Fh8WxCI6hvlinXwwz45seWSxnVwKUmMevI7haVcE/4
        wZOGWoqbDcM9a1X75+iOQnG0k6Wh8OM=
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
Message-ID: <YsSj6rZmUkR8amT2@castle>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle>
 <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 04, 2022 at 05:07:30PM +0200, Michal Hocko wrote:
> On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > events are not raised.
> > > >
> > > > It's not/less of an issue in a generic case because consequent
> > > > allocations from a process context will trigger the reclaim and
> > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > memory cgroup, so it might never happen.
> > > 
> > > The patch looks good but the above sentence is confusing. What might
> > > never happen? Reclaim or MAX event on dying memcg?
> > 
> > Direct reclaim and MAX events. I agree it might be not clear without
> > looking into the code. How about something like this?
> > 
> > "It's not/less of an issue in a generic case because consequent
> > allocations from a process context will trigger the direct reclaim
> > and MEMCG_MAX events will be raised. However a bpf map can belong
> > to a dying/abandoned memory cgroup, so there will be no allocations
> > from a process context and no MEMCG_MAX events will be triggered."
> 
> Could you expand little bit more on the situation? Can those charges to
> offline memcg happen indefinetely?

Yes.

> How can it ever go away then?

Bpf map should be deleted by a user first.

> Also is this something that we actually want to encourage?

Not really. We can implement reparenting (probably objcg-based), I think it's
a good idea in general. I can take a look, but can't promise it will be fast.

In thory we can't forbid deleting cgroups with associated bpf maps, but I don't
thinks it's a good idea.

> In other words shouldn't those remote charges be redirected when the
> target memcg is offline?

Reparenting is the best answer I have.

Thanks!
