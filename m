Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF534A617C
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 17:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiBAQla (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 11:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241164AbiBAQl1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 11:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643733687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PC8NZ8lG/hbKxyQngU3kWuHlJ5Tl5ht+lJl5+tMvXcM=;
        b=B7hNIJLRf1rknpzQE3GYo2p6w/JVO5Gl7gLZ355ox5uncd+RTUsnfsqQsWhXMVx6gUlYQ8
        LTGaiG5+tufi9/5kYjuSgTGAS9Kq/2/Vw6gAMXKAyQ85dtabgs6Y76sGjRcd3VdKzXaBbu
        qvsU9Jr/tlMahM7HCVb3E1Q3SwH4o04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-XeNOkZiYNrC9gA6ixD_JFQ-1; Tue, 01 Feb 2022 11:41:24 -0500
X-MC-Unique: XeNOkZiYNrC9gA6ixD_JFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E95D41898292;
        Tue,  1 Feb 2022 16:41:21 +0000 (UTC)
Received: from [10.22.19.61] (unknown [10.22.19.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F14C410A4B53;
        Tue,  1 Feb 2022 16:41:19 +0000 (UTC)
Message-ID: <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
Date:   Tue, 1 Feb 2022 11:41:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
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
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz> <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
 <12686956-612d-d89b-5641-470d5e913090@redhat.com>
 <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2/1/22 05:49, Michal Hocko wrote:
> On Mon 31-01-22 13:38:28, Waiman Long wrote:
> [...]
>> Of course, it is also possible to have a debugfs interface to list those
>> dead memcg information, displaying more information about the page that pins
>> the memcg will be hard without using the page owner tool.
> Yes, you will need page owner or hook into the kernel by other means
> (like already mentioned drgn). The question is whether scanning all
> existing pages to get that information is the best we can offer.
The page_owner tool records the page information at allocation time. 
There are some slight performance overhead, but it is the memory 
overhead that is the major drawback of this approach as we need one 
page_owner structure for each physical page. Page scanning is only done 
when users read the page_owner debugfs file. Yes, I agree that scanning 
all the pages is not the most efficient way to get these dead memcg 
information, but it is what the page_owner tool does. I would argue that 
this is the most efficient coding-wise to get this information.
>> Keeping track of
>> the list of dead memcg's may also have some runtime overhead.
> Could you be more specific? Offlined memcgs are still part of the
> hierarchy IIRC. So it shouldn't be much more than iterating the whole
> cgroup tree and collect interesting data about dead cgroups.

What I mean is that without piggybacking on top of page_owner, we will 
to add a lot more code to collect and display those information which 
may have some overhead of its own.

Cheers,
Longman

