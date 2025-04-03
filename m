Return-Path: <cgroups+bounces-7332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77D1A7A45B
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C27176946
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BD24BC09;
	Thu,  3 Apr 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJ7AACbe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A61C861F
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688196; cv=none; b=qbiI5Q3ptVV+Tb7YYJrlwKw9Ya/D53rcNWmNBLxKeBE0mJHBHQ7vciH92VBxV5idYEAHa6y+LPVMMB6jXAi/YYw9BMClfFtgKNYUnr0AeqcC2f9w0nKxno/nBrc3HJyulAATCJ15A7lSQVBQucrhT5ffvRV1FHlcLHemGSlTvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688196; c=relaxed/simple;
	bh=8wd++/QS/xpM3EXXxc69GzFn6SgURG8H5mMkQefQd1M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFqB0WU40IOt21IR2V5+YrJwsdJBV22WiVGyhhPnLGsSaMUsXmmtvhV6Eucdh9YqvSqDIujC18XtH1u00tlkhAIdBzOqGjgZOPkaAsu0aWtXcXpK9NkbOsChEZmyaaLWrlKR0IyL24WeHw1wU8ayJ5MYhp6T7BabHd46tMiR7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJ7AACbe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eAoy1aQ30yuScjB2LdD2aKFWnFzP7D/Q7jd8pjdm/k=;
	b=GJ7AACbe0556dd5ZwbXBQFypSgm+WYsPu20YuBRaNtlcHp4cDKBl+iVeuIkyV1wbYYUo8g
	TQCPOrgnQS8tu0VsxCsQInvaCTdSHTAcvaeZVsTw7Xln6/drjgSI9KYY3XELdZtkif8Jay
	Bs/GicHcFq5fwbe4vMx4nxeFSc4pUho=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-MZyNt3fqNSmLN0_gqtLmuA-1; Thu, 03 Apr 2025 09:49:52 -0400
X-MC-Unique: MZyNt3fqNSmLN0_gqtLmuA-1
X-Mimecast-MFC-AGG-ID: MZyNt3fqNSmLN0_gqtLmuA_1743688191
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8fae3e448so19565046d6.2
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 06:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688191; x=1744292991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eAoy1aQ30yuScjB2LdD2aKFWnFzP7D/Q7jd8pjdm/k=;
        b=U6k0bSGELXi48GTnNQMwkbY5kWKTwCtaX52oWi6W+UQd2e4KN5mwmAACpUi+dowih4
         C7XdJukpp123GKlzdRmTF2zBD7awVmB7+oe0ojZasdR5UvQsOmpUl2H67lDziCmTBJ9x
         tdia0ygS8dfkdrMj/eNg0iUWguBGFyOiu2B0G9kpbdzxk0bRdPzxJrJPJVDZ2DWERZfz
         UEUmHfTrernKUEhaVqtjZO5kOZoSe9ASMU4CnoGLk1PbUCqt0BxukvzeCp8edsOijeY9
         DsgPSdjfJNtSjv6ONsn5SOI1KAe1I/SGWfqBhVhlpHhY+wTI60+/ITVIK8s8AlWozMmg
         Babw==
X-Forwarded-Encrypted: i=1; AJvYcCU7lesh7/aEam3K8K73TqXyk+nLJzF5zJa0fjfEPvH5o0bmTx3Yble1V57xLV/2KV1P+JIAmihT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7VE3HH3dPsZR4yJWyxf6vBNJQg7rqQUT6ZpbEJhHZ7NLu83T
	5JYu6quNqKwsOtMrYgJwkU+oirIRYcnHSMVE8tBSygQ12r2W+m+OaSM/CxH5UgbJbT9LMCXVzzO
	14xDo4rZ/lSBeo/ikcKZ1bXrQuGEakg7ENvqB21ME+lRvzsPS7//7MAHwmnn7wlc=
X-Gm-Gg: ASbGncsmNWoFMS0d5biCoVcVKDqd5TrEAmy2KWSIB61hD7/m7rxZxV2xEHrjj8qO0RJ
	ed69GNwPqkj5PO8X7V3KVggbQ7gQekpdjqO5dlppB63VSQfqBHDfDfQw6jQgBH+Ie1Af3b7GXaQ
	X3fzhUcb+YFsSeDRO1Em9VMuDOe+s0uxeWJr2fbWjLrSKEH3WxAepCw332DUNrz/6rcb7JtXirH
	qxOO4IOCAZN1lWrFFxkuSLsT2X3xr+svffJXqaUhnFB58MffNRTBzDl6dV2FCRAEZmwR0YdGf3A
	fkI5gykpeHm8Uu44mQi+qfbQO5vwy2cuGqQ0lWWHRUAuofUDqZU5p3AoO61pTw==
X-Received: by 2002:a05:6214:d45:b0:6ea:d604:9e59 with SMTP id 6a1803df08f44-6ef02b7fe83mr105374966d6.9.1743688191332;
        Thu, 03 Apr 2025 06:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbzjYUkcoGjF250F0Pl2Phd2PHHM5mJucKy2fKCWScw+uUZHWYUOwP0vKoI8Pljh7xHfeTTw==
X-Received: by 2002:a05:6214:d45:b0:6ea:d604:9e59 with SMTP id 6a1803df08f44-6ef02b7fe83mr105374666d6.9.1743688190985;
        Thu, 03 Apr 2025 06:49:50 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14cf41sm7678356d6.105.2025.04.03.06.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 06:49:50 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2fa642e3-4ee9-497f-8c3c-49abb712a679@redhat.com>
Date: Thu, 3 Apr 2025 09:49:49 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] cgroup/cpuset: Remove unneeded goto in
 sched_partition_write() and rename it
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-8-longman@redhat.com>
 <t5gojwcnwdb36ppkhq6hpujmyatckg5wd5eigsnmt2kndfofe7@ymc7tiury62o>
Content-Language: en-US
In-Reply-To: <t5gojwcnwdb36ppkhq6hpujmyatckg5wd5eigsnmt2kndfofe7@ymc7tiury62o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/3/25 9:33 AM, Michal Koutný wrote:
> On Sun, Mar 30, 2025 at 05:52:45PM -0400, Waiman Long <longman@redhat.com> wrote:
>> The goto statement in sched_partition_write() is not needed. Remove
>> it and rename sched_partition_write()/sched_partition_show() to
>> cpuset_partition_write()/cpuset_partition_show().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
> ...
>
> Also noticed (here or for the preceding comments&cleanup patch):
>
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3525,8 +3525,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>    * in the default hierarchy where only changes in partition
>    * will cause repartitioning.
>    *
> - * If the cpuset has the 'sched.partition' flag enabled, simulate
> - * turning 'sched.partition" off.
> + * If the cpuset has the 'cpus.partition' flag enabled, simulate
> + * turning 'cpus.partition" off.
>    */
>
>   static void cpuset_css_offline(struct cgroup_subsys_state *css)
>
>
> Next time...

Thanks for catching that. Will fix in a follow up commit.

Cheers,
Longman


