Return-Path: <cgroups+bounces-11871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0DC53AD1
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C244A5291
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75C33DEE8;
	Wed, 12 Nov 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOz0gP4U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4ogwg8j"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6452BCF6C
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965626; cv=none; b=k3DtBwO/FdUmCsu41JPdz041pbrr8Qov96xlpHlRtegKD8qUbrP4bY2oQpaJf9frOGUS9VXMZ/d7umn9lUEulqOBBI7vr3FssTrStLqQfQhlxAg6RSVUsinsOw0bB3avLDKyYTAoven4VOlhbmx++4xluc9aTshzP9G7lz/Ne3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965626; c=relaxed/simple;
	bh=NPKmesSgG0k5cHihrVZICOAHxzeS6yl0o6Q6Msfzyf0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q6AZeeU5XgD0QZPAzzrCRzYTakEY/ka93vvPCf9VY/kDyVBKtvUD4qyWsDfCSdk8Rz/1xnH9DCAeEiw77LWB1/VOfCPO5TvDP3IBPKx3c0HqX2/hISAE8iicHHwWPAPSRJUK8c3h8kNUgYJZBpw9tL7tDhiwpFbp0JamINnIJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOz0gP4U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4ogwg8j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
	b=DOz0gP4U3n24WDcZG5E9C1uVTPgcYKpBfAngJpCW6YrSUCWWLK8IZnES44x+mnSoqQY9pN
	pBO77RxbwHZdewvaGAmBO/lEHHy6Zi1oAIvh7QPLEqUGTo8Eib4sJgVOdqREj7l2d894D7
	qYwifJHW+XCral11I/A1VqWRdecX4TA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-E87wbZDwNXypZJi1NBd9bg-1; Wed, 12 Nov 2025 11:40:22 -0500
X-MC-Unique: E87wbZDwNXypZJi1NBd9bg-1
X-Mimecast-MFC-AGG-ID: E87wbZDwNXypZJi1NBd9bg_1762965621
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b17194d321so138000185a.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762965621; x=1763570421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
        b=U4ogwg8j0AkH0dSCF16QZLstcV5ZtOrLLgzfytX0ey0f+aDo6nI7UjT/4mLSN+1rch
         I5oPWSCFEWiwN5zNGLA5tf6LY7p0aoOo4tE6+AMIuABCxpjChI+t/B03dHZtdn8VmRQv
         6WYcRZpAeM8PFbYJ5GsSxcgbGr5ZZNpWzcNU4nTpRU68EaS8LkpvLKhfs6Hm64Ansxsb
         C6ShRFRlGcXfbXsQZa+wc37LLumw1hrDT0/QI8Kv8+K8Hq40PAgpeTPiOxCmm9mICVdd
         t62e1ga2v0npHM4tBcXTgw5rBXmqHiHa+B3AtenWLTIKQetr6Bmq2YxwZ6dat7kpNn2y
         7Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965621; x=1763570421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
        b=FItTDN86knWtUAm0lyxZzQDOWL0s0I3dc/vGE8oE5wK0ozNqBycbQY1zZfajzZ2+OU
         +lw6r3C8JSvwrrzITwJBTcHysQn/NLc6RPJHj7vhrn2ay1Z2isI9A0XDH641RDyw4snT
         xxe/YQvUZV8jp0jVUNdI1XjRZ2N8jKf1ecNRGAEjpFIbftyosOHZjBG/FaFtE46GxIBd
         PiZ4r9xMjlil2kycQTm5fgPdOvZ9UqIqFptSgI3zY0jQP12nltolw1RJ68dCo0+ZoBzS
         p/WJqfLYKY0l4vgL58t4fqWpMVtaMgKWd9WkPC5KzU7P5Aa0vd3q/f1Zxab2cyIfvl2o
         s48w==
X-Forwarded-Encrypted: i=1; AJvYcCXmAiJgS764Q4lcxCmN53idUOIF+PeYuFB9WUpsrrZJGt+djf0oB1VCevsSfomQLjHMreYFklRN@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrIr/zbqpiYu0rS3/XitOikfM1cG8016Zv0PdQqDTsDKx3c0L
	dxv1rSsbHaDpJQ9N/8K8GhrvgTasQv9SMTU3+ATFzNlFub060DuxzqY7RvornpOblLs0YXCZ/cI
	DvYyrcy+dKBOnSwpOfyqjzLubH8V8WzT4r044LeUu5gQzER77i5a4TeIJtE0=
