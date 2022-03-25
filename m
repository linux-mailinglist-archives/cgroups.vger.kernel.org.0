Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC74E73C0
	for <lists+cgroups@lfdr.de>; Fri, 25 Mar 2022 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351013AbiCYMvm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Mar 2022 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242879AbiCYMvl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Mar 2022 08:51:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9865820;
        Fri, 25 Mar 2022 05:50:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD771210F1;
        Fri, 25 Mar 2022 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648212604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9k72q4nGxTZAjXFEZ3O4X+oiukJzFsmhEYIKREvjY4=;
        b=Orc9+Oa8vO07QT9vWpudH/xLJRCJV4ACZ1UzXBWsZ075CvmEEv9RklCIYYfU8tpcvGlSfs
        wQrd7Gr3sORgQ9cdVHZLTMTm7X/EehcTpc8lkeim5gbrdGP7E7qK/Aw61CuJ3rh48/eMjY
        lopuxx+qN2k8ovkkWyPfVAHjtYQMadg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C50E3A3B82;
        Fri, 25 Mar 2022 12:50:02 +0000 (UTC)
Date:   Fri, 25 Mar 2022 13:49:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        ke wang <ke.wang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: introduce proportional protection on memcg
Message-ID: <Yj26d7eQ2DHXqiE4@dhcp22.suse.cz>
References: <1648113743-32622-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yjx/3yi7BfH7wLPz@chrisdown.name>
 <CAGWkznGLO7xpQK7E07dLv7ZfO53nx2fn54tVNw7-b46QnzKwkA@mail.gmail.com>
 <CAGWkznGAmML4XB0t5jOZEoafQrFk=gXvP96Lmgh221Y22bUuyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGAmML4XB0t5jOZEoafQrFk=gXvP96Lmgh221Y22bUuyw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 25-03-22 11:08:00, Zhaoyang Huang wrote:
> On Fri, Mar 25, 2022 at 11:02 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Thu, Mar 24, 2022 at 10:27 PM Chris Down <chris@chrisdown.name> wrote:
> > >
> > > I'm confused by the aims of this patch. We already have proportional reclaim
> > > for memory.min and memory.low, and memory.high is already "proportional" by its
> > > nature to drive memory back down behind the configured threshold.
> > >
> > > Could you please be more clear about what you're trying to achieve and in what
> > > way the existing proportional reclaim mechanisms are insufficient for you?
> 
> sorry for the bad formatting of previous reply, resend it in new format
> 
>  What I am trying to solve is that, the memcg's protection judgment[1]
>  is based on a set of fixed value on current design, while the real
>  scan and reclaim number[2] is based on the proportional min/low on the
>  real memory usage which you mentioned above. Fixed value setting has
>  some constraints as
>  1. It is an experienced value based on observation, which could be inaccurate.
>  2. working load is various from scenarios.
>  3. fixed value from [1] could be against the dynamic cgroup_size in [2].

Could you elaborate some more about those points. I guess providing an
example how you are using the new interface instead would be helpful.
-- 
Michal Hocko
SUSE Labs
