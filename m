Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1C1A951F
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 09:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635347AbgDOHvp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Apr 2020 03:51:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34995 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635311AbgDOHvk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Apr 2020 03:51:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so17754604wmh.0
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2020 00:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZflJgwYSj531imkdPG/TxmV4Iy8O6kY7AdN2O/yZCw=;
        b=UeSHUtF4A4BRT9YNqBcKb/wJmtmrY3IxvnbZUIp3OqMsb5JpujA38cF3El7IQ53FLa
         79qGk1yC2ztDbV3gv+uREvZVG/dJx/w1JWR8Xh6LfwI9nd/wdSsJH3aOh3DMpZhK2j6h
         G4fgnx97em4mMjCDAyqG+rmIZ0PhIfEyePFES59m0M6Q5ldSXEHakaSkbQiFLhbKU4qz
         HRtNWV49IOB7Z9jSDJGXj4YvJNbieGrtVWN3/tj6aJiHY53PwOZSDscfveH/av5D1rfY
         vaErEgDy8KfkopLhqJBNTHHK03fm2M74BuuACqK9FNhelxxy0YHKiWvkOU3xEVBO74jU
         MzkQ==
X-Gm-Message-State: AGi0PuYB9K906JKvQ6tB50M8qGDoy/91SmAm54ujB4P78R4sFc+quBPs
        5t60HwNvcajePMiAEffAo58=
X-Google-Smtp-Source: APiQypIza0iw/xuyz5yuC0fuTDRpTmP7jRNmDBuhq9AUulMDjkDrkpM4iU5PdwdQjAqAFJHbNZ/qyg==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr3758464wmc.124.1586937098873;
        Wed, 15 Apr 2020 00:51:38 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a205sm17197249wmh.29.2020.04.15.00.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:51:37 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:51:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Cc:     svc_lmoiseichuk@magicleap.com, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, tj@kernel.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, minchan@kernel.org, vinmenon@codeaurora.org,
        andriy.shevchenko@linux.intel.com, anton.vorontsov@linaro.org,
        penberg@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200415075136.GY4629@dhcp22.suse.cz>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
 <20200414113730.GH4629@dhcp22.suse.cz>
 <CAELvCDTGnpA4WBAMZjGSLTrg2-Dbb3kTmLjMTw_JLYXBdvpcxw@mail.gmail.com>
 <20200414184917.GT4629@dhcp22.suse.cz>
 <CAELvCDQRYmTZrGSwBUjnRJB3kfB_5JOJ5ELdGv+tkCyhvM=x9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELvCDQRYmTZrGSwBUjnRJB3kfB_5JOJ5ELdGv+tkCyhvM=x9A@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-04-20 16:53:55, Leonid Moiseichuk wrote:
> It would be nice if you can specify exact numbers you like to see.

You are proposing an interface which allows to tune thresholds from
userspace. Which suggests that you want to tune them. I am asking what
kind of tuning you are using and why cannot we use them as defaults in
the kernel.

> On Tue, Apr 14, 2020 at 2:49 PM Michal Hocko <mhocko@kernel.org> wrote:
> 
> > ....
> 
> > As far I see numbers which vmpressure uses - they are closer to RSS of
> > > userspace processes for memory utilization.
> > > Default calibration in memory.pressure_level_medium as 60% makes 8GB
> > device
> > > hit memory threshold when RSS utilization
> > > reaches ~5 GB and that is a bit too early, I observe it happened
> > > immediately after boot. Reasonable level should be
> > > in the 70-80% range depending on SW preloaded on your device.
> >
> > I am not sure I follow. Levels are based on the reclaim ineffectivity not
> > the overall memory utilization. So it takes to have only 40% reclaim
> > effectivity to trigger the medium level. While you are right that the
> > threshold for the event is pretty arbitrary I would like to hear why
> > that doesn't work in your environment. It shouldn't really depend on the
> > amount of memory as this is a percentage, right?
> >
> It is not only depends from amount of memory or reclams but also what is
> software running.
> 
> As I see from vmscan.c vmpressure activated from various shrink_node()  or,
> basically do_try_to_free_pages().
> To hit this state you need to somehow lack memory due to various reasons,
> so the amount of memory plays a role here.
> In particular my case is very impacted by GPU (using CMA) consumption which
> can easily take gigs.
> Apps can take gigabyte as well.
> So reclaiming will be quite often called in case of lack of memory (4K
> calls are possible).
> 
> Handling level change will happen if the amount of scanned pages is more
> than window size, 512 is too little as now it is only 2 MB.
> So small slices are a source of false triggers.
> 
> Next, pressure counted as
>         unsigned long scale = scanned + reclaimed;
>         pressure = scale - (reclaimed * scale / scanned);
>         pressure = pressure * 100 / scale;

Just to make this more obvious this is essentially 
	100 * (1 - reclaimed/scanned)

> Or for 512 pages (lets use minimal) it leads to reclaimed should be 204
> pages for 60% threshold and 25 pages for 95% (as critical)
>
> In case of pressure happened (usually at 85% of memory used, and hittin
> critical level)

I still find this very confusing because the amount of used memory is
not really important. It really only depends on the reclaim activity and
that is either the memcg or the global reclaim. And you are getting
critical levels only if the reclaim is failing to reclaim way too many
pages. 

> I rarely see something like closer to real numbers
> vmpressure_work_fn: scanned 545, reclaimed 144   <-- 73%
> vmpressure_work_fn: scanned 16283, reclaimed 2495  <-- same session but 83%
> Most of the time it is looping between kswapd and lmkd reclaiming failures,
> consuming quite a high amount of cpu.
> 
> On vmscan calls everything looks as expected
> [  312.410938] vmpressure: tree 0 scanned 4, reclaimed 2
> [  312.410939] vmpressure: tree 0 scanned 120, reclaimed 62
> [  312.410939] vmpressure: tree 1 scanned 2, reclaimed 1
> [  312.410940] vmpressure: tree 1 scanned 120, reclaimed 62
> [  312.410941] vmpressure: tree 0 scanned 0, reclaimed 0

This looks more like a problem of vmpressure implementation than
something you want to workaround by tuning to me.

-- 
Michal Hocko
SUSE Labs
