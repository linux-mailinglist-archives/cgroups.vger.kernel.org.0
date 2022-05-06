Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF87E51E099
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444325AbiEFVH5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 17:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378271AbiEFVH4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 17:07:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B416EC40
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 14:04:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v10so7006603pgl.11
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/GiMZkwziqGVKRswzEq3KwN0WZ0d2CZmkLA7V2xges=;
        b=rLijwaVPAMsRydy7EXWF4RLC/0NsdSSaCfI/QiICpS/c5u8iUKncH59HRzLuoFhl0M
         WF+udOYUKCFKzaw7r4wqvM08AqPTC3aInhgNle06I9Dcn5wOpLqW5/OVm9klyCcvVUre
         yS4VfOh9A6/Y2BEBeviTklCXMYTmDelnOP97hySBEICezb6xFanRb7fzTqclHrraw9c+
         lfImj5dXVX7gMDnMNB3agTiCY4S+n4tVeUarOaMkn/+28nfy2LFr594ysBdYPmWZBZYU
         G6VZmjkgkJ4gjPBQdrbPwVU87/4Q/pYxrrcmVDkafSpBsvsl0ezEUrgDC4DUuuvs9BXU
         Dufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/GiMZkwziqGVKRswzEq3KwN0WZ0d2CZmkLA7V2xges=;
        b=7gPJNtC7Lr6C2qwfOJ74WwSGKo5bz6cAgut5gdqf65RDMR4dAER0QNsQ1DatJZdLXq
         uZj63vPsypVdarGcPbcbnpM8i2dQC8rW5WcknFcBcVlFU5tZc6mGpJnFHFAGzMItve0O
         rmQwl65CKf2qk5vakt4c1qV4KLTld+QuKjy1CsAxWstkMeqnFbzi3btOMTUr0gxnYxip
         weiEflwS1lVqnx0XtYe87PPaeLqA7Jp0fix5mpAn4/kBspzUCObfKhefzadRP+OlZHau
         rXz8zRL2wXLufVN4FIGNUBiRl7hyjPrsESbsRWajwE1sbWrpUq+MItoy7Oi3gFPvqBFL
         mtWw==
X-Gm-Message-State: AOAM532YzjqFKz2zDxdDlUAa3yjpj5t20Qt98yFojkTpZmtjxgwiQONK
        LzUVnG0+Tr2gX0sVquOvgOG0uJa8RaI4D+pnJgzHng==
X-Google-Smtp-Source: ABdhPJxroGIi3ECGLBHZLWXn+a5SRECWfWcZa0be3+Zrt8x/nte5b7bF+HWtbZ5kJM6MkPqHl9rTXQsaZYBO1Ykc0ok=
X-Received: by 2002:a63:382:0:b0:3c2:1669:e57b with SMTP id
 124-20020a630382000000b003c21669e57bmr4267599pgd.509.1651871051869; Fri, 06
 May 2022 14:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
 <YnU3EuaWCKL5LZLy@cmpxchg.org> <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
 <YnWJ5QgRyc+Ualjx@cmpxchg.org>
In-Reply-To: <YnWJ5QgRyc+Ualjx@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 May 2022 14:04:00 -0700
Message-ID: <CALvZod5V1OTLPu339=gNForq0WdErCABDuhtraps1UEk+qEM7w@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ganesan Rajagopal <rganesan@arista.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 6, 2022 at 1:50 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 06, 2022 at 08:56:31AM -0700, Shakeel Butt wrote:
> > On Fri, May 6, 2022 at 7:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Thu, May 05, 2022 at 05:13:30AM -0700, Ganesan Rajagopal wrote:
> > > > v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
> > > > sysfs. This is missing for v2 memcg though "memory.current" is exported.
> > > > There is no other easy way of getting this information in Linux.
> > > > getrsuage() returns ru_maxrss but that's the max RSS of a single process
> > > > instead of the aggregated max RSS of all the processes. Hence, expose
> > > > memcg->watermark as "memory.watermark" for v2 memcg.
> > > >
> > > > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
> > >
> > > This wasn't initially added to cgroup2 because its usefulness is very
> > > specific: it's (mostly) useless on limited cgroups, on long-running
> > > cgroups, and on cgroups that are recycled for multiple jobs. And I
> > > expect these categories apply to the majority of cgroup usecases.
> > >
> > > However, for the situation where you want to measure the footprint of
> > > a short-lived, unlimited one-off cgroup, there really is no good
> > > alternative. And it's a legitimate usecase. It doesn't cost much to
> > > maintain this info. So I think we should go ahead with this patch.
> > >
> > > But please add a blurb to Documentation/admin-guide/cgroup-v2.rst.
> >
> > No objection from me. I do have two points: (1) watermark is not a
> > good name for this interface, maybe max_usage or something.
>
> How about memory.peak? It'd be nice to avoid underscores.
>
> > (2) a way to reset (i.e. write to it, reset it).
>
> We used to have that with cgroup1, but it gets weird in modern cgroup
> environments when there can be multiple consumers. One of them resets
> the stat for their own purpose, now the others have no idea what
> sample time frame they are looking at.
>
> It'd be more robust if we just said "peak usage since birth of
> cgroup". If you want to sample new work, create a new cgroup.

SGTM for both.
