Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297EB2CDD4
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfE1Rll (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfE1Rll (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 28 May 2019 13:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F89730833AF;
        Tue, 28 May 2019 17:41:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45C4B1019607;
        Tue, 28 May 2019 17:41:35 +0000 (UTC)
Subject: Re: [PATCH v5 5/7] mm: rework non-root kmem_cache lifecycle
 management
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-6-guro@fb.com>
 <20190528170828.zrkvcdsj3d3jzzzo@esperanza>
 <96b8a923-49e4-f13e-b1e3-3df4598d849e@redhat.com>
 <20190528173959.h4hq55b3ajlfpjrk@esperanza>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <518419c5-ee74-d9a1-c01c-f1a3306d2d34@redhat.com>
Date:   Tue, 28 May 2019 13:41:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528173959.h4hq55b3ajlfpjrk@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 28 May 2019 17:41:40 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/28/19 1:39 PM, Vladimir Davydov wrote:
> On Tue, May 28, 2019 at 01:37:50PM -0400, Waiman Long wrote:
>> On 5/28/19 1:08 PM, Vladimir Davydov wrote:
>>>>  static void flush_memcg_workqueue(struct kmem_cache *s)
>>>>  {
>>>> +	/*
>>>> +	 * memcg_params.dying is synchronized using slab_mutex AND
>>>> +	 * memcg_kmem_wq_lock spinlock, because it's not always
>>>> +	 * possible to grab slab_mutex.
>>>> +	 */
>>>>  	mutex_lock(&slab_mutex);
>>>> +	spin_lock(&memcg_kmem_wq_lock);
>>>>  	s->memcg_params.dying = true;
>>>> +	spin_unlock(&memcg_kmem_wq_lock);
>>> I would completely switch from the mutex to the new spin lock -
>>> acquiring them both looks weird.
>>>
>>>>  	mutex_unlock(&slab_mutex);
>>>>  
>>>>  	/*
>> There are places where the slab_mutex is held and sleeping functions
>> like kvzalloc() are called. I understand that taking both mutex and
>> spinlocks look ugly, but converting all the slab_mutex critical sections
>> to spinlock critical sections will be a major undertaking by itself. So
>> I would suggest leaving that for now.
> I didn't mean that. I meant taking spin_lock wherever we need to access
> the 'dying' flag, even if slab_mutex is held. So that we don't need to
> take mutex_lock in flush_memcg_workqueue, where it's used solely for
> 'dying' synchronization.

OK, that makes sense. Thanks for the clarification.

Cheers,
Longman

