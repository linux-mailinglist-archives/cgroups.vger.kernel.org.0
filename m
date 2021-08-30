Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57BC3FBB83
	for <lists+cgroups@lfdr.de>; Mon, 30 Aug 2021 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhH3SLc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Aug 2021 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhH3SLc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Aug 2021 14:11:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D43C061575;
        Mon, 30 Aug 2021 11:10:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m17so9015597plc.6;
        Mon, 30 Aug 2021 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hD0xppJLT6aEBN2umsxRQUAtIA9VVamYDNavPG9ZrFA=;
        b=nUGFYmCE9vU9tp3VIixtY28HUGWuJn0CQpFrlaTEOAG5ks+zzZg7SYZJ7uVTIEYh5+
         4nwFaQDapsEvEUbOOxE1L7PC+rlnZ0lvvjt2qL/4R+L5rcV1GC+aBRDkCLipRuN5pKbQ
         a//RaTkbMnyB/xZJiFJUbubqXtIBczqDj8PFZY6ncK0LISWmPHX9QrJ62gOBuTZaMZOM
         jy+MFzlTkYm3+OIERk1+WlY2Q1yZyk6qT1s7z+Eq6qXeFk5BMssrLaiszlG/yqNM7lad
         5YwMiZKgSh+rPPv8N0Wn3G5qNGleu5StVthZpta/ubqWJCw4jsZIZEhzlpTZbnAYZoZe
         4zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hD0xppJLT6aEBN2umsxRQUAtIA9VVamYDNavPG9ZrFA=;
        b=amweqRAFCEI5APX3N9d5xBBdROEaS6MU5lV+FEqxsi9YaLS6/rgdqRH2U7eJqFiRWb
         2s6prQmLk+0Dn3xbyqtLzEm2yIif//z8LqJTJ1aJKemRF1N5MNUrgOPW1+NZbCr4nZxK
         WMwCjSgeIh7jUT+c7dEVUW3n5oSKnC8384gFbYsq+Afa60NZySSZj1aQGsWirnNgR7l5
         SZ88sn2PupucKg4sCkPPM7YJUHu5snoeQJfr1rsfZ9Q64NcbEFPBeIE9aA1gD4HOO3dy
         PyOWhPtr66woQRnB8mpO1UkbsF8AuGqmeKf1CbYhPLVskKio+tsYH7WV4oKFav5X4Hhr
         iUlg==
X-Gm-Message-State: AOAM532YpBd7oyZBVJ0bqVrjMu68hZTCb6xhAXXKZaQ4ct6PH2M5UTvc
        ypccRYbye9n6iudXzQwe+Eg=
X-Google-Smtp-Source: ABdhPJwHT36Iw7KT3WkTeq49AqdYspMrghtvyqmmodTda4K6CfH1jSY+9quPI5YV6oO8G3yiLR6uDA==
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr378666pjv.89.1630347037205;
        Mon, 30 Aug 2021 11:10:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id z9sm15038224pfa.2.2021.08.30.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:10:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Aug 2021 08:10:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] cgroup: Avoid compiler warnings with no subsystems
Message-ID: <YS0fGvwqLWKpcejZ@mtj.duckdns.org>
References: <20210828000255.3213497-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828000255.3213497-1-keescook@chromium.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 27, 2021 at 05:02:55PM -0700, Kees Cook wrote:
> As done before in commit cb4a31675270 ("cgroup: use bitmask to filter
> for_each_subsys"), avoid compiler warnings for the pathological case of
> having no subsystems (i.e. CGROUP_SUBSYS_COUNT == 0). This condition is
> hit for the arm multi_v7_defconfig config under -Wzero-length-bounds:
> 
> In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:264,
>                  from include/uapi/linux/swab.h:6,
>                  from include/linux/swab.h:5,
>                  from arch/arm/include/asm/opcodes.h:86,
>                  from arch/arm/include/asm/bug.h:7,
>                  from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:13,
>                  from include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from include/linux/sched.h:12,
>                  from include/linux/cgroup.h:12,
>                  from kernel/cgroup/cgroup-internal.h:5,
>                  from kernel/cgroup/cgroup.c:31:
> kernel/cgroup/cgroup.c: In function 'of_css':
> kernel/cgroup/cgroup.c:651:42: warning: array subscript '<unknown>' is outside the bounds of an
> interior zero-length array 'struct cgroup_subsys_state *[0]' [-Wzero-length-bounds]
>   651 |   return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
