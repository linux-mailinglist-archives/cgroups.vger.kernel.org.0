Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5E46F956
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 03:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhLJCu6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Dec 2021 21:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236158AbhLJCu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Dec 2021 21:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639104443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NBrZb9MWEkfnRCq35Z7md/5O5MZ6n/FZXnIl859Do4=;
        b=ZhDrkIVOqPCgXlN54J8vttrDDBUHitaonxwh+eG/oVKJbv7yyM8jvqH56YlGwGDCxHEkhO
        ecUNOq9/6QHyBJUDfzI3wDi0fp5RKW1QKudlbIgIzEZh9v2SXavjfgbSRnd67qm7FpffQS
        NSAtUXtO06TrpATKsMe8JKV4rV6zwCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-GZiMF25ONFOVVsm1hljH-w-1; Thu, 09 Dec 2021 21:47:20 -0500
X-MC-Unique: GZiMF25ONFOVVsm1hljH-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60F48102C84E;
        Fri, 10 Dec 2021 02:47:18 +0000 (UTC)
Received: from [10.22.32.131] (unknown [10.22.32.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86BD55D740;
        Fri, 10 Dec 2021 02:47:17 +0000 (UTC)
Message-ID: <3c06c8b3-c6ed-50c5-79ac-21982a10d417@redhat.com>
Date:   Thu, 9 Dec 2021 21:47:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211210020632.150769-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211210020632.150769-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/9/21 21:06, Waiman Long wrote:
> Direct calls to local_irq_{save/restore}() and preempt_{enable/disable}()
> are not appropriate for PREEMPT_RT. To provide better PREEMPT_RT support,
> change local_irq_{save/restore}() to local_lock_irq{save/restore}() and
> add a local_lock_t to struct memcg_stock_pcp.
>
> Also disable the task and interrupt context optimization for obj_stock as
> there will be no performance gain in the case of PREEMPT_RT. In this case,
> task obj_stock will be there but remain unused.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   mm/memcontrol.c | 41 ++++++++++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 19 deletions(-)

Sorry, this doesn't apply to linux-next as it conflicts with a previous 
patch that I sent out. Will send out a v2 soon.

-Longman

