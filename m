Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7370ED9FD
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 01:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfD1Xyh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Apr 2019 19:54:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37213 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfD1Xyh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Apr 2019 19:54:37 -0400
Received: by mail-yb1-f194.google.com with SMTP id p134so3198435ybc.4
        for <cgroups@vger.kernel.org>; Sun, 28 Apr 2019 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJzmJt5dXSr46qHnoNS5EATc+3d/a2ElrqvTmuSBEdg=;
        b=vtb874mzD79EZ4lK/FKahzxhVi0KRxJCPlqZoqswyk+2KOM5zWGrGYQuwyAm+T22Tw
         owM7xGx6+2XBrBj5iKgttpXndlokSkCdXaHqUeHOFf+PlXlCZ2yp0uwBGU9kHmPDBaP3
         NPMqftVpxG32Ym3soeW3UjOB6L1fPjZDBlyMdNqNwt9OVII2tfrlqfl/gnvIPU3bMaZn
         cUVYDFNlR55+wB/mdDdGu/qVqcG7ro7bhCZ4ZElgyYQOn/W0/DI1IikYofKRbuRkkoiy
         mESCGm4KqIGV5Jq0W0rf0Z4UcYiBTtc6ftKlNJ6VQTSglnjByMoBHVI/DsH9MW04d21q
         MSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJzmJt5dXSr46qHnoNS5EATc+3d/a2ElrqvTmuSBEdg=;
        b=R0c4j9UfxXUh7pPS11F9xyLtKPwRi+q1dRYzlc6YUV8BAGxaa9HbfQarKAbAUO7bHS
         YQW8Sit3P9Jg6y8sk3WuksQcTyHJugEJ9jliBESB/C+0qJgKOYM0C9k1yHD1V0MImU8H
         LG3ZgNlFO0k4yAPkNC7yMENk6+0chPliTxf1oJVsOUu701ZnG4wwXw2BT9GDi9ckAliV
         3JkMENUol4XQHFqwVHWyz4aFbh4Gw0XcIu4C+6oSzqZS/R/kOUmhFrzwc0LmYJg1V75V
         1UYyOK/28U6FCH3F02E+HvBlttv7K0vuenEcRXZtaW/nBjzKt+tmJ76WW8RGO/j6VS74
         iBBQ==
X-Gm-Message-State: APjAAAV+nduc7LfXiuTsDNQZE33qFAzjYk7kYgZu4RxhHDl/0p5Zr8fq
        +b/egTohUeCvtDJQxXvr1PKY99vDmBYaOcK/qptQdE9vQ/s=
X-Google-Smtp-Source: APXvYqywcrtNm7hfKOwHEbWcro/mUsCfRRyw7no0aSBlNf48FzHe5zU0X1HlsmhnwnPpE8C1iDov7piwnmKx6YCRD8c=
X-Received: by 2002:a25:f507:: with SMTP id a7mr46894022ybe.164.1556495676033;
 Sun, 28 Apr 2019 16:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190423154405.259178-1-shakeelb@google.com> <20190425064858.GL12751@dhcp22.suse.cz>
In-Reply-To: <20190425064858.GL12751@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 28 Apr 2019 16:54:24 -0700
Message-ID: <CALvZod5Peau7D-O1oi0jFfiOCJrSOMHDnr6TPrTxawt_jh9izw@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: refill_stock for kmem uncharging too
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 24, 2019 at 11:49 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 23-04-19 08:44:05, Shakeel Butt wrote:
> > The commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for socket
> > memory uncharging") added refill_stock() for skmem uncharging path to
> > optimize workloads having high network traffic. Do the same for the kmem
> > uncharging as well. Though we can bypass the refill for the offlined
> > memcgs but it may impact the performance of network traffic for the
> > sockets used by other cgroups.
>
> While the change makes sense, I would really like to see what kind of
> effect on performance does it really have. Do you have any specific
> workload that benefits from it?
>

Thanks for the review. I will run some benchmarks and report back later.

Shakeel
