Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA437180F
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhECPdU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 11:33:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhECPdT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 11:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59593B01F;
        Mon,  3 May 2021 15:32:25 +0000 (UTC)
To:     Waiman Long <llong@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210502180755.445-1-longman@redhat.com>
 <20210502180755.445-2-longman@redhat.com>
 <699e5ac8-9044-d664-f73f-778fe72fd09b@suse.cz>
 <4c90cf79-9c61-8964-a6fd-2da087893339@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm: memcg/slab: Don't create unfreeable slab
Message-ID: <d767ff72-711d-976c-d897-9cea0375c827@suse.cz>
Date:   Mon, 3 May 2021 17:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4c90cf79-9c61-8964-a6fd-2da087893339@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/3/21 4:20 PM, Waiman Long wrote:
> On 5/3/21 8:22 AM, Vlastimil Babka wrote:
>> On 5/2/21 8:07 PM, Waiman Long wrote:
>>> The obj_cgroup array (memcg_data) embedded in the page structure is
>>> allocated at the first instance an accounted memory allocation happens.
>>> With the right size object, it is possible that the allocated obj_cgroup
>>> array comes from the same slab that requires memory accounting. If this
>>> happens, the slab will never become empty again as there is at least one
>>> object left (the obj_cgroup array) in the slab.
>>>
>>> With instructmentation code added to detect this situation, I got 76
>>> hits on the kmalloc-192 slab when booting up a test kernel on a VM.
>>> So this can really happen.
>>>
>>> To avoid the creation of these unfreeable slabs, a check is added to
>>> memcg_alloc_page_obj_cgroups() to detect that and double the size
>>> of the array in case it happens to make sure that it comes from a
>>> different kmemcache.
>>>
>>> This change, however, does not completely eliminate the presence
>>> of unfreeable slabs which can still happen if a circular obj_cgroup
>>> array dependency is formed.
>> Hm this looks like only a half fix then.
>> I'm afraid the proper fix is for kmemcg to create own set of caches for the
>> arrays. It would also solve the recursive kfree() issue.
> 
> Right, this is a possible solution. However, the objcg pointers array should
> need that much memory. Creating its own set of kmemcaches may seem like an
> overkill.

Well if we go that way, there might be additional benefits:

depending of gfp flags, kmalloc() would allocate from:

kmalloc-* caches that never have kmemcg objects, thus can be used for the objcg
pointer arrays
kmalloc-cg-* caches that have only kmemcg unreclaimable objects
kmalloc-rcl-* and dma-kmalloc-* can stay with on-demand
memcg_alloc_page_obj_cgroups()

This way we fully solve the issues that this patchset solves. In addition we get
better separation between kmemcg and !kmemcg thus save memory - no allocation of
the array as soon as a single object appears in slab. For "kmalloc-8" we now
have 8 bytes for the useful data and 8 bytes for the obj_cgroup  pointer.

Vlastimil

> Cheers,
> Longman
> 

