Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6158008A
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfHBS4n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 14:56:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34702 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfHBS4n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Aug 2019 14:56:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so55599247qkt.1;
        Fri, 02 Aug 2019 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNGLxw2KweTcYpa9QkuGXi/8Vq8kU4lq6/m0y6hK/fE=;
        b=fogrInpcFGgIcmhYnky/AvbQZYcNngP+1NA9vPDvAgWGannmX09ril8r2t0m6Nwbft
         K5MBntXA2r9jHfX8pjMZi3i26BE93k7hIQrNguBwsdAymi9vBbJcyBqo/sx/2u1X/ocF
         lGHvHeCQB8ECPOIva3qKiFKVT8eTETQ8UKgkvKZgE2LgyA/Rb76xad1uMMFrxzKBevNz
         aE0q89Sx/MZ7Lls1mTv/sIlA6uhCbD5eQd5IONPxNJzTnO78Jc4wJ11ejOlDCtCj4Jum
         OHArxueuGJ7QZ8uKaxVGAW4487eIjLOS6nbsK7utF1UXM2Q3w3YWfP9h37W3pSnlydZh
         FJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNGLxw2KweTcYpa9QkuGXi/8Vq8kU4lq6/m0y6hK/fE=;
        b=T+Z/voVBtORA10Wy8DXZsjUKAdPFzmoG/nwIgY9/H9SfEKs/X1RKxB+TSlG6StvSMN
         sy5lFanfeL/qmxhm7mPH5rv4Cp+ws3Cut+/WL5W46VU0iIZXfPxYgEJSi2u3ccqF0rcq
         GoOOwr90tzVUwqDvCGmKYEqhm8nj42eRWKYXor1nl99dop75/+d5S3Vc6T8qUMv0JDrF
         p1q/dwA0mblUN26mngqCbyeqBosVymIn6uFs7LuLecvFjjo0tmoFuGi/hfvu6p6RXr9/
         UegeznW2q5T7MZ56PLZhtNothbu5GLadv9RFFvdqKmgDuQAnqxCdzDlYGOP20YBgZMFx
         MTMg==
X-Gm-Message-State: APjAAAVG8C5aIBSmpiHXciwD6AUAmy03DdHw/FQ095o1h7b55crPEwv/
        LPUsEKBhHD3l/NpW+3uXoBwGmkslwG4zkUexfUM=
X-Google-Smtp-Source: APXvYqzYxCbc7dr941jU8as06MAJUPnoVZotdMadT7POHu58kTI4st9fGq6gaB6kR9fcMe5wuEPbkeh6/gNB7Q+65cM=
X-Received: by 2002:a37:7643:: with SMTP id r64mr89399970qkc.467.1564772202629;
 Fri, 02 Aug 2019 11:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz> <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz> <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
 <20190729184850.GH9330@dhcp22.suse.cz> <CAHbLzkp9xFV2sE0TdKfWNRVcAwaYNKwDugRiBBoEKx6A_Hr3Jw@mail.gmail.com>
 <20190802093507.GF6461@dhcp22.suse.cz>
In-Reply-To: <20190802093507.GF6461@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 2 Aug 2019 11:56:28 -0700
Message-ID: <CAHbLzkrjh7KEvdfXackaVy8oW5CU=UaBucERffxcUorgq1vdoA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 2, 2019 at 2:35 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 01-08-19 14:00:51, Yang Shi wrote:
> > On Mon, Jul 29, 2019 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 29-07-19 10:28:43, Yang Shi wrote:
> > > [...]
> > > > I don't worry too much about scale since the scale issue is not unique
> > > > to background reclaim, direct reclaim may run into the same problem.
> > >
> > > Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
> > > You can have thousands of memcgs and I do not think we really do want
> > > to create one kswapd for each. Once we have a kswapd thread pool then we
> > > get into a tricky land where a determinism/fairness would be non trivial
> > > to achieve. Direct reclaim, on the other hand is bound by the workload
> > > itself.
> >
> > Yes, I agree thread pool would introduce more latency than dedicated
> > kswapd thread. But, it looks not that bad in our test. When memory
> > allocation is fast, even though dedicated kswapd thread can't catch
> > up. So, such background reclaim is best effort, not guaranteed.
> >
> > I don't quite get what you mean about fairness. Do you mean they may
> > spend excessive cpu time then cause other processes starvation? I
> > think this could be mitigated by properly organizing and setting
> > groups. But, I agree this is tricky.
>
> No, I meant that the cost of reclaiming a unit of charges (e.g.
> SWAP_CLUSTER_MAX) is not constant and depends on the state of the memory
> on LRUs. Therefore any thread pool mechanism would lead to unfair
> reclaim and non-deterministic behavior.

Yes, the cost depends on the state of pages, but I still don't quite
understand what does "unfair" refer to in this context. Do you mean
some cgroups may reclaim much more than others? Or the work may take
too long so it can't not serve other cgroups in time?

>
> I can imagine a middle ground where the background reclaim would have to
> be an opt-in feature and a dedicated kernel thread would be assigned to
> the particular memcg (hierarchy).

Yes, it is opt-in by defining a proper "water mark". As long as "water
mark" is defined (0, 100), the "kswapd" work would be queued once the
usage is greater than "water mark", then it would exit once the usage
is under "water mark". If "water mark" is 0, it will never queue any
background reclaim work.

We did use dedicated kernel thread for each cgroup, but it turns out
it is also tricky and error prone to manage the kernel thread,
workqueue sounds much more simple and less error prone.

> --
> Michal Hocko
> SUSE Labs
