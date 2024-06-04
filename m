Return-Path: <cgroups+bounces-3096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9518FB67B
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2111C22CC4
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D24D846D;
	Tue,  4 Jun 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAuI3hV4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCA13CA9A
	for <cgroups@vger.kernel.org>; Tue,  4 Jun 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513385; cv=none; b=TRBJslWKrCwneF6dlqHAtfAIWkyFhPqsmOYfezhvA7Z/r9srVuNtdG9rv7stwbkvbq4PJBltpFKE8jRmZpTplQTTMvDm07/xktGwcJqe1lljqsrqgaVAmLV0F/5vFN3PNxDqrEBrPb84VxUqihSIP2Sm8IYfZoxffhxvmzpctx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513385; c=relaxed/simple;
	bh=4TQW0kfgzyxz8gaP9ctr2Nr1tEvi9I6QOkgJu5JS7zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZkhrv9f5/dct6Dq6zCiXD23nVPfz2ypQcJnHpB3T7rNpI7y2YjybiEyQrpc0d00KGyMlTEkM0xUCZ1p+1vWqiLpS5rk46S5NRDeVNE8P8D/y3CSBRbY0KZuyGFPn3daGorBRh4T1LBbnM7yzz1VEa1UEnxiSsP7hzCbzq8ZQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAuI3hV4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717513382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HeKLp06cYpYp9T9CdViOJHM4DaddkJicTfYxHrEBRA=;
	b=bAuI3hV4SsW4TuHTZ3pP8b5nlraR8sf6rckYC9rgPGpxbJLh4TKluSHCjf0f1L6IJdVPXJ
	bE9r/enxjVAvthW60ukLQeZbPe5YsuZZeqzMNYL4//neA45Mm3oYTr2a2zMU2/U8UoBq5X
	k1g1B0jEmlW6UhvBcIhVBeoMjuqhZCM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-sBQ9Z7ckMCK9d-dAK7eg6g-1; Tue,
 04 Jun 2024 11:02:58 -0400
X-MC-Unique: sBQ9Z7ckMCK9d-dAK7eg6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 663333C0008A;
	Tue,  4 Jun 2024 15:02:58 +0000 (UTC)
Received: from [10.22.17.111] (unknown [10.22.17.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A769E492BDB;
	Tue,  4 Jun 2024 15:02:57 +0000 (UTC)
Message-ID: <6a2b7129-febc-4dd2-b493-7f43e061a2a6@redhat.com>
Date: Tue, 4 Jun 2024 11:02:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpuset: use Union-Find to optimize the merging of
 cpumasks
To: Xavier <ghostxavier@sina.com>
Cc: lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531024837.255293-1-ghostxavier@sina.com>
 <20240603123101.590760-1-ghostxavier@sina.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240603123101.590760-1-ghostxavier@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 6/3/24 08:31, Xavier wrote:
> The process of constructing scheduling domains involves multiple loops
> and repeated evaluations, leading to numerous redundant and ineffective
> assessments that impact code efficiency.
>
> Here, we use Union-Find to optimize the merging of cpumasks. By employing
> path compression and union by rank, we effectively reduce the number of
> lookups and merge comparisons.
>
> Signed-off-by: Xavier <ghostxavier@sina.com>
>
> Hi Longman,
>
> Thank you for your feedback on the previous version of the patch.
>
> Now I will respond to the three questions you raised:
> 1) The function comment describes the algorithm to find the set of
> domains. If you change the algorithm, you have to update the comment as
> well.
>
> Reply: Sorry for not paying attention to the comments before. The new patch (v3) has updated the comment content.
>
> 2) generate_sched_domains() is not in a performance critical path, so
> its performance is not as important. Also the csn array is typically not
> that big. Changing the algorithm may introduce new bugs which leads to
> the next point.
>
> Reply: Indeed, this function is not a critical path impacting performance, but it's always good to optimize efficiency. The optimization is limited to the internals of this function and does not affect other modules, so fixing the internal bug should have manageable risks.

In term of efficiency, your patch does eliminate the third iteration (k) 
in the csn iteration loop. However the new union_sets() function may go 
up the node hierarchy which can considered a third iteration in some 
way. So there is some saving, but not as significant as it looks. It 
does simplify the code and make it a bit easier to read.

>
> 3) How do you test your code to ensure its correctness?
> I applied your patch and run the ./test_cpuset_prs.sh got the following...
>
> Reply: I'm very sorry, this is my first time submitting a kernel patch and I don't know which test cases need to be run. I just constructed some scenarios locally to test, so the testing scope is limited. Thank you for providing the test cases. I have reproduced and resolved the issue, and have passed several other test cases in CGroup. But currently, I only have QEMU simulation environment, so my testing ability is limited. I hope you can help me with some comprehensive testing of my new version patch. Thank you very much.
>
> I hope you can pay further attention to the new patch.

Also your patch eliminates all the use of the cpuset->pn variable. So 
you cab remove it as it is no longer needed.

After a harder look at the generate_sched_domains() code, I have found a 
bug in the code with respect to the support of remote partition. I will 
send another patch to fix it. I also realize that the function was 
originally designed to support v1 cpuset. v2 cpuset is quite different 
and the code can be simplified for the v2 use case.

You are welcome to send a v4 patch on top of the new cpuset code base.

Thanks,
Longman


