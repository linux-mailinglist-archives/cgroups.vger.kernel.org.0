Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1927AABCDA
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405824AbfIFPpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 11:45:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35411 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPpn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 11:45:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id d26so6093576qkk.2
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xy4uz+AuS1IIWwhJKMvLPwOAkr/rEBanFq85X7QSE+8=;
        b=F+zcOTKWxYuZtqccWWl/FcpG+it/14/xBuwGVjya64FFlWSbVYHszu+0Hwvo0sn3wH
         BsBd4Cd48rXZptQ3cmKX5RdUzkil59G0KXV54/S9MFcoz9pqeh0efKuAJ7Mn77lRt9GP
         Vi0XwK2N21me1BKetYO3e7ID0S0HiAm8PhVulHWZZPivC6BZ+mO4IbMpG42lvGMQp/1h
         p4x15mkd05Q7XrcYsWQX4WGAXbIcaIO7M2KwfTRjFF0EyCY21mKoCYenIVN+mU4XdRaL
         wJuLxGeOIsobZR3kM7JarUs1fFopGPtQG8SgFM1WcmOA/Y1jA/k6jIsiVz9leaV5kV6p
         TJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xy4uz+AuS1IIWwhJKMvLPwOAkr/rEBanFq85X7QSE+8=;
        b=SsB/X+/hhh9nyOpm/u5ElQXsVYedmbnTCxh+vtcx/SSgVjZ7/iupU0jYZkUMJYeq8R
         bDSxTahhVd6hg0w3BkjnGNACDo1hp1F+w2adbKbJ2nGkrbvozh5mgq69MItEBDWVuV8q
         vdnxIWq7+kOoCMln07PjaIGkAwnBLZP1v/eHXQ4QnlkKHjTZ3T9DoHCV3CgN/6YrE8qe
         3fdqA7OtUUnTKhaBu/S/rGGcm97tKW6KKYLh2uBKpiejfG5M+htdU5CCWE1UAZunTRrU
         CD6hO/p4IFmRe52uUT11sWiVxsVytYRNHwVU9CPgPnlrfY9xEcYjUgjxiMz8yHo3hH1D
         AcrQ==
X-Gm-Message-State: APjAAAWop1WFSy0UXqu2B69wxwK2uNxluE56iIGA25YnHHKWU/XmIAKH
        rnnrV1wPZ4k5Jw/LSq7b+eA=
X-Google-Smtp-Source: APXvYqx8KMf2Vlev4sBFud5jnvb1R1NiRHF1UeW8ah5SDM6BcGXfoWaOFRH6oquFpZCxlzFS59p4fA==
X-Received: by 2002:a37:a48e:: with SMTP id n136mr9545064qke.223.1567784741768;
        Fri, 06 Sep 2019 08:45:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e7cb])
        by smtp.gmail.com with ESMTPSA id s23sm3132385qte.72.2019.09.06.08.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:45:41 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:45:39 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, Kenny Ho <y2kenny@gmail.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190906154539.GP2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local>
 <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com>
 <20190906152320.GM2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uEXP7XLFB2aFU6+E0TH_DepFRkfCoKoHwkXtjZRDyhHig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEXP7XLFB2aFU6+E0TH_DepFRkfCoKoHwkXtjZRDyhHig@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Fri, Sep 06, 2019 at 05:34:16PM +0200, Daniel Vetter wrote:
> > Hmm... what'd be the fundamental difference from slab or socket memory
> > which are handled through memcg?  Is system memory used by GPUs have
> > further global restrictions in addition to the amount of physical
> > memory used?
> 
> Sometimes, but that would be specific resources (kinda like vram),
> e.g. CMA regions used by a gpu. But probably not something you'll run
> in a datacenter and want cgroups for ...
> 
> I guess we could try to integrate with the memcg group controller. One
> trouble is that aside from i915 most gpu drivers do not really have a
> full shrinker, so not sure how that would all integrate.

So, while it'd great to have shrinkers in the longer term, it's not a
strict requirement to be accounted in memcg.  It already accounts a
lot of memory which isn't reclaimable (a lot of slabs and socket
buffer).

> The overall gpu memory controller would still be outside of memcg I
> think, since that would include swapped-out gpu objects, and stuff in
> special memory regions like vram.

Yeah, for resources which are on the GPU itself or hard limitations
arising from it.  In general, we wanna make cgroup controllers control
something real and concrete as in physical resources.

> > At the system level, it just gets folded into cpu time, which isn't
> > perfect but is usually a good enough approximation of compute related
> > dynamic resources.  Can gpu do someting similar or at least start with
> > that?
> 
> So generally there's a pile of engines, often of different type (e.g.
> amd hw has an entire pile of copy engines), with some ill-defined
> sharing charateristics for some (often compute/render engines use the
> same shader cores underneath), kinda like hyperthreading. So at that
> detail it's all extremely hw specific, and probably too hard to
> control in a useful way for users. And I'm not sure we can really do a
> reasonable knob for overall gpu usage, e.g. if we include all the copy
> engines, but the workloads are only running on compute engines, then
> you might only get 10% overall utilization by engine-time. While the
> shaders (which is most of the chip area/power consumption) are
> actually at 100%. On top, with many userspace apis those engines are
> an internal implementation detail of a more abstract gpu device (e.g.
> opengl), but with others, this is all fully exposed (like vulkan).
> 
> Plus the kernel needs to use at least copy engines for vram management
> itself, and you really can't take that away. Although Kenny here has
> some proposal for a separate cgroup resource just for that.
> 
> I just think it's all a bit too ill-defined, and we might be better
> off nailing the memory side first and get some real world experience
> on this stuff. For context, there's not even a cross-driver standard
> for how priorities are handled, that's all driver-specific interfaces.

I see.  Yeah, figuring it out as this develops makes sense to me.  One
thing I wanna raise is that in general we don't want to expose device
or implementation details in cgroup interface.  What we want expressed
there is the intentions of the user.  The more internal details we
expose the more we end up getting tied down to the specific
implementation which we should avoid especially given the early stage
of development.

Thanks.

-- 
tejun
