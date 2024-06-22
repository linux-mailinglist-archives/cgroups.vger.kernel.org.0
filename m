Return-Path: <cgroups+bounces-3284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96809135F9
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 22:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37CF282351
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7259168;
	Sat, 22 Jun 2024 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIyXhw6A"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF9208CA
	for <cgroups@vger.kernel.org>; Sat, 22 Jun 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719087189; cv=none; b=mG2sqsBkEBVojlo19cIUAnP9w4S26jx7IBkVwgJwT1+eymox1f4Ecb2kAiuVGHQ8agLynxXtxqMJE0L28SUEEVntWwcSHXnrMs9Xlb0MTdF01NPk6Y1Iv6wnK2j5QVnGdd/YRwXoeOzTDexLeL2NzIZ2aO4abdTXY0o3VzKBZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719087189; c=relaxed/simple;
	bh=9QTVTTAr/bLgfzwDbYy9kX0trwJMsoi07Zv5cyxqpSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSmH8VcJpkNCLgscowL8qSFNxn6derV5P4qSFQYW2DxJCDe8tWu/L5s/pE8d4hYAbq1W9Gq1rfa9D1qa9ebWcvWz/MNZPugVImaspba4VvdNfju+ovqZGwgOI7/yZaaPNtvbcueP0f59sQsFWWwkbS8YL4P09a4yuJN/oHmLUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIyXhw6A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719087186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVloH0O0knxKGVZtXf1+vpovAON8LePlPVCgLz6irFQ=;
	b=iIyXhw6AdN9JdMwyxGPodclDyfFTI4MB4MlPh3duKCBgiCc95sFxEYz3zVo+LWEriZtAqk
	ckwwhiZqBM6jO/ovEomEAlqji1REl19eSQ9TyjsQMMYE9l//zUJzAS0y2RG/boTSE+s5iI
	BhCMPB+Fv45nXVdhdO9gr/c2KLQGRSQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-Z4Gct5fHPVa8Np_ctXthlg-1; Sat,
 22 Jun 2024 16:13:02 -0400
X-MC-Unique: Z4Gct5fHPVa8Np_ctXthlg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEA5819560AD;
	Sat, 22 Jun 2024 20:13:00 +0000 (UTC)
Received: from [10.22.32.34] (unknown [10.22.32.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84F6719560BF;
	Sat, 22 Jun 2024 20:12:58 +0000 (UTC)
Message-ID: <2c70eff8-c79a-4c99-b8db-491ce25745a0@redhat.com>
Date: Sat, 22 Jun 2024 16:12:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Markus Elfring <Markus.Elfring@web.de>,
 Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <b8792fb5-9efe-4dfc-ab61-6fa55a4b0d51@web.de>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <b8792fb5-9efe-4dfc-ab61-6fa55a4b0d51@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 6/22/24 16:04, Markus Elfring wrote:
> …
>> +++ b/kernel/cgroup/cpuset.c
> …
>> @@ -5051,10 +5066,12 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>>   	if (!buf)
>>   		goto out;
>>
>> +	mutex_lock(&cpuset_mutex);
>>   	css = task_get_css(tsk, cpuset_cgrp_id);
>>   	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>   				current->nsproxy->cgroup_ns);
>>   	css_put(css);
>> +	mutex_unlock(&cpuset_mutex);
> …
>
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&cpuset_mutex);”?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L196

A mutex guard will be more appropriate if there is an error exit case 
that needs to be handled. Otherwise, it is more straight forward and 
easier to understand with the simple lock/unlock.

Cheers,
Longman


