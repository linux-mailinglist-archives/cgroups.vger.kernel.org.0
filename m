Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420B559BE95
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiHVLcX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 07:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiHVLcE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 07:32:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8A33E06;
        Mon, 22 Aug 2022 04:31:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9898E340D8;
        Mon, 22 Aug 2022 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661167908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rN68WvWnS9a0ZMxHp34QNuXswa4YZncIEkckzvz7TD4=;
        b=mwVzMNZp9O0hzvXg5oLi/niUhvKZEJ6VJ7/HIZrF/IKfgXAeDVGD2ApZ1ifROdoG4KgHvh
        15oWw7JTG8NPmMALApOqNXx/LT5CmM6ffvqjjZHh0UxqXY27mjzw653QQw6luzzniOFIQW
        DvHDdd/h+uUNsbz4qEuqBefHaHUApAY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7850013523;
        Mon, 22 Aug 2022 11:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bRGUGiRpA2O4MAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 22 Aug 2022 11:31:48 +0000
Date:   Mon, 22 Aug 2022 13:31:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, ke.wang@unisoc.com,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yv+6YjaGAv52yvq9@slm.duckdns.org>
 <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv/EArPDTcCrGqJh@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 19-08-22 07:10:26, Tejun Heo wrote:
> On Fri, Aug 19, 2022 at 10:08:59AM -0700, Shakeel Butt wrote:
> > On Fri, Aug 19, 2022 at 9:29 AM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Fri, Aug 19, 2022 at 07:29:22PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > It is observed in android system where per-app cgroup is demanded by freezer
> > > > subsys and part of groups require memory control. The hierarchy could be simplized
> > > > as bellowing where memory charged on group B abserved while we only want have
> > > > group E's memory be controlled and B's descendants compete freely for memory.
> > > > This should be the consequences of unified hierarchy.
> > > > Under this scenario, less efficient memory reclaim is observed when comparing
> > > > with no memory control. It is believed that multi LRU scanning introduces some
> > > > of the overhead. Furthermore, page thrashing is also heavier than global LRU
> > > > which could be the consequences of partial failure of WORKINGSET mechanism as
> > > > LRU is too short to protect the active pages.
> > > >
> > > > A(subtree_control = memory) - B(subtree_control = NULL) - C()
> > > >                                                       \ D()
> > > >                           - E(subtree_control = memory) - F()
> > > >                                                         \ G()
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Just in case it wasn't clear.
> > >
> > > Nacked-by: Tejun Heo <tj@kernel.org>
> > >
> > > Thanks.
> > >
> > 
> > Was there a previous discussion on this? The commit message is unreadable.
> 
> http://lkml.kernel.org/r/1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com

Even that discussion doesn't really explain the real underlying problem.
There are statements about inefficiency and trashing without any further
details or clarifications.

My very vague understanding is that the Android system would like to
freeze specific applications and for that it requires each application
to live in its own cgroup. This clashes with a requirement to age and
reclaim memory on a different granularity (aka no per process reclaim).
So in fact something that cgroup v1 would achieve by having 2
hierarchies, one for the freezer which would have a dedicated cgroup for
each application and the other for the memory controller where tasks are
grouped by a different criteria. This would rule out that a global (or
any external memory pressure) reclaim would age LRUs that contain a mix
bag of application pages rather than iterate over per-application LRUs.
Is that understanding correct?
-- 
Michal Hocko
SUSE Labs
