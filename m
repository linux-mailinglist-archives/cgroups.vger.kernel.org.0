Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9123D7EF6
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhG0URC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 16:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhG0URB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 16:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627417020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByUPLbiVuvdvoapeEFXQAcFKJj/8lLrwBdwnV9vgH+s=;
        b=iIPYqXhCxCQ/tI2aYQFlODE1F3UluJwhMLsCtJIL6dxTpUc6duCZErA/0NMrf/FQ9v6VYQ
        kVXxAUsNLVyGRANNgGGwZuA/kcpiszOqAO1LQ4eAMpIY3IBJLke102HomkElsJgcSwK3U4
        9oeGI14kIdPEi0z3L79v7iom4+LBXQw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-ldgkFSIfMmWOr7mscJ9BHA-1; Tue, 27 Jul 2021 16:16:59 -0400
X-MC-Unique: ldgkFSIfMmWOr7mscJ9BHA-1
Received: by mail-qk1-f198.google.com with SMTP id h5-20020a05620a0525b02903b861bec838so1661qkh.7
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 13:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ByUPLbiVuvdvoapeEFXQAcFKJj/8lLrwBdwnV9vgH+s=;
        b=TjEGgk6WUdDf8vbz/OyCR1jlhPUOLx7q9Ka0lT0QOk2Y6iCzYa89LpdNA95tL3vmbT
         F03ErYjfdsir4d7AjmZdTRyQLS31fE02A7UowlvGlcMKCymsHyvwwjnbCtotvj6lu9ql
         UI/RlI8T0cKBfOrQPW1bQMDn9TVKRu5ILnQC0HK9Nt+9PJDyXXzPY8NnI+x2LoEOvBP7
         NsHgiBDG2eYO54cdGlW+pZ36rQMYj5v/hFNPus2orfaq23mvoRQezR/j4uiY1Izr7Ts5
         aGD9w5S7s4rZ9MfPPy0uLPVV7rRWc/C/cYkhlCRQJfcOEizNk70oP7qOQuC8nwReKyeJ
         /rEw==
X-Gm-Message-State: AOAM532jpOiUaTMsoa0sRDye7xrbuvwjy/dpDH8pvKr1R/H1yriryKG4
        fWBpAU/JnTSaySX0R0dl6wS0O+Y0W30s0TwicNlKsJsbOUiRPfyMz/VkH1++ToKwqWcWM1ie8ig
        AwSDaGatEHHAQYb1xIw==
X-Received: by 2002:a05:620a:318e:: with SMTP id bi14mr21424398qkb.176.1627417018993;
        Tue, 27 Jul 2021 13:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkKaLGiPqMLIncbtDqJyUsjY34972lfs0JJ1TJHQSJbPBkHyyv8W+CXGcrtPiJOkaTxPBjIQ==
X-Received: by 2002:a05:620a:318e:: with SMTP id bi14mr21424373qkb.176.1627417018811;
        Tue, 27 Jul 2021 13:16:58 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id g10sm1910136qtp.67.2021.07.27.13.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:16:58 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/9] cgroup/cpuset: Fix a partition bug with hotplug
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
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-3-longman@redhat.com>
 <YP8+ajTnvrha+0O6@mtj.duckdns.org>
Message-ID: <2173a00b-504a-1932-877d-d26775e4775c@redhat.com>
Date:   Tue, 27 Jul 2021 16:16:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP8+ajTnvrha+0O6@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/26/21 6:59 PM, Tejun Heo wrote:
> On Tue, Jul 20, 2021 at 10:18:27AM -0400, Waiman Long wrote:
>> In cpuset_hotplug_workfn(), the detection of whether the cpu list
>> has been changed is done by comparing the effective cpus of the top
>> cpuset with the cpu_active_mask. However, in the rare case that just
>> all the CPUs in the subparts_cpus are offlined, the detection fails
>> and the partition states are not updated correctly. Fix it by forcing
>> the cpus_updated flag to true in this particular case.
>>
>> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Applied to cgroup/for-5.15 w/ a minor update to the comment (I dropped
> "just" before "all". It read weird to me.)
>
> Thanks.
>
Thanks for fixing the wording.

Cheers,
Longman

