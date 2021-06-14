Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694983A6A68
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhFNPdL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 11:33:11 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38690 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhFNPdG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 11:33:06 -0400
Received: by mail-lf1-f50.google.com with SMTP id r5so21806502lfr.5
        for <cgroups@vger.kernel.org>; Mon, 14 Jun 2021 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bNme+EzHVzrIQEXwYwbnMcehdQ/ZaTsor5me0kGBI+A=;
        b=NFSC8hXLt1UmmA/yEyGFseJidXegBmq+NZ1BAg51wCEhbt0II8ZiQJ7Hzdz9go8FTH
         NpLqfJX2qL3XCZLJzAq6VacSqe/Y03/2x8Ah+7Lp7n7wZmUgWyA7r/dMcyGq2SeO+67R
         2WN62J/Bdx/CNxOvPDRuuQ2fdUQDuRm3YH1lGQP+Or4Gg+0lKYpALATDdu6vW/O1PflW
         tRpOkmvwkJR9TicaaFYpjXLr3ivh8HapLJToWvTarG+yjI2c2blLNy8+jOs4DeWna9jn
         l91YIPY7iBP7PC1FZO/XHSOZcCnA/Xl49xGiEGtZDDrmVwC0lTmgfw3HCKvg7vq5gl35
         Qk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bNme+EzHVzrIQEXwYwbnMcehdQ/ZaTsor5me0kGBI+A=;
        b=UCCctNw2ybjDyvsvTB+cW58Ssgovzm/WRrmDZkDykmP6gPIC6Fahi0seOFjyFtAD0H
         MN4vCtPjNwmu12mdt5H0rHjR6Ke7zGJvc+o6UHM0EnfhsF4OuTbLZOmpJSpGQp1yGQkA
         98gHZBXvICF83gElv6DyO/l2yU3/mI3Z+0PSOxG/quohv41YkWxhRLOIUgkgglSFoJyH
         axNDp1s7cpfL4PJUkOtBhmA+26WOJZyhXwSqeOkLQG2XkaDOERpDfozWufhNswwFjBZ3
         drQxmGuauZYN/ex8KjtBxcPiNVUTolEpxyJk9FVLwc9FUzzRWnk2lf1dbFqa7f1J90tK
         i/9A==
X-Gm-Message-State: AOAM533/IzWSm9iLHOqAYnTHOsfW7lp6XLGhrSyPyJXee2lESRQ1mpB5
        lOStml/xy9LUUbDuoQvAshMym1D439VW2++/TklcDuosO+CU/6aU
X-Google-Smtp-Source: ABdhPJygBg5yGh+Fh5lkbZUkHhRwXvoQ7j62FCdfmA8OfJDx2+SonVvGkb+JPOa5iUxG88v1+7Zz2rBqgVXoZPjDrvo=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr12214333lfk.409.1623684587682;
 Mon, 14 Jun 2021 08:29:47 -0700 (PDT)
MIME-Version: 1.0
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Mon, 14 Jun 2021 17:29:35 +0200
Message-ID: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
Subject: Short process stall after assigning it to a cgroup
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello

I want to use cgroups to control my heavy cpuload consuming applications.
All apps are running in the realtime domain and I'm using kernel 4.9
and cgroup v1.

I created a small application that monitors the CPU load (by reading
the /proc filesystem) and when it enters a full load condition, I
dynamically start to put the high consuming processes into a cgroup
(which were created during system start-up). Each process will have
it's own cgroup created under the root-cgroup.

The budget I assign to the process is equal to the budget it has
consumed in the previous measurement interval (for example 5s). As
long as the load continues to be high, I start to gradually reduce the
budget of the cgroup until the system is idle enough.

This works reasonably well, but in some cases I see that a very high
load consuming application is stopped completely at the moment it is
put in a cgroup, although the budget allocated to it is correctly
calculated based on the load it consumed in my previous interval.

An example:
- cpu.rt_period_us = 1000000
- cpu.rt_runtime_us = 400000
I would assume that an application put in a cgroup with this
configuration can consume 40% of the CPU and it actually does. But
sometimes, immediately after the process assignment, it stops for a
short period (something like 1 or 2s) and then starts to consume 40%
again.

Is that expected behavior?

It looks like the "budget" it has consumed in the root-cgroup is taken
into account when it is moved to its own group and this results in the
stall.

Best regards,
Ronny
