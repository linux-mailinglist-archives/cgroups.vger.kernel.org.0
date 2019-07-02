Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCD5D061
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2019 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGBNUJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Jul 2019 09:20:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36091 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGBNUI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Jul 2019 09:20:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so8716498edq.3
        for <cgroups@vger.kernel.org>; Tue, 02 Jul 2019 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzwvLHoODplnbHp8E5wmzRqBd3OOGVG/jeLS3EJmbkI=;
        b=PLQgsPgYBC/G9Xu6IxvRYvzAvQRalruQEH0a8dsSrM/GzFFEwvOGcjPQPO8gkjDj6L
         VAPFPhiDO0tL24ASu834S6tk4flGYFc7iVwXREVPsrVkjby6PD3rjVTPaMDeUho627RR
         vug066EctcLUKndhQWVVmmH+MAXfdNRYxOHqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzwvLHoODplnbHp8E5wmzRqBd3OOGVG/jeLS3EJmbkI=;
        b=s/9s91ggiorZus7gXj6VDOOV1LcnMAi/Q1NQ+oXTUIL3HKGrMujS7Pi5TC0yfJXfsv
         E6X5QvlDRoCEju/20MGUfhot8dgpHivV6Y6ADlK2KIDlEaFCijEGqts7QYgGr641a7z/
         4TT3Ia37Vxcmt7w4Kyin9Y5lFkXc4j/zMx2W27iCmuxie+NAn2dF7l1vgYW2MJdQeB8Y
         2dVTnUstsJaN4nQMWfd0hs5JVmfgsQ2Dj8bUZUm+a6upOuKi2A0Dc25mZXY7cy32Jryu
         /nvPT8u27HDHV104H9QPxx5E0+Zqe66hBkltpxqRESDPd+SqtNUjAQeHu7iH23+c06bU
         RFRw==
X-Gm-Message-State: APjAAAWXEy79LiIgfzTbRtiORWQsVlpk4A4UT+zb6lWTpE+Q8tOSUCHV
        eFj4iI2XC7R/BOfWEWWHWjzCgg==
X-Google-Smtp-Source: APXvYqw7FGdmAU7xcVGE/u+98yQ6KUSJpvpjWVisE8v6s1ByxKG2c+sZUyC6EXgZQVbFuJbU9e7APQ==
X-Received: by 2002:aa7:d985:: with SMTP id u5mr6460651eds.222.1562073607031;
        Tue, 02 Jul 2019 06:20:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g3sm4558034edh.24.2019.07.02.06.20.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:20:05 -0700 (PDT)
Date:   Tue, 2 Jul 2019 15:20:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 09/11] drm, cgroup: Add per cgroup bw measure and
 control
Message-ID: <20190702132003.GB15868@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-10-Kenny.Ho@amd.com>
 <20190626162554.GU12905@phenom.ffwll.local>
 <CAOWid-dO5QH4wLyN_ztMaoZtLM9yzw-FEMgk3ufbh1ahHJ2vVg@mail.gmail.com>
 <20190627061153.GD12905@phenom.ffwll.local>
 <CAOWid-dCkevUiN27pkwfPketdqS8O+ZGYu8vRMPY2GhXGaVARA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-dCkevUiN27pkwfPketdqS8O+ZGYu8vRMPY2GhXGaVARA@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 28, 2019 at 03:49:28PM -0400, Kenny Ho wrote:
> On Thu, Jun 27, 2019 at 2:11 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > I feel like a better approach would by to add a cgroup for the various
> > engines on the gpu, and then also account all the sdma (or whatever the
> > name of the amd copy engines is again) usage by ttm_bo moves to the right
> > cgroup.  I think that's a more meaningful limitation. For direct thrashing
> > control I think there's both not enough information available in the
> > kernel (you'd need some performance counters to watch how much bandwidth
> > userspace batches/CS are wasting), and I don't think the ttm eviction
> > logic is ready to step over all the priority inversion issues this will
> > bring up. Managing sdma usage otoh will be a lot more straightforward (but
> > still has all the priority inversion problems, but in the scheduler that
> > might be easier to fix perhaps with the explicit dependency graph - in the
> > i915 scheduler we already have priority boosting afaiui).
> My concern with hooking into the engine/ lower level is that the
> engine may not be process/cgroup aware.  So the bandwidth tracking is

Why is the engine not process aware? Thus far all command submission I'm
aware of is done by a real process from userspace ... we should be able to
track these with cgroups perfectly.

> per device.  I am also wondering if this is also potentially be a case
> of perfect getting in the way of good.  While ttm_bo_handle_move_mem
> may not track everything, it is still a key function for a lot of the
> memory operation.  Also, if the programming model is designed to
> bypass the kernel then I am not sure if there are anything the kernel
> can do.  (Things like kernel-bypass network stack comes to mind.)  All
> that said, I will certainly dig deeper into the topic.

The problem is there's not a full bypass of the kernel, any reasonable
workload will need both. But if you only control one side of the bandwidth
usuage, you're not really controlling anything.

Also, this is uapi: Perfect is pretty much the bar we need to clear, any
mistake will hurt us for the next 10 years at least :-)

btw if you haven't read it yet: The lwn article about the new block io
controller is pretty interesting. I think you're trying to solve a similar
problem here:

https://lwn.net/SubscriberLink/792256/e66982524fa9477b/

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
