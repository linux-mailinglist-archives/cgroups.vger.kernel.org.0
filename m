Return-Path: <cgroups+bounces-15660-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APR9FYaa/Gk6RwAAu9opvQ
	(envelope-from <cgroups+bounces-15660-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 15:58:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D95924E9B7B
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 548003078EB9
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64733FA5C8;
	Thu,  7 May 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZye/vEO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65D3F65F7
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162043; cv=none; b=SkdicbRdJ9quvOBbzi7mJBOCADdYW/xIQD5AhSGOjmsxsXemvoq0aH4Z2gi13oonTxi8B3O2L3f+HI/ToF3SSskn5rBWeaWq3FO/3PmqIoG2lJ/yKGqGmlRFfzfyRk7IFvGN7D/h1v7aia3oL9LhMAJ89YZ0gdBa+vy7geHXsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162043; c=relaxed/simple;
	bh=YBFN/8jZxMSFbyzP/Gk03pFxtAKWoGLOdakNBq7QnNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBGgCw7biXyyfsui0yTZzlfPjWclULagrYuvhktOG8T6Nl9R/6LPIYaNjJoq/iSiALFYJT+oDd8JeaoQCdxN+zwezbhlWttj6F6dIKi6/R7/hqudVMF0Ze4ui1XPhbofJ4dLQhzenKa0kv1UawoH3wYFXXmnaYsIQhvLJHnengY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZye/vEO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778162041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqVA5cExOZf1mQiP3plqnzFj9TXbyUviQpiazaj1Hp0=;
	b=JZye/vEOP5/bxmaR5qqP7WIrajOhyVrXUu7N3jQvpG9Tq1jbuY4edBUHnTInl5mUiAfL1h
	TokySxPYbP5hAfTDJviKyby10lNu05wNoivpCGInfNFc+MMBIfzALEGvtx6t9xwa3SvXlt
	vdI4E17UnzirKEgI2FDS08shhG35Fls=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-URb_qEpgNjycfWL90W6AHg-1; Thu,
 07 May 2026 09:53:56 -0400
X-MC-Unique: URb_qEpgNjycfWL90W6AHg-1
X-Mimecast-MFC-AGG-ID: URb_qEpgNjycfWL90W6AHg_1778162033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD90E195608E;
	Thu,  7 May 2026 13:53:52 +0000 (UTC)
Received: from [10.2.16.64] (unknown [10.2.16.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 212DB19560A3;
	Thu,  7 May 2026 13:53:49 +0000 (UTC)
Message-ID: <891b7731-b0e7-44ca-9954-0e5a1ee9be98@redhat.com>
Date: Thu, 7 May 2026 09:53:48 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
 __GFP_HARDWALL in cpuset_current_node_allowed()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Wandun <chenwandun1@gmail.com>
Cc: chenridong@huaweicloud.com, tj@kernel.org, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507105434.3266234-1-chenwandun@lixiang.com>
 <afx1u4kV-2kvgEEf@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <afx1u4kV-2kvgEEf@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: D95924E9B7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15660-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 8:33 AM, Michal Koutný wrote:
> On Thu, May 07, 2026 at 06:54:34PM +0800, Chen Wandun <chenwandun1@gmail.com> wrote:
>> This makes it unreachable in the common case, so dying tasks can get
>> stuck in direct reclaim or even trigger OOM while trying to exit,
>> despite being allowed to allocate from any node.
> (OTOH, the caused OOM could select this task and bypass the hardwall. So
> this should only expedite but no unblock the exit path.)
>
>> Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
>> can allocate memory from any node to exit quickly, even when cpusets
>> are enabled.
> This makes sense to me on its own (given other hardwall exemptions,
> namely the commit c596d9f320aaf ("cpusets: allow TIF_MEMDIE threads to
> allocate anywhere")).
>
> Acked-by: Michal Koutný <mkoutny@suse.com>

This looks good to me too.

Acked-by: Waiman Long <longman@redhat.com>

>
>
> At first, I wondered whether this could happen on cpuset v2 -- it can --
> because only per-cpuset hardwalling is absent but the generic logic for
> GFP_USER allocations is still meant to be in place. Nevertheless, it
> occured to me we can spare callback_lock in this function (a separate
> chaneg for cpuset_current_node_allowed()):
>
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4213,6 +4213,9 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>          if (current->flags & PF_EXITING) /* Let dying task have memory */
>                  return true;
>
> +       if (is_in_v2_mode())
> +               return true;
> +
>          /* Not hardwall and node outside mems_allowed: scan up cpusets */
>          spin_lock_irqsave(&callback_lock, flags);

Yes, it is a performance optimization that is worth to have as cgroup v2 
doesn't have the concept of memory hardwall yet.

Cheers,
Longman


