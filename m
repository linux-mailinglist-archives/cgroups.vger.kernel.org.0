Return-Path: <cgroups+bounces-412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B177EB5AA
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841C12812AD
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDD2C19E;
	Tue, 14 Nov 2023 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFx6txvV"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF40D2E8
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 17:40:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD95FF
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699983652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9Q6PGcPJmoGKurJgt6K4Z+fQ7WE1chv/RiIO3wgaBc=;
	b=iFx6txvVFy+eX/WOqxupHrlNhacRbe1M4YQBuku4kq5eYn+5QVC7K+FOFuUfGXcvI9Hzs8
	gA48QFvJphVe/+m46n1H2YHI8O44VL1IpjUd7rnPk6NDTYNMqtaZsMbM/1MGcTq32DpHXF
	zq3n/mIzk/08QbZzHO8cNY77HZlK9N4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-xDTvQo4xNYyGmjiZcPzXyg-1; Tue, 14 Nov 2023 12:40:48 -0500
X-MC-Unique: xDTvQo4xNYyGmjiZcPzXyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 682AC811E7B;
	Tue, 14 Nov 2023 17:40:47 +0000 (UTC)
Received: from [10.22.32.154] (unknown [10.22.32.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36578112130B;
	Tue, 14 Nov 2023 17:40:47 +0000 (UTC)
Message-ID: <f14e370c-5792-4a59-986d-50081a49e0d4@redhat.com>
Date: Tue, 14 Nov 2023 12:40:46 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tj-cgroup:for-next] BUILD REGRESSION
 e76d28bdf9ba5388b8c4835a5199dc427b603188
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, kernel test robot <lkp@intel.com>
Cc: cgroups@vger.kernel.org
References: <202311131910.pxATTnsK-lkp@intel.com>
 <ZVObbkEVn8-fnzZ3@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZVObbkEVn8-fnzZ3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 11/14/23 11:08, Tejun Heo wrote:
> On Mon, Nov 13, 2023 at 07:12:12PM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
>> branch HEAD: e76d28bdf9ba5388b8c4835a5199dc427b603188  cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
>>
>> Error/Warning reports:
>>
>> https://lore.kernel.org/oe-kbuild-all/202311130831.uh0AoCd1-lkp@intel.com
>>
>> Error/Warning: (recently discovered and may have been fixed)
>>
>> kernel/workqueue.c:5848:12: warning: 'workqueue_set_unbound_cpumask' defined but not used [-Wunused-function]
>>
>> Error/Warning ids grouped by kconfigs:
>>
>> gcc_recent_errors
>> |-- i386-tinyconfig
>> |   `-- kernel-workqueue.c:warning:workqueue_set_unbound_cpumask-defined-but-not-used
> The function is going to be used by a follow-up patch that Waiman is
> currently updating, so I'm going to leave it as-is for now. Looks like we'll
> need CONFIG_SYSFS || CONFIG_CPUSETS guarding it no matter what tho. Waiman,
> can you please add that to the rest of your series?
>
> Thanks.
>
Sure, I will make the necessary update. I am now in the LPC, so it may 
be a bit late in response.

Cheers,
Longman


