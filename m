Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B478A3EAC9F
	for <lists+cgroups@lfdr.de>; Thu, 12 Aug 2021 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhHLVlo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Aug 2021 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhHLVlo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Aug 2021 17:41:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B205C061756;
        Thu, 12 Aug 2021 14:41:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e15so9127628plh.8;
        Thu, 12 Aug 2021 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAC7usbSxJAj4Uf52V6UWSOyNZ0nwEBnpPn4ZOBy98U=;
        b=N19jAu7ypTXt6WK7cfJ0LMDOqywRj+Jwavt99QhQohJWtN4D3MU5t9zGcqaItP0Gt6
         Z8wkY6LhQhZ61HOWBUtfY8d6PLtkaMY7xGmmmvr8Q9vgQXi2lDBhCXzPedrMqMgy44OX
         BkCZfXCvjlGo8duK1PJTdKuhu5tQcgvVwNQBFvscXnfMVEdjPgs8BfJ7v3ApWfkBzeYZ
         Qur5/Wv9akKhyJn+x3QOE1D2tDZdUkTO9cnK+qC4Wx6QdnHDzbAkoCgDQD5PIYXDJ8V/
         NoZnEZ2VEhJWtk8/WwgZ6qImb4PDaCBvAiornHAvrL+UcURc6q3EwSf2JVxrxaN9q47j
         FyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TAC7usbSxJAj4Uf52V6UWSOyNZ0nwEBnpPn4ZOBy98U=;
        b=Uut3HTwLQBjAt4+2b/5nvg1j3xcTKy/qt3Gd878eIDMh7zVUeBgIWsNILfOWMyCG/x
         c5Vd2AUpPhI+DtK1JsGazLGSCymfQmVHKfrMksszObfxH9uzhiWXMMCN5z2nU2tglEDh
         Legwi/drxl6MSx8vD+ZgALUx0+6ZukbshnKYoY/djWzZx7cUdM+OGH4X0sQFdPM1K5Vd
         nxMBcUlycNH6lXEjJE8+wg+C83X2ICyY4MSQZCp/x3d4tz7ZrsXUXs7fkeM4IXtzqdwT
         BbRtGKdPTJN42blgSZFfT+/AEtaBlu/lL3mSa+h1W8kMO/YZ29ZTBEc6LWGhRlxN8Te6
         vMOg==
X-Gm-Message-State: AOAM530YZ0x5I39kAT7FiqZIAxdz8lbQATYOosFXeqAqYOVKPdWFC8KJ
        kB9qNisSJAOGqUBkG5d1V54=
X-Google-Smtp-Source: ABdhPJy3pQeWEPeVupAuFxBDvjFrN6aPESruOg+x2WRkhnEUCUEDHySfROWKgUilKid5hosVOf5Ciw==
X-Received: by 2002:a63:4d18:: with SMTP id a24mr5550376pgb.324.1628804477955;
        Thu, 12 Aug 2021 14:41:17 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v10sm11118067pjd.29.2021.08.12.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:41:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 11:41:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: Enable memory migration for cpuset v2
Message-ID: <YRWVe5j8G2LLvTt4@slm.duckdns.org>
References: <20210811195707.30851-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811195707.30851-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 11, 2021 at 03:57:07PM -0400, Waiman Long wrote:
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

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
