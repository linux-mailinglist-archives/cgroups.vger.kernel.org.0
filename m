Return-Path: <cgroups+bounces-17818-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 65d2GxMKV2oWEgEAu9opvQ
	(envelope-from <cgroups+bounces-17818-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 06:18:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9975A6EE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 06:18:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Yt5JWzjf;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17818-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17818-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380573048916
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA723507B;
	Wed, 15 Jul 2026 04:18:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A65380FDB
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 04:18:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089084; cv=none; b=JaWrW08LoCgLxL5ZxHkSEzxF2bqqUgzVK/mZ9qJMafEn/RKD9o2d7rvSi07c664cdr5x/LxuvWR2YzfpbC+QF8aSFtay8N2uPmAmdtPT/WhN3YuDljJsXP2uYg/tdl79S7s2xDj4eYx0BkT/9785l98mgB8PVNVn/MPOOxgUtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089084; c=relaxed/simple;
	bh=2aj97DlNEXSJv6SmnN3/HDr4AIGAg109zmKqKPz5LeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbmltfKRD7OgvQG/HCiamTGn9YuR4r2mOnKnaVyvOo2zxqvlY3SnaIt7d7ApiAXkIRcui6Uipz9FolmAWlUVjIC7jhToBG5zWtNgKQyeIXqRH7FcFtAdDYCPZoL9DcR2E2+brV79mrW5iIMTA5W2e2j8qBqXW+y0GsRlEbKVGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt5JWzjf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784089082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5QhjOmZmev9jjzpC6LSZX2ien8jet4q9MPH7etJF/8=;
	b=Yt5JWzjfpdKLjCDjnr1Vpx9dQ+VARcPzM9VpVBPUscWg+Z60nFXpSnVC3KpMdxT+5WMhvq
	94EoIF8348QPvh/jENjd+D9uRDNs9ZcRvelxWxewpnXrb17pG2JDa0oUQtch7gL/CK7xbu
	CJ+CXcVHVUH2k3itTQfIMq+hVaObirI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-WaF9dcfFPeSMTVPkL6ySYw-1; Wed,
 15 Jul 2026 00:17:55 -0400
X-MC-Unique: WaF9dcfFPeSMTVPkL6ySYw-1
X-Mimecast-MFC-AGG-ID: WaF9dcfFPeSMTVPkL6ySYw_1784089074
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04C691956068;
	Wed, 15 Jul 2026 04:17:54 +0000 (UTC)
Received: from [10.22.89.63] (unknown [10.22.89.63])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B98E403;
	Wed, 15 Jul 2026 04:17:52 +0000 (UTC)
Message-ID: <5e074ad6-c844-4e03-a4f2-02fd709f90e6@redhat.com>
Date: Wed, 15 Jul 2026 00:17:51 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cgroup: Fix intermittent test_cgfreezer_ptrace
 test failures
To: Tao Cui <cui.tao@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260714183125.521650-1-longman@redhat.com>
 <4ae04b8055b7145e182380a46f92c26e@kernel.org>
 <2e5102e4-0732-41c2-a5be-bbff2f386e58@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <2e5102e4-0732-41c2-a5be-bbff2f386e58@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17818-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cgroup.events:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEC9975A6EE

On 7/14/26 9:24 PM, Tao Cui wrote:
>
> 在 2026/7/15 06:09, Tejun Heo 写道:
>> Hello, Waiman.
>>
>>> +	usleep(1000);
>>>   	if (cg_check_frozen(cgroup, true))
>>>   		goto cleanup;
>> A fixed 1ms sleep only hides the race. On a loaded machine or a slow arch
>> (you mention ppc64) the refreeze can take longer than 1ms, and the test
>> reads the unfrozen state and fails anyway.
>>
>> The freezer test already has a way to wait for this properly.
>> cg_prepare_for_wait() sets up an inotify watch on cgroup.events and
>> cg_wait_for() blocks until it changes. cg_enter_and_wait_for_frozen() shows
>> the pattern: loop cg_wait_for() then cg_check_frozen(). The cgroup always
>> ends up frozen, so looping until cg_check_frozen() reports frozen is
>> reliable and doesn't depend on timing.
>>
>> Can you respin using that instead of usleep()?
>>
>> Also, temporaily -> temporarily, in both the changelog and the comment.
>>
> Hi Tejun, Waiman,
>
> I ran into a similar issue a while back and can add a data point on
> the reproducibility: when running the full cgroup selftest suite, a
> few cases -- test_cgfreezer_ptrace and test_cgfreezer_stopped -- fail
> intermittently (around 40-70% on VMs), yet each failing case passes
> reliably when run on its own. That points at state carried across
> tests rather than a per-test bug, which is also why a fixed sleep/retry
> is fragile.
>
> On the "unfrozen state" above, I traced where CGRP_FROZEN actually gets
> cleared. When the frozen tracee is woken by PTRACE_INTERRUPT,
> JOBCTL_TRAP_STOP takes priority over JOBCTL_TRAP_FREEZE in get_signal(),
> so the task enters ptrace_stop() instead of going back to
> do_freezer_trap(). With debug printk in cgroup_update_frozen_flag() and
> cgroup_leave_frozen(), the cg_test_ptrace trace shows:
>
>    0 -> 1  nr_frozen=1  task_count=1   /* initial freeze            */
>    1 -> 0  nr_frozen=0  task_count=1   /* dec, task still in cgroup */
>    0 -> 1  nr_frozen=0  task_count=0   /* task left cgroup          */
>
> The 1 -> 0 step (nr_frozen 1->0 while task_count is still 1) is
> cgroup_dec_frozen_cnt(), called from cgroup_leave_frozen(true) at the
> end of ptrace_stop() (signal.c:2479) when the tracee is woken by
> PTRACE_DETACH. That clears CGRP_FROZEN until the task loops back into
> do_freezer_trap() and re-enters the frozen state -- the transient
> unfrozen window the test hits.
>
> As a kernel-side attempt I changed cgroup_enter_frozen() so it no longer
> returns early when current->frozen is already true: css_set_lock is
> taken before the check and, if CGRP_FREEZE is still set,
> cgroup_update_frozen() is called to re-verify the cgroup frozen state
> when a frozen task is handed off to ptrace.

get_signal() => ptrace_do_notify() => ptrace_stop() is where I saw the 
cgroup became unfrozen. Later cgroup_enter_frozen() is called to be 
frozen again. I do my testing mostly on bare metal and I don't see 
failure in x86, but I do see intermittent failures in arm64 and ppc64le. 
Also the clearing and setting of the frozen flag and the reading of 
frozen flag is from different processes running on different CPUs. I 
suppose the PTRACE_DETACH operation is synchronous. That is why I 
suspect it can be a racing issue where the frozen flag is seen to be set 
in one CPU while the other CPU may still see it cleared. This kind of 
racing issues are much more visible in archs with weak memory model.

Cheers,
Longman


