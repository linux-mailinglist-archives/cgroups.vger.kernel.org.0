Return-Path: <cgroups+bounces-91-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B37D7386
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 20:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C0A281A24
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB92AB41;
	Wed, 25 Oct 2023 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agk+5TLE"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2027EF8
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 18:47:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E43186
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698259627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUDjItQQjo3UPdZDmLpNvYnFjQ8bZdicYhlR0NUWUUk=;
	b=agk+5TLEh0ZIXWO1GtnG3otacjPEJS4Vy92gRcKQVVFLDfDqULvv8OqhN0x6juHL/Rvp/d
	KBRrFn9LEvVyIj1+2MzpbfhZePfvSGRkrsluIncfS1fH8ztyJUPnMQ30ZjTV0xPw757uZ4
	PFxfARX6trV6/131m4pwxw4iY4ggUz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-9dhxosdYO52Lgzigwoc7CQ-1; Wed, 25 Oct 2023 14:47:02 -0400
X-MC-Unique: 9dhxosdYO52Lgzigwoc7CQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78598811E91;
	Wed, 25 Oct 2023 18:47:01 +0000 (UTC)
Received: from [10.22.32.140] (unknown [10.22.32.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B173492BFA;
	Wed, 25 Oct 2023 18:47:01 +0000 (UTC)
Message-ID: <25bebe6f-9ff4-ed75-0041-2c6207c7d6f9@redhat.com>
Date: Wed, 25 Oct 2023 14:47:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH-cgroup 1/4] workqueue: Add
 workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20231013181122.3518610-1-longman@redhat.com>
 <20231013181122.3518610-2-longman@redhat.com>
 <ZS-kTXgSZoc985ul@slm.duckdns.org>
 <4e9cc6e3-7582-64af-76d7-6f9f72779146@redhat.com>
 <f8796057-e7f0-b589-783f-d11538aaafbf@redhat.com>
 <ZTc57JX2qZiXn3p4@mtj.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZTc57JX2qZiXn3p4@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 10/23/23 23:28, Tejun Heo wrote:
> Hello,
>
> On Wed, Oct 18, 2023 at 03:18:52PM -0400, Waiman Long wrote:
>> I have a second thought after taking a further look at that. First of all,
>> cpuset_allowed_mask isn't relevant here and the mask can certainly contain
>> offline CPUs. So cpu_possible_mask is the proper fallback.
>>
>> With the current patch, wq_user_unbound_cpumask is set up initially as
>> (HK_TYPE_WQ ∩ HK_TYPE_DOMAIN) house keeping mask and rewritten by any
>> subsequent write to workqueue/cpumask sysfs file. So using
> The current behavior is not something which is carefully planned. It's more
> accidental than anything. If we can come up with a more intutive and
> consistent behavior, that should be fine.
>
>> wq_user_unbound_cpumask has the implied precedence of user-sysfs written
>> mask, command line isolcpus or nohz_full option mask and cpu_possible_mask.
>> I think just fall back to wq_user_unbound_cpumask if the operation fails
>> should be enough.
> But yeah, that sounds acceptable.

I have implemented the fallback to the user requested cpumask in the 
failure case.

Cheers,
Longman


