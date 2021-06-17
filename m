Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93DF3AA930
	for <lists+cgroups@lfdr.de>; Thu, 17 Jun 2021 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQC4C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Jun 2021 22:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhFQC4C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Jun 2021 22:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623898434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yS1nM3ylxqu4LGWweeetnOJWhjHjFKRHgCRdFTmCJkE=;
        b=gXpmwFOIduk2/9ckK6uOz5f62UA4v+vegnUu/PmMFzPvbwjb033oqPmZTdebjvVXBnTapl
        4g5+lUivfYA8eFf20LhDQxtgWCKC6A9oxKjL/KBRPpj5i2d5XtHq48/KaZWbKGEuplHb25
        bZoeEh9wfoEbyyX/oC8o00i9h13PoUY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-GnCiU8vnPGOIyzSzQhj6AQ-1; Wed, 16 Jun 2021 22:53:51 -0400
X-MC-Unique: GnCiU8vnPGOIyzSzQhj6AQ-1
Received: by mail-wr1-f69.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so2257860wri.20
        for <cgroups@vger.kernel.org>; Wed, 16 Jun 2021 19:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yS1nM3ylxqu4LGWweeetnOJWhjHjFKRHgCRdFTmCJkE=;
        b=kjfX82bzML6xHG02U01QNpHjm8OIP+kIdRmOsLQSL6x5o5N54jT/YY/o+ekDGW/7TT
         NDJNDStx7R3fkfFg3KzNvq/QECK6u663/iQcHeIVsiFMGvUkIiL4PhYWrkmtt2d0kMjv
         ePTvC5RMqssWDYsrJ1nEgTTD7L6HV3an3g5B5p5NxEeZkbHVoMIf+u4LR/9w7AOy8Ljz
         uxnVBrB4sqTxzCp13flhebQjjLeNbNxekn5l+XkSdW1pGEJm/NGjySXH4b9nFcMwn2bn
         2NqUh3jc42yfeHfqYi7F4oPInEIcA72elFf6J+Sa6EG4JfPfkHrJY7NAlDKC/T7fFktQ
         xbjg==
X-Gm-Message-State: AOAM530NvaqDzrMrvuBF8l9fl11SRyTx8jkwf/c16uLDWrDS2gBjOpIh
        EnzCPZi1HZNoj1nKFFgujMsbJQ1pEUvHiifGDkRpmD19Uzgupjk2A/CKFsJyhpkqJQO7mUpFUAo
        X8y24IKFhczzBeGXHYw==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr583741wmi.171.1623898430240;
        Wed, 16 Jun 2021 19:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycogHw1ABakuf4er+UbRreN9lkhiUZ8wnSoK8E3G9KFZOhpUS4fGgk6OHwkh2KfEcm5Rr5Lw==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr583714wmi.171.1623898430048;
        Wed, 16 Jun 2021 19:53:50 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n12sm3783427wrw.83.2021.06.16.19.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 19:53:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/5] cgroup/cpuset: Don't call validate_change() for some
 flag changes
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
        Juri Lelli <juri.lelli@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-2-longman@redhat.com>
 <YMphhLAzmRRyD+cm@slm.duckdns.org>
Message-ID: <4e4da272-ae34-4ff8-18bc-253e9c14a14c@redhat.com>
Date:   Wed, 16 Jun 2021 22:53:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMphhLAzmRRyD+cm@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/16/21 4:39 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jun 03, 2021 at 05:24:12PM -0400, Waiman Long wrote:
>> The update_flag() is called with one flag bit change and without change
>> in the various cpumasks in the cpuset. Moreover, not all changes in the
>> flag bits are validated in validate_change().  In particular, the load
>> balance flag and the two spread flags are not checked there. So there
>> is no point in calling validate_change() if those flag bits change.
> The fact that it's escaping validation conditionally from caller side is
> bothersome given that the idea is to have self-contained verifier to ensure
> correctness. I'd prefer to make the validation more complete and optimized
> (ie. detect or keep track of what changed) if really necessary rather than
> escaping partially because certain conditions aren't checked.

Thanks for the comments.

You are right. I will leave out this patch. Anyway, the rests of the 
patchset don't have a strict dependency on it.

Cheers,
Longman

