Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85374957D
	for <lists+cgroups@lfdr.de>; Thu,  6 Jul 2023 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjGFGVL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jul 2023 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjGFGUt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jul 2023 02:20:49 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A632B198B
        for <cgroups@vger.kernel.org>; Wed,  5 Jul 2023 23:20:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b2ab496ecso380321a12.2
        for <cgroups@vger.kernel.org>; Wed, 05 Jul 2023 23:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688624448; x=1691216448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=054dwjt9BZCou3BvPjMRnfFzZ2wjHCy2lrA2F8To2Yk=;
        b=a/gZc1hvT7JRiiUYzG1SPVOHiHFMZ5cv81dBONAX0K6rQb/SqodZ/lLZoD6G628ExP
         YAd7fHKCO8Uce6GfN3NdeaykplGQ29jTP1s1duFpDpYznOqIoHbToAyL5+/e4rjop4px
         RnYjO1Dq2V76xE62yjTCc5gppCq4Ilyvg6B+wC/at9D5beVGj/dSGIKww8CivxZHgMPs
         xUAr63iI0RUxB/1CrizQ0kDz4z+hUrxNojnH+C506j0HK6jQWpTT4OiCsEUo2etb1Qaj
         qq9nOEvhORD0DyWKW/sSLHCUa79qo5POjO0faDZksJV99qlPER3hM1mrmWsqRtzP1voK
         kuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688624448; x=1691216448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=054dwjt9BZCou3BvPjMRnfFzZ2wjHCy2lrA2F8To2Yk=;
        b=BTIFFieiibU0zfi7hCzubKNuvzzLRO/wcs/w+YP7k/35glEpNeEBp8Uq3EF28nkfXK
         aHzp3+qt5CzeZHeiWaRzaIOj9UzpXEG5QZ72655zFg2tdc0c3ZBKQwtQR9Qt062D0leJ
         5kLSHPFEWf7ADC4R0/kz2PD/5wmUFbCe65ZdJrT8jBByXD4+NBVyCBsvxuTC1Xadc8Nz
         XpWQOsHztsvysDZ4OyhrBOxvo8aTOQJu5WqhMM6Yc8IYjvzt+KUDMBWut/VwsDjuypm6
         gge62BrrhHMnu+IzNVkx6GSwO7IpM4Q2hjQ+AtQNiV2mpIKpdcnp/exMHmHKlzE1wv4E
         VaGg==
X-Gm-Message-State: ABy/qLamtcIAwpBF1wzBmQLMfe23TCY5RsZdLZTRNTiJMVyKswiyMU3D
        BWKAdfqv9O1q4rT+9LU8t8sKbdh0uqNf9A==
X-Google-Smtp-Source: APBJJlFzXEYN6IPpBFkmO+8r0LKe3KxYt8mAuNjzTYJLriYpEm63md407jdKnq12s3zBrfw6dE9T/SconNIdSw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:751d:0:b0:553:8668:dc40 with SMTP id
 q29-20020a63751d000000b005538668dc40mr509175pgc.6.1688624448157; Wed, 05 Jul
 2023 23:20:48 -0700 (PDT)
Date:   Thu, 6 Jul 2023 06:20:45 +0000
In-Reply-To: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
Mime-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
Message-ID: <20230706062045.xwmwns7cm4fxd7iu@google.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
From:   Shakeel Butt <shakeelb@google.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou wrote:
> Hello,
> 
> We're seeing CPU load issues with cgroup stats retrieval. I made a
> public gist with all the details, including the repro code (which
> unfortunately requires heavily loaded hardware) and some flamegraphs:
> 
> * https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13
> 
> I'll repeat the gist of that gist here. Our repro has the following
> output after a warm-up run:
> 
> completed:  5.17s [manual / mem-stat + cpu-stat]
> completed:  5.59s [manual / cpu-stat + mem-stat]
> completed:  0.52s [manual / mem-stat]
> completed:  0.04s [manual / cpu-stat]
> 
> The first two lines do effectively the following:
> 
> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
> /sys/fs/cgroup/system.slice/cpu.stat > /dev/null
> 
> The latter two are the same thing, but via two loops:
> 
> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat >
> /dev/null; done
> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
> > /dev/null; done
> 
> As you might've noticed from the output, splitting the loop into two
> makes the code run 10x faster. This isn't great, because most
> monitoring software likes to get all stats for one service before
> reading the stats for the next one, which maps to the slow and
> expensive way of doing this.
> 
> We're running Linux v6.1 (the output is from v6.1.25) with no patches
> that touch the cgroup or mm subsystems, so you can assume vanilla
> kernel.
> 
> From the flamegraph it just looks like rstat flushing takes longer. I
> used the following flags on an AMD EPYC 7642 system (our usual pick
> cpu-clock was blaming spinlock irqrestore, which was questionable):
> 
> perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro
> 
> Naturally, there are two questions that arise:
> 
> * Is this expected (I guess not, but good to be sure)?
> * What can we do to make this better?
> 
> I am happy to try out patches or to do some tracing to help understand
> this better.

Hi Ivan,

Thanks a lot, as always, for reporting this. This is not expected and
should be fixed. Is the issue easy to repro or some specific workload or
high load/traffic is required? Can you repro this with the latest linus
tree? Also do you see any difference of root's cgroup.stat where this
issue happens vs good state?

BTW I am away for next month with very limited connectivity, so expect
slow response.

thanks,
Shakeel
