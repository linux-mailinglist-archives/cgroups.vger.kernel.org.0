Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB403B9DE5
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhGBJKx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 05:10:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhGBJKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 05:10:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4BD262006A;
        Fri,  2 Jul 2021 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625216900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vy9xdj2QLgIqzr/TgmLE77gLmPWcB0CW7T+Mjh40YGc=;
        b=VAQaWwdMVj2o9m81fAuHALE0jIVcwnGjxshViGXKd+wsXn5bTqSdtgFdYG0DDnSmGtE7+u
        F2s+VgUPZyf2Z8NN1XmybNZgSe0FhTv33uGZZmMsU9Su142BWJIF/s+7Rv6CcvLZVnpuj7
        t78uAO9mWgSCzrZheK9G9KPILW5elK4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07E27A3B83;
        Fri,  2 Jul 2021 09:08:19 +0000 (UTC)
Date:   Fri, 2 Jul 2021 11:08:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: Process memory accounting (cgroups) accuracy
Message-ID: <YN7XgzB4bE2K9int@dhcp22.suse.cz>
References: <69ffd3a0-2cb7-8baa-17d0-ae45a52595af@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ffd3a0-2cb7-8baa-17d0-ae45a52595af@canonical.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 02-07-21 09:50:11, Krzysztof Kozlowski wrote:
[...]
> The questions: How accurate are now the cgroup counters?

The precision depends on the number of CPUs the workload is running on
as we do a per-cpu charge caching to optimize the accounting. This is
MEMCG_CHARGE_BATCH (32) pages currently. You can learn more by checking
try_charge function (mm/memcontrol.c).

> I understood they should charge only pages allocated by the process, so
> why mmap(4 kB) causes max_usage_in_bytes=132 kB?

Please note that kernel allocations (marked by __GFP_ACCOUNT) are
accounted as well so this is not only about mmaped memory.

> Why mmap(4 MB) causes max_usage_in_bytes=4 MB + 34 pages?

The specific number will depend on the executing - e.g. use up all but 3
pages from CPU0 batch and have 31 pages on another cpu.

> What is being accounted there (stack guards?)?
> 
> Or maybe the entire LTP test checking so carefully memcg limits is useless?

Well, I haven't really checked details of those tests and their
objective but aiming for an absolute precision is not really something
that is very useful IMHO. We are very likely to do optimizations like
the one mentioned above as the runtime tends to be much more important
than to-the-page precision.

Hope this clarifies this a bit.
-- 
Michal Hocko
SUSE Labs
