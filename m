Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC15314FD0
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFPQR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:16:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39649 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfEFPQQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:16:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so6534510plb.6
        for <cgroups@vger.kernel.org>; Mon, 06 May 2019 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1u7drWIJX0vlIQB/ygcUGyKLjxAddZMS8JK32/Eg9hU=;
        b=Gfz6Scb+O2dfTb/uucuXrirZqRMDgF4/Zjl9BTGZrZWKo+QHDsRDtuCj0izcdOXzTi
         MRBYqwsmnC2e2iTWV7mY/5X9K21nxVs2DTJAYxgib2P1a+J58VF/oe3ppYcf122tjBG0
         TdTWNtw0PM50AuDnCjlp6SQh1sXgMUgz3L3qfAAH8WUHGjcdrxTBumA4E5k4dL4a/tnk
         NuAuY8j86JpTdsunWHDaWqHuo1cFDDCNrIvoaG4ce5U7gbS8hrHFTAAS8fdpC9vdt2f4
         EE5MHAXTmTgxlGGESYMm5dW8lsmAavNw3P1AYOoXPR1FPuJoAow1sFOgo+ssLmNOwUao
         fB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1u7drWIJX0vlIQB/ygcUGyKLjxAddZMS8JK32/Eg9hU=;
        b=tujKSAgO/wk5g+eWRD/PhRkGSBVawzt8to5iuDqwcQ2xB7JQ14sw36Jif889iZKN8i
         UsEzmZMcnhTlK9PeRsS2z6IXDCtnf3IY8ee03dwNFU/Zja2j+9r0kMxkSIdwE+vV+4aE
         +Kw2Nd8+lIrGOBg7AXWvVzcMdTz+5a3Q59eCYX8VQFtPn4PuFurhHug2jxpzvGrd+l0i
         pn/WSQeivbTX86aTErEwNHb6RPtcZTGdQowk7UwSrjsM4oJsNvM0ONX7wodfLMLH5KsH
         k51Vqo24bNf0MGiGdgRn7Lkzb9BPDSnCRrZK/wfExMwwlGQbmYECuFwi2CUTEXpaI6aE
         eA2Q==
X-Gm-Message-State: APjAAAXp4mxcpuywqxvyXcMAFPN2qpQl//Y0ZaeOQoTvKWsuEyWqOT+y
        I9B/IkZ2TZq5momF2tR2UyOKDg==
X-Google-Smtp-Source: APXvYqwIbUKO147fnZOB17UUDrHH0ucZxXj2tg3GkjqUJZP2G1mbEvn9k/V2uaDJP2/lyedoAKCdVw==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr33215767plq.234.1557155775870;
        Mon, 06 May 2019 08:16:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:32a0])
        by smtp.gmail.com with ESMTPSA id 9sm18661441pgv.5.2019.05.06.08.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 08:16:14 -0700 (PDT)
Date:   Mon, 6 May 2019 11:16:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Brian Welty <brian.welty@intel.com>
Cc:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
Message-ID: <20190506151613.GB11505@cmpxchg.org>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 01, 2019 at 10:04:33AM -0400, Brian Welty wrote:
> In containerized or virtualized environments, there is desire to have
> controls in place for resources that can be consumed by users of a GPU
> device.  This RFC patch series proposes a framework for integrating 
> use of existing cgroup controllers into device drivers.
> The i915 driver is updated in this series as our primary use case to
> leverage this framework and to serve as an example for discussion.
> 
> The patch series enables device drivers to use cgroups to control the
> following resources within a GPU (or other accelerator device):
> *  control allocation of device memory (reuse of memcg)
> and with future work, we could extend to:
> *  track and control share of GPU time (reuse of cpu/cpuacct)
> *  apply mask of allowed execution engines (reuse of cpusets)

Please create a separate controller for your purposes.

The memory controller is for traditional RAM. I don't see it having
much in common with what you're trying to do, and it's barely reusing
any of the memcg code. You can use the page_counter API directly.

> Instead of introducing a new cgroup subsystem for GPU devices, a new
> framework is proposed to allow devices to register with existing cgroup
> controllers, which creates per-device cgroup_subsys_state within the
> cgroup.  This gives device drivers their own private cgroup controls
> (such as memory limits or other parameters) to be applied to device
> resources instead of host system resources.
> Device drivers (GPU or other) are then able to reuse the existing cgroup
> controls, instead of inventing similar ones.
> 
> Per-device controls would be exposed in cgroup filesystem as:
>     mount/<cgroup_name>/<subsys_name>.devices/<dev_name>/<subsys_files>
> such as (for example):
>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.max
>     mount/<cgroup_name>/memory.devices/<dev_name>/memory.current
>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.stat
>     mount/<cgroup_name>/cpu.devices/<dev_name>/cpu.weight

Subdirectories for anything other than actual cgroups are a no-go. If
you need a hierarchy, use dotted filenames:

gpu.memory.max
gpu.cycles.max

etc. and look at Documentation/admin-guide/cgroup-v2.rst's 'Format'
and 'Conventions', as well as how the io controller works, to see how
multi-key / multi-device control files are implemented in cgroup2.
