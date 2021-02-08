Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD39A31410B
	for <lists+cgroups@lfdr.de>; Mon,  8 Feb 2021 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhBHU42 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Feb 2021 15:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhBHUy5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Feb 2021 15:54:57 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A019C06178A
        for <cgroups@vger.kernel.org>; Mon,  8 Feb 2021 12:54:16 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b14so2348961qkk.0
        for <cgroups@vger.kernel.org>; Mon, 08 Feb 2021 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcpftL0I3Yn/sC6LOBOo9QXXxpF9jls61Dh3UGgrMhQ=;
        b=XGEs+1RNC81c2udolSMD/41WbwHBvqroEIblFLM6gl9MVclTdONeCq1jP0jJVv3DW7
         dqvBGlfkyGoSaJOFPO4C+/KygXrMmF6GgeZV38oFelwD8bYgQ4Y9FaDxTNylaeEkxhxN
         9/wMWF5GLFfZLkCkBzWMoFr2YsBTvzztvlTODSSdkywa0ZqSPz7MMES7R4ORrBwmRXAa
         inRSRsCQhcz07fMpBpDsQUbvvWjmpmN/ObDNeouvOi73LV0BXKKTABmritwmYEUUmzuj
         N6MX+1gkgsjC7cBc8+SIZf6tPoSoD/WIgebrPDZfgKnsLOKOtM1fzFUShy4hNgpDqfjO
         8aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcpftL0I3Yn/sC6LOBOo9QXXxpF9jls61Dh3UGgrMhQ=;
        b=tGzgRI2mtGoVA2UUeaO8hbgHDxtDGLQlngQXr73bAECp0Np8CofC1fVWLegQa+heSk
         iQ7ASsiNv98/ACB88CPp+2H9YXMIiRgIi9q/cCKdKbiLZUm/sUmOtxryo9T+WmbPD5xV
         bEFhOV89ipimnChCHu3LhEwK5fpWYh0cyREKZ6TMeS7N2paNurH8GUV60zcTTISA9ect
         FKXIT1Yoygb5Z4HjOSaHY96yvwHuuIsIydSdAEAjuUnUaRMcb3S+uFkMedrdNVSP0wkC
         siwCznxcXuct2JbgcRx5kccoEBIV+KvtbalkusYffUtXR4j8GtzzPfpGrYAyv3CMxTh7
         Kbgg==
X-Gm-Message-State: AOAM531z0sKb148fU1yS3xD2wLyV5D0OGRkripBz1qoYnwWQA3Xb8JeB
        yWZ7tD72qhecxb3Frs0V/ddJkA==
X-Google-Smtp-Source: ABdhPJyVK62aBHf/AAc/vz/JS5ITM85XcG83LzKNHbywrxm4x9GiInjP9DCODQJEYHOwcUsfBKrnmA==
X-Received: by 2002:a37:4a91:: with SMTP id x139mr2049044qka.102.1612817655489;
        Mon, 08 Feb 2021 12:54:15 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 15sm14904060qty.65.2021.02.08.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 12:54:14 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:54:14 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YCGk9ksAU8+tBv5y@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
 <20210205182806.17220-8-hannes@cmpxchg.org>
 <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 07, 2021 at 06:28:37PM -0800, Shakeel Butt wrote:
> On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > There are two functions to flush the per-cpu data of an lruvec into
> > the rest of the cgroup tree: when the cgroup is being freed, and when
> > a CPU disappears during hotplug. The difference is whether all CPUs or
> > just one is being collected, but the rest of the flushing code is the
> > same. Merge them into one function and share the common code.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks!

> BTW what about the lruvec stats? Why not convert them to rstat as well?

Great question.

I actually started this series with the lruvec stats included, but I'm
worried about the readers being too hot to use rstat (in its current
shape, at least). For example, the refault code accesses the lruvec
stats for every page that is refaulting - at the root level, in case
of global reclaim. With an active workload, that would result in a
very high rate of whole-tree flushes.

We probably do need a better solution for the lruvecs as well, but in
this case it just started holding up fixing the memory.stat issue for
no reason and so I tabled it for another patch series.
