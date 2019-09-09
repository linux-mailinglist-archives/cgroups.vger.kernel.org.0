Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F1AD886
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391037AbfIIMJO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 08:09:14 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:38841 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390907AbfIIMJO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Sep 2019 08:09:14 -0400
Received: (qmail 31435 invoked from network); 9 Sep 2019 14:09:09 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 09 Sep 2019 14:09:09 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <20190909082732.GC27159@dhcp22.suse.cz>
 <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
 <b45eb4d9-b1ed-8637-84fa-2435ac285dde@suse.cz>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <3ca34a49-6327-e6fd-2754-9b0700d87785@profihost.ag>
Date:   Mon, 9 Sep 2019 14:09:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b45eb4d9-b1ed-8637-84fa-2435ac285dde@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Am 09.09.19 um 13:49 schrieb Vlastimil Babka:
> On 9/9/19 10:54 AM, Stefan Priebe - Profihost AG wrote:
>>> Do you have more snapshots of /proc/vmstat as suggested by Vlastimil and
>>> me earlier in this thread? Seeing the overall progress would tell us
>>> much more than before and after. Or have I missed this data?
>>
>> I needed to wait until today to grab again such a situation but from
>> what i know it is very clear that MemFree is low and than the kernel
>> starts to drop the chaches.
>>
>> Attached you'll find two log files.
> 
> Thanks, what about my other requests/suggestions from earlier?

Sorry i missed your email.

> 1. How does /proc/pagetypeinfo look like?

# cat /proc/pagetypeinfo
Page block order: 9
Pages per block:  512

Free pages count per migrate type at order       0      1      2      3
     4      5      6      7      8      9     10
Node    0, zone      DMA, type    Unmovable      1      0      0      1
     2      1      1      0      1      0      0
Node    0, zone      DMA, type      Movable      0      0      0      0
     0      0      0      0      0      1      3
Node    0, zone      DMA, type  Reclaimable      0      0      0      0
     0      0      0      0      0      0      0
Node    0, zone      DMA, type   HighAtomic      0      0      0      0
     0      0      0      0      0      0      0
Node    0, zone      DMA, type      Isolate      0      0      0      0
     0      0      0      0      0      0      0
Node    0, zone    DMA32, type    Unmovable   1141    970    903    628
   302    106     27      4      0      0      0
Node    0, zone    DMA32, type      Movable    274    269    368    396
   342    265    214    178    113     12     13
Node    0, zone    DMA32, type  Reclaimable     81     57    134    114
    60     50     25      4      2      0      0
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0
     0      0      0      0      0      0      0
Node    0, zone    DMA32, type      Isolate      0      0      0      0
     0      0      0      0      0      0      0
Node    0, zone   Normal, type    Unmovable     39     36  13257   3474
  1333    317     42      0      0      0      0
Node    0, zone   Normal, type      Movable   1087   9678   1104   4250
  2391   1946   1768    691    141      0      0
Node    0, zone   Normal, type  Reclaimable      1   1782   1153   2455
  1927    986    330      7      2      0      0
Node    0, zone   Normal, type   HighAtomic      1      1      2      2
     2      0      1      1      1      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0
     0      0      0      0      0      0      0

Number of blocks type     Unmovable      Movable  Reclaimable
HighAtomic      Isolate
Node 0, zone      DMA            1            7            0
0            0
Node 0, zone    DMA32           52         1461           15
0            0
Node 0, zone   Normal          824         5448          383
1            0

> 2. Could you also try if the bad trend stops after you execute:
>  echo never > /sys/kernel/mm/transparent_hugepage/defrag
> and report the result?

it's pretty difficult to catch those moments. Is it OK so set the value
now and monitor if it happens again?

Just to let you know:
I've now also some more servers where memfree show 10-20Gb but cache
drops suddently and memory PSI raises.

Greets,
Stefan
