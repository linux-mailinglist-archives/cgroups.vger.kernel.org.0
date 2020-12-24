Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F242E23C8
	for <lists+cgroups@lfdr.de>; Thu, 24 Dec 2020 03:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgLXCrP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Dec 2020 21:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgLXCrP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Dec 2020 21:47:15 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47EC0617A6
        for <cgroups@vger.kernel.org>; Wed, 23 Dec 2020 18:46:35 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c79so525343pfc.2
        for <cgroups@vger.kernel.org>; Wed, 23 Dec 2020 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDRfu0M1YLV1uhT7YoKaiH9p9Ye/ITZc1yvaQ4SUQRQ=;
        b=ZJPDaWbo/DIXrpPoj3kbzFZq3ifzLIDVBRcOUeeDau6bNYnMbfXwq+Q3xjq+SqbDy4
         Dim1zSamlWYGDHO7vC5p5k5feoa3IXuVpZaqrm86asSB+klu5vOjmug219Kw/52k8nAo
         eHOfWtYH2gjhQhErEg4GMr3D5/GaUBAn4XQCkV/btHnMMR6M1AEaIiPQpHv9/jr0V9p5
         dPyMkWT6VkJRbkcY3AvB9Eta4zTVQCQmf9DRFylxLwf8Zm98OVmndOXtNERC8HmdkP0F
         kuhZWGA2K7XU/Gz+RkI2T6VYvzo+paOxH/7ud2cUmqITTJde3TZ5DowlQoAvpRH7yspk
         1t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDRfu0M1YLV1uhT7YoKaiH9p9Ye/ITZc1yvaQ4SUQRQ=;
        b=lFs8UYX4Yb2o5Rkn9l/yNvgXwr0WJOEfPVn2fszk03mIn9pYoxeBmT36CU6HjoCOyH
         j4T5daKt6qdj03T9pjlDHcCLSNcUEgbB0PX1XcmEVo2cHGyEngQD7hda3wzUosp2gwbP
         St/r4qUC48dQysFMM8YEXoVJ1OqJDuz8qx6Gh6AENpfOjQuqr6gmQO5b8bitDiCECySf
         73dNmA6XZedKAbVDZUJmeC2ZWAy1vIypRhq/+TQCY+owjJYBjpF2tkD/U6xRR8ZVpB0D
         DvtSS2bzX+iEAdZPL1eiLkEc22c9ufpgyBdq0iETJ9xoBAn5oA61G092MpyLNe/q9Di/
         CWDg==
X-Gm-Message-State: AOAM5333tZQ9q5ZZQSTWPLYQ9pq3v/4Dn+o/P3gqm2KbGV5zx3wOMqx+
        qTN6Sv3iAnomT448FymJgAmEThmIsgzZqwxQoSK/cA==
X-Google-Smtp-Source: ABdhPJwYrW/b7eupKEutfmD9j8Xwe7uZNE+Erred065j6h0pMc4R4dMuAUJfUM4SPXlq+LkRkRNFBEAp1N6bYEuBtHo=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr26008689pfp.49.1608777994836; Wed, 23
 Dec 2020 18:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20201217034356.4708-1-songmuchun@bytedance.com>
 <20201217034356.4708-3-songmuchun@bytedance.com> <CALvZod7kMhb7k6rDZj18JTE=RMji-SinJmfdcPbN9PUL9Off_w@mail.gmail.com>
In-Reply-To: <CALvZod7kMhb7k6rDZj18JTE=RMji-SinJmfdcPbN9PUL9Off_w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Dec 2020 10:45:58 +0800
Message-ID: <CAMZfGtVQvD4o-nVdCqNBjWtjDzxcfqme9xMH9ar=C=_sMyDm+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/7] mm: memcontrol: convert
 NR_ANON_THPS account to pages
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 24, 2020 at 6:08 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Dec 16, 2020 at 7:45 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Currently we use struct per_cpu_nodestat to cache the vmstat
> > counters, which leads to inaccurate statistics expecially THP
>
> *especially

Thanks.

>
> > vmstat counters. In the systems with hundreads of processors
>
> *hundreds

Thanks.

>
> > it can be GBs of memory. For example, for a 96 CPUs system,
> > the threshold is the maximum number of 125. And the per cpu
> > counters can cache 23.4375 GB in total.
> >
> > The THP page is already a form of batched addition (it will
> > add 512 worth of memory in one go) so skipping the batching
> > seems like sensible. Although every THP stats update overflows
> > the per-cpu counter, resorting to atomic global updates. But
> > it can make the statistics more accuracy for the THP vmstat
> > counters.
> >
> > So we convert the NR_ANON_THPS account to pages. This patch
> > is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
> > on compound page arrival"). Doing this also can make the unit
> > of vmstat counters more unified. Finally, the unit of the vmstat
> > counters are pages, kB and bytes. The B/KB suffix can tell us
> > that the unit is bytes or kB. The rest which is without suffix
> > are pages.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> I agree with the motivation behind this patch but I would like to see
> some performance numbers in the commit message. We might agree to pay
> the price but at least we will know what exactly that cost is.

Do you have any recommendations about benchmarks?
I can do a test. Thanks very much.

-- 
Yours,
Muchun
