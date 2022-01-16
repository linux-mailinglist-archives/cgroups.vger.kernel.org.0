Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3F48FEB8
	for <lists+cgroups@lfdr.de>; Sun, 16 Jan 2022 20:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiAPTyi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jan 2022 14:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiAPTyi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jan 2022 14:54:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E3C061574
        for <cgroups@vger.kernel.org>; Sun, 16 Jan 2022 11:54:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p27so38160491lfa.1
        for <cgroups@vger.kernel.org>; Sun, 16 Jan 2022 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32ZGPXHe3Ged0KnD2WiQsFB3QGx2BbSWPhOV/bW7jNc=;
        b=RMd20O9hiJ+E++mZyFCDgYsG99GnasXx9c7mZSzw0rI5QCZRUDgY7035Y/jwkEIhET
         //SyReKW9JjjJucOIxRqhB29/qOd4FJouwJMwOq05gVXJnoAaw9T8BRB2KyG/rTWdf/3
         JChxfan6qdczRC8W0KyNqWCcGtDTmC/Dkg1vIrMMrJS8DHl6PHjNIY+V4aHI/Ct1MUx+
         eWAX6pjHBWif9lJixach4FExApXyy+orxoCRlPl5egBwUKbfvgBbI0LxRO4uqztDVEGx
         zcs89gRS7lDl7xhNTMO0tfkzqTOrF99K6B28pwaFimR4JkOr12A8c0sB/e3NKvoHqzWt
         KJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32ZGPXHe3Ged0KnD2WiQsFB3QGx2BbSWPhOV/bW7jNc=;
        b=kiFl+T3IwB8jDRaMQ+3wTmMASPqUPeKAlYYIQmjccc1x0RsPsfEapdTQS5UvHnvqGo
         yRhbrA22Gj6PVTZ1z6dUqjpEsjIl2Unw1Iv1vVImhSmXzrwVGcEMbGFMiPIYt1M9BGGI
         9RHmgFvRGWeLQDwKgLCCDV0MZbKSpvT5ybhoEExoq2/kV6ySWswWb3aGoryXdg/eW4Jp
         DQKGbWZ1NyJvj2WZ4OdupiAfbHiYDkPcTXy6nk5pXPJP/en72t6dMy6lkdPKU0YjAOr8
         L/gS1OBQ69S9bB5Hqwn2e1s8RvjKQvEho8esxDNEm9/gFgSJBAKlocn4G1jmPGmEnEAF
         PSCQ==
X-Gm-Message-State: AOAM533av7NeX6seoImEGwnHSH2OsPQtzkTxM5KcazzhIz7vyYWKcCPY
        XL8T/NMGXWvC7vke2gHc/mpH4B0I7Z/a6BkH6nNGVg==
X-Google-Smtp-Source: ABdhPJyGC2HiGMD9xJ2IzvKhtFycMw3qTAUv/s7jZVYILuuCp45IGNNYwzSQ72dovmtvqs9HDTNM7vbfxWjIAoqZLN0=
X-Received: by 2002:a05:6512:33d5:: with SMTP id d21mr14534416lfg.8.1642362875855;
 Sun, 16 Jan 2022 11:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com> <20220111010302.8864-3-richard.weiyang@gmail.com>
In-Reply-To: <20220111010302.8864-3-richard.weiyang@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 16 Jan 2022 11:54:24 -0800
Message-ID: <CALvZod52PWUhaFW1jOjJFd_Ef4pBrj7=q8MaBEAWMqawapxQ6Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/memcg: retrieve parent memcg from css.parent
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 10, 2022 at 5:03 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> The parent we get from page_counter is correct, while this is two
> different hierarchy.
>
> Let's retrieve the parent memcg from css.parent just like parent_cs(),
> blkcg_parent(), etc.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
