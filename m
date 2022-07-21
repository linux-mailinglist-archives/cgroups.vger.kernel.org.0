Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2991057C9E0
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiGULoV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 07:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGULoU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 07:44:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5181B1C;
        Thu, 21 Jul 2022 04:44:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80A01347E8;
        Thu, 21 Jul 2022 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658403857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55vVqyAoWIEQ9JxT7s6q3Jr0to6oOsiGEmqrmnmaNGA=;
        b=Io2AKFGB7/eGwnBd04xBVFA7h2OmtbDhJOT2cpLxov+xmrqhdkQIes+oEiybC/+hFQp4xH
        rsU9zD7wajZdjxY9q29OcYlhNkh0olliRmeN45oIkAz3wZVoMAeCL2y1/zzI8KG9k1Ymqg
        Q2NM9TA+/ZepPCtDQKEQZblHFcwxvyU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6AB622C149;
        Thu, 21 Jul 2022 11:44:17 +0000 (UTC)
Date:   Thu, 21 Jul 2022 13:44:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <Ytk8EBBEi4EubvPn@dhcp22.suse.cz>
References: <20220714064918.2576464-1-yosryahmed@google.com>
 <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
 <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
 <CAJD7tkYBm+L_-GTLDux0ZsJ6=kw-zzHjs6vgKUtmeZhcxLwqiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYBm+L_-GTLDux0ZsJ6=kw-zzHjs6vgKUtmeZhcxLwqiw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-07-22 11:02:56, Yosry Ahmed wrote:
> On Wed, Jul 20, 2022 at 10:50 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > [...]
> > >
> > > I think what we are missing here is
> > > - explain that this doesn't have any effect on existing users of
> > >   vmpressure user interface because that is cgroup v1 and memory.reclaim
> > >   is v2 feature. This is a trivial statement but quite useful for future
> > >   readers of this commit
> > > - explain the effect on the networking layer and typical usecases
> > >   memory.reclaim is used for currently and ideally document that.
> >
> > I agree with the above two points (Yosry, please address those) but
> > the following third point is orthogonal and we don't really need to
> > have an answer for this patch to be accepted.
> >
> 
> That's great feedback, thanks Michal and Shakeel!
> 
> How do you feel about the following commit message instead? Does it
> address your concerns?:
> 
> memory.reclaim is a cgroup v2 interface that allows users to
> proactively reclaim memory from a memcg, without real memory pressure.
> Reclaim operations invoke vmpressure, which is used in cgroup v1 to
> notify userspace of reclaim efficiency, and used in both v1 and v2 as
> a signal for a memcg being under memory pressure for networking (see
> mem_cgroup_under_socket_pressure()). For the former, vmpressure
> notifications in v1 are not affected by this change since
> memory.reclaim is a v2 feature.
> 
> For the latter, the effects of the vmpressure signal (according to
> Shakeel [1]) are as follows:
> 1. Reducing send and receive buffers of the current socket.
> 2. May drop packets on the rx path.
> 3. May throttle current thread on the tx path.
> 
> Since proactive reclaim is invoked directly by userspace, not by
> memory pressure, it makes sense not to throttle networking. Hence,
> this change makes sure that proactive reclaim caused by memory.reclaim
> does not trigger vmpressure.

OK, looks much better. Please also add a note to the documentation about
this side effect.

Thanks!
-- 
Michal Hocko
SUSE Labs
