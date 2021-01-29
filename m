Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84F308404
	for <lists+cgroups@lfdr.de>; Fri, 29 Jan 2021 04:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhA2DBw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jan 2021 22:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhA2DBt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jan 2021 22:01:49 -0500
Received: from rockwork.org (unknown [IPv6:2001:19f0:6001:1139:5400:2ff:feee:29a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80847C061573
        for <cgroups@vger.kernel.org>; Thu, 28 Jan 2021 19:01:09 -0800 (PST)
Received: from [192.168.43.200] (unknown [36.19.57.1])
        by rockwork.org (Postfix) with ESMTPSA id ACF4DFBC2E;
        Fri, 29 Jan 2021 03:00:59 +0000 (UTC)
Subject: Re: [RFC PATCH 0/9] cgroup support for GPU devices
To:     Brian Welty <brian.welty@intel.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
From:   Xingyou Chen <rockrush@rockwork.org>
Message-ID: <84b79978-84c9-52aa-b761-3f4be929064e@rockwork.org>
Date:   Fri, 29 Jan 2021 11:00:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126214626.16260-1-brian.welty@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/1/27 上午5:46, Brian Welty wrote:

> We'd like to revisit the proposal of a GPU cgroup controller for managing
> GPU devices but with just a basic set of controls.  This series is based on 
> the prior patch series from Kenny Ho [1].  We take Kenny's base patches
> which implement the basic framework for the controller, but we propose an
> alternate set of control files.  Here we've taken a subset of the controls
> proposed in earlier discussion on ML here [2]. 
>
> This series proposes a set of device memory controls (gpu.memory.current,
> gpu.memory.max, and gpu.memory.total) and accounting of GPU time usage
> (gpu.sched.runtime).  GPU time sharing controls are left as future work.
> These are implemented within the GPU controller along with integration/usage
> of the device memory controls by the i915 device driver.
>
> As an accelerator or GPU device is similar in many respects to a CPU with
> (or without) attached system memory, the basic principle here is try to
> copy the semantics of existing controls from other controllers when possible
> and where these controls serve the same underlying purpose.
> For example, the memory.max and memory.current controls are based on
> same controls from MEMCG controller.

It seems not to be DRM specific, or even GPU specific. Would we have an universal
control group for any accelerator, GPGPU device etc, that hold sharable resources
like device memory, compute utility, bandwidth, with extra control file to select
between devices(or vendors)?

e.g. /cgname.device that stores PCI BDF， or enum(intel, amdgpu, nvidia, ...),
defaults to none, means not enabled.

