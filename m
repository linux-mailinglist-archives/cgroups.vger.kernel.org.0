Return-Path: <cgroups+bounces-7286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EDA78365
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E67166560
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF6D213E8E;
	Tue,  1 Apr 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lsu7KDG0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05E20E32B
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540121; cv=none; b=lAxVNyu65LMGPwxMPdaDFf/XCCqm7wcqG11ANMrk/zi8PvxIUg4N22engou+G+YrguUDtxc19xB0/YXLenWtxzqSDKyBfGpL6NxzXTaILOU8JvQRUjB5VZhAEbvDWPvzFE7S+rTsqb8teUxMj/0k9gaI2QxEYlx7uQidql6kDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540121; c=relaxed/simple;
	bh=DQqNytcES03RM+rHoX7X/MIHXjVFtwm514rcdrui4L4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JAATqfvQhmQ6Tn58rhX4uVA7aXJxDgwq6cDkPYkKpsUan3dgz1MHuaQpcEqQpHzw+pMCBZpfaemdeq5tp6QFAGgTGpXEGmQ1m6jOU7QmtiLSjWiqOKiv0ME8DgXMQOGdSS0OZ7skYwHCrTi/DZqzyOD8fo4baSnQIFQUAMh2490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lsu7KDG0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743540119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Owge253k5OvzgMZCm8XexlvQc59vpIkP2hnOZmugbZE=;
	b=Lsu7KDG0vojX0X6JvuUL++YH87iEifs40pVXgX7Woh+2NKKWVolgam0i1tn0aT3uOolsZ9
	wai9cipoubhL2kbgspjqrogwSC6pMel4JFmSImZyvzUxhh/e1n81uX8zKEiweLJqLjtCZX
	Hl/NTa27M+EAWxl7EsiXC8tP1UeN4Ac=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-qMYYGHr8P_yGxwKwtUw05A-1; Tue, 01 Apr 2025 16:41:58 -0400
X-MC-Unique: qMYYGHr8P_yGxwKwtUw05A-1
X-Mimecast-MFC-AGG-ID: qMYYGHr8P_yGxwKwtUw05A_1743540117
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5e2a31f75so120457485a.1
        for <cgroups@vger.kernel.org>; Tue, 01 Apr 2025 13:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540117; x=1744144917;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owge253k5OvzgMZCm8XexlvQc59vpIkP2hnOZmugbZE=;
        b=qCLBSLz/NNu+pnVTUlCEKGMsgYLNnk/DYhECHk5eJu9oE0QIpEjDVfofvkPsC6/HUk
         7o8ii1Ggy5fRVgEPyj9MaiYYbCRUtC02wD66aM7ivXn1P9ofnzISLMwpGjYIbTIz6kKi
         wNNL+M2CDWecphA1WJKvL41iKMKpbdCgEy7x4orx71Pg6cOW1edeVaj9duMRhDj5DN+j
         dNOPKmbGeBj114dbrtkpWqUX4PCBPdKEKjsoiJdNBLM+q79OJwwJ+Jjc1qfic2+2WC4N
         veXlfNx8tggI4V5gbmRY2AvuULlStVp8wI6vv1DC8dUPvcIJgKt7Olluw/JVw1KK2UL3
         fh+A==
X-Forwarded-Encrypted: i=1; AJvYcCXJNo1pPb2GJOIuywp1RxpcYzwNfm3+ZBLDddlejHV4REDxkodn+9Jsy64epl/pGDpfr8PzzaR1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26EQvSUPq8PcfATuPT9OdmXK89nwFqGqOH+9Eeqa0i3j/WLV+
	7IL6zGWQdLumLPahIgI7+j1IEsZf6g942ZzZTq4/utjWHe/d1hgdd+mXLAwiNHMbLGXR+kawTv7
	OTd3pioMNb3qdPHKOXi3iTI0Cq5Y4LPsPTdoOGYEZieP4EetOe5wyBws=
