Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2A36157F
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhDOWcM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 18:32:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:26527 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234764AbhDOWcM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Apr 2021 18:32:12 -0400
IronPort-SDR: Z545+vNWPPckl0KnvurPgzhFitYbQBbnlKvrR1ZgK+WD+aKRW2ue6G4n+fH7i0xgGIo35z1ZPx
 hWRGx7AKljkw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="182451049"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="182451049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:31:48 -0700
IronPort-SDR: Vz5L/aqOpzPiervUyJdJvGmElFJ3yi7owML1W7i9kVQSa51SUX+IF0Ae+DeYJ+ot/rKL0yKwgo
 WSqa4xn66c/g==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="453108163"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.21.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:31:46 -0700
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
 <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
 <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
 <YHABLBYU0UgzwOZi@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <4a864946-a316-3d9c-8780-64c6281276d1@linux.intel.com>
Date:   Thu, 15 Apr 2021 15:31:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YHABLBYU0UgzwOZi@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 4/9/21 12:24 AM, Michal Hocko wrote:
> On Thu 08-04-21 13:29:08, Shakeel Butt wrote:
>> On Thu, Apr 8, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
> [...]
>>> The low priority jobs should be able to be restricted by cpuset, for
>>> example, just keep them on second tier memory nodes. Then all the
>>> above problems are gone.
> 
> Yes, if the aim is to isolate some users from certain numa node then
> cpuset is a good fit but as Shakeel says this is very likely not what
> this work is aiming for.
> 
>> Yes that's an extreme way to overcome the issue but we can do less
>> extreme by just (hard) limiting the top tier usage of low priority
>> jobs.
> 
> Per numa node high/hard limit would help with a more fine grained control.
> The configuration would be tricky though. All low priority memcgs would
> have to be carefully configured to leave enough for your important
> processes. That includes also memory which is not accounted to any
> memcg. 
> The behavior of those limits would be quite tricky for OOM situations
> as well due to a lack of NUMA aware oom killer.
> 

Another downside of putting limits on individual NUMA
node is it would limit flexibility.  For example two memory nodes are
similar enough in performance, that you really only care about a cgroup
not using more than a threshold of the combined capacity from the two
memory nodes.  But when you put a hard limit on NUMA node, then you are
tied down to a fix allocation partition for each node.  Perhaps there are
some kernel resources that are pre-allocated primarily from one node. A
cgroup may bump into the limit on the node and failed the allocation,
even when it has a lot of slack in the other node.  This makes getting
the configuration right trickier.

There are some differences in opinion currently
on whether grouping memory nodes into tiers, and putting limit on
using them by cgroup is a desirable.  Many people want the 
management constraint placed at individual NUMA node for each cgroup, instead
of at the tier level.  Will appreciate feedbacks from folks who have
insights on how such NUMA based control interface will work, so we
at least agree here in order to move forward.

Tim

