Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8820037
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEPHZg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 03:25:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33202 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPHZf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 03:25:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so2147752wrx.0
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iPx+wmq2nYYFuwabzIBwS3Yxgni0laEJwbwdB3cf5pk=;
        b=GQ+qJ+BtGAoop2xLovP/SWd9hEMgh1JfEFVnqNyiQ/wxjSfPrDlvkTFpdmZ3mSa+Jz
         36umW5lx+vKZj88JxalbVo+Dxn4IBqZHQOEFsWO7Lfz+K8AEDqhDAuLy1kIxdJ2cWmUd
         y10KX8td8bT7FaQ+z3TfuL73JIev6uiscU1jAZbNcIioclRYFDU8nXlLUZjfrddf9AyX
         8TSRKJSM5Iuxj9aO3qB+VGykVBu0kL/tLSmaEi3vIHv1sgTl3dNIpHqJBT89xJzzGYDc
         Q94FIVLxi9fu+BGjvz8+LsNGksvFpWXD9QVPYB72LudZcVkf99b9m4jjjyeRFTx9lOPj
         nf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=iPx+wmq2nYYFuwabzIBwS3Yxgni0laEJwbwdB3cf5pk=;
        b=mSjoiPD66Ai2RfnAfDUf9q54e6DPCTAJgfaQln4dfuiUnX8Xk5vyp0CZq5f3Cv5p3R
         +D9e6c90qcgTzT3NLnklbTLN5YZc5VHrTCbi9L6gahpfX0y7noT+F9EDZkWwmHh9nTKD
         6sdoefX4Wvo8Lm395mAmkYl1AaLcS0gyPj5Tq4dqQzhrjp6Ce79RWzJXqNEPSMx/8mt4
         RzKVG54N5oVk4JqOwIOl7UiJ5vlv16HoS/CN2UjwnhfYOHt9sf78YOTKFqTLm8Bhya1N
         ZIbQ2uVObzIHzXNSzbo1UCpMDUQ6HKmaNpVSY0BysatQbTz9HmzD35X9zLkfqQOngym7
         v9Yg==
X-Gm-Message-State: APjAAAVLWDA9AldJczNpL/Fky/MVLKD3A03Hv+cX5B46KTVLG9TMOqYN
        Vg5Ukqei17I95lQOvvfq2ndmVxdg
X-Google-Smtp-Source: APXvYqzPZy+bzn3l0eV6qmLKJhd7Ztp3YtT0VWFDKyIPnv099jcShTL0swdkVF+zvaoJIhBtjU+nzA==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr6141856wrt.218.1557991533356;
        Thu, 16 May 2019 00:25:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id l13sm2781999wme.37.2019.05.16.00.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 00:25:32 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation
 limit
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Kenny Ho <y2kenny@gmail.com>,
        "Welty, Brian" <brian.welty@intel.com>
Cc:     "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com>
 <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
 <7db2caae-7eab-7c6a-fe90-89cb9cae30b4@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
Date:   Thu, 16 May 2019 09:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7db2caae-7eab-7c6a-fe90-89cb9cae30b4@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 16.05.19 um 09:16 schrieb Koenig, Christian:
> Am 16.05.19 um 04:29 schrieb Kenny Ho:
>> [CAUTION: External Email]
>>
>> On Wed, May 15, 2019 at 5:26 PM Welty, Brian <brian.welty@intel.com> wrote:
>>> On 5/9/2019 2:04 PM, Kenny Ho wrote:
>>>> There are four control file types,
>>>> stats (ro) - display current measured values for a resource
>>>> max (rw) - limits for a resource
>>>> default (ro, root cgroup only) - default values for a resource
>>>> help (ro, root cgroup only) - help string for a resource
>>>>
>>>> Each file is multi-lined with one entry/line per drm device.
>>> Multi-line is correct for multiple devices, but I believe you need
>>> to use a KEY to denote device for both your set and get routines.
>>> I didn't see your set functions reading a key, or the get functions
>>> printing the key in output.
>>> cgroups-v2 conventions mention using KEY of major:minor, but I think
>>> you can use drm_minor as key?
>> Given this controller is specific to the drm kernel subsystem which
>> uses minor to identify drm device,
> Wait a second, using the DRM minor is a good idea in the first place.