X-Gm-Gg: ASbGncufkIrgHPxqrpsBh9WSllWZrJlWa3e8IkwKDZkuKnGdNBmmGmn9aBnboUoQbb5
	pS1ZYWvM0oG04RLRSCE4crcCIfmf4eg3IfDkUhjb1LrFPTNWQwA+z8aE2SS4nWkqF7Ro03hN2IN
	DSofQ/nmRsKkO7onKWJuaKIshb0eaAqg1j5YlZNBZ6YYcQSg/UnnUI1jdO6W5mjDamf8CxnBnKA
	euw0C7op2CCPCPgo8h4zM3y4anPYPVHRzLymfbQLkUccOY3r3uu9nu6YjxMmXFd4X+MlVOVgEOY
	+cKBriTDrjGCg46CSfRZwb0c6UAmarT1peBJEw4+qlMIYQGzuJxVAkZLzpNO3g==
X-Received: by 2002:a05:620a:4013:b0:7c5:5276:1db7 with SMTP id af79cd13be357-7c6908974d4mr2076453585a.52.1743540117628;
        Tue, 01 Apr 2025 13:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH27u1JuY0yEa8uyZ7v4MsZRRq+k/qsw1NKT26VcX+0iVdXSIzNmBeyfSP31h9rLTX0UGAbFQ==
X-Received: by 2002:a05:620a:4013:b0:7c5:5276:1db7 with SMTP id af79cd13be357-7c6908974d4mr2076451385a.52.1743540117322;
        Tue, 01 Apr 2025 13:41:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f768b70esm699208885a.43.2025.04.01.13.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 13:41:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d9c96490-98bf-406b-8324-6cf86a536433@redhat.com>
Date: Tue, 1 Apr 2025 16:41:55 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
To: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-shjD2OwHJPI0vG@slm.duckdns.org>
 <915d1261-ee9f-4080-a338-775982e1c48d@redhat.com>
 <Z-xFqkBsh640l5j0@mtj.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z-xFqkBsh640l5j0@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/1/25 3:59 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Mar 31, 2025 at 11:12:06PM -0400, Waiman Long wrote:
>> The problem is the RCU delay between the time a cgroup is killed and is in a
>> dying state and when the partition is deactivated when cpuset_css_offline()
>> is called. That delay can be rather lengthy depending on the current
>> workload.
> If we don't have to do it too often, synchronize_rcu_expedited() may be
> workable too. What do you think?

I don't think we ever call synchronize_rcu() in the cgroup code except 
for rstat flush. In fact, we didn't use to have an easy way to know if 
there were dying cpusets hanging around. Now we can probably use the 
root cgroup's nr_dying_subsys[cpuset_cgrp_id] to know if we need to use 
synchronize_rcu*() call to wait for it. However, I still need to check 
if there is any racing window that will cause us to miss it.

>
>> Another alternative that I can think of is to scan the remote partition list
>> for remote partition and sibling cpusets for local partition whenever some
>> kind of conflicts are detected when enabling a partition. When a dying
>> cpuset partition is detected, deactivate it immediately to resolve the
>> conflict. Otherwise, the dying partition will still be deactivated at
>> cpuset_css_offline() time.
>>
>> That will be a bit more complex and I think can still get the problem solved
>> without adding a new method. What do you think? If you are OK with that, I
>> will send out a new patch later this week.
> If synchronize_rcu_expedited() won't do, let's go with the original patch.
> The operation does make general sense in that it's for a distinctive step in
> the destruction process although I'm a bit curious why it's called before
> DYING is set.

Again, we have to synchronize between the css_is_dying() call in 
is_cpuset_online() which is used by cpuset_for_each_child() against the 
calling of cpuset_css_killed(). Since setting of the CSS_DYING flag is 
protected by cgroup_mutex() while most of the cpuset code is protected 
by cpuset_mutex. The two operations can be asynchronous with each other. 
So I have to make sure that by the time CSS_DYING is set, the 
cpuset_css_killed() call has been invoked. I need to do similar check if 
we decide to use synchronize_rcu*() to wait for the completion of 
cpuset_css_offline() call.

As I am also dealing with a lot of locking related issues, I am more 
attuned to this kind of racing conditions to make sure nothing bad will 
happen.

Cheers,
Longman



