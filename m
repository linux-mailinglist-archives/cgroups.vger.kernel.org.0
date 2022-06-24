Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAA559ACE
	for <lists+cgroups@lfdr.de>; Fri, 24 Jun 2022 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiFXN7z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jun 2022 09:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFXN7y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jun 2022 09:59:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD34DF4A;
        Fri, 24 Jun 2022 06:59:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A0131F8BD;
        Fri, 24 Jun 2022 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656079192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2w1L23+IbYV6NN1uakoMnM4Ln36dQ8vdC1Lu+6qgUGE=;
        b=rnrxBaL9L5/alzpeiarh24yjJKETzL+5hZn/bNLXr9qnxJB4OputXmn+PQbI6yJrMHOWC1
        J8yvQ3ooToFm+hyLDaXikq8rdGG9IAS8LNLT4TBOD3hSKY7HkpjmYw/nq2f526Yd+3cdoU
        Pm/WnARFLWJ2zx0fP4apGU2OaGlE1oA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E778F2C24C;
        Fri, 24 Jun 2022 13:59:51 +0000 (UTC)
Date:   Fri, 24 Jun 2022 15:59:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@openvz.org>, kernel@openvz.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Message-ID: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
 <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
 <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-06-22 09:55:33, Shakeel Butt wrote:
> On Thu, Jun 23, 2022 at 9:07 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 23-06-22 18:03:31, Vasily Averin wrote:
> > > Dear Michal,
> > > do you still have any concerns about this patch set?
> >
> > Yes, I do not think we have concluded this to be really necessary. IIRC
> > Roman would like to see lingering cgroups addressed in not-so-distant
> > future (http://lkml.kernel.org/r/Ypd2DW7id4M3KJJW@carbon) and we already
> > have a limit for the number of cgroups in the tree. So why should we
> > chase after allocations that correspond the cgroups and somehow try to
> > cap their number via the memory consumption. This looks like something
> > that will get out of sync eventually and it also doesn't seem like the
> > best control to me (comparing to an explicit limit to prevent runaways).
> > --
> 
> Let me give a counter argument to that. On a system running multiple
> workloads, how can the admin come up with a sensible limit for the
> number of cgroups?

How is that any easier through memory consumption? Something that might
change between kernel versions? Is it even possible to prevent from id
depletion by the memory consumption? Any medium sized memcg can easily
consume all the ids AFAICS.
-- 
Michal Hocko
SUSE Labs
