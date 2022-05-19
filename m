Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F30252DCA8
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbiESSXa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241996AbiESSX3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 14:23:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273844A0C
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 11:23:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so8310989wrg.12
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69aaD4QPBI9GdAKDBus5t7k/zTxSvsdipve2TR2Ob64=;
        b=GkrWqpjb2yzPqkTVz9B3AF1h6LM7P8OXxi4jhC4daSBHKirsPkAj/SnhCBRObr6hEA
         WiRe4Wva0Ozk3jVncq2kBHskGsms1JYwqHmXoWzPjEPybLXpd46qdKbASSPGfdxi63vy
         LJQH7E7ZG4EQo1NMjCDQ0C21BbsohR5OpwSvd5tXaRitjNYoejlK5W2ozBG9NWI+9HsO
         5EE6MfloqEZZ2bWuw2IDjRbqk6NiHnUWnmQgkFaiD6UyO98KHexuzXwqXY6gYRjB37Lv
         EhtgEtqHenGlbGslS2t3DXNV3YJTqWgMMvu0VwKxEOxEdNtIkE+6JtzxqyJGaKb+J7tA
         hXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69aaD4QPBI9GdAKDBus5t7k/zTxSvsdipve2TR2Ob64=;
        b=eZ2++GGycwXr/z7zhBEy+rSaNELYAc1shqiWXlw1kPLF3hVxf6b3+9/gKJVdBdF+0/
         kvaTRNPAoOmQVFHZ/BRikIENzseLwMz91jS/+hOqC6vSUamkCXDApNtUiwD5pWkGeD41
         s77KvnwutzZ5cVMzgt7OcQcM6OaholJxWeXUkrttNX1+hikQsN9Xlw7ZFMo5JNgdlJ1R
         4+2JgCfx0lcksmhc4Qvq00KgZi6KrIZo2cyJw1Nl9OsG5lgBw7HqWpU6uD/iDdUbzxUg
         HfgStWnJQAugi7vjJ01iqeowcfxvS2ueb2/xSYGyJrQ0s7VW/dGVtH+GuIArSIC9DN2S
         03Bw==
X-Gm-Message-State: AOAM5337OS8GhJTDvVCRUqj5+57AHZF0FO4qWybJgDxCsBB1pCXSQsf6
        Nr5rH0rSPpjGUqdKGJMI8XB5At2o8FJOSa4P9F3MY0qBm1i2aw==
X-Google-Smtp-Source: ABdhPJzgiRnXFN6S2gC1fKKXjzhLgZufzaMOa157G/FFVNR/qTjRPbeyyLcMCUrWvBY7gjwJ1/H59Sfaq//qqD7qEOk=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr5325035wrr.534.1652984605773; Thu, 19
 May 2022 11:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <CAJD7tkZSgRs6T60Gv4dZR5xBemxgCB_2s8hz8zB0F_nakN5aTQ@mail.gmail.com> <878rqxhpn1.fsf@vajain21.in.ibm.com>
In-Reply-To: <878rqxhpn1.fsf@vajain21.in.ibm.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 19 May 2022 11:22:49 -0700
Message-ID: <CAJD7tkb+MESXcx4P5VfJqWfdQRbDD+FJ1o5vUtvomqJ-T9BGcw@mail.gmail.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
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

On Thu, May 19, 2022 at 1:51 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Hi,
>
> Thanks for looking into this patch,
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Wed, May 18, 2022 at 3:38 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
> >>
> >> [1] Provides a way for user-space to trigger proactive reclaim by introducing
> >> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
> >> of pages scanned and reclaimed is still not directly available to the
> >> user-space.
> >>
> >> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
> >> readable which returns the number of pages scanned / reclaimed during the
> >> reclaim process from 'struct vmpressure' associated with each memcg. This should
> >> let user-space asses how successful proactive reclaim triggered from memcg
> >> 'memory.reclaim' was ?
> >
> > Isn't this a racy read? struct vmpressure can be changed between the
> > write and read by other reclaim operations, right?
> Read/write of vmpr stats is always done in context of vmpr->sr_lock
> which is also the case for this patch. So not sure how the read is racy
> ?.

I didn't mean that you can read the value while it is being changed. I
meant that between writing to memory.reclaim and reading from it,
another reclaim operation could modify memcg vmpressure. A sequence
like this:
1) Write to memory.reclaim
2) Kernel coincidentally runs reclaim on that memcg
3) Read from memory.reclaim

The result would be that you are reading the stats of another reclaim
operation, not the one invoked by writing to memory.reclaim.

>
> >
> > I was actually planning to send a patch that does not updated
> > vmpressure for user-controller reclaim, similar to how PSI is handled.
> >
> Ok, not sure if I am inferring correctly as to how how that would be
> useful. Can you please provide some more context.

IIUC vmpressure is used as an indicator for memory pressure. In my
opinion it makes sense if vmpressure is not changed on reclaim
operations directly invoked by the user, as they are not directly
related to whether the system is under memory pressure or not. PSI is
handled in a similar way. See e22c6ed90aa9 ("mm: memcontrol: don't
count limit-setting reclaim as
memory pressure").

>
> The primary motivation for this patch was to expose the vmpressure stats
> to user space that are available with cgroup-v1 but not with cgroup-v2
> AFAIK

If the main goal is exposing vmpressure, regardless of proactive
reclaim, this is something else. AFAIK vmpressure is not popular
anymore and PSI is the more recent/better indicator.

>
> > The interface currently returns -EBUSY if the entire amount was not
> > reclaimed, so isn't this enough to figure out if it was successful or
> > not?
> Userspace may very well want to know the amount of memory that was
> partially reclaimed even though write to "memory.reclaim" returned
> '-EBUSY'. This feedback can be useful info for implementing a retry
> loop.
>
> > If not, we can store the scanned / reclaim counts of the last
> > memory.reclaim invocation for the sole purpose of memory.reclaim
> > reads.
> Sure sounds reasonable to me.
>
> > Maybe it is actually more intuitive to users to just read the
> > amount of memory read? In a format that is similar to the one written?
> >
> > i.e
> > echo "10M" > memory.reclaim
> > cat memory.reclaim
> > 9M
> >
> Agree, I will address that in v2.
>
> <snip>
>
> --
> Cheers
> ~ Vaibhav
