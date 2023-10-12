Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4C7C785D
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442372AbjJLVGO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442643AbjJLVGN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 17:06:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D29C0
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 14:06:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso547366366b.0
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697144770; x=1697749570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+qU6BUc+Yf/LfU49BhL9yi5ulNhXzI9oQByMXuhbEg=;
        b=0m+gXYYDkFe14NmT4YPiXVLt4L/kvFGgiMzyKP8SQ8MD52objZpTGbOqyQSAFHy6xf
         sIzXV+OHcDRVggQFzx5V4Yd6RPX4lvOFVCjJVL7PCPlJloUHR33ZX8ApG/IEjXAk1nKR
         PDErzQF9doM0mqxnqevDtiRoM8kMqDmKQLyp/xbQmIiSMaGwg+uvmeKXRg23CcH+hmzu
         ThWtvwFyZCmtIwCipkTSjNJfbuNLhtvEVf9N7aNl6Jsj5sa7RqNOjajkQ5dpItgz5NxE
         hlo3S27B+vInT63nx1XRJRPeVHGIlFEtCnK098rTpbXkDbaNgdXYkPiyaGEP14/p4Dyv
         YYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144770; x=1697749570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+qU6BUc+Yf/LfU49BhL9yi5ulNhXzI9oQByMXuhbEg=;
        b=Wf7eVQtneSSQ9j/qDT/kSUGqK9iHtdJtKApIRrCFCAn5mk+PDiVcqIT5zL9Icqd7co
         68SXlAU2AvWFHsLdYPYwKg2ZWIB3UN9NeSYJ33dn9inir66HyS1DHl10Jm9VHdmIT3HU
         50d2ks/bnoXGJPv7axTNWQ3k8wLKFDIrbuAhpPkx5dgMlnHGIsMdn++2jhiGI1Tc4q+O
         3minhoJtxjemkhBDAEHlk3QqEmixIUtHMHw7P+a/TzCOXzUEaMGsWtwEl5FsYSLpeN9l
         MxKoMV7vJp+5IF79z99Fu7aHP1vF9gMpMuXESKr1rklAY50QyhojfFn1M6x2wD54R7/u
         skcA==
X-Gm-Message-State: AOJu0YypKGSSj7pHT6aKe6plR6vlJYwc0UKrCCEvcPOvEunQAYvDxWEK
        APBQs/gLRhNi1Kc+/5KlkQEHg0/zd+yLfsVPfpDemQ==
X-Google-Smtp-Source: AGHT+IEMEev1fCcpfuV8sPYSsL+tp51FurlzcduDBSyW680ptIpoot7s6rm+mhDt5HS2vIKEyVOU5nII/oglFVQ0YlM=
X-Received: by 2002:a17:906:fe08:b0:9a1:e0b1:e919 with SMTP id
 wy8-20020a170906fe0800b009a1e0b1e919mr20987908ejb.4.1697144769713; Thu, 12
 Oct 2023 14:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com> <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
In-Reply-To: <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 14:05:30 -0700
Message-ID: <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[..]
> > > >
> > > > Using next-20231009 and a similar 44 core machine with hyperthreading
> > > > disabled, I ran 22 instances of netperf in parallel and got the
> > > > following numbers from averaging 20 runs:
> > > >
> > > > Base: 33076.5 mbps
> > > > Patched: 31410.1 mbps
> > > >
> > > > That's about 5% diff. I guess the number of iterations helps reduce
> > > > the noise? I am not sure.
> > > >
> > > > Please also keep in mind that in this case all netperf instances are
> > > > in the same cgroup and at a 4-level depth. I imagine in a practical
> > > > setup processes would be a little more spread out, which means less
> > > > common ancestors, so less contended atomic operations.
> > >
> > >
> > > (Resending the reply as I messed up the last one, was not in plain text)
> > >
> > > I was curious, so I ran the same testing in a cgroup 2 levels deep
> > > (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> > > experience. Here are the numbers:
> > >
> > > Base: 40198.0 mbps
> > > Patched: 38629.7 mbps
> > >
> > > The regression is reduced to ~3.9%.
> > >
> > > What's more interesting is that going from a level 2 cgroup to a level
> > > 4 cgroup is already a big hit with or without this patch:
> > >
> > > Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> > > Patched: 38629.7 -> 31410.1 (~18.7% regression)
> > >
> > > So going from level 2 to 4 is already a significant regression for
> > > other reasons (e.g. hierarchical charging). This patch only makes it
> > > marginally worse. This puts the numbers more into perspective imo than
> > > comparing values at level 4. What do you think?
> >
> > This is weird as we are running the experiments on the same machine. I
> > will rerun with 2 levels as well. Also can you rerun the page fault
> > benchmark as well which was showing 9% regression in your original
> > commit message?
>
> Thanks. I will re-run the page_fault tests, but keep in mind that the
> page fault benchmarks in will-it-scale are highly variable. We run
> them between kernel versions internally, and I think we ignore any
> changes below 10% as the benchmark is naturally noisy.
>
> I have a couple of runs for page_fault3_scalability showing a 2-3%
> improvement with this patch :)

I ran the page_fault tests for 10 runs on a machine with 256 cpus in a
level 2 cgroup, here are the results (the results in the original
commit message are for 384 cpus in a level 4 cgroup):

               LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
------------------------------+-------------+-------------+-------------
  page_fault1_per_process_ops |             |             |            |
  (A) base                    | 270249.164  | 265437.000  | 13451.836  |
  (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
                              | -3.29%      | -3.66%      |            |
  page_fault1_per_thread_ops  |             |             |            |
  (A) base                    | 242111.345  | 239737.000  | 10026.031  |
  (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
                              | -2.09%      | -1.85%      |            |
  page_fault1_scalability     |             |             |
  (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
  (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
                              | -1.16%      | -1.69%      |            |
  page_fault2_per_process_ops |             |             |
  (A) base                    | 203561.836  | 203301.000  | 2550.764   |
  (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
                              | -3.13%      | -2.73%      |            |
  page_fault2_per_thread_ops  |             |             |
  (A) base                    | 171046.473  | 170776.000  | 1509.679   |
  (B) patched                 | 166626.327  | 166406.000  | 768.753    |
                              | -2.58%      | -2.56%      |            |
  page_fault2_scalability     |             |             |
  (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
  (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
                              | -1.29%      | -1.41%      |            |
  page_fault3_per_process_ops |             |             |
  (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
  (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
                              | -1.56%      | -1.86%      |            |
  page_fault3_per_thread_ops  |             |             |
  (A) base                    | 391234.164  | 390860.000  | 1760.720   |
  (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
                              | -3.58%      | -3.71%      |            |
  page_fault3_scalability     |             |             |
  (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
  (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
                              | +2.26%      | +2.45%      |            |

The numbers are much better. I can modify the commit log to include
the testing in the replies instead of what's currently there if this
helps (22 netperf instances on 44 cpus and will-it-scale page_fault on
256 cpus -- all in a level 2 cgroup).
