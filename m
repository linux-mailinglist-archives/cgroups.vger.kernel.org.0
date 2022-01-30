Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19434A3809
	for <lists+cgroups@lfdr.de>; Sun, 30 Jan 2022 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiA3SXB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 13:23:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347090AbiA3SXA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 13:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643566980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk6jWVv8m8Aoa9sIEtk8sb+YK7vTEczGSdx1RJXY09g=;
        b=WlHSgfLo2Y7/aJ9KaTIfl3K6COuj5fWWmx1oPyFyTzJZN8VQpPuLUaAF7bCMEVuuN8rZ5h
        Wia2oYVXoLeVwdBpkTinxf9OIfKdOlhigQEnOWE9tKSC6UMc8yphgG9yQgmsx4UpESL+Xg
        oxNv1lFQ/9ZOlemHiJFeKxqoVeUZksw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-xoX3Gk22OCmgYW_CPl3s8Q-1; Sun, 30 Jan 2022 13:22:54 -0500
X-MC-Unique: xoX3Gk22OCmgYW_CPl3s8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF20E81424E;
        Sun, 30 Jan 2022 18:22:52 +0000 (UTC)
Received: from [10.22.16.114] (unknown [10.22.16.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B336C7E12C;
        Sun, 30 Jan 2022 18:22:46 +0000 (UTC)
Message-ID: <82c99093-e44b-7fac-14ab-9e8392d107ea@redhat.com>
Date:   Sun, 30 Jan 2022 13:22:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com> <YfYxJR7ugv83ywAb@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfYxJR7ugv83ywAb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/30/22 01:33, Mike Rapoport wrote:
> On Sat, Jan 29, 2022 at 03:53:15PM -0500, Waiman Long wrote:
>> It was found that a number of offlined memcgs were not freed because
>> they were pinned by some charged pages that were present. Even "echo
>> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
>> offlined but not freed memcgs tend to increase in number over time with
>> the side effect that percpu memory consumption as shown in /proc/meminfo
>> also increases over time.
>>
>> In order to find out more information about those pages that pin
>> offlined memcgs, the page_owner feature is extended to dump memory
>> cgroup information especially whether the cgroup is offlined or not.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/page_owner.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 28dac73e0542..8dc5cd0fa227 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/migrate.h>
>>   #include <linux/stackdepot.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/memcontrol.h>
>>   #include <linux/sched/clock.h>
>>   
>>   #include "internal.h"
>> @@ -331,6 +332,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   		depot_stack_handle_t handle)
>>   {
>>   	int ret, pageblock_mt, page_mt;
>> +	unsigned long __maybe_unused memcg_data;
>>   	char *kbuf;
>>   
>>   	count = min_t(size_t, count, PAGE_SIZE);
>> @@ -365,6 +367,35 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   			migrate_reason_names[page_owner->last_migrate_reason]);
>>   	}
>>   
>> +#ifdef CONFIG_MEMCG
> Can we put all this along with the declaration of memcg_data in a helper
> function please?
>
Sure. Will post another version with that change.

Cheers,
Longman

