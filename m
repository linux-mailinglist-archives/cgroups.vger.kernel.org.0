Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D375BB47
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGTXev (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGTXeu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 19:34:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746A358C;
        Thu, 20 Jul 2023 16:34:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55ba895d457so746263a12.0;
        Thu, 20 Jul 2023 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689896031; x=1690500831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDyB0fNg8iWGoLzY4kcY3n9F15g3W1rTkoIJoBTRg3A=;
        b=p+DjGaqxAYYqPCdrR2BuBFrntop3OtvaJ9VPhfM4o2gjf3vqRJipbYIu7R0l45bmex
         qOYSyJjyvqVatCS3/cx/jCT624c+7E64DfOD4mxB7fVWiy9qgxpagCj5Oq7t63/bbEbd
         7XlvJpp22DUAqDFFOk1rUNh/4XL1OEyZ9/FICeZEWEvKrC3C2DaExZWPQbFmbi8btTih
         OdWniYrypHRj+r7hruEGoY+OT/ko57kNTp34phNCjotDBg6lkZQug5+DcQiRLL+PYgyn
         Urb767YbMH2gYYyExrPkfBmm/0ZwTrS0pZGlBY0dMuyw8WfHFCJ1y0ZDpbMza1FBy9MC
         D1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689896031; x=1690500831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDyB0fNg8iWGoLzY4kcY3n9F15g3W1rTkoIJoBTRg3A=;
        b=NRiO54Rn8lbgKuokkNTepZppMGMOFYrCkQVoxv0Ad0EFubLQleHkEpk6xCnh4o/peO
         YLLuCLPHj+TGCO6T1llA3AG3s8F68RJbjLjpOS+Q3IlcI2OKG7IjJPr/pBYnBf47iV2J
         2CYrERtybiMoiNZ00fNMTaAwtvPjYqQ0E38Jh7G2HKm93g3RpoRZrpWlyzSa3RU333ee
         UkRizE60IMyPAeGyZwBws1Ggia3JieNceOgS9BuvENiSZlZyEqWxgYaNurCwvJc+LfcM
         1kVj2PhLeB01wnME9CYKfyXqfO8B7VnzurnFCSjOX3ymqMaeBHgG5zPdLmfZTDlSnbYU
         OF6w==
X-Gm-Message-State: ABy/qLaWWkAIobOMSg3mbIX51AQa5zRisvuHCJRCI/W774kP9EqvSPA4
        nOZ59PhDySnZzAQLOKwGkQ0=
X-Google-Smtp-Source: APBJJlG9dcKPqdMMFcJVFh6rhJcaarEtkzCu++Q5F259HoJP8/SfAsOR9pG4xjmljAFXmku1B2DUrg==
X-Received: by 2002:a17:90a:6b4f:b0:262:b22b:8ab5 with SMTP id x15-20020a17090a6b4f00b00262b22b8ab5mr128498pjl.17.1689896030994;
        Thu, 20 Jul 2023 16:33:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a01c300b00263c8b33bcfsm1576834pjd.14.2023.07.20.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:33:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 13:33:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <ZLnEXbeQJ_69xV23@slm.duckdns.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
 <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
 <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
 <CABdmKX0JETkXpOSfCUZ3jaZv1JxRzbTP+Se4i3HMKjP3PNZ8Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX0JETkXpOSfCUZ3jaZv1JxRzbTP+Se4i3HMKjP3PNZ8Qg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jul 20, 2023 at 04:24:02PM -0700, T.J. Mercier wrote:
> > Hmm... so, usually, the problems we see are resources that are persistent
> > across different instances of the same application as they may want to share
> > large chunks of memory like on-memory cache. I get that machines get
> > different dynamic jobs but unrelated jobs usually don't share huge amount of
> > memory at least in our case. The sharing across them comes down to things
> > like some common library pages which don't really account for much these
> > days.
> >
> This has also been my experience in terms of bytes of memory that are
> incorrectly charged (because they're charged to a zombie), but that is
> because memcg doesn't currently track the large shared allocations in
> my case (primarily dma-buf). The greater issue I've seen so far is the
> number of zombie cgroups that can accumulate over time. But my
> understanding is that both of these two problems are currently
> significant for Yosry's case.

memcg already does reparenting of slab pages to lower the number of dying
cgroups and maybe it makes sense to expand that to user memory too. One
related thing is that if those reparented pages are written to, that's gonna
break IO isolation w/ blk-iocost because iocost currently bypasses IOs from
intermediate cgroups to root but we can fix that. Anyways, that's something
pretty different from what's proposed here. Reparenting, I think, is a lot
less conroversial.

Thanks.

-- 
tejun
