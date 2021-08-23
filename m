Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADB3F4FC7
	for <lists+cgroups@lfdr.de>; Mon, 23 Aug 2021 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhHWRrq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Aug 2021 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhHWRrq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Aug 2021 13:47:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22ABC061757
        for <cgroups@vger.kernel.org>; Mon, 23 Aug 2021 10:47:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y144so20100721qkb.6
        for <cgroups@vger.kernel.org>; Mon, 23 Aug 2021 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gbkRpn8OvHDvVhkug5/SCecw4iR6zEDgQeKV01fnIoo=;
        b=upkSxN2nnvY2Wv/MwUo3Qk+bN9RsxVHHPTcUHGhtMHImyRfryeKTsloFifEFrqdlt0
         UxVtQai+tAQNcsIJ818me8Yhi3/bMHiaU7UglvqElSdxuOBTPg8BCOnN3T1AJfORwqcH
         NYTKsEACcfB06lkK8E4ps1ukwzCLeG8yfT85LndESHBE7pMmxUCgd78URSV2DpFKMKNs
         5j1L94LSJYWhTz1Yyq8X6ZJU0F/PJxu6jlgN3V1E7rR727XeyxqXOvVGAY1aVcOmGrAW
         7SpfwdKSRYCa67kYAD3SULGslNCC8EhJZcPuSsdvmwK1YPuq5Us1QyWndADVs8b5Lf83
         KDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gbkRpn8OvHDvVhkug5/SCecw4iR6zEDgQeKV01fnIoo=;
        b=Nlid/GWrha7rS/qCHs5XiqoQ+jJZrkeZ7VRcYI2BTQbfhXFaa7ScOfddO/3F4Y36lG
         mtYsdkKVHrZwafpnpvi8yyasfJqeAHTQld426RS889VjsCMM47366Ug01dtdQyuTef+T
         hMRgPGcTqwrGcsNbSvl9HuLI1bdbEVtOjSizr9MhGne+uQAsxk2lfhjZ1YmLOVc4ykbS
         Y4ZX28Hi0DCFJMW/qFsCjY4qbGtHCDYeDWnlyDIENAQeKMWeKJzlRbKbTPM+nZ7OH2I1
         Cooukzs4StnDun4dW7uzQndk7HP8IHp/bjfz7Iad6op9Z26c7xrpSdSJjcng341x4L1s
         gZOw==
X-Gm-Message-State: AOAM533RqBDmHGVMAGCh4xF8VXNvD0NMYUAsucmFazOpqGkxBkYAXJNO
        yw+QHiZ6pBikCOhChtfubPVtIw==
X-Google-Smtp-Source: ABdhPJy4VFl7V2wM8ld39ppY0iGYe5/g3eWo45c2toz0PzW8foCKoU6B6OX1uvt8ckaX5+Gqtj2lpA==
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr17734902qkt.77.1629740822738;
        Mon, 23 Aug 2021 10:47:02 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s28sm8833950qkm.43.2021.08.23.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:47:01 -0700 (PDT)
Date:   Mon, 23 Aug 2021 13:48:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YSPfe4yf2fRdzijh@cmpxchg.org>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
 <YSPIOZOVG2qplLIW@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSPIOZOVG2qplLIW@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Mon, Aug 23, 2021 at 06:09:29PM +0200, Michal Koutný wrote:
> Hello
> 
> (and sorry for a belated reply).

It's never too late, thanks for taking a look.

> On Tue, Aug 17, 2021 at 02:05:06PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > @@ -2576,6 +2578,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> > [...]
> > +			/* memory.low scaling, make sure we retry before OOM */
> > +			if (!sc->memcg_low_reclaim && low > min) {
> > +				protection = low;
> > +				sc->memcg_low_skipped = 1;
> 
> IIUC, this won't result in memory.events:low increment although the
> effect is similar (breaching (partial) memory.low protection) and signal
> to the user is comparable (overcommited memory.low).

Good observation. I think you're right, we should probably count such
partial breaches as LOW events as well.

Note that this isn't new behavior. My patch merely moved this part
from mem_cgroup_protection():

-       if (in_low_reclaim)
-               return READ_ONCE(memcg->memory.emin);

Even before, if we retried due to just one (possibly insignificant)
cgroup below low, we'd ignore proportional reclaim and partially
breach ALL protected cgroups, while only counting a low event for the
one group that is usage < low.

> Admittedly, this patch's behavior adheres to the current documentation
> (Documentation/admin-guide/cgroup-v2.rst):
> 
> > The number of times the cgroup is reclaimed due to high memory
> > pressure even though its usage is under the low boundary,
> 
> however, that definition might not be what the useful indicator would
> be now.
> Is it worth including these partial breaches into memory.events:low?

I think it is. How about:

"The number of times the cgroup's memory.low-protected memory was
reclaimed in order to avoid OOM during high memory pressure."

And adding a MEMCG_LOW event to partial breaches. BTW, the comment
block above this code is also out-of-date, because it says we're
honoring memory.low on the retries, but that's not the case.

I'll prepare a follow-up patch for these 3 things as well as the more
verbose comment that Michal Hocko asked for on the retry logic.
