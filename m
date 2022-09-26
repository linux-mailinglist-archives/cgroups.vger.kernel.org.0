Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7135EACA1
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIZQez (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIZQe0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 12:34:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A152857C6
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 08:22:53 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 65so1321044ybp.6
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qvRaYPYKDxzCfmvXG/5tfegDFwEt8aN7PLvlIvfXAQ8=;
        b=pStoVQWt8z1fKG46RrHzQ+sN31TSBbQ26LClitIomuBqoK2WB2xkeSUXpBiR/tZFPS
         ZDpUvIXb30o3RRyb586qMCs2Q+aQOJw7lbbI6PS44mBomAbcgUfLoksOaDJugCE7d+Kh
         DJYfs/0c/Ga9st0WzAfZIJFu4DF8IqUh15usUbL1dCXM2QiqHXk8ojNAhIy5vYeVGAcF
         yiAG1h4zC7pp6bxc3yAE+/mbXNSEvVQWLVZHPvCy8R6DPk46I2RwzMxgozOy7irYGciQ
         vBmUqB6XipPTnYgWdmuHwBVqqKSrEp2B6W5q06iRFMxMW6q+JcdP8i1p4vXqTZFiSo0p
         sU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qvRaYPYKDxzCfmvXG/5tfegDFwEt8aN7PLvlIvfXAQ8=;
        b=nTgU4IYKNC9sCq/SYCCTHrBEDrcRA6/D9cDR0w5UH1X7KDezrQ3BAUbBDYM8YSbrnV
         8lvB4DdbqVIbIGYmoZpKCrme/lVKMiafhpNzetglOiV1P+jUZlw4HMAhz5MD+SuV070E
         vbFGTo9CnumQjJwR/mZic+gxIZZvdeDVxvui1oK54Wk4cV+XokZD1rioHuKBnKD6/q5X
         x0Bbj9JiVJ10aBBXSwi0heuGs5o03zPjia5ssoIeL0DtdEcl1FP5b5roZ9JFEkxAMmYz
         LUkbmKnrar34ty2/pancexXBeSi8OPOZHISl2z70958w3REnGgxCjWg9tMvLfCrqzEqJ
         1MsQ==
X-Gm-Message-State: ACrzQf2aJvDZaSTvSMYHomoov3fzyjY+ElFn3LICPATy8ioTLR7lnnJm
        4dwCOR+kh5Ub4Fk3F+YmH905neUPWkLTuLbtHLUkIQ==
X-Google-Smtp-Source: AMsMyM5Lp73sHyFKfLjMTs/m+By3tCw/fxlEkA5yb+z+FfL3c5aa+8/pB0jwke64blltc+ac6ZWSOAVc+uIJ2LribaE=
X-Received: by 2002:a25:9d83:0:b0:68f:a551:ec71 with SMTP id
 v3-20020a259d83000000b0068fa551ec71mr21591820ybp.212.1664205747529; Mon, 26
 Sep 2022 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220926135704.400818-1-hannes@cmpxchg.org> <20220926135704.400818-5-hannes@cmpxchg.org>
In-Reply-To: <20220926135704.400818-5-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Sep 2022 08:22:16 -0700
Message-ID: <CALvZod573J7wJgvvWMHnyL39b7S0TD7fbs2fohvRmSCHUanCqA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: memcontrol: drop dead CONFIG_MEMCG_SWAP config symbol
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 26, 2022 at 6:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Since 2d1c498072de ("mm: memcontrol: make swap tracking an integral
> part of memory control"), CONFIG_MEMCG_SWAP hasn't been a user-visible
> config option anymore, it just means CONFIG_MEMCG && CONFIG_SWAP.
>
> Update the sites accordingly and drop the symbol.
>
> [ While touching the docs, remove two references to CONFIG_MEMCG_KMEM,
>   which hasn't been a user-visible symbol for over half a decade. ]
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
