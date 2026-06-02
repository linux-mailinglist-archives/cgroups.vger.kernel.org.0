Return-Path: <cgroups+bounces-16578-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9qfOb4fH2oXhAAAu9opvQ
	(envelope-from <cgroups+bounces-16578-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:23:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F56310A3
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:23:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=drGqSvyX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16578-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16578-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A7E43029D33
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1440392C56;
	Tue,  2 Jun 2026 18:23:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB3390C8C
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 18:23:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424631; cv=none; b=kbmZBv71S575869MkkFMrV4r8qv4LbYBoUAh2f9Yysa+kHwGUQ6OwiSLh3EgPiI7Jj5wrRjJjhVFzKitlwdcpyR5vlrw4Q3gAbVfzQquu6hspUBNQAeDMGvyLJ3ZGPfW2T+4Jr1iykukQBKAIZp+BMIM+iCdpNCSMk29AkGGuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424631; c=relaxed/simple;
	bh=IcYwhzPzbsUeyZglAu/w1ud2pRgPoOzH6/AX5g6ZjWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuwA/WSuu9nxXpcLoJqSbS2ZKjE+4L0sCYcPorlIRCoHSKs/8A08yEz4v3V906gVLiP67B60byNOM7TYFaag4VfSLZaBZwM+U0oSoSXumvPcZ3GfdQ/6R0zuQvuD5Uy5UARjOkScPZlMWoYW9LpOWYrg1xxov5xl2jhm1Es2khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drGqSvyX; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780424629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFZWMhYzHFyJkn8qZO08AqGOocCfWTny7zZCB6ieDhI=;
	b=drGqSvyXpZvWk6szyBZWXsHI7gmMxuH+wobReXOg7C1zHHkhZqUfTp10Rgza5nnSwoR6uF
	28MVfF2lqSeJ039ZU1dBscWvowFE/qtPnHvzpFeKaYbsvJAsM/+zn51VcM+ZR6zi7MxWyL
	Qiz5zEoRiVfb/Kh0bQcqXSjlJXxv2hw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-8OSVFpxPNlysnleIazZVFg-1; Tue,
 02 Jun 2026 14:23:44 -0400
X-MC-Unique: 8OSVFpxPNlysnleIazZVFg-1
X-Mimecast-MFC-AGG-ID: 8OSVFpxPNlysnleIazZVFg_1780424623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13F79180057C;
	Tue,  2 Jun 2026 18:23:43 +0000 (UTC)
Received: from [10.22.80.32] (unknown [10.22.80.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75ED3180058A;
	Tue,  2 Jun 2026 18:23:41 +0000 (UTC)
Message-ID: <0c68fc55-0eed-4aac-99bd-18c93fe6fece@redhat.com>
Date: Tue, 2 Jun 2026 14:23:40 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: change ridong's email
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hanes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602091038.26901-1-ridong.chen@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260602091038.26901-1-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16578-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hanes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,huaweicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D0F56310A3


On 6/2/26 5:10 AM, Ridong Chen wrote:
> The chenridong@huaweicloud.com is no longer a valid email,
> replace it with the personal email ridong.chen@linux.dev
>
> Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ec290e38b44..e035a3be797c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6535,7 +6535,7 @@ F:	include/linux/blk-cgroup.h
>   
>   CONTROL GROUP - CPUSET
>   M:	Waiman Long <longman@redhat.com>
> -R:	Chen Ridong <chenridong@huaweicloud.com>
> +R:	Ridong Chen <ridong.chen@linux.dev>
>   L:	cgroups@vger.kernel.org
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
Acked-by: Waiman Long <longman@redhat.com>


