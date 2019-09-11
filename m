Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3FAF5B9
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2019 08:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfIKGY2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Sep 2019 02:24:28 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:28055 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfIKGY2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Sep 2019 02:24:28 -0400
Received: (qmail 9504 invoked from network); 11 Sep 2019 08:24:25 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Wed, 11 Sep 2019 08:24:25 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
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
Message-ID: <5f960e74-1f44-9a0a-58a6-dcb64aa71612@profihost.ag>
Date:   Wed, 11 Sep 2019 08:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

Am 11.09.19 um 08:12 schrieb Stefan Priebe - Profihost AG:
> Hi Michal,
> Am 10.09.19 um 15:24 schrieb Michal Hocko:
>> On Tue 10-09-19 15:14:45, Stefan Priebe - Profihost AG wrote:
>>> Am 10.09.19 um 15:05 schrieb Stefan Priebe - Profihost AG:
>>>>
>>>> Am 10.09.19 um 14:57 schrieb Michal Hocko:
>>>>> On Tue 10-09-19 14:45:37, Stefan Priebe - Profihost AG wrote:
>>>>>> Hello Michal,
>>>>>>
>>>>>> ok this might take a long time. Attached you'll find a graph from a
>>>>>> fresh boot what happens over time (here 17 August to 30 August). Memory
>>>>>> Usage decreases as well as cache but slowly and only over time and days.
>>>>>>
>>>>>> So it might take 2-3 weeks running Kernel 5.3 to see what happens.
>>>>>
>>>>> No problem. Just make sure to collect the requested data from the time
>>>>> you see the actual problem. Btw. you try my very dumb scriplets to get
>>>>> an idea of how much memory gets reclaimed due to THP.
>>>>
>>>> You mean your sed and sort on top of the trace file? No i did not with
>>>> the current 5.3 kernel do you think it will show anything interesting?
>>>> Which line shows me how much memory gets reclaimed due to THP?
>>
>> Please re-read http://lkml.kernel.org/r/20190910082919.GL2063@dhcp22.suse.cz
>> Each command has a commented output. If you see nunmber of reclaimed
>> pages to be large for GFP_TRANSHUGE then you are seeing a similar
>> problem.
>>
>>> Is something like a kernel memory leak possible? Or wouldn't this end up
>>> in having a lot of free memory which doesn't seem usable.
>>
>> I would be really surprised if this was the case.
>>
>>> I also wonder why a reclaim takes place when there is enough memory.
>>
>> This is not clear yet and it might be a bug that has been fixed since
>> 4.18. That's why we need to see whether the same is pattern is happening
>> with 5.3 as well.

but except from the btrfs problem the memory consumption looks far
better than before.

Running 4.19.X:
after about 12h cache starts to drop from 30G to 24G

Running 5.3-rc8:
after about 24h cache is still constant at nearly 30G

Greets,
Stefan
