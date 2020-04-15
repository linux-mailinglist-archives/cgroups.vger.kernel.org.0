Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464281A9544
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635370AbgDOHzk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Apr 2020 03:55:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50528 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635402AbgDOHzg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Apr 2020 03:55:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id x25so16235831wmc.0
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2020 00:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82iX8iXTHfqyovIgf5kiyQIgAJjX9SPtyGR8K6K5RtU=;
        b=tB0A6J+OTpYLBEAeKh2sfmNB39MkxIU8ZOUojUsBAIot7SkrUr8bAAp1B3Ar1PtvPo
         5+s5mF9Mh14fhVLjGfPmUJQFkSgpxrSarFCUZNS3DmcrP0HbDwYEfqU+3rYSLUNaYS5m
         bIO/wDPNuvzcSiVaIo/evhnAgiAHQerMIchhnoz5J9Rj9QfP50wH/hsrzRRoLylvcL+p
         3UcXYoiy9PU4hZXpO4UbzkXuxjK+ZoVuj1bf/dQv2KY9BpO/3c/wxIj3D6dPAz3hzsnE
         /lSRrs7Mr4mFLSG51wfFK1ZfI1W4XkAAhecMaKgrznmMHjRXXLd+utggj4WOy+MrQiC6
         QCSw==
X-Gm-Message-State: AGi0PuYo2irLY/uhie15N64ASNQuE+WL5j2qxNv0Af9yl4SYJjMB/Td6
        rjJ3Hx2eYaLX6aOt1ik2j88=
X-Google-Smtp-Source: APiQypLEOmrr+HNvcmWr4UiSXn6WVrLtpE5NtIlToiaDF5+QZMGpYb8TqQjrIL3OqLooAaqa1O2rUw==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr4235915wmk.68.1586937334012;
        Wed, 15 Apr 2020 00:55:34 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id z16sm23857077wrl.0.2020.04.15.00.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:55:32 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:55:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        svc lmoiseichuk <svc_lmoiseichuk@magicleap.com>,
        vdavydov.dev@gmail.com, tj@kernel.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, minchan@kernel.org, vinmenon@codeaurora.org,
        andriy.shevchenko@linux.intel.com, penberg@kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200415075532.GZ4629@dhcp22.suse.cz>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
 <20200414113730.GH4629@dhcp22.suse.cz>
 <CAELvCDTGnpA4WBAMZjGSLTrg2-Dbb3kTmLjMTw_JLYXBdvpcxw@mail.gmail.com>
 <20200414192329.GC136578@cmpxchg.org>
 <CAELvCDS_z-bTvRZ7fxkfHjnjV1WzFcxarzrbT1pDwkXX_dmOoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELvCDS_z-bTvRZ7fxkfHjnjV1WzFcxarzrbT1pDwkXX_dmOoA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-04-20 18:12:47, Leonid Moiseichuk wrote:
> I do not agree with all comments, see below.
> 
> On Tue, Apr 14, 2020 at 3:23 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > On Tue, Apr 14, 2020 at 12:42:44PM -0400, Leonid Moiseichuk wrote:
> > > On Tue, Apr 14, 2020 at 7:37 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > On Mon 13-04-20 17:57:48, svc_lmoiseichuk@magicleap.com wrote:
> > > > Anyway, I have to confess I am not a big fan of this. vmpressure turned
> > > > out to be a very weak interface to measure the memory pressure. Not
> > only
> > > > it is not numa aware which makes it unusable on many systems it also
> > > > gives data way too late from the practice.
> >
> > Yes, it's late in the game for vmpressure, and also a bit too late for
> > extensive changes in cgroup1.
> >
> 200 lines just to move functionality from one place to another without
> logic change?
> There does not seem to be extensive changes.

Any user visible API is an big change. We have to maintain any api for
ever. So there has to be a really strong reason/use case for inclusion.
I haven't heard any strong justification so far. It all seems to me that
you are trying to workaround real vmpressure issues by fine tunning
parameters and that is almost always a bad reason for a adding a new
tunning.
-- 
Michal Hocko
SUSE Labs
