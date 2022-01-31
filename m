Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664DC4A4F1F
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 20:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358975AbiAaTBg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 14:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244293AbiAaTBf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 14:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643655695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxAwEA9Ms4jKsy8aU7wpsx4G3K1ATTggQYOqNKinqIQ=;
        b=bRvqa2oyRrg1muy2A3fct8z9mQg5YKEVdOo678W9fMhUh1ggJuW+d1PNeoMji/8/JWN/ho
        hpn3ERFMeC23C7+A1kf3iuGuubSHD70CA2HRaEATjABF8QApGd5026KQE33RKCU02yi1xn
        8NV3cboLDzYxpRLTCPA6yZo0iut8NU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-FOuYN5FjP8adVL3IftXX9w-1; Mon, 31 Jan 2022 14:01:31 -0500
X-MC-Unique: FOuYN5FjP8adVL3IftXX9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D12D8189FA;
        Mon, 31 Jan 2022 19:01:29 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CC8360843;
        Mon, 31 Jan 2022 19:01:19 +0000 (UTC)
Message-ID: <c781641d-e5dc-f79b-a9c0-aa91ab228316@redhat.com>
Date:   Mon, 31 Jan 2022 14:01:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
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
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 04:38, Michal Hocko wrote:
> On Sat 29-01-22 15:53:15, Waiman Long wrote:
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
> It is not really clear to me how this is supposed to be used. Are you
> really dumping all the pages in the system to find out offline memcgs?
> That looks rather clumsy to me. I am not against adding memcg
> information to the page owner output. That can be useful in other
> contexts.

I am just piggybacking on top of the existing page_owner tool to provide 
information for me to find out what pages are pinning the dead memcgs. 
page_owner is a debugging tool that is not turned on by default. We do 
have to add a kernel parameter and  rebooting the system to use that, 
but that is pretty easy to do once we have a reproducer to reproduce the 
problem.

Cheers,
Longman

