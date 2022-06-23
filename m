Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333DF5576E2
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiFWJnE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiFWJnD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 05:43:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0564F9;
        Thu, 23 Jun 2022 02:43:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF1FA21CFB;
        Thu, 23 Jun 2022 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655977380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdZnnoaTG6/in9QGnqYjtzbMQOKcr+nleBeI2IghgO4=;
        b=Mc1wVFGem2YqPRd3+41ems0z57Z3EKWvAnCwaelIpAwCzRZuErwv2/w0XdR8RnVV//v9i8
        f65xaqkG/QIE5wKkFV63Q/Gwa0D814VvV89jo49Eug7zMf2u6J2sZWF3Em7jrfQOx3LLRK
        jF3fUJJak1Mx/E0qkmfSDiIiXFVDCtY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A30B2C142;
        Thu, 23 Jun 2022 09:42:54 +0000 (UTC)
Date:   Thu, 23 Jun 2022 11:42:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
Message-ID: <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
 <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> On Thu, Jun 23, 2022 at 1:05 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 23-06-22 00:05:30, Yosry Ahmed wrote:
> > > Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > > as memory pressure") made sure that memory reclaim that is induced by
> > > userspace (limit-setting, proactive reclaim, ..) is not counted as
> > > memory pressure for the purposes of psi.
> > >
> > > Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
> > > from try_charge() and reclaim_high() wrap the call to
> > > try_to_free_mem_cgroup_pages() with psi handlers.
> > >
> > > However, vmpressure is still counted in these cases where reclaim is
> > > directly induced by userspace. This patch makes sure vmpressure is not
> > > counted in those operations, in the same way as psi. Since vmpressure
> > > calls need to happen deeper within the reclaim path, the same approach
> > > could not be followed. Hence, a new "controlled" flag is added to struct
> > > scan_control to flag a reclaim operation that is controlled by
> > > userspace. This flag is set by limit-setting and proactive reclaim
> > > operations, and is used to count vmpressure correctly.
> > >
> > > To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
> > > ("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
> > > is effectively reverted and the same flag is used to control psi as
> > > well.
> >
> > Why do we need to add this is a legacy interface now? Are there any
> > pre-existing users who realized this is bugging them? Please be more
> > specific about the usecase.
> 
> Sorry if I wasn't clear enough. Unfortunately we still have userspace
> workloads at Google that use vmpressure notifications.
> 
> In our internal version of memory.reclaim that we recently upstreamed,
> we do not account vmpressure during proactive reclaim (similar to how
> psi is handled upstream). We want to make sure this behavior also
> exists in the upstream version so that consolidating them does not
> break our users who rely on vmpressure and will start seeing increased
> pressure due to proactive reclaim.

These are good reasons to have this patch in your tree. But why is this
patch benefitial for the upstream kernel? It clearly adds some code and
some special casing which will add a maintenance overhead.
-- 
Michal Hocko
SUSE Labs
