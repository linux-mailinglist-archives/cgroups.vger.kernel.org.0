Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB2AD83E
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 13:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404458AbfIILtq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 07:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732500AbfIILtp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Sep 2019 07:49:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EF4CAD44;
        Mon,  9 Sep 2019 11:49:44 +0000 (UTC)
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <20190909082732.GC27159@dhcp22.suse.cz>
 <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b45eb4d9-b1ed-8637-84fa-2435ac285dde@suse.cz>
Date:   Mon, 9 Sep 2019 13:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/9/19 10:54 AM, Stefan Priebe - Profihost AG wrote:
>> Do you have more snapshots of /proc/vmstat as suggested by Vlastimil and
>> me earlier in this thread? Seeing the overall progress would tell us
>> much more than before and after. Or have I missed this data?
> 
> I needed to wait until today to grab again such a situation but from
> what i know it is very clear that MemFree is low and than the kernel
> starts to drop the chaches.
> 
> Attached you'll find two log files.

Thanks, what about my other requests/suggestions from earlier?

1. How does /proc/pagetypeinfo look like?
2. Could you also try if the bad trend stops after you execute:
  echo never > /sys/kernel/mm/transparent_hugepage/defrag
and report the result?

Thanks
