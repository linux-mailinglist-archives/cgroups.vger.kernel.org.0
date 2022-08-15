Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD4593442
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiHOR4m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 13:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiHOR4h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 13:56:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0075175B8
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 10:56:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so9938934wrp.0
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XCzC1k5JaSs6DVSxuA2P3WfUqr4hU66sPfesxZu2dUs=;
        b=HOKkfB0gFcImmm8qD1rRnAB9O6Np3Uxgn5FoWtQm+SA9NiFobkW0mDb2PoQNBqFCng
         rH29D9fdqxBaHiwjgUmtaIX/II1UBXNecm+GG8Ju6AhJ4C9Z4a3mSrvGuS2jknZrJnJJ
         Y+s4yHlSemcD8+ZH1KXhaV9VDkJhmSW8qqweYrSjyNMAU1yNiLAruehBOBq0XweJOm/U
         rMUCZOu+cPA7fbW45VyT3mZS2uFRmJ4DpFjwxZZqKBCuFCxZ5yQ80+p7UuFjI7zMtJK7
         GSQ+PZ4jdWGWBy81yVXZwkuuPDAUNKug6Xr0M3VdqDav61SotURKhAgAPrJ4hwea/Tfw
         loCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XCzC1k5JaSs6DVSxuA2P3WfUqr4hU66sPfesxZu2dUs=;
        b=gD8PwDW+VJLupXnSBr0TubupqFRvb+CwE9QVccJgy0JifdPYpkUsWSlUOvNJLmWgQE
         gG6uf38r5QJGemi2obHDNZLH2pJUnXHXVqDoKcGHHp7d0q+y7khIQ2ok9/xUMIebjlKU
         ODqn5rEE0VyIGsIR8LwohpKqS2kHYM/ffOnT2HV8eN/N+X3e20ZXbFG2vYW5wvP9YelN
         OzWHCnbFgtdAKslqVLfin6aOHnfPlPilF0/xekG70LenAPm3tSix9AVVlsXwMdjbGSVk
         4Orjg8J4U0iUt0CzI3aLTlCV9VRFJT42Tm9SORoaQNGgMPYIDmxhbMgIGvOCmdqV8GP2
         Ovog==
X-Gm-Message-State: ACgBeo2N+pk0LmXmoLC5RFcslMQRrDdqQA05RfzJLz5427TR1Y8MVTKa
        5i2RNJdqqB5MmbUyHRPEajd9YVQFXztsNUruzr7Gxg==
X-Google-Smtp-Source: AA6agR5WxDpkq7lUDE4ES4zBp3sfSgorTNgHBU/js0SQqHPAdx+jUSoC7kbBk7VnWIagobmgCUBBptw8Fx1p/oVEJFA=
X-Received: by 2002:a05:6000:1379:b0:21f:c4d:957a with SMTP id
 q25-20020a056000137900b0021f0c4d957amr9538354wrz.210.1660586193170; Mon, 15
 Aug 2022 10:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car> <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com> <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com> <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
 <Yvpm3cubIRAqUUJn@cmpxchg.org> <CAJD7tkaSS61YqYHKztqimASEaEakAdV0XqMs_k0ooJhUbX0+=g@mail.gmail.com>
 <CAJD7tkbVz44d64yPm15kUMmpFEQwFtut6Ye8D8oO1jiS9s_tBw@mail.gmail.com> <YvqGoxfs25bEyQGJ@cmpxchg.org>
In-Reply-To: <YvqGoxfs25bEyQGJ@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 15 Aug 2022 10:55:56 -0700
Message-ID: <CAJD7tkZKyNyxbtxXyWSnosJjpBmCE4CT1mMdbP-L_VEa__NoCg@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Li,Liguang" <liliguang@baidu.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
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

On Mon, Aug 15, 2022 at 10:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Aug 15, 2022 at 09:16:08AM -0700, Yosry Ahmed wrote:
> > On Mon, Aug 15, 2022 at 8:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Mon, Aug 15, 2022 at 8:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Mon, Aug 15, 2022 at 06:46:46AM -0700, Yosry Ahmed wrote:
> > > > > Yeah I understand this much, what I don't understand is why we charge
> > > > > the zswap memory through objcg (thus tying it to memcg kmem charging)
> > > > > rather than directly through memcg.
> > > >
> > > > The charged quantities are smaller than a page, so we have to use the
> > > > byte interface.
> > > >
> > > > The byte interface (objcg) was written for slab originally, hence the
> > > > link to the kmem option. But note that CONFIG_MEMCG_KMEM is no longer
> > > > a user-visible option, and for all intents and purposes a fixed part
> > > > of CONFIG_MEMCG.
> > > >
> > > > (There is the SLOB quirk. But I'm not sure anybody uses slob, let
> > > > alone slob + memcg.)
> > >
> > > Thanks for the clarification, it makes sense to use the byte interface
> > > here for this, and thanks for pointing out that CONFIC_MEMCG_KMEM is
> > > not part of CONFIG_MEMCG.
> > >
> > > One more question :) memcg kmem charging can still be disabled even
> > > with !CONFIG_MEMCG_KMEM, right? In this case zswap charging will also
> > > be off, which seems like an unintended side effect, right?
> >
> > memcg kmem charging can still be disabled even
> > with CONFIG_MEMCG_KMEM***
>
> Yes, indeed, if the host is booted with the nokmem flag. Doing so will
> turn off slab, percpu, and (as of recently) zswap.
>
> The zswap backing storage *is* kernel memory, so that seems like the
> correct semantics for the flag.

I honestly didn't consider it first as kernel memory, as the memory is
coming from LRU pages. It can be confusing to think about, given that
it is memory that the kernel allocates and manages, but it has user
data. Anyway, maybe it's not worth overthinking this, since it can be
considered as kernel memory.

>
> That said, the distinction between kernel and user memory is becoming
> increasingly odd. The more kernel memory we track, the more ridiculous
> the size of the hole you punch into resource control by disabling it.
>
> Maybe we should just deprecate that knob altogether.

Yeah a lot of used memory will just go unaccounted even with memcg
enabled if the knob is disabled (which is what memcg is all about).
This is even more significant now with zswap in the picture.
