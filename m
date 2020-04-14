Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E630E1A8A22
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504392AbgDNStX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:49:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39074 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504372AbgDNStV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 14:49:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11so4360679wrs.6
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 11:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5etxd9gVFF2A6oPERnSptsX6ygEMzNVMa/EIetpdkKU=;
        b=BfmxWLyXyhoWdlU7Rn8DXGpYLPP+C7xsFlfeN99OM8gIgj01MkvsM1g2QU0VKIaIqc
         VfVUdinbtB2R3xHJqrUbbPzM9jiPZoQi5BKdrMgrWwOSZgwWjTESBG0zoUiLn8IRMFXd
         4cZX2pXpRYoCoepgIy4gUSTUeE/KfFdsU0aFFmx+Y6buX4ktL2g+hbBgTZkJ1RoyWmNB
         7b4OpirWjLxydEEJ5+4hEQHSuZtErRMiqg83UykQEisXbifwitUhCHRn+qwmq2eqpGvT
         0do+XLEZvxNw9gAfyFBgHlo1sK8O2Sty1jvVCg9+iyDqmJVPSMNYB/rQNzkD2rNlWwLd
         jJwQ==
X-Gm-Message-State: AGi0PuajWHFt3QEV8xXMNO8SsEIb4IdU0e0M+U+BorDJe6X5WO098jPP
        JO+etCZwNOhREJLBybaByJI=
X-Google-Smtp-Source: APiQypLxnQgq9Itt+tEMgXYqaqb6KCW+fSDosF9wKWsC6LKfUejb1sLd5HN4lOiyxHlj6u9skdjO4w==
X-Received: by 2002:adf:f4cc:: with SMTP id h12mr24661827wrp.171.1586890159764;
        Tue, 14 Apr 2020 11:49:19 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id n6sm19047761wmc.28.2020.04.14.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:49:18 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:49:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Cc:     svc_lmoiseichuk@magicleap.com, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, tj@kernel.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, minchan@kernel.org, vinmenon@codeaurora.org,
        andriy.shevchenko@linux.intel.com, anton.vorontsov@linaro.org,
        penberg@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200414184917.GT4629@dhcp22.suse.cz>
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

On Tue 14-04-20 12:42:44, Leonid Moiseichuk wrote:
> Thanks Michal for quick response, see my answer below.
> I will update the commit message with numbers for 8 GB memory swapless
> devices.
> 
> On Tue, Apr 14, 2020 at 7:37 AM Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Mon 13-04-20 17:57:48, svc_lmoiseichuk@magicleap.com wrote:
> > > From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>
> > >
> > > Small tweak to populate vmpressure parameters to userspace without
> > > any built-in logic change.
> > >
> > > The vmpressure is used actively (e.g. on Android) to track mm stress.
> > > vmpressure parameters selected empiricaly quite long time ago and not
> > > always suitable for modern memory configurations.
> >
> > This needs much more details. Why it is not suitable? What are usual
> > numbers you need to set up to work properly? Why those wouldn't be
> > generally applicable?
> >
> As far I see numbers which vmpressure uses - they are closer to RSS of
> userspace processes for memory utilization.
> Default calibration in memory.pressure_level_medium as 60% makes 8GB device
> hit memory threshold when RSS utilization
> reaches ~5 GB and that is a bit too early, I observe it happened
> immediately after boot. Reasonable level should be
> in the 70-80% range depending on SW preloaded on your device.

I am not sure I follow. Levels are based on the reclaim ineffectivity not
the overall memory utilization. So it takes to have only 40% reclaim
effectivity to trigger the medium level. While you are right that the
threshold for the event is pretty arbitrary I would like to hear why
that doesn't work in your environment. It shouldn't really depend on the
amount of memory as this is a percentage, right?

> From another point of view having a memory.pressure_level_critical set to
> 95% may never happen as it comes to a level where an OOM killer already
> starts to kill processes,
> and in some cases it is even worse than the now removed Android low memory
> killer. For such cases has sense to shift the threshold down to 85-90% to
> have device reliably
> handling low memory situations and not rely only on oom_score_adj hints.
> 
> Next important parameter for tweaking is memory.pressure_window which has
> the sense to increase twice to reduce the number of activations of userspace
> to save some power by reducing sensitivity.

Could you be more specific, please?

> For 12 and 16 GB devices the situation will be similar but worse, based on
> fact in current settings they will hit medium memory usage when ~5 or 6.5
> GB memory will be still free.
> 
> 
> >
> > Anyway, I have to confess I am not a big fan of this. vmpressure turned
> > out to be a very weak interface to measure the memory pressure. Not only
> > it is not numa aware which makes it unusable on many systems it also
> > gives data way too late from the practice.
> >
> > Btw. why don't you use /proc/pressure/memory resp. its memcg counterpart
> > to measure the memory pressure in the first place?
> >
> 
> According to our checks PSI produced numbers only when swap enabled e.g.
> swapless device 75% RAM utilization:

I believe you should discuss that with the people familiar with PSI
internals (Johannes already in the CC list). 
-- 
Michal Hocko
SUSE Labs
