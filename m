Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD342151C
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 19:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhJDR0D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhJDR0C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 13:26:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A4C061745
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 10:24:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y23so35416221lfb.0
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEcLDwK9m1057jui6AApVi77iUKrt1BBHKk+cl8sBwg=;
        b=TnB++IRae/jo7gqmQjvRKcHMHKTEqCZDZphTfi5vqyHYACWjXUvpjyPRFMIh9KZN4I
         WnSWO3bAsjSUNczaIep4vUgkrW4Xkc2ZKwYP9nvihsSLiG2BAOx8GhVX9b6/+iiS0tFH
         k0r5k6pUly5KokxDk1+787vNZJfhPAsJHdfl2BFuxeaST/d+CUl2KLhb51OQxSLZYfD2
         pjjuWIBmQsmt3Ohu1veqNZMuquHHpjwDPqYrnVG9FfFe7XhCnvRQCLFCQI6HDiAOcJXc
         tf2e/QLDCOpEgcy6ghQvYIWqFc6qRvU5YXWA5oML13c00Wf4o9ga0BnaVrt40rNS7YOk
         OjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEcLDwK9m1057jui6AApVi77iUKrt1BBHKk+cl8sBwg=;
        b=m6p3DQZD5WbqcE9MApU0OkUMwdI4Zx89jUNaCnTlnbZYUfPUs2hfiGwRyDYn7/jQ8P
         ghjGasiAwAG7My5M3NIwVvNCZLWzfCYNsmz1v0RPAvDcYuiwIvwqKFLbdHmsd0bJdYgD
         5Om3dXnnLjtHNOzjxPY00d6oQ4AQTzGJ6MJV94r35vOHx6bQmxj9x1Hyk6GJBuHuBDgt
         HNhOrfG2vo3iJp6oC/ND9X/XV/NBmv+xCVrSUBRqmC9XLrJLy7D0GLPr72B4YBo0oWmw
         38Y9BcaDOV3xYrHiyqPOo6MWDsylekHW9JP6VQgScEWrs2xOX3YcZSUDbROaRc4O/hUP
         d6hw==
X-Gm-Message-State: AOAM533pCCPa6S4wYicnlT8/ZXQzNFsdvXbs8VGcYBh/RK2kA+qbWN+J
        Kjrl7RDOhEu6TafFu/LBcASI4Iv7x+e4kxFqMUhsOg==
X-Google-Smtp-Source: ABdhPJzmD4UEBiXFKhf3rNaJHbKhr3KtSIrZIN1GdcE1+jJQvDvJM30Za3MQXvWxtLqb+LdeTrVIpEaC31hVR+x7lVM=
X-Received: by 2002:a05:6512:3193:: with SMTP id i19mr15780869lfe.485.1633368251172;
 Mon, 04 Oct 2021 10:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617090941.340135-1-lee.jones@linaro.org> <YMs08Ij8PZ/gemLL@slm.duckdns.org>
 <YMs5ssb50B208Aad@dell> <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
 <YVsuw+UBZDY6Rkzd@slm.duckdns.org> <CAJuCfpHprdJWpR_HPSVm6DFEOJj4RWmWC10=ZdGYF_JFAvV+_g@mail.gmail.com>
In-Reply-To: <CAJuCfpHprdJWpR_HPSVm6DFEOJj4RWmWC10=ZdGYF_JFAvV+_g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Oct 2021 10:23:59 -0700
Message-ID: <CALAqxLV-tOgBMAWd36sg+bh3s0XXqKWD+P-CYgVXf7Won4auAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 4, 2021 at 9:57 AM Suren Baghdasaryan <surenb@google.com> wrote:
> On Mon, Oct 4, 2021 at 9:41 AM Tejun Heo <tj@kernel.org> wrote:
> > On Thu, Sep 30, 2021 at 02:20:53PM -0700, Suren Baghdasaryan wrote:
> > > Some of the controllers are moving to cgroup v2 but not all of them
> > > are there yet. For example, there are still some issues with moving
> > > the cpu controller to v2 which I believe were discussed during Android
> > > Microconference at LPC 2021.
> >
> > Care to provide a summary?
>
> Unfortunately I could not be present at LPC this year but Wei I
> believe was the presenter (CC'ing him).
> Wei, could you please summarize the issues with moving the cpu
> controller to cgroups v2?

Tejun: We were sorry you didn't join as we were hoping for your
attendance for the discussion!

For reference, here's the video of the session:
  https://www.youtube.com/watch?v=O_lCFGinFPM&t=2941s

And continued discussion from the BoF:
  https://youtu.be/i5BdYn6SNQc?t=703

But Wei can still chime in with a more focused summary, maybe?


> Also CC'ing John, who I believe tried to upstream this patch before.

We sort of went in a big circle of creating a config time option w/
CAP_SYS_NICE, then a new CAP_CGROUP_MIGRATE then switching to
CAP_SYS_RESOURCE and then back to CAP_CGROUP_MIGRATE, and when that
was panned I gave up and we kept the small patch in the Android tree
that uses CAP_SYS_NICE.

Links to previous attempts & discussion:
v1: https://lore.kernel.org/lkml/1475556090-6278-1-git-send-email-john.stultz@linaro.org/#t
v2: https://lore.kernel.org/lkml/1476743724-9104-1-git-send-email-john.stultz@linaro.org/
v4: https://lore.kernel.org/lkml/1478647728-30357-1-git-send-email-john.stultz@linaro.org/
v5: https://lore.kernel.org/lkml/1481593143-18756-1-git-send-email-john.stultz@linaro.org/

thanks
-john
