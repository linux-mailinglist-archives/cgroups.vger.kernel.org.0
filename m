Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD968714012
	for <lists+cgroups@lfdr.de>; Sun, 28 May 2023 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjE1UUL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 May 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjE1UUK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 May 2023 16:20:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D1AD
        for <cgroups@vger.kernel.org>; Sun, 28 May 2023 13:20:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f99222e80so558647866b.1
        for <cgroups@vger.kernel.org>; Sun, 28 May 2023 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685305207; x=1687897207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5tzlCcTXM+eOURUdO0t9TVW2oV4Aa+HB1hfHnMu9k8=;
        b=s8FB2ezdO7kdcK7pl7RNe0BNVFxC0Yq4k84nMFs4rF20IctkBmf1Yacsu1VPAnMCzR
         Y4M22U2y5fIznXfBvrbFuDZKtV5znftQpZuw0asdirs89nocYzyo0eo2sw1GSos80sD7
         s05H+tuXmiKCtYXhPWMWLJFDqwEuirbWGr3KG3TbrPdYtqek1/pPjFRIpxZG88jMsdNv
         q3Cpv+9y71x5WDq1kHOuoh/Rqv6Yt7Hran5AsHNMgomVRHT2A3E2IT5c/cFPtiJDrq71
         GveYnre8KOKaVbEdTArMu40p+/B89f9Ot573qWvgmJ2YGHnZcDoBRcve5ZCv89kHNU7U
         OxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685305207; x=1687897207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5tzlCcTXM+eOURUdO0t9TVW2oV4Aa+HB1hfHnMu9k8=;
        b=QK0qD/wwR1fvNYs6Li3jFk4qaLTW+I22OGIBTQ5EB1NJ4Z965jr25IYKJ1BHSsXw1R
         42jdXj7jknzSX/peESroXOuuZRlLBrKauim8jvqzD4cx5wZqnEMkcNCIUpiXIk4gDI3X
         j4VomOnlGx1TtGsdJorUX7N3dHHcaGAB83fo9ot6J7jxUZCqgfe5tzOWBvyIjT0mWTkX
         1GlX58cmMGH/EaVvxzdbSo9+Cyef0YbE7V4GgfKy2Scxs0UXmpBK4WL9U/PtwA5k8pey
         FqM5xqvs6PNAHsUQn7zaYYPEr6IEk/XQPJDjPE9axwsBaOrqBZIV/hW/h614aa/HRV6y
         hRZg==
X-Gm-Message-State: AC+VfDwXJISY0ETYsPG+WfpJDp6hlkiJWJhO02IFFeZVAxC0hFech9ia
        /rfC28bvsRI51puGGdWSyQ4Kky/LFGrsPQOR+koBops8Ta5qknLOGys=
X-Google-Smtp-Source: ACHHUZ6LKrWQYZ/ziYg2ebTrJN5whPmpw/mWVtFHT6bvgB+PON/LDioZ17gr+9wBRW6VRPuxrQziRSJVXpkWUUoag2Q=
X-Received: by 2002:a17:907:6d12:b0:95f:969e:dc5a with SMTP id
 sa18-20020a1709076d1200b0095f969edc5amr4825779ejc.30.1685305206691; Sun, 28
 May 2023 13:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230527103126.398267-1-linmiaohe@huawei.com> <ZHGAcaqOx/e8lqwV@casper.infradead.org>
 <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
 <ZHIcnOV/mrkcerlG@casper.infradead.org> <CAJD7tkZ2Q1ZCqNchpiiC6FCE08dYH6tzANA=VqujeDgT8YhRUA@mail.gmail.com>
 <D2B59104-B602-45A3-B938-AE5DC67BAC98@linux.dev>
In-Reply-To: <D2B59104-B602-45A3-B938-AE5DC67BAC98@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 28 May 2023 13:19:30 -0700
Message-ID: <CAJD7tkb+Y6PXHEVkmXyfMSXh=kY_T-qxvJFv=nF-m0ZYZv5Ryw@mail.gmail.com>
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, May 28, 2023 at 6:02=E2=80=AFAM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On May 28, 2023, at 02:54, Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Sat, May 27, 2023 at 8:07=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> >>
> >> On Fri, May 26, 2023 at 09:13:05PM -0700, Yosry Ahmed wrote:
> >>> On Fri, May 26, 2023 at 9:01=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> >>>>
> >>>> On Sat, May 27, 2023 at 06:31:26PM +0800, Miaohe Lin wrote:
> >>>>> The function mem_cgroup_from_obj() is not used anymore. Remove it a=
nd
> >>>>> clean up relevant comments.
> >>>>
> >>>> You should have looked at the git history to see why it was created
> >>>> and who used it.
> >>>>
> >>>> Shakeel, Vasily, are you going to retry adding commit 1d0403d20f6c?
> >>>
> >>> That commit did not introduce the function though, no? It was
> >>> introduced before it and replaced by other variants over time (like
> >>> mem_cgroup_from_slab_obj()). It looks like that commit was reverted ~=
9
> >>> months ago. We can always bring it back if/when needed.
> >>
> >> The commit immediately preceding it is fc4db90fe71e.
> >>
> >> Of course we can bring it back.  It's just code.  But avoiding
> >> unnecessary churn is also good.  Let's wait to hear from Vasily.
> >>
> >>> It also looks to me that 1d0403d20f6c was using mem_cgroup_from_obj()
> >>> on a struct net object, which is allocated in net_alloc() from a slab
> >>> cache, so mem_cgroup_from_slab_obj() should be sufficient, no?
> >>
> >> Clearly not.
> >
> > I dived deeper into the history on LKML, and you are right:
> > https://lore.kernel.org/all/Yp4F6n2Ie32re7Ed@qian/
> >
> > I still do not understand why mem_cgroup_from_slab_obj() would not be
> > sufficient, so I am hoping Vasily or Shakeel can help me understand
> > here. Seems to be something arch-specific.
>
> I think it is because *init_net* which is not allocated from slab meant
> its address does not belong to linear mapping addresses on arm64. However=
,
> virt_to_page() is only applicable to linear mapping addresses. So,
> mem_cgroup_from_slab_obj() is not sufficient. mem_cgroup_from_obj() is us=
ed
> in this case, which will use vmalloc_to_page() for the page associated
> with *init_net*. If Vasily does not want to bring commit 1d0403d20f6c bac=
k,
> this patch LGTM. Otherwise, let's wait for Vasily.

I see, thanks for the context, Muchun!

>
> Thanks.
>
