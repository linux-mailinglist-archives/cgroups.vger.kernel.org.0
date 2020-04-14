Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE91A8ACA
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 21:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504807AbgDNTar (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504775AbgDNT3q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 15:29:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063FC025480
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 12:23:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l13so8472463qtr.7
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IiZNJMCD1kbGltSbdSP42lcTPVfZZdCFmf+wp01qYTo=;
        b=RwwCmIB7ctPm2eZIIKDEiOKmos3jQdBxTVEG5RvZSbkV6qx3mS8owINSN9Q4vZ7OIS
         RV2m8pThdMF5zEvqM8E1gyAWGDKpUUtKRbX2qGs7db5dBKU+S9aWrAM7z6XMQCvIbpSV
         RHT+8Xv7lNrxl4dZwvcKb9a30lxz9ZqbNxtyS6EtjXe2NOPVf0EkQm45oLKdDhlO0rkz
         v/6G1qSst8Q0DW/UeN6I0cwt0GE7xhFcDsDyAUiLCDVa9nrQjXrKPI8lk1vvJwlt2RM5
         ynB6xM183bbjPmwSl74sG2i8nCWCJ6aKUCDDLZc4WfCYXrewgkvLvBlv8vntw/Acb09x
         3g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IiZNJMCD1kbGltSbdSP42lcTPVfZZdCFmf+wp01qYTo=;
        b=NPZwxZuFdou2Wdnsf7CufVHZkmc3hASAtSqmbDDt6Qg8k4PXvgWS5vgnDtQYT2xRbi
         Etlim2qL7gzk5PWsyTZFAivT7Sz6n/JeUr6lcADQRXC5s8xzteGDF3tLbSk3s6g/NAKX
         Mb8eYpEP9SFyz/B4UavfV/Hn1blR7qiPD6JVDB1rmewf9C3JId4H1aJ5iFbYLcGQbdGb
         33njTpT50eHEMt/DqkIBCRZneXq9cOL85NW5PyJKO7k6ZiS124tJCDPmeLMaIrQJJdid
         WY4AOaVui4HdIGyX9LQlh+0fKywTJpQUKthlvFXDsBbqTAio6R3GxNai4t8SsmxjYu8u
         0EyQ==
X-Gm-Message-State: AGi0PuZVn+Jl/P3ouHiN05fQ5FIqxF3UMBGNotD0c+bqqm6jAePLVhU1
        xbiN4WrIk1uQcmYQIVg9FHHCTg==
X-Google-Smtp-Source: APiQypIsWwXZj6Vc0/5Ixmn0EpnCIL+tbz10939EFT76GeeCqkj6YupU4aY+atQ9Pws1uWy8K2uJBQ==
X-Received: by 2002:ac8:1ad1:: with SMTP id h17mr18050991qtk.9.1586892210731;
        Tue, 14 Apr 2020 12:23:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id m26sm11794637qta.53.2020.04.14.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:23:30 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:23:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Cc:     Michal Hocko <mhocko@kernel.org>, svc_lmoiseichuk@magicleap.com,
        vdavydov.dev@gmail.com, tj@kernel.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, minchan@kernel.org, vinmenon@codeaurora.org,
        andriy.shevchenko@linux.intel.com, anton.vorontsov@linaro.org,
        penberg@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200414192329.GC136578@cmpxchg.org>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
 <20200414113730.GH4629@dhcp22.suse.cz>
 <CAELvCDTGnpA4WBAMZjGSLTrg2-Dbb3kTmLjMTw_JLYXBdvpcxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELvCDTGnpA4WBAMZjGSLTrg2-Dbb3kTmLjMTw_JLYXBdvpcxw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 14, 2020 at 12:42:44PM -0400, Leonid Moiseichuk wrote:
> On Tue, Apr 14, 2020 at 7:37 AM Michal Hocko <mhocko@kernel.org> wrote:
> > On Mon 13-04-20 17:57:48, svc_lmoiseichuk@magicleap.com wrote:
> > Anyway, I have to confess I am not a big fan of this. vmpressure turned
> > out to be a very weak interface to measure the memory pressure. Not only
> > it is not numa aware which makes it unusable on many systems it also
> > gives data way too late from the practice.

Yes, it's late in the game for vmpressure, and also a bit too late for
extensive changes in cgroup1.

> > Btw. why don't you use /proc/pressure/memory resp. its memcg counterpart
> > to measure the memory pressure in the first place?
> >
> 
> According to our checks PSI produced numbers only when swap enabled e.g.
> swapless device 75% RAM utilization:
> ==> /proc/pressure/io <==
> some avg10=0.00 avg60=1.18 avg300=1.51 total=9642648
> full avg10=0.00 avg60=1.11 avg300=1.47 total=9271174
> 
> ==> /proc/pressure/memory <==
> some avg10=0.00 avg60=0.00 avg300=0.00 total=0
> full avg10=0.00 avg60=0.00 avg300=0.00 total=0

That doesn't look right. With total=0, there couldn't have been any
reclaim activity, which means that vmpressure couldn't have reported
anything either.

By the time vmpressure reports a drop in reclaim efficiency, psi
should have already been reporting time spent doing reclaim. It
reports a superset of the information conveyed by vmpressure.

> Probably it is possible to activate PSI by introducing high IO and swap
> enabled but that is not a typical case for mobile devices.
> 
> With swap-enabled case memory pressure follows IO pressure with some
> fraction i.e. memory is io/2 ... io/10 depending on pattern.
> Light sysbench case with swap enabled
> ==> /proc/pressure/io <==
> some avg10=0.00 avg60=0.00 avg300=0.11 total=155383820
> full avg10=0.00 avg60=0.00 avg300=0.05 total=100516966
> ==> /proc/pressure/memory <==
> some avg10=0.00 avg60=0.00 avg300=0.06 total=465916397
> full avg10=0.00 avg60=0.00 avg300=0.00 total=368664282
> 
> Since not all devices have zram or swap enabled it makes sense to have
> vmpressure tuning option possible since
> it is well used in Android and related issues are understandable.

Android (since 10 afaik) uses psi to make low memory / OOM
decisions. See the introduction of the psi poll() support:
https://lwn.net/Articles/782662/

It's true that with swap you may see a more gradual increase in
pressure, whereas without swap you may go from idle to OOM much
faster, depending on what type of memory is being allocated. But psi
will still report it. You may just have to use poll() to get in-time
notification like you do with vmpressure.
