Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355C4F4499
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 00:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiDEOKE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352628AbiDENHD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 09:07:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E48300A;
        Tue,  5 Apr 2022 05:08:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34FB4210EF;
        Tue,  5 Apr 2022 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649160503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYOi21VBdrnEfgCIXqKolf+TBqlw4Pd+D8zmojzTZKg=;
        b=IzlVwj1UBmMOQmHd3Zp7EfAXZmHByCFtW1hb2ofyTRxldgM0qGnGQd6hQt8jCSab/6KcQa
        DvpaN+BbZ0cPKEbNjPfbufOi006FMFq43iNjeXx+OsbgAgJLj9TyIVm1NfWnLhJysJp1ob
        x43XW5Auch1IHBKqWUSgRQ4Q6Do+kNI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 81C8CA3B89;
        Tue,  5 Apr 2022 12:08:22 +0000 (UTC)
Date:   Tue, 5 Apr 2022 14:08:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Message-ID: <YkwxNaJIg6ptJOYT@dhcp22.suse.cz>
References: <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
 <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
 <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
 <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-04-22 21:14:40, Zhaoyang Huang wrote:
[...]
> Please be noticed that this patch DOES protect the memcg when external
> pressure is 1GB as fixed low does.

This is getting more and more confusing (at least to me). Could you
describe the behavior of the reclaim for the following setups/situations?

a) mostly reclaiming a clean page cache - via kswapd
b) same as above but the direct reclaim is necessary but very
   lightweight
c) direct reclaim makes fwd progress but not enough to satisfy the
   allocation request (so the reclaim has to be retried)
d) direct reclaim not making progress and low limit protection is
   ignored.

Say we have several memcgs and only some have low memory protection
configured. What is the user observable state of the protected group and
when and how much the protection can be updated?

I think it would be also helpful to describe the high level semantic of
this feature.

> Besides, how does the admin decide
> the exact number of low/min if it expand from small to even xGB in a
> quick changing scenario?

This is not really related, is it? There are different ways to tune for
the protection.

[...]
-- 
Michal Hocko
SUSE Labs
