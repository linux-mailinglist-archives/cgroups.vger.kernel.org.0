Return-Path: <cgroups+bounces-14578-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE8AFlRPp2nKggAAu9opvQ
	(envelope-from <cgroups+bounces-14578-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 22:15:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3D1F743D
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F274314E09D
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24A37F723;
	Tue,  3 Mar 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fMZKh+zX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDF38C2CA
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572344; cv=none; b=XWf5ZOm7QwKLlCCx7aPtHZymiNLP+IhO7IxQTzAPQ+saxYJdB6EfxmQo8vljSobRv0TcDoPsaM8YjU5HyD37hwSbG+G2tU6QnMKOkHpVOOzMcY2yLVzHebaUAGwkPdXn4GN3W/kxWGuTgZbg/YVXvaSdulYY3gbPn5b5fbh8sqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572344; c=relaxed/simple;
	bh=J8f/rq0JhKVWLGrnHUIGFAM5wHzDzd/4yc+djUCeWPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxefbAJZNK24CjPN967YsBZJcuB0wfqanURUqOggS3B00xmgTnA/fo9zaUxbWIGQST0iuxPv4VWifrVJlL7crUKOx7ejgYXGlNu5GPpwOeJDtLASjddbGzxtNiIzhhA26OsOmppENkx71Fo7H3yU7ChecGxDDzx3i5je67pjSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fMZKh+zX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772572340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8f/rq0JhKVWLGrnHUIGFAM5wHzDzd/4yc+djUCeWPk=;
	b=fMZKh+zXIRa4g+vPYHT+JmDcAci63QcbjFjDp/Q90FjR5PZwCYwKI/kRoLm5RySjpdPeiS
	GV8Qd0rm1ZEqEklz/ok5TYdBNwk0TYREAqhEdvg/DFEAN17Jv3JF3O6PTbFkJjyaWH6Lau
	s0OkucNUKrjGor9LcxS2kFFn3OnpMk4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Hao Li <hao.li@linux.dev>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Vlastimil Babka <vbabka@suse.cz>,  Harry Yoo <harry.yoo@oracle.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]: memcg: obj stock and slab stat caching cleanups
In-Reply-To: <20260302195305.620713-1-hannes@cmpxchg.org> (Johannes Weiner's
	message of "Mon, 2 Mar 2026 14:50:13 -0500")
References: <20260302195305.620713-1-hannes@cmpxchg.org>
Date: Tue, 03 Mar 2026 21:11:49 +0000
Message-ID: <7ia4pl5kpqi2.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B6C3D1F743D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14578-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roman.gushchin@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Johannes Weiner <hannes@cmpxchg.org> writes:

> This is a follow-up to `[PATCH] memcg: fix slab accounting in
> refill_obj_stock() trylock path`. The way the slab stat cache and the
> objcg charge cache interact appears a bit too fragile. This series
> factors those paths apart as much as practical.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

My ai review bot is also entirely happy with it.

Thanks!

