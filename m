Return-Path: <cgroups+bounces-3606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2892DD2F
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 01:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C36B20C2C
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 23:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5314A0B2;
	Wed, 10 Jul 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccSDavV0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568D158859
	for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655502; cv=none; b=XOmHWj8Sy05TzOiSPsG8TjSA9I5BSvSUqA+XR0t42tkAukPWxi88+q8uIBJxCONstMMO4yRh8/vuOmViUWwKvYIRPiH8N+94zGEjYCcwIIgPAFWzaBqRwmvPUyHVfsCqSSaiYuqBjnfvq+TvMcsvMKTTAEl27OsAW4ayadz65l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655502; c=relaxed/simple;
	bh=npGFZ7+tSqeY2xxryGCHThpOWXBJ+gAv7JI9axGTi9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK05+djymQrxYMsIheEMgj4d75iq4jfMPGv73zVCN+wzrhC4cjV8mXaMZNzxB3sMG705snbBQGRu5ZUaB39agA8IeBseSjw7w3uAr62gi/xF4lO/jdnBnXevdRdUX7P6TzSWlra2p3oA6Q3ONd7RSQtxsJD0GhmjNWVYUkSMwag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccSDavV0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720655499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA5BtkAtts8DBgOsaPfYF+PKA9KEchHy7+koVC7lhY8=;
	b=ccSDavV0HT+0fqgmbugnCdJUMKszXDaxXpPPwASNvbzmQ1Kxz+xLXeIviSfoV/SaSExLOf
	uTjAnhHg7aPqfk40jxYQjpMYxJQsi5d279avc4NlwBa+zTRxea6TGrVxQxA0W8VBXUcGsM
	OwfjonjOzFg55Lu8UdWUrcd9dMzzOBs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-gbRn394WMUSJ9IOq0kwrXQ-1; Wed,
 10 Jul 2024 19:51:35 -0400
X-MC-Unique: gbRn394WMUSJ9IOq0kwrXQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AAEF1955F43;
	Wed, 10 Jul 2024 23:51:33 +0000 (UTC)
Received: from [10.22.48.10] (unknown [10.22.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DBBC1955F40;
	Wed, 10 Jul 2024 23:51:31 +0000 (UTC)
Message-ID: <fc72e655-bb17-4b55-b00e-1fc640d35d77@redhat.com>
Date: Wed, 10 Jul 2024 19:51:30 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240710182353.2312025-1-longman@redhat.com>
 <Zo8ELsGOyFwkpKUj@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zo8ELsGOyFwkpKUj@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 7/10/24 17:59, Tejun Heo wrote:
> Hello,
>
> On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 54
>> 	nr_dying_descendants 44
>> 	nr_cpuset 1
>> 	nr_cpu 40
>> 	nr_io 40
>> 	nr_memory 54
>> 	nr_dying_memory 44
>> 	nr_perf_event 55
>> 	nr_hugetlb 1
>> 	nr_pids 54
>> 	nr_rdma 1
>> 	nr_misc 1
> So, css may be too specific a name but this looks a bit disorganized. How
> about using controller as the common prefix? Maybe something like:
>
> 	nr_controllers_cpu 40
> 	nr_controllers_io 40
> 	nr_controllers_memory 54
> 	nr_controller_perf_event 55
> 	...
> 	nr_dying_controllers_memory 44
>
> If controllers is too long, we can shorten it somehow or use subsys, maybe?

I think "controllers" is too long. I am fine with "subsys". Will make 
change in the next version.

Thanks,
Longman


