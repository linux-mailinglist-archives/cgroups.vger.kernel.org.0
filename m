Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9665F6003
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 06:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJFETi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 00:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJFETh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 00:19:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DBD9A
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 21:19:35 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id z30so348836qkz.13
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 21:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4VEh9i/QK9xTQL6ExiIgh+tg9GqBfC90q8qqSObsBU=;
        b=sZL9/JucKLz3kza/Ci0aE4mVLQuA02JUnRd0KZ+JjmTvCYZBC54ujscNSfmQ/NxErl
         TBJxwh2iZtm7uXDfkJufgPQ+xGw1njpAaiBlaqgy+2mkenaYeIj2LxooAMyYvv+iFdQP
         TOnXK2UPvQ0tNG7A3YwlRfQmV5CMnuf8jD4P+ac5y2/XUyIZgT3NgkrCOn46rsnBY7iA
         dVo+PTwO2hWBzCNR8+P7nWKid7JTLjWfYHCzde0xqyh8Q44PTs7Fu3uDqvfG5I+sbALj
         u56wTAUzxDi/JxYTiGVAo5YQ9kbM+v0953iBfko68HZuZSyWrunAPEzP226mMlwTQj71
         n57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4VEh9i/QK9xTQL6ExiIgh+tg9GqBfC90q8qqSObsBU=;
        b=C+HvdTmDwu3/tmtmN7eSi4zTi+rMtu8MjdhB2FTYIBUX7wY8Ji6sjC3eAIf8elkYAS
         SEEK/ELPHpQX0jl9XopQWcJw6LMLfejXMz8MGKuTtGXv/Q7kIsq1NBoywVQB438LLwum
         nprs3PBEEKTfwCNuygqsnJo0fYhORnvPoW2N0rS0hZs/8ChiVCAwyPo12Sr6kfMogrO4
         NWNhB0gRml8e/SgnmMzakQlcyUNnrfsaN+X3pYnSdSMloxhmFAZrVwIDKHVNtQzXahiJ
         cN1YWo10l1PKD7KteIeHQSA7psJA/WEQhn5hmOiu55hnsXcMHbq/f/BjDw8UofgCDIcZ
         fKpA==
X-Gm-Message-State: ACrzQf2Mrdc3tLSA5qerEl5vlgZDc8Og9nudLS2lHnWFmm7SAzz2bfF0
        ekaKRpmIEPWzZFGJOga22ybGqvcWMvY0Jg==
X-Google-Smtp-Source: AMsMyM5iFdQs5h8Er5ULgff4bJSprImXOkkfnC/FHoRy0rd5gqF55hYL0TbLF6bWECu4B2p/1Vq11w==
X-Received: by 2002:a37:c06:0:b0:6e2:b66f:b78f with SMTP id 6-20020a370c06000000b006e2b66fb78fmr1911018qkm.444.1665029974896;
        Wed, 05 Oct 2022 21:19:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8a16])
        by smtp.gmail.com with ESMTPSA id j25-20020ac84419000000b003938a65479bsm1331656qtn.10.2022.10.05.21.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:19:34 -0700 (PDT)
Date:   Thu, 6 Oct 2022 00:19:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
Message-ID: <Yz5XVZfq8abvMYJ8@cmpxchg.org>
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
> On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > During page/folio reclaim, we check if a folio is referenced using
> > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > accessed soon, and hence reclaiming it will cause a refault.
> > > >
> > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > processes in the subtree of the target memcg. This behavior was
> > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > pages would get charged to the memcg of the process that was faulting them
> > > > in. It made sense to only consider accesses coming from processes in the
> > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > for it appropriately.
> > > >
> > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > memcg that was originally charged for them during swapping out. Which
> > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > page/folio is a viable reclaim target.
> > > >
> > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > the folio is swapbacked.
> > >
> > > It seems to me this change can potentially increase the number of
> > > zombie memcgs. Any risk assessment done on this?
> >
> > Do you mind elaborating the case(s) where this could happen? Is this
> > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > from a zombie memcg and swapping out would let us move the charge to
> > the parent?
> 
> The scenario is quite straightforward: for a page charged to memcg A
> and also actively used by memcg B, if we don't ignore the access from
> memcg B, we won't be able to reclaim it after memcg A is deleted.

This patch changes the behavior of limit-induced reclaim. There is no
limit reclaim on A after it's been deleted. And parental/global
reclaim has always recognized outside references.
