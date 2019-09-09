Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262D0AD88C
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 14:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404746AbfIIMKE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 08:10:04 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:54969 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404263AbfIIMKE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Sep 2019 08:10:04 -0400
Received: (qmail 31500 invoked from network); 9 Sep 2019 14:10:02 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 09 Sep 2019 14:10:02 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <20190909082732.GC27159@dhcp22.suse.cz>
 <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
 <20190909110136.GG27159@dhcp22.suse.cz>
 <20190909120811.GL27159@dhcp22.suse.cz>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <88ff0310-b9ab-36b6-d8ab-b6edd484d973@profihost.ag>
Date:   Mon, 9 Sep 2019 14:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909120811.GL27159@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Am 09.09.19 um 14:08 schrieb Michal Hocko:
> On Mon 09-09-19 13:01:36, Michal Hocko wrote:
>> and that matches moments when we reclaimed memory. There seems to be a
>> steady THP allocations flow so maybe this is a source of the direct
>> reclaim?
> 
> I was thinking about this some more and THP being a source of reclaim
> sounds quite unlikely. At least in a default configuration because we
> shouldn't do anything expensinve in the #PF path. But there might be a
> difference source of high order (!costly) allocations. Could you check
> how many allocation requests like that you have on your system?
> 
> mount -t debugfs none /debug
> echo "order > 0" > /debug/tracing/events/kmem/mm_page_alloc/filter
> echo 1 > /debug/tracing/events/kmem/mm_page_alloc/enable
> cat /debug/tracing/trace_pipe > $file

Just now or when PSI raises?

Greets,
Stefan
