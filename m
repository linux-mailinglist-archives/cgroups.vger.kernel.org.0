Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC1C1BCB
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2019 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfI3G45 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Sep 2019 02:56:57 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:43683 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfI3G45 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Sep 2019 02:56:57 -0400
Received: (qmail 7848 invoked from network); 30 Sep 2019 08:56:54 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 30 Sep 2019 08:56:54 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <52235eda-ffe2-721c-7ad7-575048e2d29d@profihost.ag>
 <20190910082919.GL2063@dhcp22.suse.cz>
 <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag>
 <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
 <20190910110741.GR2063@dhcp22.suse.cz>
 <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
 <20190910125756.GB2063@dhcp22.suse.cz>
 <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag>
 <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
 <20190910132418.GC2063@dhcp22.suse.cz>
 <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag>
 <2fe81a9e-5d29-79cf-f747-c66ae35defd0@profihost.ag>
 <4f6f1bc9-08f4-d53a-8788-a761be769757@suse.cz>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <d6740465-bf85-49f1-ae4e-0bf4780b96b0@profihost.ag>
Date:   Mon, 30 Sep 2019 08:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4f6f1bc9-08f4-d53a-8788-a761be769757@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

the current status is, that everything works well / fine since i
switched from CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS to
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
Am 27.09.19 um 14:45 schrieb Vlastimil Babka:
> On 9/19/19 12:21 PM, Stefan Priebe - Profihost AG wrote:
>> Kernel 5.2.14 is now running since exactly 7 days and now we can easaly
>> view a trend i', not sure if i should post graphs.
>>
>> Cache size is continuously shrinking while memfree is rising.
>>
>> While there were 4,5GB free in avg in the beginnen we now have an avg of
>> 8GB free memory.
>>
>> Cache has shrinked from avg 24G to avg 18G.
>>
>> Memory pressure has rised from avg 0% to avg 0.1% - not much but if you
>> look at the graphs it's continuously rising while cache is shrinking and
>> memfree is rising.
> 
> Hi, could you try the patch below? I suspect you're hitting a corner
> case where compaction_suitable() returns COMPACT_SKIPPED for the
> ZONE_DMA, triggering reclaim even if other zones have plenty of free
> memory. And should_continue_reclaim() then returns true until twice the
> requested page size is reclaimed (compact_gap()). That means 4MB
> reclaimed for each THP allocation attempt, which roughly matches the
> trace data you preovided previously.
> 
> The amplification to 4MB should be removed in patches merged for 5.4, so
> it would be only 32 pages reclaimed per THP allocation. The patch below
> tries to remove this corner case completely, and it should be more
> visible on your 5.2.x, so please apply it there.

so i switched back to 4.19 LTS Kernel - as this is the kernel we run on
all our infrastructures. THP is now only in use von kvm host machines.
Your patch applies to 4.19 as well - but not sure if it is a good idea
to apply it to those machines.

Greets,
Stefan
