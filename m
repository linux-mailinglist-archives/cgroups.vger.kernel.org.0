Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33CC713629
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjE0Szc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 May 2023 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE0Szc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 May 2023 14:55:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94A8D8
        for <cgroups@vger.kernel.org>; Sat, 27 May 2023 11:55:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f5d651170so586233966b.1
        for <cgroups@vger.kernel.org>; Sat, 27 May 2023 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685213727; x=1687805727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viejgcOJYhUdOPohgf97i0Wzf+D67gj8ZGmzRX0nO/k=;
        b=yoIXKiJP/PQuOCyvUbfZpPOpmciaL4BClmV5u9FWAJav2Ab8Fs/ZHqJC6/HGAiO13m
         ZIKUvlIZjCopV2HwNAgU5hBgWXN5Gx9UGuVLxhZwd1XDlIeFS7Tn4kU/+WQ1PkaFuTMY
         SeJaaK3wWFUBTd7wOLVlxB+V0ZsQNdY7xTCxKpHi8oVAv/QbU19qZaeZFlnP416z3z4Y
         97dqvyvsgJ/TPe+wKMayqSIW9aw2RQStv1GRQGRjUFhJpNPxuYp8wqTpzr5hv3o/Y/Od
         aGCh+n3C6XasvgpZvPguvSXjnuqn7Coq7+UHWRY1PscVJpDxDqfIBI/dDcKQ0EzCIj/p
         /PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685213727; x=1687805727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viejgcOJYhUdOPohgf97i0Wzf+D67gj8ZGmzRX0nO/k=;
        b=hZA4UHVeN8MafyXLoZfBRSLXu++u0NEPhwDWT5ZfQ3SX3ZqAQHNiJaHxcPsLRwEkzx
         kU2zgwaSp6gydkRS5j6LEHZGjYihliMwpFICr0v1kYFlouCecdptP/n/IH5/Fgfta6yt
         4x5QvUjUM7H3+3paDbFp14NJC2S1Grv32uL/9cLDkaQeovDjUZp1Jb04xqyfUwmfULDb
         uehbGDXXVMLcMNQu1Dx0llpJlZvbXuTr89ZFWlD9NAEqHZhGRQffKlm8To863KfeZgnH
         OovXVmr+grRNo1M4lHt1gw453E0mbl7YTUyUSGRNlN2g3ALF2+CUBSGqFraOIIH/sOcS
         Gdww==
X-Gm-Message-State: AC+VfDx5KpAzx0j5myTKiwcaBUCRLk09UWL7PHMBG5b44Sjv6sgclvl8
        4X0oHrKEuQnhjNArYiewpnFiG3sVaXB6q7Nxgde4Rg==
X-Google-Smtp-Source: ACHHUZ4cY+YKzf3kGgpArZ+DgkkS5ZM4pAPkMnZnRR17ridTfoFJR5pJ7FXcCmsuCaJJNY7AG22LsT0cACVD3aVaxHI=
X-Received: by 2002:a17:907:6d0c:b0:96f:aed9:2520 with SMTP id
 sa12-20020a1709076d0c00b0096faed92520mr2426610ejc.21.1685213727057; Sat, 27
 May 2023 11:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230527103126.398267-1-linmiaohe@huawei.com> <ZHGAcaqOx/e8lqwV@casper.infradead.org>
 <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com> <ZHIcnOV/mrkcerlG@casper.infradead.org>
In-Reply-To: <ZHIcnOV/mrkcerlG@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 27 May 2023 11:54:50 -0700
Message-ID: <CAJD7tkZ2Q1ZCqNchpiiC6FCE08dYH6tzANA=VqujeDgT8YhRUA@mail.gmail.com>
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Sat, May 27, 2023 at 8:07=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 26, 2023 at 09:13:05PM -0700, Yosry Ahmed wrote:
> > On Fri, May 26, 2023 at 9:01=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Sat, May 27, 2023 at 06:31:26PM +0800, Miaohe Lin wrote:
> > > > The function mem_cgroup_from_obj() is not used anymore. Remove it a=
nd
> > > > clean up relevant comments.
> > >
> > > You should have looked at the git history to see why it was created
> > > and who used it.
> > >
> > > Shakeel, Vasily, are you going to retry adding commit 1d0403d20f6c?
> >
> > That commit did not introduce the function though, no? It was
> > introduced before it and replaced by other variants over time (like
> > mem_cgroup_from_slab_obj()). It looks like that commit was reverted ~9
> > months ago. We can always bring it back if/when needed.
>
> The commit immediately preceding it is fc4db90fe71e.
>
> Of course we can bring it back.  It's just code.  But avoiding
> unnecessary churn is also good.  Let's wait to hear from Vasily.
>
> > It also looks to me that 1d0403d20f6c was using mem_cgroup_from_obj()
> > on a struct net object, which is allocated in net_alloc() from a slab
> > cache, so mem_cgroup_from_slab_obj() should be sufficient, no?
>
> Clearly not.

I dived deeper into the history on LKML, and you are right:
https://lore.kernel.org/all/Yp4F6n2Ie32re7Ed@qian/

I still do not understand why mem_cgroup_from_slab_obj() would not be
sufficient, so I am hoping Vasily or Shakeel can help me understand
here. Seems to be something arch-specific.

Thanks for digging this up, Matthew.
