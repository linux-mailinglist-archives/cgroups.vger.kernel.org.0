Return-Path: <cgroups+bounces-14687-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPg4MFUYq2kfaAEAu9opvQ
	(envelope-from <cgroups+bounces-14687-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 19:09:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38322692C
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39BB03052452
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE9421896;
	Fri,  6 Mar 2026 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gg0+geFT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC9366804
	for <cgroups@vger.kernel.org>; Fri,  6 Mar 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820549; cv=none; b=KrJghtgeXnco/EcF0MPPEBMZT7p9KaOnpFAyfKVOChxNf0q1n8FP6wH0F44i2rPd8HeFLtqkI2OxVwdCeFvEjSC0ja9G1qx2yC+vG/tnKc+IKKqovz1TXXLc6MM8uNlVVrsUflvoTA1nSnihVKE++yPDXWPRqRray6AVfufsC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820549; c=relaxed/simple;
	bh=cTjtrEat0O2hYG/Rz93+CmJURLk2pPlMvpn1bJpM/HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6SuXaGt4WYknEMXlzUkWkoY2ID1y/MaI66lYCIn45pgb38sd2FJqHIuACVYz1qyaEAQvlWNEUBRcOjSJGoFj8H82m/Zi0CYl6wMXNKJvQSsq40dPJkaFnDl4Gnv8dIzm0Ei26VX5TdD8OQWur5uq+lYodqgunqnTe6nILuTMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gg0+geFT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772820546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crfVUH228IvBNACtGUhuwt5q0L8onBsCpt4psN5HeWY=;
	b=gg0+geFT2PMUHAu09empYeA4UJTXGv489AC/LyG2L8wnx6PIOQFp8j5W595N1ZPr4oZRFb
	RADUZMCY69FulrKCgOcpGLd1nLQVpIlGNvmvaIEJaaKChQJPF07EsHZeGGJTMnitJv5U7c
	1p72VXK9xK8uy+KCU0pbHU4HugKm6kQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-RYcXcwRgOViMcMHbn2aX3w-1; Fri,
 06 Mar 2026 13:09:03 -0500
X-MC-Unique: RYcXcwRgOViMcMHbn2aX3w-1
X-Mimecast-MFC-AGG-ID: RYcXcwRgOViMcMHbn2aX3w_1772820541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD1F618005B8;
	Fri,  6 Mar 2026 18:09:00 +0000 (UTC)
Received: from [10.22.81.146] (unknown [10.22.81.146])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0CF01956095;
	Fri,  6 Mar 2026 18:08:58 +0000 (UTC)
Message-ID: <1591cbe6-b449-49d1-9953-2c1267d09dd9@redhat.com>
Date: Fri, 6 Mar 2026 13:08:58 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Call rebuild_sched_domains() directly
 in hotplug
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huawei.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 Chen Ridong <chenridong@huaweicloud.com>
References: <20260305195329.282556-1-longman@redhat.com>
 <6ad9aa06d0fbfd79b0541cd134013e1d@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <6ad9aa06d0fbfd79b0541cd134013e1d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 3F38322692C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14687-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/6/26 12:03 PM, Tejun Heo wrote:
> Applied to cgroup/for-7.0-fixes.
>
> One minor note: the patch also changes system_unbound_wq to
> system_dfl_wq in cpuset_handle_hotplug() without mentioning it in
> the commit message.

Right, I forgot to mention that it is a suggestion from Frederic as 
system_unbound_wq will be removed in the near future.

Sorry for that.

Cheers,
Longman


