Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349195B128C
	for <lists+cgroups@lfdr.de>; Thu,  8 Sep 2022 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIHCfX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIHCfX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 22:35:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438DE95AF0
        for <cgroups@vger.kernel.org>; Wed,  7 Sep 2022 19:35:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c24so15337789pgg.11
        for <cgroups@vger.kernel.org>; Wed, 07 Sep 2022 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ky2nnvwk5aMRpug1OiXdRVfX6OZ/Blwf8y/RgQf3zCU=;
        b=IfqRKpQJZLtUUw3FK0nalBJ+FjJYspG6C1fY/6m//4cf4HJJhIsIsPGoRoTTNsCnQS
         7nDJRuNF1imN5jNzf1YM9DNRaGaBVS8u6DC8VjpdD21adZbQ2kRVjn0a8VcZc1183KRg
         2rXc26R4gdOX0PTflk+HqGryZp4BUoLR5cBn30bUaqne7zTicctxBSgJs9JtzcnYXyZL
         eRBGv7Lp6b5LRD1WAHxDRG+vdsi5AHQ5lB6HeYq6qn4StAAY1Di5cQn9AePJ9KKqSKPs
         z6NWDM0fVXaufe1qxDay/6XZqvQJgXE6wAeA8OLyScix0+vjawVxHPhgPncsveXFTinG
         czFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ky2nnvwk5aMRpug1OiXdRVfX6OZ/Blwf8y/RgQf3zCU=;
        b=aZ7zHbZ2MTev85nWno5tNu6r3LrFsd4p+ZgEz2D0nNuBFPb7OsDBgIthn9xLrwa5cE
         clrEMpFiqf05z2hHHD+zGqWaCncOL0Xksq/Ie/arrvrGo4Q8adtefQPg/LZaTq2t3Cwu
         1X+Q4KOxilqyNsoSfjcJ8bdNebzUnls1i5VyYjayo6g25s23/xAx5L/Yt5MFF2dHeH28
         JOPTF2SuVoKlLZ6aTv5Hs9m3matMqLqIsrXXGIFyU5fyqw3/9tKgiX6YQ9esFTUcSYCN
         e2g3Jx5S4Fsk6XADy+eUtORxY1Y/Xjg6f+6bQ9I/+KPSUpMZJ2k6AKvdT/PnjhFAd+4+
         5DWA==
X-Gm-Message-State: ACgBeo1caQUW52cEQW9HKaIteGEKKlORCb7PJ4IJCAYTxvHx6eYYvLld
        53MM8BwJbNUBTchpgiLp4gmnvEXsByP1XFuVKqcs9w==
X-Google-Smtp-Source: AA6agR5EJ0ZEbrVZkpUuRie3AJaKAJdYbfgDtopgpj+sqF8J4AGNCc7ajxsAMVxIBf+qfSs0s80TkD+CAq7HDXDati8=
X-Received: by 2002:a05:6a00:2385:b0:53a:cad4:79de with SMTP id
 f5-20020a056a00238500b0053acad479demr6913798pfc.8.1662604521620; Wed, 07 Sep
 2022 19:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com> <20220907043537.3457014-4-shakeelb@google.com>
In-Reply-To: <20220907043537.3457014-4-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Sep 2022 19:35:10 -0700
Message-ID: <CALvZod70Mvxr+Nzb6k0yiU2RFYjTD=0NFhKK-Eyp+5ejd1PSFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Sep 6, 2022 at 9:36 PM Shakeel Butt <shakeelb@google.com> wrote:
>
[...]
>
>  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  {
>         long x = 0;
>         int cpu;
> +       int index = memcg_events_index(event);
> +
> +       if (index < 0)
> +               return 0;
>
>         for_each_possible_cpu(cpu)
>                 x += per_cpu(memcg->vmstats_percpu->events[event], cpu);

Andrew, can you please replace 'event' in the above line with 'index'?
I had this correct in the original single patch but messed up while
breaking up that patch into three patches for easier review.
