Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFFC77BF68
	for <lists+cgroups@lfdr.de>; Mon, 14 Aug 2023 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjHNR4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjHNR4h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 13:56:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD46B5
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 10:56:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so42354275e9.1
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692035795; x=1692640595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeN/HGuUgCuQPe5kPvEPkK0pdFU40c32aDEDmB1vFRU=;
        b=eEoTsU2yEih/aF37TTSzmNf2+4o3WWF1X80OF2loX8zGBdBwW1B6vzzBdK1y20zH/r
         Sn4ahzedMLMHlay9fr3/eue4Hp1AwOn310a632QCVrN47BPnt+Ui5eBFBTUf6vVlWfFy
         LM6cmv43Q3SIto1Jjd8qhi9w9cYWGb0eYddco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035795; x=1692640595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeN/HGuUgCuQPe5kPvEPkK0pdFU40c32aDEDmB1vFRU=;
        b=Ee/akQaWmRRl1TNjkm7R+DRK0evnJaXZtO9h+iHM4iFNzdpa46vn3nRtSCmA5a0YeK
         cG4iLC/1W1cZxpLV7oIfVd+C8nXUbfnagaC4TS8t1237k6E53+knnZFO/Q9lyolBC6pb
         fixy9xXtwoLLhp6i1ujogZfpeQ9r4T4eNmTU+RR+LZEoG12ZK2euM9DZc803u76Egatr
         AeC392bPTNj1C361H/la5c6Ctu53s8jMlRs0FkKcRoW4+fgAV+UrRzmhioqa2tnHmsZ3
         MEJvjGdm14JWQgpUm9nomNV4L1GauDeS/M+UjV+5R1RkJCZm76EqpG706PsrXvkFIJ9R
         1XjQ==
X-Gm-Message-State: AOJu0YxTa4pRk0+tHGgoKE4029YvdwlqNrMAnxCB52W9ZrowUkFZGbiI
        /N5dL2x3R7lwSS0OdSWJQdaZjXwJCwwKIqmW6eLbOg==
X-Google-Smtp-Source: AGHT+IEtr8YhK9rwdhdGnQqyqtbe4YECBg/+Z36CICXvXvvNP5p+ftYBInLJlzQ0Abpx2QVpHp4v6za0CEi0bsvOQJ4=
X-Received: by 2002:a7b:c3cd:0:b0:3fb:d68d:4c6f with SMTP id
 t13-20020a7bc3cd000000b003fbd68d4c6fmr7747060wmj.14.1692035794784; Mon, 14
 Aug 2023 10:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
 <a052dffe-ed5e-6d22-8af8-0861e618f327@redhat.com> <CABWYdi0CXy2GZax_s6O-Xc0gvH+TGJzKwv_v6QqMty9P-ATJug@mail.gmail.com>
 <CALvZod65Y-dSkH6a=ASTDTK2oGznTd7Yts1csttxoP0w9jaQUw@mail.gmail.com>
In-Reply-To: <CALvZod65Y-dSkH6a=ASTDTK2oGznTd7Yts1csttxoP0w9jaQUw@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 14 Aug 2023 10:56:23 -0700
Message-ID: <CABWYdi2y+nsbum+0EnK4W_jF-8RNbNJJadiZH2Ofb_wnYjbrbA@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 11, 2023 at 7:34=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> Hi Ivan,
>
> (sorry for late response as I was away)
>
> On Fri, Aug 11, 2023 at 3:35=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> [...]
> > > > I spent some time looking into this and I think I landed on a fix:
> > > >
> > > > * https://github.com/bobrik/linux/commit/50b627811d54
> > > >
> > > > I'm not 100% sure if it's the right fix for the issue, but it reduc=
es
> > > > the runtime significantly.
>
> In your patch, can you try to replace mem_cgroup_flush_stats() with
> mem_cgroup_flush_stats_ratelimited() instead of cgroup_rstat_flush().
> I wanted to see if you observe any stale stats issues.

We scrape cgroup metrics every 53s and at that scale I doubt we'd
notice any staleness. With 2s FLUSH_TIME it would be in the noise. We
can even remove any sort of flushing from memory.stat as long as
cpu.stat is read right before it as it does flushing for both.

I agree with Yosry that there's probably no reason to flush both cpu
and memory stats at the same time.

It doesn't seem right to use delayed flush for memory and direct flush
for cpu. Perhaps it doesn't matter as much to warrant a bigger rework
of how it's done, but maybe then my patch to use the same mechanism
between cpu and memory flushing makes sense?
