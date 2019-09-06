Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF7ABC3E
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfIFPXZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 11:23:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37021 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPXY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 11:23:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so3055067qkd.4
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OJ2aInTH+ll02m34eiKB5anEI6az0ahAcVsZsWlgcJc=;
        b=UO76zrFl49LKNJTSDdriZCNJ7IyuMqcUrBY7wZJo92eM2VFOtWq3obIUqVB3OV5wK5
         g0aMdU/P5Bie5xF38jeVaHiOGa5A07Is5Dr2yKz5YkKCN/DY0AkBLJ5iMMHlwt1SNN+A
         NTp7mU6lP1/o/J1Oxwuy42XCnYbKcO9t8gU3Sm+U3Jlh7DLdOiNEoYfmJATFcpZBuwgy
         2Gb3wV+35UmTZdwRdpVcsh0qaMPs1C8JpZ3OjMGAYNS3TWBM5lSvQo/DIuERiPUhWrjF
         hVBue2c+XioJnHHcwEDd/febjuSCcKx5MclkFqjwnDCneZcrrTN6k2VhBfD1Mi4lybAS
         LIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJ2aInTH+ll02m34eiKB5anEI6az0ahAcVsZsWlgcJc=;
        b=joBHDy1gV4ESpoaLyjP2DaLWSBtwvqMd53b9cFz6ieLOg5FKBFTfOlpM091wBlLdC2
         e5JkDNOqMfQ97WjC8KC4CagJnDUAbuXbPfTg0uz/J2yq0waWel+sZh1ynyg11rc4SI+u
         3c7eQ+Yn55jvdG1NY9pukMo3dm5bnQXhzP2xsFBJ2C1Qvsm2UTJIPXixL+FEyM6/SvuF
         cRrXMsOWAqTGmqPW33iksEdcW7hLz/szkqneLSWuoNaPrSCgbMmqmIPEBPFsnkKGXObe
         6Y36kN3tLvA862u8+3jGzx8KwBFohg3HJA8WR2Agdi/JBJsqDQP9RMd6RBncYb0SxFEv
         nw4Q==
X-Gm-Message-State: APjAAAXMIqMg4mZXyezxhMlQ2DPXWQnXPhwKETWrzgV87N7/qRUqZiYH
        uDqr5pO7LIMwgchH5vqAh9o=
X-Google-Smtp-Source: APXvYqxWCuFp0bfkKuq41IsDLncbaoUCMpj4GmWjBh9gcJ7tAJ2yOJo7NrzKNUpTK0fRYBeUv0Y4jw==
X-Received: by 2002:a37:4f4c:: with SMTP id d73mr9375226qkb.171.1567783403281;
        Fri, 06 Sep 2019 08:23:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e7cb])
        by smtp.gmail.com with ESMTPSA id i66sm3293712qkb.105.2019.09.06.08.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:23:22 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:23:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, Kenny Ho <y2kenny@gmail.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190906152320.GM2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local>
 <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Tue, Sep 03, 2019 at 09:48:22PM +0200, Daniel Vetter wrote:
> I think system memory separate from vram makes sense. For one, vram is
> like 10x+ faster than system memory, so we definitely want to have
> good control on that. But maybe we only want one vram bucket overall
> for the entire system?
> 
> The trouble with system memory is that gpu tasks pin that memory to
> prep execution. There's two solutions:
> - i915 has a shrinker. Lots (and I really mean lots) of pain with
> direct reclaim recursion, which often means we can't free memory, and
> we're angering the oom killer a lot. Plus it introduces real bad
> latency spikes everywhere (gpu workloads are occasionally really slow,
> think "worse than pageout to spinning rust" to get memory freed).
> - ttm just has a global limit, set to 50% of system memory.
> 
> I do think a global system memory limit to tame the shrinker, without
> the ttm approach of possible just wasting half your memory, could be
> useful.

Hmm... what'd be the fundamental difference from slab or socket memory
which are handled through memcg?  Is system memory used by GPUs have
further global restrictions in addition to the amount of physical
memory used?

> I'm also not sure of the bw limits, given all the fun we have on the
> block io cgroups side. Aside from that the current bw limit only
> controls the bw the kernel uses, userspace can submit unlimited
> amounts of copying commands that use the same pcie links directly to
> the gpu, bypassing this cg knob. Also, controlling execution time for
> gpus is very tricky, since they work a lot more like a block io device
> or maybe a network controller with packet scheduling, than a cpu.

At the system level, it just gets folded into cpu time, which isn't
perfect but is usually a good enough approximation of compute related
dynamic resources.  Can gpu do someting similar or at least start with
that?

Thanks.

-- 
tejun
