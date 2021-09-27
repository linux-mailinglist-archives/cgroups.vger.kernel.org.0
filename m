Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63590419D06
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhI0RjH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Sep 2021 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbhI0RhY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Sep 2021 13:37:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CFC02C30A;
        Mon, 27 Sep 2021 10:08:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so12208976plh.9;
        Mon, 27 Sep 2021 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=icdhatsIVMpVj9yFW17RwQuR1S0u1I+iYgg1GU5p9cg=;
        b=ZMz3hfxwpz4U36m5O/CYL7j1TR5S3j0rERHxQWLDXoJkRLldkBdniIGZLVHf9Iit5d
         Ecfe2rMtWI53lH6H7AXxEgdRL/M1bsKthqaf1i/A3XJEpNQqe9UzQLfrrxOboq/hOvYI
         4Bwuza8gO3r6TeSr6m+M5Eiv2gzQYeRvyeuwXV7M2uZeVy1hj8m0O3vGG9v8kzUD4MTB
         PY7nVeQM2AX4z265SOWlctIjaPzpr9PjGT+KrvnYle0zWd5ZXTp1jpaIhwgYWcCLy3HW
         V0akiE9PrGLppPnC6Lp5xh4hKko3DuVWP7aJ9iISiwNuJbM0Xk/jhJDPOjfOFFbnm7+q
         AYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=icdhatsIVMpVj9yFW17RwQuR1S0u1I+iYgg1GU5p9cg=;
        b=NJuyGIPqOWJDps/otVJqUJHLq9Bn92tXwXa6+mmXTskp8WKhbpfhVG729aAxTE0/Xl
         oIVPILOVsj3iS9JnzoSs5mbMu0kSd/z/CwVSOBv3HMYIpqZm31YcugfyTamHZtV7nmZy
         7IE+HShOQ4isrxxgknf1FcAI7EnREleNceZLhs1h7r7F9w7gNOCyj1fdPu7IxfokK2kg
         1T+qKN0Mnyu8DRH1QG45WwogLn1PP/RW6NEIFYDGAYq/ejBSD0MhvLYRgmVApfPdC2i9
         r5FuxYpxZzZ3XVnfWwgIhU00CwLtGzhUBT5zuvPtRRhg5VFdGA2CDnYc69zVCzQ+2CNU
         ba8A==
X-Gm-Message-State: AOAM533TUIoHa8N720EQvFsC58QLYaHTGrm95gjbeijcnXCBq8G00Jbx
        2CjvGRh1xigFacWuQ4gNsww=
X-Google-Smtp-Source: ABdhPJyjoDWsLl88srnjDSeCTyY4vJVqnDVBwMnKif2pCakeEaOeDgBGKPQVQt2Y0SHa7GNcYXjAyg==
X-Received: by 2002:a17:90a:1a42:: with SMTP id 2mr174835pjl.202.1632762533935;
        Mon, 27 Sep 2021 10:08:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k25sm3666216pgt.49.2021.09.27.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:08:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Sep 2021 07:08:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     "yukuai (C)" <yukuai3@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup
 v2
Message-ID: <YVH6pLUONhmvhTMK@slm.duckdns.org>
References: <20210909140815.2600858-1-yukuai3@huawei.com>
 <20210917174103.GC13346@blackbody.suse.cz>
 <CACGdZYJiLuh6kED_tdWkYqbHDXc_18m-XJbevp-ri5ansvbtYg@mail.gmail.com>
 <37f8c687-8549-104a-2501-532a0cfc9a48@huawei.com>
 <20210921134414.GE4091@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210921134414.GE4091@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Sep 21, 2021 at 03:44:14PM +0200, Michal Koutný wrote:
> On 2021/09/18 3:58, Khazhy Kumykov wrote:
> > (This does also bring up: if this is a useful thing, would it make
> > sense to tie to the device, vs. requiring cgroup. We happen to use
> > cgroups so that requirement doesn't affect us).
> 
> Good point, That's IMO a better idea, it'd be more consistent with other
> resources for which there exist global (cgroup independent) kernel
> constraints (e.g. threads-max sysctl, mem= cmdline, cpu hotplug) that
> double the root cgroup contraint role.

This is why I usually try to push root-cgroup level features outside cgroup
because it really doesn't have much to do with cgroups at the root level.
For visibility stuff, we do replicate quite a bit in the root level because
not doing so becomes too painful for users but for control I'm more
hesitant.

One side-way solution could be using iocost. It doesn't have root-level
control per-se but it does configure per-device attributes which define what
the device can and is allowed to do so that it can be used as the basis for
weighted fair distribution. Even if IO control is disabled from the root
level, it'll still modulate the device according to the parameters.

> OTOH, this also deepens the precedent of init NS root cgroup being
> special (more special than a container's root cgroup).

While it does seem like an aesthetical wrinkle, I don't think this is a
practical problem. System root being different is a given whether
aesthetically pleasing or not (not the most important but we have
CONFIG_CGROUPS after all). I don't think it'll lead anywhere good to try to
mask the differences.

Thanks.

-- 
tejun
