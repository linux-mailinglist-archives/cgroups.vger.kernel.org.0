Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A644C209A2
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEPO2f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 10:28:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34612 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPO2f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 10:28:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so2683167oib.1
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HNCPXbXdkNL0q2efwNiVVUF3BwJuEulbMOCTiuMBkQo=;
        b=Pe2Hrgi3rl1YpSJ8NJr4Tpje2qgKcnan4/2zSTdWJuPN7Nt1wEj2RY9vZVJUjJ/LdC
         jNZmEGyphX1wJZwSYRrmb2kwY7E499VygRET2OuBM2Nzn+mHAbTiEPPJXhIMto53j+uG
         w5GPLXQ5J28pHdZGJ/EYy9XfKdTK85kfNP0m2RBiiUzPF/W4a76InK799UICRaOFZ6iW
         nVSydjjH7LoHypT182DoMivQ8brmxXrTCcOkSh8Vus5Lbeo/mqsnP58dkadHlFPCq/Xa
         7jXqUhg70wynmyglCfvIZndpmd+2Yykk1U0MI4Pd0lCiyhN9EESyM2gY54vQIbZqawg0
         B1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HNCPXbXdkNL0q2efwNiVVUF3BwJuEulbMOCTiuMBkQo=;
        b=J5f6Trrn5mtJs0o521Inxyn6C+arFkk8EdzuZkUovnaksL8zqGlNqQYTwBYDBZb/2V
         4UNAakXAi4Y4dM55svoay0PG99dsEasP/vBSQCPNm3kpTzTb6j1qgn6Fxn6pdzMzd4QR
         NSlXoKiwqRmdI/fSQtkcrn7SwhsiLRQfHqvIxGSPOW4aQOxBYG6xbzLuByqlUlksE1Ic
         8++eQzcMQXy/IXdABgzKP6jciFGPEi3V2koqU5nq1w1J8G9rt/fRz45ANB36o50P9g47
         EB2xX7Ui5a5Gj1W7P3RMVrpRKF4MyzNParB6X5IZKFJQkvqMjlQdHRrUPNyLk0W4DGiv
         wFkg==
X-Gm-Message-State: APjAAAU8VYluDqijoQCtjPPo4JD+vURjLedRUfsxtiPYh4CDz6lCZUYE
        AKS9Rrrl1e/A+V5TTy7cgLRIzqA8ycWVwGHgKks=
X-Google-Smtp-Source: APXvYqwqbyaNrB2yMGJVvh5LcPxc72syzTwAVLL+tr+bhKoHch8JsMIVB02QrLGM1IEBPykmw4aIocbX35qVGz63pxs=
X-Received: by 2002:aca:5b83:: with SMTP id p125mr10507062oib.164.1558016914865;
 Thu, 16 May 2019 07:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
 <7db2caae-7eab-7c6a-fe90-89cb9cae30b4@amd.com> <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
 <CAOWid-fQgah16ycz-V-ymsm7yKUnFTeTSBaW4MK=2mqUHhCcmw@mail.gmail.com> <1c50433e-442b-cada-7928-b00ed0f6f9d2@gmail.com>
In-Reply-To: <1c50433e-442b-cada-7928-b00ed0f6f9d2@gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 16 May 2019 10:28:23 -0400
Message-ID: <CAOWid-d=RwJ3_x1emhH_hh6TcfZPLyDYiPtv1-4Fa_y13v+Jbg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "Welty, Brian" <brian.welty@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 10:12 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> Am 16.05.19 um 16:03 schrieb Kenny Ho:
> > On Thu, May 16, 2019 at 3:25 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 16.05.19 um 09:16 schrieb Koenig, Christian:
> >> We need something like the Linux sysfs location or similar to have a
> >> stable implementation.
> > I get that, which is why I don't use minor to identify cards in user
> > space apps I wrote:
> > https://github.com/RadeonOpenCompute/k8s-device-plugin/blob/c2659c9d1d0=
713cad36fb5256681125121e6e32f/internal/pkg/amdgpu/amdgpu.go#L85
>
> Yeah, that is certainly a possibility.
>
> > But within the kernel, I think my use of minor is consistent with the
> > rest of the drm subsystem.  I hope I don't need to reform the way the
> > drm subsystem use minor in order to introduce a cgroup controller.
>
> Well I would try to avoid using the minor and at least look for
> alternatives. E.g. what does udev uses to identify the devices for
> example? And IIRC we have something like a "device-name" in the kernel
> as well (what's printed in the logs).
>
> The minimum we need to do is get away from the minor=3Dlinenum approach,
> cause as Daniel pointed out the minor allocation is quite a mess and not
> necessary contiguous.

I noticed :) but looks like there isn't much of a choice from what
Tejun/cgroup replied about convention.

Regards,
Kenny
