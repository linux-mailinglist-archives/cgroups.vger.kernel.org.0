Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A561D8DAC
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 04:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgESCh7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgESCh7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 22:37:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE3C061A0C
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 19:37:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so879371ejb.10
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cHkZoHQXI3aEuEjslUR4plc1ANHqu9wqQB4RG/kOcg=;
        b=Mh9PV2beR8kr3sxrsvtSNBQkdVdaxMDyWEAR2BMrKGoZGEcLEsnHv0wI4lF5m6XERu
         JvelpzFXtcY8ryrfqTkyQEGTQmv4WXI2Dh7AjkIKEytkAabZGXbXoTPk31UF9p6/tjlK
         LQaieh22LBBb9He/v+ecjLB0cQvCZ/TTiegmxZwkYTp7SptjPtEpPVKmYxbwwxGo4j6H
         PXQfoOTEvBRVFcUUkwhkowsJGWpLTkrTc93AG0Dyk2c6Kizmq3BsUbSgXap+UhHnOWfI
         bFuWi+hQxnmLCCP7Fa2oF9mX2/zuzfQTqydfJMT5u9z75zlp+ALwcqCBOeSUIXEUdQG8
         qkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cHkZoHQXI3aEuEjslUR4plc1ANHqu9wqQB4RG/kOcg=;
        b=qw5Q4fDFptP9rK5qL8Weh8u4+bau8b8GmERZbXqzjHyIXBf8Tkw55IuYnwOAWRwhzt
         Dk55DaFBH0m9lKPDzSL6VcNsV9ZtLvNytk782ZkEJWOKDzRlML5x0cZyFdTqegCbc6vZ
         JPyEp2qNiw/u5BytjxibQSWKoN7XDAKV8dra02Bks5HyWzf+VKFlnQhl4aO7QH0P82+d
         oTctQ+cChTBKbvawFqS/e0dxPu1kjBMQGhtZkNAvbKQw669FUEP8ct5QEij18EaLLp5t
         4Gy/QT2lVVeZ3c0MpgPJ92O4naEN4KJvekd2oM62DcZVHyT2r+ULzMuJXqRtitqQx7RY
         sy6Q==
X-Gm-Message-State: AOAM5316hFIb/ll3O1MRXoNqF2jP4OPCnl0LQi6RWGw0FoiQv07dg41i
        ChYX5nhAohc+xNXF2FEK/rUaFw69LxXXkX2KxNO1VA==
X-Google-Smtp-Source: ABdhPJym++ET8pX585JqnYzfTr1oJlMw9Xvo0N1SCn5yizGiDgDmWwu0zC+WVLteLp6JBpx93hcYibSG+DSDA8Vu7Q8=
X-Received: by 2002:a17:906:af47:: with SMTP id ly7mr552521ejb.98.1589855877357;
 Mon, 18 May 2020 19:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200427235621.7823-4-longman@redhat.com> <F1FA6654-C07C-42FD-B497-61EB635B264C@lca.pw>
 <638f59c0-60f1-2279-fea6-28b2980720f4@redhat.com>
In-Reply-To: <638f59c0-60f1-2279-fea6-28b2980720f4@redhat.com>
From:   Qian Cai <cai@lca.pw>
Date:   Mon, 18 May 2020 22:37:46 -0400
Message-ID: <CAG=TAF78e=71-cUt2jaTgY8QZDmucRO2JRo-rEWALe+dGVxoQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm/slub: Fix another circular locking dependency
 in slab_attr_store()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 18, 2020 at 6:05 PM Waiman Long <longman@redhat.com> wrote:
>
> On 5/16/20 10:19 PM, Qian Cai wrote:
> >
> >> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
> >>
> >> It turns out that switching from slab_mutex to memcg_cache_ids_sem in
> >> slab_attr_store() does not completely eliminate circular locking dependency
> >> as shown by the following lockdep splat when the system is shut down:
> >>
> >> [ 2095.079697] Chain exists of:
> >> [ 2095.079697]   kn->count#278 --> memcg_cache_ids_sem --> slab_mutex
> >> [ 2095.079697]
> >> [ 2095.090278]  Possible unsafe locking scenario:
> >> [ 2095.090278]
> >> [ 2095.096227]        CPU0                    CPU1
> >> [ 2095.100779]        ----                    ----
> >> [ 2095.105331]   lock(slab_mutex);
> >> [ 2095.108486]                                lock(memcg_cache_ids_sem);
> >> [ 2095.114961]                                lock(slab_mutex);
> >> [ 2095.120649]   lock(kn->count#278);
> >> [ 2095.124068]
> >> [ 2095.124068]  *** DEADLOCK ***
> > Can you show the full splat?
> >
> >> To eliminate this possibility, we have to use trylock to acquire
> >> memcg_cache_ids_sem. Unlikely slab_mutex which can be acquired in
> >> many places, the memcg_cache_ids_sem write lock is only acquired
> >> in memcg_alloc_cache_id() to double the size of memcg_nr_cache_ids.
> >> So the chance of successive calls to memcg_alloc_cache_id() within
> >> a short time is pretty low. As a result, we can retry the read lock
> >> acquisition a few times if the first attempt fails.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> > The code looks a bit hacky and probably not that robust. Since it is the shutdown path which is not all that important without lockdep, maybe you could drop this single patch for now until there is a better solution?
>
> That is true. Unlike using the slab_mutex, the chance of failing to
> acquire a read lock on memcg_cache_ids_sem is pretty low. Maybe just
> print_once a warning if that happen.

That seems cleaner. If you are going to repost this series, you could
also mention that the series will fix slabinfo triggering a splat as
well.
