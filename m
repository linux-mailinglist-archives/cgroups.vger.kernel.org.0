Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46B36826F
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhDVO1y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhDVO1x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 10:27:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A4C06138B
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 07:27:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b38so10915743ljf.5
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUbZYT4OBaB64X7LHgzjKFjOfvV90LK9Vn0x4eZD4WE=;
        b=m03NQBJsiIYmZLHNAhp0ZNgR6JE1hvKR6rXrXKgEbpcm/xxcVWpyWKSe4UJSSFoEA0
         6VERSKMt3H1owy6VkbUcLEpYa4p+4xzIUeG0QGSkO/4n+f5U0hQJcuEKfVa7RGzmuZDc
         gs1Qs8aNheTNoYmGGp+2vAbMg2xCCtRdzRMSlQaC5Fo28MNBGDgSyPMkwk6copXCONZy
         gohJAjVusy8MudtqtIcM1D/lHeYMhSVwV6qeQtp/AircejjDw5yUBk08fU3A2mZyrMX8
         LEUxOeNIb2m0yU9EvunJ87XnZGy56PrEY71VEgmDdl12YHu9jtL4MBtBenFNr+/I+XRy
         ev5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUbZYT4OBaB64X7LHgzjKFjOfvV90LK9Vn0x4eZD4WE=;
        b=A2o4TavkjePqOoCWKTckLlk5Gd3v7tmOooF20O2uRFEIhwWMQWKZ8jWnhFB2WsZqmq
         YwbBvHs6OhzJEQX4HS/KmiPHGfv6GdwXWWJMLL0HnxQfrFE86dRqifjFdThzN0i+r65n
         aR9J3gDAPSrukUciJiJ5Btk+cecMtrndWGStfFkkryrcwdgzsMg+sSJ21sZwPordLlvD
         EKjIa3INu4h70MEGg+/6fyXq38wDJA1cqPqxuA3hMtmvHzvveV4jrSSsJMCxNBlsB8FZ
         S6y2JPhexUVyJ3hPhxGxSQYMBBEbYPTKZk6kFukEfSjEv3P/RTnmPiVVzq+R4iLcKxN6
         2TyQ==
X-Gm-Message-State: AOAM532nzm/dlULFxxM7YZy/f+Lg1IHD1pLaMuUHNu+ADa1df1ZjoCBX
        3N1EtCwKpiBSU5fEWgUOE1HJcOkrF3Z7cKI9v7a9uQ==
X-Google-Smtp-Source: ABdhPJxuPeU6YJj81GeUryMLJyMPTds2wqBiSmhpJSyCNeXFkuQsmGAZagAn1Y0AMi6ejQI0rH+KkH3+1wSZAPT7DXw=
X-Received: by 2002:a2e:9cc1:: with SMTP id g1mr2742525ljj.0.1619101635457;
 Thu, 22 Apr 2021 07:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com> <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
 <1f8d300b-9a8b-de09-6d5d-6a9c20c66d24@sony.com> <CALvZod5+5ycobmSt=NC3VJF4FRMFmBQEN7SQgipyTDbzHEbPUQ@mail.gmail.com>
 <6eaa4c24-c565-bc5d-dbca-b73c72569a16@sony.com>
In-Reply-To: <6eaa4c24-c565-bc5d-dbca-b73c72569a16@sony.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Apr 2021 07:27:04 -0700
Message-ID: <CALvZod5dr8Uy84wJ5-a=zyR52_k5AU64GtFAsJpBRE89DEt-yg@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     peter enderborg <Peter.Enderborg@sony.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 21, 2021 at 10:39 PM <Peter.Enderborg@sony.com> wrote:
>
> On 4/21/21 9:18 PM, Shakeel Butt wrote:
> > On Wed, Apr 21, 2021 at 11:46 AM <Peter.Enderborg@sony.com> wrote:
> >> On 4/21/21 8:28 PM, Shakeel Butt wrote:
> >>> On Wed, Apr 21, 2021 at 10:06 AM peter enderborg
> >>> <peter.enderborg@sony.com> wrote:
> >>>> On 4/20/21 3:44 AM, Shakeel Butt wrote:
> >>> [...]
> >>>> I think this is the wrong way to go.
> >>> Which one? Are you talking about the kernel one? We already talked out
> >>> of that. To decide to OOM, we need to look at a very diverse set of
> >>> metrics and it seems like that would be very hard to do flexibly
> >>> inside the kernel.
> >> You dont need to decide to oom, but when oom occurs you
> >> can take a proper action.
> > No, we want the flexibility to decide when to oom-kill. Kernel is very
> > conservative in triggering the oom-kill.
>
> It wont do it for you. We use this code to solve that:

Sorry what do you mean by "It wont do it for you"?

[...]
> int __init lowmemorykiller_register_oom_notifier(void)
> {
>     register_oom_notifier(&lowmemorykiller_oom_nb);

This code is using oom_notify_list. That is only called when the
kernel has already decided to go for the oom-kill. My point was the
kernel is very conservative in deciding to trigger the oom-kill and
the applications can suffer for long. We already have solutions for
this issue in the form of userspace oom-killers (Android's lmkd and
Facebook's oomd) which monitors a diverse set of metrics to early
detect the application suffering and trigger SIGKILLs to release the
memory pressure on the system.

BTW with the userspace oom-killers, we would like to avoid the kernel
oom-killer and memory.swap.high has been introduced in the kernel for
that purpose.
