Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0852AA63
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiEQSOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbiEQSOB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 14:14:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F83515A3
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 11:13:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so1865972wme.5
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxdLGiW7G4yy4xMRD8hfhHfhbpz1FE3G/RxrHKIn0i4=;
        b=dlOjwguLoSABSlSgnpYbdu/+hz6xKKTWhzMk/C7LJGmIpRXsihQvKoARr8bmjTriEN
         CnZHHPI2C6oDaLfkZ/omNpk2kv0RAjqvQFOH1wjzYlmNblToLm7kwdYRSORYVgTzy0TX
         x43CqGlTOW1HisGyl/oCzP8SWveY/V6ov38GxWtdQ8CjCkCQMPiNjeBLGeHRIXMTCCNQ
         5tFyi/hY0V1RA7m53sC3PKKtrvyTOju4KPAXPgE9CjhmIumupMoyfhcxAfdfeO8b1T18
         J7mie+Ri7kqib9BUe8Ys0WGxdy5mjIjG5eEIc6KeN0U5Rz8uIL1LV+0NDyoqZqumhfU8
         BdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxdLGiW7G4yy4xMRD8hfhHfhbpz1FE3G/RxrHKIn0i4=;
        b=vvkzwPotLhbmo97D//l3qwhNlj/ysZ47KbLO0yJIUgJt3P5Vh8EhoWvCUk6wv7XXMt
         EGSOoOaFIDU/Mf9+8KnGGWgt33krubKh1ImIoyEOobcy0tVn3I52C8GAuHVLbVDkhQFL
         jlJcfialj5B7U5cyazHR5Hk7X7ZKus2ux8AYC+/oBO89nsMWBiSkTzwkvB0hD2krKHJv
         7u+XYFjRg2J+EFNq+9BiK2Avwl+jazyx0HNo67mMtMqDHwpD4/gtSyyk02MBR+Mo+uZ0
         ZNOfU6Kqw/Krda/0cl8g8kDXMFk3bLIS/fMokR6OWJyfphGF8sUrTmK4eRL/0XVV0jdE
         +UEA==
X-Gm-Message-State: AOAM5308CrMGbsGxCjAOmnWxgMS4ZeCg3fP74W58/8ZoNqy7EL4H6DCT
        wig9CZls6vzAsRl6rufJf2q76PotZcbsHT6ombPk4w==
X-Google-Smtp-Source: ABdhPJwoiJ5pxRwzxetMp75okFV9PBCgHVA8ptysLcZUPvY8nSQ/S2080HUHHLeS3rHYTa428cdTOMVUWbutGjM/LlI=
X-Received: by 2002:a05:600c:1910:b0:394:8517:496e with SMTP id
 j16-20020a05600c191000b003948517496emr22699150wmq.24.1652811226699; Tue, 17
 May 2022 11:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoPHtHXzpK51F/1Z@carbon>
In-Reply-To: <YoPHtHXzpK51F/1Z@carbon>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 17 May 2022 11:13:10 -0700
Message-ID: <CAJD7tkbbiP0RusWBdCvozjauKN-vhgvzWtsL3Hu5y2dLr63idQ@mail.gmail.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
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

On Tue, May 17, 2022 at 9:05 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Mon, May 16, 2022 at 03:29:42PM -0700, Yosry Ahmed wrote:
> > The discussions on the patch series [1] to add memory.reclaim has
> > shown that it is desirable to add an argument to control the type of
> > memory being reclaimed by invoked proactive reclaim using
> > memory.reclaim.
> >
> > I am proposing adding a swappiness optional argument to the interface.
> > If set, it overwrites vm.swappiness and per-memcg swappiness. This
> > provides a way to enforce user policy on a stateless per-reclaim
> > basis. We can make policy decisions to perform reclaim differently for
> > tasks of different app classes based on their individual QoS needs. It
> > also helps for use cases when particularly page cache is high and we
> > want to mainly hit that without swapping out.
> >
> > The interface would be something like this (utilizing the nested-keyed
> > interface we documented earlier):
> >
> > $ echo "200M swappiness=30" > memory.reclaim
>
> What are the anticipated use cases except swappiness == 0 and
> swappiness == system_default?
>
> IMO it's better to allow specifying the type of memory to reclaim,
> e.g. type="file"/"anon"/"slab", it's a way more clear what to expect.

I imagined swappiness would give user space flexibility to reclaim a
ratio of file vs. anon as it sees fit based on app class or userspace
policy, but I agree that the guarantees of swappiness are weak and we
might want an explicit argument that directly controls the return
value of get_scan_count() or whether or not we call shrink_slab(). My
fear is that this interface may be less flexible, for example if we
only want to avoid reclaiming file pages, but we are fine with anon or
slab. Maybe in the future we will have a new type of memory to
reclaim, does it get implicitly reclaimed when other types are
specified or not?

Maybe we can use one argument per type instead? E.g.
    $ echo "200M file=no anon=yes slab=yes" > memory.reclaim

The default value would be "yes" for all types unless stated
otherwise. This is also leaves room for future extensions (maybe
file=clean to reclaim clean file pages only?). Interested to hear your
thoughts on this!

>
> E.g. what
> $ echo "200M swappiness=1" > memory.reclaim
> means if there is only 10M of pagecache? How much of anon memory will
> be reclaimed?

Good point. I agree that the type argument or per-type arguments have
multiple advantages over swappiness.

>
> Thanks!
