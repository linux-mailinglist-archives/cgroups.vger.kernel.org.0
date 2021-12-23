Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA347DDC4
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 03:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbhLWCbn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 21:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238478AbhLWCbm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 21:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640226701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndDsEl87XhT/7c03RwGZ3BUnuqirZACHRsfL75QimI4=;
        b=bbwNGcwXFMSx3M8piN8CZy1Jtfy09LSAB44oWBnJIh85iN3QYokhcUQdaMCvnW3JrMvezk
        eFFigbMQn6eJ7RKAxRFBJDWzTv712qIPD52kVKiHN8/gdBHWO1OXArNL1Jvz5yFIOyQ5Vs
        Yiq8aK0rHdT//0lRrjL0DO1fhgIXA1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-YRiRbPuwOMiy_ppxWk5ANg-1; Wed, 22 Dec 2021 21:31:40 -0500
X-MC-Unique: YRiRbPuwOMiy_ppxWk5ANg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34EA9802C91;
        Thu, 23 Dec 2021 02:31:38 +0000 (UTC)
Received: from [10.22.16.38] (unknown [10.22.16.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED5337EF56;
        Thu, 23 Dec 2021 02:31:36 +0000 (UTC)
Message-ID: <bdfc9791-4af2-f4fb-9ef5-dab1e2e3ff89@redhat.com>
Date:   Wed, 22 Dec 2021 21:31:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 1/3] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT
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
 <20211222114111.2206248-2-bigeasy@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211222114111.2206248-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
> The per-CPU counter are modified with the non-atomic modifier. The
> consistency is ensure by disabling interrupts for the update.
> This breaks on PREEMPT_RT because some sections additionally
> acquire a spinlock_t lock (which becomes sleeping and must not be
> acquired with disabled interrupts). Another problem is that
> mem_cgroup_swapout() expects to be invoked with disabled interrupts
> because the caller has to acquire a spinlock_t which is acquired with
> disabled interrupts. Since spinlock_t never disables interrupts on
> PREEMPT_RT the interrupts are never disabled at this point.
>
> The code is never called from in_irq() context on PREEMPT_RT therefore

How do you guarantee that these percpu update functions won't be called 
in in_irq() context for PREEMPT_RT? Do you think we should add a 
WARN_ON_ONCE(in_irq()) just to be sure?

Cheers,
Longman

