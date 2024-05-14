Return-Path: <cgroups+bounces-2887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2248C59F7
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BD1C21500
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4E1802A1;
	Tue, 14 May 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ahd2Gnin"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCC17F37C
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705752; cv=none; b=hJK/5S8RfKCJIJstzVgZoHl7PGBslVjW2TS4537Ws03CUh2RIKVnzgVzFJfJlHwN7IFkItwG2ZUnaeZCT722QYqgZ2i8NK+Hh2nJE+K5GnlKG+Xmd1G1YcAU42p2HHiY5DET7H8cAREFxuc5rWj6M2mQcoWLgeme4PxR4uDmHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705752; c=relaxed/simple;
	bh=lELqUKrJlCCY1VkA2cO2YbrvZapdf1v79jnvhnwCVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pizQ7pXeRIsW06STcIoWpJwwH1usMX8bL3GjVEEQT+WI08VdIOv7XBUmXBFCXvXZ6o2B+gCruMDB5pHmkVKw30pi2zWdMMeGhl/tiyZQahgD65uo8+N+u0971NR1SBZEDmIhjlI/agkBa0+cc4Hlg1EBh2UUVhEdXClnSv7btv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ahd2Gnin; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715705749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Xc3VFjZ08Mc4cSLOBVdBw5V+Qgn6KoMPCEk8F7ooxQ=;
	b=Ahd2GninpTHNWwOkCz8OYDvDeRBJxVba7jrUt/G/5eygB12SUi3Dv9hg+wOtGIifw9hcnf
	N8qm7m1t3FZTyzWmE0OEAULtx5NLb+Avc1s7J3PcIwf6ISvDM4wfEhYEwuRJOqR/99kFLH
	VpaORpbtJpDwCE698EBp8terdlKzWes=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-4rSj7Fj6OKer9on9Dp2reg-1; Tue,
 14 May 2024 12:55:44 -0400
X-MC-Unique: 4rSj7Fj6OKer9on9Dp2reg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 724433800BA7;
	Tue, 14 May 2024 16:55:43 +0000 (UTC)
Received: from [10.22.34.104] (unknown [10.22.34.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79150C15BB9;
	Tue, 14 May 2024 16:55:41 +0000 (UTC)
Message-ID: <a0c5534a-55c6-4ca5-afe1-184fddb535c1@redhat.com>
Date: Tue, 14 May 2024 12:55:41 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cgroup/cpuset: optimize
 cpuset_mems_allowed_intersects()
To: Tejun Heo <tj@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Imran Khan <imran.f.khan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-6-yury.norov@gmail.com>
 <911ca229-4849-4fd2-8ae8-5ca653d8a5e3@redhat.com>
 <ZkOWRa_hFFhcbpVf@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZkOWRa_hFFhcbpVf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


On 5/14/24 12:50, Tejun Heo wrote:
> On Tue, May 14, 2024 at 12:47:59PM -0400, Waiman Long wrote:
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 4237c8748715..47ed206d4890 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -5010,6 +5010,9 @@ EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
>>>    int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
>>>    				   const struct task_struct *tsk2)
>>>    {
>>> +	if (tsk1 == tsk2)
>>> +		return 1;
>>> +
>>>    	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
>>>    }
>> Reviewed-by: Waiman Long <longman@redhat.com>
> I'm not sure this is worth the added code.

Yes, I do have a second thought afterward. The only caller of 
cpuset_mems_allowed_intersects() is oom_cpuset_eligible() in 
mm/oom_kill.c. So I believe a better fix is to avoid calling 
cpuset_mems_allowed_intersects() there if current == tsk.

Cheers,
Longman


