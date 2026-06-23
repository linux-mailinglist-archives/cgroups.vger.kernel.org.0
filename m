Return-Path: <cgroups+bounces-17169-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WArcKUjlOWovywcAu9opvQ
	(envelope-from <cgroups+bounces-17169-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:45:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 869D06B358B
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:45:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Dh+I3r0F;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17169-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17169-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A06FE3057694
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BD3859F6;
	Tue, 23 Jun 2026 01:33:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945236A342
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 01:33:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178435; cv=none; b=cyvdYj6ynWS8l2M2TvAlx5Gmha5GonZN+8XouPV5q92QcIJJlfR6OaSMU4r1icBzqyKNWXzyBfyPsxjLE3hmHadyacfdzvjzvt7P9JhkUFWZ0ZvYHCIaKDmWWCgWY4pn3PpN92kWFfZelyTYEoR5O3Y0jFmawDMnoHbo9D9UUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178435; c=relaxed/simple;
	bh=5L9DX9oqKDlgDsJTijyiFSJdSHzrES276FS+VIXBFOw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JKVIZvth4fWoQAzsiyrK9BqWedjfOxO1Y4EZOgoVyCE+V7awxtLb/lW7PN9jDFpSZVi5KEaUCJi4CZ7UPCFZAuFutVkRvZyDxM8NLVqdOluYc0xr/A4NQIa0gVd/4ix2zKGPQfkB5tjSMpYjJjm+WzgVeCJAA11Iy4QHBk5wJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dh+I3r0F; arc=none smtp.client-ip=95.215.58.188
Message-ID: <97aa10a4-0632-46a1-ac34-ab4fdccef73e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782178421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L9DX9oqKDlgDsJTijyiFSJdSHzrES276FS+VIXBFOw=;
	b=Dh+I3r0F/aGWYrKZp/CP8UZDX32V0zXSLodpVy77f4D6GH2klrwfBOc86HlIXceOjmpigB
	kGOVzG51fvCmLGR+MrnSAhMOlnjXflxC3/b31fG36X5L5TUtlaec0Ce8KTOak697hY8wSD
	yD2Br4u1VP/XY575zRM2+AD2vtuSrf8=
Date: Tue, 23 Jun 2026 09:33:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block/cgroup: Drop stale -EBUSY retry from
 blkg_conf_prep()
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
References: <20260622085623.520209-1-yangxiuwei@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260622085623.520209-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17169-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:yangxiuwei@kylinos.cn,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 869D06B358B



在 2026/6/22 16:56, Yang Xiuwei 写道:
> Since commit 8f4236d9008b ("block: remove QUEUE_FLAG_BYPASS and
> ->bypass") nothing in the blkcg blkg lookup/creation path
> returns -EBUSY anymore...

Correct. I traced every error path in blkg_conf_prep() (and blkg_create()
underneath it): the only possible values are -EINVAL, -EOPNOTSUPP, -ENOMEM,
-ENODEV and -EEXIST (from radix_tree_insert). The -EBUSY source was indeed
the blk_queue_bypass() check removed by 8f4236d9008b, so the retry branch
has been dead since 2018. Clean removal with no behavioral change.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

