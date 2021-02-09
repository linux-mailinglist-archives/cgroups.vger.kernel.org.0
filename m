Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F393150CE
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhBINvJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 08:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhBINth (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 08:49:37 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A873C061786
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 05:48:57 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a25so22418235ljn.0
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 05:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6hyX38mFJ+6yDNoRa0BGXqLisY4Yt/Qs5tS4tQuLTM=;
        b=Lnr4Vpipr9eoHCBAXs0vIMZqnnLOPt5XJJY6hZEYAEXJLxFHjgBAEVv1hMRDeE70Zu
         SPfvjE9sH0FPF2chVvLMxOf68LUhxTq+qZ/JYFtOm/zKjaGbRZSyxuO/WEzk1e+/jPcf
         wa8p46aN3DkPxs0WMp+llHSAdjEt6ZVLeBHVZF0ydb4SyhCi7gM/XYPNq96BaVzTlZPO
         tnE+xKkoiZsZq8OWZR65+m4MG9uSN8HUF+c61TlJdXXZGZWuw9/X3h5jvYTJ/Ahv+vt5
         2d00sw6ydU3gfg7oAsyhyneHfaFA/Tr92JOoGVJj5XskNx8aAQJ7euKvLBShn+SZXz9j
         VhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6hyX38mFJ+6yDNoRa0BGXqLisY4Yt/Qs5tS4tQuLTM=;
        b=NsW0NTdY8evyMjjIuro10OyB8m/dl5IcwJQY3F0I4pnz25QzpHqeMVzZCp4if03SRa
         ktyq4NdNsEeDAgjGeNrq3yartS/kw+G6a6Id8GOISE6hneRNwtdp3M9LmvvbaY8Qnohv
         T/NPTcLVkDRv1y6e1JPBtJSToOSwHJUv6ReQbJOoAWoVjW/mQL2sbMnBpmBAVJEuJQh1
         dCooHEjJp2QRo/OHDXRMwHdPpd/xURrK8L5J6/dW8esUtm9vIU3g6c3SoeYlh30QJLWn
         Q0MGXmhx+i1moCOKPF+ECcS6a9WwQwna3lI7sUPCjys8jOouQb8LYGf3TKbXrfqU38Dh
         +ClA==
X-Gm-Message-State: AOAM5315rwbACCgHw+G84gHefxy2CVUlvHdQXxLhMS2chu2zTB6d/5l2
        0RIy4rcqwcw/ac1RS7+J8lPSFQAbNg+ukkmqIh6LNQ==
X-Google-Smtp-Source: ABdhPJyLt44bzUjpu6Y8sHGTFfy5PZuO0xZAOmT/z6qaaoQpN60RFk8x0k4fYzlAfbSMW3PiuKVgCHpucU/OkVGtTwk=
X-Received: by 2002:a2e:b165:: with SMTP id a5mr10040263ljm.81.1612878535285;
 Tue, 09 Feb 2021 05:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20210205182806.17220-1-hannes@cmpxchg.org> <20210205182806.17220-9-hannes@cmpxchg.org>
In-Reply-To: <20210205182806.17220-9-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Feb 2021 05:48:44 -0800
Message-ID: <CALvZod6Sy-SAUdAFMP=Bot_gyzGQqW2LrOehRbE-qUEgveFF8Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] kselftests: cgroup: update kmem test for new vmstat implementation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> With memcg having switched to rstat, memory.stat output is precise.
> Update the cgroup selftest to reflect the expectations and error
> tolerances of the new implementation.
>
> Also add newly tracked types of memory to the memory.stat side of the
> equation, since they're included in memory.current and could throw
> false positives.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
