Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3725F15D8
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiI3WLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiI3WLQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 18:11:16 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694712084B;
        Fri, 30 Sep 2022 15:11:14 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127dca21a7dso6941971fac.12;
        Fri, 30 Sep 2022 15:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XScEm+DuYC8Hlch7wHtQ1OIZ+cTh7jVexKgDloeMcLg=;
        b=yuNno+LYadq20Pk5744APf6fbk2XZ9RAlmPHZyUE0Qc+5mYcRO8VM514K9zlA8aG88
         QhMqRE04F+7JLF4fPbUUvedtZ6cgYDIcV8l+RoE4qZB6gG4zLvMfMUQJtmAEUE2dvOLM
         7bGSVYr8mETMgRfU1g9c7OHWE1xMikcEDHfE+ahkGNCpOgDW0GuH9oieY1zczPO985tN
         suGNZgv9IZf/r3dylZMG4fll8MhQ0suDgY4OiNBwhUkFNbsLOLpNjRbDijHg2LyJUP1F
         W5laPP4ymjkdVEbpY1zRPaSdLXbbq8Lo4pjFQ84DwvV3A/8/DjlHkFVpEGwChSaTl/fs
         dEdA==
X-Gm-Message-State: ACrzQf1F/FJ1/Kv9CaOf68WwhKuqaMrvrKWEDIdinB19gIn49WY9csrf
        WWdJLMfAIKFvwbzxVQ25Dsl3MuxbQ4qx5ibrX7dOtb4UpyA=
X-Google-Smtp-Source: AMsMyM4m1myiTvDwOzrvck//Wg05/NC3MMi+a1KNaAU13c6BxicLH27qNXmeVrDg4jVPM5wJUVs3p+ubk/boXSl7Kdk=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr156984oam.218.1664575873758; Fri, 30
 Sep 2022 15:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org> <YzdjHenrJpooKMjv@krava>
 <CAM9d7cjKaZvWQUwGwoTLNzAgHS7ndL_V_5+O+WqMUvuHJ7cWNg@mail.gmail.com> <88915C51-33CD-49A4-A9E0-F5F5ECDEA0C7@gmail.com>
In-Reply-To: <88915C51-33CD-49A4-A9E0-F5F5ECDEA0C7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 15:11:02 -0700
Message-ID: <CAM9d7ci4mvc1rsMyRbwH-i2=8XVsEAvkk5JXLMHmbV4nkbBYhQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 30, 2022 at 3:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On September 30, 2022 6:56:40 PM GMT-03:00, Namhyung Kim <namhyung@kernel.org> wrote:
> >Hi Jiri,
> >
> >On Fri, Sep 30, 2022 at 2:44 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>
> >> On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
> >> > The recent change in the cgroup will break the backward compatiblity in
> >> > the BPF program.  It should support both old and new kernels using BPF
> >> > CO-RE technique.
> >> >
> >> > Like the task_struct->__state handling in the offcpu analysis, we can
> >> > check the field name in the cgroup struct.
> >> >
> >> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> > ---
> >> > Arnaldo, I think this should go through the cgroup tree since it depends
> >> > on the earlier change there.  I don't think it'd conflict with other
> >> > perf changes but please let me know if you see any trouble, thanks!
> >>
> >> could you please paste the cgroup tree link?
> >
> >Do you mean this?
> >
> >  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> >
>
>
> Which branch and cset in that tree does you perf skel depends on?

I believe it's for-6.1 and the cset is in

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?h=for-6.1&id=7f203bc89eb66d6afde7eae91347fc0352090cc3

Thanks,
Namhyung
