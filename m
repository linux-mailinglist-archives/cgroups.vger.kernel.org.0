Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E94B19D4
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbiBJXxQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 18:53:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345935AbiBJXxP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 18:53:15 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58055F7A
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 15:53:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu29so8152160lfb.0
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYlkrxPZ2Z2zJ0ERqrS7qUlWPElIVoGvIlqioJZlkEg=;
        b=N7sJdoUSvYyq4MjeAPZ+AFQb0pTRwxjWTrsPhX0XMSt6+2JQTgiCBZcetXZs1nn0iF
         4Mnb+PdRGBlJgMhfrAdhn5bYjANfKDHCNuCeLZDHMFckT6QMOsgNCIMfFzeekLGylJ5P
         wNUQvGaZVE164HcLoLdHVIv4PMt/RYLPqLzyYPWKs2LWg0XHv4Cng2Bg0iIqBVVl9dhC
         PuoIWkNoA7GZVZcRSnk/dg6fjwvxyIJ1DSLaTAgIgroZT3KUMkI62C/BmXmLWdbltMZD
         FtofcFN19iXXP4W5nA4N2/9YVNIv3zJSO3wYrw2lnv6lXYCFZED9GP4KMjf5FAU7UHK2
         JrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYlkrxPZ2Z2zJ0ERqrS7qUlWPElIVoGvIlqioJZlkEg=;
        b=tXuutet2WxtC2u9qUHRkMVxoNzJXy4J4xUW01Gc43PVY4arwhg5tK+d2b6DhVvXZxo
         +os1XFlYp0mlivqMyZ7wMHfWMp+IfKdybfsfVKNf9E3CCT2AhEse+l1rA+4SP87mQO7W
         sl75ZsPOL6NEOndFGbA2iCIZoWzq7gJ7h6YWANHenh3pfro1RdcXOm4Wg9LYi2O3sYWy
         j64/FN0BvWK/SarpnXhSRmldPCJvMUM/pFjVbh2q2i1iidCve8tP9f6K5e0Hn9MDz4Gj
         qcCsAxDNaD7uA5yTJ5NLKbdQDo07AvrKJD1F3tDyZJO2DhLaLDiz5Nq4VUjn3kIWtRKh
         yMPg==
X-Gm-Message-State: AOAM53348Dr5nHBnAlShh9i0CAk0Xd7dFdnddC4UoAZkkFan7AV9UuK1
        peA4EakIosGyCHJxwCMp2UJBGEvjhi8m1yRmfXXpYg9L0E2Xxw==
X-Google-Smtp-Source: ABdhPJzlQ7C2povlgj2WhXWBIUQvgOe7nN/U/YEt/xipMo3xl/7n7Z7MXLZqPTYBMl70EN25TbWtI04N4CiekUZ7TOQ=
X-Received: by 2002:a19:9144:: with SMTP id y4mr6846910lfj.494.1644537192004;
 Thu, 10 Feb 2022 15:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com> <20220210081437.1884008-5-shakeelb@google.com>
 <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com> <CALvZod5xFmCVV_AZO1be8pYakmDvYh-QXmNYtTNT4zvCw-m4bQ@mail.gmail.com>
 <YgWf0wL5RoSpNrWn@carbon.dhcp.thefacebook.com>
In-Reply-To: <YgWf0wL5RoSpNrWn@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Feb 2022 15:53:00 -0800
Message-ID: <CALvZod5XstvNB_=qprW6_bx33h8JeyE5TjvX3UDoqG8XHBr14w@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg: synchronously enforce memory.high
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 3:29 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Feb 10, 2022 at 02:22:36PM -0800, Shakeel Butt wrote:
> > On Thu, Feb 10, 2022 at 12:15 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > [...]
> > >
> > > Has this approach been extensively tested in the production?
> > >
> > > Injecting sleeps at return-to-userspace moment is safe in terms of priority
> > > inversions: a slowed down task will unlikely affect the rest of the system.
> > >
> > > It way less predictable for a random allocation in the kernel mode, what if
> > > the task is already holding a system-wide resource?
> > >
> > > Someone might argue that it's not better than a system-wide memory shortage
> > > and the same allocation might go into a direct reclaim anyway, but with
> > > the way how memory.high is used it will happen way more often.
> > >
> >
> > Thanks for the review.
> >
> > This patchset is tested in the test environment for now and I do plan
> > to test this in production but that is a slow process and will take
> > some time.
> >
> > Let me answer the main concern you have raised i.e. the safety of
> > throttling a task synchronously in the charge code path. Please note
> > that synchronous memory reclaim and oom-killing can already cause the
> > priority inversion issues you have mentioned. The way we usually
> > tackle such issues are through userspace controllers. For example oomd
> > is the userspace solution for catering such issues related to
> > oom-killing. Here we have a similar userspace daemon monitoring the
> > workload and deciding if it should let the workload grow or kill it.
> >
> > Now should we keep the current high limit enforcement implementation
> > and let it be ineffective for some real workloads or should we make
> > the enforcement more robust and let the userspace tackle some corner
> > case priority inversion issues. I think we should follow the second
> > option as we already have precedence of doing the same for reclaim and
> > oom-killing.
>
> Well, in a theory it sounds good and I have no intention to oppose the
> idea. However in practice we might easily get quite serious problems.
> So I think we should be extra careful here. In the end we don't want to
> pull and then revert this patch.
>
> The difference between the system-wide direct reclaim and this case is that
> usually kswapd is doing a good job of refilling the empty buffer, so we don't
> usually work in the circumstances of the global memory shortage. And when we do,
> often it's not working out quite well, this is why oomd and other similar
> solutions are required.
>.
> Another option is to use your approach only for special cases (e.g. huge
> allocations) and keep the existing approach for most other allocations.
>

These are not necessarily huge allocations and can be a large number
of small allocations. However I think we can make this idea work by
checking current->memcg_nr_pages_over_high. If
order(current->memcg_nr_pages_over_high) is, let's say, larger than
PAGE_ALLOC_COSTLY_ORDER, then throttle synchronously. WDYT?
