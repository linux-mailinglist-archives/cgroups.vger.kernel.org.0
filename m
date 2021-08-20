Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36973F2ECC
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhHTPVh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbhHTPVb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 11:21:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F751C061756;
        Fri, 20 Aug 2021 08:20:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf2so2421014ejb.9;
        Fri, 20 Aug 2021 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8KKw/Y3X2cc5tVMPl/kxkct9qTUI3pzXDdZwfJk130I=;
        b=srQGGc4i2tywZ5Qnahhh6GTqbqMNOHKen/sEg/S9W/n/RVwuBH24EsDhB9eOpj+RXX
         rpFj4gL5cKEV/2e20kJduWblm0chvohY959cUsSFRn7xmfcPWHf88ju/w8mHqD4Ijl0a
         o4LRGAP30Vxhxx7FZomjjxS8qoOPXplCmt9MT40wZWO2xdiOBMJPv7tmN3j8Hlc/Xyx2
         vTgCTo5YUZgQFd4oGf0o1nDSUuQ8jaegH6GuMZ1AxkSsROawGppbKgBJJ7NYlDkVPA4f
         BLNnVVZIWD6bd+i9ytSr/uvicx6QSwZsgN/UX9WrAkBcEv3vzJPhYAfiPcbsiStFi7oK
         MN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8KKw/Y3X2cc5tVMPl/kxkct9qTUI3pzXDdZwfJk130I=;
        b=s1XZa6m5bo9FuCmELDkeQRGo5P1PGCcytZ7kYopCkge0cVClcMZHCUbccjr0m+f6XV
         zc1pxx+HZ8W7UVRlKonnqKV7mMakms0EKRIpKlRXvcjRQM8dujjpM6xaWUKWWZNTs4Cb
         Ov42EqOiwR4SYa1Hts0CWMmUwA/O+o3QrUf/yGWsiTs4dJ0hZ33gfi1OJJJkMhdpuX/R
         PmskZi4xgr5fqJu1LocmkgNbRN2XuC1kov7uviexc4SjkFYUt7WNAgLLdib665n59/Tg
         nMZIvOsFYFD7m5uDdjzntNe/oxvJb9TeY9/J74ideRLnZFSFUUcOaAdxc1R78J2E3WUZ
         S6Kg==
X-Gm-Message-State: AOAM530uI9Tuoq0SrJFOU1/SVOcKHbE3kiKrNwDO7ro7v8aepsRPsAcb
        ZHYH1y87HYa5DJVtwZ/XcBXHuGya2wjBm+2l+gs=
X-Google-Smtp-Source: ABdhPJw1x49PqwFmrpp5sYyS45+q8xBuz9j8fq1eNnSPU+nccRcOxAg6jxC9zxPHiYdVyZaH5lO1SpPAuV9TdsTyef0=
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr22082804eje.240.1629472851367;
 Fri, 20 Aug 2021 08:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn> <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz>
In-Reply-To: <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz>
From:   yong w <yongw.pur@gmail.com>
Date:   Fri, 20 Aug 2021 23:20:40 +0800
Message-ID: <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu 19-08-21 16:53:39, yongw.pur@gmail.com wrote:
> > From: wangyong <wang.yong@zte.com.cn>
> >
> > Inspired by PSI features, vmpressure inotifier function should
> > also be configured to decide whether it is used, because it is an
> > independent feature which notifies the user of memory pressure.
>
> Yes, it is an independent feature indeed but what is the actual reason
> to put a more configuration space here. Config options are not free both
> from the user experience POV as well as the code maintenance. Why do we
> need to disable this feature. Who can benefit from such a setup?
>
> > So we add configuration to control whether vmpressure notifier is
> > enabled, and provide a boot parameter to use vmpressure notifier
> > flexibly.
>
> Flexibility is nice but not free as mentioned above.
>
> > Use Christoph Lamenter=E2=80=99s pagefault tool
> > (https://lkml.org/lkml/2006/8/29/294) for comparative testing.
> > Test with 5.14.0-rc5-next-20210813 on x86_64 4G Ram
> > To ensure that the vmpressure function is executed, we enable zram
> > and let the program occupy memory so that some memory is swapped out
> >
> > unpatched:
> > Gb    Rep     Thr     CLine   User(s) System(s) Wall(s) flt/cpu/s     f=
ault/wsec
> > 2     1       1       1       0.1     0.97    1.13    485490.062      4=
63533.34
> > 2     1       1       1       0.11    0.96    1.12    483086.072      4=
65309.495
> > 2     1       1       1       0.1     0.95    1.11    496687.098      4=
69887.643
> > 2     1       1       1       0.09    0.97    1.11    489711.434      4=
68402.102
> > 2     1       1       1       0.13    0.94    1.12    484159.415      4=
66080.941
> > average                               0.106   0.958   1.118   487826.81=
62     466642.7042
> >
> > patched and CONFIG_MEMCG_VMPRESSURE is not set:
> > Gb    Rep     Thr     CLine   User(s) System(s) Wall(s) flt/cpu/s     f=
ault/wsec
> > 2     1       1       1       0.1     0.96    1.1     490942.682      4=
73125.98
> > 2     1       1       1       0.08    0.99    1.13    484987.521      4=
63161.975
> > 2     1       1       1       0.09    0.96    1.09    498824.98       4=
76696.066
> > 2     1       1       1       0.1     0.97    1.12    484127.673      4=
65951.238
> > 2     1       1       1       0.1     0.97    1.11    487032          4=
68964.662
> > average                               0.094   0.97    1.11    489182.97=
12     469579.9842
> >
> > According to flt/cpu/s, performance improved by 0.2% which is not obvio=
us.
>
> I haven't checked how are those numbers calculated but from a very brief
> look it seems like the variation between different runs is higher than
> 0.2%. Have you checked the average against standard deviation to get a
> better idea whether the difference is really outside of the noise?
> --
> Michal Hocko
> SUSE Labs

Thanks for your reply.
The reason for adding configuration is as follows=EF=BC=9A
1. Referring to [PATCH] psi: make disabling/enabling easier for vendor
kernels, the modification
is also applicable to vmpressure.

2. With the introduction of psi into the kernel, there are two memory
pressure monitoring methods=EF=BC=8C
it is not necessary to use both and it makes sense to make vmpressure
configurable.

3. In the case where the user does not need vmpressure,  vmpressure
calculation is additional overhead.
In some special scenes with tight memory, vmpressure will be executed
frequently.we use "likely" and "inline"
to improve the performance of the kernel, why not reduce some
unnecessary calculations?

4. This patch is forward compatible, because VMPRESSURE is set by
default and user does not need to
make any changes. For users who do not need to use vmpressure notifier
or users who use psi, they
can choose not to configure this function.

Thanks.
