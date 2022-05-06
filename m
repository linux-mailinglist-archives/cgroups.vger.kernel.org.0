Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1E51DDCE
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443892AbiEFQsV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347271AbiEFQsR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 12:48:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE416D4FF
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 09:44:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g21so8627078iom.13
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rf6MstebMe7T6JVzKugNQZXbfltXJvPfsmUp0B3hsoU=;
        b=jLKEUboD2FZQ+ozGu1TE5ymLn9dqAn0Bx9eCyPK4k4XzsSowz7l1Tu+xTPMtrNQnrJ
         5PMtkEBS2y9k7znDr40M9XVMkGT0WY4buCZXvqkzxQ24mfD3fryn7YU2x5QF9M6yiGoc
         e859cuJ8QyOyyCeHYO5nZDtFGKemBTz+mEzDFzKYJsD7uvIT6T8NzsTgxtwbKU6ZY8+o
         u8Zfs+54nAd2M7uE2a+YcgDsogj101IGxjdRFN9R90V47eU5fBkXwA7P70wkJ5sTWOPa
         33m6cWGxvXhXi9tAirtlAA/VRmQEDxJOIuxjELqRuV1spKd28xyFmPCCnUc7AMOKmknx
         rO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rf6MstebMe7T6JVzKugNQZXbfltXJvPfsmUp0B3hsoU=;
        b=uxAswk6QKIkF7kuAU8Kz6tUtHMJgssvfSUdevnyUoQ+mEZuT4drGlLdzDqjGr7bQQt
         CqjLJeKennNwzybelg2OVBBbZ0raTI/KwN9yK3/48jPgh8vQlio26o+cWoTfVzh2ZiD3
         1gyU7C9LlK5dwg43ywxXWtJwCHIcWrP8iIWQslUhYvQrOSL9SJI0e2sPZ+YUzz47l6AK
         sjsfjHp4DmsxE+9LYUuUkQFmUwTBLhKcx2bshed5/cX5t8E6ial/MXPLPvGmeNXHH37E
         xrMq/JSUCjG+XnfebZfqgd9jNQdvvEnKi5wCZqfRtQBj0Z7sqLfOQ7ZT+nnMNLDPYJQl
         qwyA==
X-Gm-Message-State: AOAM532POKZaYMVlHem/rsg+4HnrLWWo5AlmuAt/eh3kOFsLfo95RQTB
        qmXiBcuIhWYdzkWuvZ4Z6Ybt8e9QfBJFH3k3JBY5Dw==
X-Google-Smtp-Source: ABdhPJz2u6m5hAYSsmxG9e0+Du1A2gIfpf8+OxpNfiG4XrO2h9NmVgW90gOouinrKG+A4QcfsQT0uIhGPHJF8YEK69s=
X-Received: by 2002:a02:3b07:0:b0:32a:efae:69ce with SMTP id
 c7-20020a023b07000000b0032aefae69cemr1729776jaa.275.1651855473373; Fri, 06
 May 2022 09:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
 <YnU3EuaWCKL5LZLy@cmpxchg.org> <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
In-Reply-To: <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
From:   Ganesan Rajagopal <rganesan@arista.com>
Date:   Fri, 6 May 2022 22:13:56 +0530
Message-ID: <CAPD3tpFx9eNUULr79xy1y7=g0zT2jMebuJMVfqyCPUZnpyx2yQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 6, 2022 at 9:26 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, May 6, 2022 at 7:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, May 05, 2022 at 05:13:30AM -0700, Ganesan Rajagopal wrote:
> > > v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
> > > sysfs. This is missing for v2 memcg though "memory.current" is exported.
> > > There is no other easy way of getting this information in Linux.
> > > getrsuage() returns ru_maxrss but that's the max RSS of a single process
> > > instead of the aggregated max RSS of all the processes. Hence, expose
> > > memcg->watermark as "memory.watermark" for v2 memcg.
> > >
> > > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
> >
> > This wasn't initially added to cgroup2 because its usefulness is very
> > specific: it's (mostly) useless on limited cgroups, on long-running
> > cgroups, and on cgroups that are recycled for multiple jobs. And I
> > expect these categories apply to the majority of cgroup usecases.
> >
> > However, for the situation where you want to measure the footprint of
> > a short-lived, unlimited one-off cgroup, there really is no good
> > alternative. And it's a legitimate usecase. It doesn't cost much to
> > maintain this info. So I think we should go ahead with this patch.
> >
> > But please add a blurb to Documentation/admin-guide/cgroup-v2.rst.
>
> No objection from me. I do have two points: (1) watermark is not a
> good name for this interface, maybe max_usage or something. (2) a way
> to reset (i.e. write to it, reset it).

Thanks for the feedback. I'll post an updated patch with your suggestions
(including updating the description). For resetting the value I assume
setting it to memory.current would be logical?

Ganesan
