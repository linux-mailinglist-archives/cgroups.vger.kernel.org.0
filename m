Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20995E5A0A
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 06:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIVEIO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 00:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiIVEHy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 00:07:54 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35783AF0D2;
        Wed, 21 Sep 2022 21:06:10 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11e9a7135easo12152435fac.6;
        Wed, 21 Sep 2022 21:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=siMkRhF/SLAewvNkB/FUmhDXG1LTV2qd6SPVClT7RXM=;
        b=C4mhES5BtjVJNUwSFQaZTZsj0CD4u9wtDykPtVeSPaNVsbEWNrn1BYPtLlZIbYDKaZ
         Qd8eGmfGlzPfW9Y3JCXkAlkYO6miiZFvy2I9Bw2qy2awCvlJ7RNTlgg0Pc7O+FGLnWOg
         3xxFgJJllc4QcqbquQbYcM+kGMk/PergZgCIa0ui84ijZElAX/1+18xsxnLIeDA9jfMu
         iR7CIkforn71dPL4nCcyQN9QH9AK+DNvXrLuym5+xAOfJDstP4gH9RX7c6uX/UzfF9gW
         UAjGgSs3lRlVCrWLaNGJV971mvxhB0O7TBje0PT2tQcTutU07oobpFjM/Do6WgGx/2eb
         fi/w==
X-Gm-Message-State: ACrzQf0CD6PRr9mlTyxVPNuGW0/CvwQYuo0p1pwBdgjhNfEBuOnhL1PG
        KTPqr2lTm9Y61H+r6s1YYImmBTHcpzE1QlzlYulVdSfX
X-Google-Smtp-Source: AMsMyM4y6qxzP6Yh1L9Q0h9wWC2dT6c/ICcvE7FfxlDfZYPCF7u7MfOowlgP/hMhzqyR2mupWed9yStTEMlJTwn1eAA=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr802693oai.209.1663819532230; Wed, 21
 Sep 2022 21:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <YuQvcCrcgNWbtndU@slm.duckdns.org> <YuRJ7uzKY5/fokH5@slm.duckdns.org>
 <YuRo2PLFH6wLgEkm@slm.duckdns.org> <Yvq33G14AU0cuswB@slm.duckdns.org>
In-Reply-To: <Yvq33G14AU0cuswB@slm.duckdns.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Sep 2022 21:05:20 -0700
Message-ID: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
Subject: Re: [PATCH v3 cgroup/for-5.20] cgroup: Replace cgroup->ancestor_ids[]
 with ->ancestors[]
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups <cgroups@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
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

Hi Tejun,

On Mon, Aug 15, 2022 at 2:17 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Jul 29, 2022 at 01:10:16PM -1000, Tejun Heo wrote:
> > Every cgroup knows all its ancestors through its ->ancestor_ids[]. There's
> > no advantage to remembering the IDs instead of the pointers directly and
> > this makes the array useless for finding an actual ancestor cgroup forcing
> > cgroup_ancestor() to iteratively walk up the hierarchy instead. Let's
> > replace cgroup->ancestor_ids[] with ->ancestors[] and remove the walking-up
> > from cgroup_ancestor().
> >
> > While at it, improve comments around cgroup_root->cgrp_ancestor_storage.
> >
> > This patch shouldn't cause user-visible behavior differences.
> >
> > v2: Update cgroup_ancestor() to use ->ancestors[].
> >
> > v3: cgroup_root->cgrp_ancestor_storage's type is updated to match
> >     cgroup->ancestors[]. Better comments.
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Applied to cgroup/for-6.1.

I've realized that perf stat change needs backward compatibility.
Will send a fix soon.

Thanks,
Namhyung
