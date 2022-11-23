Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDADA636CA3
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 22:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiKWV5t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 16:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiKWV5s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 16:57:48 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104722BCF
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 13:57:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id fz10so90434qtb.3
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 13:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXUl97TIC36iX2gzZ4z9T7kVADet1dCMIeHKCLo4dC4=;
        b=1d778WwTHiFnSrOOtipV1oy8hteglhzctqXDcakElk44hR7nj0Kw1HZUKFrkLK1flS
         1dy2ejEUeQqR3zUjNbKe64kHFHaCeNPfR+mHEFOOM8LiucYx2e8pjbjLk1BMo3Sbf3K9
         wZL/Jay42f6APIg1zJmYPEYEFZuFaYZ54oLip8A+55aEI0PiSRx6eLERACZ4gNoB/nRm
         LTOQd16sAxmRdLvYL+ViYyxYH5UhhXYq81mueLRa3i7YmQ4Cty/v68jpsO7pFl5W2ApC
         fFUnjjrFHbN4SCxNJgdTGJifAWOycqM5/tm/mDgGyEo4EcDqRaXaB8j0C8GsSVJo9CBj
         8CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXUl97TIC36iX2gzZ4z9T7kVADet1dCMIeHKCLo4dC4=;
        b=g881iXvnmzMu5tXUtDwojimS6iur7Q0LCQ44zzPDbZ8hx4eC0oMoI4H9Z8Qai2Qxut
         0NbEDS66aKWAs/n3EMXM3S5EZ3EVz9h3ZsG7PbFL//WeSKzHBcOQsOHlwKD16UoK3gJh
         FoX5DD+1rX33UeXKx1okfiTu7xvrOhjtg7+E2kngOyVDnlxzcdIxq/aZdRF9841XXAIe
         g+npzv71n1dPuJC4Sag8NA38qZNiyA6xHRzloL8kCQH6wL8wbcEQNYY6+6TyNLExQuHC
         JdJmGIVbtsVmEXG1peDjlQSv1jHMf+PnU4HFMG8+KT0DQ5Vgg8WQZZmwYWDlv7oG0Ffe
         p1pg==
X-Gm-Message-State: ANoB5pkklIwH4waeil+mNRzm8fcx7QBBLC2ua+XMje3cYLffW2nHZjHe
        aFfNjYeMdjk0bNS71zT4aZjZ+Q==
X-Google-Smtp-Source: AA0mqf59P97n8g2DJvpHoXjjiYjLodaojFr8pNiZ3Pf2y67xR6vLpb15b1401HTaq887RBMqTNLCfg==
X-Received: by 2002:ac8:4a10:0:b0:3a5:2556:42ed with SMTP id x16-20020ac84a10000000b003a5255642edmr13309728qtq.422.1669240664291;
        Wed, 23 Nov 2022 13:57:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b006fafc111b12sm13219537qkp.83.2022.11.23.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:57:43 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:58:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
Message-ID: <Y36XchdgTCsMP4jT@cmpxchg.org>
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org>
 <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 01:20:57PM -0800, Mina Almasry wrote:
> On Wed, Nov 23, 2022 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Hello Mina,
> >
> > On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> > > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > reclaim""), the proactive reclaim interface memory.reclaim does both
> > > reclaim and demotion. This is likely fine for us for latency critical
> > > jobs where we would want to disable proactive reclaim entirely, and is
> > > also fine for latency tolerant jobs where we would like to both
> > > proactively reclaim and demote.
> > >
> > > However, for some latency tiers in the middle we would like to demote but
> > > not reclaim. This is because reclaim and demotion incur different latency
> > > costs to the jobs in the cgroup. Demoted memory would still be addressable
> > > by the userspace at a higher latency, but reclaimed memory would need to
> > > incur a pagefault.
> > >
> > > To address this, I propose having reclaim-only and demotion-only
> > > mechanisms in the kernel. There are a couple possible
> > > interfaces to carry this out I considered:
> > >
> > > 1. Disable demotion in the memory.reclaim interface and add a new
> > >    demotion interface (memory.demote).
> > > 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
> > >    behavior in the kernel like so:
> > >       - demote=0 would disable demotion from this call.
> > >       - demote=1 would allow the kernel to demote if it desires.
> > >       - demote=2 would only demote if possible but not attempt any
> > >         other form of reclaim.
> >
> > Unfortunately, our proactive reclaim stack currently relies on
> > memory.reclaim doing both. It may not stay like that, but I'm a bit
> > wary of changing user-visible semantics post-facto.
> >
> > In patch 2, you're adding a node interface to memory.demote. Can you
> > add this to memory.reclaim instead? This would allow you to control
> > demotion and reclaim independently as you please: if you call it on a
> > node with demotion targets, it will demote; if you call it on a node
> > without one, it'll reclaim. And current users will remain unaffected.
> 
> Hello Johannes, thanks for taking a look!
> 
> I can certainly add the "nodes=" arg to memory.reclaim and you're
> right, that would help in bridging the gap. However, if I understand
> the underlying code correctly, with only the nodes= arg the kernel
> will indeed attempt demotion first, but the kernel will also merrily
> fall back to reclaiming if it can't demote the full amount. I had
> hoped to have the flexibility to protect latency sensitive jobs from
> reclaim entirely while attempting to do demotion.

The fallback to reclaim actually strikes me as wrong.

Think of reclaim as 'demoting' the pages to the storage tier. If we
have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
CXL and from CXL to storage. If we reclaim a page from RAM, it means
we 'demote' it directly from RAM to storage, bypassing potentially a
huge amount of pages colder than it in CXL. That doesn't seem right.

If demotion fails, IMO it shouldn't satisfy the reclaim request by
breaking the layering. Rather it should deflect that pressure to the
lower layers to make room. This makes sure we maintain an aging
pipeline that honors the memory tier hierarchy.

So I'm hesitant to design cgroup controls around the current behavior.

> The above is just one angle of the issue. Another angle (which Yosry
> would care most about I think) is that at Google we call
> memory.reclaim mainly when memory.current is too close to memory.max
> and we expect the memory usage of the cgroup to drop as a result of a
> success memory.reclaim call. I suspect once we take in commit
> 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg reclaim""),
> we would run into that regression, but I defer to Yosry here, he may
> have a solution for that in mind already.

IMO it should both demote and reclaim. Simliar to how memory.reclaim
on a non-tiered memory system would both deactivate active pages and
reclaim inactive pages.
