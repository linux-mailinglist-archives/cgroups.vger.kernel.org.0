Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE220946
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfEPOMs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 10:12:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEPOMs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 10:12:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so3431638wrv.2
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lSwbFWzRiS8FZuFJszUREBuA/RBtw3ld1q66H70SoTI=;
        b=Uko2mgZrKk4b9lz6lS3uhyQnaceHyGNZWwcgSU2iuowhTsGzwK6e2wzRnsR6dMcxN0
         LptM5PbOFAIrGEsnd54Y8GlCxHO7Ko1Oax/xYIDr07K2aY9glOZEUjNLiec4i0G0Hg/s
         7iEcpwcQJqUrBersyzxZymlvs8t4KYnD479zMAxvdfekYSOX6QTqz45S02NsIHMxbpPz
         sIuhlXOwRU4qa/uiORC63hEnCCkWyxo7rIOJPfSNDzTmw6ETo3PVLKQiWQlL93oTyQ2R
         bEoUXnB7REXZw/RsxhEgjF6pFnGTp/OZyGpsOK2Gw3LEsFoo91dBsDJMXzRvPbTujS4V
         UvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=lSwbFWzRiS8FZuFJszUREBuA/RBtw3ld1q66H70SoTI=;
        b=BaWSXM8+ln82fI/yP4Wti7k+gWnd9EC3VG/cUQ323wjCYkl+Y6b59pDqAWvaERyInV
         8o23UMx5s9UxRDfKSAaR08qHKYE4W8Jgevq2Qj09kKnmRyjmIcdDyrIDVd3Ee9g7gbdV
         eOnZjxaWemNYNuOzC2woyfr9i/6o0NwzLxhuLOnVgU15rm02cDTWNCpr2eg8bnZKi4ex
         /vvUWAQa7nvUPcY0ZOtJNzOlkP4Tygg5hYF6TwYb+gc0sp6iXaVyqNjfMi239c9sSzlR
         2V1ofx2/9WcN2VZ18HbEKvRjBaQXVFqu5v1LFRwH8jEAcN8O1B7RepVz88O9lHrus3da
         xorQ==
X-Gm-Message-State: APjAAAUbqCNaZfvzWsFtsblmNGjvWcaGCT8kBLYqZ0vDffolTGX4EbCf
        p+DdNMVTeXnIjEuA6lK3JVCkzPyK
X-Google-Smtp-Source: APXvYqxSSO3ZWWMBPz0oHOCL9eMrinbzzDReUF3UBViYg3o0NnEQ4bFGsajhnTYXG3U9vuStZF1itg==
X-Received: by 2002:adf:aa09:: with SMTP id p9mr4050839wrd.59.1558015965837;
        Thu, 16 May 2019 07:12:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id d3sm7480770wmf.46.2019.05.16.07.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:12:45 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation
 limit
To:     Kenny Ho <y2kenny@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "Welty, Brian" <brian.welty@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com>
 <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
 <7db2caae-7eab-7c6a-fe90-89cb9cae30b4@amd.com>
 <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
 <CAOWid-fQgah16ycz-V-ymsm7yKUnFTeTSBaW4MK=2mqUHhCcmw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1c50433e-442b-cada-7928-b00ed0f6f9d2@gmail.com>
Date:   Thu, 16 May 2019 16:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOWid-fQgah16ycz-V-ymsm7yKUnFTeTSBaW4MK=2mqUHhCcmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 16.05.19 um 16:03 schrieb Kenny Ho:
> On Thu, May 16, 2019 at 3:25 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 16.05.19 um 09:16 schrieb Koenig, Christian:
>>> Am 16.05.19 um 04:29 schrieb Kenny Ho:
>>>> On Wed, May 15, 2019 at 5:26 PM Welty, Brian <brian.welty@intel.com> wrote:
>>>>> On 5/9/2019 2:04 PM, Kenny Ho wrote:
>>>>>> Each file is multi-lined with one entry/line per drm device.
>>>>> Multi-line is correct for multiple devices, but I believe you need
>>>>> to use a KEY to denote device for both your set and get routines.
>>>>> I didn't see your set functions reading a key, or the get functions
>>>>> printing the key in output.
>>>>> cgroups-v2 conventions mention using KEY of major:minor, but I think
>>>>> you can use drm_minor as key?
>>>> Given this controller is specific to the drm kernel subsystem which
>>>> uses minor to identify drm device,
>>> Wait a second, using the DRM minor is a good idea in the first place.
>> Well that should have read "is not a good idea"..
>>
>> I have a test system with a Vega10 and a Vega20. Which device gets which
>> minor is not stable, but rather defined by the scan order of the PCIe bus.
>>
>> Normally the scan order is always the same, but adding or removing
>> devices or delaying things just a little bit during init is enough to
>> change this.
>>
>> We need something like the Linux sysfs location or similar to have a
>> stable implementation.
> I get that, which is why I don't use minor to identify cards in user
> space apps I wrote:
> https://github.com/RadeonOpenCompute/k8s-device-plugin/blob/c2659c9d1d0713cad36fb5256681125121e6e32f/internal/pkg/amdgpu/amdgpu.go#L85

Yeah, that is certainly a possibility.

> But within the kernel, I think my use of minor is consistent with the
> rest of the drm subsystem.  I hope I don't need to reform the way the
> drm subsystem use minor in order to introduce a cgroup controller.

Well I would try to avoid using the minor and at least look for 
alternatives. E.g. what does udev uses to identify the devices for 
example? And IIRC we have something like a "device-name" in the kernel 
as well (what's printed in the logs).

The minimum we need to do is get away from the minor=linenum approach, 
cause as Daniel pointed out the minor allocation is quite a mess and not 
necessary contiguous.

Regards,
Christian.

>
> Regards,
> Kenny
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

