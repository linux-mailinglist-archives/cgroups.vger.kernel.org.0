Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C458552CB90
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 07:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiESFo2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 01:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiESFo1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 01:44:27 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A6BA56D
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 22:44:25 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id z6so4221478vsp.0
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4G1Aen0GHFS3EKGVhT8LtVmXwzlfEt6YIPzeajfpco=;
        b=TfM1sIv3epxOyr8vwn+yKNq7eWm1RYkvIpe1hkD0nYYUQ+1T+dA+nbMVF8dqXxdrgQ
         TKPEQcTC8xhl53O8M3et5WJGZPkPxvjvoqr1mz7BoNZce0hiT+OGC0ngAlln2r9xhnTS
         GDmtbaO8mTUnP9ryTbINm3tQDwTCs6CVMSAq1GvHN7a1TF4tHPcHrocdZNCWwrWPbuFP
         GCxcy0l2u7baeGrVwssKb7hVHgPo+ZoOKOhlNl1s5bfBe85draRvX/VccgY6tZ+oRbtg
         AopXnH0gUfAgYqTlU2YXPLOrQrLhgwFJvbYppSUuD6oLh7JPRpE88qP16/Skgn5ehoIz
         otoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4G1Aen0GHFS3EKGVhT8LtVmXwzlfEt6YIPzeajfpco=;
        b=kGwhClreDEzUGqWa08SGvzxIYrUhsflPlh0g6afWhf5uyTvhSI3jfWL40kV8YoVU5O
         sBbzK3X0CXlydRrrZ/NFBDQVPPCTB6PJikPnTPd1lsnnZ90Ld2mUdFbTzpCj0O6JE+8m
         L4/1tTZbPXJorpDkR72HHqJx/g+xnEDppVFQisboDhLIALdVDbUML3eqh7TTgCCDxEV+
         t2lwXxzGyQPc/UVsDMEmZ7PMyQYxgSiaVgNdF/7G+IVRkGZ2Rcr1qJqndCS7KsS/4Roh
         DlOw8P1XNqelO9OmQ6qMaHfg0To6xNI5rPqm8leoSVfaz/eWILcWYiuAWd2yCt43NWGI
         aaPQ==
X-Gm-Message-State: AOAM531FnuuU2u9bXAsUAAUwS5hfbAMbAg1nqp+cv/NvCTFdn+TB9EoL
        cSxjAn1LEy9204gZuKzh/OZljK7zZUixp66M2TWOqSvbEUTxCA==
X-Google-Smtp-Source: ABdhPJzjIGWE3RgBWy45zYJ4UQGjCyFZ1KeXAe2ceseEhoL8NHTVa9I7lO8SRL1YtRIiZpI7krjK4Y0TehwD5YvQRnQ=
X-Received: by 2002:a05:6102:3ecf:b0:320:7c27:5539 with SMTP id
 n15-20020a0561023ecf00b003207c275539mr1509687vsv.59.1652939064462; Wed, 18
 May 2022 22:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz> <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
 <YoQAVeGj19YpSMDb@cmpxchg.org>
In-Reply-To: <YoQAVeGj19YpSMDb@cmpxchg.org>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 18 May 2022 22:44:13 -0700
Message-ID: <CAAPL-u8pZ_p+SQZnr=8UV37yiQpWRZny7g9p6YES0wa+g_kMJw@mail.gmail.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
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

On Tue, May 17, 2022 at 1:06 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hi Yosry,
>
> On Tue, May 17, 2022 at 11:06:36AM -0700, Yosry Ahmed wrote:
> > On Mon, May 16, 2022 at 11:56 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 16-05-22 15:29:42, Yosry Ahmed wrote:
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
> > >
> > > Can you be more specific about the usecase please? Also how do you
> >
> > For example for a class of applications it may be known that
> > reclaiming one type of pages anon/file is more profitable or will
> > incur an overhead, based on userspace knowledge of the nature of the
> > app.
>
> I want to make sure I understand what you're trying to correct for
> with this bias. Could you expand some on what you mean by profitable?
>
> The way the kernel thinks today is that importance of any given page
> is its access frequency times the cost of paging it. swappiness exists
> to recognize differences in the second part: the cost involved in
> swapping a page vs the cost of a file cache miss.
>
> For example, page A is accessed 10 times more frequently than B, but B
> is 10 times more expensive to refault/swapin. Combining that, they
> should be roughly equal reclaim candidates.
>
> This is the same with the seek parameter of slab shrinkers: some
> objects are more expensive to recreate than others. Once corrected for
> that, presence of reference bits can be interpreted on an even level.
>
> While access frequency is clearly a workload property, the cost of
> refaulting is conventionally not - let alone a per-reclaim property!
>
> If I understand you correctly, you're saying that the backing type of
> a piece of memory can say something about the importance of the data
> within. Something that goes beyond the work of recreating it.
>
> Is that true or am I misreading this?
>
> If that's your claim, isn't that, if it happens, mostly incidental?
>
> For example, in our fleet we used to copy executable text into
> anonymous memory to get THP backing. With file THP support in the
> kernel, the text is back in cache. The importance of the memory
> *contents* stayed the same. The backing storage changed, but beyond
> that the anon/file distinction doesn't mean anything.
>
> Another example. Probably one of the most common workload structures
> is text, heap, logging/startup/error handling: hot file, warm anon,
> cold file. How does prioritizing either file or anon apply to this?
>
> Maybe I'm misunderstanding and this IS about per-workload backing
> types? Maybe the per-cgroup swapfiles that you guys are using?
>
> > If most of what an app use for example is anon/tmpfs then it might
> > be better to explicitly ask the kernel to reclaim anon, and to avoid
> > reclaiming file pages in order not to hurt the file cache
> > performance.
>
> Hm.
>
> Reclaim ages those pools based on their size, so a dominant anon set
> should receive more pressure than a small file set. I can see two
> options why this doesn't produce the desired results:
>
> 1) Reclaim is broken and doesn't allocate scan rates right, or
>
> 2) Access frequency x refault cost alone is not a satisfactory
>    predictor for the value of any given page.
>
> Can you see another?
>
> I can sort of see the argument for 2), because it can be workload
> dependent: a 50ms refault in a single-threaded part of the program is
> likely more disruptive than the same refault in an asynchronous worker
> thread. This is a factor we're not really taking into account today.
>
> But I don't think an anon/file bias will capture this coefficient?

It essentially provides the userspace proactive reclaimer an ability
to define its own reclaim policy by adding an argument to specify
which type of pages to reclaim via memory.reclaim.

Even though the page type (file vs anon) doesn't always accurately
reflect the performance impact of a page, the separation of different
types of pages is still meaningful w.r.t reclaim.

The reclaim costs of anon and file pages are different. With zswap,
anon pages can be reclaimed via memory compression, which doesn't
involve I/Os, but reclaiming dirty file pages needs I/O for writeback.

The access patterns of anon and file pages are also different: Anon
pages are mostly mapped and accessed directly by CPU, whereas file
pages are often accessed via read/write syscalls. A single accessed
(young) bit can carry very different performance weights for different
types of pages.

Because anon/tmpfs pages account for the vast majority of memory usage
in Google data centers and our proactive reclaim algorithm is tuned
only for anon pages, we'd like to have the option to only proactively
reclaim anon pages.

It is not desirable to set the global vm.swappiness to disable file
page reclaim because we still want to use the kernel reclaimer to
reclaim file pages when proactive reclaimer fails to keep up with the
memory demand.
