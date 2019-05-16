Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93731206E5
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEPM3F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 08:29:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36107 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEPM3E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 08:29:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so5032631edx.3
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i+Lyxzg1cYsoIY9/z0raLB7h90h+0ypKbiiOiLxJIc4=;
        b=VHJchvJkBUL/IiXCqvxAcr+2npuP0fs7zrWHH7236TKDnakQ0iZlJdW4pCjn+8nxL+
         3E1lsKC0liOlLQT1gOGdcLFHiJvB76/L0bRTc6rSNm4I8IfC+OljCRbxjOQ257sm6jxr
         Y46sqchCpt5nqUfyFUQIu/9ra0M5fEiAkKh5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=i+Lyxzg1cYsoIY9/z0raLB7h90h+0ypKbiiOiLxJIc4=;
        b=S7ZaeNjX63etw8JS6Xw7JtDID750ABVcicah2wZzhoEj2qQYuVft5WQxRiSsPwhWzU
         uGunBInNFcT/vhDXGGRl9NXiTzCR87hBPk7o5bAU9HnbWmXx1q6GL7xOtLfO0AyBfEvI
         dJrzz7DjovJyBFzHXBxteg54yFHkXTZAbruhJpfnwlvCL+ETSzOt+u6Qw3o3k6pH4pM5
         cSWAbMYym89QmtpbxlEHNvPApxi6d33sNotaVgRw+UMzLwj/DzdqeAZh8E9o5Y9XefbB
         GLiKoXKclqRAoLRfFM/9KWKKjXp8F2NQJ027mTzZNT2G8QxqPgjbONcfA1x4PlHx8vl5
         5ubg==
X-Gm-Message-State: APjAAAXVwiLFB2etymCAPKT9nat7lNqQqnpTxAF+x35UMMM69fR4KdAf
        ksc2AqO+sx7PFo9NrKmIrHciqg==
X-Google-Smtp-Source: APXvYqxrreJ6ABa5awYWluY+zOs/iIa6BkyLYZkzZE6+e1vzjgscU8bF9TwZ1FvI0SbHUp2uC2Hnng==
X-Received: by 2002:a17:906:f19a:: with SMTP id gs26mr31357470ejb.78.1558009742079;
        Thu, 16 May 2019 05:29:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r2sm1055553ejp.76.2019.05.16.05.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 05:29:00 -0700 (PDT)
Date:   Thu, 16 May 2019 14:28:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     christian.koenig@amd.com
Cc:     Kenny Ho <y2kenny@gmail.com>,
        "Welty, Brian" <brian.welty@intel.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation
 limit
Message-ID: <20190516122858.GB3851@phenom.ffwll.local>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com>
 <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
 <7db2caae-7eab-7c6a-fe90-89cb9cae30b4@amd.com>
 <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e124f5e-f83f-5ca1-4616-92538f202653@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 09:25:31AM +0200, Christian König wrote:
> Am 16.05.19 um 09:16 schrieb Koenig, Christian:
> > Am 16.05.19 um 04:29 schrieb Kenny Ho:
> > > [CAUTION: External Email]
> > > 
> > > On Wed, May 15, 2019 at 5:26 PM Welty, Brian <brian.welty@intel.com> wrote:
> > > > On 5/9/2019 2:04 PM, Kenny Ho wrote:
> > > > > There are four control file types,
> > > > > stats (ro) - display current measured values for a resource
> > > > > max (rw) - limits for a resource
> > > > > default (ro, root cgroup only) - default values for a resource
> > > > > help (ro, root cgroup only) - help string for a resource
> > > > > 
> > > > > Each file is multi-lined with one entry/line per drm device.
> > > > Multi-line is correct for multiple devices, but I believe you need
> > > > to use a KEY to denote device for both your set and get routines.
> > > > I didn't see your set functions reading a key, or the get functions
> > > > printing the key in output.
> > > > cgroups-v2 conventions mention using KEY of major:minor, but I think
> > > > you can use drm_minor as key?
> > > Given this controller is specific to the drm kernel subsystem which
> > > uses minor to identify drm device,
> > Wait a second, using the DRM minor is a good idea in the first place.
> 
> Well that should have read "is not a good idea"..

