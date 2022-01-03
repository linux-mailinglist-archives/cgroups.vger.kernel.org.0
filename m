Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193A24833E1
	for <lists+cgroups@lfdr.de>; Mon,  3 Jan 2022 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiACPEi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jan 2022 10:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233710AbiACPEi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jan 2022 10:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641222277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/azdTXQpdDt54c/qGW2Q0f96DDwXW7aJM/qGAElD6uU=;
        b=X++g/GGfHc4+bLW6NZQEj6JQ/8Tb3Hy5ABjm55DJbhCR3yx49Dy2tfhBdc5AI2BnBT7lfP
        jvVdGra+t6TvpAwVwuGct32M5pVpXDX8AxPDDz6zFHQPSsdg1YvoxfyBaL6836ynudptkL
        BIwMS55HTPK+lRZJKRBe6kIYa4cDIcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-TMjiKpjAPhGubCgj3Rz6nw-1; Mon, 03 Jan 2022 10:04:34 -0500
X-MC-Unique: TMjiKpjAPhGubCgj3Rz6nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 032E91023F4D;
        Mon,  3 Jan 2022 15:04:32 +0000 (UTC)
Received: from [10.22.9.34] (unknown [10.22.9.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2862BCD9;
        Mon,  3 Jan 2022 15:04:30 +0000 (UTC)
Message-ID: <df637005-6c72-a1c6-c6b9-70f81f74884d@redhat.com>
Date:   Mon, 3 Jan 2022 10:04:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 3/3] mm/memcg: Allow the task_obj optimization only on
 non-PREEMPTIBLE kernels.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-4-bigeasy@linutronix.de>
 <f6bb93c8-3940-6141-d0e0-50144549a4f5@redhat.com>
 <YdML2zaU17clEZgt@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YdML2zaU17clEZgt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 1/3/22 09:44, Sebastian Andrzej Siewior wrote:
> On 2021-12-23 16:48:41 [-0500], Waiman Long wrote:
>> On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
>>> Based on my understanding the optimisation with task_obj for in_task()
>>> mask sense on non-PREEMPTIBLE kernels because preempt_disable()/enable()
>>> is optimized away. This could be then restricted to !CONFIG_PREEMPTION kernel
>>> instead to only PREEMPT_RT.
>>> With CONFIG_PREEMPT_DYNAMIC a non-PREEMPTIBLE kernel can also be
>>> configured but these kernels always have preempt_disable()/enable()
>>> present so it probably makes no sense here for the optimisation.
>>>
>>> Restrict the optimisation to !CONFIG_PREEMPTION kernels.
>>>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> If PREEMPT_DYNAMIC is selected, PREEMPTION will also be set. My
>> understanding is that some distros are going to use PREEMPT_DYNAMIC, but
>> default to PREEMPT_VOLUNTARY. So I don't believe it is a good idea to
>> disable the optimization based on PREEMPTION alone.
> So there is a benefit to this even if preempt_disable() is not optimized
> away? My understanding was that this depends on preempt_disable() being
> optimized away.
> Is there something you recommend as a benchmark where I could get some
> numbers?

In the case of PREEMPT_DYNAMIC, it depends on the default setting which 
is used by most users. I will support disabling the optimization if 
defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT), just not by 
CONFIG_)PREEMPTION alone.

As for microbenchmark, something that makes a lot of calls to malloc() 
or related allocations can be used.

Cheers,
Longman

