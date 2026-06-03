Return-Path: <cgroups+bounces-16623-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rUhaNmV4IGrV3wAAu9opvQ
	(envelope-from <cgroups+bounces-16623-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:54:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992263AAC0
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gy4RCagh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16623-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16623-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293013035AA3
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AF3E5A2D;
	Wed,  3 Jun 2026 18:47:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB972797AC
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 18:47:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512445; cv=none; b=Cv2wkAwwCkutC9g0mouCaO94miOD5A1tai5SXflfGLW3YwcaCEKdog3TsfjNgErNJXlyNmUlIWak3J9x5c7uOjpyaXApYIWxOYGXPaSH5DKHTqtrActYmG3NY0e8P1vo4nh/SQsC0OX030nFL5l1WdoF7TY1X83liLQB3esznUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512445; c=relaxed/simple;
	bh=wWqs3oPF7mlG6LLUKySNuhktwo+pteTb72PM5QRgr8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM66f/AEgxvP9JNwTQfRP7Ev35sV2ylHF2sDc2oVBvrKqb5rvhEgaurdSgKTqxE7CRJON8yb89xSdb0olbAV6b0CYvjK5bda/s6T2lOkSiDobCevWS1yJqgbdONUPhIjMIHh9WAJn43I338rMmQ5mHUwtPtDn14IeaEMqtdibu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy4RCagh; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780512442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OR50zp9f+zsfYu74rLL29wUcEjWpOoJyiVYpaeas98=;
	b=gy4RCaghCSqekTby7UpWXnlWrCa+OWBNVAO7rCVJ440jvfGhPC+QxTJYXTCcZw/3lCES5I
	DTa9e8ctVb+StcfmicXFvllyG9WdLnBY5JAyAUYMwR1o7sjqdT33lfP6YVGECaQHQ4eH9a
	ArLZ7bx6mhHc9gZp3c45zXzw9yVFrRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-KwvkXKBKPuGgBcr8u_eBPg-1; Wed,
 03 Jun 2026 14:47:21 -0400
X-MC-Unique: KwvkXKBKPuGgBcr8u_eBPg-1
X-Mimecast-MFC-AGG-ID: KwvkXKBKPuGgBcr8u_eBPg_1780512440
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F32F1956046;
	Wed,  3 Jun 2026 18:47:20 +0000 (UTC)
Received: from [10.22.89.171] (unknown [10.22.89.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18E2F180049F;
	Wed,  3 Jun 2026 18:47:18 +0000 (UTC)
Message-ID: <07bfe9cc-b8ab-4c4c-bfe0-b974abd3ff08@redhat.com>
Date: Wed, 3 Jun 2026 14:47:18 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Support multiple source/destination
 cpusets using pids pattern
To: Ridong Chen <ridong.chen@linux.dev>
Cc: cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
References: <20260602023203.248077-7-longman@redhat.com>
 <20260603102604.177503-1-ridong.chen@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260603102604.177503-1-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16623-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3992263AAC0

On 6/3/26 6:26 AM, Ridong Chen wrote:
> The current cpuset_can_attach() and cpuset_attach() functions assume task
> migration is from one source cpuset to one destination cpuset. This can be
> wrong in several scenarios:
>   - Moving a multi-threaded process with threads in different cpusets
>   - Disabling the cpuset controller (many children to one parent)
>   - Enabling the cpuset controller (one parent to many children)
>
> Fix this by adopting the pids subsystem's per-task accounting pattern.
> In cpuset_can_attach(), use task_cs(task) to get the correct source cpuset
> for each task (like pids_can_attach uses task_css), adjust nr_deadline_tasks
> and reserve DL bandwidth per-task, and increment attach_in_progress per-task
> on the destination cpuset. In cpuset_attach(), handle destination cpuset
> changes within the task iteration loop.
>
> A shared helper cpuset_undo_attach() reverses the per-task operations for
> both partial rollback in cpuset_can_attach() and full reversal in
> cpuset_cancel_attach().
>
> When multiple source cpusets are detected in can_attach(), set
> attach_many_sources so that cpuset_attach() forces cpus_updated and
> mems_updated to true, ensuring all tasks get properly updated regardless
> of which source cpuset cpuset_attach_old_cs points to.
>
> This eliminates the need for nr_migrate_dl_tasks, sum_migrate_dl_bw, and
> dl_bw_cpu fields in struct cpuset.
>
> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default hierarchy")
> Signed-off-by: Ridong Chen <ridong.chen@linux.dev>

It is not a problem doing per-task DL BW allocation and eliminating the 
*dl_bw* fields. However, updating nr_deadline_tasks before it is 
committed can be problematic.

nr_deadline_tasks is used in dl_rebuild_rd_accounting() which is called 
by partition_sched_domains_locked(). After the release of cpuset_mutex 
at the end of cpuset_can_attach() and before cpuset_attach() or 
cpuset_cancel_attach() is called, it is possible 
that partition_sched_domains_locked() can be called 
and dl_rebuild_rd_accounting() is not getting the right DL BW accounting 
information. So unless there is a way to confirm that this situation 
cannot happen, we can't change nr_deadline_tasks before the attach is 
commited.

Cheers,
Longman


