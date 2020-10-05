Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B22836E9
	for <lists+cgroups@lfdr.de>; Mon,  5 Oct 2020 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgJENvg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Oct 2020 09:51:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39995 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJENvf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Oct 2020 09:51:35 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kPQto-0000xP-TR
        for cgroups@vger.kernel.org; Mon, 05 Oct 2020 13:51:33 +0000
Received: by mail-wr1-f71.google.com with SMTP id g6so752452wrp.17
        for <cgroups@vger.kernel.org>; Mon, 05 Oct 2020 06:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQQp2PNEq0FY7Hqco5htUGBXM0/SRgDQIUWJr9BdqaM=;
        b=f5oj+ch0Im/B8O/C15MKikkyP7coj396Sev9xzhHesveis+JuYHQMV5945gEq4BvXv
         ElVFiTtlr4HRyFYfs4xnyYQMliaSDFRg8V6xm3JITE31/GRk35Omt5vCSzoY6vSCj3jB
         i8nqzudzuSQE01EJGpFFGZ16Da1LvCHinNz81+LaHQ+qdOO6BCOkZ1pVHspFXJ40ixVL
         aEAyTFg4V5xQfITP73DrBbaL7Sxx1UAMeBNvvrBd41E/ipNhqfmNK7P/EYWwhw6gjthy
         t4YOrwBJd75QdYI2aUgdoNzTWJp8DBwB52QBha39xgpfy4BiwBV1iQzloLAjopDSjRdn
         GtjA==
X-Gm-Message-State: AOAM532yfp8oZLyguRVcHXVuSvPuD4sCO78r2n7soek0GieJnK8yJrku
        2BjaIsHYHm216NGLepFo/fSgaZTBdi5cBjFg9wReVzK1Fqg4ZBQkUC+lk4KbW1nJ/6Z/4qPGqz7
        H5ThxMx4UTcMtErxTzIDZCSgXa2zOyYCg7EA=
X-Received: by 2002:a1c:28a:: with SMTP id 132mr17121818wmc.9.1601905892391;
        Mon, 05 Oct 2020 06:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwofc6USifXN7h+C0hcGmEQa4n+RfAxxI8ZWg7rnK634gMSN9Wa915TnRbfzQlf/I65n7VhQw==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr17121788wmc.9.1601905892065;
        Mon, 05 Oct 2020 06:51:32 -0700 (PDT)
Received: from localhost (host-79-36-133-218.retail.telecomitalia.it. [79.36.133.218])
        by smtp.gmail.com with ESMTPSA id t202sm13779805wmt.14.2020.10.05.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:51:31 -0700 (PDT)
Date:   Mon, 5 Oct 2020 15:51:30 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2] Opportunistic memory reclaim
Message-ID: <20201005135130.GA850459@xps-13-7390>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
 <20201005112555.GA108347@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005112555.GA108347@chrisdown.name>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 05, 2020 at 12:25:55PM +0100, Chris Down wrote:
> Andrea Righi writes:
> > This feature has been successfully used to improve hibernation time of
> > cloud computing instances.
> > 
> > Certain cloud providers allow to run "spot instances": low-priority
> > instances that run when there are spare resources available and can be
> > stopped at any time to prioritize other more privileged instances [2].
> > 
> > Hibernation can be used to stop these low-priority instances nicely,
> > rather than losing state when the instance is shut down. Being able to
> > quickly stop low-priority instances can be critical to provide a better
> > quality of service in the overall cloud infrastructure [1].
> > 
> > The main bottleneck of hibernation is represented by the I/O generated
> > to write all the main memory (hibernation image) to a persistent
> > storage.
> > 
> > Opportunistic memory reclaimed can be used to reduce the size of the
> > hibernation image in advance, for example if the system is idle for a
> > certain amount of time, so if an hibernation request happens, the kernel
> > has already saved most of the memory to the swap device (caches have
> > been dropped, etc.) and hibernation can complete quickly.
> 
> Hmm, why does this need to be implemented in kernelspace? We already have
> userspace shrinkers using memory pressure information as part of PID control
> already (eg. senpai). Using memory.high and pressure information looks a lot
> easier to reason about than having to choose an absolute number ahead of
> time and hoping it works.

senpai is focused at estimating the ideal memory requirements without
affecting performance. And this covers the use case about reducing
memory footprint.

In my specific use-case (hibernation) I would let the system use as much
memory as possible if it's doing any activity (reclaiming memory only
when the kernel decides that it needs to reclaim memory) and apply a
more aggressive memory reclaiming policy when the system is mostly idle.

I could probably implement this behavior adjusting memory.high
dynamically, like senpai, but I'm worried about potential sudden large
allocations that may require to respond faster at increasing
memory.high. I think the user-space triggered memory reclaim approach is
a safer solution from this perspective.

-Andrea
