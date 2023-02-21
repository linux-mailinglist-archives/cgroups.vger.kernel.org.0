Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0351169E56D
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjBURCY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjBURCE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:02:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F6422B;
        Tue, 21 Feb 2023 09:01:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so5449990pjb.2;
        Tue, 21 Feb 2023 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC+l61qoknT1eRg99Cptt6lYzgJ7/E5pHZ5cZZg+HEA=;
        b=E3v/fWrkgoLvZ5IU6Z/wsyMkwmei+5ld4ItC04k3iIZ/mrR1aWYZlDsmoHnjBrrxBj
         dBYd+W2meo9XHLZHLYVjzfYEUj5KdyEJf6JrkN4kN63PSxA+AnLFe7DmjpSg1XKxDTTB
         jEwWgDK73jGLbxzC1UmyWwop6BZZaO6vd+9lPJ51CBQ4sykllhsRambNSkSek8QvjM2A
         Y2aavvHy04zSorbnx18YIDRUYQTTfWjsEwjxN0yO/l5RGOtoA4ubiRO/63oottneqqxR
         IZHNhaQSILIxj/MdRF3MSaXJF5L0v+FFpiqXgVF8O7KStGWfantC/txGgB21EhbI7xMY
         bq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC+l61qoknT1eRg99Cptt6lYzgJ7/E5pHZ5cZZg+HEA=;
        b=4EjAx0n9fAH49tcNY4j9MZuxyVAT8/iznWEEArisZagavPWL9lLxYwb0bY8/E9hSr8
         QbkxxtHAI7N8+sXs8o6fXbXytKS30QjVQXAoG/Cf3KZGjAOQsaL8sLMqXOQLo9demGzM
         NjLMxHvW+Ux2pU8IC4Qr8wWMBU17ADwE+pFHT51gV3upBP4zqENebW0OLO4Rfi/rKUjg
         4dftkexD2zH8n75cMH844Gwsk4vs576ITvYUsi00fzqDwNZtaz0CeE9Rxr+ybdftUvEB
         FeSisUaT80Q1vkyc5MOgaATFbKVXiYgG6gkBVUf7ubOALYBybSHI1TPxTjNsdNSWdUx9
         wbFQ==
X-Gm-Message-State: AO0yUKW0duuNcAZoV1Cl5aloc5k89IVENA83zdwDtP3jLBgA2tONvxIh
        iCFhZBHxuD2hteTvRk+vl7qnd9LW+12DwrOiNYw=
X-Google-Smtp-Source: AK7set84t5/Hanc6UFs4D8xstQCLdAdE2sFOybmww084rRqixjDbOslbUvPP66vCV697zWARmCH61U3Su33HNfX/aO4=
X-Received: by 2002:a17:90b:2692:b0:234:bf90:3a1 with SMTP id
 pl18-20020a17090b269200b00234bf9003a1mr1254947pjb.120.1676998896983; Tue, 21
 Feb 2023 09:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220230624.lkobqeagycx7bi7p@google.com> <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
In-Reply-To: <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
From:   Martin Zhao <findns94@gmail.com>
Date:   Wed, 22 Feb 2023 01:00:00 +0800
Message-ID: <CADfL_jBDNZiEWbnn+w9+FhSRPzVwP872XBbhYTZwny8Jzr4bDw@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 1:17 PM Roman Gushchin <roman.gushchin@linux.dev> w=
rote:
>
> > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >
> > =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote=
:
> >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> >>> The knob for cgroup v2 memory controller: memory.oom.group
> >>> will be read and written simultaneously by user space
> >>> programs, thus we'd better change memcg->oom_group access
> >>> with atomic operations to avoid concurrency problems.
> >>>
> >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> >>
> >> Hi Yue!
> >>
> >> I'm curious, have any seen any real issues which your patch is solving=
?
> >> Can you, please, provide a bit more details.
> >>
> >
> > IMHO such details are not needed. oom_group is being accessed
> > concurrently and one of them can be a write access. At least
> > READ_ONCE/WRITE_ONCE is needed here.
>
> Needed for what?
>
> I mean it=E2=80=99s obviously not a big deal to put READ_ONCE()/WRITE_ONC=
E() here, but I struggle to imagine a scenario when it will make any differ=
ence. IMHO it=E2=80=99s easier to justify a proper atomic operation here, e=
ven if it=E2=80=99s most likely an overkill.
>
> My question is very simple: the commit log mentions =E2=80=9C=E2=80=A6 to=
 avoid concurrency problems=E2=80=9D, so I wonder what problems are these.

Thanks for your watching!
This topic is found in code review by coincidence, so no real issues
recorded for now. I checked other read/write callbacks about other knobs,
most of them use READ_ONCE/WRITE_ONCE on the user setting variable.
Actually I am curious as well why this interface doesn't use
READ_ONCE/WRITE_ONCE, is there any other synchronization mechanism I
didn't notice yet?

>
> Also there are other similar cgroup interfaces without READ_ONCE()/WRITE_=
ONCE().
>
> Thanks!
