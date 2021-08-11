Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821B3E97EB
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhHKSst (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhHKSst (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 14:48:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ED2C0613D3
        for <cgroups@vger.kernel.org>; Wed, 11 Aug 2021 11:48:25 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id dk2so1700308qvb.3
        for <cgroups@vger.kernel.org>; Wed, 11 Aug 2021 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXzKXvFp1VaOu436UKEuohFjo8wrYLVba4+cewsAvpA=;
        b=u100rSlqWXrGMEJnMlU3PRU56IUsCPjCokscAfgDNwK+higO44digKOiRDj5BQSPpM
         ZS58RGwL7C8iNB60vAmnsqFazlSEsmtXaQOBkf+X74GwqjHkEbSNLAWQsAcs5V5kRRqI
         JUid3RalT/VT5LESVj2bhx3WcKdSyKkKPt4UKRPSqi8r8ju/snUnvUjNtIQfCg0uhTMp
         TCXMz0SZZynSwM7sKSGAfkAOZqT/FUwkuG5zT4IaShb7FRMwq2tts3yTsBsu+zx0T6q3
         XXZycBqy9JAk5jNE2JK+C5crsaJP4+nxLDWo32qzl2i7pk7LsFUOet4dY9Z6jjSBUYm+
         u0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXzKXvFp1VaOu436UKEuohFjo8wrYLVba4+cewsAvpA=;
        b=b+qUt8ub8GM7v6nEZuxj9a7BA7B+xWmSlg1cq8cdwaSW/aAJpezCsg1spQxJbFJWma
         YTIM68YwBrwI7quM3N8z+4T0mzjGLfCC1XWlKfKjFQN8K19g7ajIitxG1X4UMMEKoRfL
         LGnRMKOm+wLVEW3qj1Qa4TKbGi7Hx/JIFAl+mxENFnANeQdGmMwc778hBOV1WEC1N/ae
         pT7RBrWeLl5I988av3VqfVVGM8nOg6OuP0nR9JTGaPAwY+pSQpd1lYztlCtbEL3VlHLS
         0LSPOUB9M7TeclT63ZBy8HACAscz6RxWMY9FNyM7zh7foOpq8jCFs1h9wa74BCI0LUd5
         oKTQ==
X-Gm-Message-State: AOAM530ohBVQGRq7k05YWQ+I4noKmqEO0rJOctwKa+2y3XiiBdugkPMn
        31lfGB/++EJF31A8421UOki7SA==
X-Google-Smtp-Source: ABdhPJyWn4X+uyzoMtbmfnwzp3LCwRx5aYuUQZj4R2Ml+aXeDMIkWiyWJn4gv55p1ioBHtAUt/EsXw==
X-Received: by 2002:a0c:e84a:: with SMTP id l10mr55172qvo.3.1628707704201;
        Wed, 11 Aug 2021 11:48:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d9fa])
        by smtp.gmail.com with ESMTPSA id u3sm8098767qke.95.2021.08.11.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:48:23 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:48:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Enable memory migration for cpuset v2
Message-ID: <YRQbdTgprUJyuis7@cmpxchg.org>
References: <20210811163035.1977-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811163035.1977-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 11, 2021 at 12:30:35PM -0400, Waiman Long wrote:
> When a user changes cpuset.cpus, each task in a v2 cpuset will be moved
> to one of the new cpus if it is not there already. For memory, however,
> they won't be migrated to the new nodes when cpuset.mems changes. This is
> an inconsistency in behavior.
> 
> In cpuset v1, there is a memory_migrate control file to enable such
> behavior by setting the CS_MEMORY_MIGRATE flag. Make it the default
> for cpuset v2 so that we have a consistent set of behavior for both
> cpus and memory.
> 
> There is certainly a cost to make memory migration the default, but it
> is a one time cost that shouldn't really matter as long as cpuset.mems
> isn't changed frequenty.  Update the cgroup-v2.rst file to document the
> new behavior and recommend against changing cpuset.mems frequently.
> 
> Since there won't be any concurrent access to the newly allocated cpuset
> structure in cpuset_css_alloc(), we can use the cheaper non-atomic
> __set_bit() instead of the more expensive atomic set_bit().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  kernel/cgroup/cpuset.c                  | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5c7377b5bd3e..47c832ad1322 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2056,6 +2056,12 @@ Cpuset Interface Files
>  	The value of "cpuset.mems" stays constant until the next update
>  	and won't be affected by any memory nodes hotplug events.
>  
> +	Setting a non-empty value to "cpuset.mems" causes memory of
> +	tasks within the cgroup to be migrated to the designated nodes if
> +	they are currently using memory outside of the designated nodes.
> +	There is a cost for this migration.  So "cpuset.mems" shouldn't
> +	be changed frequently.

The migration skips over pages that are (temporarily) off the LRU for
reclaim, compaction etc. so it can leave random pages behind.

In practice it's probably fine, but it probably makes sense to say
it's advisable to set this config once before the workload launches
for best results, and not rely too much on changing things around
post-hoc, due to cost you pointed out but also due to reliability.

Otherwise no objection from me.
