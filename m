Return-Path: <cgroups+bounces-15987-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJRUFcGoB2r9BAMAu9opvQ
	(envelope-from <cgroups+bounces-15987-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 01:14:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BED559429
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51478301DCDB
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800653B840F;
	Fri, 15 May 2026 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS5wB+mI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8443009CB
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886845; cv=none; b=WsTMi5lSSI9T2JYBB07JbvJr4pqnDhsEUUD9+YLIP613Afpx8gru6GAsTLIntvCc+GeU7TXetwYWkklYIN5Hswm/NevxCtiZsffCEV0/Jk4G7PFSVUDXYnKTJ7mlhiXjkSscZzd6XBtimEfMjGMA4kRwL0HoHDTl+gEvjTvftOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886845; c=relaxed/simple;
	bh=TIz7amTn0pbdvFvm9B5AV2/Lj2TpRUJHh0aDutwgrCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2XHo0lisc/wqjM4iEsTFSHQHmtSYPsb9mnffjv9oNHuNL8vsYWBrUg9zrG37DWU97C7Pr7To+U6GalhXDAU7aZVr8aKS37KJ3TabZYMSVSMEaGSNxbfKAdGy+PZgrvTuRI/V6tbXmP4ndVwDkmhjBys9rnwpHdULWG7f7xJQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS5wB+mI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778886843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO6JIahKwvP2yRWnlAdpq/IyOdU4MFgoTUre7vZgkKE=;
	b=VS5wB+mIQ3cb6c8PWxJUDuIyMc/+WSVxDRP3/UA8noSXXoP2njVY2nIPNAM96Hr/13QxRp
	S8z2NnsmwcorzpltoNZ8CdZuOAHUOhw6zOTKNWB57cbR5iAA8FjiKqQAUYp6h18Uhc0SHW
	+grFDwHWqupmiR5+YlKPCKICOW+8XL0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-UTv4I7llOnuG4No4J8G3zg-1; Fri,
 15 May 2026 19:13:59 -0400
X-MC-Unique: UTv4I7llOnuG4No4J8G3zg-1
X-Mimecast-MFC-AGG-ID: UTv4I7llOnuG4No4J8G3zg_1778886838
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD77D1800616;
	Fri, 15 May 2026 23:13:57 +0000 (UTC)
Received: from [10.2.16.156] (unknown [10.2.16.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65F3730001A2;
	Fri, 15 May 2026 23:13:54 +0000 (UTC)
Message-ID: <40ee8cb3-575e-427b-a33b-459e88e31184@redhat.com>
Date: Fri, 15 May 2026 19:13:52 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 0/4] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20260514170240.575156-1-longman@redhat.com>
 <4f49602d35d987e029b8e92a577f0c60@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <4f49602d35d987e029b8e92a577f0c60@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 97BED559429
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15987-lists,cgroups=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/14/26 5:46 PM, Tejun Heo wrote:
> Hello,
>
> Quick AI-assisted review pass; passing the points along for human eyes.
Thank for passing the AI review info.
> Patch 4:
>
> - The leader loop comment says "Only v1 supports memory_migrate", but
>    CS_MEMORY_MIGRATE is set unconditionally on v2 cpusets in
>    cpuset_css_alloc(). With v2 controller-disable folding children with
>    differing effective_mems into the parent, picking a single
>    llist_entry(src_cs_head.first, ...) as oldcs passes the wrong source
>    nodemask to cpuset_migrate_mm() for every leader whose actual source
>    differs. Looks like the source needs to be looked up per leader.
I falsely assumes that CS_MEMORY_MIGRATE isn't set for v2. I am going to 
move the cpuset_migrate_mm() call into cpuset_attach_task() as well. To 
enable access to right oldcs information, I have to reluctantly add the 
oldcs pointer to task_struct as that is the simplest way moving forward.
>
> - cs->old_mems_allowed updates are inconsistent across destinations: the
>    mid-loop transition assigns cs->effective_mems (raw) while the tail
>    assignment uses cpuset_attach_nodemask_to (after guarantee_online_mems).
>    The v2 fast-path also updates only the first-task cs, leaving other
>    destinations on dst_cs_head stale.
I will clarify the confusion and fix the v2 fast-path in v2.
> Patch 3:
>
> - Changelog says "the newly cloned task isn't the group leader", but for
>    CLONE_INTO_CGROUP without CLONE_THREAD the new task is its own
>    group_leader, so the new mpol_rebind_mm() block in cpuset_attach_task()
>    does run from cpuset_fork(). Either acknowledge as an incidental
>    improvement or guard the new path.
Will update the patch description.
>
> Patch 1:
>
> - alloc_dl_bw() reads confusingly next to the scheduler's dl_bw_alloc()
>    while doing more (pick cpu, call dl_bw_alloc, record cs->dl_bw_cpu).
>    Something like cpuset_reserve_dl_bw() would be clearer.
Sure, cpuset_reserve_dl_bw() sounds like a good name.
> - The relocated "Mark attach is in progress" comment sits inside a
>    braceless else; either move it above the if (ret) or brace both arms.

Will add the additional braces though that will be removed in a later patch.

Cheers,
Longman

>
> Patch 2 looked clean.
>
> Thanks.
>
> --
> tejun
>


