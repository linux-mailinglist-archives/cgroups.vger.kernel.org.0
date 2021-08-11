Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBF3E97E1
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 20:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhHKSqx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 14:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230207AbhHKSqw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 14:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628707588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOILZBJ0R4YxSBlomh5xiyJL3tlxmw5VR/2YYVBHfVY=;
        b=EwW1Lt7iXin0ZAb0YDhwtWWbqICvcow1T6t8TIqgeW3Ycfjhdzi922VTdJiwbiHaW0D6lo
        KiPxSoeE3+2kQIULIqK1c0ZlGxHafOYUwdeTAlxaUWRfdYSfAH699RDYx822sQBQX+OBvH
        pPP5DqI00Tuhdr0k0VS6u5M5lpUaEw0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-cWYU1OmPM8KL3HlOfbpDQQ-1; Wed, 11 Aug 2021 14:46:27 -0400
X-MC-Unique: cWYU1OmPM8KL3HlOfbpDQQ-1
Received: by mail-qk1-f197.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso1900767qke.14
        for <cgroups@vger.kernel.org>; Wed, 11 Aug 2021 11:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BOILZBJ0R4YxSBlomh5xiyJL3tlxmw5VR/2YYVBHfVY=;
        b=rPl/w2/su9sPuCZM9CB6PSMUH7lmxec5wwyJ5DndmN1Rr/d/slyfn528fG89U9YDd4
         BUWO9O7Rep7B3Ux6oFysoxh6GE6b7H6ETe/Crpe6ulPIh63VrhIGBW8YTWyO1lCFzCgx
         xg0rpgRfLoMuGU8yThUKnlxoFeHMm6E2Ttg5iUw/eevFwpPMKZ9RQCFK0mEMCcEBVRpL
         n2nSxydQC29qVPoM11IvE9O6nUJxgPz1vFt9Cur0nr70CsmnJrM+AtsyjNpi+l+XxL0W
         39FEam15wxVJGZrmjlQ3eX9HApV8Cq7roV08QHxKOsxDbX9HiNji4w63dzXVqwx8omcd
         yjSA==
X-Gm-Message-State: AOAM533CthHwfx5nfHDm1wKcoAD1LSuTkpeHqcLywltEQrlHtKlqh7As
        zefP5psw4dJ4e1Hj8lhS6fWsHuD2WrXtzXiOUWwVCdmv+WAMhXZg4uMbzWK61R4vDecCVZdMX+t
        9DeqAgwq4REqp2a93EQ==
X-Received: by 2002:ac8:47d9:: with SMTP id d25mr123628qtr.247.1628707586781;
        Wed, 11 Aug 2021 11:46:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc+HweGCSjMpjaJcpagiM7+c0ZCQmmIkZOMJU7you99awb+4aUS28VxuYA6K2SQkpFfVwoCg==
X-Received: by 2002:ac8:47d9:: with SMTP id d25mr123604qtr.247.1628707586605;
        Wed, 11 Aug 2021 11:46:26 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id s69sm12744271qka.102.2021.08.11.11.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:46:25 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 4/6] cgroup/cpuset: Allow non-top parent partition root
 to distribute out all CPUs
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
 <20210811030607.13824-5-longman@redhat.com>
 <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
 <abfa6f2f-aa13-f18e-5a16-f568082d07bc@redhat.com>
 <YRQVFkNX5DcKixzy@slm.duckdns.org>
Message-ID: <ef02d96b-325c-87f6-a6a3-d840feefef24@redhat.com>
Date:   Wed, 11 Aug 2021 14:46:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQVFkNX5DcKixzy@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/11/21 2:21 PM, Tejun Heo wrote:
> On Wed, Aug 11, 2021 at 02:18:17PM -0400, Waiman Long wrote:
>> I don't think that is true. A task can reside anywhere in the cgroup
>> hierarchy. I have encountered no problem moving tasks around.
> Oh, that shouldn't be happening with controllers enabled. Can you please
> share a repro?

I have done further testing. Enabling controllers won't prohibit moving 
a task into a parent cgroup as long as the child cgroups have no tasks. 
Once the child cgroup has task, moving another task to the parent is not 
allowed (-EBUSY). Similarly if a parent cgroup has tasks, you can't put 
new tasks into the child cgroup. I don't realize that we have such 
constraints as I usually do my testing with a cgroup hierarchy with no 
tasks initially. Anyway, a new lesson learned.

I will try to see how to address that in the patch, but the additional 
check added is still valid in some special case.

Cheers,
Longman





