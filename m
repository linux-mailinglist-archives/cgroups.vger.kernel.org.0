Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45D2208F7
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPODX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 10:03:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40965 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPODX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 10:03:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id g8so3507621otl.8
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A0jIRjjrX5qk5QJs7UAl2yKQShbcxJfUChlkRjdVYcY=;
        b=ErCWxkgR+nXomtoUR4fY/ddK8L5X7ssVnlmZCLlqLK4Wwt5LBHNQYTJuJz54lCMjJr
         Nd6h5e3hKxDWvATBUOTA2mmC+cBRpD+sDhYXShYq5UkxcemB0jFiZzndVj4d0YhDXCsA
         INKgWNMaPszz6fH9IjcZuxvxU36oHghpeipNiR7vMnmQmfyjhu/ZI+D1qkwd/34/eWqc
         VSFRWh4DeMZGwLXwr9YYlU7IoBYuPBr9sXTnfGQJQCQ8JMn0dWssVQE0VJ9mWD71zxeO
         xI8S+JFE0wbMkIS8zgqLk3nC8zOQVDCge0m1v3JkHhuoOC1g5Gnxcfur8CXmJZNvovjc
         3/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A0jIRjjrX5qk5QJs7UAl2yKQShbcxJfUChlkRjdVYcY=;
        b=NJn85TxANW4wWDhM805JxYzGLpmPbXgz0VJeS2IoQC7M5NHwCbZ4TZ3zbNWzuK1JRD
         ENWGqJSWJcjNfR1lqiZ6OYZLnEN1/MAGT2fHHO6YQ2c4kJqvK++0TaTEj2qGEfDHqnhW
         BECWRjS2wS/ptAHwvuHalkuV1u3JhT4b/giJu5rxBqbKe1F/vdwOUrsCiqEW0kbD9ckd
         0/VVjZvaFFhaK4BJRrZZ/puLqoWwAqKIjs6+ytYYJMsewJPqK/fTTgNh95iGnX4bEtp/
         rSKaPL5ny0EOnUwKZimrazaLzWMXVbLjA+efDcmGm9eji4yZyhw6WyO8d0Oy0xyjOW5a
         NpMQ==
X-Gm-Message-State: APjAAAUOgSQrWDpeynHn3Wx+hrCUCxPKsHRvQLZpaKC9olN6nWtE820P
        1Z99ElwPkpxRSedVzhPA8fxGPDzzZ8hb9r867YQ=
X-Google-Smtp-Source: APXvYqxoiKtk36BcJTLdZmrGDGJjZ9eIwAOZ5N2t5FqGPQmjWY1EO8INR+yd7kDU1yYAfYEdg9BLaOAEgZ14ps/SxM0=
X-Received: by 2002:a9d:3c2:: with SMTP id f60mr27239946otf.74.1558015402560;
 Thu, 16 May 2019 07:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
 <7db2caae-7eab-7c6a-fe90-89cb9cae30b4@amd.com> <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
In-Reply-To: <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 16 May 2019 10:03:10 -0400
Message-ID: <CAOWid-fQgah16ycz-V-ymsm7yKUnFTeTSBaW4MK=2mqUHhCcmw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Welty, Brian" <brian.welty@intel.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 3:25 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> Am 16.05.19 um 09:16 schrieb Koenig, Christian:
> > Am 16.05.19 um 04:29 schrieb Kenny Ho:
> >> On Wed, May 15, 2019 at 5:26 PM Welty, Brian <brian.welty@intel.com> w=
rote:
> >>> On 5/9/2019 2:04 PM, Kenny Ho wrote:
> >>>> Each file is multi-lined with one entry/line per drm device.
> >>> Multi-line is correct for multiple devices, but I believe you need
> >>> to use a KEY to denote device for both your set and get routines.
> >>> I didn't see your set functions reading a key, or the get functions
> >>> printing the key in output.
> >>> cgroups-v2 conventions mention using KEY of major:minor, but I think
> >>> you can use drm_minor as key?
> >> Given this controller is specific to the drm kernel subsystem which
> >> uses minor to identify drm device,
> > Wait a second, using the DRM minor is a good idea in the first place.
> Well that should have read "is not a good idea"..
>
> I have a test system with a Vega10 and a Vega20. Which device gets which
> minor is not stable, but rather defined by the scan order of the PCIe bus=
.
>
> Normally the scan order is always the same, but adding or removing
> devices or delaying things just a little bit during init is enough to
> change this.
>
> We need something like the Linux sysfs location or similar to have a
> stable implementation.

I get that, which is why I don't use minor to identify cards in user
space apps I wrote:
https://github.com/RadeonOpenCompute/k8s-device-plugin/blob/c2659c9d1d0713c=
ad36fb5256681125121e6e32f/internal/pkg/amdgpu/amdgpu.go#L85

But within the kernel, I think my use of minor is consistent with the
rest of the drm subsystem.  I hope I don't need to reform the way the
drm subsystem use minor in order to introduce a cgroup controller.

Regards,
Kenny
