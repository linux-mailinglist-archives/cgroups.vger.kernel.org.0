Return-Path: <cgroups+bounces-15715-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG7ILPRkAWodXwEAu9opvQ
	(envelope-from <cgroups+bounces-15715-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 07:11:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC73507FBB
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 07:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B2530221E0
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 05:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3299362151;
	Mon, 11 May 2026 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkslecJf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B5248881
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476227; cv=none; b=PoyiWYHJsduNMX0FZO4dv1pMW2BAfNMeM1wKlkBTaghp7ePKYdLkSmQ2br5ziIdjzuqmyeSg09ZMKnp1TvPksJOMV8ENCp9ozYhH2PDOhoWGTKygRo+ffxD0gE4jYF2jfxvbbmfyEstafEl0lmV9CmF+pzp7w6bjK2dg7Yu+A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476227; c=relaxed/simple;
	bh=9bPgUgowYtDZvwWDaDvH9GE08BbGRUl9XHTtvYleq54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcEXEqCw5uMboMZWWQOJQBiwFgZe/OJ2S22w05Xb1rkq5YQuNT8dDZT3Kur2VqOg9fhM2TYO1lggmgt3YKONzbrX3K/6QZzpqNG98Dttqm7qIryrX+Z5tCx93ZZAv1hCIOdC4aTTkAaYRWgMbsk05S7ujVSSXhamai/WKEcBktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkslecJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778476225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tz4VshiSjvGUhY3dhtN6lD+p4cKMAlBefoUW+XXMHE=;
	b=CkslecJfvBFG/Ry7ZQArJ8S9+XzTgIl5H90LsEvb2QTHEpPWcYHXM+qAdd+mVMZAtGkUND
	EYuFvgbS8Yx9NFKz/aO8oBsTRzonDzZLK8soH22/6UdydZbo8hakX3lFHVSTSy6LJo4Q3q
	95ukbXbll8bpeUcjdZ380QKW8Sg4eYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-w6iTBQSwOBK7DQjDiHYbAg-1; Mon,
 11 May 2026 01:10:18 -0400
X-MC-Unique: w6iTBQSwOBK7DQjDiHYbAg-1
X-Mimecast-MFC-AGG-ID: w6iTBQSwOBK7DQjDiHYbAg_1778476215
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51FEF19560B4;
	Mon, 11 May 2026 05:10:13 +0000 (UTC)
Received: from [10.2.16.21] (unknown [10.2.16.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A09030001BE;
	Mon, 11 May 2026 05:10:04 +0000 (UTC)
Message-ID: <8aaa7dd9-2426-475c-af64-85ef5f2aa855@redhat.com>
Date: Mon, 11 May 2026 01:10:02 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cgroup/cpuset: Fix deadline bandwidth leak in
 cpuset_can_attach()
To: Aaron Tomlin <atomlin@atomlin.com>, tsbogend@alpha.franken.de,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: chenridong@huaweicloud.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, omosnace@redhat.com,
 kees@kernel.org, neelx@suse.com, sean@ashe.io, chjohnst@gmail.com,
 steve@abita.co, mproche@gmail.com, nick.lange@gmail.com,
 cgroups@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260509164847.939294-1-atomlin@atomlin.com>
 <20260509164847.939294-2-atomlin@atomlin.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260509164847.939294-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 4EC73507FBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15715-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[atomlin.com,alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/9/26 12:48 PM, Aaron Tomlin wrote:
> During a cgroup migration, cpuset_can_attach() iterates over the
> provided taskset. If a task within the batch is a deadline (DL) task,
> the destination cpuset's DL metrics (i.e., nr_migrate_dl_tasks and
> sum_migrate_dl_bw) are appropriately incremented.
>
> However, if a subsequent task in the same migration batch fails the
> task_can_attach() check, the loop aborts and jumps directly to
> out_unlock. Consequently, any DL metrics accumulated from previously
> processed tasks in the batch remain permanently inflated in the
> destination cpuset. Because the migration is subsequently aborted by the
> cgroup core, cpuset_cancel_attach() is never invoked to unwind these
> specific increments.
>
> This behaviour results in a permanent leak of deadline bandwidth, which
> incorrectly restricts the admission control capacity of the destination
> cpuset.
>
> To resolve this, introduce an out_unlock_reset failure path that
> conditionally invokes reset_migrate_dl_data(). This guarantees that if a
> batch migration is aborted for any reason, the pending DL metrics are
> safely reset before returning the error.
>
> Fixes: 0a67b847e1f06 ("cpuset: Allow setscheduler regardless of manipulated task")

That is not the commit that introduced the bug. Anyway, there is already 
another patch sent recently to fix this bug. See

https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@kylinos.cn/

Cheers,
Longman



