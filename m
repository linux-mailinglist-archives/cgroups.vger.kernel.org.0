Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5547B1D06
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjI1Mwm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjI1Mwl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 08:52:41 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865DF180
        for <cgroups@vger.kernel.org>; Thu, 28 Sep 2023 05:52:39 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65b2463d663so31891136d6.0
        for <cgroups@vger.kernel.org>; Thu, 28 Sep 2023 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695905558; x=1696510358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpkzH31Yq2C5TtSflxHZb2eMAQY8GuLcUePer8rUOKM=;
        b=lD5VTD3x8o44NyL6UsJRxVk0rhmdfVE3mmfdkY6BtjP/n5Wesv3dRC7i57Vv0jf8Lp
         FtTs8yHszU6Ct+4nbdVvY2L4dEETuPq3QP+P2oJfqvEWQsUQEeAJ7vrDD7x0a65Qtrfk
         W+7ErlyYE4ajE0EnVfexs+kDosZKJ6stFFjPZN1n1/JcFGWDEUmFXt8StoUTqBBmS5dl
         ZE6bslXpreaayIVShZ5mH0LtW+tRa722Siab9jiUlb3rOYNgDC0CeJCTx3iRjVz0amsL
         jWZSr9ZE6LJR1q7vvLyJkHHH3hWio6GUvycF6SAhRrAGeTNQoyNM2j2GQb0oVTa3lx/8
         Yq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905558; x=1696510358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpkzH31Yq2C5TtSflxHZb2eMAQY8GuLcUePer8rUOKM=;
        b=Tgf6TCvAt5OxujU2hpzATURRvQbMp7/Vy7V5d/2DA2HVcuR8RMms4AsNFy28TxWelM
         wwK/f7jxpoGlZnv0Xd1S5sDFW2wPiiEIyv1Wb7O3sl8EugT6XU/ismrI3ke/HyritA2K
         Iq6HJ6gDI84Rrm0QGNO3LzRBvS76QWrO50RxQxHYfT+wO9rFBbyu5CjhzqXYtFgwUJfv
         TPZGK8LAt8KImz1WunM17Y8Y7JEdeWzSP/x0r08qjIc3M/5c9jM4u+dnAoGv1jlh1MZ0
         PF/bIA5MjCiBM0nK3FW6+FnzjeLUSBLEeI24BownR9rZew9z37KyoAOfwTuE8xRNUBO9
         zajw==
X-Gm-Message-State: AOJu0YzAVvB1/GGUGjxP5WlDLDy/bMT/N+dHgDoy2Gyxu4smJbUHTAGm
        Rhro4xD2Iz9QNPrlQ0JXKjIbLA==
X-Google-Smtp-Source: AGHT+IFCbHcqAmY51j1yK/l67N14ymge0mJS2ELWGRT3ta0V1oAfu54V3IVoBh1epAxg2hsK8CIkKQ==
X-Received: by 2002:a05:6214:1925:b0:64f:3795:c10 with SMTP id es5-20020a056214192500b0064f37950c10mr926742qvb.10.1695905558577;
        Thu, 28 Sep 2023 05:52:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id r10-20020a0c9e8a000000b006562b70805bsm3806364qvd.84.2023.09.28.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:52:38 -0700 (PDT)
Date:   Thu, 28 Sep 2023 08:52:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, riel@surriel.com, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20230928125237.GA407389@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
 <ZRSgq_l2IXmedy4V@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRSgq_l2IXmedy4V@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 02:37:47PM -0700, Roman Gushchin wrote:
> On Wed, Sep 27, 2023 at 02:47:38PM -0400, Johannes Weiner wrote:
> > On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> > > On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> > > > Currently, hugetlb memory usage is not acounted for in the memory
> > > > controller, which could lead to memory overprotection for cgroups with
> > > > hugetlb-backed memory. This has been observed in our production system.
> > > > 
> > > > This patch series rectifies this issue by charging the memcg when the
> > > > hugetlb folio is allocated, and uncharging when the folio is freed. In
> > > > addition, a new selftest is added to demonstrate and verify this new
> > > > behavior.
> > > 
> > > The primary reason why hugetlb is living outside of memcg (and the core
> > > MM as well) is that it doesn't really fit the whole scheme. In several
> > > aspects. First and the foremost it is an independently managed resource
> > > with its own pool management, use and lifetime.
> > 
> > Honestly, the simpler explanation is that few people have used hugetlb
> > in regular, containerized non-HPC workloads.
> > 
> > Hugetlb has historically been much more special, and it retains a
> > specialness that warrants e.g. the hugetlb cgroup container. But it
> > has also made strides with hugetlb_cma, migratability, madvise support
> > etc. that allows much more on-demand use. It's no longer the case that
> > you just put a static pool of memory aside during boot and only a few
> > blessed applications are using it.
> > 
> > For example, we're using hugetlb_cma very broadly with generic
> > containers. The CMA region is fully usable by movable non-huge stuff
> > until huge pages are allocated in it. With the hugetlb controller you
> > can define a maximum number of hugetlb pages that can be used per
> > container. But what if that container isn't using any? Why shouldn't
> > it be allowed to use its overall memory allowance for anon and cache
> > instead?
> 
> Cool, I remember proposing hugetlb memcg stats several years ago and if
> I remember correctly at that time you was opposing it based on the idea
> that huge pages are not a part of the overall memcg flow: they are not
> a subject for memory pressure, can't be evicted, etc. And thp's were seen
> as a long-term replacement. Even though all above it's true, hugetlb has
> it's niche and I don't think thp's will realistically replace it any time
> soon.

Yeah, Michal's arguments very much reminded me of my stance then. I
stand corrected.

I'm still hopeful that we can make 2M work transparently. I'd expect
1G to remain in the hugetlb domain for some time to come, but even
those are mostly dynamic now with your hugetlb_cma feature!

> So I'm glad to see this effort (and very supportive) on making hugetlb
> more convenient and transparent for an end user.

Thanks!
