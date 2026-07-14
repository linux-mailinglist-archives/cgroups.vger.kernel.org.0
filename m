Return-Path: <cgroups+bounces-17762-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gqpBHiH6VWoLxQAAu9opvQ
	(envelope-from <cgroups+bounces-17762-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 10:58:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A955D7529E5
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 10:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=cvL8JFVI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17762-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17762-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F567302292E
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770643B48A;
	Tue, 14 Jul 2026 08:58:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BC3F44CE
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 08:58:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019484; cv=none; b=UrvFjIUr2ZMI8KItuGw7Is29X3Azc2mIAWOGSlLCLZBTz0duWjV1xDCF8FQVhP1Ago3Inml5gzESr3GOsKsy8kgNmKJm//o+3GwVez4af1H3gj+XRH+HAj0D5fValX17VhzXt75KYxZ57TCERgqd0cF/F7OGQpyrNUg8TUfdq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019484; c=relaxed/simple;
	bh=qwRP4V+B9iDlbvfwesX2cvK8FhtV6iIKfYBrR6kvmBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAF1YY0E8g3IXyClCnMhZnct8Wf9hSrTVzG4Mb2YdndPhP1kI+y5Pnupky578PjqTw9T18tSg/2O1NTi10IMqH45YE2/MXFhsyvnnxo5BGPizQ0oG4PIcB5j/8zVXoKYqUpg4oHSx7/CKc/H++j9Vn3A+A7sBF+epDYcWyQMxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cvL8JFVI; arc=none smtp.client-ip=91.218.175.185
Message-ID: <007856c9-3506-4888-9818-8e4630b37fdc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784019480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdNrMq8bCxTLGPFwSKxLND/cn4ZHbHVtNZy8gkOzFEo=;
	b=cvL8JFVI8hI1XSYBlYnTgG96ED8LBxldfSLuxN6z+Sksjj+kcaYQFUC71DKj/S2ZoO9LR5
	uctNSsErdebcnnCIwrv66TbBoismLninA/PKyb0Qq2iMO2BwSOPAMhFpjTKO+kyiWC1NbD
	1zWI4Nuz19MM1tJSfX2uIoCvpxgAM60=
Date: Tue, 14 Jul 2026 16:57:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v3 0/3] cgroup/cpuset: Support multiple destination
 cpusets for cpuset_*attach()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260712235510.373125-1-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260712235510.373125-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17762-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A955D7529E5



On 7/13/2026 7:55 AM, Waiman Long wrote:
>   v3:
>    - Swap the first 2 patches as the original patch 1 can introduce serious bug
>      without patch 2. Doing patch 2 first will be less problematic.
> 

Would it make sense to squash these two patches into one?

>   v2: https://lore.kernel.org/lkml/20260712150127.236790-1-longman@redhat.com
>    - Make sure that attach_ctx.old_cs won't be set to a source cpuset that is
>      also the destination cpuset.
> 
>   v1: https://lore.kernel.org/lkml/20260711020540.176740-1-longman@redhat.com
> 
> This is a follow-up patch series to [1] to properly handle a special case
> for cpuset task migration operation where the source and destination
> cpusets are the same.
> 
> Patch 1 enables cpuset_*attach() to handle the case where there are many
> destination cpusets from enabling cpuset controller. Patch 2 handles
> those tasks that have the same source and destination cpuset by skipping
> them as they are not migrating with respect to cpuset. Patch 3 adds a
> new test case into test_cpuset to test proper handling of cpu affinity
> when cpuset controller is disabled.
> 
> [1] https://lore.kernel.org/lkml/20260702214757.579012-1-longman@redhat.com
> 
> Michal Koutný (1):
>    selftests/cgroup: Add test for cpuset affinity on controller disable
> 
> Waiman Long (2):
>    cgroup/cpuset: Support multiple destination cpusets for
>      cpuset_*attach()
>    cgroup/cpuset: Handle the special case of non-moving tasks in
>      cpuset_can_attach()
> 
>   kernel/cgroup/cpuset.c                       | 131 ++++++----
>   tools/testing/selftests/cgroup/test_cpuset.c | 243 +++++++++++++++++++
>   2 files changed, 321 insertions(+), 53 deletions(-)
> 

-- 
Best regards
Ridong


