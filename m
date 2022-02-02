Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783A4A75C8
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiBBQ3n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 11:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbiBBQ3n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 11:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643819382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0ow7OhvPHO62CtY/qyYiL8XWSa1Avspao6Gho1V2I8=;
        b=Jaa8LDqcfUs/kitD42arp04Mo5j9ccJ8wGFMTD3Ds2FGssn6fUVWV5voAMNB6ZZVj1+VvE
        g8rmZXRESVvMi/R+gq3IBFFlEDoJYMtmo+uzqhB4rEtIq4YeGA3VReDWENlw9gjrHSs6nn
        eOTOsd5i7t7oDd44zb5KWoSfjMQFMlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-HvNJrQYJPbiuC6PRN1-sag-1; Wed, 02 Feb 2022 11:29:41 -0500
X-MC-Unique: HvNJrQYJPbiuC6PRN1-sag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D958144E0;
        Wed,  2 Feb 2022 16:29:38 +0000 (UTC)
Received: from [10.22.34.202] (unknown [10.22.34.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1595C7D498;
        Wed,  2 Feb 2022 16:29:36 +0000 (UTC)
Message-ID: <cfde9038-8887-ea8b-b0f8-f950e85a54af@redhat.com>
Date:   Wed, 2 Feb 2022 11:29:36 -0500
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
 <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
 <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/22 03:57, Michal Hocko wrote:
> On Tue 01-02-22 11:41:19, Waiman Long wrote:
>> On 2/1/22 05:49, Michal Hocko wrote:
> [...]
>>> Could you be more specific? Offlined memcgs are still part of the
>>> hierarchy IIRC. So it shouldn't be much more than iterating the whole
>>> cgroup tree and collect interesting data about dead cgroups.
>> What I mean is that without piggybacking on top of page_owner, we will to
>> add a lot more code to collect and display those information which may have
>> some overhead of its own.
> Yes, there is nothing like a free lunch. Page owner is certainly a tool
> that can be used. My main concern is that this tool doesn't really
> scale on large machines with a lots of memory. It will provide a very
> detailed information but I am not sure this is particularly helpful to
> most admins (why should people process tons of allocation backtraces in
> the first place). Wouldn't it be sufficient to have per dead memcg stats
> to see where the memory sits?
>
> Accumulated offline memcgs is something that bothers more people and I
> am really wondering whether we can do more for those people to evaluate
> the current state.

You won't get the stack backtrace information without page_owner 
enabled. I believe that is a helpful piece of information. I don't 
expect page_owner to be enabled by default on production system because 
of its memory overhead.

I believe you can actually see the number of memory cgroups present by 
looking at the /proc/cgroups file. Though, you don't know how many of 
them are offline memcgs. So if one suspect that there are a large number 
of offline memcgs, one can set up a test environment with page_owner 
enabled for further analysis.

Cheers,
Longman

