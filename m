Return-Path: <cgroups+bounces-890-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E0808908
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 14:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371AC1C20B40
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE691405CD;
	Thu,  7 Dec 2023 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAOQMF4g"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CBAA
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 05:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701955286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlxnIkTVs+MeF68tCsmk/nR1vv5URTWbbq/XkKatOUM=;
	b=CAOQMF4gyU/yYPdZ7/NyR8gZBvPnGjDyZWkuG2+UgPkX98mMMxllseDA5lNxHHB3QBc7ZJ
	p+XGVOUqheW99meYzOVuK89ANfe2v7M9dVIint/foYVqLS/E915H8bqiJXXLm1FeoWrNSg
	Fa4aMiilF1jUnrxw84bJLIH7XTHtfR4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-jCRHf0RGOiK98jxr_VOP_w-1; Thu,
 07 Dec 2023 08:21:22 -0500
X-MC-Unique: jCRHf0RGOiK98jxr_VOP_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B3C3813F28;
	Thu,  7 Dec 2023 13:21:22 +0000 (UTC)
Received: from [10.22.32.209] (unknown [10.22.32.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AFB23492BE6;
	Thu,  7 Dec 2023 13:21:21 +0000 (UTC)
Message-ID: <0a79501b-ff60-4122-840f-fc0095ae05fd@redhat.com>
Date: Thu, 7 Dec 2023 08:21:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup] cgroup: Move rcu_head up near the top of
 cgroup_root
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yafang Shao <laoar.shao@gmail.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20231207043753.876437-1-longman@redhat.com>
 <CAJD7tkZtt8xedBJyRns+6HpdXoBxadLUGuGNG5s1trEbRgb9hA@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkZtt8xedBJyRns+6HpdXoBxadLUGuGNG5s1trEbRgb9hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 12/6/23 23:51, Yosry Ahmed wrote:
> On Wed, Dec 6, 2023 at 8:38 PM Waiman Long <longman@redhat.com> wrote:
>> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
>> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
>> for freeing the cgroup_root.
>>
>> The use of kvfree_rcu(), however, has the limitation that the offset of
>> the rcu_head structure within the larger data structure cannot exceed
>> 4096 or the compilation will fail. By putting rcu_head below the cgroup
>> structure, any change to the cgroup structure that makes it larger has
>> the risk of build failure. Commit 77070eeb8821 ("cgroup: Avoid false
>> cacheline sharing of read mostly rstat_cpu") happens to be the commit
>> that breaks it even though it is not its fault. Fix it by moving the
>> rcu_head structure up before the cgroup structure.
>>
>> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/cgroup-defs.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 5a97ea95b564..45359969d8cf 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -562,6 +562,10 @@ struct cgroup_root {
>>          /* Unique id for this hierarchy. */
>>          int hierarchy_id;
>>
>> +       /* A list running through the active hierarchies */
>> +       struct list_head root_list;
>> +       struct rcu_head rcu;
>> +
> Perhaps the comment should mention the placement requirements, and
> maybe a pointer to wherever it is specified that the offset of struct
> rcu_head should not exceed 4096?

Fair. I will update the patch description to give more details about 
that. It is new to me too before I got a compilation failure report in 
linux-next.

Cheers,
Longman

>


