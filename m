Return-Path: <cgroups+bounces-7654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE30A9417A
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E793AF1F5
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 03:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806213B280;
	Sat, 19 Apr 2025 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHOg8rJ4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C74D599
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745034482; cv=none; b=svarR/ZoiWG/cj+6KAyWgUSQQzrNhuRfAKnZEPv/clGZT1eBvs3i/6iVxfEi3fDk60envQHbk8yiu57vRvNbVmBdmwmteeQkX0sT8PKpD5ahfRJ0kwYvlQQg6tCmGeQZWL1kovGGKqj1PE/kYT6ta9Gipe2F9xQPNFQ2mN9ApM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745034482; c=relaxed/simple;
	bh=aW+J9nwCbuGtf9DSQt/O9uZhkn0wSA1UgTiwYLdmLcg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lJjPPL1Ob9uGeJ7I/9oPGI7bs1ubm1mqEEFWvbbbjoeZT1Ihq+hea5vwEZiOHCZ89ndlyK+t/aLGdwtS5+zgyqxMiMyzKkXiTVu+nullhJi68x2iTOTLf3eQv90OZfvYce6DML14tekw/kbK7GUZ1U1d4kC1IXiEJb/F4vUQz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHOg8rJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745034479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euRBpjQMecmcoooO18bxyQ49tEv+DDvKLc7+lXs5X2Q=;
	b=BHOg8rJ4LGGj+7obVHi1tfMEgQR26uqp9J5K9T1SStPSxvErXCzfD+vi/t9clVTFvQPP9E
	w9UpqkmOIgkFJLvBTNP3i/lqdDU2wB2j0euW8C8CmdJFKnquYMYPXOWzMOOTwPGMl+/EMJ
	HHPFPXZXO6Jeh0QFSAfMV7IuDuNkB8M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-oUciPrjUNvq1ibWSORg5EA-1; Fri, 18 Apr 2025 23:47:57 -0400
X-MC-Unique: oUciPrjUNvq1ibWSORg5EA-1
X-Mimecast-MFC-AGG-ID: oUciPrjUNvq1ibWSORg5EA_1745034477
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6eeb5e86c5fso25592646d6.1
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745034477; x=1745639277;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euRBpjQMecmcoooO18bxyQ49tEv+DDvKLc7+lXs5X2Q=;
        b=keuQOqtbrVAvBqBtcQ3t4QjkZbcv3CUF+O6ZbUv6DIsLYvrMaXDQLOaQ4UCzG+vm+r
         BRoRLZfiOiUbsYZ8sSpWX576pBdlATFsurupziibgU+r030VhlM5N5DI7hsS+yQOO7oi
         bmQIzVsDhGoTHPXyorF+tzJfdL9t+K2DmOrH9h+BE4YuzY6jmwu29BCRXYW7YcGK7u4d
         OAuivNPSN8JJdKD+w6mJanzDw1ikD0Suf3gTEdf02Y4oCKbRYlAwaWyMe6RDiC+N8d9s
         gf2Pccp9D5xhR4Be3eSSV51zSociyOYf62vqeJgMVDHHO0375iJZ3W2Fz5OmcKlzdrgq
         2Yyg==
X-Gm-Message-State: AOJu0Yy0s35EHil+HoEHRm7k0JLQqcm0KM+4O38j/UKVzNGgIZoSSXSd
	LQP7NXWk/OTMNkllQ13pKUDDHUoR7ppAG0o2Fhut4P32vW/DoR/Y8qMfuRDlV5b1S5lr/EUywd1
	nTSyY+VtOb8HU3UoRu8mXIwkEpfhDBTMDakeZ+Nu/oa0oEnlPRjzlWjs=
X-Gm-Gg: ASbGncsHTQUCtZ/UO+NPNxCGBCcVFXL5SzNbkw7uS9HZawvlyo1GxF7/Ce6ODocfrgN
	RwyDcdqWXhCK6jmIVWA4GTvvOfBonTP4ppfrvXyNRqPoDsiWe6BcLdwnpEpPm/3IYT3RESWul6t
	W9GqBrT4Xye6yUz9gaxIyowwPJQe48C2za/30HSS+6ab6LOmD9vOEBj4BJWIb/wIIxYxT3jv04+
	FKpsSyep6QieGkyEUCR2E98ktnEzM3e1+cJ2HG6QVsbAiQBFszCjxcXiA34JjkskZkCduY0magm
	NSA4FrWUL0+fet/yLjGHu6yfOlVBGLpTT3fvcSClQt8QNJSXwA==
X-Received: by 2002:a05:6214:21ee:b0:6e8:f9e6:c4e2 with SMTP id 6a1803df08f44-6f2c46458c0mr97829406d6.32.1745034477057;
        Fri, 18 Apr 2025 20:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkLsrK0DDA6WUJeYeccHnK40MNGALJUBAhTBwVewhL/xZHtjUTmB0r5Q5IR+oPqEiugxed9g==
X-Received: by 2002:a05:6214:21ee:b0:6e8:f9e6:c4e2 with SMTP id 6a1803df08f44-6f2c46458c0mr97829276d6.32.1745034476762;
        Fri, 18 Apr 2025 20:47:56 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af13f9sm17594616d6.14.2025.04.18.20.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 20:47:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fd97e9cc-50d7-4d99-a856-3151891eb397@redhat.com>
Date: Fri, 18 Apr 2025 23:47:54 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>, Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, hannes@cmpxchg.org,
 mkoutny@suse.com, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org
References: <20250418031352.1277966-1-gourry@gourry.net>
 <20250418031352.1277966-2-gourry@gourry.net>
 <aAMTLKolO0GWCoMN@slm.duckdns.org> <aAMYOxSOrVpjhtzT@gourry-fedora-PF4VCD3F>
Content-Language: en-US
In-Reply-To: <aAMYOxSOrVpjhtzT@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/25 11:27 PM, Gregory Price wrote:
> On Fri, Apr 18, 2025 at 05:06:20PM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Apr 17, 2025 at 11:13:52PM -0400, Gregory Price wrote:
>> ...
>>> +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
>>> +{
>>> +	return memcg ? cgroup_node_allowed(memcg->css.cgroup, nid) : true;
>>> +}
>>> +
>> ...
>>> +bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
>>> +{
>>> +	return cpuset_node_allowed(cgroup, nid);
>>> +}
>> ...
>>> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>>> +{
>> What does the indirection through cgroup_node_allowed() add? Why not just
>> call cpuset directly?
>>
> This is an artifact of me trying to figure out how to get this to build
> with allconfig (matrix of CPUSET and MEM_CGROUP).
>
> I think you're right, I can probably drop it.  I was trying to write :
>
> bool cpuset_node_allowed(struct cpuset *cs, int nid);

The cpuset structure isn't exposed externally. So you can't use cpuset 
from outside cpuset.c. Passing the cgroup structure is the right approach.

Cheers,
Longman

>
> and just couldn't do it, so eventually landed on passing the cgroup into
> the cpuset function, which means I think I can drop the indirection now.
>
> Will push it and see if allconfig builds.
>
> Thanks
>
> ~Gregory
>


