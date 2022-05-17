Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07952AC7C
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiEQULw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 16:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiEQULv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 16:11:51 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41703466D
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 13:11:50 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id bm18-20020a056820189200b0035f7e56a3dfso23434oob.8
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Eui4Xs+XTv+2fskDeZzVLFI7BoyJsiN1wcr5vwpuw=;
        b=WU/rjkUAPamtv0gkPDycWAE77Am36/IyWuJpo5Zb2eziurBXoSNBUk8a/btdXSi4vl
         JYdTjNlc1tFfa+zFQQGfnVCkC4iSfenQQOnM/K3wh621mRpoPOdyJzslLbh3/4vHD+5+
         9Q+KDe8qFb13wyO/kUhHD8ykWgNnfdQTI9okC1NnIZFUIXltN8CK26H5pdqfKR46vNo8
         wJbBaQSlH6elChFUIYs2QL5H3p/l4vhCPKX7zktNzuNWL/4HU8YhrJ+6JbwYLN0+kyut
         UqAZ6Do0nKd4p6ualilc3kQp8Z/KwO46JHWnNORLCqjsoP/PCpGwNNqdTTCSIZ9Imkvj
         dCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Eui4Xs+XTv+2fskDeZzVLFI7BoyJsiN1wcr5vwpuw=;
        b=LvhkBWchvT2YMQk2UlP392cG61R08O2j2+CSckB0DgFwVaQ9Go2iiKoLt6XP/jeW/7
         zE1Ajc0MtFpBZ6UaU9yKDrmiURmIIM/XojCb2D8UIJlWvlhv1Wex1wtfd9sbVZyppPJK
         vf0AmcQr7/c0mlLeI8BOvWrzHJSRY25i46+0z4cIWakOnnhjwA/SlnAVEez+f9PUovP3
         6bnY+cfX3hJyl4ARReVVaJCzV9vgjCvfwRuqTrx7OI6TUiiqMC0wT/vCCrtfp9P1W+/k
         PZZa7Z/u75ddHm/hApbbQIJLWvZTjSXu2kZGtSoruomXNq2sZkyMtUs8JzczejpSIT8U
         bvcw==
X-Gm-Message-State: AOAM532GM7C/zZTJ1ckTW6B4+Dbh1gT9X2j3eOODTrV5RRdM8G+v53cR
        HwOBW1HYHtoo1et/8kY6SFej61qnKnCUg45ZUw+gDw==
X-Google-Smtp-Source: ABdhPJzuEzXPYLDRIUsQ0UUxlDf91VeLnwxnj1XJx1S2hSq/7TMXpvon5ep0s+XDdBTXAYlUx1DJHIS6xuThHLamwPw=
X-Received: by 2002:a4a:d40d:0:b0:33a:33be:9c1e with SMTP id
 n13-20020a4ad40d000000b0033a33be9c1emr8631037oos.96.1652818309731; Tue, 17
 May 2022 13:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoPHtHXzpK51F/1Z@carbon> <CAJD7tkbbiP0RusWBdCvozjauKN-vhgvzWtsL3Hu5y2dLr63idQ@mail.gmail.com>
 <YoP8P7hzXIyogQ68@carbon>
In-Reply-To: <YoP8P7hzXIyogQ68@carbon>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 17 May 2022 13:11:13 -0700
Message-ID: <CAJD7tkaPWcFyisv3Kso0AFUGkQiiAiFmsV2R3ZU2SNc4XP8v+w@mail.gmail.com>
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

