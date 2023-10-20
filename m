Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECFB7D14CA
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 19:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377939AbjJTRXe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377946AbjJTRXc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 13:23:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D7AD6E
        for <cgroups@vger.kernel.org>; Fri, 20 Oct 2023 10:23:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso11765ad.0
        for <cgroups@vger.kernel.org>; Fri, 20 Oct 2023 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697822609; x=1698427409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZExr3HakSu/t70XqjHC6rrKDB2IMk8Lwf9XEJ5+nuo=;
        b=CI82VHtcbHQz1eluwUb+gNbXVXCSsdxOESmINb/FvOWZ+zA/Ouuw2s6JcjSU0voXs8
         +W6POwmug/ybwurWHHa7HzNWPgf5Q2OL4piXwjh+4cliEZeKtVTVD0F9pkrF603Yd59J
         NK8T51kQ/2UGd9/gjI9ETIsC1SnXNuMs9Qct2Sk8oFNKodpUCQPZF2y9KcyQYa/eXFlO
         Dmkhdr2HaZ49iD4/Ndisy7tUI0G3EAr2aJGMb1yjvD7Plma124MDklD7ELrtJq/mFGk6
         tauF2Gko514Zg9jxDGHN2KKXp5IyQEhSOn6u1OSxcbAXUBg+WaPYeJ+INOGC6TvJylsh
         y7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822609; x=1698427409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZExr3HakSu/t70XqjHC6rrKDB2IMk8Lwf9XEJ5+nuo=;
        b=K03qHvr6mM8UejMzqj4S8W6SYPxigYpf0mAw8jffakclwacPJvQWwiiM6bMFr6hGPP
         ViEKHimARQgOeZI8P+WOB9rAxgRR2tosV/2Yaofy1zSXfoQghom+8U8X8HODBGoKy/y8
         h2iNitNQR4n9mLW/Tq1qgG69Imohg9CHUFVvvkFIm6ys/ZkOIOZPnyQYKKkk0qkn0IyK
         uLdjYCLiM1QaqDKa8ycH0y/+Yj5KR39v+SEtSkcTfFJJsLjJiJNZ0hcZ4McVUWmJFtxE
         U/UwCf+t0vKfOPhUGml8vX4P7t39hisnFgRN1NCCSBIloFmWH+wIDZAcVtLMKsyWgKrm
         8UOQ==
X-Gm-Message-State: AOJu0YwIiirDHDQO2itClZ+qyr2aPRJdT9P7Y347BpMCypgq3fX/igxO
        7JFmm6RZhkH73Lh5a0pUobH30/uFeGXzNbiscBjnOA==
X-Google-Smtp-Source: AGHT+IE6qIeeuEX5YH+y/z1n375Wnwum8Fvy1MQ/6ot9JPGuTfvhnYMSZC0YoAk+ckCivwMMP+8siHwBMoL3xRQ8aZ0=
X-Received: by 2002:a17:902:e949:b0:1c1:efe5:ccf8 with SMTP id
 b9-20020a170902e94900b001c1efe5ccf8mr256373pll.17.1697822608688; Fri, 20 Oct
 2023 10:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com> <202310202303.c68e7639-oliver.sang@intel.com>
In-Reply-To: <202310202303.c68e7639-oliver.sang@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 20 Oct 2023 10:23:16 -0700
Message-ID: <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 20, 2023 at 9:18=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -25.8% regression of will-it-scale.per_thread=
_ops on:
>
>
> commit: 51d74c18a9c61e7ee33bc90b522dd7f6e5b80bb5 ("[PATCH v2 3/5] mm: mem=
cg: make stats flushing threshold per-memcg")
> url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-=
change-flush_next_time-to-flush_last_time/20231010-112257
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everyth=
ing
> patch link: https://lore.kernel.org/all/20231010032117.1577496-4-yosryahm=
ed@google.com/
> patch subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold pe=
r-memcg
>
> testcase: will-it-scale
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
>
>         nr_task: 100%
>         mode: thread
>         test: fallocate1
>         cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
----------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -30.0% r=
egression |
> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory    =
          |
> | test parameters  | cpufreq_governor=3Dperformance                      =
            |
> |                  | mode=3Dthread                                       =
            |
> |                  | nr_task=3D50%                                       =
            |
> |                  | test=3Dfallocate1                                   =
            |
> +------------------+-----------------------------------------------------=
----------+
>

Yosry, I don't think 25% to 30% regression can be ignored. Unless
there is a quick fix, IMO this series should be skipped for the
upcoming kernel open window.
