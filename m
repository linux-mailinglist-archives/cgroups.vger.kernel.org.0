Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323024F815E
	for <lists+cgroups@lfdr.de>; Thu,  7 Apr 2022 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiDGORT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDGORT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 10:17:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF428E33;
        Thu,  7 Apr 2022 07:15:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0EEFE1F85E;
        Thu,  7 Apr 2022 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649340899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKwrr1idTmWArX2lqn5YORjBOhR4BKEAOp87gdFGmAs=;
        b=JJOWpMh04HvpMRV9OHslNnYorECxh2BD2x5KOqtVFuXhlvMJYVYdpOespQ8gzdXuS+vIbr
        xcez1y5fivmjExddn6mXf7iZ7mev5ZvAdim89+c+9N8W2INFFncr1rhx9538zF0O2NhH+2
        neOak+Z7R28zFIrQW/wC8IqrTMRVydg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75EEAA3B87;
        Thu,  7 Apr 2022 14:14:58 +0000 (UTC)
Date:   Thu, 7 Apr 2022 16:14:57 +0200
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
Message-ID: <Yk7x4U5gTvS4/ijR@dhcp22.suse.cz>
References: <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
 <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
 <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
 <YkwxNaJIg6ptJOYT@dhcp22.suse.cz>
 <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
 <Yk6VZlGnB48RqnYW@dhcp22.suse.cz>
 <CAGWkznG+V88f_DjtJAe4_Nr=32Q7Z4b1CaBCB0FVqhAAsuNsWA@mail.gmail.com>
 <Yk6ya5Ks0H6rHPx4@dhcp22.suse.cz>
 <CAGWkznH1NhfDXy94cOs0YWnw_uOOVbcbrygT5X6CAZ44CTf78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznH1NhfDXy94cOs0YWnw_uOOVbcbrygT5X6CAZ44CTf78Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 07-04-22 20:36:51, Zhaoyang Huang wrote:
> On Thu, Apr 7, 2022 at 5:44 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [...]
> > On Thu 07-04-22 16:59:50, Zhaoyang Huang wrote:
> > > > This means that limits are altered even if there is memory to be
> > > > reclaimed from other memcgs. Why? How does this line up with the
> > > > basic property of the low limit to act as a protection from the reclaim?
> > > ok, partially understand. I would like to say that low's original
> > > definition under this patch has changed, says the calculated low just
> > > provide protection when the psi value is lower than the setting and
> > > will introduce reclaiming if it exceed.
> >
> > OK, I guess I finally get to understand what you are trying to say. So
> > effectivelly your new semantic defines the low limit as an initial
> > protection that is very soft and only preserved under a light global
> > memory pressure[1]. If the reclaim pressure is higher the user provided
> > protection is decreased. The new semantic is planned to be a global
> > opt-in.
> >
> > Correct?
> right. But I don't think the original protection is soft which could
> be proved by the test result that the memcg is protected in a certain
> range of pressure and could also help to release the system by
> breaking low limit.

Low limit protection is considered soft because it doesn't provide any
guarantee. I will be ignored (and that will be reported to the userspace
via LOW event) if there is nothing reclaimable in the scope of the
reclaimed hierarchy. An alternative would be OOM actually.

> > Now, that I (believe) to have a slightly better understanding I have to
> > say I really dislike the idea.
> > First of all the new semantic would have to be memcg reclaim aware. That
> > means that the scaling logic would need to be aware where the memory
> > pressure comes from.
> I don't follow. Does it mean that the protected should distinguish the
> pressure from global and other memcgs? I don't know why.

No, it should behave consistently for any external memory pressure.
A reclaimed memcg can apply different constraint depending on the root
of the reclaim. Your solution is considering root to be root_memcg.

[...]
-- 
Michal Hocko
SUSE Labs
