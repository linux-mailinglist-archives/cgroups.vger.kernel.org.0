Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780144A8BF6
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 19:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353587AbiBCSxx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 13:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353585AbiBCSxw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 13:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643914432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9DO1jLJUL5DivNcmSp8xo0wxBcJI5YNywWCMphqcSI=;
        b=L8h3wgZvPTpUbFbRNDEeNDGCfySgy6En0LPiby1pso5XQPXlqXq+gS51hte5kSKmUf5BKq
        QcLyCCqJkHCWVGz/5D6/rk3XhKJ8R5XjyAObw6UTEJEZ8D1J5yjhg9D+BaCfeNdY95dW5N
        Ib2w9WK6inq1zPvv5j5oYe97axBAWTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-J2BTooLXNPSbyWiBLp1SPA-1; Thu, 03 Feb 2022 13:53:49 -0500
X-MC-Unique: J2BTooLXNPSbyWiBLp1SPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0AD81432F;
        Thu,  3 Feb 2022 18:53:46 +0000 (UTC)
Received: from [10.22.8.80] (unknown [10.22.8.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF03B7EFDD;
        Thu,  3 Feb 2022 18:53:10 +0000 (UTC)
Message-ID: <88619dad-6d41-6a91-a8d6-72e3aaf3575d@redhat.com>
Date:   Thu, 3 Feb 2022 13:53:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 4/4] mm/page_owner: Record task command name
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
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
 <20220131220328.622162-1-longman@redhat.com>
 <YflRjeoC0jbzArDG@dhcp22.suse.cz>
 <4ba66abe-5c6d-26a7-f11c-c3b8514bfb34@redhat.com>
 <91fb8637-6550-dc37-a95b-df7812b02b0a@suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <91fb8637-6550-dc37-a95b-df7812b02b0a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/3/22 07:10, Vlastimil Babka wrote:
> On 2/2/22 17:53, Waiman Long wrote:
>> On 2/1/22 10:28, Michal Hocko wrote:
>>> Cc Vlastimil
>>>
>>> On Mon 31-01-22 17:03:28, Waiman Long wrote:
>>>> The page_owner information currently includes the pid of the calling
>>>> task. That is useful as long as the task is still running. Otherwise,
>>>> the number is meaningless. To have more information about the allocating
>>>> tasks that had exited by the time the page_owner information is
>>>> retrieved, we need to store the command name of the task.
>>>>
>>>> Add a new comm field into page_owner structure to store the command name
>>>> and display it when the page_owner information is retrieved.
>>> I completely agree that pid is effectivelly useless (if not misleading)
>>> but is comm really telling all that much to compensate for the
>>> additional storage required for _each_ page in the system?
>> Yes, it does add an extra 16 bytes per page overhead. The command name can
>> be useful if one want to find out which userspace command is responsible for
>> a problematic page allocation. Maybe we can remove pid from page_owner to
>> save 8 bytes as you also agree that this number is not that useful.
> Pid could be used to correlate command instances (not perfectly if reuse
> happens), but command name could have a higher chance to be useful. In my
> experience the most useful were the stacktraces and gfp/order etc. anyway.
> So I wouldn't be opposed replacing pid with comm. The mild size increase
> should be acceptable, this is an opt-in feature for debugging sessions with
> known tradeoff for memory and cpu overhead for the extra info.

Thanks for the information.

I floated around dropping pid just as a possible way to reduce overall 
memory overhead. I did not do that in my patch and I am not planning to 
post any patch unless everybody agree.

Cheer,
Longman

