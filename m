Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E293B4ED893
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiCaLhH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCaLhG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 07:37:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0363A206EDC;
        Thu, 31 Mar 2022 04:35:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B479E1F37D;
        Thu, 31 Mar 2022 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648726518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iGRqDVWtIbClXX9jVOMp8RjR3wfp+eidE5p7MXuygs=;
        b=eSREMlixUKn6FkfFx7u1sXdAW8YfxbXQ50cR770VPYQGAn1vhhuQOVHNRs+0p7rOT0z1z2
        eAxqWj82Yt9i2/1Wl6gtsjymIYuNLpYZFT5Qv7KDDzAcVu+uwKE5w0U4rTjh0KYXb0G3gF
        vcqGFJUs6orzHF0kMWDD30ruR+xl34s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B8B2A3B87;
        Thu, 31 Mar 2022 11:35:18 +0000 (UTC)
Date:   Thu, 31 Mar 2022 13:35:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Ke Wang <ke.wang@unisoc.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Message-ID: <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz>
 <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > by loading an special algorithm into its virtual address space and make it hard
> > > to protect the expanded usage without userspace's interaction.
> >
> > Do I get it correctly that the concern you have is that you do not know
> > how much memory your workload will need because that depends on some
> > parameters?
> right. such as a camera APP will expand the usage from 50MB to 500MB
> because of launching a special function(face beauty etc need special
> algorithm)
> >
> > > Furthermore, fixed
> > > memory.low is a little bit against its role of soft protection as it will response
> > > any system's memory pressure in same way.
> >
> > Could you be more specific about this as well?
> As the camera case above, if we set memory.low as 200MB to keep the
> APP run smoothly, the system will experience high memory pressure when
> another high load APP launched simultaneously. I would like to have
> camera be reclaimed under this scenario.

OK, so you effectivelly want to keep the memory protection when there is
a "normal" memory pressure but want to relax the protection on other
high memory utilization situations?

How do you exactly tell a difference between a steady memory pressure
(say stream IO on the page cache) from "high load APP launched"? Should
you reduce the protection on the stram IO situation as well?

[...]
> > One very important thing that I am missing here is the overall objective of this
> > tuning. From the above it seems that you want to (ab)use memory->low to
> > protect some portion of the charged memory and that the protection
> > shrinks over time depending on the the global PSI metrict and time.
> > But why this is a good thing?
> 'Good' means it meets my original goal of keeping the usage during a
> period of time and responding to the system's memory pressure. For an
> android like system, memory is almost forever being in a tight status
> no matter how many RAM it has. What we need from memcg is more than
> control and grouping, we need it to be more responsive to the system's
> load and could  sacrifice its usage  under certain criteria.

Why existing tools/APIs are insufficient for that? You can watch for
both global and memcg memory pressure including PSI metrics and update
limits dynamically. Why is it necessary to put such a logic into the
kernel?

-- 
Michal Hocko
SUSE Labs
