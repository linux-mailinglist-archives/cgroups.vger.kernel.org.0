Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D16596568
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiHPWUI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 18:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbiHPWTf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 18:19:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9035E67F
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 15:19:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 20so1845994plo.10
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/vkwmLHblp61YfsURm3yRKZjj5rnHEuckjDW4SKaq/U=;
        b=CG5u7n19ZObiTmC7dk1tO/D9YWD/37ZTz/+CG2AKj2mRMJ7g+K0tI75Y94q1xDO5Y7
         4w4SSCAa+EBIw4jdbxmMN48GSbq5CYTKKjcTZ1KH0+mWnHzvHme8CMNqCQSxR0K65mTd
         XejVK86B6WW8ze2ZsTbHXaCl5uml/jHTaVYWIodvfvHLyuvvKS9Z5pJ9I8OGvqLTQ+sW
         2fCEJ29AyxSd/mkt2SB4uS/jSOKOMD7dY5tGMZpa/ukEVrGtOlNaQCCnZ9Sqm0Mc4s1G
         ROC0wwCBHJdXCih8l6GUlivMgBNlsuF45Yl3dbCgJ0sfNnXA6bUQeuhduoaEd19TcaAz
         +bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/vkwmLHblp61YfsURm3yRKZjj5rnHEuckjDW4SKaq/U=;
        b=LxesHQo/u1xFgZJTqPOLF2gF0cebjOaocJ8/nK9hTv/6N+iHo7KqqdjW1G6H3qhIKi
         P/K+XssOw+nBUDYZN39hbYckcmlJ49ZQZ8+Gg+EwEKltmckdGea+u4fWMxrXbWcZWQh+
         gNleeoQktf0oiLRhA6pAzU/T7hCuZrpDrwgDco5MciS5pKjit2QOLSAUmITivUMv21OM
         IfkgHRWmQNqxgUtySnPOVzAjBZY1C/GHIrJlDvXe0a5VTUe8Qt6BWFNlDU+AYnOCsWlt
         nkESkwDxs03jEafVsnFbzWckuM8oYCNZSX6yB4uHE6TFgj/CbBO7wWn9nIiNyKMmIKlj
         c8jA==
X-Gm-Message-State: ACgBeo3ZreHq8kFUckGtJriO5BggriekvOJ4G4ZqoeUr8H0PPV42em1R
        6kmGigD4DdNk/Eo0U5osIRSOzHwRRrne1fhJXBlnLsb3d2c=
X-Google-Smtp-Source: AA6agR5xm/QKqhmnvQ9vc2Upkbu/QoWjM24Jk+5D61SjCo+NYDkohaqIA+eaZzqXtVDzY9//+iP4URqvS/ldWpD4yvQ=
X-Received: by 2002:a17:902:e750:b0:16f:3f32:6f5c with SMTP id
 p16-20020a170902e75000b0016f3f326f5cmr23908975plf.106.1660688366627; Tue, 16
 Aug 2022 15:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car> <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com> <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com> <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
 <Yvpm3cubIRAqUUJn@cmpxchg.org> <CAJD7tkaSS61YqYHKztqimASEaEakAdV0XqMs_k0ooJhUbX0+=g@mail.gmail.com>
 <CAJD7tkbVz44d64yPm15kUMmpFEQwFtut6Ye8D8oO1jiS9s_tBw@mail.gmail.com>
 <YvqGoxfs25bEyQGJ@cmpxchg.org> <CAJD7tkZKyNyxbtxXyWSnosJjpBmCE4CT1mMdbP-L_VEa__NoCg@mail.gmail.com>
In-Reply-To: <CAJD7tkZKyNyxbtxXyWSnosJjpBmCE4CT1mMdbP-L_VEa__NoCg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Aug 2022 15:19:15 -0700
Message-ID: <CALvZod6VhjEqzwz1BEunfwzXui+VPntDY9nkOpF0c+8UB-O=ow@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Li,Liguang" <liliguang@baidu.com>,
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

On Mon, Aug 15, 2022 at 10:56 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 10:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Aug 15, 2022 at 09:16:08AM -0700, Yosry Ahmed wrote:
> > > On Mon, Aug 15, 2022 at 8:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Mon, Aug 15, 2022 at 8:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > On Mon, Aug 15, 2022 at 06:46:46AM -0700, Yosry Ahmed wrote:
> > > > > > Yeah I understand this much, what I don't understand is why we charge
> > > > > > the zswap memory through objcg (thus tying it to memcg kmem charging)
> > > > > > rather than directly through memcg.
> > > > >
> > > > > The charged quantities are smaller than a page, so we have to use the
> > > > > byte interface.
> > > > >
> > > > > The byte interface (objcg) was written for slab originally, hence the
> > > > > link to the kmem option. But note that CONFIG_MEMCG_KMEM is no longer
> > > > > a user-visible option, and for all intents and purposes a fixed part
> > > > > of CONFIG_MEMCG.
> > > > >
> > > > > (There is the SLOB quirk. But I'm not sure anybody uses slob, let
> > > > > alone slob + memcg.)
> > > >
> > > > Thanks for the clarification, it makes sense to use the byte interface
> > > > here for this, and thanks for pointing out that CONFIC_MEMCG_KMEM is
> > > > not part of CONFIG_MEMCG.
> > > >
> > > > One more question :) memcg kmem charging can still be disabled even
> > > > with !CONFIG_MEMCG_KMEM, right? In this case zswap charging will also
> > > > be off, which seems like an unintended side effect, right?
> > >
> > > memcg kmem charging can still be disabled even
> > > with CONFIG_MEMCG_KMEM***
> >
> > Yes, indeed, if the host is booted with the nokmem flag. Doing so will
> > turn off slab, percpu, and (as of recently) zswap.
> >
> > The zswap backing storage *is* kernel memory, so that seems like the
> > correct semantics for the flag.
>
> I honestly didn't consider it first as kernel memory, as the memory is
> coming from LRU pages. It can be confusing to think about, given that
> it is memory that the kernel allocates and manages, but it has user
> data. Anyway, maybe it's not worth overthinking this, since it can be
> considered as kernel memory.

Yup not worth overthinking this.

>
> >
> > That said, the distinction between kernel and user memory is becoming
> > increasingly odd. The more kernel memory we track, the more ridiculous
> > the size of the hole you punch into resource control by disabling it.
> >
> > Maybe we should just deprecate that knob altogether.
>
> Yeah a lot of used memory will just go unaccounted even with memcg
> enabled if the knob is disabled (which is what memcg is all about).
> This is even more significant now with zswap in the picture.

Yes, we should deprecate this knob. Last I remember there were users
facing zombie issues due to kernel memory for kernels before objcg
infrastructure and used this knob to resolve the zombie issue. So, I
think this can be deprecated. Though it would be safe to first warn
and deprecate in later release.
