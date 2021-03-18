Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4A340951
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCRPx5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhCRPxs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Mar 2021 11:53:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97474C06175F
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 08:53:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o10so5341018lfb.9
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pq/eBnxufGHS03GB6g8W63yjQMuRCa5QlbRp3PwKUEw=;
        b=bgdV4hZplv+94CUHWEbu9IHkjeAlUPO8LEb5m90TFIXf2m9HsOiO9yTkUsNDIdAL/2
         rBZTdVoEZ257H5o2v1HojtAp7qwdrf7q6Ii2ntKX7WkOrgSD01JG2StigU5YHcWoqSJZ
         bTXqHezszXCYygdvLZ/D4lwuJVAa88DpyGrABJ/xN9LlrHbBIre4dBG8nHgZCCo7PWaS
         YykPvxidGKJ7WFvtyyCMDgKpOdLSC7cUPueTA3LN63sNMlGVX/MIeRRWbisyCFlEdCpG
         VXqLfvbBzVRVVJY9HgvpGs9mCleH1KBcPG9F1+PKCOZB9CKurbXljzRWCaGovWH1biG9
         +hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pq/eBnxufGHS03GB6g8W63yjQMuRCa5QlbRp3PwKUEw=;
        b=oKY0UQkuxN7GcKAIxfHQ3o6/0tzVfuEKTuLeyiusCMKHJaIPZ0K2M/ZZDGVY46KJ94
         Hch8i1AOyyLF6spT7mxthh5qXPkDoKRGILvtDJdFhJMgYHFziI5utSQYgnmoEa7GZUC/
         yFut8TW3Ltevbnde5YH4UK7mB68oHJB7JzSlKl4CjfsMO9Tge9pBrklkmpL9ojc7WfSN
         vpEhGFHhK1QKSz3TurPusLMxMZXt3lu0gI7EpQJPeVDyMUszJ2jsgxjx0E1evh/pSiKy
         rd06vZi6VBEPWnZYba8H6Oz2DHgc34+NsWdv+OBaGpfULTOAiOqh+1tY86kRTz4LQCLq
         ADEA==
X-Gm-Message-State: AOAM531msRiPAhVtkwhO/lQfoJplkUfRL2XpUu+rDXd7CgiGVT6lAEWJ
        SMRnTWpHy6cgpUey4yTb6UvMVDfNVjNakyv3nyyLPQ==
X-Google-Smtp-Source: ABdhPJxEgWeS33XZh839tg6ABZ5gTUZAm8ikQzXDtakEINgKM9uy1FMacx7hcnhzqgiPX7UJktfr+qQJhl78XhvdRtk=
X-Received: by 2002:a19:3804:: with SMTP id f4mr5990396lfa.117.1616082825932;
 Thu, 18 Mar 2021 08:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
In-Reply-To: <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 08:53:32 -0700
Message-ID: <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 17, 2021 at 3:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/16/21 9:36 AM, Dan Schatzberg wrote:
> > No major changes, just rebasing and resubmitting
>
> Applied for 5.13, thanks.
>

I have requested a couple of changes in the patch series. Can this
applied series still be changed or new patches are required?
