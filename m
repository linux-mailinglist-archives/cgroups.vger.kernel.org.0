Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E79512470
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 23:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiD0VYb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 17:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiD0VYU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 17:24:20 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AF6E8FC
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 14:21:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q75so2287620qke.6
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HO69GAZWB5ZNDpZdF5+7qBeyAdQ2ziZHjagMLd+xkN0=;
        b=5W7SEFXUw6PNxrAXqi0ncsTH0FzFFYHStI+dwhrp0hF7U6GJFbv/sx3XO72IuBcV+F
         W9J+YYs/DLYjU6qP0rVKlFL4mk/jrQ4jfITtCJEm5HndT6slVEo64n64mX40Lr0F5jfc
         1QMKRxmC5RfbskkX2EgJaswtYkp8m/E3HG0Tv9N5rz0ytd5+9bDtotoj07hPPJAs80Me
         TtoOmnsAXwD34zxpMJu1gHKmF4bheYT5h3p5Qddrdk0UiE/7qaZ7hNRgP1AIVvH24qqF
         UCf3j8vqEpCFAmVeKl3Iw4i/5q9pJjAtRIprUh6/1rsxucu80pPFFznY6rCMiY64gOJE
         NndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HO69GAZWB5ZNDpZdF5+7qBeyAdQ2ziZHjagMLd+xkN0=;
        b=BOGuDHGsPj1YR4Rg+B4w0UXoGhiPKlX7o/5QQCuckqlQzU+wUBYYMhTyrP8KuZ/Q8S
         XxEPAWWrEmyYlwlXSBzrD9dRPxWgxgwzTM+b0//dN0BqgS86Gpru20M0ERZLw4V/k2ej
         tE3glFYohwzki7TrEU5ctmyVRfOnaQqSLevQOiRi38fBs7ofhefmarju8F7mbhzKtc3u
         4lbDb/+o/D9IHoF6AhV6tCUcEK8fGxwp7u/ZjbdkySRV9bZkj6ii5rifNPPJFowL4EAH
         84l/HBr0h8E2EkGiTfvF8TwaNn4xJN+zfmbB4W6l4bjJYDFAYamjXEVSnXf9qWDswiQ3
         m13A==
X-Gm-Message-State: AOAM532GnKpsKAvlKoK2zsTFqcNj6nRB2OVBlr+/vP5iQMHY23lxWrRJ
        A5ZOD13L/17kUcWR0OHEe8fZJg==
X-Google-Smtp-Source: ABdhPJzevvqFTCD5Jevk1/UP1ZG0Oy84NOUFU4sf4OZmyEtUbtFDT3W/k1LXxyGdV2+eTrx+h/Vdnw==
X-Received: by 2002:a05:620a:40d4:b0:69f:60ac:b958 with SMTP id g20-20020a05620a40d400b0069f60acb958mr9579444qko.609.1651094465863;
        Wed, 27 Apr 2022 14:21:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id s12-20020ac85ecc000000b002f3874bfecbsm574562qtx.5.2022.04.27.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:21:05 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:20:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YmmznQ8AO5RLxicA@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymmnrkn0mSWcuvmH@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> Hi Johannes,
> 
> On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > Currently it requires poking at debugfs to figure out the size and
> > population of the zswap cache on a host. There are no counters for
> > reads and writes against the cache. As a result, it's difficult to
> > understand zswap behavior on production systems.
> > 
> > Print zswap memory consumption and how many pages are zswapped out in
> > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  fs/proc/meminfo.c             |  7 +++++++
> >  include/linux/swap.h          |  5 +++++
> >  include/linux/vm_event_item.h |  4 ++++
> >  mm/vmstat.c                   |  4 ++++
> >  mm/zswap.c                    | 13 ++++++-------
> >  5 files changed, 26 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index 6fa761c9cc78..6e89f0e2fd20 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  
> >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > +#ifdef CONFIG_ZSWAP
> > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > +		   (PAGE_SHIFT - 10));
> > +#endif
> 
> I agree it would be very handy to have the memory consumption in meminfo
> 
> https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> 
> If we really go this Zswap only metric instead of general term
> "Compressed", I'd like to post maybe "Zram:" with same reason
> in this patchset. Do you think that's better idea instead of
> introducing general term like "Compressed:" or something else?

I'm fine with changing it to Compressed. If somebody cares about a
more detailed breakdown, we can add Zswap, Zram subsets as needed.

From 8e9e2d6490b7082c41743fbdb9ffd2db4e3ce962 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 27 Apr 2022 17:15:15 -0400
Subject: [PATCH] mm: zswap: add basic meminfo and vmstat coverage fix fix

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/filesystems/proc.rst | 7 ++++---
 fs/proc/meminfo.c                  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8b5a94cfa722..93edcf233464 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -964,7 +964,7 @@ Example output. You may not have all of these fields.
     Mlocked:               0 kB
     SwapTotal:             0 kB
     SwapFree:              0 kB
-    Zswap:              1904 kB
+    Compressed:         1904 kB
     Zswapped:           7792 kB
     Dirty:                12 kB
     Writeback:             0 kB
@@ -1057,8 +1057,9 @@ SwapTotal
 SwapFree
               Memory which has been evicted from RAM, and is temporarily
               on the disk
-Zswap
-              Memory consumed by the zswap backend (compressed size)
+Compressed
+              Memory consumed by compression backends, such as zswap
+              (compressed size)
 Zswapped
               Amount of anonymous memory stored in zswap (original size)
 Dirty
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6e89f0e2fd20..554d6f230e67 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -87,7 +87,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SwapTotal:      ", i.totalswap);
 	show_val_kb(m, "SwapFree:       ", i.freeswap);
 #ifdef CONFIG_ZSWAP
-	seq_printf(m,  "Zswap:          %8lu kB\n",
+	seq_printf(m,  "Compressed:     %8lu kB\n",
 		   (unsigned long)(zswap_pool_total_size >> 10));
 	seq_printf(m,  "Zswapped:       %8lu kB\n",
 		   (unsigned long)atomic_read(&zswap_stored_pages) <<
-- 
2.35.3
