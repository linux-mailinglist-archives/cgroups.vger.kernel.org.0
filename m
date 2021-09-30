Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEC41E339
	for <lists+cgroups@lfdr.de>; Thu, 30 Sep 2021 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbhI3VWt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Sep 2021 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349279AbhI3VWs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Sep 2021 17:22:48 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF15C06176A
        for <cgroups@vger.kernel.org>; Thu, 30 Sep 2021 14:21:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 71so16230600ybe.6
        for <cgroups@vger.kernel.org>; Thu, 30 Sep 2021 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c+ez2fuj6x2arikU4FELGnLHBGOaPBSZKyEOfKhurP0=;
        b=Vjck3gCd3Rwg2cn5LKRjQog78fLTppRrQ4DyI31rbFU8aucgUnMYfxuS+Sq30YpzRT
         RhDZXELtttMX+dNOY/hYQgHdjzJdsgRnbwAdl8zRc5AMFMFNWa+TxLyaobvvFzafzbQp
         IbcMay1giYTIjiJwwjQy/W7o+Tr20zAjm6w9r9al838MBHHNlHzAY3Uhgmwj6fj/qDGj
         FrHGFt639+INeUtXdPbeeVB9HOQMTP4uA1pCyIqjEBE+mi3haLKx0S4uQHUPP9UvVm6O
         aG0tRL+7/tE8RVnGzPeUWQVdP+WhFbJ1sinaB8TpJk8/yEkatmPnIjuGVISSwB/Hz4GM
         j4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+ez2fuj6x2arikU4FELGnLHBGOaPBSZKyEOfKhurP0=;
        b=sWzs3ZjttZK+vr3t9sYop4T0+gL8UHN+4OhrQ4rgf5l11NM81KZxOombMCvXqK+kCI
         LEMJ7Ix7ZEc3FiX61S1HXXrQHod+ruh8MK20m+iBx5aypn5DCb1AtXkbtmX76WSDhIrv
         5mNBY+K/4yyiXy1apL9WYltCIeUUK9E2b0jdE3/d1um3WcF4eowhY6LFE+7PKFxXJOPE
         e41ZYG9eFj8zPu7pTPPhwfPLfnyQrZ/0YhgfRRDH/RYSAEz4bJNOQwkDlGLlrsSi7QPc
         EGFEQBYPxlUOK78/rexdHQQedc6fGQ7RKydH1lUTJcPoigRODFwKLvsu6J5ByB/xQeLH
         mcEA==
X-Gm-Message-State: AOAM533obxVD3ZGmDX2SqhP1YSTPMkJeJuWGQe8SL9VMPaYNKD7YtWFQ
        O6jqBSxOVmhXlFmLLFxWW8iMnudHzvcqHRrdXK4WnE2qdkDcyg==
X-Google-Smtp-Source: ABdhPJx86zYXulMWYBLCXQl/i7aAO2kQWmNpbDlpztuEhS2zCzBVL8Nf4EI7/nnOx0C5QiTjtGkhRpi+mv20B+tQ26A=
X-Received: by 2002:a25:d1d3:: with SMTP id i202mr1880759ybg.487.1633036864611;
 Thu, 30 Sep 2021 14:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210617090941.340135-1-lee.jones@linaro.org> <YMs08Ij8PZ/gemLL@slm.duckdns.org>
 <YMs5ssb50B208Aad@dell>
In-Reply-To: <YMs5ssb50B208Aad@dell>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Sep 2021 14:20:53 -0700
Message-ID: <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 17, 2021 at 5:02 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Hi Tejun,
>
> Thanks for your reply.
>
> On Thu, 17 Jun 2021, Tejun Heo wrote:
> > On Thu, Jun 17, 2021 at 10:09:41AM +0100, Lee Jones wrote:
> > > It should be possible for processes with CAP_SYS_NICE capabilities
> > > (privileges) to move lower priority tasks within the same namespace t=
o
> > > different cgroups.
> >
> > I'm not sure that "should" is justified that easily given that cgroup c=
an
> > affect things like device access permissions and basic system organizat=
ion.
>
> The latter part of that sentence does provide some additional caveats.
>
> > > One extremely common example of this is Android's 'system_server',
> > > which moves processes around to different cgroups/cpusets, but should
> > > not require any other root privileges.
> >
> > Why is this being brought up now after all the years?

Currently Android uses an out-of-tree patch to work around this issue.

>
> This has been discussed before?
>
> I didn't find any evidence of that on the lists.

IIRC, John Stultz from Linaro tried to upstream a similar patch before.

>
> > Isn't android moving onto cgroup2 anyway?
>
> That I would have to check.

Some of the controllers are moving to cgroup v2 but not all of them
are there yet. For example, there are still some issues with moving
the cpu controller to v2 which I believe were discussed during Android
Microconference at LPC 2021.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
