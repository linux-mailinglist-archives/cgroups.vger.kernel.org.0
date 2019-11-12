Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6AF9876
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 19:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLSUU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 13:20:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37018 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfKLSUU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 13:20:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id g50so20789160qtb.4
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 10:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8YEl8DjjpzVT+jv1JTvmwB07dFEMqomlwwTe3310pY=;
        b=KGZv5hfKhSeMlIk3qURodC/bAqExsgUF/6lSCR5KsnlI2hk1Vvt1Ez2XgZxpFXA6M5
         8NVnX35tumAMf8vnwXOFXvzbSO92tizrnnR0oG2BuR4cvUtk5ck7y7zDzOFViLG0BLii
         LlqvsQXofXqmA6yYdPv+ou1g+Dj4+W+uI7q/VBfOGf1zGxNnhbdp7/C+cgP1Pchyt/Fa
         nm4DL5uBVj/MkkJRMhVmzu8uNlKaGah+hX5o7Ukk+f2wXdl67Dpk/sfK9/hOPNH1GcT5
         IyMHcklOBzKmgmgdX/rKt3LxiEfgOiElsQ7rJpf5BAx81/PxDpbMsgGNxbZOrH/gntTJ
         PSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8YEl8DjjpzVT+jv1JTvmwB07dFEMqomlwwTe3310pY=;
        b=tqp4dGwFf1tR58GW8Uqoffc/MQ3gFWSlRMoEpSyhJqlrzDr2tQrMo/8rdD5QqeZ83U
         G9zlKs7oJdRX+P5vIJP3OqODBEZRagZ+PpHfC+koycfsfAe+0ryJ7gzWdfogXZ11KgOj
         u0ht0jKiAFLCbgQfuHO4pdE0sgmqzLkdLOm/ktg+ip2jRQYQ8V8dcxC9rGrKDzSofQHk
         NnEeq2jtHFgYTflV/HDy1brG4tmu8Avo/bILvXV7+EnxBpWBvgxJ+a8U1x1N0E/v55yL
         YbhpAaxlfQRhw67YNvplKHFyy3DvGUg6VRuQOXjhRXxcOFMkVTeFQOJfIWP5YLIO7KWt
         quDQ==
X-Gm-Message-State: APjAAAXjJFCpsdGTrqx4+hNILEXrpqaKGZ0gOQz9xZ8doc+BgHaF+MDM
        ITQJ780UzX/ta+sAr4NKoU0BoQ==
X-Google-Smtp-Source: APXvYqxAJw9irKY7g9DkVQFTpe5A8l1M8lvcepZNDcLVyN+F4gO+m+2TgrsjbM1/Sy4V/K2ycaqo5w==
X-Received: by 2002:aed:24c1:: with SMTP id u1mr33987362qtc.29.1573582818867;
        Tue, 12 Nov 2019 10:20:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id k27sm8179165qkj.30.2019.11.12.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:20:18 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:20:17 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, guro@fb.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191112182017.GB179587@cmpxchg.org>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
 <20191111130516.GA891635@chrisdown.name>
 <20191111131427.GB891635@chrisdown.name>
 <20191111132812.GK1396@dhcp22.suse.cz>
 <20191112145942.GA168812@cmpxchg.org>
 <20191112152750.GA512@dhcp22.suse.cz>
 <20191112161658.GF168812@cmpxchg.org>
 <20191112163156.GB512@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112163156.GB512@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 05:31:56PM +0100, Michal Hocko wrote:
> On Tue 12-11-19 11:16:58, Johannes Weiner wrote:
> > On Tue, Nov 12, 2019 at 04:27:50PM +0100, Michal Hocko wrote:
> > > lruvec_lru_size is explicitly documented to use MAX_NR_ZONES for all
> > > LRUs and git grep says there are more instances outside of
> > > get_scan_count. So all of them have to be fixed.
> > 
> > Which ones?
> > 
> > [hannes@computer linux]$ git grep lruvec_lru_size
> > include/linux/mmzone.h:extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
> > mm/vmscan.c: * lruvec_lru_size -  Returns the number of pages on the given LRU list.
> > mm/vmscan.c:unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
> > mm/vmscan.c:    anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES - 1) +
> > mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES - 1);
> > mm/vmscan.c:    file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES - 1) +
> > mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES - 1);
> > mm/vmscan.c:            lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> > [hannes@computer linux]$
> 
> I have checked the Linus tree but now double checked with the current
> next
> $ git describe next/master
> next-20191112
> $ git grep "lruvec_lru_size.*MAX_NR_ZONES" next/master
> next/master:mm/vmscan.c:                        lruvec_lru_size(lruvec, inactive_lru, MAX_NR_ZONES), inactive,
> next/master:mm/vmscan.c:                        lruvec_lru_size(lruvec, active_lru, MAX_NR_ZONES), active,
> next/master:mm/vmscan.c:        anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
> next/master:mm/vmscan.c:                lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES);
> next/master:mm/vmscan.c:        file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
> next/master:mm/vmscan.c:                lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
> next/master:mm/workingset.c:    active_file = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
> 
> are there any changes which didn't make it to linux next yet?

Aaahh, that makes sense. I was looking at the latest mmots which
has

- mm: vmscan: detect file thrashing at the reclaim root
- mm: vmscan: enforce inactive:active ratio at the reclaim root

Those replace the inactive_is_low and the workingset callsites with
the recursive lruvec_page_state(). It looks like that isn't in next -
and while I hope it'll make it into 5.5, it might not. So we need a
fix that considers the other callsites as well.

Qian's patches that Andrew already has will be good then, as it
reduces the churn to those other callsites that are in flux.

We can clean things up when the dust settles.
