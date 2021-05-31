Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB883967C0
	for <lists+cgroups@lfdr.de>; Mon, 31 May 2021 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEaSWm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 May 2021 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhEaSWl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 May 2021 14:22:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA9C061574
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 11:20:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i10so5927826lfj.2
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfVhFBreFM3+hibS+ZUYxXnl8ONhxdP+w+9OFOxmAhE=;
        b=YBmR9AxxYxpwcV2YLzagXsntolLPZCaQTDTHWwWzremKSRujeGHnr7cEFxCHJDPpC8
         uaLyP5C8RRhr4s4wXlYMDiPX0c8RklFoJxwVY2bnKnNBvShdMuoNijcv/8zIs79d5SXC
         zdvUVhGtoCsnnLEyKLRSV18nJCg4OCgmpAJhGMhhMAvk0Gx5HCxFRpRoKZd1JPVFkY4B
         F2LjxX5mJqXCi72QGNSMJEayaBTXYrT/wmY5tLoc3DV26DQXybMi3YJZH00vfuCt6bo0
         6UvsBGhqYIYVdHjwjPqABXJ7CAvie8+hqdWyqFE+u0Eu2NfkhRwAUMfTtrN4qV+1fR/n
         awhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfVhFBreFM3+hibS+ZUYxXnl8ONhxdP+w+9OFOxmAhE=;
        b=ZkNYbtlUVSgnqmFIjoIEwR70h7X9N8mcC7M2KfqS+cOI7kcKQcHxhRllPViHQTteyL
         1XCXdn+ImuLP03GTwm0nMUyIZR8FTsaFVa08BYS6PNLRp3D6lE/PJkexQxPJWQ+oVIwp
         zk0DSDmWHY7JWA8QIybAEfDN/zSvorI93ueny/qz3sgkayZt/XQKyZHUzdclIqosoLuN
         8NH9d5B5VrX6qL/W7b787E3GGcyVohJIbAhrDDTxqb+IxOFQnWWZ17nqCWD3o0nzeYDV
         namVkxzlkTgzElq1koyIH5ynfr+Wn9LKZ2a+oLBh5b2L03v5snxxUmjk33PcNfnpIZx8
         78TQ==
X-Gm-Message-State: AOAM532+pJqhdcyVGRzHYeB4r7mLXYJIjRqUlQytNV+qLv+gwBYolTaY
        AmR56aTvyB69BGYO53KwCJTEU75KxTu5Rvi1QjFjSw==
X-Google-Smtp-Source: ABdhPJx8uEnnXt5B1Cl3c0HFZ6yO2OdoHl5U2ygkG2P+Of6xFjMVbHtsr/2ctti8ISmVIYBGG9aYedzsBR4Ys8Lvxtc=
X-Received: by 2002:a05:6512:2344:: with SMTP id p4mr15895230lfu.299.1622485257374;
 Mon, 31 May 2021 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com> <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
In-Reply-To: <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 May 2021 11:20:46 -0700
Message-ID: <CALvZod4FUEXuqs8mKiN-WdmF2eCi29=aRG-cOaUQEDCbHdXQRA@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 31, 2021 at 5:11 AM yulei zhang <yulei.kernel@gmail.com> wrote:
>
[...]
> > Can you please explain why memory.high is not good enough for your
> > use-case? You can orchestrate the memory.high limits in such a way
> > that those certain cgroups hit their memory.high limit before causing
> > the global reclaim. You might need to dynamically adjust the limits
> > based on other workloads or unaccounted memory.
> >
>
> Yep, dynamically adjust the memory.high limits can ease the memory pressure
> and postpone the global reclaim, but it can easily trigger the oom in
> the cgroups,

Can you please elaborate a bit more on this? The memory.high has a
strong throttling mechanism, so if you are observing memory.high being
ineffective then we need to fix that. Also can you please explain a
bit more on the specific of the workload which is able to escape
memory.high throttling e.g. the normal number of processes/threads in
the workload?
