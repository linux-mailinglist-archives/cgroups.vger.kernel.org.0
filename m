Return-Path: <cgroups+bounces-12183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D621C82FB2
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 02:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C13EC34B17F
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A51F874C;
	Tue, 25 Nov 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtXT5THq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7rFWSwY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2388191484
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032979; cv=none; b=pwFXwqd0BRJnI7hm/yHrTyE/bhOErtd8xcP7HZUiXUimr4Qba+jY5eCyTzsQZRVSOI5XoooQXgYns1izNofL5gL1GoaA/8V8B68gLsNWcxZELbgioza4T3wQgX6TenGji4DGe1kzUI2SBLZeCQVY1abWurEFHICepunhdUwtYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032979; c=relaxed/simple;
	bh=6Z1BDcw1KlB4F6PpLLVbr9RimvJrrz5j4t3fEvmprvw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uDPlf+BWMoGyZvZpFp2+ZIZz9k45kmptCsyhG2CZqAcJ5dYWxNgeRD3rn6hWGZLRdUW1XnrAsBuH4PqKH8DtQBHahpiWJSzONOaianvhvcQDfQK0LX6E1ZWEOZuZJfh0sMAYHmNNmpDAoJ3ZGggLb7zFvhJ5j62AM0HxGXJts60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtXT5THq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7rFWSwY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764032976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nx/23Bwfo1PUIBqHCTdUdrkLmvnnrvsRIe7fjcVL5wo=;
	b=OtXT5THqmmL1qotbeLHMiGwHfxMVah3x3JnHscQBCikpKTK0LCrm54W53p9Agni2L3LKVR
	SynvF+X3ZY7cKFeTA4GEEgFVOtIvHBrqBxbWUofKk0CkQN22dBGQ4i0fxfp6uevll+H2xD
	TS8WBoIX7JzmFy8t7W5xAmdQ8reMhEk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-IEefgO9YM7KbIG4SIcr_Tg-1; Mon, 24 Nov 2025 20:09:34 -0500
X-MC-Unique: IEefgO9YM7KbIG4SIcr_Tg-1
X-Mimecast-MFC-AGG-ID: IEefgO9YM7KbIG4SIcr_Tg_1764032974
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee04f4c632so97695331cf.3
        for <cgroups@vger.kernel.org>; Mon, 24 Nov 2025 17:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764032974; x=1764637774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nx/23Bwfo1PUIBqHCTdUdrkLmvnnrvsRIe7fjcVL5wo=;
        b=L7rFWSwYfPPYPcH3lh58efpmFljTsUbxQ/fs6lV5ppp0AJSyLd/vo+HBVkHNZM6eHH
         H9GmKAZBXJJlpnfoCqRTiuXOXPDhTFq1JjbNo122nEN6jrt7D4AXsWWbaGM7S989voGe
         Wv6Jm7m67khojFinKwq2uJacTweC7LM8bCOOZihE5KZDtKuY76OiLpMSLp+zymTS1bk2
         J1vgdBZJ/RmITMQsZUvuC62p8ip04OMeRBXqDZeAE6eyHBVu2teQregTksEmv51o0TAq
         /rf4hHinQ1oOOOS0eVaTO296cpmAcCZabNL490NbkzQ+GOWTKUjJ82T22b1BVT/kYJl4
         i14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764032974; x=1764637774;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx/23Bwfo1PUIBqHCTdUdrkLmvnnrvsRIe7fjcVL5wo=;
        b=e+AxQR/wg1Zj8KIOlAU/6zzfVB/0EAbMZi68IG1VKISKt+srRElb/2bgss6u06V2Js
         cTS5zvgEQoZcujnbsGsPq7ccBFeZk7Z1axz+xEcNZvEO2a4D8rQqiKUlP5XADzsWSEEE
         q/wl3zTE6jeNdjOkMNX/Fv6wgTg8VEOSe8Pa3la+t8KtbpKkwiBXMrMsdyJwDziZsnmv
         dcoTM1+Nt9aB3nxvT14ylEF4KXzr4L/8kT5SH7ZyF+9eopSlC9uFJiRtAN1cCGxGc4kL
         iXAZu5r4GD/Dyun6362vTScbqi6jd4Sg1HpF/dmLOtRNtMn7T/Z+VKuEll/vRWBV/Gii
         E4Xg==
X-Gm-Message-State: AOJu0YygUimr4F6BgRWDeuaP/NjJAqBgnXPZKk/mbmMplzFGhHrR98N0
	DVEpZUOdI1juERDbiTSwzFRNe6YCdDTKJLkcesLmoFeIK4kggpihjBNhMVJiJ058N7UJVsiNOnS
	48Buf3ODaGkU7M4rRj3uAWPj/wl+wj4XQsEb8/q/YY4bwJoOE9yYamViokt8=
X-Gm-Gg: ASbGncvUAmTn1OkKTnby1Rcmj8IRitn9vu03JqQn41Tcbt6ywRJzGrKf/b8QGnluvKr
	GLHrxPsYs/MCkKDK6RytfoVUJOdt5/p8n34UA3pomX1VBvhHqehqn5XfpTF6EyOuMCOmsgZyv48
	SO/2aZEcPHjeIqIw6vnVia2b6HPkKMVOLQa4EenK7tRFQ5Q5FuoMfaU/4/2kdLTwELzlTcqAqGJ
	PnscBE+g7/Y3cNIrg275fCsxELm252zcSLa2NqnA6bJTBo3Nh8gyOqVP8fXuu4n8g97Gs4SHsaj
	JXYRwsEXMWOC8KjPD7iwtR74bGsbAaoo/dA9gbFgJsvsinPSUHAMovC+d5PAtsNLlk0IHDSK2a7
	Lhal7hNxgehvbf4BQGG9QunLXHanLC2Oo7Hj0+A8GQAHeXUvAr80TIVCC
