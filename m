Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E740FCB6
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbhIQPkJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbhIQPkH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 11:40:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A5C061574;
        Fri, 17 Sep 2021 08:38:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c21so31267478edj.0;
        Fri, 17 Sep 2021 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zxCLMiwgNRNijtEYpMVJcX6xlScUvdnPIRXCubpCOuE=;
        b=Y0S+zKjpf3Rgo+qWJaUXBauspRABthhE5vW8jiUnn2i4SxsmTCovLFND1qUoBfJKLN
         XUSSCxC1YRkj7NyGevUuDKtg6/K8clJWXyAFSYBa/jAh9r1oZMe6WhnlbcCWqRlKtEC8
         qSL0j35NOoBrV4IRdPAReh5OTfuGWnbPwUiLjrfBqs3ZfGj8RWsLxx/yJSuAn1lJoyoN
         Sfk9XbCDZFbkJEcl5K4okuAJ8Fnh+AM++3HMl8yHSejRPCWHCUhXq1a5HUTabRxiYUhY
         4CPVf0vq4zD2uHEsrP6JAEq51HlEDVIpc7W7eQNJ5rUFqsYi4IJDsUmH4k/AisP+FDO6
         U7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zxCLMiwgNRNijtEYpMVJcX6xlScUvdnPIRXCubpCOuE=;
        b=kzfXvz1j3uw1LN/WhixOj001MUvI/T0AzjT6795phMnDeh8er0Nf6ZtGaLa1uq9/we
         fpnLnCFjMFfR0mfacgE6cqVj5hHfaBsoZUaiftBlx88O0uY+IP3wLzqH/6zgEg2Zkw7+
         FG15BHo/0VpFUUfdoromglgZ0so2piirh9CFKwzwy0IEtk3olUnHa+/f8q2Kq88s8xbG
         lRzzRwLlwMe+1FaE+0fCltixI2rrXe0RK6aRZKBGy/r9UQcgLxoutuTlPA97vSF0HvGh
         /t36+jtnZ1bM2wLCL1VBTApkR1uenN+jYrnax6KkPubjm6F9PZiDZNeeiIoprmta07X1
         0shg==
X-Gm-Message-State: AOAM530KhZMF4aZ8amAAtSzXTtBLO5d27DwCbwxE4Heu+L/48Cb/uJ3J
        GyxdnHigAzyYFFY5qzetE64Pk7WfKkLCqMqTKGs=
X-Google-Smtp-Source: ABdhPJzuTeICPGu0FEYeFqBrz2DYqD4swqzp/3wVCprj2Nwqq4Irleac2DOscZZ36VisVtuBaLgFLoCv8/qAfZ2Tz1o=
X-Received: by 2002:a17:906:3c56:: with SMTP id i22mr12938477ejg.287.1631893122771;
 Fri, 17 Sep 2021 08:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <1631635551-8583-1-git-send-email-wang.yong12@zte.com.cn> <YUHqG0P6Ahs8FvN+@dhcp22.suse.cz>
In-Reply-To: <YUHqG0P6Ahs8FvN+@dhcp22.suse.cz>
From:   yong w <yongw.pur@gmail.com>
Date:   Fri, 17 Sep 2021 23:38:31 +0800
Message-ID: <CAOH5QeB==iASFSeHWZXT0ESBCN5W6mJ8cugJih1uKpqJZbtgqQ@mail.gmail.com>
Subject: Re: [PATCH v2] vmpressure: wake up work only when there is
 registration event
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 14-09-21 09:05:51, yongw.pur@gmail.com wrote:
> > From: wangyong <wang.yong12@zte.com.cn>
> >
> > Use the global variable num_events to record the number of vmpressure
> > events registered by the system, and wake up work only when there is
> > registration event.
> > Usually, the vmpressure event is not registered in the system, this pat=
ch
> > can avoid waking up work and doing nothing.
>
> I have asked in the previous version and this changelog doesn't that
> explain again. Why don't you simply bail out early in vmpressure()
> entry?
Thanks for your reply.
Because the else branch will modify the socket_pressure, and will not wake =
up
the work. It is necessary to judge the tree parameters at the same
time, like this
if (tree && !static_branch_unlikely(&num_events))
    return;
It's not good to judge the tree twice parameters in the function.
>
> > Test with 5.14.0-rc5-next-20210813 on x86_64 4G ram.
> > Consume cgroup memory until it is about to be reclaimed, then execute
> > "perf stat -I 2000 malloc.out" command to trigger memory reclamation
> > and get performance results.
> > The context-switches is reduced by about 20 times.
>
> Is this test somewhere available so that it can be reproduced by
> others. Also while the number of context switches can be an interesting
> it is not really clear from this evaluation whether that actually
> matters or not. E.g. what does an increase of task-clock and twice as
> many instructions recorded tell us?
>
The test program is a simple malloc  process, which allocate memory
and fill some data.
I think it may be that more instructions can be executed per unit time.
> > unpatched:
> > Average of 10 test results
> > 582.4674048   task-clock(msec)
> > 19910.8               context-switches
> > 0             cpu-migrations
> > 1292.9                page-faults
> > 414784733.1   cycles
>
> > <not supported>       stalled-cycles-frontend
> > <not supported>       stalled-cycles-backend
>
> Why is this a part of the data?
>
> > 580070698.4   instructions
> > 125572244.7   branches
> > 2073541.2     branch-misses
> >
> > patched
> > Average of 10 test results
> > 973.6174796   task-clock(msec)
> > 988.6         context-switches
> > 0             cpu-migrations
> > 1785.2                page-faults
> > 772883602.4   cycles
> > <not supported>       stalled-cycles-frontend
> > <not supported>       stalled-cycles-backend
> > 1360280911    instructions
> > 290519434.9   branches
> > 3378378.2     branch-misses
> >
> > Tested-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > ---
> >
> [...]
> > @@ -272,6 +277,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg=
, bool tree,
> >               return;
> >
> >       if (tree) {
> > +             if (!static_branch_unlikely(&num_events))
> > +                     return;
>
> We usually hide the change behind a static inline helper (e.g.
> vmpressure_disabled()). I would also put it to the beginning of
> vmpressure or put an explanation why it makes sense only in this branch.
> --
Because only this branch needs to wake up work.
Yes, static inline helper is more easier to read and understand.
