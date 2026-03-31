Return-Path: <cgroups+bounces-15121-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC2vNt9Iy2kPFQYAu9opvQ
	(envelope-from <cgroups+bounces-15121-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 06:09:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A991363D57
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 06:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AE9300B06E
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 04:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B52C1593;
	Tue, 31 Mar 2026 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7BBrGlO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0928AAEB
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929824; cv=none; b=afLYdOwPw+sj3YKVKGQqq3e7tA75nEsnK/yTR2yTBWJT+jswD4K2T47ZdxDi3LX20AfEXu255z5D5KMd5cIQ8rPqj3QLnj52eoMtgxLYF3EpualDI4185dZ7fDca1+Z+XDA7qtHATpCtnZyy/8jZfVZj/6dvFd4jQdrqzYEz6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929824; c=relaxed/simple;
	bh=eAN/fccFaJenwEg+PtIQALNm5CkfOqgLimU4u71+Eu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO+fSCgzI6dVY9vPPscLOG48mgwgzHcdeC9Edg6dAVcNDxELsKzLSkMW1BPjI2yNM86hR26QnXrzl7Icjzn5S+BkoOTC26BwVveBVCw6iKBYao6frMCUcIs51nQYKiMUuoV0ltPX933j1qov2gdZRBr44++8fRasJrbkqZX/A8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7BBrGlO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774929822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhQhsVlHkUdp1u8lVh/yc5BWf65vNXkGXbfUATcYfMM=;
	b=i7BBrGlOrMFpvnf8uvKTv6T2jW4Z7gliglM3slMLaiu7rI/vGcewvPowre0DqbrANLF7bI
	f2+fInOm3xVW0IpSOTb9fJc72UvMpyF6u32h0qIKMG8Gh9uMHj9RnBCwAcGpSyo91WT0ph
	7HDY2dVhU95xR86zO+BXbC5liJUVcY4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-5dWhUe2xNV-3EvUixeNarg-1; Tue,
 31 Mar 2026 00:03:38 -0400
X-MC-Unique: 5dWhUe2xNV-3EvUixeNarg-1
X-Mimecast-MFC-AGG-ID: 5dWhUe2xNV-3EvUixeNarg_1774929814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9322E195605E;
	Tue, 31 Mar 2026 04:03:33 +0000 (UTC)
Received: from [10.22.64.128] (unknown [10.22.64.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21F9E19560AB;
	Tue, 31 Mar 2026 04:03:27 +0000 (UTC)
Message-ID: <18473552-2a97-4da9-9f44-ac49d4131004@redhat.com>
Date: Tue, 31 Mar 2026 00:03:26 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] sched/core: Dynamically update scheduler domain
 housekeeping mask
To: Qiliang Yuan <realwujing@gmail.com>, peterz@infradead.org
Cc: cgroups@vger.kernel.org, akpm@linux-foundation.org,
 anna-maria@linutronix.de, boqun.feng@gmail.com, bsegall@google.com,
 dietmar.eggemann@arm.com, frederic@kernel.org, hannes@cmpxchg.org,
 jackmanb@google.com, jiangshanlai@gmail.com, joelagnelf@nvidia.com,
 josh@joshtriplett.org, juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 mathieu.desnoyers@efficios.com, mgorman@suse.de, mhocko@suse.com,
 mingo@kernel.org, mingo@redhat.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, shuah@kernel.org, surenb@google.com, tglx@kernel.org,
 tj@kernel.org, urezki@gmail.com, vbabka@suse.cz, vincent.guittot@linaro.org,
 vschneid@redhat.com, ziy@nvidia.com
References: <20260325140053.GC3738786@noisy.programming.kicks-ass.net>
 <20260330114516.103451-1-realwujing@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260330114516.103451-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15121-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,redhat.com,kvack.org,efficios.com,suse.de,suse.com,linux.dev,goodmis.org,suse.cz,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A991363D57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 7:45 AM, Qiliang Yuan wrote:
> On Wed, Mar 25, 2026 at 03:00:53PM +0100, Peter Zijlstra wrote:
>> Sched domain boundaries are not static, they are easily changed by
>> cpuset partition (v1 and v2 both support this).
> You're absolutely right. My description was imprecise. The goal of this
> patch was to ensure that the housekeeping mask for scheduler domains
> follows the partition boundaries dynamically as they are resized.
>
> In V13, I will explicitly integrate the housekeeping update logic
> directly with `cpuset.cpus.partition` transitions. This way, any change
> to the isolation level of a partition will automatically update
> the kernel-internal housekeeping state, avoiding any parallel management
> logic.

It looks like your patch series isn't based on the latest v7.0 kernel. 
With the latest upstream kernel, the HK_TYPE_DOMAIN cpumask has been 
updated to dynamically follow changes made in the cpuset isolated 
partition setting.

Cheers,
Longman


