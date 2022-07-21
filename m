Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1F57C9D9
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiGULmc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGULmc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 07:42:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE35D0EE;
        Thu, 21 Jul 2022 04:42:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2389B347EB;
        Thu, 21 Jul 2022 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658403749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkvbSMivb/aWXIlzYNPZoVB/iKbqXT76LFZqzry9Fz4=;
        b=r2465AG3bndbjlFwjkJAWIovGGRSvB4ub7P3vDo/JON7K4EOcDSeD0D4aKvmMfKaVYRcsN
        q071il98/zaQkOiititSJGsdWBY7fcTNeVkfW8TDsWHrmu1KKFWJmlRfJ6yd/MKGdXD5C2
        //MdG7ABC4+aDFuIp0M2Obnx5rxqfQY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E9632C149;
        Thu, 21 Jul 2022 11:42:28 +0000 (UTC)
Date:   Thu, 21 Jul 2022 13:42:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in
 vmpressure
Message-ID: <Ytk7octCv1DZeelM@dhcp22.suse.cz>
References: <20220714064918.2576464-1-yosryahmed@google.com>
 <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
 <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-07-22 10:49:53, Shakeel Butt wrote:
> On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> >
> > I think what we are missing here is
> > - explain that this doesn't have any effect on existing users of
> >   vmpressure user interface because that is cgroup v1 and memory.reclaim
> >   is v2 feature. This is a trivial statement but quite useful for future
> >   readers of this commit
> > - explain the effect on the networking layer and typical usecases
> >   memory.reclaim is used for currently and ideally document that.
> 
> I agree with the above two points (Yosry, please address those) but
> the following third point is orthogonal and we don't really need to
> have an answer for this patch to be accepted.
> 
> > - how are we going to deal with users who would really want to use
> >   memory.reclaim interface as a replacement for existing hard/high
> >   memory reclaim? Is that even something that the interface is intended
> >   for?
> 
> I do agree that this question is important. Nowadays I am looking at
> this from a different perspective and use-case. More concretely how
> (and why) to replace vmpressure based network throttling for cgroup
> v2. I will start a separate thread for that discussion.

I think we should be good to document this side effect for now. If you
have a plan to change to vmpressure based throttling then only better.
But one way or the other impact of the memory.reclaim interface on
netwroking should be documented properly.

-- 
Michal Hocko
SUSE Labs