Well that should have read "is not a good idea"..

Christian.

>
> I have a test system with a Vega10 and a Vega20. Which device gets which
> minor is not stable, but rather defined by the scan order of the PCIe bus.
>
> Normally the scan order is always the same, but adding or removing
> devices or delaying things just a little bit during init is enough to
> change this.
>
> We need something like the Linux sysfs location or similar to have a
> stable implementation.
>
> Regards,
> Christian.
>
>>    I don't see a need to complicate
>> the interfaces more by having major and a key.  As you can see in the
>> examples below, the drm device minor corresponds to the line number.
>> I am not sure how strict cgroup upstream is about the convention but I
>> am hoping there are flexibility here to allow for what I have
>> implemented.  There are a couple of other things I have done that is
>> not described in the convention: 1) inclusion of read-only *.help file
>> at the root cgroup, 2) use read-only (which I can potentially make rw)
>> *.default file instead of having a default entries (since the default
>> can be different for different devices) inside the control files (this
>> way, the resetting of cgroup values for all the drm devices, can be
>> done by a simple 'cp'.)
>>
>>>> Usage examples:
>>>> // set limit for card1 to 1GB
>>>> sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
>>>>
>>>> // set limit for card0 to 512MB
>>>> sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
>>>>    /** @file drm_gem.c
>>>> @@ -154,6 +156,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
>>>>         obj->handle_count = 0;
>>>>         obj->size = size;
>>>>         drm_vma_node_reset(&obj->vma_node);
>>>> +
>>>> +     obj->drmcgrp = get_drmcgrp(current);
>>>> +     drmcgrp_chg_bo_alloc(obj->drmcgrp, dev, size);
>>> Why do the charging here?
>>> There is no backing store yet for the buffer, so this is really tracking something akin to allowed virtual memory for GEM objects?
>>> Is this really useful for an administrator to control?
>>> Isn't the resource we want to control actually the physical backing store?
>> That's correct.  This is just the first level of control since the
>> backing store can be backed by different type of memory.  I am in the
>> process of adding at least two more resources.  Stay tuned.  I am
>> doing the charge here to enforce the idea of "creator is deemed owner"
>> at a place where the code is shared by all (the init function.)
>>
>>>> +     while (i <= max_minor && limits != NULL) {
>>>> +             sval =  strsep(&limits, "\n");
>>>> +             rc = kstrtoll(sval, 0, &val);
>>> Input should be "KEY VALUE", so KEY will determine device to apply this to.
>>> Also, per cgroups-v2 documentation of limits, I believe need to parse and handle the special "max" input value.
>>>
>>> parse_resources() in rdma controller is example for both of above.
>> Please see my previous reply for the rationale of my hope to not need
>> a key.  I can certainly add handling of "max" and "default".
>>
>>
>>>> +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
>>>> +             size_t size)
>>> Shouldn't this return an error and be implemented with same semantics as the
>>> try_charge() functions of other controllers?
>>> Below will allow stats_total_allocated to overrun limits_total_allocated.
>> This is because I am charging the buffer at the init of the buffer
>> which does not fail so the "try" (drmcgrp_bo_can_allocate) is separate
>> and placed earlier and nearer other condition where gem object
>> allocation may fail.  In other words, there are multiple possibilities
>> for which gem allocation may fail (cgroup limit being one of them) and
>> satisfying cgroup limit does not mean a charge is needed.  I can
>> certainly combine the two functions to have an additional try_charge
>> semantic as well if that is really needed.
>>
>> Regards,
>> Kenny
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

