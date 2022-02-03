Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EC4A8C22
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 20:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiBCTEU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 14:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237541AbiBCTEU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 14:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643915059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WFk5VazJGj78aF3vcRFOwWn7//j5v/p/zsICay1c+U=;
        b=QnmwVovOe8JgvKk//Z1TR+qKjK9KVJ14DqYScYfV5FSIL9ikrAvXBikxsH8kFiU0rmGaYa
        PvbWIrICYM1J9navU9T3ojLdQBi085agBt/BVVfhv0Z5RCcwDmMu9hcgYVnD83UT7vxlQq
        uwMhjmLM4Fxz6jbU8hkgz5UR5CXWTQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-1_xSlXEUNfiENHGx0Rm0IQ-1; Thu, 03 Feb 2022 14:04:18 -0500
X-MC-Unique: 1_xSlXEUNfiENHGx0Rm0IQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A074518B613D;
        Thu,  3 Feb 2022 19:04:15 +0000 (UTC)
Received: from [10.22.8.80] (unknown [10.22.8.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 747A75D6BA;
        Thu,  3 Feb 2022 19:03:59 +0000 (UTC)
Message-ID: <3f042edb-3769-afea-17a7-899578cd5c69@redhat.com>
Date:   Thu, 3 Feb 2022 14:03:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/4] mm/page_owner: Print memcg information
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
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-4-longman@redhat.com>
 <YfvOp5VXrxy9IW1w@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfvOp5VXrxy9IW1w@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/3/22 07:46, Michal Hocko wrote:
> On Wed 02-02-22 15:30:35, Waiman Long wrote:
> [...]
>> +#ifdef CONFIG_MEMCG
>> +	unsigned long memcg_data;
>> +	struct mem_cgroup *memcg;
>> +	bool online;
>> +	char name[80];
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
>> +	online = (memcg->css.flags & CSS_ONLINE);
>> +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> Is there any specific reason to use another buffer allocated on the
> stack? Also 80B seems too short to cover NAME_MAX.
>
> Nothing else jumped at me.

I suppose we can print directly into kbuf with cgroup_name(), but using 
a separate buffer is easier to read and understand. 79 characters should 
be enough for most cgroup names. Some auto-generated names with some 
kind of embedded uuids may be longer than that, but the random sequence 
of hex digits that may be missing do not convey much information for 
identification purpose. We can always increase the buffer length later 
if it turns out to be an issue.

Cheers,
Longman

