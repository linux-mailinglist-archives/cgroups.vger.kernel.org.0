Return-Path: <cgroups+bounces-14506-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNAzAYOepWltCAAAu9opvQ
	(envelope-from <cgroups+bounces-14506-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 15:28:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0F1DAC38
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F18731474C8
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD23FFAD4;
	Mon,  2 Mar 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtR1/196"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17183FFAB2
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460923; cv=none; b=D4gYf6OtQVrS1S0oSY+xXoci8fL4w6EvDOmR1eaJg2Qy5YCHCgmlRBftQYE/flf45E1U0hb/fpcP/UeHIxiuVEOpLurChjqalxB7+0VFRe3iWZESLuTj2XK4rHQvZ9+iWRb/q/BZ8RNzuJQIVzGrxkOQy1ZiPsuExWzMNc7bcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460923; c=relaxed/simple;
	bh=PO9LFxjHRiXSZV0ZTkBcY+OJzR2dcqixVUYO6d+SoyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIML0GZtk8+IohM7JjXwff/xuptEVvHtS+WkWtyk5neUi6gu6l++J4OjJHdaCynxkR9I67OdX8NY6jtZP7V5rG0FsaehDnQaGGCOC8y/FuFaTqoeK9N8HKHfpn8t8bmJI+TOckzUiEVHYMTYX3P+NsNV3NKGZZ5bBhieFYaTwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtR1/196; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772460921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PUUY1opl6eDiW1jZM0WQddZV4oH4gcaLepSTLvQvQY=;
	b=CtR1/196Ns+BIIUSYGlYQhblRZQHo1oCJrDZs7xShZiSzqJFohZY0vf+U4TSv41Wz3wsxR
	RveWgzYwD9LTFgqWa7+ABgpiuxqLWyQQ2R4LaNedrrBUoPzR1d7EDW5iDk9fAKb3BnzSZm
	amgNX85nYGQ0OOYudzALZT6BP083lnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-GXUYZp7WMB23NG-YsYS2RQ-1; Mon,
 02 Mar 2026 09:15:18 -0500
X-MC-Unique: GXUYZp7WMB23NG-YsYS2RQ-1
X-Mimecast-MFC-AGG-ID: GXUYZp7WMB23NG-YsYS2RQ_1772460916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2EFF19560B9;
	Mon,  2 Mar 2026 14:15:15 +0000 (UTC)
Received: from [10.22.65.79] (unknown [10.22.65.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2221A19560A7;
	Mon,  2 Mar 2026 14:15:12 +0000 (UTC)
Message-ID: <69ec4b3c-818b-4784-9b90-1ac5e977ae58@redhat.com>
Date: Mon, 2 Mar 2026 09:15:11 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] cgroup/cpuset: Call housekeeping_update() without
 holding cpus_read_lock
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
 <20260221185418.29319-9-longman@redhat.com> <aaV/Jme7NAooNxZQ@lothringen>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <aaV/Jme7NAooNxZQ@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 59C0F1DAC38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-14506-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 7:14 AM, Frederic Weisbecker wrote:
> On Sat, Feb 21, 2026 at 01:54:18PM -0500, Waiman Long wrote:
>> The current cpuset partition code is able to dynamically update
>> the sched domains of a running system and the corresponding
>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>> "isolcpus=domain,..." boot command line feature at run time.
>>
>> The housekeeping cpumask update requires flushing a number of different
>> workqueues which may not be safe with cpus_read_lock() held as the
>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>> which have locking dependency with cpus_read_lock() down the chain. Below
>> is an example of such circular locking problem.
>>
>>    ======================================================
>>    WARNING: possible circular locking dependency detected
>>    6.18.0-test+ #2 Tainted: G S
>>    ------------------------------------------------------
>>    test_cpuset_prs/10971 is trying to acquire lock:
>>    ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180
>>
>>    but task is already holding lock:
>>    ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
>>
>>    which lock already depends on the new lock.
>>
>>    the existing dependency chain (in reverse order) is:
>>    -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>    -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>    -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>    -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>    -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>
>>    Chain exists of:
>>      (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
> Which workqueue is involved here that holds rtnl_mutex?
> Is this an existing problem or added test code?

Circular locking dependency here may not necessarily mean that 
rtnl_mutex is directly used in a work function.  However it can be used 
in a locking chain involving multiple parties that can result in a 
deadlock situation if they happen in the right order. So it is better 
safe that sorry even if the chance of this occurrence is minimal.

Cheers,
Longman


