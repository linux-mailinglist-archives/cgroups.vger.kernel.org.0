Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34203EAD6B
	for <lists+cgroups@lfdr.de>; Fri, 13 Aug 2021 00:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhHLW4b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Aug 2021 18:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238415AbhHLW4b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Aug 2021 18:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628808965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU1jcFqEFviufW4xVur65db047ti+YmuGAqH7xi6AYA=;
        b=F227wH2m+WktspAsKmf9g5iISMBbhkgJk/S9wl769RyyzK3XLbYoL+9+2TlJz2LkPOxHgj
        Ac5CMoVLjRDuT7UB912h4ss4hPEXrDp00nuwYlVhyqUf6Y19fKoYv4+SPyyWw//gwFOl8n
        +9sR3lH2AV0ccURNa2pwU8gTpWbneFI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-P9TWu8MbPSWUJPwXHVSKog-1; Thu, 12 Aug 2021 18:56:03 -0400
X-MC-Unique: P9TWu8MbPSWUJPwXHVSKog-1
Received: by mail-qt1-f197.google.com with SMTP id o11-20020ac85a4b0000b029028acd99a680so4061731qta.19
        for <cgroups@vger.kernel.org>; Thu, 12 Aug 2021 15:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pU1jcFqEFviufW4xVur65db047ti+YmuGAqH7xi6AYA=;
        b=FwcmpB/dKFjMZMd7+ziiBQJYKAcBzLEf51F3HZM9o/25XOL5RZUwU84NO6ojybIDa4
         aukCG1qpMtX9LYpP1TSos82QNYVWKBdt92znLEAyiXqyc3UEJ10v+O8E5LJlY6k6bvOO
         9z5bOCO3F/KX7GYEePI70+FKVRka9uztAPAAPN4sj5+BB+PKi89uKIifQKHpfvEHZvgi
         hUn3t/aMVd7dZw9oKwCA6ydF7SWzEAWXEWFNhQ6Gd4d0+VyYjxIcvdNIgRINRNwzL8oU
         kkO2O4a/C9KvpquGF6iEmp7Te8ZADfftamYYa03nmj2T5CoirvgJtemSoq68+ygAMqtI
         5z0A==
X-Gm-Message-State: AOAM5313/D9wcYPLlkiwwHi9TAGzJHZFplH5n6aSIDvjsHSR6gyyRuq8
        21i5LA5zBjxNcN4uPmfTuPzOHBAF1CaT9rperU1/5Y4GykiPixtzDpJfWav0j7M/nSd474GHOeW
        WEzQO1tuh4cDYeOFaEg==
X-Received: by 2002:a05:6214:a02:: with SMTP id dw2mr6395576qvb.61.1628808963314;
        Thu, 12 Aug 2021 15:56:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz420Kic49s06UtdxHWo/YD/3XASGNT0TOXMTVd4tfATpr0sLrT6MWjhl7rS+FEPDfsmmSwtA==
X-Received: by 2002:a05:6214:a02:: with SMTP id dw2mr6395557qvb.61.1628808963138;
        Thu, 12 Aug 2021 15:56:03 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q9sm2220931qkn.85.2021.08.12.15.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 15:56:02 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/6] cgroup/cpuset: Properly handle partition root tree
To:     Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
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
 <20210811030607.13824-3-longman@redhat.com>
 <YRQSKZB8rQUsfF2K@slm.duckdns.org>
 <b7897818-8fe6-8dd8-3ff6-6b15401162ba@redhat.com>
 <YRWeQH6gY5PqIanD@slm.duckdns.org>
Message-ID: <55f61b66-5159-7e13-6e41-33df042612b0@redhat.com>
Date:   Thu, 12 Aug 2021 18:56:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRWeQH6gY5PqIanD@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/12/21 6:18 PM, Tejun Heo wrote:
> Hello,
>
> On Wed, Aug 11, 2021 at 03:27:20PM -0400, Waiman Long wrote:
>> Disabling partition at the parent level does invalidate all the child
>> partitions under it. So it must be done with care when we disable a
>> partition.
>>
>> How about we give some indication that a child partition exist when reading
>> cpuset.cpus.partition and recommend double-checking it before disabling a
>> partition? For example, we keep track of the number of cpus delegated to
>> child partitions. Perhaps we can list that information on read.
>>
>> With that information available, I have no objection to allow disabling a
>> parent partition with child partitions under it.
> This is a general problem which has always existed regardless of whether the
> errors are synchronous or not. There are many different reasons that a write
> to a cpuset interface file could fail and it has never been easy to tell why
> a given operation was rejected. Making error notifications asynchronous
> doesn't really change anything fundamental although it does make the
> situation a bit more opaque.
>
> I'm all for improving visibility. Now that we can consolidate most error
> states into a unified failure state, this might actually be easier to do.
> IOW, we now just have to explain why a given cgroup is in an invalid state
> rather than additionally having to explain why a given write has been
> rejected, which is pretty awkward to do as those failures are transient and
> local to the writer.
>
> So, if you wanna tackle this, let's do it right and provide something
> comprehensive rather than explaining just one failure.

That sounds reasonable. My current idea is to add invalid partition 
reason string to cpuset. So when users read cpuset.cpus.partition of an 
invalid partition, it will read something like "root invalid  (<reason>)".

What do you think?

Cheers,
Longman

