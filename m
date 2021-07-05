Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39ED3BB6CB
	for <lists+cgroups@lfdr.de>; Mon,  5 Jul 2021 07:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGEFdH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jul 2021 01:33:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:48282 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhGEFdH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Jul 2021 01:33:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="207097821"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="207097821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2021 22:30:29 -0700
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="495996838"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2021 22:30:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        =?utf-8?Q?Michal_Kou?= =?utf-8?Q?tn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: switch lruvec stats to rstat
References: <20210615174435.4174364-1-shakeelb@google.com>
Date:   Mon, 05 Jul 2021 13:30:21 +0800
In-Reply-To: <20210615174435.4174364-1-shakeelb@google.com> (Shakeel Butt's
        message of "Tue, 15 Jun 2021 10:44:34 -0700")
Message-ID: <877di549aq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Shakeel,

Shakeel Butt <shakeelb@google.com> writes:

> The commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat") but skipped
> the conversion of the lruvec stats as such stats are read in the
> performance critical code paths and flushing stats may have impacted the
> performances of the applications. This patch converts the lruvec stats
> to rstat and later patch adds the periodic flushing of the stats and
> thus remove the need to synchronously flushing the stats in the
> performance critical code paths.
>
> The rstat conversion comes with the price i.e. memory cost. Effectively
> this patch reverts the savings done by the commit f3344adf38bd ("mm:
> memcontrol: optimize per-lruvec stats counter memory usage"). However
> this cost is justified due to negative impact of the inaccurate lruvec
> stats on many heuristics. One such case is reported in [1].
>
> The memory reclaim code is filled with plethora of heuristics and many
> of those heuristics reads the lruvec stats. So, inaccurate stats can
> make such heuristics ineffective. [1] reports the impact of inaccurate
> lruvec stats on the "cache trim mode" heuristic. Inaccurate lruvec stats
> can impact the deactivation and aging anon heuristics as well.
>
> [1] https://lore.kernel.org/linux-mm/20210311004449.1170308-1-ying.huang@intel.com/

Sorry for late reply.  I have just verified that this patchset can
resolve the problem as in the above link for me.  Thanks!

Best Regards,
Huang, Ying

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - no changes
>
