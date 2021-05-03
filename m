Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5C371682
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhECOVP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 10:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhECOVP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 May 2021 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620051621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cba/OYMboyUL2DtaynOpgQ1aSITP9mKlivymjF+E18U=;
        b=UIlH1z66YclXqc7gb/oqkfT7ByDetsN+PhHsWQDy8kFJDVtHsmNwlJqWCSRN/csWOfomxQ
        8vS7S+zrmGiSghqVnlOyVRoJNAtZLe8U9DwOz5YWZHpPjeOeCjG9jlLTq218CLeerP+o4G
        htGScNxIP5PLZU7hK/VBbLKk21CfDvs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-EnYu5eAMPy-pQCYiszZPNw-1; Mon, 03 May 2021 10:20:20 -0400
X-MC-Unique: EnYu5eAMPy-pQCYiszZPNw-1
Received: by mail-qt1-f198.google.com with SMTP id r20-20020ac85c940000b02901bac34fa2eeso1497810qta.11
        for <cgroups@vger.kernel.org>; Mon, 03 May 2021 07:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cba/OYMboyUL2DtaynOpgQ1aSITP9mKlivymjF+E18U=;
        b=UDmWsXvdLvTHmuc0JlB+JoyQGe9+en+r44i/AQJn55Ew3LVB8XpWWiUjAHkI9hdJl3
         s6bOqmGsNJynJOvqCOvWgGI3SgNR8GI0r3g8g8j8pDD9JUKjY4vgdX5NBgvgWv9L9eBW
         QHb81x2lMmGInzMNp42IQ6iPlGpWEUrPW4QvRQIlz8DvQglCV2DDRCPspOOUjI3VtwMj
         UiCtJdKoKrYO+/4chlWuLgxl6D1fGzwWVf2UidCvcDJWicpmrNQleyPjIq5Ztdqqt4rS
         t5fXtyngmP3Ac0sN1a7sipnhx824xPmTkC54hG0DXjo5Q8e7MSGCoPMHhbFAS3Ac7tCs
         f6EQ==
X-Gm-Message-State: AOAM532lZ8LisC2BYSTwpAoowC5Ri29LHL1M8PvhYtmyypfz3qkogn3t
        QXr7eTGcaOFGoc4USOty5WId2X8HgWhrSYOVhjiDw4/vrS5aqHOby+MbTLNzRcaFfTVvnlAhHSl
        3Cs9RPLHTU4tfJLkBwQ==
X-Received: by 2002:a05:622a:15c6:: with SMTP id d6mr16903560qty.172.1620051619877;
        Mon, 03 May 2021 07:20:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRarG4Zi4peWlqgXlLk5yiZcgOvrdkvZtDmZ1mwnE32A43M0N16VhKdpPc8PH6nbBYcwoXwQ==
X-Received: by 2002:a05:622a:15c6:: with SMTP id d6mr16903539qty.172.1620051619684;
        Mon, 03 May 2021 07:20:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v10sm8614891qtf.39.2021.05.03.07.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:20:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: Don't create unfreeable slab
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210502180755.445-1-longman@redhat.com>
 <20210502180755.445-2-longman@redhat.com>
 <699e5ac8-9044-d664-f73f-778fe72fd09b@suse.cz>
Message-ID: <4c90cf79-9c61-8964-a6fd-2da087893339@redhat.com>
Date:   Mon, 3 May 2021 10:20:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <699e5ac8-9044-d664-f73f-778fe72fd09b@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/3/21 8:22 AM, Vlastimil Babka wrote:
> On 5/2/21 8:07 PM, Waiman Long wrote:
>> The obj_cgroup array (memcg_data) embedded in the page structure is
>> allocated at the first instance an accounted memory allocation happens.
>> With the right size object, it is possible that the allocated obj_cgroup
>> array comes from the same slab that requires memory accounting. If this
>> happens, the slab will never become empty again as there is at least one
>> object left (the obj_cgroup array) in the slab.
>>
>> With instructmentation code added to detect this situation, I got 76
>> hits on the kmalloc-192 slab when booting up a test kernel on a VM.
>> So this can really happen.
>>
>> To avoid the creation of these unfreeable slabs, a check is added to
>> memcg_alloc_page_obj_cgroups() to detect that and double the size
>> of the array in case it happens to make sure that it comes from a
>> different kmemcache.
>>
>> This change, however, does not completely eliminate the presence
>> of unfreeable slabs which can still happen if a circular obj_cgroup
>> array dependency is formed.
> Hm this looks like only a half fix then.
> I'm afraid the proper fix is for kmemcg to create own set of caches for the
> arrays. It would also solve the recursive kfree() issue.

Right, this is a possible solution. However, the objcg pointers array 
should need that much memory. Creating its own set of kmemcaches may 
seem like an overkill.

Cheers,
Longman

