Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063D61BB296
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 02:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD1ANi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbgD1ANi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 20:13:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF45C03C1A8
        for <cgroups@vger.kernel.org>; Mon, 27 Apr 2020 17:13:38 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ep1so9571518qvb.0
        for <cgroups@vger.kernel.org>; Mon, 27 Apr 2020 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=T8w1cAu62fq3Z/o1KAR+sWAmzB/rXmhhrpuLQFBAE2o=;
        b=F6JtusMLTinzcqcUGMiUbaV2UdtlgxhuL6LAGXkeTZHk+Pr449mf/NN+OXQurRixTB
         q4taVk1n0AyKdsw8fkHxyPWrHStJ44B9LkpKzmEXsYSFT5xBk4bxXdYS/tmiiaAN077Y
         3sGnQt+B20IiZIqcvCmYTOWkrh/zocQxGAH3tQeeyd86oBSPbGIAYupBvOX1dsqmYWt1
         v8dSIy15SqYvOQ9owwKsiH3P2mH/omX7QeNRAfTuf2LVpiVaGHGw6acfvDTAWsxnOLuD
         La9kc2JCwHNei5DoPqEuqHjYb/VS7FQUmOlfJ7GOS3tUAUQy946ci3hYJLFuFB+Rlb4B
         rntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=T8w1cAu62fq3Z/o1KAR+sWAmzB/rXmhhrpuLQFBAE2o=;
        b=IPB6V/KkuBsvWcGgASJeDwu1/AfU8BIDMgc918C0FfiwNctnq3IxIScqQ0aCuAD/JZ
         op1T99nxJLLXDHq1BMNEU4ADTrkVDJ1NEsfCYdaXdsdRnuUfguSxdFTEBEWdC2eFwdW2
         FXKai4fYYTJ2cmLvgB7dC9Uogu7ETu4EHzTgAQU9/x/JfTG7qShawUyHxpBMTgNLY1Vi
         yh8qj8LAhhk/byoY/9wzz7u8/sPsD5kREPfEt42K0AuJwlhdUeAXUbv+lSWR3gq3PaZp
         IiWSbKO+IdXzn3He63zMWJ75EO1BaDNvYdOM7uubObkZknAl29UInOWb1XMHuKYJPVyF
         4A2w==
X-Gm-Message-State: AGi0PuYAAVNdfLadcsGTvuWqtvO5gez9NpKYT5T8gGZtfzC/OiAwU9DF
        VJ3JmCCEj12EOUyyGB8iZdV8Jg==
X-Google-Smtp-Source: APiQypJn4FTOv85rWPD4nI1annl59MfgciOnHBOrcqSfE4D8IYqFhQj45SpSMByd3gG2ZRM+XnUxCg==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr25454231qvn.28.1588032817220;
        Mon, 27 Apr 2020 17:13:37 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 11sm2439712qkv.92.2020.04.27.17.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 17:13:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Mon, 27 Apr 2020 20:13:35 -0400
Message-Id: <55509F31-A503-4148-B209-B4D062AD0ED7@lca.pw>
References: <20200427235621.7823-5-longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
In-Reply-To: <20200427235621.7823-5-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> A lockdep splat is observed by echoing "1" to the shrink sysfs file
> and then shutting down the system:
>=20
> [  167.473392] Chain exists of:
> [  167.473392]   kn->count#279 --> mem_hotplug_lock.rw_sem --> slab_mutex
> [  167.473392]
> [  167.484323]  Possible unsafe locking scenario:
> [  167.484323]
> [  167.490273]        CPU0                    CPU1
> [  167.494825]        ----                    ----
> [  167.499376]   lock(slab_mutex);
> [  167.502530]                                lock(mem_hotplug_lock.rw_sem=
);
> [  167.509356]                                lock(slab_mutex);
> [  167.515044]   lock(kn->count#279);
> [  167.518462]
> [  167.518462]  *** DEADLOCK ***
>=20
> It is because of the get_online_cpus() and get_online_mems() calls in
> kmem_cache_shrink() invoked via the shrink sysfs file. To fix that, we
> have to use trylock to get the memory and cpu hotplug read locks. Since
> hotplug events are rare, it should be fine to refuse a kmem caches
> shrink operation when some hotplug events are in progress.

I don=E2=80=99t understand how trylock could prevent a splat. The fundamenta=
l issue is that in sysfs slab store case, the locking order (once trylock su=
cceed) is,

kn->count =E2=80=94> cpu/memory_hotplug

But we have the existing reverse chain everywhere.

cpu/memory_hotplug =E2=80=94> slab_mutex =E2=80=94> kn->count


