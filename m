Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0412151E052
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443555AbiEFUyY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443621AbiEFUyV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 16:54:21 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E2D6D3B0
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 13:50:37 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z126so6774769qkb.2
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kM1Re2q1+o0mt7HNTzM9pmXb6Uv+LgAUNdOExkGF+Sk=;
        b=nCHZ2VjR2LksJL8hdsGYZ4YP8kaLy7y7F6GQMdz9S/7UTbw/6qCJQA9cmKW5G4fvEK
         /nrOkjPS9aulj5o7hdS9zR69R2yovdEm6GdgAtRvQfFTBhvcYYGrIBZxKRcrQsHfKt59
         PWcTPtpYxK+8sL58NOSDkbq4jtTVF8o0O7MVP55ECx2Vnwk7dNRqhxwAIsgFEYqluaaR
         7U2Ed+uAGYvDnd36Aem7eflCHJ5Fnmp5OYyhPx7RJzCyWZQvuRVxqnKlpNTwIhr5P5MQ
         k7YzRaQHr5ptE/nQqk/ADvfd7lOXxDdNS6xmjkb2dY0GhfS+HZ1cl8yCexk56ZIB12d5
         Il/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kM1Re2q1+o0mt7HNTzM9pmXb6Uv+LgAUNdOExkGF+Sk=;
        b=GWWpM6lyENoaV90KDIQfNo0DiuIu+ncnqLtCFOhQTmvAcQ47V750HCwmVzgZlCaT11
         hnRfzECXCeYW/90k0XCdmCugkY+9To2CVGFskhZGLVGxaRdDHXeoZ7CdeGKwFNHll3r6
         ki8ZcOoMzFruZKykS1hm+mhGnY0Unhvr5bMn+Wq3ePYa2d26FNOgSAXxMSXD1lr/m5wa
         EZFzqi5iAH1LXqL6EUBDQUBX8jBks0W+y7BA6pa+Shi26GsstwQmVRNFdNkz55rKQGkX
         ycPq8CnfWH+zc6AQ3z97Aftx+wxK4gk1/E3ZmYgPd9UNfwBZTl3qnpg9yTnxwlGeV2DZ
         hpAg==
X-Gm-Message-State: AOAM531PmbxI9A5kcLvH9/pUjUGwQqZaiK1qTXYvdvhNdObOQeY664WR
        bD1g+rROcU9+azvbQ7cy3e8zHA==
X-Google-Smtp-Source: ABdhPJwz1fDLm1s6qehStx74QYuE7hT/C4Zr9EzZiDpYQAVy+OzmK2UclNs7slFeMc5XkYwg6ibmPg==
X-Received: by 2002:a37:5584:0:b0:69e:d812:4b4f with SMTP id j126-20020a375584000000b0069ed8124b4fmr3707452qkb.45.1651870236219;
        Fri, 06 May 2022 13:50:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:538c])
        by smtp.gmail.com with ESMTPSA id i22-20020ae9ee16000000b0069fc13ce1e5sm2937032qkg.22.2022.05.06.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:50:35 -0700 (PDT)
Date:   Fri, 6 May 2022 16:49:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Ganesan Rajagopal <rganesan@arista.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2
 memcg
Message-ID: <YnWJ5QgRyc+Ualjx@cmpxchg.org>
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
 <YnU3EuaWCKL5LZLy@cmpxchg.org>
 <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 06, 2022 at 08:56:31AM -0700, Shakeel Butt wrote:
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
> good name for this interface, maybe max_usage or something.

How about memory.peak? It'd be nice to avoid underscores.

> (2) a way to reset (i.e. write to it, reset it).

We used to have that with cgroup1, but it gets weird in modern cgroup
environments when there can be multiple consumers. One of them resets
the stat for their own purpose, now the others have no idea what
sample time frame they are looking at.

It'd be more robust if we just said "peak usage since birth of
cgroup". If you want to sample new work, create a new cgroup.
