Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D755374A28
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 23:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhEEVax (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 17:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhEEVax (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 17:30:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48846AFD5;
        Wed,  5 May 2021 21:29:55 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Roman Gushchin <guro@fb.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
 <YJLk1tmDeGed58yr@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f73cc1c6-2950-c56d-6a57-8cebb23db65b@suse.cz>
Date:   Wed, 5 May 2021 23:29:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJLk1tmDeGed58yr@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 8:32 PM, Roman Gushchin wrote:
> On Wed, May 05, 2021 at 08:02:06PM +0200, Vlastimil Babka wrote:
>> On 5/5/21 7:30 PM, Roman Gushchin wrote:
>> > On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
>> >> 
>> >> With this change, all the objcg pointer array objects will come from
>> >> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>> >> both the recursive kfree() problem and non-freeable slab problem are
>> >> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>> >> have mixed accounted and unaccounted objects, this will slightly reduce
>> >> the number of objcg pointer arrays that need to be allocated and save
>> >> a bit of memory.
>> > 
>> > Unfortunately the positive effect of this change will be likely
>> > reversed by a lower utilization due to a larger number of caches.
>> > 
>> > Btw, I wonder if we also need a change in the slab caches merging procedure?
>> > KMALLOC_NORMAL caches should not be merged with caches which can potentially
>> > include accounted objects.
>> 
>> Good point. But looks like kmalloc* caches are extempt from all merging in
>> create_boot_cache() via
>> 
>> 	s->refcount = -1;       /* Exempt from merging for now */
> 
> Wait, s->refcount is adjusted to 1 in create_kmalloc_cache() after calling
> into create_boot_cache?

Hmm I missed that

Now I wonder why all kmalloc caches on my system have 0 aliases :)
cat /sys/kernel/slab/kmalloc-*/aliases


> It means they are not exempt actually.
> 

