Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28963246D1C
	for <lists+cgroups@lfdr.de>; Mon, 17 Aug 2020 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgHQQpo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Aug 2020 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbgHQQpQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Aug 2020 12:45:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D8C061343
        for <cgroups@vger.kernel.org>; Mon, 17 Aug 2020 09:44:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so18208333ljg.13
        for <cgroups@vger.kernel.org>; Mon, 17 Aug 2020 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ustc/Co8E0AQhbcerO/qjyS5RAvKGH1AciZ7eOvqsmA=;
        b=c+qkjdRRVAF0xvWA9+DkkVLwK7sGF1z8hQM3CtGa1YD+bJI6w1nj5+9S70Q8FvCQqi
         2Ei0s13pec+cTVm+0OSOFIdw7vP7XLcSIvUcZ6EGrALSHKiZ7PPGzM4XEb029aajiYyC
         aEhBUOpbzPBTQSG4Cdn7X1BjMfLQqn745I4HqH3Abk31kJgYxjgeUpKk7qwB2tzxmqpe
         AtkUyANm5zAbjaLbrp8RlEB5I2UccCxi0HQae47ThK7uHUPNGSHd8fX+Y3ltxcsiL9Kl
         3ENiFhFOnYGf8LXV3bRXJi1SUgcycpC5v7MIYDrXtB34VmBj+Nk2YpIHRR25BtbB6i8Q
         lRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ustc/Co8E0AQhbcerO/qjyS5RAvKGH1AciZ7eOvqsmA=;
        b=X6OsHCHMvqXFTb3d5E4sq8Wibd7CGu4smeiUu6E8A4MsuiT89vNRT7HhrPqoWYWX91
         SxWcsmIaE6F57xDdPnMM0BYx+MZOQpcRU1wcRxX1o04Ws3kqDlxTToozCar2/fUaTZPI
         hzuqW2ifNzxpDisFaSuWJvPXfP8vCC9eog4pERY0oqE5t7lCwPT7iGHhRt6xWWhypezT
         CADCfLKP9u7BBlopfDtc2m40kIpHjoKp1cmzLm7+cShQv/oGzHClyJZSwCDWzpO4mf/b
         6O7RbTX1RB1PFHneS3AWDd3BT+KOX4i06RoD843LGAeelvXshUWf45vkmrZdg0RhabX8
         aUgg==
X-Gm-Message-State: AOAM531aX7/ru1FogHOwnR5ju/A4RFmtERx6W8bbBlKApA8+Mh5SLSYd
        AjvHVFcoUuToP90vXaQwqG5R/P0bG4KQMKe1mhhShw==
X-Google-Smtp-Source: ABdhPJxOE/KUm/g/wNOBiL7kHkyu0ap1d61VlZFxn7CVZ1FQIRsBFPdNAO+qmD/8YZJURfdVWZ4NywWAdRo3uSnMkE4=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr7974441ljj.270.1597682693369;
 Mon, 17 Aug 2020 09:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200817140831.30260-1-longman@redhat.com> <20200817140831.30260-2-longman@redhat.com>
In-Reply-To: <20200817140831.30260-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 17 Aug 2020 09:44:42 -0700
Message-ID: <CALvZod5V3N3K9-tDoaq=JgkeuAK=0TkRf97Vua0khXL+Lxw+Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 17, 2020 at 7:11 AM Waiman Long <longman@redhat.com> wrote:
>
> Memory controller can be used to control and limit the amount of
> physical memory used by a task. When a limit is set in "memory.high"
> in a non-root memory cgroup, the memory controller will try to reclaim
> memory if the limit has been exceeded. Normally, that will be enough
> to keep the physical memory consumption of tasks in the memory cgroup
> to be around or below the "memory.high" limit.
>
> Sometimes, memory reclaim may not be able to recover memory in a rate
> that can catch up to the physical memory allocation rate especially
> when rotating disks are used for swapping or writing dirty pages. In
> this case, the physical memory consumption will keep on increasing.

Isn't this the real underlying issue? Why not make the guarantees of
memory.high more strict instead of adding more interfaces and
complexity?

By the way, have you observed this issue on real workloads or some
test cases? It would be good to get a repro with simple test cases.
