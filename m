Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FFC35FE5F
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 01:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhDNXW5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 19:22:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:49778 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbhDNXW5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Apr 2021 19:22:57 -0400
IronPort-SDR: +e3cUORvlUZO0kaSOmHTujgSvLV10z9Ahhlwb/XpiNxFhFl3Zr4QqLeMziOD3m/S/Wie44Kc5F
 OAp2V9JDrOVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191569719"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="191569719"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 16:22:35 -0700
IronPort-SDR: yKzHtAmEdZ0kv3rfguUotAqfiqqx8CmwXDFa45EuQRacYxvT5a105gadLWQoJsEHrhvD7gSA7Q
 vzz7FfRwUpaA==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="389553964"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.63.115])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 16:22:35 -0700
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
To:     Shakeel Butt <shakeelb@google.com>, Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.cz>,
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
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <ffa8eb86-27e3-3a46-4977-0d0cf33503fe@linux.intel.com>
Date:   Wed, 14 Apr 2021 16:22:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 4/8/21 1:29 PM, Shakeel Butt wrote:
> On Thu, Apr 8, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:

> 
> The low and min limits have semantics similar to the v1's soft limit
> for this situation i.e. letting the low priority job occupy top tier
> memory and depending on reclaim to take back the excess top tier
> memory use of such jobs.
> 
> I have some thoughts on NUMA node limits which I will share in the other thread.
> 

Shakeel,

Look forward to the proposal on NUMA node limits.  Which thread are
you going to post it?  Want to make sure I didn't miss it.

Tim
