Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBC3B3D71
	for <lists+cgroups@lfdr.de>; Fri, 25 Jun 2021 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFYHfv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Jun 2021 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhFYHff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Jun 2021 03:35:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63087C061766
        for <cgroups@vger.kernel.org>; Fri, 25 Jun 2021 00:33:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c16so11259541ljh.0
        for <cgroups@vger.kernel.org>; Fri, 25 Jun 2021 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bRwf8isjvoYl83x2OClryu7P0IJp28cVtw0kzUaoiqE=;
        b=J5TXfJKrChnx0Kw8UzbBdOYLoeBRXpK0qQg/BlZzemDnd7n7Atjv8ZFVzG0luzgVDN
         RV5SpCPBHXnJa7nB+vzotBodPhwU7XAV7rG4RppTJnbhnVMdHSbWOMKr99FLasoEOHxh
         j/lsD3IyuhjRU/oM/cuHScn+4wOceam19hQVGGRhB64YSaAozksVUz1Y/wIwqW0M5VH8
         fRdL0HbAr9ioXLnesQYMPlSM3gk2VvemM8m5J6YXvgfvBq9LuUAd8r1Em/eVytdUFEQU
         e2hJvtPjeUqiNTFprcaBDI0wnPrZaUiHiP5mPlGtll9xFtX3j0LxLwDuUvS3FbXjSdXr
         tpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bRwf8isjvoYl83x2OClryu7P0IJp28cVtw0kzUaoiqE=;
        b=M5h7u+FNFlbABg5rFJXEKK9uoCidbICvyDlWOU2uaDPAcc1vos/PrvewZLFcDdr5eN
         VWZC1gDmh5jEfyP1/HeJ8sfi9Qjk/UPkzfNOj+uF3jLo0J9H99MoNOK43kLg/Oap3J8C
         u0w0iFiE/nNLb7UEhxlXrrC7PDmTJrCOMhk8EGNudy0ehlFfmq8ov8HNW7gqxOwpX2jM
         4CGE2+7mAlv8V5eyaDmKh/zBL998heMKAr+fBAIwEFNP4dZVelYUbG8vGG0ZndleTLbw
         y8B0OH9ijfAtpwjUhFbvG6iavMZubJHNTyI25Yd1VPBFHt3TY4A5XJ2+gGUghWKHOxlN
         jJFQ==
X-Gm-Message-State: AOAM533RSX6qfOnKv/8Qtz0TEhOI2jsN4NNRHCWhrM8STtQ6+Lfe36tZ
        Yn0FtA6aPoPVHD/4eO/3U7Fpyopo7mxSwY6aWWk=
X-Google-Smtp-Source: ABdhPJz166+LeKo+oc42XQry1+XHqovUOgCdktYSUwINlsnbhaP1X9nsK4t828w3LIP2rR8dszJv4RCFtrfQKk80jyQ=
X-Received: by 2002:a2e:1453:: with SMTP id 19mr7254373lju.62.1624606391101;
 Fri, 25 Jun 2021 00:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
 <YNNvK0koEdkuD/z3@blackbook>
In-Reply-To: <YNNvK0koEdkuD/z3@blackbook>
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Fri, 25 Jun 2021 09:32:59 +0200
Message-ID: <CAMJ=MEfMSX06-mcKuv54T7_VCCrv8uZsN-e-QiHe8-sx-sXVoA@mail.gmail.com>
Subject: Re: Short process stall after assigning it to a cgroup
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Op wo 23 jun. 2021 om 19:28 schreef Michal Koutn=C3=BD <mkoutny@suse.com>:
>
> Hello Ronny.
>
> On Mon, Jun 14, 2021 at 05:29:35PM +0200, Ronny Meeus <ronny.meeus@gmail.=
com> wrote:
> > All apps are running in the realtime domain and I'm using kernel 4.9
> > and cgroup v1. [...]  when it enters a full load condition [...]
> > I start to gradually reduce the budget of the cgroup until the system
> > is idle enough.
>
> Has your application some RT requirements or is there other reason why
> you use group RT allocations? (When your app seems to require all CPU
> time, you decide to curb it. And it still fullfills RT requirements?)
>

The application does not have strict RT requirements.
The main reason for using cgroups is to reduce the load of the high
consumer applications when the system is under high load so that also
lower prio apps can have a portion of the CPU.
We were working with fixed croups initially but this has the big
disadvantage that the unused budget configured in one group cannot be
used by another group and as such the processing power is basically
lost.

>
> > But sometimes, immediately after the process assignment, it stops for
> > a short period (something like 1 or 2s) and then starts to consume 40%
> > again.
>
> What if you reduce cpu.rt_period_us (and cpu.rt_runtime_us
> proportionally)? (Are the pauses shorter?) Is there any useful info in
> /proc/$PID/stack during these periods?
>

I tried to use shorter periods like 100ms instead of 1s but the
problem is still observed.
Using a proportionally reducing algo is more complex to implement and
I think would not solve the issue either.

About the stack: it is difficult to know from the SW when the issue
happens so dumping the stack is not easy I think but it is a good
idea.
I will certainly think about it.
To observe the system I use a spirent traffic generator which shows me
the number of processed packets in a nice graph. In this way it is
easy to see that there are short peaks when the system is not
returning any packets.

> > Is that expected behavior?
>
> Someone with RT group schedulling knowledge may tell :-)
>
> HTH,
> Michal
