Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D02272ACD
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgIUPz3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 11:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgIUPz3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 11:55:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA58C061755
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 08:55:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so11520751ljg.9
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlAO2f2MCbdMFYmuMR/JVAe3ADfPLwZDOazJ0JPDtY8=;
        b=X6obxRKeN8mR9RXp9MXChkD/M+vckq63Aq7SzA4AbmwqS/IV5RDlSeQScIvKUx90Yq
         egE3yRvoKY3/syMLF2edGesVcPB6irZi2K8o1J7gzKQQYLf/KoNbSLvEDwPRQ8Zm/SCT
         gq5vqLKF0gc7kMWfQqZL8aa0UB2Bz+NsoL8x+711eRc2LRrgrsg/Qn9SIOSuQ9Ca3Re+
         Gztcy1jkdpujzRW0mt7Jdz3Iu8Kp1XCbeD5DMLzyrhsRRCN2VL1v0le3b5DU/mAV5WTR
         X02fZxY1HAoBQI19wrg4qUPbFwT29TH7MY4J5mkMhi6z/F/8vW26DM+UxD+2RtSmOaVe
         uYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlAO2f2MCbdMFYmuMR/JVAe3ADfPLwZDOazJ0JPDtY8=;
        b=j8D/yibItg0FaOMdfa+65Kr+lyJjdWIJ4GU3zv/TVaF6tbvlHtBV9DP9nahHbEUFrL
         jEtnhDOu2A4CpG6ulFd7nuLrv+cnGHp7QzPaMrbp+tLyQYBqO3zs40LVWbGPT1ii6HK2
         9lXLIR1r1zN/yBI8oHJgHw4Fc2ElNZWtV1mfhuKWYAc22kDAvsPB9BUTerRtIJDH1ktB
         Iw5k849L3NtR/y2Hc2/OsGtuCgkIWCLFizN5RBaI2JgKTdFjncl3LfcJbdpDZE6gm9Hf
         RbpfLipNzv4SMAbK7S4nhwXMZt3rPjeBRusZBHE3CoTqVZrKpL6K6nBVeGbodDnjCima
         tbag==
X-Gm-Message-State: AOAM531QgF1h8gkUYmZw5mU4G8z5XWSU9iFf0SarULDUuuEJgpIAwEtR
        lU09/WaLHXBvarbiPwktFlh5eplZx9gAYC/TmuRAnw==
X-Google-Smtp-Source: ABdhPJzAzrg0an3L/O21olXYAkjIkNnbmJ64HN6mgah50aQ3PSN08J/FUDGQvp5j4/fAmKh3qQmu1dRpTCZjQgXqSpU=
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr116899ljc.192.1600703726805;
 Mon, 21 Sep 2020 08:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
In-Reply-To: <20200921080255.15505-1-zangchunxin@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Sep 2020 08:55:15 -0700
Message-ID: <CALvZod5JpEsmNvbaCMEfRMt83GbeLJk2oM0=siCj+aXEnxYh4Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Add the drop_cache interface for cgroup v2
To:     zangchunxin@bytedance.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 21, 2020 at 1:05 AM <zangchunxin@bytedance.com> wrote:
>
> From: Chunxin Zang <zangchunxin@bytedance.com>
>
> In the cgroup v1, we have 'force_mepty' interface. This is very
> useful for userspace to actively release memory. But the cgroup
> v2 does not.
>
> This patch reuse cgroup v1's function, but have a new name for
> the interface. Because I think 'drop_cache' may be is easier to
> understand :)
>
> Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 11 +++++++++++
>  mm/memcontrol.c                         |  5 +++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index ce3e05e41724..fbff959c8116 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1181,6 +1181,17 @@ PAGE_SIZE multiple when read back.
>         high limit is used and monitored properly, this limit's
>         utility is limited to providing the final safety net.
>
> +  memory.drop_cache
> +    A write-only single value file which exists on non-root
> +    cgroups.
> +
> +    Provide a mechanism for users to actively trigger memory
> +    reclaim. The cgroup will be reclaimed and as many pages
> +    reclaimed as possible.
> +
> +    It will broke low boundary. Because it tries to reclaim the
> +    memory many times, until the memory drops to a certain level.
> +

drop_cache is not really force_empty(). What is your use-case? Maybe
you can use memory.reclaim [1] for your use-case. It is already in
Andrew's tree.

[1] https://lkml.kernel.org/r/20200909215752.1725525-1-shakeelb@google.com
