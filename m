Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99D720937
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfEPOKU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 10:10:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37841 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPOKT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 10:10:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so4037213qtp.4
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4sDOxMUP58OIR9BfihJ4UZAZRlR6Y13wM0CaqjH6oNE=;
        b=gqMdqGipCRaZuzcjHF1PBfs5h15q+m/gyx1euVyQWs60klB8iAxKHH295hUzDZ5Dil
         aN1Lsbi7UwxeSod3kZoXguG7TPCHIJgQcKlejv4WFgyAXPKPUv30dsjltoh+s77gEH+s
         oGXGGuHJHZ7iWXvoiNK2TjukdS7hIh+WZjKxzIHjvsyfA2kSDj11XkdYAwPuscuTFXPg
         iie+OAMNP2cdtNDBhnZ123S1/aeZXPM3RPbCSK1i2FE411VCoFcoh26AMtaSafk1K/TM
         Wz0f4nmOXS3Aj+jb3WqHoehP4+HUuHouLzjcc+ZxQ2uhpr1w8NMLTmkGA2jl6yG7EFeX
         M1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4sDOxMUP58OIR9BfihJ4UZAZRlR6Y13wM0CaqjH6oNE=;
        b=eKt+WPSrKSKCM8E2NDga7PvzSd4tBwBDky4YuM5oW2qipZ+FqNjBDR3p9O8IZJ9vla
         dcs+lQNkVKKbv5dTG5ycIuRVA1RJIs2FojHC51zCjZm9u3FR3e7bkYfDmREVbYlKa8mK
         ao/CyE4oeEcZpi0OAFUTr1QeGmORJC4s2Qhyiu0ZtdWvoXcCLIuy+rtdraGL7JRgIXF6
         VJRevzPErhGOId2cX2/6FgRAbJ5qado8QB9snd1wu+uI5lPujucXoTZ7FdUcvAUNCQcV
         oB4U7vgpXRB4gkqJksboZf+wHNZTVJuSVwLsisz/AkD5rsnZqgXF/MOjPDAz4W4Pncrq
         sC0g==
X-Gm-Message-State: APjAAAVFS5lLiRa7/Bk/iy5re8zdYxm1ILPeW8Zfh3z/e+9VaMzTWK/T
        9AbSPrmhiCFUzX228xysciD/zXy/Pxg=
X-Google-Smtp-Source: APXvYqwbWSZUa7+C4SUhRR7nMwltVkifbPmv9MOwZiTJD/HH2P7E+cA10XzeUWDy3BsfOIk4/YIaeg==
X-Received: by 2002:ac8:2edc:: with SMTP id i28mr42310462qta.115.1558015818989;
        Thu, 16 May 2019 07:10:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:30c9])
        by smtp.gmail.com with ESMTPSA id p8sm3389554qta.24.2019.05.16.07.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:10:18 -0700 (PDT)
Date:   Thu, 16 May 2019 07:10:15 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     "Welty, Brian" <brian.welty@intel.com>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        sunnanyong@huawei.com, Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation
 limit
Message-ID: <20190516141015.GC374014@devbig004.ftw2.facebook.com>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com>
 <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I haven't gone through the patchset yet but some quick comments.

On Wed, May 15, 2019 at 10:29:21PM -0400, Kenny Ho wrote:
> Given this controller is specific to the drm kernel subsystem which
> uses minor to identify drm device, I don't see a need to complicate
> the interfaces more by having major and a key.  As you can see in the
> examples below, the drm device minor corresponds to the line number.
> I am not sure how strict cgroup upstream is about the convention but I

We're pretty strict.

> am hoping there are flexibility here to allow for what I have
> implemented.  There are a couple of other things I have done that is

So, please follow the interface conventions.  We can definitely add
new ones but that would need functional reasons.

> not described in the convention: 1) inclusion of read-only *.help file
> at the root cgroup, 2) use read-only (which I can potentially make rw)
> *.default file instead of having a default entries (since the default
> can be different for different devices) inside the control files (this
> way, the resetting of cgroup values for all the drm devices, can be
> done by a simple 'cp'.)

Again, please follow the existing conventions.  There's a lot more
harm than good in every controller being creative in their own way.
It's trivial to build convenience features in userspace.  Please do it
there.

> > Is this really useful for an administrator to control?
> > Isn't the resource we want to control actually the physical backing store?
> That's correct.  This is just the first level of control since the
> backing store can be backed by different type of memory.  I am in the
> process of adding at least two more resources.  Stay tuned.  I am
> doing the charge here to enforce the idea of "creator is deemed owner"
> at a place where the code is shared by all (the init function.)

Ideally, controller should only control hard resources which impact
behaviors and performance which are immediately visible to users.

Thanks.

-- 
tejun
