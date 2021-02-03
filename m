Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1430D74D
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 11:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhBCKTI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Feb 2021 05:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhBCKTD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Feb 2021 05:19:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA41C061573
        for <cgroups@vger.kernel.org>; Wed,  3 Feb 2021 02:18:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so23530375wrz.0
        for <cgroups@vger.kernel.org>; Wed, 03 Feb 2021 02:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U7wzFPqPJjRnSnevKVluik0v7yG0WQ43COq8Iej7GJk=;
        b=Et1vQSKj1b5A5vPhuXS6Jv72x4mhNh+mqm6wWyMVijzpn7Sgr3TS7RXh1ftWuA9HpM
         z0H/E4Omf9Y0mwUJsiiBbyDyK9lpKh7r+NlhP17/ZSp/aDTcTh7/zAvo4HspBNCSy/+8
         lOmCzPDG/9A7iZeHl8T0M79MmVUUhEAzZOJL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U7wzFPqPJjRnSnevKVluik0v7yG0WQ43COq8Iej7GJk=;
        b=lWrLbqbDDcjGEJDmsL4lKMgI5lt1/H5THD4jStRYE1KV41P9liZYtS0ubSop09JvB8
         bwT2HrnXYO7Cc/MfIwd/Mf/vtBndkmsDE+oKB2ZvMRpiReRLRIloaBvZZejc+LHdzVNe
         QiypoN3hybOuKoT16mUNoMyHv66YEccLp7LpYRsVvCRFnhfHQnzOEO9QMBa60UX6a87R
         M4droHAfojtZMlCx1Rh7euMnmI8wT+qPMux3ZXfPF0uOOtC3Nx1Zl+K/FdlRZLstEqZg
         zfMZWThaKQEdtBtti5llkRt85ywnyg3o6AbzXNkjNLcIWHtYhLy6v9yIKW78fi1GxWIN
         yTIw==
X-Gm-Message-State: AOAM5337D7ZV7ni91EpBQIe8V3cP3kk3rHwwJYWBfvbakPIC2m7W72kE
        CtJI3TmedMIgbD+IiwS9PshcEA==
X-Google-Smtp-Source: ABdhPJylqqOyinK/5J7t9b+SAZ0aHn7UPyHib4aKoH84mXamrsQuG2ImfDPhWxz/7EGcR5r/87OuYQ==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr2613707wrw.120.1612347501535;
        Wed, 03 Feb 2021 02:18:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z1sm2962189wru.70.2021.02.03.02.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:18:20 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:18:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Welty <brian.welty@intel.com>
Cc:     Xingyou Chen <rockrush@rockwork.org>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [RFC PATCH 0/9] cgroup support for GPU devices
Message-ID: <YBp4ap+1l2KWbqEJ@phenom.ffwll.local>
References: <20210126214626.16260-1-brian.welty@intel.com>
 <84b79978-84c9-52aa-b761-3f4be929064e@rockwork.org>
 <5307d21b-7494-858c-30f0-cb5fe1d86004@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5307d21b-7494-858c-30f0-cb5fe1d86004@intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 01, 2021 at 03:21:35PM -0800, Brian Welty wrote:
> 
> On 1/28/2021 7:00 PM, Xingyou Chen wrote:
> > On 2021/1/27 上午5:46, Brian Welty wrote:
> > 
> >> We'd like to revisit the proposal of a GPU cgroup controller for managing
> >> GPU devices but with just a basic set of controls.  This series is based on 
> >> the prior patch series from Kenny Ho [1].  We take Kenny's base patches
> >> which implement the basic framework for the controller, but we propose an
> >> alternate set of control files.  Here we've taken a subset of the controls
> >> proposed in earlier discussion on ML here [2]. 
> >>
> >> This series proposes a set of device memory controls (gpu.memory.current,
> >> gpu.memory.max, and gpu.memory.total) and accounting of GPU time usage
> >> (gpu.sched.runtime).  GPU time sharing controls are left as future work.
> >> These are implemented within the GPU controller along with integration/usage
> >> of the device memory controls by the i915 device driver.
> >>
> >> As an accelerator or GPU device is similar in many respects to a CPU with
> >> (or without) attached system memory, the basic principle here is try to
> >> copy the semantics of existing controls from other controllers when possible
> >> and where these controls serve the same underlying purpose.
> >> For example, the memory.max and memory.current controls are based on
> >> same controls from MEMCG controller.
> > 
> > It seems not to be DRM specific, or even GPU specific. Would we have an universal
> > control group for any accelerator, GPGPU device etc, that hold sharable resources
> > like device memory, compute utility, bandwidth, with extra control file to select
> > between devices(or vendors)?
> > 
> > e.g. /cgname.device that stores PCI BDF， or enum(intel, amdgpu, nvidia, ...),
> > defaults to none, means not enabled.
> > 
> 
> Hi, thanks for the feedback.  Yes, I tend to agree.  I've asked about this in
> earlier work; my suggestion is to name the controller something like 'XPU' to
> be clear that these controls could apply to more than GPU.
> 
> But at least for now, based on Tejun's reply [1], the feedback is to try and keep
> this controller as small and focused as possible on just GPU.  At least until
> we get some consensus on set of controls for GPU.....  but for this we need more
> active input from community......

There's also nothing stopping anyone from exposing any kind of XPU as
drivers/gpu device. Aside from the "full stack must be open requirement we
have" in drm. And frankly with drm being very confusing acronym we could
also rename GPU to be the "general processing unit" subsytem :-)
-Daniel

> 
> -Brian
> 
> [1] https://lists.freedesktop.org/archives/dri-devel/2019-November/243167.html

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
