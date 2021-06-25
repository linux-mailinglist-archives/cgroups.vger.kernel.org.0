Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8FE3B429A
	for <lists+cgroups@lfdr.de>; Fri, 25 Jun 2021 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhFYLh1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Jun 2021 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYLh1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Jun 2021 07:37:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247FC061574
        for <cgroups@vger.kernel.org>; Fri, 25 Jun 2021 04:35:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f13so12056884ljp.10
        for <cgroups@vger.kernel.org>; Fri, 25 Jun 2021 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CvU9SJEajbsXtfHda6+kKDOJRbuR3DlWfO4uCMK/qPI=;
        b=Ds0LgUziVbhxE9Pg2UM2H+gxbvMESW5DSHxWrgkyl/gSNhV/VEHUikNS5JtUac4mzQ
         kSHeXy3mNAxUOARUomSr8brTzYoZDZ3XRZOaUAkZO6d/VprbI2cHoF0CVZfC8uWeau6r
         nAEsfkx0r42HUCcxMgrr/vEnoCE5prmU3UeA7HXMFfVmbjnCssqP/o4BS5pfMzf+bhsB
         CyhKA6nkZKF5TWSu3CwWw/wIgMKYmcuMslUtNYYMGL0t7MoUR+io7A43ExDXIpf/lZOi
         w63O3sUgnX3r3FNmSJRFqr+4pAjfqvTYZT/3PxfmqxASTtRe4IeH647HdEDcT9yN7A63
         3Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CvU9SJEajbsXtfHda6+kKDOJRbuR3DlWfO4uCMK/qPI=;
        b=f6FJkF/GWUKcRIdkZBiUQrssJv6M1iCv2dUz2/6iMDl1D9I9KGw3NV1/MN3ldLuxvN
         Mm1G3dsUqUxN57Tb9MO4zlhKBs3PfNcb5jbKYYGL8ITfE4YyUe2JlvN2DuswkJpfgkm/
         fEVWWt6R2dB77AW9/YH0UlTDD81dHQVODZZg90xk3PlJmKrFS/3H0Nrg8S/S7qlqOZFN
         jbAo+XeYQm+NZlUQS00SrFFj1fM0jIKT2/UBgaheOR7Uq9ALgqCYEflvUPTCo7cxLOHO
         b0VRpNY9juJCeg33AzgaOMSrjCvB63R95k0/dX1zcAV0FKvLm7bb0ZO5qBwNVp/a8Kfd
         rSww==
X-Gm-Message-State: AOAM5317/Clpo8wma/3rnideXNaFFVNxQQsd0URztZoXDGHqp9izNZG3
        r49r4HPAxsgXGEiFHy+2uv/mZq4qiuCtEGW6UYE=
X-Google-Smtp-Source: ABdhPJx4Y85mO1UmOSybKixfat2x4n1Uk8C26/KLAeMI0Ej/Nsj6BaqqAWW+8EY41BD9yOhcsh3emmZ8TcxLEJcnhJo=
X-Received: by 2002:a2e:8589:: with SMTP id b9mr8130314lji.2.1624620904765;
 Fri, 25 Jun 2021 04:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
 <YNNvK0koEdkuD/z3@blackbook> <CAMJ=MEfMSX06-mcKuv54T7_VCCrv8uZsN-e-QiHe8-sx-sXVoA@mail.gmail.com>
 <YNWZW/WhdP50F4xy@blackbook>
In-Reply-To: <YNWZW/WhdP50F4xy@blackbook>
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Fri, 25 Jun 2021 13:34:53 +0200
Message-ID: <CAMJ=MEfCpY-ZRq_mXUOU6=w9vvgNpF3DWGBWbGz6GzoY6bYtSQ@mail.gmail.com>
Subject: Re: Short process stall after assigning it to a cgroup
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Op vr 25 jun. 2021 om 10:52 schreef Michal Koutn=C3=BD <mkoutny@suse.com>:
>
> On Fri, Jun 25, 2021 at 09:32:59AM +0200, Ronny Meeus <ronny.meeus@gmail.=
com> wrote:
> > The application does not have strict RT requirements.
>
> Can you even use the normal non-RT scheduling policy? ...

No since we want certain functions (like packet processing) to have a
higher priority than for example management activities.

>
> > We were working with fixed croups initially but this has the big
> > disadvantage that the unused budget configured in one group cannot be
> > used by another group and as such the processing power is basically
> > lost.
>
> ...then your problem may be solvable with mere weights to adjust prioriti=
es
> of competitors. (Or if you need to stick with RT policies you can assign
> different priorities on task basis, I wouldn't use RT groups for that.)
>
> > About the stack: it is difficult to know from the SW when the issue
> > happens so dumping the stack is not easy I think but it is a good
> > idea.
> > I will certainly think about it.
>
> You may sample it periodically or start prior a migration to get more
> insights what's causing the delay.
>

I observed that when I create the cgroups dynamically (at the moment I
need them) and immediately assign the threads to it, the symptom seems
to be gone.
I'm going to observe the system some more to confirm that the problem
is really solved in this way.

Thanks Michal for the time you spent on this.

> Regards,
> Michal
>
