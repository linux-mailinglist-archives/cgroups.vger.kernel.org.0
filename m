Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86374A4DAC
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 19:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiAaSAi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 13:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiAaSAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 13:00:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89457C06173D
        for <cgroups@vger.kernel.org>; Mon, 31 Jan 2022 10:00:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f10so2039568lfu.8
        for <cgroups@vger.kernel.org>; Mon, 31 Jan 2022 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDAib+Bb/dH824cDSeLWITIJZuwoFHO7+dlyhfyg7SU=;
        b=bnGr1AtWDiuxZ4vCWPPtTrf0rCqdtKwtwCLDhRqdlmk/VByNX7ZDiYGlLu9UpojJuk
         cmrsI6WYoRXCN5xMdZW/vwApSpcBGKGj/vyMWBkkg8/4ABU8qzFO8Z8Ytq+nyV8L5rAx
         bPz29zv8jlQQT4kwtfAsG28PDsrgq0akpP0/bJ47B8d+kCcbZMc6nvW/gDsEiDHlBPgR
         SpXeezyCMttodSaARcOLP4wnQZLtSA0c5gtAiq+gH1S+CkUz36zRT2ZhKOvy5O1UMhsg
         eyVEFe4mMhm1ogImTdcQh+c2UYLHF0DdNC/kApoDZHqKhHscWYijtUUJ2JjSYLbGGpMK
         p37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDAib+Bb/dH824cDSeLWITIJZuwoFHO7+dlyhfyg7SU=;
        b=dd/q5LBcB3kpW6l8QQHhaTwPeMQWuwbx1nmzIBqNkA4tmUEa5t7+FBS/tjtb/DwtRV
         DdjXwWCa1Eisr+rZIrZpXgxYha0W9vj6Qu6oGc5STFxojP5NAKZE6oQvhUhBR/FuUVfQ
         yOdlGjq2T+hFdOW3bHpd8QYE09Vity6/amNdpnkeZZtdHrHeq7O5zJuxHknUEaNw1WhF
         ejNL/HDPDIvZjFBtuOwq3JjS43QvDgJYs2zS3w9d12eLA7CWzteDWIXfA/aNHIUukTwi
         ABUIpQuF1YhviWFceXgk1pGeXC1A5ixhpRSNvhyOjKX/Ju620EwKz2Qq0hOr4c4jnwCD
         iSEQ==
X-Gm-Message-State: AOAM533MNHpIEhaw2xlnS/6qp7nSbJPvDS0RYkZuCkwL1ZD7F7GF4Jej
        XBolAPXxHnlaGYxwBKswAzum2yyQrfLytYSBpkWetA==
X-Google-Smtp-Source: ABdhPJxQznG399o4FeIp4grPFm8gWblqBKSsK5BWSTEtUQHPIYYYdo+jP7kOqfui2OPLfGhyyZPibpA0rS68i8bZLzs=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr1911241lfv.184.1643652035654;
 Mon, 31 Jan 2022 10:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20211001190938.14050-1-longman@redhat.com> <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com> <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
 <YfgV2iiaVlR0hozD@carbon.dhcp.thefacebook.com> <95ba1931-e9c9-45c3-b080-d28f2ad368a7@redhat.com>
 <c950a93d-bb70-9a97-dabe-a1d58d755dad@redhat.com> <YfgaIcSJhqEOnh65@carbon.dhcp.thefacebook.com>
 <9abc9cb8-8734-90b0-c495-8df89c7bb579@redhat.com>
In-Reply-To: <9abc9cb8-8734-90b0-c495-8df89c7bb579@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 Jan 2022 10:00:24 -0800
Message-ID: <CALvZod6_L1Q1xnjx26cgNgXHhpH=Mvdkk98f2=AAo=euwYY62Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
To:     Waiman Long <longman@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 9:25 AM Waiman Long <longman@redhat.com> wrote:
>
> On 1/31/22 12:19, Roman Gushchin wrote:
> > On Mon, Jan 31, 2022 at 12:15:19PM -0500, Waiman Long wrote:
> >> On 1/31/22 12:09, Waiman Long wrote:
> >>> On 1/31/22 12:01, Roman Gushchin wrote:
> >>>> On Sun, Jan 30, 2022 at 10:55:56PM -0500, Waiman Long wrote:
> >>>>> On 10/1/21 19:51, Roman Gushchin wrote:
> >>>>>> On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
> >>>>>>> When freeing a page associated with an offlined memcg, refill_stock()
> >>>>>>> will put it into local stock delaying its demise until another memcg
> >>>>>>> comes in to take its place in the stock. To avoid that, we now check
> >>>>>>> for offlined memcg and go directly in this case to the slowpath for
> >>>>>>> the uncharge via the repurposed cancel_charge() function.
> >>>>>> Hi Waiman!
> >>>>>>
> >>>>>> I'm afraid it can make a cleanup of a dying cgroup slower: for every
> >>>>>> released page we'll potentially traverse the whole cgroup tree and
> >>>>>> decrease atomic page counters.
> >>>>>>
> >>>>>> I'm not sure I understand the benefits we get from this change which
> >>>>>> do justify the slowdown on the cleanup path.
> >>>>>>
> >>>>>> Thanks!
> >>>>> I was notified of a lockdep splat that this patch may help to prevent.
> >>>> Would you mind to test this patch:
> >>>> https://www.spinics.net/lists/cgroups/msg31244.html  ?
> >>>>
> >>>> It should address this dependency.
> >>> Thanks for the pointer. I believe that your patch should be able to
> >>> address this circular locking dependency.
> >>>
> >>> Feel free to add my
> >>>
> >>> Reviewed-by: Waiman Long <longman@redhat.com>
> >> BTW, have you posted it to lkml? If not, would you mind doing so?
> > Not yet.
> >
> > I was waiting for Alexander to confirm that it resolves the originally reported
> > issue. I just pinged him, will wait for tomorrow and post the patch in any case.
> >
> > Thanks!
>
> I see. This is not a problem that is easily reproducible. You need to
> hit the right timing for the lockdep splat to appear.

I agree here. The patch on its own has merits as it is reducing
dependency on an unrelated lock.
