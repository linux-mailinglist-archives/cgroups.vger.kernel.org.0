Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2357D1C8
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiGUQmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiGUQmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 12:42:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127980F52;
        Thu, 21 Jul 2022 09:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3B3C338EF;
        Thu, 21 Jul 2022 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658421773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qt+WwiyZiViwm6KCAndCDSnf7EhrmXRlccAiNwCFNNo=;
        b=s3mxsE1en0lqSnTJLvhyzGUsqbXkTK/v+hYViR89oTUA6bqcr5DquYpjUw8UXqkfuTKg9r
        KAnHtJMmRhEiRtftyKyLIUpnIF6ePyV81/KZDUEhQ78gD4XBZHOCkl+O5FcHU/ZjS/1VVv
        LCPs1wNQeQ4KUqmPTtw00vwJpeniXWE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB2D113A1B;
        Thu, 21 Jul 2022 16:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b+3HLgyC2WI6fAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 21 Jul 2022 16:42:52 +0000
Date:   Thu, 21 Jul 2022 18:42:52 +0200
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
Message-ID: <YtmCDCsv+K+9refK@dhcp22.suse.cz>
References: <20220714064918.2576464-1-yosryahmed@google.com>
 <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
 <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
 <CAJD7tkYBm+L_-GTLDux0ZsJ6=kw-zzHjs6vgKUtmeZhcxLwqiw@mail.gmail.com>
 <Ytk8EBBEi4EubvPn@dhcp22.suse.cz>
 <CAJD7tkZVcQ6xzdnGPS0kQAP=+Q=yZwVT_ZrLaEsAgkLi_DAMtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZVcQ6xzdnGPS0kQAP=+Q=yZwVT_ZrLaEsAgkLi_DAMtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-07-22 08:58:06, Yosry Ahmed wrote:
> On Thu, Jul 21, 2022 at 4:44 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 20-07-22 11:02:56, Yosry Ahmed wrote:
> > > On Wed, Jul 20, 2022 at 10:50 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > [...]
> > > > >
> > > > > I think what we are missing here is
> > > > > - explain that this doesn't have any effect on existing users of
> > > > >   vmpressure user interface because that is cgroup v1 and memory.reclaim
> > > > >   is v2 feature. This is a trivial statement but quite useful for future
> > > > >   readers of this commit
> > > > > - explain the effect on the networking layer and typical usecases
> > > > >   memory.reclaim is used for currently and ideally document that.
> > > >
> > > > I agree with the above two points (Yosry, please address those) but
> > > > the following third point is orthogonal and we don't really need to
> > > > have an answer for this patch to be accepted.
> > > >
> > >
> > > That's great feedback, thanks Michal and Shakeel!
> > >
> > > How do you feel about the following commit message instead? Does it
> > > address your concerns?:
> > >
> > > memory.reclaim is a cgroup v2 interface that allows users to
> > > proactively reclaim memory from a memcg, without real memory pressure.
> > > Reclaim operations invoke vmpressure, which is used in cgroup v1 to
> > > notify userspace of reclaim efficiency, and used in both v1 and v2 as
> > > a signal for a memcg being under memory pressure for networking (see
> > > mem_cgroup_under_socket_pressure()). For the former, vmpressure
> > > notifications in v1 are not affected by this change since
> > > memory.reclaim is a v2 feature.
> > >
> > > For the latter, the effects of the vmpressure signal (according to
> > > Shakeel [1]) are as follows:
> > > 1. Reducing send and receive buffers of the current socket.
> > > 2. May drop packets on the rx path.
> > > 3. May throttle current thread on the tx path.
> > >
> > > Since proactive reclaim is invoked directly by userspace, not by
> > > memory pressure, it makes sense not to throttle networking. Hence,
> > > this change makes sure that proactive reclaim caused by memory.reclaim
> > > does not trigger vmpressure.
> >
> > OK, looks much better. Please also add a note to the documentation about
> > this side effect.
> 
> I don't want to add something to the documentation about throttling
> networking because it seems like these are implementation details that
> we may change in the future. I don't know if we can document this
> behavior today and then change it later.

The exact mechanism on how the throttling is done is one thing. This can
change. But the fact that _no_ throttling is applied is something that
we shouldn't change of course. If we were really strict we shouldn't
change it even now but considering that the interface is new and
usecases still shaping then better now than later.

> How about we document a more generic statement in memory.reclaim
> documentation, like:
> 
> "With reactive reclaim operations triggered by the kernel, the kernel
> may take further actions to alleviate memory pressure (such as
> throttling networking memory consumption). For proactive reclaim
> operations triggered by this interface, the kernel may choose to skip
> such actions as reclaim is not an indication of memory pressure."

IDK, this sounds too much word lawyering to me TBH. It is better to be clear
about explicitly known side effects. For example where do shrinkers
stand in the light of above wording? Kernel can chose to do almost
anything and I do not think we want to control which shrinkers are
triggered and what they do.

So I would really prefer to say something like:
"
Please note that the proactive reclaim (triggered by this interface) is
not meant to indicate memory pressure on the memory cgroup. Therefore
socket memory balancing triggered by the memory reclaim normally is not
exercised in this case. This means that the networking layer will not
adapt based on reclaim induced by memory.reclaim.
"
-- 
Michal Hocko
SUSE Labs
