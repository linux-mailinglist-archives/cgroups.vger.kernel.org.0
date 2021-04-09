Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29C235964B
	for <lists+cgroups@lfdr.de>; Fri,  9 Apr 2021 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDIHYn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 03:24:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhDIHYn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 9 Apr 2021 03:24:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617953070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3CuiOk6cqvEWVs8EpFm1ZB/VV5Oybfre6iEM0gujwYY=;
        b=H4OWQuY93sOd2wKm3WVHcYphE9zQySsHIQ3lLQnHVXjXiTp5Z2tGAgTERRG5jUPKPJz+WD
        aeAYiSW0cSqzDTTLy2KbJpJgWv7DhS+age8yXFSPvW0YTZsIDaZ7PgOaFd1yMcKNYaXUvZ
        kMvpiEldYW/V/6JgPafaL4NeJ4VBUV0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCA45AF0D;
        Fri,  9 Apr 2021 07:24:29 +0000 (UTC)
Date:   Fri, 9 Apr 2021 09:24:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
Message-ID: <YHABLBYU0UgzwOZi@dhcp22.suse.cz>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
 <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
 <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 08-04-21 13:29:08, Shakeel Butt wrote:
> On Thu, Apr 8, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
[...]
> > The low priority jobs should be able to be restricted by cpuset, for
> > example, just keep them on second tier memory nodes. Then all the
> > above problems are gone.

Yes, if the aim is to isolate some users from certain numa node then
cpuset is a good fit but as Shakeel says this is very likely not what
this work is aiming for.

> Yes that's an extreme way to overcome the issue but we can do less
> extreme by just (hard) limiting the top tier usage of low priority
> jobs.

Per numa node high/hard limit would help with a more fine grained control.
The configuration would be tricky though. All low priority memcgs would
have to be carefully configured to leave enough for your important
processes. That includes also memory which is not accounted to any
memcg. 
The behavior of those limits would be quite tricky for OOM situations
as well due to a lack of NUMA aware oom killer.
-- 
Michal Hocko
SUSE Labs
