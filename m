Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D483E9785
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhHKSTd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 14:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230391AbhHKSTd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 14:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628705949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANzdLIOaIJbxnr8pVh5jQkoQ6kMweZt9tE4el1kTVKE=;
        b=hg9Ft9g1H9MW9ZFx7rwb9ujgQhABKOpaut+nljDABZBRwl0vhNnv2u3dGXEnzjOLqK03vQ
        E44YUOERFOMhsH230dqgUIbP/YtDXHXRYrl3w3X5uO7o5Se+xpkLLLZoH1tfsuTMc3vyKS
        gNMKyZvssvMhZ6J+53BuV9+wwxKiRLk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Hc5tKE7BNyy9BuXNHRHG0A-1; Wed, 11 Aug 2021 14:19:07 -0400
X-MC-Unique: Hc5tKE7BNyy9BuXNHRHG0A-1
Received: by mail-qv1-f70.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so1748264qvt.20
        for <cgroups@vger.kernel.org>; Wed, 11 Aug 2021 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ANzdLIOaIJbxnr8pVh5jQkoQ6kMweZt9tE4el1kTVKE=;
        b=nAPJoQxda31nDuJIXlTLH/adrWkIwixIMn0V4J1EtHYmhHrSQ4/Cxj4izWGRI9rVkr
         Q3xie2fEqx1S1+iw1RmNLqSRjrdGxHHFju60eZ7i4hmGmzt37mXori1u3MA7Q6SRimqD
         TK0A1pdzxr85T1Ezfm0z13o9QKXSm0wG2CjQjjEIOg27Zs+34NxC2mDTaASjhK/DAlJe
         ODlne9ieTpk04w0r0AVSEpqvW5zhBJsgt0UWNpXqneeaCijZBJAHROHWwAAm6BVS7xVl
         fktNMD0sqvI/mbEscJWyT2KJQu3o27ICb+LJ+KuRVryIpTdquac2j6QDazx3IydTK2rs
         LmoA==
X-Gm-Message-State: AOAM531Uz/0IIatFC27gyDcm/gcTdveSk2Fkc0o7YxKxPGlqmRHRvsST
        v9KzUA7TuNj+JvTbgr7tpb/tEorSYT8gbYJT8qg6b8Y1LsVNvgVmngV6XwC7/LJ9ywWkn94eUqi
        LPYAu9M7n5DSj13x8hA==
X-Received: by 2002:a05:620a:b4f:: with SMTP id x15mr326532qkg.436.1628705946986;
        Wed, 11 Aug 2021 11:19:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyItQRa+ugH8/MfKjbw8BhyNTooZz1XicdSsFFEontpDk1YQ4tO1FOw+vSvhWCsxBi7gnVOSQ==
X-Received: by 2002:a05:620a:b4f:: with SMTP id x15mr326513qkg.436.1628705946825;
        Wed, 11 Aug 2021 11:19:06 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m197sm13035877qke.54.2021.08.11.11.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:19:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-6-longman@redhat.com>
 <YRQTy7eo5jOlHTc6@slm.duckdns.org>
Message-ID: <26180e1d-1fa9-f175-66f8-297cf0685a11@redhat.com>
Date:   Wed, 11 Aug 2021 14:19:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQTy7eo5jOlHTc6@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/11/21 2:15 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, Aug 10, 2021 at 11:06:06PM -0400, Waiman Long wrote:
>> +	Poll and inotify events are triggered whenever the state
>> +	of "cpuset.cpus.partition" changes.  That includes changes
>> +	caused by write to "cpuset.cpus.partition" and cpu hotplug.
>> +	This will allow a user space agent to monitor changes caused
>> +	by hotplug events.
> It might be useful to emphasize that this is the primary mechanism to
> signify errors and thus should always be monitored.

Sure, will do that in the next version.

Cheers,
Longman

