Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C941B3AC2DD
	for <lists+cgroups@lfdr.de>; Fri, 18 Jun 2021 07:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhFRFfV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Jun 2021 01:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhFRFfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Jun 2021 01:35:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BECC061574
        for <cgroups@vger.kernel.org>; Thu, 17 Jun 2021 22:33:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p7so14407535lfg.4
        for <cgroups@vger.kernel.org>; Thu, 17 Jun 2021 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uWO1hK3ZXvOVh7b8YIGuK4UjnlgoPUKf+n3eG1ZZy9I=;
        b=tTF2w6u94nDeH6OQs79EePuzBVO4u511wVqE9LUkHs2Xz2SMGJSGAkzsQkLitLTsm6
         T9T1jDDKCu22/q8q14stHvaFAeuM3IS2Ona4qENUX94BvmxcRzjqNr7fY+8sqXfzkxsw
         i/TQya1wwe4B+SGkbXaP65nA4zZLkFontPXuaa+D7AzDb9s21x5kjNtuVy9mUHIoexa5
         +JjDIMFNWHPQgr2VJFIRC5JeQ9e9mQst5o/JuFC57wmFVpDl/oZUAPo5cCa5jMg8qm4A
         zIAcNHHcYWZYpNYmfGS3RVEP1CsnsKyPrz7N9ZhbAjccQla4ecfp6Kpg2EbHU1Fhp1BH
         eARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uWO1hK3ZXvOVh7b8YIGuK4UjnlgoPUKf+n3eG1ZZy9I=;
        b=Y1NYuh4NaDzyuIDDbDe8bL41PzLiKeOwXZePZn8GtthNuHVhLOY8CbtcVOK1P4S3q1
         tN96LSJofXR9u5LX1Nm1+WNne87ipOVhz9S7v6sDQ1VOxfYwQ+s9OvTeVqWV4SnFQ/O8
         XQvevsuiqQYzbQ1+P68O7HCuiN0cnOxv9/t0DQlk3cQ1AEv5v75c/acb/eEbAW53yCO9
         HCTSBrHNyVvt8F3yL+UC2ipgZKMLHkPZjqPMHCR/v5VBqYxAdML7aUngDv209Sau9OV1
         vaSU8qEtNJovT7geFjJvjhu0+Bupj1P4nVVvpWC/pQ4F7myO381u7/3kcmxld6hOKxHK
         6CHg==
X-Gm-Message-State: AOAM5303j1kbhBQpm4LqML2bzFhP0oxJFGDJPPz7SCFGGln1hfZ2fYaA
        wN2ylYleh2zDJ0WyiCQxO5CpWpUA4tZtAtnZg2Momip+5f6yzQ==
X-Google-Smtp-Source: ABdhPJzegTKTzGKbfTmL1sHt4w+pXhJO/CU2y+p3K3t3UBeGbQRvbqdLBy/P5jO3p6CYsUdXpPxcBKmjaJLdeLXGJ1U=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr1635100lfk.409.1623994388817;
 Thu, 17 Jun 2021 22:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
In-Reply-To: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Fri, 18 Jun 2021 07:32:56 +0200
Message-ID: <CAMJ=MEfjxBXWxR6PPbeoQGKc6aXQCoDjyfiOinKamR3u2xwS7w@mail.gmail.com>
Subject: Re: Short process stall after assigning it to a cgroup
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Op ma 14 jun. 2021 om 17:29 schreef Ronny Meeus <ronny.meeus@gmail.com>:
>
> Hello
>
> I want to use cgroups to control my heavy cpuload consuming applications.
> All apps are running in the realtime domain and I'm using kernel 4.9
> and cgroup v1.
>
> I created a small application that monitors the CPU load (by reading
> the /proc filesystem) and when it enters a full load condition, I
> dynamically start to put the high consuming processes into a cgroup
> (which were created during system start-up). Each process will have
> it's own cgroup created under the root-cgroup.
>
> The budget I assign to the process is equal to the budget it has
> consumed in the previous measurement interval (for example 5s). As
> long as the load continues to be high, I start to gradually reduce the
> budget of the cgroup until the system is idle enough.
>
> This works reasonably well, but in some cases I see that a very high
> load consuming application is stopped completely at the moment it is
> put in a cgroup, although the budget allocated to it is correctly
> calculated based on the load it consumed in my previous interval.
>
> An example:
> - cpu.rt_period_us = 1000000
> - cpu.rt_runtime_us = 400000
> I would assume that an application put in a cgroup with this
> configuration can consume 40% of the CPU and it actually does. But
> sometimes, immediately after the process assignment, it stops for a
> short period (something like 1 or 2s) and then starts to consume 40%
> again.
>
> Is that expected behavior?
>
> It looks like the "budget" it has consumed in the root-cgroup is taken
> into account when it is moved to its own group and this results in the
> stall.
>
> Best regards,
> Ronny

Note that this is a dual-core CPU and the process that is doing the cgroup
updates is running in a single thread. So that other core will most
probably running the application that is moved into the child cgroup.