On Tue, May 17, 2022 at 12:49 PM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Tue, May 17, 2022 at 11:13:10AM -0700, Yosry Ahmed wrote:
> > On Tue, May 17, 2022 at 9:05 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Mon, May 16, 2022 at 03:29:42PM -0700, Yosry Ahmed wrote:
> > > > The discussions on the patch series [1] to add memory.reclaim has
> > > > shown that it is desirable to add an argument to control the type of
> > > > memory being reclaimed by invoked proactive reclaim using
> > > > memory.reclaim.
> > > >
> > > > I am proposing adding a swappiness optional argument to the interface.
> > > > If set, it overwrites vm.swappiness and per-memcg swappiness. This
> > > > provides a way to enforce user policy on a stateless per-reclaim
> > > > basis. We can make policy decisions to perform reclaim differently for
> > > > tasks of different app classes based on their individual QoS needs. It
> > > > also helps for use cases when particularly page cache is high and we
> > > > want to mainly hit that without swapping out.
> > > >
> > > > The interface would be something like this (utilizing the nested-keyed
> > > > interface we documented earlier):
> > > >
> > > > $ echo "200M swappiness=30" > memory.reclaim
> > >
> > > What are the anticipated use cases except swappiness == 0 and
> > > swappiness == system_default?
> > >
> > > IMO it's better to allow specifying the type of memory to reclaim,
> > > e.g. type="file"/"anon"/"slab", it's a way more clear what to expect.
> >
> > I imagined swappiness would give user space flexibility to reclaim a
> > ratio of file vs. anon as it sees fit based on app class or userspace
> > policy, but I agree that the guarantees of swappiness are weak and we
> > might want an explicit argument that directly controls the return
> > value of get_scan_count() or whether or not we call shrink_slab(). My
> > fear is that this interface may be less flexible, for example if we
> > only want to avoid reclaiming file pages, but we are fine with anon or
> > slab.
> > Maybe in the future we will have a new type of memory to
> > reclaim, does it get implicitly reclaimed when other types are
> > specified or not?
> >
> > Maybe we can use one argument per type instead? E.g.
> >     $ echo "200M file=no anon=yes slab=yes" > memory.reclaim
> >
> > The default value would be "yes" for all types unless stated
> > otherwise. This is also leaves room for future extensions (maybe
> > file=clean to reclaim clean file pages only?). Interested to hear your
> > thoughts on this!
>
> The question to answer is do you want the code which is determining
> the balance of scanning be a part of the interface?
>
> If not, I'd stick with explicitly specifying a type of memory to scan
> (and the "I don't care" mode, where you simply ask to reclaim X bytes).
>
> Otherwise you need to describe how the artificial memory pressure will
> be distributed over different memory types. And with time it might
> start being significantly different to what the generic reclaim code does,
> because the reclaim path is free to do what's better, there are no
> user-visible guarantees.

My understanding is that your question is about the swappiness
argument, and I agree it can get complicated. I am on board with
explicitly specifying the type(s) to reclaim. I think an interface
with one argument per type (whitelist/blacklist approach) could be
more flexible in specifying multiple types per invocation (smaller
race window between reading usages and writing to memory.reclaim), and
has room for future extensions (e.g. file=clean). However, if you
still think a type=file/anon/slab parameter is better we can also go
with this.

I imagine this will be an enum/flags that will be passed to
try_to_free_pages() instead of may_swap, and then we can map it to one
bit flags in struct scan_control. The anon/file flags will be used to
control list type in shrink_lruvec (get_scan_counts) and
mem_cgroup_soft_limit_reclaim(), and the slab flag will be used to
control calls to shrink_slab().

This is orthogonal, but while we are at it we can also add a
"controlled_reclaim" flag that we use to control whether we call
vmpressure or not. I assume we don't want to count vmpressure for
controlled reclaim, similar to PSI. We can then also revert
e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim as
memory pressure") and use the same flag to control calls to psi.

>
> >
> > >
> > > E.g. what
> > > $ echo "200M swappiness=1" > memory.reclaim
> > > means if there is only 10M of pagecache? How much of anon memory will
> > > be reclaimed?
> >
> > Good point. I agree that the type argument or per-type arguments have
> > multiple advantages over swappiness.
>
> If a user wants to select multiple types of memory, can they just run several
> requests in parallel? Or one by one?
>
> Thanks!
