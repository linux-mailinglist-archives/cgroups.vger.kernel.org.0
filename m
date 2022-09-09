Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBEC5B3CBA
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIIQMJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Sep 2022 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiIIQMG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Sep 2022 12:12:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971111EA50
        for <cgroups@vger.kernel.org>; Fri,  9 Sep 2022 09:12:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l10so2221918plb.10
        for <cgroups@vger.kernel.org>; Fri, 09 Sep 2022 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=eDrfYVwDQC+B+QpEvQ41UIS7OrQEnld5CNSxZdpZPgA=;
        b=F0wkqBGJL1xYRFxmN2T75z4AIhNt1UbmivRoZwZ3KboiF5oDQtO7ium3Kzq9dCV+3L
         RP2ICzUpgzxqrq8hUXPMY0eGLmRwA+zAdDYSuZh9GUeWrGuwZqUh08H8pA77P9iEsPGp
         b6pnj6Rb9wFZ+c+JdoNtMdcrNCB7NeeWChdxumtbo3jnTMvn/m+9Yh9o+8/jqU14NYlo
         Uq/uY6XTV/gnfIa8IZ92OH+bqS6ePdD+EGQoRQq+nYue9IGW4Px3jClughrHNWAxX7uT
         XPnuvp8oyCH45KSg9104v6Oi+FYeivUUTm11neuKW+KDrm0old9h/hl2dytqCvmymdak
         rzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eDrfYVwDQC+B+QpEvQ41UIS7OrQEnld5CNSxZdpZPgA=;
        b=mMmSiDW7WrSqM435vUDpm6tVAe/Z9Soak+EiiQwbX78EX0OSI4pIuRxemNBJj/7KjS
         7Q1PBnYqzz1ImNaVPA1jfFIvndefwPyIGRJIqpOgXdF32oxXEfRbaNR7VVSAJfZXsVuJ
         xwudMelGuHhM/JzREsnbeYZc6X/QDpCO7TMpNY2TDMbkJEroniS3WG5OCJxMqRbR3mD8
         UkC4hJEDLmAEdRPY0oQIYs9Hpno+4LpTeSW+Thy3sX5vnL0YAo2Fk1/T8Vlb+kZPLdmt
         EB9FfFlkgjmRFoM1lno+oA7J6P87lAIaXnJQ0DJcvesvgtvLt1ZWIFenIUXp9Wa0p0aW
         T6Ow==
X-Gm-Message-State: ACgBeo0k8JxvqQGkEOv33urXuA1jZUr4KvXOZmT9SxU3KuymzI7tB2F4
        oy5twyNcV7aubEFye5Jqz949YE8jFfnE3Mf8rQsx8g==
X-Google-Smtp-Source: AA6agR6o1k8OYU6c3VZsjtmoi4GU+j620+63W9MswFegv3cf067xiW0Q2ntmP7g7tJsYUNwDAHlv3rflaFDJncKmQIQ=
X-Received: by 2002:a17:902:b410:b0:172:c9d1:7501 with SMTP id
 x16-20020a170902b41000b00172c9d17501mr14547983plr.106.1662739919860; Fri, 09
 Sep 2022 09:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com> <20220907043537.3457014-2-shakeelb@google.com>
 <YxqIQOWzrsrPnff3@blackbook>
In-Reply-To: <YxqIQOWzrsrPnff3@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Sep 2022 09:11:48 -0700
Message-ID: <CALvZod77qUb0XRJh3y3-GQevoKjcwdt-Gtq0u0Tp6zTxBe-4CA@mail.gmail.com>
Subject: Re: [PATCH 1/3] memcg: extract memcg_vmstats from struct mem_cgroup
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 8, 2022 at 5:26 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hi.
>
> On Wed, Sep 07, 2022 at 04:35:35AM +0000, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > This is a preparatory patch to reduce the memory overhead of memory
> > cgroup. The struct memcg_vmstats is the largest object embedded into th=
e
> > struct mem_cgroup.
> > This patch extracts struct memcg_vmstats from struct
> > mem_cgroup to ease the following patches in reducing the size of struct
> > memcg_vmstats.
>
> Is the reason for the extraction just moving things away from the header
> file?
> Or is the separate allocation+indirection somehow beneficial wrt, e.g.
> fragmentation?
>

The main reason was to move away from the head file. I have not yet
measured the performance impact of these changes. I am planning to
rearrange struct mem_cgroup and will do some performance tests after
that.
