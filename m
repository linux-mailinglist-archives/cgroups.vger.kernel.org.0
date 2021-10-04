Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5507421548
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJDRqQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 13:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhJDRqQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 13:46:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55716C061745;
        Mon,  4 Oct 2021 10:44:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m14so212346pfc.9;
        Mon, 04 Oct 2021 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GlP8WaB0zRZgpiKdt/BSMoK6ihgOV+T5zAu0xpLxZyQ=;
        b=MrX57fwHmCyrgUKhL9es+GURrgy7bi5kQGDxIwCkl/coK/2RZmEGBuZqtlgxCmVqaB
         uzqBtWgowXjuQRyRlJVYwDRdEJfkE1/MSIM/+EvBZoCemlBJCMW2Qv4PtgHAHXssT5aP
         SKBBWXGjLZ+uQM6T35vAGDIxPKQr7EeyhcZDwKMVxCcGaf+nzpvl1HDMRFPR1nhteoTH
         j33ozfp/gml4Fy2CPQ0RSY/5HyZ4uWzgUb2TMxSXMpsvN8UvfjFK7rJrb20juqnzkT+9
         FXTdO9B8WR2O8ZIpKjcHY7p+18d2PiA2ECq2gNUDUOO95wuHitclGuSVWLBNpMDEqG6s
         sFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GlP8WaB0zRZgpiKdt/BSMoK6ihgOV+T5zAu0xpLxZyQ=;
        b=HKi2esxJNOut3f8tTUukmuMdW5wuRsk7tls/cR+MRB4/HIge1mt2xnQ6tUh/jADqnZ
         9ZRvb6mdXFzCnZdsns8QoUXpAw7bHTO0hRaqhEucY+gR5U0Dwhgr2bnhglx8ItQgzVq4
         pCzXEVrXJz4Guf6dxFlYMIBF/57uF+GiR0KIPC30smk3LfAGnn9NIB7IGguHk8UjmaMJ
         GDLV/DWhNEHWkIVVyjPN586Wfv4Odd5doS/ZYOucHvV8BU6wJtSVaNTWLN/eWj0eClpy
         /00Bls3e2YSS6x7pjjAwIfzNVCel2mSPDcF55ldFF+ptr2IDs4OSNd6JB5VxITFqalyL
         5toA==
X-Gm-Message-State: AOAM530LW1xs7Tj+Y9pmYnVsi7PkpRoOFx8EliIQQN/yGWQ/RAKfS/Ny
        cLWfgSwRExpr8hPNk/DkiEcSGpCB8yI=
X-Google-Smtp-Source: ABdhPJwMPHeoglHMelv0HVvXhBblkGnmaLd3GLrLC/5jKkh9FB3yPjGqn5XHkzF1oc7w621byg/Fxw==
X-Received: by 2002:a62:dd0a:0:b0:44b:bd85:9387 with SMTP id w10-20020a62dd0a000000b0044bbd859387mr26005806pff.49.1633369466607;
        Mon, 04 Oct 2021 10:44:26 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c8sm15095918pfj.204.2021.10.04.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:44:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 07:44:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
Message-ID: <YVs9eJnNJYwF/3f3@slm.duckdns.org>
References: <20210929235936.2859271-1-shakeelb@google.com>
 <YVszNI97NAAYpHpm@slm.duckdns.org>
 <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 04, 2021 at 10:25:12AM -0700, Shakeel Butt wrote:
> > > To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
> > > a system with swap-on-zram and the file was pushed to swap through
> > > memory.force_empty interface. On reading the whole file, the memcg stat
> > > flush in the refault code path is triggered. With this patch, we
> > > observed 38% reduction in the read time of 8 GiB file.
> >
> > The patch looks fine to me but that's a lot of reduction in read time. Can
> > you elaborate a bit on why this makes such a huge difference? Who's hitting
> > on that lock so hard?
> 
> It was actually due to machine size. I ran a single threaded workload
> without any interference on a 112 cpus machine. So, most of the time
> the flush was acquiring and releasing the per-cpu rstat lock for empty
> trees.

Sorry for being so slow but can you point to the exact call path which gets
slowed down so significantly? I'm mostly wondering whether we need some sort
of time-batched flushes because even with lock avoidance the flush path
really isn't great when called frequently. We can mitigate it further if
necessary - e.g. by adding an "updated" bitmap so that the flusher doesn't
have to go around touching the cachelines for all the cpus.

Thanks.

-- 
tejun
