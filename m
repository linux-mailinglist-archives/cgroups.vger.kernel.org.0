Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC421A79B2
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439404AbgDNLhg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 07:37:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51412 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439385AbgDNLhd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 07:37:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id x4so12618779wmj.1
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 04:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZ8CX2OLj8e4jBkaM6apCXhxUob9hd2xQu1TNFcfLjY=;
        b=jIDDpc+gN5HSON6ixlAHZCwcVOui+AGXsZEVWdY1KI1h/uv8Zur+6CMqy7Nk5mY4cv
         T1G3uOYdjNn3sFwQQ1eVoNTD5Cln4pZuiqhWQS1Cscj6MGGT/X5yCrBrNkkNEgOhuT5v
         vX8WEa5FCWFafP1qXCpNuDX+UqkEhK155+pIvYET4RABx8fIf8ocWcuMNx9cl31IEJuT
         llPNwjKjoB1G5OQKFsK05t1Pxg/b8CZca36Jvk7DEQBXHYKbDwudQYce6vBmmspvINhd
         156udcAGJQ9KQDCvc2YuhtzXr52GKykd5UAwZlYEGDV6sRCUYAu6+8hLlfMEKsdKq9cB
         gSrg==
X-Gm-Message-State: AGi0PuYfAM2q7OgAqzG/cPLlO8wMhtAUdwG8q8D/ikpRUe8tCNnCvayJ
        ZCUAxTzESqqjgIZsf11R+hc=
X-Google-Smtp-Source: APiQypLVb+QMixbBMaPAk6mNsPKP6B2IbHo4Bav7bhCSERvXdMMCTam9iO5LIxr/Zefb/9WRU9dfMA==
X-Received: by 2002:a1c:e1c1:: with SMTP id y184mr23860084wmg.143.1586864251539;
        Tue, 14 Apr 2020 04:37:31 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id p6sm11348533wrt.3.2020.04.14.04.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 04:37:30 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:37:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     svc_lmoiseichuk@magicleap.com
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com, tj@kernel.org,
        lizefan@huawei.com, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        anton.vorontsov@linaro.org, penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: Re: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200414113730.GH4629@dhcp22.suse.cz>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-04-20 17:57:48, svc_lmoiseichuk@magicleap.com wrote:
> From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>
> 
> Small tweak to populate vmpressure parameters to userspace without
> any built-in logic change.
> 
> The vmpressure is used actively (e.g. on Android) to track mm stress.
> vmpressure parameters selected empiricaly quite long time ago and not
> always suitable for modern memory configurations.

This needs much more details. Why it is not suitable? What are usual
numbers you need to set up to work properly? Why those wouldn't be
generally applicable?

Anyway, I have to confess I am not a big fan of this. vmpressure turned
out to be a very weak interface to measure the memory pressure. Not only
it is not numa aware which makes it unusable on many systems it also 
gives data way too late from the practice.

Btw. why don't you use /proc/pressure/memory resp. its memcg counterpart
to measure the memory pressure in the first place?

> Leonid Moiseichuk (2):
>   memcg: expose vmpressure knobs
>   memcg, vmpressure: expose vmpressure controls
> 
>  .../admin-guide/cgroup-v1/memory.rst          |  12 +-
>  include/linux/vmpressure.h                    |  35 ++++++
>  mm/memcontrol.c                               | 113 ++++++++++++++++++
>  mm/vmpressure.c                               | 101 +++++++---------
>  4 files changed, 200 insertions(+), 61 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
