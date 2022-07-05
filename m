Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B665678D8
	for <lists+cgroups@lfdr.de>; Tue,  5 Jul 2022 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiGEUz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGEUz0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 16:55:26 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9A13FBB;
        Tue,  5 Jul 2022 13:55:24 -0700 (PDT)
Date:   Tue, 5 Jul 2022 13:55:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657054523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhLg0Cla8ai3X3/kkktyXt1O9nP6eFUzBhnC95wXg1g=;
        b=boaUMGQrEYaa64Ejun5RDXRXFn8PWPBU1pEwrfi8rXGvOFIimvDtjTADvibcbOTMbTMh7C
        m1tF2o0DFhgshmtR/vEjYI1ipC8YECkYlXg0qma7hbvcvuvC00ejkH4eFLHO+KPFS7yp8i
        ieZLyzDLzT0sps0jmhOT0b7o4jzy4eU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsSlNbKuprI97TtF@castle>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <YsMDdjc5SXMAuV2l@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsMDdjc5SXMAuV2l@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 04, 2022 at 05:12:54PM +0200, Michal Hocko wrote:
> On Fri 01-07-22 20:35:21, Roman Gushchin wrote:
> > Yafang Shao reported an issue related to the accounting of bpf
> > memory: if a bpf map is charged indirectly for memory consumed
> > from an interrupt context and allocations are enforced, MEMCG_MAX
> > events are not raised.
> 
> So I guess this will be a GFP_ATOMIC request failing due to the hard
> limit, right? I think it would be easier to understand if the specific
> allocation request type was mentioned.

It all started from the discussion here:
https://www.spinics.net/lists/linux-mm/msg302319.html

Please, take a look.

> 
> > It's not/less of an issue in a generic case because consequent
> > allocations from a process context will trigger the reclaim and
> > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > memory cgroup, so it might never happen. So the cgroup can
> > significantly exceed the memory.max limit without even triggering
> > MEMCG_MAX events.
> 
> More on that in other reply.
> 
> > Fix this by making sure that we never enforce allocations without
> > raising a MEMCG_MAX event.
> > 
> > Reported-by: Yafang Shao <laoar.shao@gmail.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Muchun Song <songmuchun@bytedance.com>
> > Cc: cgroups@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: bpf@vger.kernel.org
> 
> The patch makes sense to me though even without the weird charge to a
> dead memcg aspect. It is true that a very calm memcg can trigger the
> even much later after a GFP_ATOMIC charge (or __GFP_HIGH in general)
> fails.

Good point!

> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
