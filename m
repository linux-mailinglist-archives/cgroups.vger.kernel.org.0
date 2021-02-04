Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD330FCD1
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 20:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhBDTap (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 14:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbhBDTak (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 14:30:40 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5DC061786
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 11:29:59 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c1so3307124qtc.1
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 11:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pxEH3lPVvNUUdUP05ZPOl2OQ8LUijQb0MCrSWBXGG1I=;
        b=avFnTqyzD1lpktS9bgh7ccT5o3JRmPhvL3P/+Rzvtn4OvxFpTV7zxaoJO0kCJ4iVHb
         xUqJgv/Re97obtqWTQQsdPQ//rV2bSEcTqkAbkpGABW2h2z02WGuBRIRJ8nfipeBbK6L
         hRybH6mwFcUaSkUpiAu4YDDK/fmqYz2oVMwmXgwexb0x6+YoIf/h5gabNV3X50431Md8
         QGBrSXWq/n3Xz8F5Q+XF+Sg32MgsX3EXrGPMUX6RUOv/t9InDPlr/qvtfobNspqKEDqj
         hPf4NcugQRHsrEnIQXjVacillW1TmexsR9w1vUrPbVszAlHh+1zvegmvVQuGMVrJeOX9
         gxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pxEH3lPVvNUUdUP05ZPOl2OQ8LUijQb0MCrSWBXGG1I=;
        b=b2Co3kYsOFeTHXeAOGIX8O51x9B8HNBd0BsZZubNzrfUDkVIBbAvXf5Xipi0L+TDQC
         afLh0flvZWSAUfRY6ojpX+HoAUHRgcCjAKC7F2oT+zNoLElheEi+xyBIfKZG7jKTCZ2P
         tz9qoVR1od2sCr/2V9i8X/4iJLOYtrXl/OrpmTZebV1EVWI18xCYWh7I9z71mn9s2trn
         iWo/6SDe//XDqA8tfctqDUFUcCJwBOf6Wdp2xrQAN8SPXXnS0uisei66NSIYgVTso1y6
         C+DTeH3JQIIf1ZDWWVjqGF4DEguGdyuZuovi6qlpPQvaVFgeopL+CfLYC0v1mJ3YQCKl
         chrQ==
X-Gm-Message-State: AOAM530JuoXFPwPh1YiwSUuIf2i52hBg6t2jLmqsBeWloYVWABg/wwsh
        nJoeO//+or4AC02jN78uDOQGaQ==
X-Google-Smtp-Source: ABdhPJz2RQx7/sc+iaLvhakoRLJxsdTzKIgiu31ziLgJIIup/Jpig7TrILtyJyDRlpAa5rzhhSwQ8w==
X-Received: by 2002:ac8:5a01:: with SMTP id n1mr1094177qta.107.1612466999188;
        Thu, 04 Feb 2021 11:29:59 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z23sm2040630qkb.13.2021.02.04.11.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:29:58 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:29:57 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <YBxLNZJ/83P7H8+H@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-2-hannes@cmpxchg.org>
 <20210202230747.GA1812008@carbon.dhcp.thefacebook.com>
 <20210203022853.GG1812008@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203022853.GG1812008@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 06:28:53PM -0800, Roman Gushchin wrote:
> On Tue, Feb 02, 2021 at 03:07:47PM -0800, Roman Gushchin wrote:
> > On Tue, Feb 02, 2021 at 01:47:40PM -0500, Johannes Weiner wrote:
> > > The memcg hotunplug callback erroneously flushes counts on the local
> > > CPU, not the counts of the CPU going away; those counts will be lost.
> > > 
> > > Flush the CPU that is actually going away.
> > > 
> > > Also simplify the code a bit by using mod_memcg_state() and
> > > count_memcg_events() instead of open-coding the upward flush - this is
> > > comparable to how vmstat.c handles hotunplug flushing.
> > 
> > To the whole series: it's really nice to have an accurate stats at
> > non-leaf levels. Just as an illustration: if there are 32 CPUs and
> > 1000 sub-cgroups (which is an absolutely realistic number, because
> > often there are many dying generations of each cgroup), the error
> > margin is 3.9GB. It makes all numbers pretty much random and all
> > possible tests extremely flaky.
> 
> Btw, I was just looking into kmem kselftests failures/flakiness,
> which is caused by exactly this problem: without waiting for the
> finish of dying cgroups reclaim, we can't make any reliable assumptions
> about what to expect from memcg stats.

Good point about the selftests. I gave them a shot, and indeed this
series makes test_kmem work again:

vanilla:
ok 1 test_kmem_basic
memory.current = 8810496
slab + anon + file + kernel_stack = 17074568
slab = 6101384
anon = 946176
file = 0
kernel_stack = 10027008
not ok 2 test_kmem_memcg_deletion
ok 3 test_kmem_proc_kpagecgroup
ok 4 test_kmem_kernel_stacks
ok 5 test_kmem_dead_cgroups
ok 6 test_percpu_basic

patched:
ok 1 test_kmem_basic
ok 2 test_kmem_memcg_deletion
ok 3 test_kmem_proc_kpagecgroup
ok 4 test_kmem_kernel_stacks
ok 5 test_kmem_dead_cgroups
ok 6 test_percpu_basic

It even passes with a reduced margin in the patched kernel, since the
percpu drift - which this test already tried to account for - is now
only on the page_counter side (whereas memory.stat is always precise).

I'm going to include that data in the v2 changelog, as well as a patch
to update test_kmem.c to the more stringent error tolerances.

> So looking forward to have this patchset merged!

Thanks
