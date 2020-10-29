Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2029E499
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 08:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgJ2HkI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgJ2HYw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 03:24:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D58C05BD0C
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 23:16:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1470517pfa.9
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 23:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7NRtz56PDrI9TlnLNjgdlxbuOLi2alt2q22qA5ZMDM=;
        b=jQ2Vn+hlZsZS9o3ITt59L/OK0Z6t3j2+1+WF33ekNAIhXNb3Pu44yIxwScTO18PQTZ
         EYIkIi/RZVDGQZSc16nb7gnKbf8Xh0MEFCILhPzbYX2xZln+4wzKEfRtQVqiAtcH2697
         LVLQcf7/Kwy7MgKBYXCW7Xx/4OnuqeZTrGumdH0W/R3oKdB9powFDeomnAWQYWgrFda+
         I7CFDxh910gYVWYr5s/MJvpZs+/Bd1/UTbZIqYqC7sRuRDRY1FeWOaWNdnXJMxVVRNqa
         QduYL17Ccef4j2aAPbpwov6T3yydVsku7bFJMZ5h6U8wzCB3QWq8SCQPcfV+dTucgKjk
         QvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7NRtz56PDrI9TlnLNjgdlxbuOLi2alt2q22qA5ZMDM=;
        b=dhvteD2QZDRlsxKAO836SLbeDH6a6N+wNwGsOu2yZg1LPUKoN/srNg30aguiwLAvWu
         5FpRNiRQqPSSP2JfaUVAkHMv3S1nVwke8KPX2Fgh/m/9Grzhj1D2Wu/Ti3q5Lz2WGDG6
         TPIRyfzBzmIQn7lM2hwdbuKC1Zd2yat1VZiVxCcJJP9i0SSKzrlzzUR5j4S731jty1SV
         hY7UA4lAlVbm94YGgkRCkES01cFv0mXHwgkdqC0n4lbsC63ClhaYHNGIaKoyzH2ZQZb3
         btCBiB10PrQzanvaZQW/LPEGFU70nNhe2YoikcKKqBUsYoq4HWDrvnbh2i47+KB9Rka2
         Otmw==
X-Gm-Message-State: AOAM530ujpUT6M7XYHiw6qrDw7KVk5tEgPVGuGTksIlAYO9GZ45nQlFe
        8wyjH/wAyN/jLsAEuyh52UpTVNkNovJtl3Yyx6J+7w==
X-Google-Smtp-Source: ABdhPJw4NQpqsTHHLGdK75LoiiTryFYJh3x82DLJSORkilAWhto57nEDjgwGuJu8Veb+OBxuu8+VsxK1p2PUyNwomc0=
X-Received: by 2002:a63:5804:: with SMTP id m4mr864296pgb.31.1603952179186;
 Wed, 28 Oct 2020 23:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com> <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
 <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com> <20201029001408.GF827280@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201029001408.GF827280@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Oct 2020 14:15:43 +0800
Message-ID: <CAMZfGtW9wa=S7+OQw_R+4LU5VzcN0H0OUPw-2XfTAJFniQN3TA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, laoar.shao@gmail.com,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 8:14 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Oct 28, 2020 at 10:56:20AM +0800, Muchun Song wrote:
> > On Wed, Oct 28, 2020 at 2:48 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> > > > If we reparent the slab objects to the root memcg, when we free
> > > > the slab object, we need to update the per-memcg vmstats to keep
> > > > it correct for the root memcg. Now this at least affects the vmstat
> > > > of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> > > > size is smaller than the PAGE_SIZE.
> > > >
> > > > Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >
> > > Can you, please, drop this patch for now?
> > >
> > > I'm working on a bigger cleanup related to the handling of the root memory
> > > cgroup (I sent a link earlier in this thread), which already does a similar change.
> > > There are several issues like this one, so it will be nice to fix them all at once.
> >
> > I have read the patch of https://lkml.org/lkml/2020/10/14/869. You
> > mean this patch
> > fixes this issue? It chooses to uncharge the root memcg. But here we may need to
> > uncharge the root memcg to keep root vmstats correct. If we do not do
> > this, we can
> > see the wrong vmstats via root memory.stat(e.g. NR_KERNEL_STACK_KB).
>
> I pointed at a different patch in the same thread (it looks like you read the first one):
> https://lkml.org/lkml/2020/10/21/612

Got it. Thanks. That is fine to me.

>
> It contained the following part:
>
> @@ -868,7 +860,7 @@ void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
>         memcg = mem_cgroup_from_obj(p);
>
>         /* Untracked pages have no memcg, no lruvec. Update only the node */
> -       if (!memcg || memcg == root_mem_cgroup) {
> +       if (!memcg) {
>                 __mod_node_page_state(pgdat, idx, val);
>         } else {
>                 lruvec = mem_cgroup_lruvec(memcg, pgdat);
>
> So it's exactly what your patch does.
>
> Thanks!



-- 
Yours,
Muchun
