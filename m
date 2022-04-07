Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7618B4F7C03
	for <lists+cgroups@lfdr.de>; Thu,  7 Apr 2022 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbiDGJqT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbiDGJqS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 05:46:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9AA9959;
        Thu,  7 Apr 2022 02:44:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B19DC1F859;
        Thu,  7 Apr 2022 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649324657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tNtnnv47l8kZs+TIL27Yd98JmTykdLmyWqvUcwUs4bc=;
        b=YvvqO5eCoJkTrKNvr0LemmEccjLFQD1q52bnbwoUP3Mp3BSM0wXsKR1i2bKn+G/Lp/LxJE
        UVUxyUL2mSlYBW0+xJmnPTkHgfVj2gOmG99QBtG6XoZNM1xnBiBLjkHX6XmcHZBavCuIiO
        6FU6nqP6u4FkABX4cukU832lSUGRxPY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62F8BA3B87;
        Thu,  7 Apr 2022 09:44:15 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:44:11 +0200
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
Message-ID: <Yk6ya5Ks0H6rHPx4@dhcp22.suse.cz>
References: <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
 <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
 <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
 <YkwxNaJIg6ptJOYT@dhcp22.suse.cz>
 <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
 <Yk6VZlGnB48RqnYW@dhcp22.suse.cz>
 <CAGWkznG+V88f_DjtJAe4_Nr=32Q7Z4b1CaBCB0FVqhAAsuNsWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznG+V88f_DjtJAe4_Nr=32Q7Z4b1CaBCB0FVqhAAsuNsWA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[...]
On Thu 07-04-22 16:59:50, Zhaoyang Huang wrote:
> > This means that limits are altered even if there is memory to be
> > reclaimed from other memcgs. Why? How does this line up with the
> > basic property of the low limit to act as a protection from the reclaim?
> ok, partially understand. I would like to say that low's original
> definition under this patch has changed, says the calculated low just
> provide protection when the psi value is lower than the setting and
> will introduce reclaiming if it exceed.

OK, I guess I finally get to understand what you are trying to say. So
effectivelly your new semantic defines the low limit as an initial
protection that is very soft and only preserved under a light global
memory pressure[1]. If the reclaim pressure is higher the user provided
protection is decreased. The new semantic is planned to be a global
opt-in.

Correct?

Now, that I (believe) to have a slightly better understanding I have to
say I really dislike the idea.
First of all the new semantic would have to be memcg reclaim aware. That
means that the scaling logic would need to be aware where the memory
pressure comes from.
More importantnly I really dislike the idea that the user provided input
is updated by the kernel without userspace knowledge about that. How is
the userspace supposed to know that the value has been changed? 
I can see how the effective values could be scaled down but this still
sounds dubious as the userspace would have hard time to understand what
is going on under the cover or even worse tune the value based on the
specific observed behavior for a specific kernel which would make this a
maintenance burden going forward.

All that being said I have hard time to make sense of a protection which
is unpredictably decreasing based on a global metrics without any
userspace view into why and how this is done. So I am afraid I have to
NACK this and I really do recommend you to start a discussion about your
specific usecase and try to find a different solution.

Best regards


[1] this is based on the global PSI metric.
-- 
Michal Hocko
SUSE Labs
