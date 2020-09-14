Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6F26831B
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgIND2u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 23:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgIND2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 23:28:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E8C061787
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 20:28:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so2171976pgl.6
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 20:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kHmejXTIo1BBSLRENZgyqFfGzb/ylHsGPtQU3ORsGY=;
        b=qSowdt5PMPNIuUtYyjjVxXOB007fAprML0D9RLG01hggiBoUvwOyNQT+CB+AUUb69C
         Pc6o7Mnk2vhKMTjLgNpanvxjhxy12n3MbsrZ/gqVlxBp2pO+LF73GR00DawWKvKDEQsv
         INJmnpgtznXFsTnRJ8tPl4m3KAttaAVb/5EBaSasg3mXATRb/qHyV5IFUeU2QrDAOVbu
         QZNs8r67pQqpSQsotruFc6agNZUIRsmSIkmzxe1hrZWD8YD0gAfCg7B+Hp3gnZqSNQg8
         1wR3DvI5i/2fNqtA75uiMcFkcXEoRE0qzVYmtLhPvo7zAXgkliZi0O7BUNBe2LhOOGEn
         U0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kHmejXTIo1BBSLRENZgyqFfGzb/ylHsGPtQU3ORsGY=;
        b=r3uvmKv0czwM7L461jkOqP/CTFlKdMgR4v8fF8nj5bBbGCgjTlGgFNRuKOhYE+SyDy
         htRX2nudVuWBxtGSz864+tyrl4oYB07zoZNOJRHgX3ugXepj0Jo5aTwLlqZHMUJFuF43
         gQjNo7Az+k2pi6kwE2mwiYOdG7IRV2nOxBC6xJs7ClJHeczTgUlpDajWDQp8MCsHlu8M
         Wq/Fycx9Svo1uoxt0WEHtng1TAWiHqZ5xXLk5tcztoy6PXKqtDGqdxWMRodEPDIskh2o
         RFpadzCxCR4N8ySIZaJKWCDmh3qG7LmmTlPlNP8onFYRy/zv23ksXCNfomZumZ/+965m
         aMtg==
X-Gm-Message-State: AOAM533bAHnobu+L0gPF6J2zwQAz59RsOhGzF5l+qV1/22VewbDxvONX
        D0FKwNZjHhbMNPxODmnm865EmV2LJE5W9ZC+yH/a6A==
X-Google-Smtp-Source: ABdhPJyYRwniJbcpH5xKTfN/gYBasufM4x3VEAlZv0zuWL45LjZLH0gCwfNtbKPcwb9oAoUfGRtNjqlf+aJkB1XhvT8=
X-Received: by 2002:a63:5515:: with SMTP id j21mr9223604pgb.31.1600054125347;
 Sun, 13 Sep 2020 20:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com>
 <20200913170913.GB2239582@chrisdown.name> <CAMZfGtVBFCodKuNKzG8TxKjeuC1_hF_YKdqMTmX5ENE_FfDmzw@mail.gmail.com>
 <91184891-6a12-87a2-5a82-099a637b072f@huawei.com>
In-Reply-To: <91184891-6a12-87a2-5a82-099a637b072f@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 11:28:09 +0800
Message-ID: <CAMZfGtVGRDCNm0oOpco+-uPjsx6+VyVrCwVRS4dKV2ZTbY-e+w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Zefan Li <lizefan@huawei.com>
Cc:     Chris Down <chris@chrisdown.name>, tj@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, corbet@lwn.net,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 11:19 AM Zefan Li <lizefan@huawei.com> wrote:
>
> On 2020/9/14 11:10, Muchun Song wrote:
> > On Mon, Sep 14, 2020 at 1:09 AM Chris Down <chris@chrisdown.name> wrote:
> >>
> >> Muchun Song writes:
> >>> In the cgroup v1, we have a numa_stat interface. This is useful for
> >>> providing visibility into the numa locality information within an
> >>> memcg since the pages are allowed to be allocated from any physical
> >>> node. One of the use cases is evaluating application performance by
> >>> combining this information with the application's CPU allocation.
> >>> But the cgroup v2 does not. So this patch adds the missing information.
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> Suggested-by: Shakeel Butt <shakeelb@google.com>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> This is a feature patch, why does this have LKP's Reported-by?
> >
> > In the v2 version, the kernel test robot reported a compiler error
> > on the powerpc architecture. So I added that. Thanks.
> >
>
> You should remove this reported-by, and then add v2->v3 changelog:

Got it. I see Andrew has done it for me, thank him very much for
his work. He also added this patch to the -mm tree.

>
> ...original changelog...
>
> v3:
> - fixed something reported by test rebot

I already added that in the changelog. Thanks.


--
Yours,
Muchun
