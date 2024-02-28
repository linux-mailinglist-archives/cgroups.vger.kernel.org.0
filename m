Return-Path: <cgroups+bounces-1896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8106F86B105
	for <lists+cgroups@lfdr.de>; Wed, 28 Feb 2024 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE572841B0
	for <lists+cgroups@lfdr.de>; Wed, 28 Feb 2024 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C291534EF;
	Wed, 28 Feb 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b="f9+Rrdk4"
X-Original-To: cgroups@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D114F9FA;
	Wed, 28 Feb 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128583; cv=none; b=aPc6JBjURXI3t8C81Xrguh1xf0CuUQL6S0UXJXopDyXnARMlh0CNe/YeYNSBfUH/WY5BiuHHADcCjnEtRUEnxgeHGzRrZq+ij7Fa0WcvxfirUIQkdB07zoWXsdS03uPLnhFK7Qt4TQtkWaw1TDiLzV7JzH1qnscJzFIkuWAP4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128583; c=relaxed/simple;
	bh=4pWP2GQkp8/f0e8eY0vksB+WBnEVCChl4tswm7EQ4xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9BxRw7EJw7Q2dt11sh8jeWGZ6m2zPdrX7pCrSXGGL7UbQaXXYr6NTkfUYW9VQZ5qMVvCDvS3UMV/QKtqppnhg9hJRUnw5UjwzYx6TOPiAKe4fpwzbibZUg+VejUvWL8kUbYtPLbd2UO8ZUUIHf/cDe1EsXnd4iZcMDu6m0Rd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr; spf=pass smtp.mailfrom=alu.hr; dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b=f9+Rrdk4; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 396DB6019E;
	Wed, 28 Feb 2024 14:56:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
	t=1709128572; bh=4pWP2GQkp8/f0e8eY0vksB+WBnEVCChl4tswm7EQ4xA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f9+Rrdk4kbZqgHk16RXmPt22nqVwJcacPfo4ayPEmnw9PNpDUuz7IQqemXYA3mxcb
	 4AORLqp6RPXUkduoDX2S/O4pvWc3/7C1rnj9HB+9I8NXdMhnxPlTn/w3Y4Ov2oX4DM
	 yGVjV/d6BZ4Al+zkZbo5Lf+T9CYNeXu3xcpFlKauIKX2ctZQeSqxhUC7wLb4Koe4EO
	 x0eK0VAtXF5whvW6dL2j6mU9fZs7qQhvam52C0oQI1anjJtw6FOnvhz9Rl4XLp+66n
	 p6jiatojxNT+JUSMXPyrHe1JHC3qg57Y7fvCOgppk5OULKOv+ByjE4IUgxhsdFkC8h
	 j/VlFPHeI65SA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C5bqcllQsldQ; Wed, 28 Feb 2024 14:56:09 +0100 (CET)
Received: from [192.168.100.10] (unknown [161.53.83.3])
	by domac.alu.hr (Postfix) with ESMTPSA id 4689E60197;
	Wed, 28 Feb 2024 14:56:09 +0100 (CET)
Message-ID: <bc055871-9aa7-4165-bb54-39520349dc16@domac.alu.unizg.hr>
Date: Wed, 28 Feb 2024 14:56:08 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Fix a memory leak in
 update_exclusive_cpumask()
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mirsad Todorovac <mirsad.todorovac@alu.hr>
References: <20240228005801.429847-1-longman@redhat.com>
From: Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <20240228005801.429847-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/28/2024 1:58 AM, Waiman Long wrote:
> Fix a possible memory leak in update_exclusive_cpumask() by moving the
> alloc_cpumasks() down after the validate_change() check which can fail
> and still before the temporary cpumasks are needed.
>
> Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.hr>
> Closes: https://lore.kernel.org/lkml/14915689-27a3-4cd8-80d2-9c30d0c768b6@alu.unizg.hr
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ba36c073304a..7260f095802a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2598,9 +2598,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
>   		return 0;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> -		return -ENOMEM;
> -
>   	if (*buf)
>   		compute_effective_exclusive_cpumask(trialcs, NULL);
>   
> @@ -2615,6 +2612,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (retval)
>   		return retval;
>   
> +	if (alloc_cpumasks(NULL, &tmp))
> +		return -ENOMEM;
> +
>   	if (old_prs) {
>   		if (cpumask_empty(trialcs->effective_xcpus)) {
>   			invalidate = true;Great work at such a short notice! (I failed to find the culprit myself.)

The leak is no longer present.

Please feel free to add:

Tested-by: Mirsad Todorovac <mtodorov@alu.unizg.hr>

Best regards, Mirsad Todorovac

P.S. APologies for the previous email accidentally sent as HTML.


