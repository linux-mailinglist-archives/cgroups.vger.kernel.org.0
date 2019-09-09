Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1CDAD8D8
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfIIMVN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 08:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfIIMVN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Sep 2019 08:21:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AC8DAF38;
        Mon,  9 Sep 2019 12:21:11 +0000 (UTC)
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
 <b45eb4d9-b1ed-8637-84fa-2435ac285dde@suse.cz>
 <3ca34a49-6327-e6fd-2754-9b0700d87785@profihost.ag>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ec45c3f9-5649-fb39-ecf8-6ca7620a6e2a@suse.cz>
Date:   Mon, 9 Sep 2019 14:21:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3ca34a49-6327-e6fd-2754-9b0700d87785@profihost.ag>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/9/19 2:09 PM, Stefan Priebe - Profihost AG wrote:
> 
> Am 09.09.19 um 13:49 schrieb Vlastimil Babka:
>> On 9/9/19 10:54 AM, Stefan Priebe - Profihost AG wrote:
>>>> Do you have more snapshots of /proc/vmstat as suggested by Vlastimil and
>>>> me earlier in this thread? Seeing the overall progress would tell us
>>>> much more than before and after. Or have I missed this data?
>>>
>>> I needed to wait until today to grab again such a situation but from
>>> what i know it is very clear that MemFree is low and than the kernel
>>> starts to drop the chaches.
>>>
>>> Attached you'll find two log files.
>>
>> Thanks, what about my other requests/suggestions from earlier?
> 
> Sorry i missed your email.
> 
>> 1. How does /proc/pagetypeinfo look like?
> 
> # cat /proc/pagetypeinfo
> Page block order: 9
> Pages per block:  512

Looks like it might be fragmented, but was that snapshot taken in the 
situation where there's free memory and the system still drops cache?

>> 2. Could you also try if the bad trend stops after you execute:
>>   echo never > /sys/kernel/mm/transparent_hugepage/defrag
>> and report the result?
> 
> it's pretty difficult to catch those moments. Is it OK so set the value
> now and monitor if it happens again?

Well if it doesn't happen again after changing that setting, it would 
definitely point at THP interactions.

> Just to let you know:
> I've now also some more servers where memfree show 10-20Gb but cache
> drops suddently and memory PSI raises.

You mean those are in that state right now? So how does 
/proc/pagetypeinfo look there, and would changing the defrag setting help?

> Greets,
> Stefan
> 

