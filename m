Return-Path: <cgroups+bounces-4534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BCA961AED
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 02:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCA51C22C5A
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE63A48;
	Wed, 28 Aug 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKq1MmgZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D47E9
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803633; cv=none; b=Lsbr18Y3TM3SCiLU2u9xRv5hLz1TXWkH14KFAboMyTH6Ib0ufuo3MydN3t1Bw7IOx9eo8RLu3vnSwby4rnVf4HRp+WEtx0h25CREWBlchc/nMz53FWe5+jbFMtAmEMcUj1OpRNdKLZwMmPbYWNiSpZX7WixrPYCKl6ZUhjrcM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803633; c=relaxed/simple;
	bh=qQqmBa0W8fvgslTNvjBfKOgFUQPAR8cRbtGybVuDQeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWcMUGubVNjPE//mThKmK8wyXqoEpSv2HJmrewTQg6X0/rK5Ke3CtACcUum8612Oo/RMjXdagtEWR8x+h9Am3kdqfeR8S9u0xqsSfhNz0Tf92l8hPz0uk7ZJFj97Zpt88PX03PAW/+K4Owcm+USpFuWgtec9pjjCIALulhcCgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKq1MmgZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724803630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHQcD4+PN18ZZ63oIe9lniNfSTtIjukAYPuWWs81cnU=;
	b=SKq1MmgZb2pTMTOswW5v3tmyiynmyXj+ucUsdrxVf/aITC+sKSf0VG9Y0VWE0tQ+oKsa0F
	Df/FSh9wDG7OHXdTR1DkeqWLrlBuAJjQ8hluKPJSDjCMEEtGlhdFJGRuuYq8Bpqj4xEJk8
	dX6eJT1Yw6sL+wZNaWivu4l+j02kLPI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-E1-E-LNXOpOgxzmhVQUZ3Q-1; Tue,
 27 Aug 2024 20:07:07 -0400
X-MC-Unique: E1-E-LNXOpOgxzmhVQUZ3Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2843B1955D4B;
	Wed, 28 Aug 2024 00:07:05 +0000 (UTC)
Received: from [10.2.16.33] (unknown [10.2.16.33])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DD321955DA8;
	Wed, 28 Aug 2024 00:07:02 +0000 (UTC)
Message-ID: <db9c50d1-4a44-47aa-91ab-0ae33be6ef2a@redhat.com>
Date: Tue, 27 Aug 2024 20:07:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 1/2] cgroup/cpuset: Account for boot time isolated
 CPUs
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240820195536.202066-1-longman@redhat.com>
 <20240820195536.202066-2-longman@redhat.com>
 <7ropw3hu6low47tklrjj66zb4ldrzzes7rkn5vwfguu5jvvr3a@3lxrzrbqbod7>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7ropw3hu6low47tklrjj66zb4ldrzzes7rkn5vwfguu5jvvr3a@3lxrzrbqbod7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 8/27/24 04:01, Michal Koutný wrote:
> Hi.
>
> On Tue, Aug 20, 2024 at 03:55:35PM GMT, Waiman Long <longman@redhat.com> wrote:
>> The prstate_housekeeping_conflict() function does check the
>> HK_TYPE_DOMAIN housekeeping cpumask to make sure that CPUs outside of it
>> can only be used in isolated partition.
>> Given the fact that we are going to make housekeeping cpumasks
>> dynamic, the current check may not be right anymore. Save the boot
>> time HK_TYPE_DOMAIN cpumask and check against it instead of the
>> upcoming dynamic HK_TYPE_DOMAIN housekeeping cpumask.
> Why is (will be) checking against the stored HK_TYPE_DOMAIN mask correct
> when this mask becomes dynamic?

In term of isolated CPUs, there are 2 categories - static and dynamic. 
Statically isolated CPUs are those that are designed as isolated at boot 
time by "isolcpus". Other isolated CPUs created by the cpuset isolated 
partitions are considered dynamic in the sense that its state can change 
at run time. The degree of CPU isolation of dynamically isolated CPUs 
isn't as good as that of the statically isolated ones. So I want to 
handle them separately which is what the prstate_housekeeping_conflict() 
is intended to do.

As it is my intention to make the housekeeping cpumasks dynamic, I need 
to keep a copy of the statically isolated CPUs and check against them. 
There is no point to check dynamically isolated CPUs as the test may 
produce a false positive result.

In the future when dynamic CPU isolation is as almost as good as the 
static ones, we can get rid of this distinction and treat all of them as 
dynamic.

Cheers,
Longman


