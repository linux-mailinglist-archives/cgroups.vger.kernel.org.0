Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66856411A
	for <lists+cgroups@lfdr.de>; Sat,  2 Jul 2022 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiGBPjX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Jul 2022 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiGBPjW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Jul 2022 11:39:22 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79512DF9B;
        Sat,  2 Jul 2022 08:39:21 -0700 (PDT)
Date:   Sat, 2 Jul 2022 08:39:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656776359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Mn01W+SjwBjTn12n10GHRZZyUQBH10vGdvggjcJ1qs=;
        b=HIxjJQ6kAfQ4qFBJiQMXQqA5XoW5kIByLOCqrrv43dTBhhkqGXj71clYdGrgGSkQ8fTPHs
        +0zeQ/LTl3Fc9bymjfIe8zjjj5SbqMyzTR+zCvm2055leF61d9LbY9Gwgfqt6hXhs6ezJV
        +yvTV3vI5vzTcHRkZ//6g8yN/hduJ54=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsBmoqEBCa7ra7w2@castle>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
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

On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Yafang Shao reported an issue related to the accounting of bpf
> > memory: if a bpf map is charged indirectly for memory consumed
> > from an interrupt context and allocations are enforced, MEMCG_MAX
> > events are not raised.
> >
> > It's not/less of an issue in a generic case because consequent
> > allocations from a process context will trigger the reclaim and
> > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > memory cgroup, so it might never happen.
> 
> The patch looks good but the above sentence is confusing. What might
> never happen? Reclaim or MAX event on dying memcg?

Direct reclaim and MAX events. I agree it might be not clear without
looking into the code. How about something like this?

"It's not/less of an issue in a generic case because consequent
allocations from a process context will trigger the direct reclaim
and MEMCG_MAX events will be raised. However a bpf map can belong
to a dying/abandoned memory cgroup, so there will be no allocations
from a process context and no MEMCG_MAX events will be triggered."

Thanks!
