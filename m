Return-Path: <cgroups+bounces-15928-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCWyOBBPBWrcUgIAu9opvQ
	(envelope-from <cgroups+bounces-15928-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:26:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24C53DA6E
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4B83032F73
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 04:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4EE3A6B9A;
	Thu, 14 May 2026 04:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8fOUTSe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3836604C
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 04:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732808; cv=none; b=imbyLgpnaF92k8kYheZHp2hq5Kwe+faoAOba+bNUvxb+Ayt3LCkEz35y60bVgtC6HlSVTqPzjPCdiwSP+AwFqJf7jyGpv4F8+N6+Rl0Zeb7B601SDACL/Y4Vue/h/LyPskTRAepgbaTGkyYUJzn/5qibucNQeuIWlA6l5bEY7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732808; c=relaxed/simple;
	bh=H+QTUiaHx8+v++cYc5L7w1Z6hyfvNCmGKDJXCtgS/l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfD4mwFpK22fyjhJnaxbbn3ha5Xe+iWohdsMfJQxn7yjOkmELdtumClViJKbhAML3C96EMrcIj6WaaBESJ8YoqkLDUxyPp0Kp1bhp0mGfSCcmg54DMQ9tRjvfNWyPwGxyDj4IY6ngNr80k0GmfbedtmF7tcNSBdcmwSiTL0ikXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8fOUTSe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778732805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsS1TwMGUD2Gx+sJxdKIX/0hmaBzXUjdGlntTlTmgZ8=;
	b=a8fOUTSehVHXVkTQ7qWf+fLEVYQUhnfiXy6ctMujxBc2Hb9mT7sPZDzfnuEQKqZx9Yiegy
	PBpAOz3Jzai0nSzhMl3uDh7CA+1ub2rwPMTwV9HQJbM/KBQQgbr27CMxvEdK0RftHh5FeP
	EIrPOCxIY4jk03w1lD1nBN5nRNdvBwM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-t0OQj1KpM8yQy6SBBPOmDw-1; Thu,
 14 May 2026 00:26:42 -0400
X-MC-Unique: t0OQj1KpM8yQy6SBBPOmDw-1
X-Mimecast-MFC-AGG-ID: t0OQj1KpM8yQy6SBBPOmDw_1778732800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0F85195609E;
	Thu, 14 May 2026 04:26:39 +0000 (UTC)
Received: from [10.2.16.30] (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 405061800347;
	Thu, 14 May 2026 04:26:36 +0000 (UTC)
Message-ID: <bda91fbe-e14f-45b1-8c61-27f16122bcc1@redhat.com>
Date: Thu, 14 May 2026 00:26:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com,
 neelx@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512010341.101419-1-atomlin@atomlin.com>
 <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
 <7ae7fe29-6405-41e3-9f3b-6c1d0255dc9e@redhat.com>
 <djbtucfusnpngys2nritqsi7stjq243zchel45ahfgaruba7el@4rtk534mfq4j>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <djbtucfusnpngys2nritqsi7stjq243zchel45ahfgaruba7el@4rtk534mfq4j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 2D24C53DA6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15928-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 7:39 PM, Aaron Tomlin wrote:
> On Wed, May 13, 2026 at 07:19:18PM -0400, Waiman Long wrote:
>> Multiple source or destination cpusets in task migration can only happens
>> when the cpuset controller is enabled or disabled in a cgroup subtree. If
>> there are DL tasks in 2 or more child cgroups, enabling or disabling of the
>> cpuset controller for those child cgroups may lead to incorrect DL task
>> accounting. This patch will probably fix the DL accounting aspect. However,
>> there are also other issues unrelated to DL tasks that need to be addressed
>> as well. So this patch is incomplete in this regard. I am working on a patch
>> series to address these issues. Hopefully I can send it out in a day or 2.
>>
> Hi Longman,
>
> Acknowledged.
>
> Also, the Sashiko AI review reported: "TOCTOU race on dl_task(task) during
> rollback causes state corruption."
>
> A concurrent sched_setscheduler() could alter the scheduling class of a
> task between the initial pass and a rollback. This assertion seems valid to
> me. Currently, neither cgroup_mutex or cpuset_mutex prevents scheduling
> class changes.
>
> Should I let you handle this too?

No, you can handle it if you want. I am more familiar with the cpuset 
code, but scheduler is much more complex. I don't think I have enough 
understanding of the code to handle it correctly.

Cheers,
Longman


