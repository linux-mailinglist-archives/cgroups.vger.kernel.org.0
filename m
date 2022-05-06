Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48251DCAA
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 17:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443242AbiEFQCE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiEFQCE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 12:02:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC26AA48
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 08:58:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x18so7844055plg.6
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHy+wusyPADBOcjPYMIU3GWI4e85gM3jZeodGyJVQhA=;
        b=YGRbRScUA8LR419d9cSOfjxmPI30qASgatv9LYfKxT1s7ZO5i8WQkqAVMm0P3oJ4nk
         pBy3k6/8jLxgJSVy7MuL4DUxNA0WmvQ8gnfUfHudyju0I6slP1Mp0HLBuo7jjUPXvoc1
         +2ppp9aeS4CY2viyRJUfAC2jdWa9UL/LWVB3lmNlPkBvpy+G+NMd9SazdehqRdbxwrXH
         edI8bgPLYjrN3G/mKqxCdQimCdKP4M6VVivakQcXQ6nYR6xoLOwI1tp+SrxtmQ4MRnQT
         ApUDsqAx5WIGKy18Lb7Oir3iBhYA4ONUJGRhDTeizI26JCjF/olW7Vs2VyIXz2JNtXnY
         rwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHy+wusyPADBOcjPYMIU3GWI4e85gM3jZeodGyJVQhA=;
        b=B7eVAqgdpl25asMglof/vtKAO9RJIgsaDeMdeRmH0sE4BBTbFFIRKRU2Bxn5jIRofK
         qIn3WXnpumaQZVZrWwuwevx9Gbd3J0NjB1rTU4mQ7p4I1MiHt2USVq/GOL7z6Rokwt91
         e622emZ9p5CFNslLf59sJxWvMFTxnNGvW0uwBqrGMp8I5kSfjpD3jHuroSwEJvC3V1Mk
         ispqyQ7xAK77ezgPYjtDn3yIeerFqL7s3vFGKJNq3C8z3NMY2I76/5qPAFQgyOBvdJBt
         mYlHKYvbqxCBzNvXyXJdSU9SnBKV4p2quyO0UMSoLs8Hm0SHYldhftDuIJx4pDl5ZkZQ
         07Xw==
X-Gm-Message-State: AOAM530iBvLPOzpqz7/+YynHHaccb3FK87EYe4nqdrbIEG5c0NBAZrfh
        6gtT9fZ+sJCN+dsaiuVuWTpSEVTm80/AcEI8bFRlkQ==
X-Google-Smtp-Source: ABdhPJyp2Q4nMMCgRmMgg2kKkOudiFFK7W93k8BUew9TnmnymZ67RQIeu7iOUYVz9L1gYPVH47+ppGfqXEhc9fEUOWs=
X-Received: by 2002:a17:90a:ea18:b0:1da:4630:513d with SMTP id
 w24-20020a17090aea1800b001da4630513dmr4840715pjy.237.1651852700201; Fri, 06
 May 2022 08:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
 <CALvZod5xiSuJaDjGb+NM18puejwhnPWweSj+N=0RGQrjpjfxbw@mail.gmail.com> <CAPD3tpG1BeTOwTBxkXCxoJagvbn6n1aAEkt0P65g91N9gtK03w@mail.gmail.com>
In-Reply-To: <CAPD3tpG1BeTOwTBxkXCxoJagvbn6n1aAEkt0P65g91N9gtK03w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 May 2022 08:58:09 -0700
Message-ID: <CALvZod5OK=6Pmf3-iQ_ERE56-C0u6R0SCRcT6axk28kLxRy_RQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
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

On Thu, May 5, 2022 at 10:27 AM Ganesan Rajagopal <rganesan@arista.com> wrote:
>
> On Thu, May 5, 2022 at 9:42 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, May 5, 2022 at 5:13 AM Ganesan Rajagopal <rganesan@arista.com> wrote:
> > >
> > > v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
> >
> > *max_usage_in_bytes
>
> Oops, thanks for the correction.
>
> > > sysfs. This is missing for v2 memcg though "memory.current" is exported.
> > > There is no other easy way of getting this information in Linux.
> > > getrsuage() returns ru_maxrss but that's the max RSS of a single process
> > > instead of the aggregated max RSS of all the processes. Hence, expose
> > > memcg->watermark as "memory.watermark" for v2 memcg.
> > >
> > > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
> >
> > Can you please explain the use-case for which you need this metric?
> > Also note that this is not really an aggregated RSS of all the
> > processes in the cgroup. So, do you want max RSS or max charge and for
> > what use-case?
>
> We run a lot of automated tests when building our software and used to
> run into OOM scenarios when the tests run unbounded. We use this metric
> to heuristically limit how many tests can run in parallel using per test
> historical data.
>
> I understand this isn't really aggregated RSS, max charge works. We just
> need some metric to account for the peak memory usage.  We don't need
> it to be super accurate because there's significant variance between test
> runs anyway. We conservatively use the historical max to limit parallelism.
>
> Since this metric is not exposed in v2 memcg, the only alternative is to
> poll "memory.current" which would be quite inefficient and grossly
> inaccurate.
>

Oh also include the details you explained here in your commit message.
