Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60B1D1157
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgEMLaj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgEMLaj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 07:30:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45019C061A0C;
        Wed, 13 May 2020 04:30:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b8so6698784plm.11;
        Wed, 13 May 2020 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Ktd5bounBb85k+GhDJYQBKwGNjtE8xOQJSWOO0qVps=;
        b=hfgNGCstCMJHb8IVTFUEeL+3JGilD81+7rwOcqzOpwjQoMrYv2Z5LeMUCzJ8pzCf9p
         8oqSZVzVevLUBq3aqDYXpA5ZPorxTlk4GyVcCXcXtDCgg7rf32OqplGewGX/Tq71KaH0
         6x4rjEaB8R/x8vYndWFQEzIeiZi6qCG+t/GUzp8QQzYxcta8Da+BQ1XqadEpTVA62rkk
         zElKLJwK03h9CYhA0lS21Apb7+3W2n0SDgmVpoyRqDKhiNiSbPAdNABETh7/377aNjfT
         BOlkWnf4jhBvUOSUv52te1U6tfHKfFNhSm+45+yDmrE3aEbTj6mQI4lzTBQIqGH/hj/R
         mnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Ktd5bounBb85k+GhDJYQBKwGNjtE8xOQJSWOO0qVps=;
        b=I1+vCEVO5Pg5hAEqN8bnRYeCRrROiGneYFgDRP54vRPD4uVRFepSZGlJPh3sYBqCYW
         cU39QdvFoTnVVW1q1585a4Em9s1Yt0a+LDvVvpdenFj0DAb+1CaXF6qWyKhtGPMbYips
         3vdNl9hcNyP8udR99qswGf60SPllojWtJkysvD9zRJrZrJYH6ayzSjnA9NYambXina7B
         NkvQ8j0f9Zy+t9xOYmsaianZVrvNS5eXmU71FSeshG7zziYPNkzhTIQV0TiFZRzJGnBU
         4id4KtBp551TPEC1kUeVo7CZh48Vc8eEMVNhUcIUkgy1brarLNu9Xvmhofh97tR2wXnO
         xbQQ==
X-Gm-Message-State: AOAM533pPboNTe/oDuyY30IXOo2h06GKe53AKXaI2Sra31KZIUaoxkfE
        pTpSKTTo2FaAQRm7w68c8jo=
X-Google-Smtp-Source: ABdhPJwyEeANLs5At6bpev/PUGNX/0KyW6asJ6F8bCCh8n5pcpj+q8jCPczezPPMJcLx7U8T8U5KPA==
X-Received: by 2002:a17:90b:608:: with SMTP id gb8mr11211316pjb.178.1589369437653;
        Wed, 13 May 2020 04:30:37 -0700 (PDT)
Received: from dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com ([27.0.3.145])
        by smtp.gmail.com with ESMTPSA id h14sm14406751pfq.46.2020.05.13.04.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 04:30:36 -0700 (PDT)
From:   Balbir Singh <bsingharora@gmail.com>
X-Google-Original-From: Balbir Singh <sblbir@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
Date:   Wed, 13 May 2020 11:30:32 +0000
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/19 V2] mm: memcontrol: charge swapin pages on
 instantiation
Message-ID: <20200513113032.GA93568@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 08, 2020 at 02:30:47PM -0400, Johannes Weiner wrote:
> This patch series reworks memcg to charge swapin pages directly at
> swapin time, rather than at fault time, which may be much later, or
> not happen at all.
> 
> Changes in version 2:
> - prevent double charges on pre-allocated hugepages in khugepaged
> - leave shmem swapcache when charging fails to avoid double IO (Joonsoo)
> - fix temporary accounting bug by switching rmap<->commit (Joonsoo)
> - fix double swap charge bug in cgroup1/cgroup2 code gating
> - simplify swapin error checking (Joonsoo)
> - mm: memcontrol: document the new swap control behavior (Alex)
> - review tags
> 
> The delayed swapin charging scheme we have right now causes problems:
> 
> - Alex's per-cgroup lru_lock patches rely on pages that have been
>   isolated from the LRU to have a stable page->mem_cgroup; otherwise
>   the lock may change underneath him. Swapcache pages are charged only
>   after they are added to the LRU, and charging doesn't follow the LRU
>   isolation protocol.
> 
> - Joonsoo's anon workingset patches need a suitable LRU at the time
>   the page enters the swap cache and displaces the non-resident
>   info. But the correct LRU is only available after charging.
> 
> - It's a containment hole / DoS vector. Users can trigger arbitrarily
>   large swap readahead using MADV_WILLNEED. The memory is never
>   charged unless somebody actually touches it.
> 
> - It complicates the page->mem_cgroup stabilization rules
> 
> In order to charge pages directly at swapin time, the memcg code base
> needs to be prepared, and several overdue cleanups become a necessity:
> 
> To charge pages at swapin time, we need to always have cgroup
> ownership tracking of swap records. We also cannot rely on
> page->mapping to tell apart page types at charge time, because that's
> only set up during a page fault.
> 
> To eliminate the page->mapping dependency, memcg needs to ditch its
> private page type counters (MEMCG_CACHE, MEMCG_RSS, NR_SHMEM) in favor
> of the generic vmstat counters and accounting sites, such as
> NR_FILE_PAGES, NR_ANON_MAPPED etc.

Could you elaborate on what this means and the implications of this on
user space programs?

> 
> To switch to generic vmstat counters, the charge sequence must be
> adjusted such that page->mem_cgroup is set up by the time these
> counters are modified.
> 
> The series is structured as follows:
> 
> 1. Bug fixes
> 2. Decoupling charging from rmap
> 3. Swap controller integration into memcg
> 4. Direct swapin charging
>

Thanks,
Balbir Singh. 
