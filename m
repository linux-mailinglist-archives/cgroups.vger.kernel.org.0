Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA9F51DDCF
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348258AbiEFQtX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347271AbiEFQtW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 12:49:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F319C04
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 09:45:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k1so7964379pll.4
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0qjQRp9Z/ELa1KDMTyNkwvprvSvj/CRsN770m3dHtI=;
        b=aUldgzo43Llu6fp+QcMUGWFDlh/AyY99U1PEBR6mCdKVOwYQgufPrs60jh9yYF9clN
         Y2SCgGEm4ZYa+Bc5GnirgHFD0s8IdkDJC++bblgND/WLFVrPoOvwUURePx3LjUnlQk2A
         IitvA2tVFh80xwQvC6s3hyFSCUkrTwic4OftTnQpgLtQ/TnM5laCtMUn6ZMVcbxdEwyW
         5WqZPNGAZTtVraVeINBMqdUXSD+EgWQotbgbf4u2zDRUD4NExne3Lyu8wKc0nwJXl+at
         o9Zu6gqgA9kTdOUmy5Mo6H03U2WlteuyDkZzf4u0TP66ODku6KIQirqBxbgwhSTmP3Qu
         b4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0qjQRp9Z/ELa1KDMTyNkwvprvSvj/CRsN770m3dHtI=;
        b=HY/VpbMwlWwRyE+muERe7iFe6x6qy+3MCMSjmDVMYv+8mrstu5CMoVbiADg8e4FRTy
         BYqrQH7Oav1K5t1WHz6OCLQuFjDL6muM0JzPkAemMrMzApEqgO7WrRgFNF8UD/v8FA1V
         xxA+wQXRGymBehbRBiT5cKw9unbnsDX9rb8c3UMCMKxWtAIxUq05MLQ79bbEVQ5/kydE
         /k45hjZ79ad6Po19TDEIDx7mfCkZdeGDkAQRNHvjyPHb+jQNFq69GUf+/qvGEY6IuuZb
         n6XIqTUK9SrJQeXBNmIdGjOxeaAOUkvg0ArDPb2dDr1qDp4vipMVnd4B5ERGFZsi/oQl
         LYQw==
X-Gm-Message-State: AOAM533CNxyhC1vdGFexqXCImCg5qcbBhN0wu2qKKqTV4VuVcH8ef9NG
        q+dcUzK2xNnxo0FDmwJdgQv5/a17W8dDwCK+kQjTHelX1dI=
X-Google-Smtp-Source: ABdhPJw6uS6rcXL4dRNcjuHFRhi6WbGIuTBUz7jZ2LbGjjGzT1siQj8ASOYOjv0f+6Eh1eHAFhCe2kM68F48f0UwCoY=
X-Received: by 2002:a17:902:f682:b0:15e:951b:8091 with SMTP id
 l2-20020a170902f68200b0015e951b8091mr4494936plg.106.1651855537669; Fri, 06
 May 2022 09:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
 <YnU3EuaWCKL5LZLy@cmpxchg.org> <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
 <CAPD3tpFx9eNUULr79xy1y7=g0zT2jMebuJMVfqyCPUZnpyx2yQ@mail.gmail.com>
In-Reply-To: <CAPD3tpFx9eNUULr79xy1y7=g0zT2jMebuJMVfqyCPUZnpyx2yQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 May 2022 09:45:26 -0700
Message-ID: <CALvZod4NTiqj2tfge54=oBrYggCzGVJp13RNxr2GDWdpqMCP0w@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Fri, May 6, 2022 at 9:44 AM Ganesan Rajagopal <rganesan@arista.com> wrote:
>
> On Fri, May 6, 2022 at 9:26 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
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
> > good name for this interface, maybe max_usage or something. (2) a way
> > to reset (i.e. write to it, reset it).
>
> Thanks for the feedback. I'll post an updated patch with your suggestions
> (including updating the description). For resetting the value I assume
> setting it to memory.current would be logical?
>

Yes, that is what v1 does, so no need to do anything different.
