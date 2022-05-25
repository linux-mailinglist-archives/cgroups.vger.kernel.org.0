Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD35338EE
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 10:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiEYI7W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 04:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiEYI7W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 04:59:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB916FA2C;
        Wed, 25 May 2022 01:59:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 019C41F905;
        Wed, 25 May 2022 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653469159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdJCYZHOyhpjXySt6nTPMBOK5Q7ap+5mhsb0yD0IbJk=;
        b=aiV6xLIl8yHWP30wU/K3GtbE85ZdBM0U1BgBzJcKlHVA+4+eXIlhgfUdcIjT7dEY9LCayY
        qdR0ughVWk+eDMKIj1MpdBpoaBSWF8+Uz2ja25zdBKLZBcBtbHqJdJEWm2SbGqjXX7AsZz
        UMe64oVsol7td+qJimhHkcqUGFKpgnI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B3F12C142;
        Wed, 25 May 2022 08:59:18 +0000 (UTC)
Date:   Wed, 25 May 2022 10:59:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
Message-ID: <Yo3v5k8UBNHF6QRi@dhcp22.suse.cz>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <YoYj4sLJfGke5IGT@dhcp22.suse.cz>
 <87zgjcg4xs.fsf@vajain21.in.ibm.com>
 <YodDaFVeU33bu7yQ@dhcp22.suse.cz>
 <CAJD7tkYwv2LDZeV2F5pxuniw7LCNjBapDCm3WuRhzwTH-jN3PA@mail.gmail.com>
 <YozFZI2euSjWPgDb@cmpxchg.org>
 <CAJD7tkZxvmnrrjc4yAe5mC+SL-MZqMkn21yjetiLYyq0B=AhtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZxvmnrrjc4yAe5mC+SL-MZqMkn21yjetiLYyq0B=AhtA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 24-05-22 12:01:01, Yosry Ahmed wrote:
> On Tue, May 24, 2022 at 4:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, May 23, 2022 at 03:50:34PM -0700, Yosry Ahmed wrote:
> > > I think it might be useful to have a dedicated entry in memory.stat
> > > for proactively reclaimed memory. A case where this would be useful is
> > > tuning and evaluating userspace proactive reclaimers. For instance, if
> > > a userspace agent is asking the kernel to reclaim 100M, but it could
> > > only reclaim 10M, then most probably the proactive reclaimer is not
> > > using a good methodology to figure out how much memory do we need to
> > > reclaim.
> > >
> > > IMO this is more useful, and a superset of just reading the last
> > > reclaim request status through memory.reclaim (read stat before and
> > > after).
> >
> > +1
> 
> It might also be useful to have a breakdown of this by memory type:
> file, anon, or shrinkers.
> 
> It would also fit in nicely with a potential type=file/anon/shrinker
> argument to memory.reclaim. Thoughts on this?

Can we start simple and see what real usecases actually will need? 
-- 
Michal Hocko
SUSE Labs
