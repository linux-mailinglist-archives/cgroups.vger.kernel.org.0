Return-Path: <cgroups+bounces-14814-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHYpMj82tGnTiwAAu9opvQ
	(envelope-from <cgroups+bounces-14814-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:07:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B219286ACB
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8A332DA598
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617C3AE1AD;
	Fri, 13 Mar 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U01M9q2b"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F31A681C
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417674; cv=none; b=U3Me/s0JOnTzXKyeU2zlPMYGvLvPUE4s0aEJwfs4wTv0SgFimtnzZqRDw/6MxI6EUkslqnVcXjEC6ONed8+gawlPL3cGc6OpFWQjjA8eLfbE5G8Sw4QktUUqzGVLCmHD0pWaNjzR7vQ/za1+UQb4F8XD+RPOXfd3eaAthmV1S6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417674; c=relaxed/simple;
	bh=FkznTkA5DKX2N8U+3L1wdA2sZUzJA/41sNgeh8xHSm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSgR9sYHQDM5vI3xJaOf+vJ93BL63LDzaArm14Nn+8k1+Z/cr2CsX+bNCw1Q6cJzkOxJIubImq3IO6NCmYigUWpTpOQLEgP9PJCQBg1MWL8PyszB6hV0PXEqcgRoR6tQg6z/YpVFFHMFbxvryGjcVTf1ROBB722ejejcvdN138U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U01M9q2b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773417672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rAeZciFy1NQAVUPN4+v5kB+w5GHPp0m5S00iLF1Qp0=;
	b=U01M9q2bZyZFAxfGH9KYagxDQTSo63eynn0JBE9wMK9SWn81nvHA6V/GPw4qje5O+unyFG
	GfbEEIxVEuv34Yui9OOpAm1OU9lWrhvpg6pEWnKO+yhuPm00BTLkrcOa+TS5VN1KPgIos7
	ztfQJZEM5TuU6mQlNlXBTu7396pxPaQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ekej8OXZOzilGQcM9jf5Cg-1; Fri,
 13 Mar 2026 12:01:07 -0400
X-MC-Unique: ekej8OXZOzilGQcM9jf5Cg-1
X-Mimecast-MFC-AGG-ID: ekej8OXZOzilGQcM9jf5Cg_1773417665
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 374A218002DD;
	Fri, 13 Mar 2026 16:01:05 +0000 (UTC)
Received: from [10.22.65.113] (unknown [10.22.65.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4B7B180075D;
	Fri, 13 Mar 2026 16:01:02 +0000 (UTC)
Message-ID: <62813cce-36b7-4255-b748-dc450d83aa3c@redhat.com>
Date: Fri, 13 Mar 2026 12:01:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>
References: <20260313154520.302888-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260313154520.302888-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,huaweicloud.com,cmpxchg.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14814-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 3B219286ACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 11:45 AM, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
>
>     commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>     commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
>
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
>
>     system_wq -> system_percpu_wq
>     system_unbound_wq -> system_dfl_wq
>
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e200de7c60b6..b399f5d0a158 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3937,7 +3937,7 @@ static void cpuset_handle_hotplug(void)
>   	 * item at all, this is not a problem.
>   	 */
>   	if (update_housekeeping || force_sd_rebuild)
> -		queue_work(system_unbound_wq, &hk_sd_work);
> +		queue_work(system_dfl_wq, &hk_sd_work);
>   
>   	free_tmpmasks(ptmp);
>   }

Thanks for the patch, but there is another patch that makes the
same change as part of a larger fix to the cpuset code. See commit
ca174c705db5 ("cgroup/cpuset: Call rebuild_sched_domains() directly in
hotplug")  in the cgroup tree.

Thanks,
Longman


