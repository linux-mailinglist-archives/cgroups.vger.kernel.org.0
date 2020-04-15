Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB81AA097
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369385AbgDOM3N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Apr 2020 08:29:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52923 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409125AbgDOM3C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Apr 2020 08:29:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id o81so11600870wmo.2
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2020 05:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftXKO5Uq1KJxEgTgHTyrErxInw3k9nxtVAFqlw5s4i4=;
        b=ubEzcmB4Ef4tWyYgdQOYdnyOMD3qdMmlfgo2lyD7/S0XQI8dB68eqYdoBuWwXTdaiy
         Rkoqpq9DWI1TH5er0Bixpm+MZrh0mg4NuY1vudrOLM7pkHyo5MKgPlxgELSqvXf94q3b
         3QKeBF7UQdAMIwK41k3hiFxSyGEdIQvw4kFofB78cyzrBRuSaxHr8bYI8mRTegk/eWWC
         UHwQZ8KXks4NkXBQ6IEVCa8gAn4xzpusWlUvIa1vtuFnX3vtbKeBFJA1L8LF/6dcdkTs
         7QRz7lqSMQbuFZuQt0mMuumPP5pkmtoDekPKrPxHkq/AV+xmrQwTbKrPzHxAhIXIlmCm
         MWgg==
X-Gm-Message-State: AGi0PubtYQ73AYx2B4gYvjpsrdRZZrRo32gL7n0uExU6DXL9gVzsAPOs
        s/Ye5LfH1kdp6JexVtpKpeE=
X-Google-Smtp-Source: APiQypJZ8bSrRr2PVsjo3hNejerskpCnIaGTRW7Ou6W3HYDnqkfXcuDyayllBwhBvq4MyLdIHHffaA==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr4965829wmh.107.1586953739505;
        Wed, 15 Apr 2020 05:28:59 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id n6sm23860479wrs.81.2020.04.15.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 05:28:58 -0700 (PDT)
Date:   Wed, 15 Apr 2020 14:28:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Cc:     svc lmoiseichuk <svc_lmoiseichuk@magicleap.com>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        anton.vorontsov@linaro.org, penberg@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200415122857.GL4629@dhcp22.suse.cz>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
 <20200414113730.GH4629@dhcp22.suse.cz>
 <CAELvCDTGnpA4WBAMZjGSLTrg2-Dbb3kTmLjMTw_JLYXBdvpcxw@mail.gmail.com>
 <20200414184917.GT4629@dhcp22.suse.cz>
 <CAELvCDQRYmTZrGSwBUjnRJB3kfB_5JOJ5ELdGv+tkCyhvM=x9A@mail.gmail.com>
 <20200415075136.GY4629@dhcp22.suse.cz>
 <CAELvCDRpVi4zjpHCw1oeY=GXf8XO2TXGUFAwztvydS27Q8L9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELvCDRpVi4zjpHCw1oeY=GXf8XO2TXGUFAwztvydS27Q8L9Sw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 15-04-20 08:17:42, Leonid Moiseichuk wrote:
> As Chris Down stated cgroups v1 frozen, so no API changes in the mainline
> kernel.

Yes, this is true, _but_ if there are clear shortcomings in the existing
vmpressure implementation which could be addressed reasonably then there
is no reason to ignore them.

[...]

> > I still find this very confusing because the amount of used memory is
> > not really important. It really only depends on the reclaim activity and
> > that is either the memcg or the global reclaim. And you are getting
> > critical levels only if the reclaim is failing to reclaim way too many
> > pages.
> >
> 
> OK, agree from that point of view.
> But for larger systems reclaiming happens not so often and we can
> use larger window sizes to have better memory utilization approximation.

Nobody is saying the the window size has to be fixed. This all can be
auto tuned in the kernel.  It would, however, require to define what
"better utilization approximation" means much more specifically.

[...]
> > This looks more like a problem of vmpressure implementation than
> > something you want to workaround by tuning to me.
> >
> Basically it is how it works - collect the scanned page and activate worker
> activity to update the current level.

That is the case only for some vmpressure invocations. And your data
suggest that those might lead to misleading results. So this is likely
good to focus on and find out whether this can be addressed.
-- 
Michal Hocko
SUSE Labs
