Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099805EFFFF
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiI2WUM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Sep 2022 18:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiI2WUL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Sep 2022 18:20:11 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 887EC5B7A2;
        Thu, 29 Sep 2022 15:20:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9A6E11101ADC;
        Fri, 30 Sep 2022 08:20:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oe1t0-00Ditm-VV; Fri, 30 Sep 2022 08:20:06 +1000
Date:   Fri, 30 Sep 2022 08:20:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     cgroups@vger.kernel.org
Cc:     linux-mm@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] memcg: calling reclaim_high(GFP_KERNEL) in GFP_NOFS
 context deadlocks
Message-ID: <20220929222006.GI3600936@dread.disaster.area>
References: <20220929215440.1967887-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929215440.1967887-1-david@fromorbit.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=63361a18
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=J_z8GOLKSbhpeTq1fcMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 30, 2022 at 07:54:40AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> This should be more obvious, but gfpflags_allow_blocking() is not
> the same thing as a GFP_KERNEL reclaim contexts. The former checks
> GFP_DIRECT_RECLAIM which tells us if direct reclaim is allowed. The
> latter (GFP_KERNEL) allows blocking on anything, including
> filesystem and IO structures during reclaim.
> 
> However, we do lots of memory allocation from various filesystems we
> are under GFP_NOFS contexts, including page cache folios. Hence if
> direct reclaim in GFP_NOFS context waits on filesystem progress
> (e.g. waits on folio writeback) then memory reclaim can deadlock.
> 
> e.g. page cache allocation (which is GFP_NOFS context) gets stuck
> waiting on page writeback like so:
> 
> [   75.943494] task:test_write      state:D stack:12560 pid: 3728 ppid:  3613 flags:0x00004002
> [   75.944788] Call Trace:
> [   75.945183]  <TASK>
> [   75.945543]  __schedule+0x2f9/0xa30
> [   75.946118]  ? __mod_memcg_lruvec_state+0x41/0x90
> [   75.946895]  schedule+0x5a/0xc0
> [   75.947397]  io_schedule+0x42/0x70
> [   75.947992]  folio_wait_bit_common+0x159/0x3d0
> [   75.948732]  ? dio_warn_stale_pagecache.part.0+0x50/0x50
> [   75.949505]  folio_wait_writeback+0x28/0x80
> [   75.950163]  shrink_page_list+0x96e/0xc30
> [   75.950843]  shrink_lruvec+0x558/0xb80
> [   75.951440]  shrink_node+0x2c6/0x700
> [   75.952059]  do_try_to_free_pages+0xd5/0x570
> [   75.952771]  try_to_free_mem_cgroup_pages+0x105/0x220
> [   75.953548]  reclaim_high.constprop.0+0xa3/0xf0
> [   75.954209]  mem_cgroup_handle_over_high+0x8f/0x280
> [   75.955025]  ? kmem_cache_alloc_lru+0x1c6/0x3f0
> [   75.955781]  try_charge_memcg+0x6c3/0x820
> [   75.956436]  ? __mem_cgroup_threshold+0x16/0x150
> [   75.957204]  charge_memcg+0x76/0xf0
> [   75.957810]  __mem_cgroup_charge+0x29/0x80
> [   75.958464]  __filemap_add_folio+0x225/0x590
> [   75.959112]  ? scan_shadow_nodes+0x30/0x30
> [   75.959794]  filemap_add_folio+0x37/0xa0
> [   75.960432]  __filemap_get_folio+0x1fd/0x340
> [   75.961141]  ? xas_load+0x5/0xa0
> [   75.961712]  iomap_write_begin+0x103/0x6a0
> [   75.962390]  ? filemap_dirty_folio+0x5c/0x80
> [   75.963106]  ? iomap_write_end+0xa2/0x2b0
> [   75.963744]  iomap_file_buffered_write+0x17c/0x380
> [   75.964546]  xfs_file_buffered_write+0xb1/0x2e0
> [   75.965286]  ? xfs_file_buffered_write+0x2b2/0x2e0
> [   75.966097]  vfs_write+0x2ca/0x3d0
> [   75.966702]  __x64_sys_pwrite64+0x8c/0xc0
> [   75.967349]  do_syscall_64+0x35/0x80
> 
> At this point, the system has 58 pending XFS IO completions that are
> stuck waiting for workqueue progress:
> 
> [ 1664.460579] workqueue xfs-conv/dm-0: flags=0x4c
> [ 1664.461332]   pwq 48: cpus=24 node=3 flags=0x0 nice=0 active=58/256 refcnt=59
> [ 1664.461335]     pending: xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io, xfs_end_io
> 
> and nothing is making progress. The reason progress is not being
> made is not clear from what I can gather from the steaming corpse,
> but it is clear that the memcg reclaim code should not be blocking
> on filesystem related objects in GFP_NOFS allocation contexts.
> 
> We have the reclaim context parameters right there when we call
> mem_cgroup_handle_over_high(), so pass them down the stack so memcg
> reclaim doesn't cause deadlocks. This makes the reclaim deadlocks in
> the test I've been running go away.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

FWIW:

Fixes: b3ff92916af3 ("mm, memcg: reclaim more aggressively before high allocator throttling")

-Dave.
-- 
Dave Chinner
david@fromorbit.com
