Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD835C81D
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhDLOD7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhDLOD6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 10:03:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FAEC061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 07:03:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e14so8829720lfn.11
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Txa0jtEnzVHszI7+7RurZSdLkTftdeKdRRITuMLu8Aw=;
        b=PKU//OewynQNd7SeSC4KENGCXLIca0cApDWlmgkcNZDG1kpsbr0rPgil0AfgvOY6dl
         xyI6oUsEgz7I5NjvX0nmU5gKYvslpr/DlU2IIRtDHNsKTNj5mYTMWpVOpf0jlmmt/S1y
         CUUPJrpfVC9XLPr2/2KydVFWwL1JDLBVppMWOyO+Az5d4syy4eLTXKVvpJh2no8LrH7e
         ex2ev3hbHYWC5eF6K2hYH3cFW/+lq19/RnT0xtAF8Di+nXWZY6q/eFfZ0rQhHO906gw/
         8g5iI2BKxf1UF0j4bm0jF5b9TGq687Vz2mq2c0Pjjaq4ByhtTs/YAEQgxKfs2aA9Fml4
         jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Txa0jtEnzVHszI7+7RurZSdLkTftdeKdRRITuMLu8Aw=;
        b=dqFzYY6rDKgBFPozp5h9webNF3u/z7EEJXIfTuUxvYhJ4K3jCCnaltr94r49VqHemV
         v9b6Eb0wZcr1nGg071S+jcO7A5Tf9I1f5jMPfs12vLiz6NsgpO/w7Mxq2ZjMXmaM2CUn
         eJA0ndhW6BEAUH6fG03QOUlRDjr8uFY3uyYIEgUcYLGQWa0cTlL4UVVIuXZTfKY+aKYo
         pibAXrIj1mMTNHs8XfvVm4TiJVn21GE974M3PS/5oaMlNbzskxssitljozbC3z3CRMD5
         U0Xy8gfEiq8y8zgEzGEOLfY5j2qcsbX9JR2c8O/SFvnoarSZzJSmbhWbE6m2EpOY9stL
         76tg==
X-Gm-Message-State: AOAM532lBFARvt5sqMQ2uAA9ajgHPwJBmW1NLG8AjWlkwb3NzJCect9h
        FdgLj4BZ66RRhkaKfLMkyV1GdgtTtCRjngDtBLNQNQ==
X-Google-Smtp-Source: ABdhPJwdMgH1vZSbLM2ftjQCiG02Bjb8iz3/wBlG8KsX8dUvbr+SMIdSWmWYv9eRFDg9nnny7qYgsT+gUxtHK7Iklhc=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr4490386lfn.299.1618236219038;
 Mon, 12 Apr 2021 07:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
 <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
 <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com> <CAHbLzkoce41b-pJ5x=6nRhex_xBdC-+cYACBw9HKtA87H71A-Q@mail.gmail.com>
In-Reply-To: <CAHbLzkoce41b-pJ5x=6nRhex_xBdC-+cYACBw9HKtA87H71A-Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 07:03:27 -0700
Message-ID: <CALvZod4vYiT-OnQ8gmhs+NurMV+kSFptMig4FJS7RAAcJJeDNA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Yang Shi <shy828301@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 1:50 PM Yang Shi <shy828301@gmail.com> wrote:
>
[...]

> >
> > The low and min limits have semantics similar to the v1's soft limit
> > for this situation i.e. letting the low priority job occupy top tier
> > memory and depending on reclaim to take back the excess top tier
> > memory use of such jobs.
>
> I don't get why low priority jobs can *not* use top tier memory?

I am saying low priority jobs can use top tier memory. The only
difference is to limit them upfront (using limits) or reclaim from
them later (using min/low/soft-limit).

> I can
> think of it may incur latency overhead for high priority jobs. If it
> is not allowed, it could be restricted by cpuset without introducing
> in any new interfaces.
>
> I'm supposed the memory utilization could be maximized by allowing all
> jobs allocate memory from all applicable nodes, then let reclaimer (or
> something new if needed)

Most probably something new as we do want to consider unevictable
memory as well.

> do the job to migrate the memory to proper
> nodes by time. We could achieve some kind of balance between memory
> utilization and resource isolation.
>

Tradeoff between utilization and isolation should be decided by the user/admin.
