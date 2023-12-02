Return-Path: <cgroups+bounces-771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B6801A25
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 03:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F341F21119
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF744411;
	Sat,  2 Dec 2023 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzUkGVKs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63981D4A
	for <cgroups@vger.kernel.org>; Fri,  1 Dec 2023 18:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701485812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvwjUNJeoy2IcJbz1Tc64DxOTpWO3+WIeQ+/gLfl3dg=;
	b=AzUkGVKs/qDFMVJhC2Rb0Xn8hVW7oE7bxzh23HUil4U7BDrMP7Mii36dkelGuBRaJhQtiU
	RgdnnjXXsOTColrDudU9jYuKmgveFgSC8mV+qNfxyQwHaiGuSowrhuxWIYNHVWs2M2fVCS
	ajjwgBSpfz2dGo/UM1WIFRo8ARBGsak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-cgIriIYhNUmYe3leOGzmkA-1; Fri, 01 Dec 2023 21:56:50 -0500
X-MC-Unique: cgIriIYhNUmYe3leOGzmkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE235185A781;
	Sat,  2 Dec 2023 02:56:49 +0000 (UTC)
Received: from [10.22.17.155] (unknown [10.22.17.155])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47B9840C6EB9;
	Sat,  2 Dec 2023 02:56:48 +0000 (UTC)
Message-ID: <436e96d1-29eb-49ec-a463-2ed420757ce8@redhat.com>
Date: Fri, 1 Dec 2023 21:56:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>, Yosry Ahmed
 <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
 Greg Thelen <gthelen@google.com>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
 Attreyee M <tintinm2017@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux CGroups <cgroups@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <ZWqPBHCXz4nBIQFN@archie.me>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZWqPBHCXz4nBIQFN@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 12/1/23 20:57, Bagas Sanjaya wrote:
>> -void mem_cgroup_flush_stats(void)
>> +/*
>> + * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
>> + * @memcg: root of the subtree to flush
>> + *
>> + * Flushing is serialized by the underlying global rstat lock. There is also a
>> + * minimum amount of work to be done even if there are no stat updates to flush.
>> + * Hence, we only flush the stats if the updates delta exceeds a threshold. This
>> + * avoids unnecessary work and contention on the underlying lock.
>> + */
> What is global rstat lock?

It is the cgroup_rstat_lock in kernel/cgroup/rstat.c.

Cheers,
Longman


