Return-Path: <cgroups+bounces-7037-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C3A5EF29
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 10:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE5717DD3E
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB07226462C;
	Thu, 13 Mar 2025 09:09:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BCD263F21;
	Thu, 13 Mar 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856992; cv=none; b=ZzqFfZU1q/QVnBQ6iQ9+0c4BHMwUrpVGYQaOic+n4BGKVIwWjFx3trH1VYSxrqYFPht/1YTcB0OdGCVQSOkfK1ZSKMIteIihoagGFpO72tk4navU5I+TVwFVZoUlB2L2i/aLl5Txtu+uB9pcnaaJWbBo10FDebqmwzSDYKAQ6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856992; c=relaxed/simple;
	bh=PISbjvmZ2iSJq7UyQIYr5UmXSsSNQDC6otnvjIpHCtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpeXV6MtcxKp33GMnZcI8vWnmI37ZXsY3pLGU4ImVLgeW9Wx+nntl141qMpwsk1VTWFZ6TWx2nQZyWdz6+tSsi10KdVqHHd7soPNdftYI8qehPpCNukCN4ODMYTgxhPGRnxTd5ahEe6+SQuBTuvihnLypESo4D6CZfAM/uVgB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D655C150C;
	Thu, 13 Mar 2025 02:09:55 -0700 (PDT)
Received: from [192.168.178.45] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438523F694;
	Thu, 13 Mar 2025 02:09:42 -0700 (PDT)
Message-ID: <433bb604-1490-4ac0-8e25-1b2f7464ef76@arm.com>
Date: Thu, 13 Mar 2025 10:09:34 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
 <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
 <Z9GWAbxuddrTzCS9@jlelli-thinkpadt14gen4.remote.csb>
 <78bc0eda-7471-404d-a816-bd5f1a8d4b27@arm.com>
 <Z9G7mMQ3xG15FmLy@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <Z9G7mMQ3xG15FmLy@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.03.25 17:51, Juri Lelli wrote:
> On 12/03/25 17:29, Dietmar Eggemann wrote:
>> On 12/03/2025 15:11, Juri Lelli wrote:
>>> On 12/03/25 09:55, Waiman Long wrote:
>>>> On 3/12/25 6:09 AM, Juri Lelli wrote:
>>>>> On 12/03/25 10:53, Dietmar Eggemann wrote:
>>>>>> On 11/03/2025 15:51, Waiman Long wrote:
>>
>> [...]
>>
>>>>> I unfortunately very much suspect !CPUSETS accounting is broken. But if
>>>>> that is indeed the case, it has been broken for a while. :(
>>>> Without CONFIG_CPUSETS, there will be one and only one global sched domain.
>>>> Will this still be a problem?
>>>
>>> Still need to double check. But I have a feeling we don't restore
>>> accounting correctly (at all?!) without CPUSETS. Orthogonal to this
>>> issue though, as if we don't, we didn't so far. :/
>>
>> As expected:
>>
>> Since dl_rebuild_rd_accounting() is empty with !CONFIG_CPUSETS, the same
>> issue happens.
> 
> Right, suspicion confirmed. :)
> 
> But, as I was saying, I believe it has been broken for a while/forever.
> Not only suspend/resume, the accounting itself.
> 
> Would you be OK if we address the !CPUSETS case with a separate later
> series?

Yes, we can do that.


