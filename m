Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787F59EC5E
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2019 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfH0PXN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Aug 2019 11:23:13 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:35954 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfH0PXM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Aug 2019 11:23:12 -0400
Received: by mail-io1-f49.google.com with SMTP id o9so47191313iom.3
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2019 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EialagdAgnBtYjzH6H0eO9CyoHJZ48U2U5aIVIJeUoo=;
        b=figx/Q98kEpCBkqo3lxQ6atjRtKnOZ/vizqGhR6ya8V3vn3+aFl2oTLswEK1VjnEMg
         An75CIk3RkB52JqKH80uhifoZiBjBgP+rPZNgE/8ipmRd77Ok9Xb6Y+4IeWDeVn8lmKd
         ySMOZk1uc2qMWNtBcJuL843WNs9SFPe/F1JQBw+7MCJe3UdkDKvttcuwKgwAi9oppUSI
         vRtaD9Uy56A0NEqyv6qNzLxcz1F6B3uV/Dp3f7ve6N1FqXtz+1EzyKNRy7GFif41nKI3
         nQoC9QQViIIaBRegMiHx06KhObDFDXWzNvmgR56X0UTpzB2kBNE2KFkzbQ9//Alh90Yc
         O4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EialagdAgnBtYjzH6H0eO9CyoHJZ48U2U5aIVIJeUoo=;
        b=fF8XzcO7uKyU3vh8fYzdO6jtt3gld19hKhyfV9oh6PSQpAMg+QPVBs94h80PFYXPK7
         9J/FFeC8L8+d3mHsUbD/hpWzIu9ZyRp/56IINLOn+B3ZyVLETxuNFuQbkniRqo//eYvY
         VGrVBbdS4ngVuUwNOF4g1FyIwF3rug8GMSVFaqTEiR251M2iKPAZuXZ+apD3AcWsDWTe
         +doGtOUfWNQh6B28WgU/J4/fY6XZ/DJ6NZA9VJpYaVCIf6xBb4MiZkbMIyeif+KbhQJK
         zRH2BL3853f1qCtr+WzwUBRHAPqaSngMfhNbZ+UcQJkks3ghKz2f/bJdjRHNxiwja8ZS
         BePA==
X-Gm-Message-State: APjAAAWmqO/yhT8tzwfXIH4wxQAzx9C8pDuMJ+7lH9OMcVeV8Gf1o3Ky
        ol1ue3SRNIJx37TmyXAXWiP8/Q==
X-Google-Smtp-Source: APXvYqzTjEDUFcepnEf1WEiRSh5mor0Y5ZzBDG+MemPieFRR8sXBVkJz4+O2iILrDrCaJ4x8THmZFQ==
X-Received: by 2002:a6b:3943:: with SMTP id g64mr24044809ioa.225.1566919391746;
        Tue, 27 Aug 2019 08:23:11 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u24sm13275659iot.38.2019.08.27.08.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:23:10 -0700 (PDT)
Subject: Re: [PATCHSET v3] writeback, memcg: Implement foreign inode flushing
To:     Tejun Heo <tj@kernel.org>, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
References: <20190826160656.870307-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15a5a6e8-90bf-726b-f68c-db91f1afc651@kernel.dk>
Date:   Tue, 27 Aug 2019 09:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826160656.870307-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/26/19 10:06 AM, Tejun Heo wrote:
> Hello,
> 
> Changes from v1[1]:
> 
> * More comments explaining the parameters.
> 
> * 0003-writeback-Separate-out-wb_get_lookup-from-wb_get_create.patch
>    added and avoid spuriously creating missing wbs for foreign
>    flushing.
> 
> Changes from v2[2]:
> 
> * Added livelock avoidance and applied other smaller changes suggested
>    by Jan.
> 
> There's an inherent mismatch between memcg and writeback.  The former
> trackes ownership per-page while the latter per-inode.  This was a
> deliberate design decision because honoring per-page ownership in the
> writeback path is complicated, may lead to higher CPU and IO overheads
> and deemed unnecessary given that write-sharing an inode across
> different cgroups isn't a common use-case.
> 
> Combined with inode majority-writer ownership switching, this works
> well enough in most cases but there are some pathological cases.  For
> example, let's say there are two cgroups A and B which keep writing to
> different but confined parts of the same inode.  B owns the inode and
> A's memory is limited far below B's.  A's dirty ratio can rise enough
> to trigger balance_dirty_pages() sleeps but B's can be low enough to
> avoid triggering background writeback.  A will be slowed down without
> a way to make writeback of the dirty pages happen.
> 
> This patchset implements foreign dirty recording and foreign mechanism
> so that when a memcg encounters a condition as above it can trigger
> flushes on bdi_writebacks which can clean its pages.  Please see the
> last patch for more details.
> 
> This patchset contains the following four patches.
> 
>   0001-writeback-Generalize-and-expose-wb_completion.patch
>   0002-bdi-Add-bdi-id.patch
>   0003-writeback-Separate-out-wb_get_lookup-from-wb_get_create.patch
>   0004-writeback-memcg-Implement-cgroup_writeback_by_id.patch
>   0005-writeback-memcg-Implement-foreign-dirty-flushing.patch
> 
> 0001-0004 are prep patches which expose wb_completion and implement
> bdi->id and flushing by bdi and memcg IDs.
> 
> 0005 implements foreign inode flushing.
> 
> Thanks.  diffstat follows.
> 
>   fs/fs-writeback.c                |  130 ++++++++++++++++++++++++++++---------
>   include/linux/backing-dev-defs.h |   23 ++++++
>   include/linux/backing-dev.h      |    5 +
>   include/linux/memcontrol.h       |   39 +++++++++++
>   include/linux/writeback.h        |    2
>   mm/backing-dev.c                 |  120 +++++++++++++++++++++++++++++-----
>   mm/memcontrol.c                  |  134 +++++++++++++++++++++++++++++++++++++++
>   mm/page-writeback.c              |    4 +
>   8 files changed, 404 insertions(+), 53 deletions(-)

Applied for 5.4, thanks Tejun.

-- 
Jens Axboe

