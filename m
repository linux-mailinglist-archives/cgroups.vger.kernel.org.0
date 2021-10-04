Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938D1421617
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhJDSJv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhJDSJs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 14:09:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF3C061745
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 11:07:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y26so75685859lfa.11
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wD6uuf3ru6YVNe7+4jEAmC2naccUsJPrRjEclRtsE7k=;
        b=ay567YeX+xvQosVRiRU+umrEP8Dfr/v0GOPuimkdV+SH13Kr5erX7ASGE7cibqmECp
         ey6exYQnFbUcRE1FQYpqaATUQPWZ8lOCy8w2kg2OznxoEVJUociUrntfZqHwTYXRjfk3
         ztjnw7OKKSOhPVODNyjj6gwan7EqdlVeXHgBUwMiMIGhjI/jXl/ZV31Y8Xh5TMJDyTa4
         eG7amjqFkoL3vGXo5P/UoueH7Mhhov2pn0NMg0MLjxEP8lAy98+ZjFJ/N9z2G7ytAKVL
         w/D48MG83NvxCGzXK6TtUUdXRDKy8ieLL/unqgmBFCFBVVG8LoKWdA9H1tXcEwOcQYQD
         ZPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wD6uuf3ru6YVNe7+4jEAmC2naccUsJPrRjEclRtsE7k=;
        b=recdvR2JeyUM5rPiFxL/y1hE+oi7ZV96c2/N/qop7fwJ4omZtVLsc0yw0E1/HEcP3b
         20gAmID72AUie56q78qirg1qIZ+/6mn6i79KYpyipc+tb2xV2EIBSirhGYJyyMlbt6hb
         WFcIRbjNtg+DZeRDUz+thZ5o12q5UQ4dAyKB/DGKZ9YenhqfY+zfYYTS2xa+eTsRwhjz
         BR5XXjYPAGOlK6bdImF4RVQy8HqQz/PDs/VNVj0C8IB1goqp3GmK0NpOv5ZjNktYzZ/p
         oabxSaFcU1AIGNB04l1U+t9r9cAvuS0TeXy7h7OhwStO7EGvBErnVbBaITRDo1pvvgFf
         isew==
X-Gm-Message-State: AOAM532h0lqmdCacl8EEnXW67OmgWZhNMtWlx95JJIslcPZdd6/RTnxi
        6vXSjihLAbHOAXlG40hogx6OM/IDHYIgSLAvG92sUIfHHD6jTI8x
X-Google-Smtp-Source: ABdhPJzykszutLekTSW+ycZIO/NYRuePsBzhxhWoCWntFLWMioYbroQE3kMa1bjhN/tYQ1S80G3lkbxbIGP2YTgoBE8=
X-Received: by 2002:a05:6512:2211:: with SMTP id h17mr15941482lfu.494.1633370876646;
 Mon, 04 Oct 2021 11:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210929235936.2859271-1-shakeelb@google.com> <YVszNI97NAAYpHpm@slm.duckdns.org>
 <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com> <YVs9eJnNJYwF/3f3@slm.duckdns.org>
In-Reply-To: <YVs9eJnNJYwF/3f3@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Oct 2021 11:07:45 -0700
Message-ID: <CALvZod47r=9j_MhZz9ngWv_JE4oqF1CrXTOQ2GpSSNFftZAsVA@mail.gmail.com>
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 4, 2021 at 10:44 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Oct 04, 2021 at 10:25:12AM -0700, Shakeel Butt wrote:
> > > > To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
> > > > a system with swap-on-zram and the file was pushed to swap through
> > > > memory.force_empty interface. On reading the whole file, the memcg stat
> > > > flush in the refault code path is triggered. With this patch, we
> > > > observed 38% reduction in the read time of 8 GiB file.
> > >
> > > The patch looks fine to me but that's a lot of reduction in read time. Can
> > > you elaborate a bit on why this makes such a huge difference? Who's hitting
> > > on that lock so hard?
> >
> > It was actually due to machine size. I ran a single threaded workload
> > without any interference on a 112 cpus machine. So, most of the time
> > the flush was acquiring and releasing the per-cpu rstat lock for empty
> > trees.
>
> Sorry for being so slow but can you point to the exact call path which gets
> slowed down so significantly?

This is the mem_cgroup_flush_stats() inside workingset_refault() in
mm/workingset.c.

> I'm mostly wondering whether we need some sort
> of time-batched flushes because even with lock avoidance the flush path
> really isn't great when called frequently. We can mitigate it further if
> necessary - e.g. by adding an "updated" bitmap so that the flusher doesn't
> have to go around touching the cachelines for all the cpus.

For the memcg stats, I already proposed a batched flush at [1].

I actually did perform the same experiment with the proposed patch
along with [1] and it improves around just 1%. More specifically for
memcg stats [1] is good enough but that is memcg specific and this
patch has merits on its own.

[1] https://lkml.kernel.org/r/20210930044711.2892660-1-shakeelb@google.com

>
> Thanks.

>
> --
> tejun
