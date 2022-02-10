Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433D4B180E
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiBJWWt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 17:22:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiBJWWt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 17:22:49 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE710BB
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 14:22:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i34so13117352lfv.2
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwpOdgFQsH734At37yjdv4Nb0bvjgu3SgbDAbXyvUB4=;
        b=fI0xbKcdzpA+8Va5155Mdfuw440giBRX8QLLR8+CLcUsOBdRYP4z5OQCb57mF1a8N6
         t4s6l4rmrsyAyL1hj58kI/rAt3V/SV8/lSX51xzZhhhpDCqA409AECsie1YGy4IeHGLE
         +GVtYOgiHoGkj9QW0fe8XD1crWNgUuUWYkRV89jW49qmBY2DLgAVREQwkcLu3xvYYS9r
         kgPtnyKJRn30npoDJjXj4RnYDRe+JgEthHfR2mGk6dY1Mcg5fOQAR3nblzbsl3+Mdw+7
         HYI9DpKPo3laQm7w7tXBN9WHS9Ql//I9J2NxCSL2J+brvwZ7zgOSXv0otFoAhUzNRBlM
         BG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwpOdgFQsH734At37yjdv4Nb0bvjgu3SgbDAbXyvUB4=;
        b=34LjcFFl2AMucQrfQBwWjr2sLgc510j5ilqdaYDU0IMwGbwQ4ab3KkZf1q36rggqKg
         ug09quznR+bui8N4giQr1aseVE35sM9kd1S4SAnUOOD/G40tGy7VlwBHzLDNDCPL5c73
         B5+lxDwhRMF1rNy5gJs9aZNq9ZXKhUX9I0VnQDMRgaVPbAd1BKC2NLtsf4kLv2G2Snxb
         PkZD5msq608fWJuUZp4zdXcUVbEpiHerST7jGgviiz6xNU2ui0tFWN0zqv7X4QE5kGeW
         IMHZQuJPvBTOQs+JiUFzdUxxbIaJ/vw4rwtsunUlPdKbJJRS/0g+sarNx7+4kFemH4di
         1OGQ==
X-Gm-Message-State: AOAM5303bS6nInsW1bIoLONFx0AGDPZba3I7WH3raGt2GoTztZVkx0an
        YUzPr03IHMnOIwkMR103TCLUKn8yQHeR7sphdxFhK8EyT3Y=
X-Google-Smtp-Source: ABdhPJz3n2/MNQsc8l0zgRAoXCBWTnu0KCr4v87xDGQiIoKz3e1x0R0A09Vnlf+JoKpSRstq0zNn8mmNb53j/3k3w/4=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr6280877lfv.184.1644531767275;
 Thu, 10 Feb 2022 14:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com> <20220210081437.1884008-5-shakeelb@google.com>
 <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
In-Reply-To: <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Feb 2022 14:22:36 -0800
Message-ID: <CALvZod5xFmCVV_AZO1be8pYakmDvYh-QXmNYtTNT4zvCw-m4bQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg: synchronously enforce memory.high
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Feb 10, 2022 at 12:15 PM Roman Gushchin <guro@fb.com> wrote:
>
[...]
>
> Has this approach been extensively tested in the production?
>
> Injecting sleeps at return-to-userspace moment is safe in terms of priority
> inversions: a slowed down task will unlikely affect the rest of the system.
>
> It way less predictable for a random allocation in the kernel mode, what if
> the task is already holding a system-wide resource?
>
> Someone might argue that it's not better than a system-wide memory shortage
> and the same allocation might go into a direct reclaim anyway, but with
> the way how memory.high is used it will happen way more often.
>

Thanks for the review.

This patchset is tested in the test environment for now and I do plan
to test this in production but that is a slow process and will take
some time.

Let me answer the main concern you have raised i.e. the safety of
throttling a task synchronously in the charge code path. Please note
that synchronous memory reclaim and oom-killing can already cause the
priority inversion issues you have mentioned. The way we usually
tackle such issues are through userspace controllers. For example oomd
is the userspace solution for catering such issues related to
oom-killing. Here we have a similar userspace daemon monitoring the
workload and deciding if it should let the workload grow or kill it.

Now should we keep the current high limit enforcement implementation
and let it be ineffective for some real workloads or should we make
the enforcement more robust and let the userspace tackle some corner
case priority inversion issues. I think we should follow the second
option as we already have precedence of doing the same for reclaim and
oom-killing.

thanks,
Shakeel
