Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72951C60D
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382284AbiEERbW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349228AbiEERbV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 13:31:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEED59940
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 10:27:41 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z18so5487859iob.5
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsF+kn83mNqrMxbS9TzRocPMWDU65sPUevlcCkR0pr0=;
        b=QOOvGNSB2CcE2vA0mwKhSu3u77etXDnR3iIJvPwzvnl7ScQ+6VWb3TFM6EwGqlAPO0
         cYcV3gTjSab/nDBsg6safyBYjUDkSiH3Irz6oBZD1t0InszqFZtGfHilSGaW3cZHgljR
         1r7dIUPtTqBHfMPU2NhUZqkF22aV2GqjWTGAHW1+Gho1zOL6kr0J3SsYM84bfncvJi1I
         LVlc+VJCUdj9gDHyBNAE9zndwCzC58ikYSrPP/Rqv+uj84lCKpTA5qQ/PG2ogq9t53+q
         3faNtN41LW3s0tLWPEE65+itf70mt6NG2HRuqpv79OfYVXRJXuX+3NrWNtvix1xkWpL0
         kEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsF+kn83mNqrMxbS9TzRocPMWDU65sPUevlcCkR0pr0=;
        b=G+OY7sD1wwtVh8owASbOMhZGjNjmOiUnBrlhUSTkJ4mtU+z+dbF8EJ+l5Xm9CR5W0C
         ZsAScERaAb1l0p3CZ/d6HGdSEtnGhhi+QbC2jRtEn/HaGXvczLtZ4IN3Co2Rw/w6mrCQ
         L2UKSphWaoE9BGegIeTrae7Z2MXDjGA2sNz5o4aGNrjuI1hjPEoXdqt5RQnhShu2iAM5
         xg1wrRjl7TPTPx2HyLMAgoO/4mvcsMZ5gOFphdztSEsUEibAv9+9bNzEVtUYIhRpMMuj
         523cVBs9xh1Sf6CqZW/NU+84CUG19zHgy82wwGMihVX90cMbRnwYL4Ifyz2lZ+NeXB+L
         cibw==
X-Gm-Message-State: AOAM530pIrp1iVDkdsbZDDtp6k77kEia8YwLtPD3QBx75VYpE8bBwq95
        QUwKFwcs975Uo6QE9Zb7e/l1e+5orhTGkk+YRwqEaQ==
X-Google-Smtp-Source: ABdhPJzTAV0Z/nQEEkMh9yiYW4RKcUHjVc9JaDjRr0t/up16kvUiiHUDz4jUmyXpxongaok395P+ZuBbQuR1Yc+ruJU=
X-Received: by 2002:a6b:f411:0:b0:657:b73f:8e97 with SMTP id
 i17-20020a6bf411000000b00657b73f8e97mr11117665iog.68.1651771661067; Thu, 05
 May 2022 10:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com> <CALvZod5xiSuJaDjGb+NM18puejwhnPWweSj+N=0RGQrjpjfxbw@mail.gmail.com>
In-Reply-To: <CALvZod5xiSuJaDjGb+NM18puejwhnPWweSj+N=0RGQrjpjfxbw@mail.gmail.com>
From:   Ganesan Rajagopal <rganesan@arista.com>
Date:   Thu, 5 May 2022 22:57:03 +0530
Message-ID: <CAPD3tpG1BeTOwTBxkXCxoJagvbn6n1aAEkt0P65g91N9gtK03w@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 5, 2022 at 9:42 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, May 5, 2022 at 5:13 AM Ganesan Rajagopal <rganesan@arista.com> wrote:
> >
> > v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
>
> *max_usage_in_bytes

Oops, thanks for the correction.

> > sysfs. This is missing for v2 memcg though "memory.current" is exported.
> > There is no other easy way of getting this information in Linux.
> > getrsuage() returns ru_maxrss but that's the max RSS of a single process
> > instead of the aggregated max RSS of all the processes. Hence, expose
> > memcg->watermark as "memory.watermark" for v2 memcg.
> >
> > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
>
> Can you please explain the use-case for which you need this metric?
> Also note that this is not really an aggregated RSS of all the
> processes in the cgroup. So, do you want max RSS or max charge and for
> what use-case?

We run a lot of automated tests when building our software and used to
run into OOM scenarios when the tests run unbounded. We use this metric
to heuristically limit how many tests can run in parallel using per test
historical data.

I understand this isn't really aggregated RSS, max charge works. We just
need some metric to account for the peak memory usage.  We don't need
it to be super accurate because there's significant variance between test
runs anyway. We conservatively use the historical max to limit parallelism.

Since this metric is not exposed in v2 memcg, the only alternative is to
poll "memory.current" which would be quite inefficient and grossly
inaccurate.

Ganesan
