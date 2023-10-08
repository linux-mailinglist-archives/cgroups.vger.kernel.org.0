Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4B7BCD89
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjJHJe6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJe6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 05:34:58 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9043B6;
        Sun,  8 Oct 2023 02:34:56 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49369d29be3so1512979e0c.3;
        Sun, 08 Oct 2023 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696757696; x=1697362496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBlUVQJaS2QVKhbKscoUL4NFod1x8khTjMBK7u8aW6o=;
        b=ZvqNHj8alv/9+LKotQHfuH+zShml24HDq8e0jJUi+ftX+PU9DPeZj+JUIaJ3NfBVlo
         ZMjukFeyRt1SxAuw2PgLf/wJ3tYpYDmYr8k0XbuHr8ic8Hr+zzk1gH0jCty9kCGP1D0F
         P3VURKLqxukX2+KKlVejmFRdPA5zR+J0WSD131pGj0wtDOXVMQDWrroJiTMZ6VA1Yvn4
         z3drx7zktg8m/l/IxbaI/DV/2+pEg609lj7qx8ImGD1GUj1tRB2vmNaJDK18ghE7Esut
         x7tPdSPxdSVVb6itKw8RprwSE7a8GNvv2oLu0JvScd3gQUdBdVgLWOeE8yO6QfnU2MoS
         kF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696757696; x=1697362496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBlUVQJaS2QVKhbKscoUL4NFod1x8khTjMBK7u8aW6o=;
        b=L0DJIVlSz/Lh69l9r1UgWU1zneZgtbwQto7tT0WsgEVgsUtIRc7m+XZMoD2DbrEgDJ
         C8iMZa98HF0UcpUJI/bY4EwufVo4VgASi+5r8Sdx2MGgBOLxBtOuPeiWarxq+zy0gBAD
         jGO+yOq2cZmPDu2DC9PZh1JQYORsvvGoiLDtsKp7Wyhq2iCeiG1MdjFuCG6HayuffI2+
         2Q/Y0bljJIvE82hwoDOCrFGeBYycLthEbnXi1c0iylWgP4c4Yx2WTOiP8RjJ4B2mTYEo
         91sw8tPG5rzqPJVgyuOdc7CmzsxBe7gMAqR8JObtLRZiW5P2ro3P7JH74bVD7C1ScMyV
         /lKg==
X-Gm-Message-State: AOJu0YxexSNbAePnpfFRqR/a0/cQob8CeSmOLEzknh/SD2wVAwdNLnfh
        MM780F3uUdHlltyw1kCl8kxs+eOt6FGwSvtskfBzQaghfSN6clzU
X-Google-Smtp-Source: AGHT+IHl/YyHGv2Hw1jRFM1F/jxzZPHFV8Mii7BcWH3Q24BGobPGCn29/2DAfjv3ZiQhf4x7TtkZO9aS6ssH1NcOwPo=
X-Received: by 2002:a67:f5cb:0:b0:452:6b50:1e7e with SMTP id
 t11-20020a67f5cb000000b004526b501e7emr9290513vso.35.1696757695971; Sun, 08
 Oct 2023 02:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231007130905.78554-1-jianlv@ebay.com> <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAFA-uR9ymPTktMbi96cb+smjQHB4Y=8SQfAqmsqTbniGbkGTLA@mail.gmail.com> <87il7hjzdp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87il7hjzdp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Sun, 8 Oct 2023 17:34:44 +0800
Message-ID: <CAFA-uR9n-rKw4k26Bhm=P16jOMtAncRsno7o=yYJ1kTxmB_mRw@mail.gmail.com>
Subject: Re: [PATCH] memcg: add interface to force disable swap
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, yosryahmed@google.com,
        willy@infradead.org, linmiaohe@huawei.com,
        wangkefeng.wang@huawei.com, laoar.shao@gmail.com,
        yuzhao@google.com, wuyun.abel@bytedance.com, david@redhat.com,
        peterx@redhat.com, vishal.moola@gmail.com, hughd@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jianlv@ebay.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Oct 8, 2023 at 4:26=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Jianlin Lv <iecedge@gmail.com> writes:
>
> > On Sun, Oct 8, 2023 at 9:17=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Jianlin Lv <iecedge@gmail.com> writes:
> >>
> >> > From: Jianlin Lv <iecedge@gmail.com>
> >> >
> >> > Global reclaim will swap even if swappiness is set to 0.
> >>
> >> Why?  Can you elaborate the situation?
> >
> > We reproduced the issue of pages being swapped out even when swappiness=
 is
> > set to 0 in the production environment through the following test progr=
am.
> > Not sure whether this program can reproduce the issue in any environmen=
t.
> >
> > From the implementation of the get_scan_count code, it can be seen that=
,
> > based on the current runtime situation, memory reclamation will choose =
a
> > scanning method (SCAN_ANON/SCAN_FILE/SCAN_FRACT) to determine how
> > aggressively the anon and file LRU are scanned. However, this introduce=
s
> > uncertainty.
> >
> > For the JVM issue at hand, we expect deterministic SCAN_FILE scan to av=
oid
> > swapping out anon pages.
>
> Why doesn't memory.swap.max work?

The main reason is that deployed nodes  are kept on cgroups v1.

>
> --
> Best Regards,
> Huang, Ying
