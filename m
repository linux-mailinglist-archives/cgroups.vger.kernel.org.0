Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31A4F8B83
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 02:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiDGXHC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 19:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiDGXHB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 19:07:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7002611
        for <cgroups@vger.kernel.org>; Thu,  7 Apr 2022 16:04:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f10so6366296plr.6
        for <cgroups@vger.kernel.org>; Thu, 07 Apr 2022 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQwT+/mAGUqM3bKuuBQMYn0uTeyRqxSYD1X0xo7/rPE=;
        b=Te8C7q8zW+qLm4J/emex42n1YOTNTgYioZ6aL6jd2MEBaCBiG1MonTEaVigQYrxCnX
         lc2a1Zp9F/CS9bGuKEKpu93mdMYLs+lQfsbi5mhteuVgcuoJm0wqWfraYddXR8D2bRg6
         g80ZitZ42SJag/feMLrn8DX95l13h9byUhXsltGRKCs9KWV88T/Q6QdZkDXhfdleSkQe
         ryLxvSOK7GWWj6jsOpKFb2APmR0DtW+cvDsI5vs30igZtouAhcFKm2Hq3Ic2zZxJev/e
         Hyk2ptU132DXhvbF7YzTGVCDK2FzEn2yYfELqe296BiWwOwU5IvauV2Zbzna4r5BI7u0
         VEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQwT+/mAGUqM3bKuuBQMYn0uTeyRqxSYD1X0xo7/rPE=;
        b=DCFHwwujnr/AzzRvkcnS4DBNAC9ykJR4RdGJB2CJVt8DSq3gV0FJF8E8Qx4LbXzyuT
         rUa2YRRxlKnx67V/cl86ioVU080IZSMQ+XkUZuZTP5QQkWUW/i/L8vNZ5Q1ygWhWxj4w
         ghOeGMd4n4+7Vxrc2Xg0SXmABVjaQLei+PTRyzwrnX+NFRUsm9ufrZfp3HqawCvH++Eu
         BAllGebgTiMjBTc94tI1dC0l0pOjS/CM71tZDLheBsjzbLvH7hINo2+5G27glsxpv9ud
         RCMyvhxarFxYexHMUquVz8VJLQVk+xBmrsrBJDcbagplQnzKOK4nY9D36U+pJn13ZOvC
         5Haw==
X-Gm-Message-State: AOAM532GK7g3wPDt9+Myq2ZpxNXyhsH10VeNzLFRR7QEmWJynoAlMwNc
        /pTYeEKTviOIGj9iU8aRdo5rQ8+7/bEkgeq2AXqRsQ==
X-Google-Smtp-Source: ABdhPJwyhCRn0iVyHg2CNrALoCcH3RqdRakJthXzqTS4zMpJZcTUNX/0eDdWvG2pEr2k9AtFzvO+MIBVwETlcC1KafM=
X-Received: by 2002:a17:90a:c791:b0:1c7:26eb:88dd with SMTP id
 gn17-20020a17090ac79100b001c726eb88ddmr18367740pjb.218.1649372698677; Thu, 07
 Apr 2022 16:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220407224244.1374102-1-yosryahmed@google.com> <20220407224244.1374102-4-yosryahmed@google.com>
In-Reply-To: <20220407224244.1374102-4-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Apr 2022 16:04:22 -0700
Message-ID: <CAJD7tkaPaXQ4M_w-YxJizD2DG8co-3Q2bVDfd7_FaG2ivgT6UA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selftests: cgroup: fix alloc_anon_noexit()
 instantly freeing memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 7, 2022 at 3:43 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
> the allocated memory. alloc_anon_noexit() is usually used with
> cg_run_nowait() to run a process in the background that allocates
> memory. It makes sense for the background process to keep the memory
> allocated and not instantly free it (otherwise there is no point of
> running it in the background).
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 36ccf2322e21..c1ec71d83af7 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -211,13 +211,18 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
>  static int alloc_anon_noexit(const char *cgroup, void *arg)
>  {
>         int ppid = getppid();
> +       size_t size = (unsigned long)arg;
> +       char *buf, *ptr;
>
> -       if (alloc_anon(cgroup, arg))
> -               return -1;
> +       buf = malloc(size);
> +       for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
> +               *ptr = 0;
>
>         while (getppid() == ppid)
>                 sleep(1);
>
> +       printf("Freeing buffer");

Hey Andew,

I am very sorry but I left a debugging printf there by mistake. If
it's no hassle, do you mind removing it from the patch (assuming I
won't need to send a v3 anyway)?

Thanks!

> +       free(buf);
>         return 0;
>  }
>
> --
> 2.35.1.1178.g4f1659d476-goog
>
