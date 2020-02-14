Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB515F88C
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 22:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgBNVPc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 16:15:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46499 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgBNVPb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 16:15:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so10085462qkh.13
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oZCVTJqDOaYO0qLkkhU/b4V9LR30/p6GYzU8hBz9PHo=;
        b=fFy3EPOllhkeZuzDwhQeqY7WkzV5jBRVVniJ7hseWZc2SSWEnQ9ce7rP0M2cQrtBfW
         7hjXGLyLSXhHOn7Wn+bbVWsEqqTZXjwGqwLKmERklVLh+nVry9j8yIENTvW6e8r4nLyB
         9+1r3RfKg8wimtCMuqW6k29EPOP8HHgvs89vRtxhFp3zep4Zkk4/9YolWCEC3bn9RGho
         HpB2Vbx1/sAk8/99Vg8kA9lMEMqsw7ZFsczNvCPnDn09+DCLogmOtCPSh0PAJbq4xZfO
         UxpTTCCq/EU7xB/PwUDxql5HhYbniZ8ZFh0GUFh+BY+u/OR21TGFiOJr2voMSp/WIyOB
         Edrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oZCVTJqDOaYO0qLkkhU/b4V9LR30/p6GYzU8hBz9PHo=;
        b=LZpsM77N3eLgEFnTEbwQs6hHZX5a1RFHLUkLD8KwOv3Z4FcdcMlxwn7KIVkkEQXgjZ
         n4wKj24FQJx2aeqU9cz7yAlEGe3CYN89oW0lqXDWMbXYPGndPMLMvChxyCRdGqp4i7aX
         uFoXGf9lWmU+X4rV0UnRMbPpNEFDnfVl2sBkBdsS5H5Awl9Xx36e7bMsm1NKabicivkt
         sCdtYfEJfM0XewQilgdY1IlC5xw12x78AKiRgcR/2T4CTNrOw1CxGBjuj75YoZw7987+
         QUtkqEBqPFdGw396j7d4VHyYS2WBjCiKzdz6Vtcgo0dkjayj/LSWVHNBmKf1vpaPElb5
         Pxng==
X-Gm-Message-State: APjAAAVL7g507vNGVDipK1Rso8jJLH40TA16+65xIcrheFobQuakLOn9
        ngpjn57MqYP7Ym+KwUO41DjqslhSnkU=
X-Google-Smtp-Source: APXvYqziQyHs3bVmpBXrquJ+5i9yGG3Fr9rPm43Z6JuOcRifUzLwShtrXg9OOOmQtz99j0+IIjn5tw==
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr4458143qkb.122.1581714930189;
        Fri, 14 Feb 2020 13:15:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::9655])
        by smtp.gmail.com with ESMTPSA id h6sm3907303qtr.33.2020.02.14.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:15:29 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:15:28 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, nirmoy.das@amd.com, damon.mcdougall@amd.com,
        juan.zuniga-anaya@amd.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
Message-ID: <20200214211528.GB218629@mtj.thefacebook.com>
References: <20200214155650.21203-1-Kenny.Ho@amd.com>
 <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local>
 <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com>
 <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 03:28:40PM -0500, Kenny Ho wrote:
> Can you elaborate, per your understanding, how the lgpu weight
> attribute differ from the io.weight you suggested?  Is it merely a

Oh, it's the non-weight part which is problematic.

> formatting/naming issue or is it the implementation details that you
> find troubling?  From my perspective, the weight attribute implements
> as you suggested back in RFCv4 (proportional control on top of a unit
> - either physical or time unit.)
> 
> Perhaps more explicit questions would help me understand what you
> mean. If I remove the 'list' and 'count' attributes leaving just
> weight, is that satisfactory?  Are you saying the idea of affinity or

At least from interface pov, yes, although I think it should be clear
what the weight controls.

> named-resource is banned from cgroup entirely (even though it exists
> in the form of cpuset already and users are interested in having such
> options [i.e. userspace OpenCL] when needed?)
> 
> To be clear, I am not saying no proportional control.  I am saying
> give the user the options, which is what has been implemented.

We can get there if we *really* have to but not from the get-go but
I'd rather avoid affinities if at all possible.

Thanks.

-- 
tejun