X-Received: by 2002:a05:622a:1792:b0:4ee:1dd0:5a47 with SMTP id d75a77b69052e-4ee58b2bc3fmr163064521cf.76.1764032973809;
        Mon, 24 Nov 2025 17:09:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKDhpFuUZ96pCci0ccMK1NkhxOsb3GvFntKeSxw5SW4EgxzEvHWARR7mZWAzHTozk0dAIJig==
X-Received: by 2002:a05:622a:1792:b0:4ee:1dd0:5a47 with SMTP id d75a77b69052e-4ee58b2bc3fmr163064301cf.76.1764032973356;
        Mon, 24 Nov 2025 17:09:33 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e8ecfcsm94548801cf.29.2025.11.24.17.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 17:09:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ca3b31ca-e9c3-41e8-ae88-d4b126f574b3@redhat.com>
Date: Mon, 24 Nov 2025 20:09:31 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 00/21] cpuset: rework local partition logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251117024627.1128037-1-chenridong@huaweicloud.com>
 <2943236a-bb0e-4417-aee4-31146988709a@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <2943236a-bb0e-4417-aee4-31146988709a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 7:49 PM, Chen Ridong wrote:
>
> On 2025/11/17 10:46, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The current local partition implementation consolidates all operations
>> (enable, disable, invalidate, and update) within the large
>> update_parent_effective_cpumask() function, which exceeds 300 lines.
>> This monolithic approach has become increasingly difficult to understand
>> and maintain. Additionally, partition-related fields are updated in
>> multiple locations, leading to redundant code and potential corner case
>> oversights.
>>
>> This patch series refactors the local partition logic by separating
>> operations into dedicated functions: local_partition_enable(),
>> local_partition_disable(), and local_partition_update(), creating
>> symmetry with the existing remote partition infrastructure.
>>
>> The series is organized as follows:
>>
>> 1. Infrastructure Preparation (Patches 1-2):
>>     - Code cleanup and preparation for the refactoring work
>>
>> 2. Introduce partition operation helpers (Patches 3-5):
>>     - Introduce out partition_enable(), partition_disable(), and
>>       partition_update() functions.
>>
>> 3. Use new helpers for remote partition (Patches 6-8)
>>
>> 4. Local Partition Implementation (Patches 9-12):
>>     - Separate update_parent_effective_cpumask() into dedicated functions:
>>       * local_partition_enable()
>>       * local_partition_disable()
>>       * local_partition_update()
>>
>> 5. Optimization and Cleanup (Patches 13-21):
>>     - Remove redundant partition-related operations
>>     - Additional optimizations based on the new architecture
>>
>> base-commit: 6d7e7251d03f98f26f2ee0dfd21bb0a0480a2178
>>
>> ---
>>
>> Changes from RFC v2:
>> 1. Dropped the bugfix (already merged/fixed upstream)
>> 2. Rebased onto next
>> 3. Introduced partition_switch to handle root state switches
>> 4. Directly use local_partition_disable()—no longer first introduce
>>     local_partition_invalidate() before unifying the two
>> 5. Incorporated modifications based on Longman's suggestions
>>
>> Changes in RFC v1:
>> 1. Added bugfix for root partition isolcpus at series start.
>> 2. Completed helper function implementations when first introduced.
>> 3. Split larger patches into smaller, more reviewable units.
>> 4. Incorporated feedback from Longman.
>>
>> Chen Ridong (21):
>>    cpuset: add early empty cpumask check in partition_xcpus_add/del
>>    cpuset: generalize the validate_partition() interface
>>    cpuset: introduce partition_enable()
>>    cpuset: introduce partition_disable()
>>    cpuset: introduce partition_update()
>>    cpuset: use partition_enable() for remote partition enablement
>>    cpuset: use partition_disable() for remote partition disablement
>>    cpuset: use partition_update() for remote partition update
>>    cpuset: introduce local_partition_enable()
>>    cpuset: introduce local_partition_disable()
>>    cpuset: user local_partition_disable() to invalidate local partition
>>    cpuset: introduce local_partition_update()
>>    cpuset: remove update_parent_effective_cpumask
>>    cpuset: remove redundant partition field updates
>>    cpuset: simplify partition update logic for hotplug tasks
>>    cpuset: use partition_disable for compute_partition_effective_cpumask
>>    cpuset: use validate_local_partition in local_partition_enable
>>    cpuset: introduce validate_remote_partition
>>    cpuset: simplify the update_prstate() function
>>    cpuset: remove prs_err clear when notify_partition_change
>>    cpuset: Remove unnecessary validation in partition_cpus_change
>>
>>   kernel/cgroup/cpuset.c | 1014 ++++++++++++++++++----------------------
>>   1 file changed, 453 insertions(+), 561 deletions(-)
>>
> Hi Longman,
>
> I would greatly appreciate it if you could review this series when you are available.
>
I was expecting a v3 and so I had probably missed it. Will take a look 
sometimes this week.

Cheers,
Longman


