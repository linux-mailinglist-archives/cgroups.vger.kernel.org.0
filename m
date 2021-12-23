Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F291247E931
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 22:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhLWVsv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Dec 2021 16:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231576AbhLWVsv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Dec 2021 16:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640296130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aOo+PkY5S4h+Nfs7B8aAFLKqPmDvtOJfX8JOA95JqA=;
        b=WzHw8uXVCFI0EEXgSUYeXPoomqlPWLFfFpZi8Ez4aX1a39pGpg4TNhTcv/JudN/CMlEkg9
        a28WyYraaZd2PfwhoXqGTWSpS/Q1pm5oBIxWB5WYJ+lJQ5iE5m0B7cA5anf8uINTgiVWEB
        xgHZyjDKEKpREhc3QYR8U5HYhHUKdlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-7l4heniYOzabyI4fv3Kasw-1; Thu, 23 Dec 2021 16:48:45 -0500
X-MC-Unique: 7l4heniYOzabyI4fv3Kasw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64AA31006AA0;
        Thu, 23 Dec 2021 21:48:43 +0000 (UTC)
Received: from [10.22.16.147] (unknown [10.22.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 474B36E1EE;
        Thu, 23 Dec 2021 21:48:42 +0000 (UTC)
Message-ID: <f6bb93c8-3940-6141-d0e0-50144549a4f5@redhat.com>
Date:   Thu, 23 Dec 2021 16:48:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 3/3] mm/memcg: Allow the task_obj optimization only on
 non-PREEMPTIBLE kernels.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-4-bigeasy@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211222114111.2206248-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
> Based on my understanding the optimisation with task_obj for in_task()
> mask sense on non-PREEMPTIBLE kernels because preempt_disable()/enable()
> is optimized away. This could be then restricted to !CONFIG_PREEMPTION kernel
> instead to only PREEMPT_RT.
> With CONFIG_PREEMPT_DYNAMIC a non-PREEMPTIBLE kernel can also be
> configured but these kernels always have preempt_disable()/enable()
> present so it probably makes no sense here for the optimisation.
>
> Restrict the optimisation to !CONFIG_PREEMPTION kernels.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If PREEMPT_DYNAMIC is selected, PREEMPTION will also be set. My 
understanding is that some distros are going to use PREEMPT_DYNAMIC, but 
default to PREEMPT_VOLUNTARY. So I don't believe it is a good idea to 
disable the optimization based on PREEMPTION alone.

Regards,
Longman

