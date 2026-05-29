Return-Path: <cgroups+bounces-16450-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BJlHPzVGWpmzQgAu9opvQ
	(envelope-from <cgroups+bounces-16450-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:07:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917C6070D1
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2C98300E296
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60213FE376;
	Fri, 29 May 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW5EOjNU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD43FD96E
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078037; cv=none; b=cdy1tnuxlaVfdIQnTnhCX17BHIsUouNUsOfEJoCz2GB/YW9zJZ89Y5JcFrKoFk2sXFcuh+X2diN7OuwTZuNrOYj1yseVNcH7zqAs0ACJpiIwYbBHu5eJ518Si0d0E3wbIdiW50g0g/TTovuLtXhVExAaFR/mPAdVEjWP6zyDrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078037; c=relaxed/simple;
	bh=ZORxc4n+KTH/i6FIqCuHy9fzYjBBMWfKZ1IrOukTMow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbY/6VK7Shz8gCXwGKTj10EtTY2SqIzDRDH/mcqQJtoSOwoujWk/4DQPOXt8S2FjQAkORg4uM7nlreLbt8A3X5wfD6zjlOfVUKi3NOxqUdAX9PLBRsOxR4M4uyHxzuthNn4VSWE/yyYUampTiyToawvucXG4zxjL6C6A/shj95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IW5EOjNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780078035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Yp5Z0v+vy9bAYL3uaXwsU8QnQUu67HN+KCDUZVXtOo=;
	b=IW5EOjNUJWget+CT7Ce+uscBR2y+duBMrPGPC6jYj2cWKGNAHDNzcrysxzDPKYK1pYRZad
	tcFIkLtzNQqWf/S1+ZsshytBKhWiXuQsO9T04mCV6QMXczdrdBujTZWahih4eb9qsMpBzA
	62n1HmBPE2GwPpYxdqVgMSE/XBiRuK4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-QpAdufHnMS-hShS-r71XAw-1; Fri,
 29 May 2026 14:07:09 -0400
X-MC-Unique: QpAdufHnMS-hShS-r71XAw-1
X-Mimecast-MFC-AGG-ID: QpAdufHnMS-hShS-r71XAw_1780078027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E46A1956059;
	Fri, 29 May 2026 18:07:07 +0000 (UTC)
Received: from [10.22.64.54] (unknown [10.22.64.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A80651945110;
	Fri, 29 May 2026 18:07:05 +0000 (UTC)
Message-ID: <e0db8d51-a795-4157-a390-a868a6587a8a@redhat.com>
Date: Fri, 29 May 2026 14:07:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Free sched domains on rebuild guard
 failure
To: Guopeng Zhang <guopeng.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
References: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16450-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1917C6070D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 5:37 AM, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
>
> generate_sched_domains() returns sched-domain masks and optional
> attributes that are normally handed to partition_sched_domains(), which
> takes ownership of them.
>
> rebuild_sched_domains_locked() has a WARN guard after
> generate_sched_domains() and before partition_sched_domains() to avoid
> passing offline CPUs into the scheduler domain rebuild path. If that
> guard fires, the function currently returns directly without freeing
> the generated doms and attr.
>
> Free the generated sched-domain masks and attributes before returning
> from the guard failure path.
>
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   kernel/cgroup/cpuset.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 51327333980a..c5fdebc205d8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1004,8 +1004,11 @@ void rebuild_sched_domains_locked(void)
>   	* prevent the panic.
>   	*/
>   	for (i = 0; doms && i < ndoms; i++) {
> -		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
> +		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask))) {
> +			free_sched_domains(doms, ndoms);
> +			kfree(attr);
>   			return;
> +		}
>   	}
>   
>   	/* Have scheduler rebuild the domains */
This WARN_ON_ONCE() is mainly used to catch bug during code update. It 
shouldn't be triggered in normal use. Anyway, it is a nice-to-have fix.

Reviewed-by:  Waiman Long <longman@redhat.com>





