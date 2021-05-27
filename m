Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D93392C24
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhE0KvK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbhE0KvJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 06:51:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1399C061574
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 03:49:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w15so155679ljo.10
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ua/saZqvwIMzSQnurwAoIde+A9NKg6vplyBhL5Gjil4=;
        b=n3Ys6kd7oq4RSx9GNj8DAA5OwUiXPsXOyHkKi4ZRtB5UzEfN9jKd8g9uQ+py8Fchnu
         fI7VGGVjbWZy5DS5ow4F8bDjLto8EruGhYNLiocK0BczIXSdROGiHePAUQv0qODETxxA
         G2p21I16bmk3PmwbTJlbd/AbqrRwZohgPCkEIBMmzq0nbqqaJZmGrFqx9q4Y7ktsaM2S
         /+UL/lN3Lu1j+/wVUJjJqf6gvjEkcxY26sZWu4IU5uWRbI3wyXkK9tzIx5CrU51KmbSw
         EujG94Xm2TUwhicxy48R02bwtQQMzRXMSSY8dTBGEXDxAKL7en4rsM+CtVzkyhO+qq9V
         ASyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ua/saZqvwIMzSQnurwAoIde+A9NKg6vplyBhL5Gjil4=;
        b=STACmvZXWCdxWz7YRlpkvYsNZBd3Jq95yQLKARUBbIwScn6BaAvAdCzFlnSlsT/tXJ
         sRDbVi/JLdiKJCII8iOEDuC9xerN1Z8s0uig1+olBNpv0c1zXocsuZYXC9/Cx8+Osk3z
         +aCa/mkJ3iF8y/ThzYHM17EYS3H0aOpFxoUrbFCjrMqpV3rL1wsS8VEboVwes1JuWQjE
         NmKrp0p66pYmgR///H/pDzaYWkRqVhWbClHtl6KSvhMoAUJQlUojoKDX+LLUkDH9Ae7W
         S20Uhcv0xPOqdcJzXD9T2V8ifNjlTMQlm0xj/Bnv3CrMQCDjgN+V3S2H2MQ9oVFJ70Rm
         BLVw==
X-Gm-Message-State: AOAM532Ugc6L91a3hSFrF9OKNVI5lBlzVhPtvP7ILmobri0k5b7x/paw
        daPMjSfWzxnDRBea19reVjy9oB/dEEnAbWg5vP6mbFdyMUJm6A==
X-Google-Smtp-Source: ABdhPJw5PrpS6wRAqAuy1LwBF+ZprULcob3L33drJjObvMSeJtf2Aj5MH+3//EqJ+/kgp6sn/feEUp2dJDEZSsa2X6g=
X-Received: by 2002:a2e:8557:: with SMTP id u23mr2055801ljj.221.1622112574244;
 Thu, 27 May 2021 03:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com> <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
In-Reply-To: <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 12:49:22 +0200
Message-ID: <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 27 May 2021 at 11:46, Odin Ugedal <odin@uged.al> wrote:
>
> Hi,
>
> > I finally got it this morning with your script and I confirm that the
> > problem of load_sum == 0 but load_avg != 0 comes from
> > update_tg_cfs_load(). Then, it seems that we don't call
> > update_tg_load_avg for this cfs_rq in __update_blocked_fair() because
> > of a recent update while propagating child's load changes. At the end
> > we remove the cfs_rq from the list without updating its contribution.
> >
> > I'm going to prepare a patch to fix this
>
> Yeah, that is another way to look at it. Have not verified, but
> wouldn't update_tg_load_avg() in this case
> just remove the diff (load_avg - tg_load_avg_contrib)? Wouldn't we
> still see some tg_load_avg_contrib
> after the cfs_rq is removed from the list then? Eg. in my example
> above, the cfs_rq will be removed from
> the list while tg_load_avg_contrib=2, or am I missing something? That
> was my thought when I looked
> at it last week at least..

1st : ensure that cfs_rq->load_sum is not null if cfs_rq-> load_isn't too
2nd : call update_tg_load_avg() during child update so we will be sure
to update tg_load_avg_contrib before removing the cfs from the list

>
> Thanks
> Odin