What else should we use?
> 
> Christian.
> 
> > 
> > I have a test system with a Vega10 and a Vega20. Which device gets which
> > minor is not stable, but rather defined by the scan order of the PCIe bus.
> > 
> > Normally the scan order is always the same, but adding or removing
> > devices or delaying things just a little bit during init is enough to
> > change this.
> > 
> > We need something like the Linux sysfs location or similar to have a
> > stable implementation.

You can go from sysfs location to drm class directory (in sysfs) and back.
That means if you care you need to walk sysfs yourself a bit, but using
the drm minor isn't a blocker itself.

One downside with the drm minor is that it's pretty good nonsense once you
have more than 64 gpus though, due to how we space render and legacy nodes
in the minor ids :-)
-Daniel
> > 
> > Regards,
> > Christian.
> > 
> > >    I don't see a need to complicate
> > > the interfaces more by having major and a key.  As you can see in the
> > > examples below, the drm device minor corresponds to the line number.
> > > I am not sure how strict cgroup upstream is about the convention but I
> > > am hoping there are flexibility here to allow for what I have
> > > implemented.  There are a couple of other things I have done that is
> > > not described in the convention: 1) inclusion of read-only *.help file
> > > at the root cgroup, 2) use read-only (which I can potentially make rw)
> > > *.default file instead of having a default entries (since the default
> > > can be different for different devices) inside the control files (this
> > > way, the resetting of cgroup values for all the drm devices, can be
> > > done by a simple 'cp'.)
> > > 
> > > > > Usage examples:
> > > > > // set limit for card1 to 1GB
> > > > > sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
> > > > > 
> > > > > // set limit for card0 to 512MB
> > > > > sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
> > > > >    /** @file drm_gem.c
> > > > > @@ -154,6 +156,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
> > > > >         obj->handle_count = 0;
> > > > >         obj->size = size;
> > > > >         drm_vma_node_reset(&obj->vma_node);
> > > > > +
> > > > > +     obj->drmcgrp = get_drmcgrp(current);
> > > > > +     drmcgrp_chg_bo_alloc(obj->drmcgrp, dev, size);
> > > > Why do the charging here?
> > > > There is no backing store yet for the buffer, so this is really tracking something akin to allowed virtual memory for GEM objects?
> > > > Is this really useful for an administrator to control?
> > > > Isn't the resource we want to control actually the physical backing store?
> > > That's correct.  This is just the first level of control since the
> > > backing store can be backed by different type of memory.  I am in the
> > > process of adding at least two more resources.  Stay tuned.  I am
> > > doing the charge here to enforce the idea of "creator is deemed owner"
> > > at a place where the code is shared by all (the init function.)
> > > 
> > > > > +     while (i <= max_minor && limits != NULL) {
> > > > > +             sval =  strsep(&limits, "\n");
> > > > > +             rc = kstrtoll(sval, 0, &val);
> > > > Input should be "KEY VALUE", so KEY will determine device to apply this to.
> > > > Also, per cgroups-v2 documentation of limits, I believe need to parse and handle the special "max" input value.
> > > > 
> > > > parse_resources() in rdma controller is example for both of above.
> > > Please see my previous reply for the rationale of my hope to not need
> > > a key.  I can certainly add handling of "max" and "default".
> > > 
> > > 
> > > > > +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> > > > > +             size_t size)
> > > > Shouldn't this return an error and be implemented with same semantics as the
> > > > try_charge() functions of other controllers?
> > > > Below will allow stats_total_allocated to overrun limits_total_allocated.
> > > This is because I am charging the buffer at the init of the buffer
> > > which does not fail so the "try" (drmcgrp_bo_can_allocate) is separate
> > > and placed earlier and nearer other condition where gem object
> > > allocation may fail.  In other words, there are multiple possibilities
> > > for which gem allocation may fail (cgroup limit being one of them) and
> > > satisfying cgroup limit does not mean a charge is needed.  I can
> > > certainly combine the two functions to have an additional try_charge
> > > semantic as well if that is really needed.
> > > 
> > > Regards,
> > > Kenny
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
