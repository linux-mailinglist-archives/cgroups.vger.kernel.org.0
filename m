Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD631421522
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhJDR1W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhJDR1V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 13:27:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCFC061745
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 10:25:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i24so25386171lfj.13
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKBTIHZkFkwseGAi5II5oGVj0iBXe7h2uvt78kuBKSA=;
        b=bBqGZLltEUDsR1PL9Qc1Y/XRczlTpQxaY5AFRGuodqngidy2xOtDflakPH5qdOqet0
         ny3SMOeBMt2G4zr7THRWei1s9a9znFAqdy7l8EbjWtiqoCkmH5ZY6ewRFn6M+9PmOZh7
         DV3FZ5a8xAC6Y04zmZqcJ48/Js2PEaa/0LC0yJn4nRk0oiYY1nAkGggkRnmPKxPlmVF4
         GErOtqrFb2+A5BIZdLLgIsEZ4qDah8/7VyCTtKaFb4za+Tk32wmnsjxI6tTj1hVG+M3Q
         gwNbLXdk/1YG8nhU32hxUc+vnh5/8TgxuzvkLfzzX5LYxFxLY+ygKfBQ5MSfZKEW90Ew
         SAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKBTIHZkFkwseGAi5II5oGVj0iBXe7h2uvt78kuBKSA=;
        b=bdQCFNDB019SXnhk/oEXD+jbnG8ykVQ60tzfzB9wsZVlUAwQlsPcScNtm6BF4qqc86
         4Yf1/ShnshGOKPgjohvfZck0NJD8yss+7J9Sot/wVu9fIXlqaZZlLkmco8zn8iR8Kp8g
         /h2QA802p+mFRfc8wrOLcsDtH4t/zXV/84vqeUd0Mjk0uyCOot7c54E4GyYaruX0DYtP
         tiT9ann32rbeY7lvt0b4bNa6dkZTeR+MJdMFVvP+P20H7n9++kCUe8NdOcEYxX9qRU4B
         CiaUTUZUzuQHOOO08Ppzgpxu2eyGk7aZnRuVGrvkOEVMTOgHPqJcBNDjFhm1XyhVoKrR
         JttA==
X-Gm-Message-State: AOAM530owOJSb0I2/0jX1+mR2B2/vxvQyssRSwbyBQ9trs1+6BPPxkOv
        iaGIvFA9tszlfN5DQiVFgGzqxgDZSnPN2wTMXqb6kQ==
X-Google-Smtp-Source: ABdhPJzUTQp6h+Sb/2NzFKgUR2uR7Qc2dWO/JFqsIhiNclfxF49MzRER5nTGq/dvtBpWJX0w4hgl9SfOI8qSEhxVitk=
X-Received: by 2002:a2e:a370:: with SMTP id i16mr16470454ljn.35.1633368323563;
 Mon, 04 Oct 2021 10:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929235936.2859271-1-shakeelb@google.com> <YVszNI97NAAYpHpm@slm.duckdns.org>
In-Reply-To: <YVszNI97NAAYpHpm@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Oct 2021 10:25:12 -0700
Message-ID: <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
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

On Mon, Oct 4, 2021 at 10:00 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Shakeel.
>
> On Wed, Sep 29, 2021 at 04:59:36PM -0700, Shakeel Butt wrote:
> > Currently cgroup_rstat_updated() has a speculative already-on-list test
> > to check if the given cgroup is already part of the rstat update tree.
> > This helps in reducing the contention on the rstat cpu lock. This patch
> > adds the similar speculative not-on-list test on the rstat flush
> > codepath.
> >
> > Recently the commit aa48e47e3906 ("memcg: infrastructure to flush memcg
> > stats") added periodic rstat flush. On a large system which is not much
> > busy, most of the per-cpu rstat tree would be empty. So, the speculative
> > not-on-list test helps in eliminating unnecessary work and potentially
> > reducing contention on the rstat cpu lock. Please note this might
> > introduce temporary inaccuracy but with the frequent and periodic flush
> > this would not be an issue.
> >
> > To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
> > a system with swap-on-zram and the file was pushed to swap through
> > memory.force_empty interface. On reading the whole file, the memcg stat
> > flush in the refault code path is triggered. With this patch, we
> > observed 38% reduction in the read time of 8 GiB file.
>
> The patch looks fine to me but that's a lot of reduction in read time. Can
> you elaborate a bit on why this makes such a huge difference? Who's hitting
> on that lock so hard?
>

It was actually due to machine size. I ran a single threaded workload
without any interference on a 112 cpus machine. So, most of the time
the flush was acquiring and releasing the per-cpu rstat lock for empty
trees.

Shakeel
