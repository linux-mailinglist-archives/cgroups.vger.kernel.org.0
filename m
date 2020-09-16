Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3962D26CD14
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgIPUxS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 16:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgIPQyL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 12:54:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D524C0002FE
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 07:47:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so4071143pfg.13
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQGO6d/0mEB1ogv6r8XPPwwDAuJ9mmObgleVeh1W30Q=;
        b=diAhpmQrYS7M270CGrN/O5Df6Kk/JIw2jK0wB8bstS53QPuZIMXExqEKVk18DEyzjV
         lrxvcXifZ+5YUVBfWIwCtt7OL+27JGQ4L6/7JfqaU/QubBtMkdF5BiHfRNUNu5xc6s9K
         AJ7katPYRezI+CcMmjtpqq8ya/8MlrOYuWNc237it6xBe7QJU8lEHsJEiHYWLLq9ERdW
         BheACdvioFzNHXrAxzi2skE1jYQhc6reOgiq78JPVS+vGTCNAlfbk53fkYaROBTG13j7
         X1GrYdQmyNtu+fn7IOnI+Dff9pLuqE3a44IT0Q+A7uB1oip+EXX3cRjS1IJ0R+YRsUNg
         NgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQGO6d/0mEB1ogv6r8XPPwwDAuJ9mmObgleVeh1W30Q=;
        b=Ts1xYMEhi5yyzGo7IRhqRPDIOs8U4e2wCJvmqNDgeakg+rarAoDiF/hmqwT5jOv14R
         xRfXdQtdhmpzr/y2Pbd8GiUBCgC9+Gr4iMcg4+LkhN8Y2SJ7E/URA4ux7SBMn1sn/ZUC
         fhZO67PVbT0Ee4JG2lx9lOa/eHKGswg4IO+TV0sfMkpOiRhwLa748FkQ0cT+m5p9bFK0
         wuEVoi/MKssBByLDnN7T8fPjSRr1F9wifiyKUsERsiu9mukv/Gjbp2fVmlQUGy9d8HKf
         oWCxVgdFuOCshE9aVhfKhfkTx5YeZSLZ7BEFavXvM37OuJ5GZKM3NqrJzOnFL0+TrnZ9
         IXeQ==
X-Gm-Message-State: AOAM532FJB6rK/HqrTsLdOoxdTCG56XXjfaFXay2fruT0PLpmeuLk5LS
        Zn9XmjrDdHJDpg0zNceiY6xRjugVFI6AaRzHsfex6A==
X-Google-Smtp-Source: ABdhPJwHamuSqfH4lJpIQcn0CZDeDCmKb5iALIr0BJPrcv+edfAnkn4NuZArB/B5l70iTD2jJffpjleIYuvEGchu+bs=
X-Received: by 2002:aa7:941a:0:b029:142:2501:35d1 with SMTP id
 x26-20020aa7941a0000b0290142250135d1mr6672587pfo.49.1600267669164; Wed, 16
 Sep 2020 07:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200915171801.39761-1-songmuchun@bytedance.com>
 <20200915214845.GB189808@cmpxchg.org> <CAMZfGtXOR1Ed2PyB4TB5mq=1mh7p7La-4BsoZ8oYhtgc8ZcqLQ@mail.gmail.com>
 <20200916144057.GA194430@cmpxchg.org>
In-Reply-To: <20200916144057.GA194430@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 22:47:12 +0800
Message-ID: <CAMZfGtX-q6vB853YCKqW3Yo=N=AFWcQSxYF=mYK6PKC2XAHMAg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 16, 2020 at 10:42 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Sep 16, 2020 at 12:14:49PM +0800, Muchun Song wrote:
> > On Wed, Sep 16, 2020 at 5:50 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Sep 16, 2020 at 01:18:01AM +0800, Muchun Song wrote:
> > > > In the cgroup v1, we have a numa_stat interface. This is useful for
> > > > providing visibility into the numa locality information within an
> > > > memcg since the pages are allowed to be allocated from any physical
> > > > node. One of the use cases is evaluating application performance by
> > > > combining this information with the application's CPU allocation.
> > > > But the cgroup v2 does not. So this patch adds the missing information.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > >
> > > Yup, that would be useful information to have. Just a few comments on
> > > the patch below:
> > >
> > > > @@ -1368,6 +1368,78 @@ PAGE_SIZE multiple when read back.
> > > >               collapsing an existing range of pages. This counter is not
> > > >               present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
> > > >
> > > > +  memory.numa_stat
> > > > +     A read-only flat-keyed file which exists on non-root cgroups.
> > >
> > > It's a nested key file, not flat.
> >
> > This is just copied from memory.stat documentation.Is the memory.stat
> > also a nested key file?
>
> No, memory.stat is a different format. From higher up in the document:
>
>   Flat keyed
>
>         KEY0 VAL0\n
>         KEY1 VAL1\n
>         ...
>
>   Nested keyed
>
>         KEY0 SUB_KEY0=VAL00 SUB_KEY1=VAL01...
>         KEY1 SUB_KEY0=VAL10 SUB_KEY1=VAL11...
>         ...

Got it. Thanks for your explanation.

>
> > > Otherwise, this looks reasonable to me.
> >
> > OK. Will do that.
>
> Thanks!



-- 
Yours,
Muchun
