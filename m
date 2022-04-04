Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0296E4F11A9
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 11:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiDDJJz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244472AbiDDJJy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 05:09:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B113BA61;
        Mon,  4 Apr 2022 02:07:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 85so7057106qkm.9;
        Mon, 04 Apr 2022 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bEukbCR9Nhs/phBw9CHkxQ3EgSEHMJ/cxKPyV/U1Lc=;
        b=J5KW87ePrm1kVWM8zimS7BHw2Mzubr83uLPX1ZBEuTOjvvs+UkzK/GsTYtS+rkeeh6
         Ge2jgAndu7+Zy91oVbelB/tQnEdNrikZagGfuskZmImTjrfeZFKVfsqjT4l6uBHJSGVZ
         VY7S7PBo+y7RdG666XUW2bx1aEo7G3ouf2K51+rUsGOhwYYyquxLNq9RdgI6zt+EI6Oq
         QogUEwbMxBtv/3Hc+6E7ikZQLShJTywcEZtzSZ40mqOmq5LwKkAGxigcH/x8JoioykXi
         D2BAEjI17KvY0X1MbUap3yVxXSGf+QKh6gAAsi1h7CMfZADAjRdbrxbuASmFKV+ZXIG/
         gb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bEukbCR9Nhs/phBw9CHkxQ3EgSEHMJ/cxKPyV/U1Lc=;
        b=H4MVPRHZpoZkOQgT7Fhaa1Rt7ZKwHQoVYSuvI/MzfOgPoCUCtWoedhLCjcIHK2UvZn
         FFo6VPNUn1+HghjFfgooWer0TcmLIIu5TlwUQuSnP1/fWu9WgTvlXNynJREobB3WjxGx
         2geSWQ7d6iYeqIU0OkuwG8ahNzOVe26XLrE5H13S27tXyu6Et9TUKlzq6XIt2Wack4t/
         KVDIYipR24ADFQRxE2+LI455QTtJqyeDggYxnrL8PgyTcm9xwQ8DUKhRTITvnQL1QGYK
         gGlNQ9i7k4hvx5CtIQbHbjc0IxzisCr7EBTmdbWs9JOv82fxpF7NmfQ2p69zNYs2chNQ
         C74Q==
X-Gm-Message-State: AOAM530yn+s7L3M8Gn31G1uvY+AOhKky0KVM5UsClMM29v3qfDN0Wy8n
        ZYBeSjN0NLnNaxsvM+15EEpKUXtGWlso0myLDYcscShav4dA7A==
X-Google-Smtp-Source: ABdhPJzxhreJVMKs5S5FdXqt1xixG6+tcI/PtSb1hJfCARG67fDZF716ric68cm5HwCcmcK69tuvoAk4ghPFTca0/L0=
X-Received: by 2002:a05:620a:108f:b0:67b:465f:56ba with SMTP id
 g15-20020a05620a108f00b0067b465f56bamr13401510qkk.297.1649063277536; Mon, 04
 Apr 2022 02:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz> <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com> <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
In-Reply-To: <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 4 Apr 2022 17:07:30 +0800
Message-ID: <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> [...]
> > > One thing that I don't understand in this approach is: why memory.low
> > > should depend on the system's memory pressure. It seems you want to
> > > allow a process to allocate more when memory pressure is high. That is
> > > very counter-intuitive to me. Could you please explain the underlying
> > > logic of why this is the right thing to do, without going into
> > > technical details?
> > What I want to achieve is make memory.low be positive correlation with
> > timing and negative to memory pressure, which means the protected
> > memcg should lower its protection(via lower memcg.low) for helping
> > system's memory pressure when it's high.
>
> I have to say this is still very confusing to me. The low limit is a
> protection against external (e.g. global) memory pressure. Decreasing
> the protection based on the external pressure sounds like it goes right
> against the purpose of the knob. I can see reasons to update protection
> based on refaults or other metrics from the userspace but I still do not
> see how this is a good auto-magic tuning done by the kernel.
>
> > The concept behind is memcg's
> > fault back of dropped memory is less important than system's latency
> > on high memory pressure.
>
> Can you give some specific examples?
For both of the above two comments, please refer to the latest test
result in Patchv2 I have sent. I prefer to name my change as focus
transfer under pressure as protected memcg is the focus when system's
memory pressure is low which will reclaim from root, this is not
against current design. However, when global memory pressure is high,
then the focus has to be changed to the whole system, because it
doesn't make sense to let the protected memcg out of everybody, it
can't
do anything when the system is trapped in the kernel with reclaiming work.
>
> > Please refer to my new version's test data
> > for more detail.
>
> Please note that sending new RFCs will just make the discussion spread
> over several email threads which will get increasingly hard to follow.
> So do not post another version until it is really clear what is the
> actual semantic you are proposing.
ok, I will hold until all question done.
>
> --
> Michal Hocko
> SUSE Labs
