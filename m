Return-Path: <cgroups+bounces-14586-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P2UEbqvp2nAjAAAu9opvQ
	(envelope-from <cgroups+bounces-14586-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 05:06:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F571FA99D
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 05:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67EE305934A
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 04:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739D37E301;
	Wed,  4 Mar 2026 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6DJJc59"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81B3537D1
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597163; cv=none; b=iuWgZn+WMLSHpMH18kyVTkRIW631sbqMILW+nT7rNinOfrxw4R/wf/KiIJBYozu9SWu0STWn364Ue4M30C9ftdp0uSt0ENo3IWvjC+DNMPlgXilT5JlCodKjJDMzFmxT0/GwUgqVym405cSua7rY69DxeCzRnmnSdLNt8Byk2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597163; c=relaxed/simple;
	bh=YVxRuP0NXDSbyXtnCqrLI757OLMnWV+voqvrCqEQOlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jELViE3VIV7YtU/AADXSYSDaFdKJRzcmRasyu3tKoJyIPNC8mx9iK0+yF4pZOgmRRxNbD6FtprKfMjSHfq2NgU3/7AqnIIbBo9pJYjxMrU+sstY+YVBj9EGqsf+d9xIjh5EW2dqNUiFWoNkLf8YAx1Cw3Ba+v5f1x1syaVQEB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6DJJc59; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772597162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVLfMHz3uFZGKoEzvvxcxpvEYhM/ojSOYfndv2rw0os=;
	b=Z6DJJc59UUh6TpqWG0DMXH9iXdN4sskiqSl5Da5vv6immQBM12aqRbbnen2x1NTppLvNoU
	ZEKp4/uSrJbXgiBJUU/jaIsCVHgXOTwLFZhrYoOuF6ahnbnARtfj7uHEmAz1aKDpXgMzfk
	PPTSrVJhJEMgcLQgL/Qw0qqWjiCN+5I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-4cjsy1NyPzmCUgOhkCVbLQ-1; Tue,
 03 Mar 2026 23:05:58 -0500
X-MC-Unique: 4cjsy1NyPzmCUgOhkCVbLQ-1
X-Mimecast-MFC-AGG-ID: 4cjsy1NyPzmCUgOhkCVbLQ_1772597156
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88F631956089;
	Wed,  4 Mar 2026 04:05:55 +0000 (UTC)
Received: from [10.22.64.108] (unknown [10.22.64.108])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFF9E300019F;
	Wed,  4 Mar 2026 04:05:51 +0000 (UTC)
Message-ID: <ca9ee83b-e93c-4f8c-8874-a01de646b458@redhat.com>
Date: Tue, 3 Mar 2026 23:05:51 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
 <aaBvc4ikB1H-WQDd@localhost.localdomain>
 <c999838a-cfdf-4556-8416-cb21aa2b69e7@redhat.com>
 <aadlJm2aUekJdIwS@pavilion.home>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <aadlJm2aUekJdIwS@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: B1F571FA99D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-14586-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/3/26 5:48 PM, Frederic Weisbecker wrote:
> Le Tue, Mar 03, 2026 at 11:00:54AM -0500, Waiman Long a écrit :
>> On 2/26/26 11:06 AM, Frederic Weisbecker wrote:
>> If you look at the work function, it will make a copy of HK_TYPE_DOMAIN
>> cpumask while holding rcu_read_lock().
> Where?
>
>> So the current hotplug operation must
>> have finished at that point.
> I'm confused. This is called from sched_cpu_deactivate(), right?
> So the work is scheduled at that point. But the work does cpuset_full_lock()
> which includes cpu hotplug read lock, so the sched domain rebuild can only
> happen at the end of cpu_down().
>
> This means that between CPUHP_TEARDOWN_CPU and CPUHP_OFFLINE, the offline
> CPU still appears in the scheduler topology because the scheduler domains
> haven't been rebuilt.
>
> And even if the work wouldn't cpu hotplug read lock, what guarantees that
> it executes before reaching CPUHP_TEARDOWN_CPU?
>
>> Of course, if there is another hot-add/remove
>> operation right after the rcu_read_lock is released, the cpumask passed down
>> to housekeeping_update() may not be the latest one. In this case, another
>> work will be scheduled to call housekeeping_update() with the new cpumask
>> again.
> I'm not so much worried about housekeeping_update() (yet). I'm worried about
> topology rebuild to happen before CPUHP_TEARDOWN_CPU. Offline CPUs shouldn't
> exist in the topology.

Yes, I am aware that this could be a problem. I am working on a fix 
patch that will always do a rebuild_sched_domains_cpuslocked() call 
directly in the hotplug path if needed as shown in the patch that I sent 
to Jon. I want to get a confirmation first before I send it out. There 
will be other minor code/comment adjustments as well.

Cheers,
Longman


