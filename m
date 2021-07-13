Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF493C77F7
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMUaH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jul 2021 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhGMUaG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jul 2021 16:30:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D27C0613DD
        for <cgroups@vger.kernel.org>; Tue, 13 Jul 2021 13:27:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a18so52554854lfs.10
        for <cgroups@vger.kernel.org>; Tue, 13 Jul 2021 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDVcnWUCmKFgFt42Z0BstCmPPXwwhSiEhiVvSxMjimA=;
        b=gGWUKJ1/QgenvRKNsFA/kuTLwkZmnjUbKvkHw6Hb9aeF/y3rC4CapuK/JdpFMuw1Sf
         XwIJHgrRUcz4hL+muJYuC3WCP0VSU+GXiTlRPCy5233n4lTzBS3lJlade5HnVy8531og
         6Xi/Rol5DVgx2NaHFulwZjPFeEg0g3fYptl7fVMy3GOodBuVsSiHGD/dkf8T4whLLNYp
         D36hGi7QmxKTb2QbtBHjvrSKG80CZ5YDP0gEMBEpfHn0DoSxKXmOrVtm9RlojlL13t+v
         16SMl0zfZLA5lkfGEOFqPlgfe6R1pe5k2jYAqVXM0YwJiEIDPfNuLt3mLwmIIMxRQ8IE
         QB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDVcnWUCmKFgFt42Z0BstCmPPXwwhSiEhiVvSxMjimA=;
        b=GoOQHTZwAW845oaH3Yj/vbHa6hMCNaTfJKaBOCzee0Lp/mBLNT4tGe5dVzF/RJMTDj
         dR/lCe/OhO7gV95zTuyS3O34FOAEx/+EjlPU9l8ZXNKDhuPvwEWmwWC4yBzMOu4tgxbw
         nhK1NdDzMDikJaTSQ8UJ22BSufgdTAbCo7eIhP86vI7h4x9Tv15il1LUVz6fCo33/3i2
         5v8o7th5cpgyRrATKsGCynrS+1B/PQl8u9Rob4QCJDCItxjgE2iuzteheso6oUzMDyd3
         xLZO+GWc7xZJFoeCqj/JZ4eLtj146naRIPKgdNhl3Cx8+Ep3jR2ezPmJREXIjT5I+kYv
         fKGg==
X-Gm-Message-State: AOAM531BvKbSVNvLR/yKxizNTIX9GTextJ9Lan2PKZ9JYzjOut7JPGE0
        ts4d1NjKT5shm39chFoUZspbK3UBCpdvOdsqqXU9Kw==
X-Google-Smtp-Source: ABdhPJypAoGStqdoyPRQutNsnNe7ghH2ya92MNaOYt9mzbNtnwlCrOwGl9PbRkXmq4Ck30R0BdGl4VZ0c/9O4luKWmE=
X-Received: by 2002:a05:6512:687:: with SMTP id t7mr4852056lfe.347.1626208033194;
 Tue, 13 Jul 2021 13:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210713202412.248252-1-shakeelb@google.com> <20210713202412.248252-2-shakeelb@google.com>
In-Reply-To: <20210713202412.248252-2-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 13 Jul 2021 13:27:02 -0700
Message-ID: <CALvZod74cj6TOm3sXsnSOXnQeCfKonf=+DQFj92QhKq49ppr8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: infrastructure to flush memcg stats
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 13, 2021 at 1:24 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> At the moment memcg stats are read in four contexts:
>
> 1. memcg stat user interfaces
> 2. dirty throttling
> 3. page fault
> 4. memory reclaim
>
> Currently the kernel flushes the stats for first two cases. Flushing the
> stats for remaining two casese may have performance impact. Always
> flushing the memcg stats on the page fault code path may negatively
> impacts the performance of the applications. In addition flushing in the
> memory reclaim code path, though treated as slowpath, can become the
> source of contention for the global lock taken for stat flushing because
> when system or memcg is under memory pressure, many tasks may enter the
> reclaim path.
>
> This patch uses following mechanisms to solve these challenges:
>
> 1. Periodically flush the stats from root memcg every 2 seconds. This
> will time limit the out of sync stats.
>
> 2. Asynchronously flush the stats after fixed number of stat updates.
> In the worst case the stat can be out of sync by O(nr_cpus * BATCH) for
> 2 seconds.
>
> 3. For avoiding thundering herd to flush the stats particularly from the
> memory reclaim context, introduce memcg local spinlock and let only one
> flusher active at a time. This could have been done through
> cgroup_rstat_lock lock but that lock is used by other subsystem and for
> userspace reading memcg stats. So, it is better to keep flushers
> introduced by this patch decoupled from cgroup_rstat_lock.
> ---
> Changes since v2:
> - Changed the subject of the patch
> - Added mechanism to bound errors to nr_cpus instead of nr_cgroups
> - memcg local lock to let one active flusher
>
> Changes since v1:
> - use system_unbound_wq for flushing the memcg stats
>

Forgot to add v3 in the subject for this patch.
