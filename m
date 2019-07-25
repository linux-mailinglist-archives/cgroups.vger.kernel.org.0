Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D47759D5
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfGYVmV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 17:42:21 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:33587 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfGYVmU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 17:42:20 -0400
Received: (qmail 11487 invoked from network); 25 Jul 2019 23:42:18 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.6]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 25 Jul 2019 23:42:18 +0200
Subject: Re: No memory reclaim while reaching MemoryHigh
To:     Chris Down <chris@chrisdown.name>
Cc:     cgroups@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
 <20190725145355.GA7347@chrisdown.name>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <06bc6218-810d-a912-935c-cb09d063ec3d@profihost.ag>
Date:   Thu, 25 Jul 2019 23:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725145355.GA7347@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Chris,

Am 25.07.19 um 16:53 schrieb Chris Down:
> Hi Stefan,
> 
> Stefan Priebe - Profihost AG writes:
>> While using kernel 4.19.55 and cgroupv2 i set a MemoryHigh value for a
>> varnish service.
>>
>> It happens that the varnish.service cgroup reaches it's MemoryHigh value
>> and stops working due to throttling.
> 
> In that kernel version, the only throttling we have is reclaim-based
> throttling (I also have a patch out to do schedule-based throttling, but
> it's not in mainline yet). If the application is slowing down, it likely
> means that we are struggling to reclaim pages.

Sounds interesting can you point me to a discussion or thread?


>> But i don't understand is that the process itself only consumes 40% of
>> it's cgroup usage.
>>
>> So the other 60% is dirty dentries and inode cache. If i issue an
>> echo 3 > /proc/sys/vm/drop_caches
>>
>> the varnish cgroup memory usage drops to the 50% of the pure process.
> 
> As a caching server, doesn't Varnish have a lot of hot inodes/dentries
> in memory? If they are hot, it's possible it's hard for us to evict them.

May be but they can't be that hot as what i would call hot. If you drop
caches the whole cgroup is only using ~ 1G extra memory even after hours.

>> I thought that the kernel would trigger automatic memory reclaim if a
>> cgroup reaches is memory high value to drop caches.
> 
> It does, that's the throttling you're seeing :-) I think more
> information is needed to work out what's going on here. For example:
> what do your kswapd counters look like?

Where do i find those?

> What does "stops working due to
> throttling" mean -- are you stuck in reclaim?

See the other mail to Michal - varnish does not respond and stack hangs
in handle_mm_fault.

I thought th kernel would drop fast the unneeded pagecache, inode and
dentries cache.

Thanks,
Stefan
