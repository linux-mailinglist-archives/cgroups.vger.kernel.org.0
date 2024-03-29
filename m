Return-Path: <cgroups+bounces-2240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62929890FE7
	for <lists+cgroups@lfdr.de>; Fri, 29 Mar 2024 01:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922B21C247A3
	for <lists+cgroups@lfdr.de>; Fri, 29 Mar 2024 00:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99110942;
	Fri, 29 Mar 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViZ2H7nK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E0A5F
	for <cgroups@vger.kernel.org>; Fri, 29 Mar 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673787; cv=none; b=TX+fVoxsHc81FEcANh+2nHiTQ94/CjUPLmRjjgF32gHiHDRrkm/nolhqlu0CIQO2WND52RDM36YM/1Gj0ao6c7Y1XZWWLKrMOxuWCZQmEgGfYVwRXVysNIRuu29/Wv5INCUHE4iEjKyEbQsXDDXuL5iGLzYROuqQpXlVpobHcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673787; c=relaxed/simple;
	bh=bTxic3zTCVAnP1UInL2d0EPzinfN7xzR216WNJg4b6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1U960nFHnXghmQV6YuayxdvZGHqcyM0iJ3pF7HzL1wbQeBOpOKdzVJTU3ISINi8rYERjpPdQxPfzZYJxoWIX4PbDTQdkKznjVPp8QtKk+lqS93B5lOj55iHe9zLxtsRaDYtBt07p3rI9q7yG+SNXqNelOxWCXUK265RENQ3m+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViZ2H7nK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711673784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3mzPsNX7W5NRZtTNJ51NaOr5melaIinfF0oNdCHQi4=;
	b=ViZ2H7nKd0QBvgUjX6dZ1Z+GlRdRHkDML/PYaYo3jzB1WnyU165InByzYbKFFEaD4VJ9aA
	Zb2sFHthDAdZyXWJ6BWfz3kf8+pZWZZZEHrokxt4cx2vfn/ZJWbjFEJx7e911UqJVEOTX/
	qPxKRWFIr7QgctiQ4BnhN6pYvlV96aE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-9KCimqGQPxKhCir4LIknOQ-1; Thu, 28 Mar 2024 20:56:18 -0400
X-MC-Unique: 9KCimqGQPxKhCir4LIknOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8F3A185A783;
	Fri, 29 Mar 2024 00:56:17 +0000 (UTC)
Received: from [10.22.9.3] (unknown [10.22.9.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 832511C060D0;
	Fri, 29 Mar 2024 00:56:15 +0000 (UTC)
Message-ID: <3135adb7-9e4d-4538-ae1b-c67d37b1ee1b@redhat.com>
Date: Thu, 28 Mar 2024 20:56:15 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/isolation: Exclude dynamically isolated CPUs
 from housekeeping masks
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Cestmir Kalina <ckalina@redhat.com>, Costa Shulyupin <cshulyup@redhat.com>
References: <20240229021414.508972-1-longman@redhat.com>
 <20240229021414.508972-2-longman@redhat.com> <ZgIHBaF0gGQTKlvU@pavilion.home>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZgIHBaF0gGQTKlvU@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


On 3/25/24 19:21, Frederic Weisbecker wrote:
> Le Wed, Feb 28, 2024 at 09:14:13PM -0500, Waiman Long a écrit :
>> The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
>> boot command line options, are used at boot time to exclude selected CPUs
>> from running some kernel background processes to minimize disturbance
>> to latency sensitive userspace applications. Some of housekeeping CPU
>> masks are also checked at run time to avoid using those isolated CPUs.
>>
>> The cpuset subsystem is now able to dynamically create a set of isolated
>> CPUs to be used in isolated cpuset partitions. The long term goal is
>> to make the degree of isolation as close as possible to what can be
>> done statically using those boot command line options.
>>
>> This patch is a step in that direction by making the housekeeping CPU
>> mask APIs exclude the dynamically isolated CPUs when they are called
>> at run time. The housekeeping CPU masks will fall back to the bootup
>> default when all the dynamically isolated CPUs are released.
>>
>> A new housekeeping_exlude_isolcpus() function is added which is to be
>> called by the cpuset subsystem to provide a list of isolated CPUs to
>> be excluded.
> Can we instead overwrite housekeeping_boot.cpumasks from cpusets entirely and
> forget about the original boot value forever?

That is an interesting question.

I think we will still need to keep the boot values somewhere, at least 
until we can dynamically isolate CPUs as good as what can be done at 
boot time. At this point, what can be done dynamically is still limited. 
So we want to keep the statically isolated CPUs around without breaking 
its isolation. Of course, we can do all these within cpuset with minimal 
change in kernel/sched/isolation.c.

Cheers,
Longman


