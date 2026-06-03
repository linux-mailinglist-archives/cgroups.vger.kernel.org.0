Return-Path: <cgroups+bounces-16616-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VGUtBY1qIGqN3AAAu9opvQ
	(envelope-from <cgroups+bounces-16616-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 19:55:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA663A50D
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 19:55:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eltnyHCK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16616-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16616-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3DFB3063AAA
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907AB38332F;
	Wed,  3 Jun 2026 17:55:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135D3812D0;
	Wed,  3 Jun 2026 17:55:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509313; cv=none; b=adq96kDRFefpZMfwgFuWkQeHoaxFgOV1uaFuUwwKFasOf6KPZiExC4bGrr1ihmSVfyd5fPLhpoerGXiPGv+cjGDRUs9/D0uthn9d4hxqpoM0l77oVYgtQ+BoN4++aA9FU7FW4VB6Z+C2q/Kjzt3H4ZAmva3zAEEmtwfM1aM+J0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509313; c=relaxed/simple;
	bh=G0rDbT469hFZorAr0zpcUyuvH/OynSKNu0YEYkNKIf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Voyj2DRfLm7NuvZ30P9ius/tuyIvgyZWzKvLW7u32p8t38skkHV5gDw4Q/JNz3soIFBg/M0CDUgTPcLPrjYuoMPWmRfTzypzCZNspevJKiX2wc7NYdEGkTjwscMwPZtMG+AGMfHamzsfasqGo/z+vJzLFt/rd8epVlE4Ou+WamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eltnyHCK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53841F00893;
	Wed,  3 Jun 2026 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509312;
	bh=dIsSV0HW1+ANeS9umGY/QJFakDMw7AYj6n8OmAaihas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eltnyHCKe3zkwhu1VQv3PxsGoVF21f2sxBgxiCfQOPiPzKfR5rO5edX8/RlSzmBoX
	 AAAqZJL+3WF9xd8vANbabA7EozFcKo5yKs/Kh/tu3fhxweIo0uFsANF4mzRi/sjKgC
	 Ly5KHTbVH3X9bQITn0CsZXBP2/JMoi7uugaSoZEST0X12vNhKqOn4/giUa0gvgVxy4
	 ywdGNqeoXM0Fk5jAnbtUl2f2XU4I9j1AfhlBYVp3w1huH+Pv8E8ADcfw4gcHmJ+VnO
	 4KnZwmmgoEKAtFwQG/7BsTwhVk9LuqTJ8CWcE7zcxsYn1rCYWE+qZ6iTNKhDd5LL/A
	 0feE5ngEA/7iQ==
Date: Wed, 3 Jun 2026 17:55:10 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Message-ID: <aiBqPjeHmECC0b0P@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com>
 <aho-Z6wshceTAYd9@google.com>
 <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16616-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96EA663A50D

> > Is the main difference that we are scanning in batches here? I think we
> > can have shrink_memcg() do that too. If anything, it might make the
> > shrinker more efficient. Over-reclaim is ofc a concern, and especially
> > in the zswap_store() path as the overhead can be noticeable. Maybe we
> > can parameterize the batch size based on the code path.
> > 
> > Nhat, what do you think?
> 
> Nhat, since we now have the referenced-based second chance algorithm, should
> we consider doing batch writeback for shrink_memcg() as well?
> 
> Of course, we could pass a parameter to control whether batch writeback is
> needed, so as to preserve the original behavior of shrink_memcg().

Yeah probably best to parameterize the batch size and keep the current
behavior of the shrinker for this series. We can play with using batches
for the shrinker later.

> 
> Thanks,
> Hao

