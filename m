Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C844AE118
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385055AbiBHSlS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 13:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385074AbiBHSlR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 13:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED3EDC06174F
        for <cgroups@vger.kernel.org>; Tue,  8 Feb 2022 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644345676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xML1xNkIw3e0hTYk74bi0fSg0bcnbMZm5u6L4MPv8BA=;
        b=aAcdPOMiOreeH3mPfBRSBK2A2oju9QjKkENlozUO+2Z0iXqTmydlcVzu3R4xXKCgemNK1a
        gQuXJxS16edU2v+OKJrbdbmBsUYh+npDhY1jIrJzrzjJfUh7STbdbBobAiTO0yAIL1IAwM
        KhEP52V4xGkeiYQIWhhc5bb7Rm/q3Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-4DGKpYoYNeCJaX4uVE-ldw-1; Tue, 08 Feb 2022 13:41:11 -0500
X-MC-Unique: 4DGKpYoYNeCJaX4uVE-ldw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B42101F003;
        Tue,  8 Feb 2022 18:41:02 +0000 (UTC)
Received: from [10.22.35.8] (unknown [10.22.35.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F62710A3945;
        Tue,  8 Feb 2022 18:40:58 +0000 (UTC)
Message-ID: <e897adca-168e-13db-8001-4afbef3aa648@redhat.com>
Date:   Tue, 8 Feb 2022 13:40:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 3/4] mm/page_owner: Print memcg information
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220208000532.1054311-1-longman@redhat.com>
 <20220208000532.1054311-4-longman@redhat.com>
 <YgJeWth50eP9L0PK@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YgJeWth50eP9L0PK@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/8/22 07:13, Michal Hocko wrote:
> On Mon 07-02-22 19:05:31, Waiman Long wrote:
>> It was found that a number of dying memcgs were not freed because
>> they were pinned by some charged pages that were present. Even "echo 1 >
>> /proc/sys/vm/drop_caches" wasn't able to free those pages. These dying
>> but not freed memcgs tend to increase in number over time with the side
>> effect that percpu memory consumption as shown in /proc/meminfo also
>> increases over time.
> I still believe that this is very suboptimal way to debug offline memcgs
> but memcg information can be useful in other contexts and it doesn't
> cost us anything except for an additional output so I am fine with this.
I am planning to have a follow-up patch to add a new debugfs file for 
just printing page information associated with dying memcgs only. It 
will be based on the existing page_owner code, though. So I need to get 
this patch in first.
>   
>> In order to find out more information about those pages that pin
>> dying memcgs, the page_owner feature is extended to print memory
>> cgroup information especially whether the cgroup is dying or not.
>> RCU read lock is taken when memcg is being accessed to make sure
>> that it won't be freed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> Acked-by: Roman Gushchin <guro@fb.com>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> With few comments/questions below.
>
>> ---
>>   mm/page_owner.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 28dac73e0542..d4c311455753 100644
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
>> @@ -325,6 +326,47 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>>   	seq_putc(m, '\n');
>>   }
>>   
>> +/*
>> + * Looking for memcg information and print it out
>> + */
> I am not sure this is particularly useful comment.
Right, I can remove that.
>
>> +static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
>> +					 struct page *page)
>> +{
>> +#ifdef CONFIG_MEMCG
>> +	unsigned long memcg_data;
>> +	struct mem_cgroup *memcg;
>> +	bool dying;
>> +
>> +	rcu_read_lock();
>> +	memcg_data = READ_ONCE(page->memcg_data);
>> +	if (!memcg_data)
>> +		goto out_unlock;
>> +
>> +	if (memcg_data & MEMCG_DATA_OBJCGS)
>> +		ret += scnprintf(kbuf + ret, count - ret,
>> +				"Slab cache page\n");
>> +
>> +	memcg = page_memcg_check(page);
>> +	if (!memcg)
>> +		goto out_unlock;
>> +
>> +	dying = (memcg->css.flags & CSS_DYING);
> Is there any specific reason why you haven't used mem_cgroup_online?
Not really. However, I think checking for CSS_DYING makes more sense now 
that I using the term "dying".
>
>> +	ret += scnprintf(kbuf + ret, count - ret,
>> +			"Charged %sto %smemcg ",
>> +			PageMemcgKmem(page) ? "(via objcg) " : "",
>> +			dying ? "dying " : "");
>> +
>> +	/* Write cgroup name directly into kbuf */
>> +	cgroup_name(memcg->css.cgroup, kbuf + ret, count - ret);
>> +	ret += strlen(kbuf + ret);
> cgroup_name should return the length of the path added to the buffer.
I realized that after I sent out the patch. I will remove te redundant 
strlen() in a future update.
>
>> +	ret += scnprintf(kbuf + ret, count - ret, "\n");
> I do not see any overflow prevention here. I believe you really need to
> check ret >= count after each scnprintf/cgroup_name.

As you have realized, the beauty of using scnprintf() is to not needing 
an overflow check after each invocation.

Cheers,
Longman

