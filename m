Return-Path: <cgroups+bounces-15130-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLneEIzcy2lHMAYAu9opvQ
	(envelope-from <cgroups+bounces-15130-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 16:39:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8973F36B11C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 16:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4541301BCDD
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0A3FD153;
	Tue, 31 Mar 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQGijboI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E53FBEB2
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967920; cv=none; b=M0zSougbmFgBzqbaGbswq5H9vCeahwiVhidX8ZCGtoP3lNtAWZCn5TINkSZGg2WAjXKgOgGSy6h9X37/ikq8j3rYqT+ocVeZHEpy6u3WET9W3jWHLg0WRy5/EJcnDsY8b83qQSDtI+eUkz8Zf4STvQ4Ki45oJW3LucryEIJ5Dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967920; c=relaxed/simple;
	bh=XPgKCAQXXpgypZ8fa7/mk1K1DLkFu5crzaxLGv5rCmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0oizopD5cPSjhyjrGiPep+InyR3h4gZJjIsffBuv6tRh1j9Hu1Rx869BRnrtT/qqSh70Njx58RwIK6gvQFVord3rfn9v35qkgF4NpMDf9k73nQHszUTpk0uBmXwiduwCUeR/cGOkbim5RXamTsgr20YZ5a6fmKfJs5K7grVpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQGijboI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774967918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHBK5RTcHGLUApVZiHj/Q/LEldgau7IiSnUjcS1LBic=;
	b=eQGijboIYw+0IHNduFe3SyPXsn340ekd1m4X4lritpjG0pb9+YOONbwEHxy/fzxk26OUE6
	txgSG/8mueqhZu2fg4Pl/iRCvn1PugFQ6+jioSkmjf1cfRzriKqaOhWzQnij/QZXg9kndD
	U5JVben+XWPLiTGu1jsBUHNQcFI9JJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-eVd53RCqMKiPhEyAHC9y8g-1; Tue,
 31 Mar 2026 10:38:33 -0400
X-MC-Unique: eVd53RCqMKiPhEyAHC9y8g-1
X-Mimecast-MFC-AGG-ID: eVd53RCqMKiPhEyAHC9y8g_1774967909
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14F8F1956065;
	Tue, 31 Mar 2026 14:38:28 +0000 (UTC)
Received: from [10.22.80.26] (unknown [10.22.80.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1756030001A2;
	Tue, 31 Mar 2026 14:38:20 +0000 (UTC)
Message-ID: <f24641b7-a177-467c-9554-e2ff188ca23e@redhat.com>
Date: Tue, 31 Mar 2026 10:38:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] sched/isolation: Implement sysfs interface for
 dynamic housekeeping
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
References: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
 <20260330114620.104027-1-realwujing@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260330114620.104027-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15130-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8973F36B11C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/30/26 7:46 AM, Qiliang Yuan wrote:
> On Wed, Mar 25, 2026 at 03:04:32PM +0100, Peter Zijlstra wrote:
>> Why? What was wrong with cpusets?
> This is the central point of the architecture. The distinction I was
> trying to address is:
>
> 1. Task Isolation (Current CPUSets):
>     The `cpuset` subsystem (especially `cpuset.cpus.partition = isolated`)
>     is excellent at managing task placement and load balancing. It
>     ensures no user tasks are pushed to isolated CPUs.
>
> 2. Kernel Overhead Isolation (Housekeeping):
>     Currently, `cpusets` do not manage kernel-internal overhead like RCU
>     callbacks, timers, or unbound workqueues. These are managed by the
>     global `housekeeping_cpumask`, which is settled at boot via
>     `isolcpus`/`nohz_full` and is static.

My plan is to extend the cpuset isolated partition mechanism to isolate 
other kernel noise currently covered by the nohz_full and manged_irq 
boot command line. That will makes the HK_TYPE_KERNEL_NOISE cpumask 
modifiable at run time. It is not a direct modification of the HK 
cpumasks as advocated by this patch series but an indirect one via the 
creation of the appropriate isolated cpuset partitions.

Cheers,
Longman


