Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D366AA319
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 14:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfIEM1Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 08:27:16 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:31643 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387866AbfIEM1Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 08:27:16 -0400
Received: (qmail 16449 invoked from network); 5 Sep 2019 14:27:15 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.4]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 05 Sep 2019 14:27:15 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     l.roehrs@profihost.ag, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <5c1d6fca-4bbe-1c09-e0c5-523bca8fbb6a@suse.cz>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <7379c903-3a46-a1b0-0903-ce03c982226a@profihost.ag>
Date:   Thu, 5 Sep 2019 14:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5c1d6fca-4bbe-1c09-e0c5-523bca8fbb6a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Am 05.09.19 um 14:15 schrieb Vlastimil Babka:
> On 9/5/19 1:27 PM, Stefan Priebe - Profihost AG wrote:
>> Hello all,
>>
>> i hope you can help me again to understand the current MemAvailable
>> value in the linux kernel. I'm running a 4.19.52 kernel + psi patches in
>> this case.
>>
>> I'm seeing the following behaviour i don't understand and ask for help.
>>
>> While MemAvailable shows 5G the kernel starts to drop cache from 4G down
>> to 1G while the apache spawns some PHP processes. After that the PSI
>> mem.some value rises and the kernel tries to reclaim memory but
>> MemAvailable stays at 5G.
>>
>> Any ideas?
> 
> PHP seems to use madvise(MADV_HUGEPAGE), so if it's a NUMA machine it
> might be worth trying to cherry-pick these two commits:
> 92717d429b38 ("Revert "Revert "mm, thp: consolidate THP gfp handling
> into alloc_hugepage_direct_gfpmask""")
> a8282608c88e ("Revert "mm, thp: restore node-local hugepage allocations"")

No it's a vm running inside qemu/kvm without numa.

Greets,
Stefan