X-Gm-Gg: ASbGncu6wYcZoUGbNU+RQ2ESoWfYtNOzQ9GXM/Oz5FroxUwqs6vDH1ooVjfv3E0OHkL
	n9f5OErOqjIyihL/KzX1NvjiiJIkvCIhHJnMNWo/BszLTHlsvb2mBubhwhkkGO+FPl1rMHdon/8
	t6SpppVBZrpiRVqNC6uLAHfPE67KHWzDENF2ESVPGttTUTw+LlVb/PJCUAhYI+ZqO0jS3fu8L9G
	2YbERBXwKBGdT8BbiVJW5p1rdcBS0Vqu7vozsfRrGR++ROmgMMmfw8mIdoORu2Yuyqes3Lr6dhs
	mJg/WxTRweGTkssYss1MetqCBe7gLwMoqWrtImg2Do4Tor1sHklmtHqQKpvqkONrWPSvyUCruJG
	it/LbA7ZhkcRVolwZ+oVYBL3qB3WjUG5vULxzBX+aT2P1Mw==
X-Received: by 2002:a05:620a:45a7:b0:89e:99b3:2e9f with SMTP id af79cd13be357-8b29b7d96c9mr432074185a.54.1762965620691;
        Wed, 12 Nov 2025 08:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeRHn0TE7WSuy/RawTo+0uqdbnmzeUBkTfUMKCdOV0bkTaq6MIRt0f6pTVYA0aGPlXvo+hcw==
X-Received: by 2002:a05:620a:45a7:b0:89e:99b3:2e9f with SMTP id af79cd13be357-8b29b7d96c9mr432071385a.54.1762965620280;
        Wed, 12 Nov 2025 08:40:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0e8sm222910385a.15.2025.11.12.08.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:40:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com>
Date: Wed, 12 Nov 2025 11:40:18 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Chen Ridong <chenridong@huaweicloud.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251112021120.248778-1-sunshaojie@kylinos.cn>
 <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 10:33 PM, Chen Ridong wrote:
>
> On 2025/11/12 10:11, Sun Shaojie wrote:
> Hello Shaojie,
>
>> Currently, when a non-exclusive cpuset's "cpuset.cpus" overlaps with a
>> partitioned sibling, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary.
>>
>> This can be observed in specific configuration sequences:
>>
>> Case 1: Partition created first, then non-exclusive cpuset overlaps
>>   #1> mkdir -p /sys/fs/cgroup/A1
>>   #2> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>>   #3> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>>   #4> mkdir -p /sys/fs/cgroup/B1
>>   #5> echo "0-3" > /sys/fs/cgroup/B1/cpuset.cpus
>>   // A1's partition becomes "root invalid" - this is unnecessary
>>
>> Case 2: Non-exclusive cpuset exists first, then partition created
>>   #1> mkdir -p /sys/fs/cgroup/B1
>>   #2> echo "0-1" > /sys/fs/cgroup/B1/cpuset.cpus
>>   #3> mkdir -p /sys/fs/cgroup/A1
>>   #4> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>>   #5> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>>   // A1's partition becomes "root invalid" - this is unnecessary
>>
>> In Case 1, the effective CPU mask of B1 can differ from its requested
>> mask. B1 can use CPUs 2-3 which don't overlap with A1's exclusive
>> CPUs (0-1), thus not violating A1's exclusivity requirement.
>>
>> In Case 2, B1 can inherit the effective CPUs from its parent, so there
>> is no need to invalidate A1's partition state.
>>
>> This patch relaxes the overlap check to only consider conflicts between
>> partitioned siblings, not between a partitioned cpuset and a regular
>> non-exclusive one.
>>
The current cgroup v2 exclusive cpuset behavior follows the v1 behavior 
of cpuset.cpus.exclusive flag. Even if we want to relax the cgroup v2 
behavior, we will still need to maintain the v1 behavior as we want to 
minimize any changes to cgroup v1.  IOW, we have to gate this change 
specific to v2.

Cheers,
Longman


