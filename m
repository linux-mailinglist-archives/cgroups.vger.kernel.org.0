Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA93A9C01
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfIEHiW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 03:38:22 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:39482 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730809AbfIEHiW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 03:38:22 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 031232E1519;
        Thu,  5 Sep 2019 10:38:18 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zR742402O6-cGCeA6uq;
        Thu, 05 Sep 2019 10:38:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1567669097; bh=p62JvE7KIEdXgE5AI0O+ncYaxKXSledvuRxkzME19lE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=w77rFB3tr6IkUqc3lv1cy4Vf2a2mzFTEgpy+TL3fPDVhh1Mdqjs6mz1Cn+KzNESdn
         QqquEkwKT49yyjF/sJV2v9ZCqPe85FWRAwxQOkVmsFlYQ7AUcx8S+27Myi6JReTqOW
         KNXK5RJ6pM83josbgeyjnQTDTsaqFkXi0GBS6xwE=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:c142:79c2:9d86:677a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hEYODfnDuP-cG7uwExp;
        Thu, 05 Sep 2019 10:38:16 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
 <20190904143747.GA3838@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <6171edb1-4598-5709-bb62-07bed89175b1@yandex-team.ru>
Date:   Thu, 5 Sep 2019 10:38:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904143747.GA3838@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/09/2019 17.37, Michal Hocko wrote:
> On Wed 04-09-19 16:53:08, Konstantin Khlebnikov wrote:
>> Currently mlock keeps pages in cgroups where they were accounted.
>> This way one container could affect another if they share file cache.
>> Typical case is writing (downloading) file in one container and then
>> locking in another. After that first container cannot get rid of cache.
>> Also removed cgroup stays pinned by these mlocked pages.
>>
>> This patchset implements recharging pages to cgroup of mlock user.
>>
>> There are three cases:
>> * recharging at first mlock
>> * recharging at munlock to any remaining mlock
>> * recharging at 'culling' in reclaimer to any existing mlock
>>
>> To keep things simple recharging ignores memory limit. After that memory
>> usage temporary could be higher than limit but cgroup will reclaim memory
>> later or trigger oom, which is valid outcome when somebody mlock too much.
> 
> I assume that this is mlock specific because the pagecache which has the
> same problem is reclaimable and the problem tends to resolve itself
> after some time.
> 
> Anyway, how big of a problem this really is? A lingering memcg is
> certainly not nice but pages are usually not mlocked for ever. Or is
> this a way to protect from an hostile actor?

We're using mlock mostly to avoid non-deterministic behaviour in cache.
For example some of our applications mlock index structures in databases
to limit count of major faults in worst case.

Surprisingly mlock fixates unwanted effects of non-predictable cache sharing.

So, it seems makes sense to make mlock behaviour simple and completely
deterministic because this isn't cheap operation and needs careful
resource planning.



On 05/09/2019 02.13, Roman Gushchin wrote:> On Wed, Sep 04, 2019 at 04:53:08PM +0300, Konstantin Khlebnikov wrote:
 >> Currently mlock keeps pages in cgroups where they were accounted.
 >> This way one container could affect another if they share file cache.
 >> Typical case is writing (downloading) file in one container and then
 >> locking in another. After that first container cannot get rid of cache.
 >
 > Yeah, it's a valid problem, and it's not about mlocked pages only,
 > the same thing is true for generic pagecache. The only difference is that
 > in theory memory pressure should fix everything. But in reality
 > pagecache used by the second container can be very hot, so the first
 > once can't really get rid of it.
 > In other words, there is no way to pass a pagecache page between cgroups
 > without evicting it and re-reading from a storage, which is sub-optimal
 > in many cases.
 >
 > We thought about new madvise(), which will uncharge pagecache but set
 > a new page flag, which will mean something like "whoever first starts using
 > the page, should be charged for it". But it never materialized in a patchset.

I've implemented something similar in OpenVZ kernel - "shadow" LRU sets for
abandoned cache which automatically changes ownership at first activation.

I'm thinking about fadvise() or fcntl() for moving cache into current memory cgroup.
This should give enough control to solve all our problems.

 >
 >> Also removed cgroup stays pinned by these mlocked pages.
 >
 > Tbh, I don't think it's a big issue here. If only there is a huge number
 > of 1-page sized mlock areas, but this seems to be unlikely.

Yep, not so big problem, tmpfs generates much more issues in this area.

 >
 >>
 >> This patchset implements recharging pages to cgroup of mlock user.
 >>
 >> There are three cases:
 >> * recharging at first mlock
 >> * recharging at munlock to any remaining mlock
 >> * recharging at 'culling' in reclaimer to any existing mlock
 >>
 >> To keep things simple recharging ignores memory limit. After that memory
 >> usage temporary could be higher than limit but cgroup will reclaim memory
 >> later or trigger oom, which is valid outcome when somebody mlock too much.
 >
 > OOM is a concern here. If quitting an application will cause an immediate OOM
 > in an other cgroup, that's not so good. Ideally it should work like
 > memory.high, forcing all threads in the second cgroup into direct reclaim.
 >

Mlock requires careful resource planning. Since sharing always been
non-deterministic each user should be ready to take all locked memory.

It's hard to inject direct reclaim into another thread for sure.
All we could do is starting background reclaim in kernel thread.
Doing this in task who calls munlock() is not fair.

At mlock it's possible to force direct claim for memory usage over high limit:
https://lore.kernel.org/linux-mm/156431697805.3170.6377599347542228221.stgit@buzz/

> 
>> Konstantin Khlebnikov (7):
>>        mm/memcontrol: move locking page out of mem_cgroup_move_account
>>        mm/memcontrol: add mem_cgroup_recharge
>>        mm/mlock: add vma argument for mlock_vma_page()
>>        mm/mlock: recharge memory accounting to first mlock user
>>        mm/mlock: recharge memory accounting to second mlock user at munlock
>>        mm/vmscan: allow changing page memory cgroup during reclaim
>>        mm/mlock: recharge mlocked pages at culling by vmscan
>>
>>
>>   Documentation/admin-guide/cgroup-v1/memory.rst |    5 +
>>   include/linux/memcontrol.h                     |    9 ++
>>   include/linux/rmap.h                           |    3 -
>>   mm/gup.c                                       |    2
>>   mm/huge_memory.c                               |    4 -
>>   mm/internal.h                                  |    6 +
>>   mm/ksm.c                                       |    2
>>   mm/memcontrol.c                                |  104 ++++++++++++++++--------
>>   mm/migrate.c                                   |    2
>>   mm/mlock.c                                     |   14 +++
>>   mm/rmap.c                                      |    5 +
>>   mm/vmscan.c                                    |   17 ++--
>>   12 files changed, 121 insertions(+), 52 deletions(-)
>>
>> --
>> Signature
> 
