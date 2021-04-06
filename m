Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31749354F75
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 11:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhDFJI5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 05:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234988AbhDFJIw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 05:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617700123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xOwykMT0eamXfCJ+cRJDX97KIiXiqqoybhZz05k4kE=;
        b=DtMYcBTnjx9dUFxs4dTtpXmx9nd/IwUaDXm0RMNwa/2CTUnx1EHnOMHwhshsRa+WrtKYf9
        zl9eTafKeg9ZNn8OTE71ArZg20dckZXIftKR09DLkU1YtMmhZ8fg8QE3XeW2sfX3Y/yPG/
        j/k4GeKheiATA6gmPjKWrmV6LCjiNQ4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99685B135;
        Tue,  6 Apr 2021 09:08:43 +0000 (UTC)
Date:   Tue, 6 Apr 2021 11:08:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
Message-ID: <YGwlGrHtDJPQF7UG@dhcp22.suse.cz>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 05-04-21 10:08:24, Tim Chen wrote:
[...]
> To make fine grain cgroup based management of the precious top tier
> DRAM memory possible, this patchset adds a few new features:
> 1. Provides memory monitors on the amount of top tier memory used per cgroup 
>    and by the system as a whole.
> 2. Applies soft limits on the top tier memory each cgroup uses 
> 3. Enables kswapd to demote top tier pages from cgroup with excess top
>    tier memory usages.

Could you be more specific on how this interface is supposed to be used?

> This allows us to provision different amount of top tier memory to each
> cgroup according to the cgroup's latency need.
> 
> The patchset is based on cgroup v1 interface. One shortcoming of the v1
> interface is the limit on the cgroup is a soft limit, so a cgroup can
> exceed the limit quite a bit before reclaim before page demotion reins
> it in. 

I have to say that I dislike abusing soft limit reclaim for this. In the
past we have learned that the existing implementation is unfixable and
changing the existing semantic impossible due to backward compatibility.
So I would really prefer the soft limit just find its rest rather than
see new potential usecases.

I haven't really looked into details of this patchset but from a cursory
look it seems like you are actually introducing a NUMA aware limits into
memcg that would control consumption from some nodes differently than
other nodes. This would be rather alien concept to the existing memcg
infrastructure IMO. It looks like it is fusing borders between memcg and
cputset controllers.

You also seem to be basing the interface on the very specific usecase.
Can we expect that there will be many different tiers requiring their
own balancing?

-- 
Michal Hocko
SUSE Labs
