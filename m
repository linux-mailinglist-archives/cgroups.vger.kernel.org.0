Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF82D3B5EB0
	for <lists+cgroups@lfdr.de>; Mon, 28 Jun 2021 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhF1NJV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Jun 2021 09:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhF1NJU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Jun 2021 09:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624885614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wsog/UA6NQRm36wrbUHXM3ftcSt/9+OFEW6vcsabAY=;
        b=ZDni8AkrinQUwWeEVSBbJlYqCj45qnB3NNjuieklN5F7tOwja4lZc0EzHgCduVgFE4PSNm
        hIjNzkykekrOJaDlA3B8elnFJTUi10yU3CLMZGbPimt5YEgir+Z3oTNihQhSYVhlttApm6
        G/O+MsxduOzEZW3bCTQVC8lhZ54g87Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-r3jsrpxJMSSPmbEwyVXMGg-1; Mon, 28 Jun 2021 09:06:53 -0400
X-MC-Unique: r3jsrpxJMSSPmbEwyVXMGg-1
Received: by mail-qt1-f197.google.com with SMTP id 5-20020ac859450000b029024ba4a903ccso12719805qtz.6
        for <cgroups@vger.kernel.org>; Mon, 28 Jun 2021 06:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3Wsog/UA6NQRm36wrbUHXM3ftcSt/9+OFEW6vcsabAY=;
        b=Lr62lBDhlF0+b3yhGllwlTKPTAj4jNlsm+gDgDkDYzunycl6bt2J7z034J7ZUKKyRE
         mV+cF++pRd6s5gX+WNPcutmMiokZSU5twAurNaFk3wUyMBxl7817ps+PgtFElcoDf2bR
         aE2LtOB6fE96U2cYEAvEXfHFEgCX7HFQSvYqrb8AcnMygSC5vmbjNZMdbVfjn4AmjOPN
         xbtyD+KEk8gjQb6IfYi35Vtz1E52L43ofOl07iDHRvNZRA0N+3cjUHCS/vMqQtg89rL6
         Y+Bav1/LfGpJwy0OQqQxTrnC62M6RhuXWgI1MtbuwmxGw7EMIAUFbe6PXWU9NsT4Lxkh
         LILw==
X-Gm-Message-State: AOAM533TKL4Hnmj0rP59hxMThw5pWyIN3H8e/W0s/Tyw07dpKkI8NsG+
        QNXGKCDBgOKrFt7fIsL7W81RCjpi8Mr6pXATfLZs7FFBGfqk4jr/ln38aii+Py2dKrdv23Xy/Aa
        DGDclsHOSxz3hhlo35A==
X-Received: by 2002:a37:9986:: with SMTP id b128mr25711690qke.485.1624885612616;
        Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUlJHxYKkE1I0xN1vBM5amAltWfY9ckZGLT37Njz1aTkLclF02YuG2OEJBVFBBcLl/BywiTA==
X-Received: by 2002:a37:9986:: with SMTP id b128mr25711669qke.485.1624885612428;
        Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h128sm10222579qkc.94.2021.06.28.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:06:51 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
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
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
Message-ID: <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
Date:   Mon, 28 Jun 2021 09:06:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNcHOe3o//pIiByh@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/26/21 6:53 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Jun 21, 2021 at 02:49:20PM -0400, Waiman Long wrote:
>>   1) A partition root can't be changed to member if it has child partition
>>      roots.
>>   2) Removing CPUs from cpuset.cpus that causes it to become invalid is
>>      not allowed.
> I'm not a fan of this approach. No matter what we have to be able to handle
> CPU removals which are user-iniated operations anyway, so I don't see why
> we're adding a different way of handling a different set of operations. Just
> handle them the same?

The main reason for doing this is because normal cpuset control file 
actions are under the direct control of the cpuset code. So it is up to 
us to decide whether to grant it or deny it. Hotplug, on the other hand, 
is not under the control of cpuset code. It can't deny a hotplug 
operation. This is the main reason why the partition root error state 
was added in the first place.

Normally, users can set cpuset.cpus to whatever value they want even 
though they are not actually granted. However, turning on partition root 
is under more strict control. You can't turn on partition root if the 
CPUs requested cannot actually be granted. The problem with setting the 
state to just partition error is that users may not be aware that the 
partition creation operation fails.  We can't assume all users will do 
the proper error checking. I would rather let them know the operation 
fails rather than relying on them doing the proper check afterward.

Yes, I agree that it is a different philosophy than the original cpuset 
code, but I thought one reason of doing cgroup v2 is to simplify the 
interface and make it a bit more erorr-proof. Since partition root 
creation is a relatively rare operation, we can afford to make it more 
strict than the other operations.

Cheers,
Longman

