Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38E2E2255
	for <lists+cgroups@lfdr.de>; Wed, 23 Dec 2020 23:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgLWWIy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Dec 2020 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLWWIx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Dec 2020 17:08:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6BC06179C
        for <cgroups@vger.kernel.org>; Wed, 23 Dec 2020 14:08:13 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s26so738343lfc.8
        for <cgroups@vger.kernel.org>; Wed, 23 Dec 2020 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoQlpaNI1/l22p0KY/MaQ96Dou9p/HLpoR9DVa4LJh8=;
        b=giGTxA/mxQx+XNfe8QbMHFkMxauB+o9JgajRnbIVQvV2WUIsFUTtYQiZimQfDBK4Si
         AueOX8SxNXBi/ULV8E5WHBMbPVvm4KL2Xf3G7gUH2RlljAPls4Gg7nODbKM1xcqER6cX
         a0MgrXFP51furYSyTt8rCXnmWC0s2wGW7AiJRcPYcknhrh70u2WQRz9FRotvdlwfOsae
         463WoX6OLSTIdNM88A2GE2UO76k+JjJ5+1vj/d6qYCbfpkc3l+eEkk4eSx1yyx0YMPKV
         6f2J8wtixvO9Pg5Xmn0vpCr09CuRdNN2E9buWaf55xaky+TKUJAzS7ERK2fdHzdYU4p8
         sC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoQlpaNI1/l22p0KY/MaQ96Dou9p/HLpoR9DVa4LJh8=;
        b=kOwbYHb2U7YSVuWdKIiraE4ZxU8qRi7sRM3RwP2dtHh6sQtXKK8YSSZEXGbn8uYxt2
         5W3T+E9MvEDwaSuH2C0jtbsaPVAJL6K6k/28QEOzgQEY63ymkqez5SpGG4XFcQDj0I8l
         9A54ofw/6Om0dnntzqGK0/k0YJc98Xissl7Yq/FY25GYKTaMEQzcQ9fksHLkV2FKDIfv
         yNbKyBzUoEBZo+a8NKaR3PFGYHqMsaJPutO0O0HA3e89fBhOryRDopaDOK/Vrrig0hzn
         FZz23zkQfcFoA0FRHJtK9EgGyasSwowNjOcQuXDfGoNmtoYLPFzjAtLA8Nh0w4dJJqRx
         dVTA==
X-Gm-Message-State: AOAM5327r5WAIGqRBE5bnlsUpTnkwFlrmlz29TnlzXCqzV4Il2YHdPEM
        dJhzyyhItIDFmmVce4YLOHwQIMlpwdaCneocYgmzww==
X-Google-Smtp-Source: ABdhPJwItxbkVp5l3S4sVv5L5p6m6OcrDlyJ9HNCuUjJgAORrTajFEr+f7dOofD6bYEpqh2xngBMcGIYlMA35D31J2c=
X-Received: by 2002:ac2:46d4:: with SMTP id p20mr11022767lfo.299.1608761291314;
 Wed, 23 Dec 2020 14:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20201217034356.4708-1-songmuchun@bytedance.com> <20201217034356.4708-3-songmuchun@bytedance.com>
In-Reply-To: <20201217034356.4708-3-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 14:08:00 -0800
Message-ID: <CALvZod7kMhb7k6rDZj18JTE=RMji-SinJmfdcPbN9PUL9Off_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mm: memcontrol: convert NR_ANON_THPS account to pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 16, 2020 at 7:45 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Currently we use struct per_cpu_nodestat to cache the vmstat
> counters, which leads to inaccurate statistics expecially THP

*especially

> vmstat counters. In the systems with hundreads of processors

*hundreds

> it can be GBs of memory. For example, for a 96 CPUs system,
> the threshold is the maximum number of 125. And the per cpu
> counters can cache 23.4375 GB in total.
>
> The THP page is already a form of batched addition (it will
> add 512 worth of memory in one go) so skipping the batching
> seems like sensible. Although every THP stats update overflows
> the per-cpu counter, resorting to atomic global updates. But
> it can make the statistics more accuracy for the THP vmstat
> counters.
>
> So we convert the NR_ANON_THPS account to pages. This patch
> is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
> on compound page arrival"). Doing this also can make the unit
> of vmstat counters more unified. Finally, the unit of the vmstat
> counters are pages, kB and bytes. The B/KB suffix can tell us
> that the unit is bytes or kB. The rest which is without suffix
> are pages.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I agree with the motivation behind this patch but I would like to see
some performance numbers in the commit message. We might agree to pay
the price but at least we will know what exactly that cost is.
