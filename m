Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E9311987
	for <lists+cgroups@lfdr.de>; Sat,  6 Feb 2021 04:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhBFDJT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 22:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhBFDBc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 22:01:32 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16479C06174A;
        Fri,  5 Feb 2021 19:00:52 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l14so4491239qvp.2;
        Fri, 05 Feb 2021 19:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsYTfAyddo367IDFzdQpxCbNtMumdTCO9J/dsgKO1IE=;
        b=etfqZ32m21s7qD/Oo8PaMdd8ZJ/AMC7yYpO89fS0vn3zirJaF3BbEo+yKkwTUCjAQQ
         tGpXQnXizzt+65NyOovBqftshiZuHcEcbthq1v+JoPcZTMIGwQGtNe1uDUGmuAEM5jf8
         C4YE4cE5euCOF6XFWa04yEOVtg+EczKUgf7atmpXKWgRvbYrJzdPnT98ZiCnschwlUJL
         UcbCNJvEmmjljr0zNUEv5xkD/0w4KeBUl7c5l3ddI/DSX/DY3lqXqCyS5vEvyI5oWAAi
         hex4hpU3tvTApMqrqON756efcFVTYjwONs6e6ljXlJoj1hWfxZ3E9YTiMkUygSeQ6+QF
         Hu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jsYTfAyddo367IDFzdQpxCbNtMumdTCO9J/dsgKO1IE=;
        b=MpDiFVk7FcDuIkMdrPUqcW/MRJFtYhEO49TGo+haPPGFjaXBj2+Hr/1mFcI2uTsMq3
         maOb+RM4LwLQkBl4ZyqGCjPdENr6vbWoRsj8Hg1MCUFaGSNFr5lt3CEtjSQ+s1Kn6aUr
         rF4fJKuSPYwV3gPg04lpf0UcYjV+1NmwG17zE0aszwFI6e15tSsSIMt4MY3p8JWe9bhl
         xw8bQost1pQp//F7n5YZFgD2YPjopZdlkDEEliHniAhkIFyBrvdS3+ZyQip4Z/mdlQXu
         SiRZCIKqP/b9vSzJYMG8SLHWtYX4n84upYway9oMgV9yJIPWanDgNkNrhUrMI+WSWMgP
         HeMA==
X-Gm-Message-State: AOAM530sB3ow0iV8wuX5jWa5qdaWUgYmebImOLM4J5Euya3+a+THwF/8
        LrlEYxaEd54PxGE+Wm9NG4k=
X-Google-Smtp-Source: ABdhPJzcT8L4O/rFn/XxOP4Cb29Q5OEMW0k3RonyDJYKXrbIhu7rdz5xndnrHRVTNd7y4ERhHE6VWQ==
X-Received: by 2002:a05:6214:c65:: with SMTP id t5mr7337492qvj.19.1612580451166;
        Fri, 05 Feb 2021 19:00:51 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id c17sm10964531qka.16.2021.02.05.19.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 19:00:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 Feb 2021 22:00:00 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] cgroup: rstat: support cgroup1
Message-ID: <YB4GMLKa56KLwBX2@mtj.duckdns.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
 <20210205182806.17220-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205182806.17220-5-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 05, 2021 at 01:28:02PM -0500, Johannes Weiner wrote:
> Rstat currently only supports the default hierarchy in cgroup2. In
> order to replace memcg's private stats infrastructure - used in both
> cgroup1 and cgroup2 - with rstat, the latter needs to support cgroup1.
> 
> The initialization and destruction callbacks for regular cgroups are
> already in place. Remove the cgroup_on_dfl() guards to handle cgroup1.
> 
> The initialization of the root cgroup is currently hardcoded to only
> handle cgrp_dfl_root.cgrp. Move those callbacks to cgroup_setup_root()
> and cgroup_destroy_root() to handle the default root as well as the
> various cgroup1 roots we may set up during mounting.
> 
> The linking of css to cgroups happens in code shared between cgroup1
> and cgroup2 as well. Simply remove the cgroup_on_dfl() guard.
> 
> Linkage of the root css to the root cgroup is a bit trickier: per
> default, the root css of a subsystem controller belongs to the default
> hierarchy (i.e. the cgroup2 root). When a controller is mounted in its
> cgroup1 version, the root css is stolen and moved to the cgroup1 root;
> on unmount, the css moves back to the default hierarchy. Annotate
> rebind_subsystems() to move the root css linkage along between roots.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Roman Gushchin <guro@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
