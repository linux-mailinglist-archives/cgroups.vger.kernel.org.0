Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873D92D1489
	for <lists+cgroups@lfdr.de>; Mon,  7 Dec 2020 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLGPU0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Dec 2020 10:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGPUZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Dec 2020 10:20:25 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3EC061794
        for <cgroups@vger.kernel.org>; Mon,  7 Dec 2020 07:19:45 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l23so7634817pjg.1
        for <cgroups@vger.kernel.org>; Mon, 07 Dec 2020 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/8cl08sjjk7XgilYCDYzD/2g3tf6PI2yGU88Vpkn4A=;
        b=ZvtKJVWdEcz//9OHUucVTATmSAQTbpHT3os9hXUq1tI7hELUplnd8MnB7mAvrNTInG
         SXI4kX0qtpGl8NvMOqSz5ZfaT6by3X4IlHRJ1dCjN4mp9fiOygwBLBo7DGq6ShDGEAMz
         WOxaCJUpmiWjCm5juhwKjGc9XjQPRQSDnwAnhRxXwXihS5IazI64FczZA+mpY0zxmNqP
         YYzLxnSOq2ftnzGeU0a1TunNkm9DRSp+d30U4zGh7ThlOaZsMr5s5OIoy/merSHADQDV
         oWro9DLx5fUohiW9xYkhz0afQc7YYyYicgJicsHm+hnFVkW3yDp8CndN/hXzNdmyz8pw
         Zh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/8cl08sjjk7XgilYCDYzD/2g3tf6PI2yGU88Vpkn4A=;
        b=uEINVIgBxlYA5oGwyQrlqwo+J5qZtB3wg7jJXXzmmhf5lXE3zxFpwDGxO4Op8TL6rm
         ssSPk2tGX4I3NGqSbRdyfzJpJXX1wp2ZXO8HALYOo+B+ukRT2RrMGvt2AKTTpFdFYs4T
         65PV9rgC20YgIR10tDnIiU4sYJ5PQgvtRltzPpjMujIGYSA/BXzAWTiaSR85Z9D/rgKG
         lIMEaAQ5nQh6Fq0nQhfXSSdx/0/rTQiZlECRkAI8UhUXaduM740K3YC6TrcTv52ULcw2
         FAHJmLuguI9aWJTL4w4PORJGAtg+ZQaqp0XdMQmG+ezPo72gXiJYMntoS0c6tvYjXvve
         UfvA==
X-Gm-Message-State: AOAM532xHOP1gso9m+qllb7ygLrfdoGloDOEK3BI0UGjoUsMQF1Vt+81
        u8plkeeLHPuTtgro6V+0iQrwJ5SKLkdpLVbbx5JOYQ==
X-Google-Smtp-Source: ABdhPJwiNRhdrT0KFjUxeAEE1uHOTXZ12d5p6D3NspJJwi6Ek+Zsfu2cWBdWyw/wt0Qc/Ccs+HbGXutwFHtLoEgc6+s=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr17277340pjq.13.1607354385273;
 Mon, 07 Dec 2020 07:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20201206085639.12627-1-songmuchun@bytedance.com>
 <20201207123605.GH25569@dhcp22.suse.cz> <CAMZfGtUhG26cTgbSmg4g+rwOtEFhgbE3QXPR_LUf3FS-s=YbOA@mail.gmail.com>
 <20201207150847.GM25569@dhcp22.suse.cz>
In-Reply-To: <20201207150847.GM25569@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 23:19:09 +0800
Message-ID: <CAMZfGtV36d0L7-+pSoD0Xqws-9naRNowTNJ3VTLwT5tFt09RJQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: optimize per-lruvec stats
 counter memory usage
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 7, 2020 at 11:09 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 07-12-20 20:56:58, Muchun Song wrote:
> > On Mon, Dec 7, 2020 at 8:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Sun 06-12-20 16:56:39, Muchun Song wrote:
> > > > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > > > of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> > > > to optimize memory usage.
> > >
> > > How much savings are we talking about here? I am not deeply familiar
> > > with the pcp allocator but can it compact smaller data types much
> > > better?
> >
> > It is a percpu struct. The size of struct lruvec_stat is 304(tested on the
> > linux-5.5). So we can save 304 / 2 * nproc bytes per memcg where nproc
> > is the number of the possible CPU. If we have n memory cgroup in the
> > system. Finally, we can save (152 * nproc * n) bytes. In some configurations,
> > nproc here may be 512. And if we have a lot of dying cgroup. The n can be
> > 100, 000 (I once saw it on my server).
>
> This should be part of the changelog. In general, any optimization
> should come with some numbers showing the effect of the optimization.
>
> As I've said I am not really familiar with pcp internals and how
> efficiently it can organize smaller objects. Maybe it can really half
> the memory consumption.
>
> My only concern is that using smaller types for these counters can fire
> back later on because we have an inderect dependency between the batch
> size and the data type.  In general I do not really object to the patch
> as long as savings are non trivial so that we are not creating a
> potential trap for something that is practically miniscule
> microptimization.

There is a similar structure named struct per_cpu_nodestat.

struct per_cpu_nodestat {
        s8 stat_threshold;
        s8 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
};

The s8 is enough for per-node vmstat counters. This also depends on
the batch size. It can be s8 for a long time. Why not s32 is not suitable
for the per-memcg vmstat counters? They are very similar, right?

Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
