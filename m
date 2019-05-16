Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2894A1FDBA
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 04:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEPC3e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 May 2019 22:29:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38511 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEPC3d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 May 2019 22:29:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id u199so1365424oie.5
        for <cgroups@vger.kernel.org>; Wed, 15 May 2019 19:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brIRTZ8rTL3D1hESD9cfO1okHwiplIHm2d3dgCFXGos=;
        b=lTP3J91gu85/z346HD4bLomplfbBRvVMZ5hOyii2mbh+6R44qEdQ21SMDdb16poqOL
         EKrK31S1q29G8DrOBb10UrJSiXilNHiLzpcwax8nwbqQ9Z1aQ+Sj7ZcqFBtfIw3Owmsk
         MRQA1j+29KOO5Y9KSjS3XuMCvUoYqCHQ+puhCfHvqMM91d0qTirnlrA0TCDwgZGyK6zg
         qP56C3OpFSPP4YrcphxXXq+Q9eb05nCZGxos/LW7LZncXDkqsWiYgii98nkhyhXCkkfw
         C5GkL4MLPWs5rT4xpBM9tain40FWtrNLnGNdm9GJPyCbPq1g1Rx0sqZ14dyDhVS18Mzc
         HbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brIRTZ8rTL3D1hESD9cfO1okHwiplIHm2d3dgCFXGos=;
        b=B0I1G6qQ+c3o0+3fqTXuUkIQeSyMmwSkhfLZc5XhtLMiOwpjDC/zzQbWIB88484Ri2
         uqm0D7bIsfALcRaZgaoKsnUdUcxr+jq5rvnt7nlIunQY+sE0ntnmdiKj4PFJP+o1WDIx
         p723kFq20ccPU5Ad7Lm96dCCg3TZWZEJOhKxmn2OK1W8vzz41JYxzLiuB7K2FhqzF2cb
         C/8virpBniu1P1+2DU+maHI5uwCfJ10M7UW9QIm1KQ9FXThm0YeKSiWYr/3lIIfQn7hr
         opy0E+FnSDm/Yi6mhvP5CYj4AuCSOMKvIZFT3psecabXMj8V9lgvkq3mH09i5dnUa6B5
         AFCA==
X-Gm-Message-State: APjAAAUpwdOa1D09mqWhR0MN6g9Cc6Q8nqcHw6IGzGyNzzSiESGT2RVa
        LFJ1WaJFIjbebJIFhZIpj9TFTucBjbxVeXxsJb0=
X-Google-Smtp-Source: APXvYqwr48Jpr1yWapbdXplFe4VSiTKhBLkcW9I9j7VKV8+AaN+tcbtQOLBFjPJfrPknwFxMSe0hu2qkPbJO1iJVpjQ=
X-Received: by 2002:aca:b8c4:: with SMTP id i187mr8550785oif.6.1557973772566;
 Wed, 15 May 2019 19:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
In-Reply-To: <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 15 May 2019 22:29:21 -0400
Message-ID: <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     "Welty, Brian" <brian.welty@intel.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tejun Heo <tj@kernel.org>, sunnanyong@huawei.com,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 15, 2019 at 5:26 PM Welty, Brian <brian.welty@intel.com> wrote:
> On 5/9/2019 2:04 PM, Kenny Ho wrote:
> > There are four control file types,
> > stats (ro) - display current measured values for a resource
> > max (rw) - limits for a resource
> > default (ro, root cgroup only) - default values for a resource
> > help (ro, root cgroup only) - help string for a resource
> >
> > Each file is multi-lined with one entry/line per drm device.
>
> Multi-line is correct for multiple devices, but I believe you need
> to use a KEY to denote device for both your set and get routines.
> I didn't see your set functions reading a key, or the get functions
> printing the key in output.
> cgroups-v2 conventions mention using KEY of major:minor, but I think
> you can use drm_minor as key?
Given this controller is specific to the drm kernel subsystem which
uses minor to identify drm device, I don't see a need to complicate
the interfaces more by having major and a key.  As you can see in the
examples below, the drm device minor corresponds to the line number.
I am not sure how strict cgroup upstream is about the convention but I
am hoping there are flexibility here to allow for what I have
implemented.  There are a couple of other things I have done that is
not described in the convention: 1) inclusion of read-only *.help file
at the root cgroup, 2) use read-only (which I can potentially make rw)
*.default file instead of having a default entries (since the default
can be different for different devices) inside the control files (this
way, the resetting of cgroup values for all the drm devices, can be
done by a simple 'cp'.)

> > Usage examples:
> > // set limit for card1 to 1GB
> > sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
> >
> > // set limit for card0 to 512MB
> > sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max


> >  /** @file drm_gem.c
> > @@ -154,6 +156,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
> >       obj->handle_count = 0;
> >       obj->size = size;
> >       drm_vma_node_reset(&obj->vma_node);
> > +
> > +     obj->drmcgrp = get_drmcgrp(current);
> > +     drmcgrp_chg_bo_alloc(obj->drmcgrp, dev, size);
>
> Why do the charging here?
> There is no backing store yet for the buffer, so this is really tracking something akin to allowed virtual memory for GEM objects?
> Is this really useful for an administrator to control?
> Isn't the resource we want to control actually the physical backing store?
That's correct.  This is just the first level of control since the
backing store can be backed by different type of memory.  I am in the
process of adding at least two more resources.  Stay tuned.  I am
doing the charge here to enforce the idea of "creator is deemed owner"
at a place where the code is shared by all (the init function.)

> > +     while (i <= max_minor && limits != NULL) {
> > +             sval =  strsep(&limits, "\n");
> > +             rc = kstrtoll(sval, 0, &val);
>
> Input should be "KEY VALUE", so KEY will determine device to apply this to.
> Also, per cgroups-v2 documentation of limits, I believe need to parse and handle the special "max" input value.
>
> parse_resources() in rdma controller is example for both of above.
Please see my previous reply for the rationale of my hope to not need
a key.  I can certainly add handling of "max" and "default".


> > +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> > +             size_t size)
>
> Shouldn't this return an error and be implemented with same semantics as the
> try_charge() functions of other controllers?
> Below will allow stats_total_allocated to overrun limits_total_allocated.
This is because I am charging the buffer at the init of the buffer
which does not fail so the "try" (drmcgrp_bo_can_allocate) is separate
and placed earlier and nearer other condition where gem object
allocation may fail.  In other words, there are multiple possibilities
for which gem allocation may fail (cgroup limit being one of them) and
satisfying cgroup limit does not mean a charge is needed.  I can
certainly combine the two functions to have an additional try_charge
semantic as well if that is really needed.

Regards,
Kenny
