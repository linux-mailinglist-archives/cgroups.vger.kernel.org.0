Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309235A401
	for <lists+cgroups@lfdr.de>; Fri,  9 Apr 2021 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDIQvO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIQvM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Apr 2021 12:51:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E660C061760
        for <cgroups@vger.kernel.org>; Fri,  9 Apr 2021 09:50:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c6so7229970lji.8
        for <cgroups@vger.kernel.org>; Fri, 09 Apr 2021 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydAqvEvjbti1VLEzYDXfmB0v6HN/16FzgGH3F04ZLl4=;
        b=Ku8jowge8CGqLIX9rDeK1rUNeZs0BpzWI63PkuG58eTTRQjw9OWcAEd7foQc41esT1
         JmyKp9pirl+Zn2IN0o/8JQaF0/tJlnNFI88SSyoSlWXIeEeuHfIW/MrnDdwLPEronJD0
         SiNv9+FJ7Wb+3LtSufgntha5moXUanEotTltXSGODoLwX3MQUpaUFi+vLFQbD04H6oct
         vpsXFbiLU+IIC9KJh2Aa4hKSrd7BtPWtUg7ai9uBPrZHnNzNGsLIuggMW89tMxsPiJZK
         d/sWm0boTnhGVnPr8mLz+E6rm0gjgU+TBIDSly3YMB/BxZ/x6KQ316ZzzhPdCo6Rp2AB
         nTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydAqvEvjbti1VLEzYDXfmB0v6HN/16FzgGH3F04ZLl4=;
        b=kPMUlENoFDMIfHolQ5YK2nRjz4w6rPsnleBRilypja2Ci/CEFGCbeF1p9wz/0TK+LA
         285HvCZYaLK78GqzQCqJWh9AihW/Gyc8D0OtwsH1qFdBHGMAzstT2X3j8I58rVgsP2WV
         ijsZ2wB9IA/En+zPGwNLsv0n9Wa4fMxfIBPuKsrzLoJq8GoKeejCJ60vP/WUeKnx8ddc
         fkHgfaf1sd+FQMu26zznuoqPu3kwo2JNim4kuQbUsmCIFWKrQBEv/gOavUr7VORQ4wQg
         JuSUuL1P8FMxNHl6aFi8Hd2vGSeBTiLiPh5pr6HQyqJM+XR+6j5gqmiCjoasx+gJAwaL
         EBvQ==
X-Gm-Message-State: AOAM533PlQExCEiAoHUkE8B905T/MhrQ98TU0K+SeLXmLV38lRD1FsL8
        lfoI87rTuw7huk6rYLK1ypweK8skgNdP9VGrrywDXA==
X-Google-Smtp-Source: ABdhPJyBfdf/8smxuHjTBAQM9sdY8EuczVM5ysrH0hk9aqsMeTqWmqxKoh0LSG7TbQswqSDxNDdfWNq71furGKOVrTo=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr10144683ljc.0.1617987057899;
 Fri, 09 Apr 2021 09:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210408193948.vfktg3azh2wrt56t@gabell> <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
 <CALvZod58NBQLvk2m7Mb=_0oGCApcNeisxVuE1b+qh1OKDSy0Ag@mail.gmail.com> <20210409163539.5374pde3u6gkbg4a@gabell>
In-Reply-To: <20210409163539.5374pde3u6gkbg4a@gabell>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Apr 2021 09:50:45 -0700
Message-ID: <CALvZod4uRU==p7Z0eP_xO49iA3ShFDHKzyWZbd7RdMso5PHsfA@mail.gmail.com>
Subject: Re: memcg: performance degradation since v5.9
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 9, 2021 at 9:35 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
[...]
> > Can you please explain how to read these numbers? Or at least put a %
> > regression.
>
> Let me summarize them here.
> The total duration ('total' column above) of each system call is as follows
> if v5.8 is assumed as 100%:
>
> - sendto:
>   - v5.8         100%
>   - v5.9         128%
>   - v5.12-rc6    116%
>
> - revfrom:
>   - v5.8         100%
>   - v5.9         114%
>   - v5.12-rc6    108%
>

Thanks, that is helpful. Most probably the improvement of 5.12 from
5.9 is due to 3de7d4f25a7438f ("mm: memcg/slab: optimize objcg stock
draining").

[...]
> >
> > One idea would be to increase MEMCG_CHARGE_BATCH.
>
> Thank you for the idea! It's hard-corded as 32 now, so I'm wondering it may be
> a good idea to make MEMCG_CHARGE_BATCH tunable from a kernel parameter or something.
>

Can you rerun the benchmark with MEMCG_CHARGE_BATCH equal 64UL?

I think with memcg stats moving to rstat, the stat accuracy is not an
issue if we increase MEMCG_CHARGE_BATCH to 64UL. Not sure if we want
this to be tuneable but most probably we do want this to be sync'ed
with SWAP_CLUSTER_MAX.
