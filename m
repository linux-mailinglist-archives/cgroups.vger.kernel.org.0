Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7477433DE8
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhJSR7c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhJSR7b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 13:59:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B4C06161C
        for <cgroups@vger.kernel.org>; Tue, 19 Oct 2021 10:57:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso522010pjw.2
        for <cgroups@vger.kernel.org>; Tue, 19 Oct 2021 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLohXwWhhTkoQPq47xX63nh19G3YNh9XY/6a/imyag8=;
        b=bE4UztpS09JP6k0FxL8qzRCmgmGOu7h35Ly+ryB0+uwFpWImRVkm8ypo5L/UOW1CWM
         O0unv30uo5Po3KqTqEe7G0wBV423YCjWaVW4yAL2wMuisjs9kkoLW3u8MMzPPAopAzHZ
         FEDNr1czg6363aU/zi4OMXrvf24H1EbvgWrppG8QphZYXtmmjzMmYTy7qql6buI5M5eh
         rWeUG3nEHzKjqzMszcPNyJwJb+E8uEOcu2CGl5zC73ZsJyMjUl3EhFSqNEeuTKwN3ItU
         VYi3sBDfIjb6uh+mdhjlO6cmabcxGKB4xh+LxDQbvVC3gf2KjvHtgifwKFb37CDFLfPS
         sw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YLohXwWhhTkoQPq47xX63nh19G3YNh9XY/6a/imyag8=;
        b=4om88hQ8eV/pDaDRpzyuHFegleoivAZmaTsE90x8CaqgElDIMswK6ABrks4e0WPvUV
         rq/OiWqFUOsqbufYZ7B5hXk43IqanZDEcXUvW+uJ+8OKa986MxlQPnp1pRvb9gg/Ivtf
         OlSzM5RLJCKjHwmqRw4eE6eTED3IinHVvBJckMq/d2ysCF2Op+ML8NY6NX+RMTGtrF32
         L8AqGu3g5hbMrVAbg4UEB5t4AUctZmiC7DnSzt7SurgA9KgvIngg8UgNqMBHhKYROKAM
         jzWFln/d1YCLXpVEj9poLw+J8w1sG7/YnJw4/U4v+RsHl+AeEiH/VrAgj9u/g7tRhtRc
         OB4w==
X-Gm-Message-State: AOAM532hZSnhYt4Tnljdfb+bbSNq46zOcSlVMkrQmMhxU2lXLNHV9mt0
        yIm/4oEcEWuUCFBxE45pJyl9jTMENgiGUg==
X-Google-Smtp-Source: ABdhPJyTsC4KrTIqFocFoJhRLt2GsnoYoA6sBD2XQXr9pGJpocnDehX0Fv13vlrW1gQzVmyPgx0+jA==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr1412413pjb.210.1634666238171;
        Tue, 19 Oct 2021 10:57:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j3sm3850259pfu.218.2021.10.19.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:57:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 07:57:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Odin Hultgren van der Horst <odin@digitalgarden.no>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org
Subject: Re: [Question] io cgroup subsystem threaded support
Message-ID: <YW8G+6QZOUYlQ1TE@slm.duckdns.org>
References: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
 <20211007133916.mgk6qb65d2r57fc2@T580.localdomain>
 <20211011153416.GB61605@blackbody.suse.cz>
 <20211015065135.5hauecjmri2lytpv@T580.localdomain>
 <20211015070745.zbzpistqrj6g4zxa@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015070745.zbzpistqrj6g4zxa@T580.localdomain>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Oct 15, 2021 at 09:07:45AM +0200, Odin Hultgren van der Horst wrote:
> > IIUC, the application would have to be collaborative anyway (dividing
> > threads into cgroups) and given you're concered about reads,
> > set_ioprio(2) might be enough for this case.

One problem there is that set_ioprio(2) only works w/ bfq.

> > Also, if you've seen starvation (likely depends on IO scheduler), you
> > may raise this with linux-block ML.
> 
> I also want to be able to limit amount of io for a given thread, just
> like you could to with io.max. So a given client cant just use all my io
> even though there is no competing thread.

This isn't what cgroup is too useful at right now. CPU control is an
exception partly due to historical reasons but it's silly to enable support
for per-thread IO control when a chunk as big as buffered writes is not only
missing but doesn't even have a plausible future path for support.

Another rather fundamental problem is that cgroup interface ends up
entangling application behavior with system admin operations - e.g. whether
IO control is available for a given application is determined by not just
the kernel configuration but how the system's cgroup hierarchy is configured
at the moment and an application's configurations can be wiped out by system
configuration changing.

Being able to extend resource control to per-thread level can definitely be
useful but we'd need a lot more work in providing a usable programmable
interface which can make cgroup system configuration transparent to the
applications so that applications can basically do something like
set_ioprio(2) and have resource control working as best as possible on top
of the system configuration at the moment.

Thanks.

-- 
tejun
