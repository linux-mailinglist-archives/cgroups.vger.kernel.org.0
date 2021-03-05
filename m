Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D017C32F03C
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhCEQm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 11:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhCEQmO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 11:42:14 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B368C061756
        for <cgroups@vger.kernel.org>; Fri,  5 Mar 2021 08:42:14 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e2so3556090ljo.7
        for <cgroups@vger.kernel.org>; Fri, 05 Mar 2021 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Idz6IhNVmVDwrmS9eS02rzcFdMoaAKDHYFFgO5wjPbU=;
        b=O2TrIrVFHinCDdMspBfmxsGMiJUlgXCqYQ5/0BckQ2Iqy1homQEhVrIQ0XJsIYpaiW
         +YcSkkOPteNMhOlE5U2GaaBp/HMTEYNawtAoNNIkRe/tsVEzJ4PZB1KAAThN973pDjue
         IjS6Zw/SOn6Xkj9MzXByMZP+d6xnuMFtlm3qOV4cT/bLE9T0j7pRISgBlXx8E+WEG+s0
         Ikc8YL/wTRFWi8DIjOcRUcsXe4QWct1oDvtVTIFV9IFP20cP91zKojuI6/SOhAOV27bO
         G/2Lnq7h5vsbliyITp9Bs3FcRyDoP2/5N+/HduaduYJDav5igamHgTT/8kSXaey2iA37
         KhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Idz6IhNVmVDwrmS9eS02rzcFdMoaAKDHYFFgO5wjPbU=;
        b=PAxJNCTra6x7Iup6EfUQyxt+o65Ag0vTQNCFlAR0dTnsu9nKJfZwSW+twmzhNk44vc
         cdvCez991RW0lTWCIOL+SqpP/x0arSLmFqxIdxd4/S8hcZyYX/O4rNsncvKWbE0VcADs
         PPK7v0jr3ympZ/rs+1XWLtXpJ/PAH22vNrcf463uLpkmdm5gMEw8xRB2YBLRjc/YqAwm
         yCFzSb7gAnzmCIbqQab7DTqYPDNvCld56Uc+DHBqZOlUFpmoxb5p3YJH8HpQP+4Jl0am
         QqaeGjW/MzcZGvAXeM5mCCneJTq8nWNua4QabCVYHBURAwck0P9a83ej0TGy09kcIUq7
         f+Cg==
X-Gm-Message-State: AOAM532npY9SuoNHsFW2zqRtOcfxCdh1LVe8M5cXwZTVTbxBoVMVcZYW
        LPd3hXOG3se2GmNreE8xnlSzxrac6CJ3PRuHjPuKWA==
X-Google-Smtp-Source: ABdhPJzGUwk57v52iY1wEp/cPEVzqifiluzS2oM2VVIzq8+D0XPrB/uI8vXaF7jxmAsK+y8S+aaiEC+qngLzzGI2LR0=
X-Received: by 2002:a2e:2f05:: with SMTP id v5mr5701469ljv.279.1614962532286;
 Fri, 05 Mar 2021 08:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20210304014229.521351-1-shakeelb@google.com> <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
 <YEJbZi+tpSATjsT/@cmpxchg.org>
In-Reply-To: <YEJbZi+tpSATjsT/@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Mar 2021 08:42:00 -0800
Message-ID: <CALvZod4iVF1tg8H-zcUVp6Kf+L9jeJBF62hNHuLNKrdcxyJXYQ@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 5, 2021 at 8:25 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> I'd also rename cgroup_memory_noswap to cgroup_swapaccount - to match
> the commandline and (hopefully) make a bit clearer what it effects.

Do we really need to keep supporting "swapaccount=0"? Is swap
page_counter really a performance issue for systems with memcg and
swap? To me, deprecating "swapaccount=0" simplifies already
complicated code.
