Return-Path: <cgroups+bounces-13590-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id paasEisugGnE3wIAu9opvQ
	(envelope-from <cgroups+bounces-13590-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 05:55:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D0C83AB
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 05:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EFE73007AEC
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75C27A123;
	Mon,  2 Feb 2026 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K7xHFaVH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF83EBF37
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770008103; cv=none; b=jNKq7peRPDqhR9riKInYGVCawVA8cEyHBONWuKudJ6sJjr4JumplBfzrG0FkNgTa8wf+SRpRja44zeMpG6vTWEXgyRXdlt6mmMhf1L59lYrCfrEaCA16zFgM0y1rEUlLW6vrVwSEq7xN9nEST5XPUg/dOdUh4yWyuMyzKsdVYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770008103; c=relaxed/simple;
	bh=TmlArQDdr1ZAc/NGzLSsuGnx+WpytNv+fOdrcGsTK8o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XywjYL4dN08+2Riqf+zFbMXNg3b/NwI/wXAPbyiWL723EBrwqbCbkWjglylrUisruSJF45XLrYt4TGU6TKFsU29wv4RoeB/tN+VcoM1SRORaC992GmtqQrg7JB47s3ptUu/fgWOHL/3PNyjp3FlsmnOFGabx+U15U0I6cH9eso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7xHFaVH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770008099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQMGuhj4v1Wf/hZq+ihAsexgXJVjJdPHN5MjuTUGtm4=;
	b=K7xHFaVH9oPc1Yh/xCOEHjVjZmuhacqZUTn0fta11OA0WnR0Dr+LIqDT7D0B84IMh2J6Gw
	T3unqGruLGEy02l4zvf1P4muxuoHYLbqQR9gEqrO6tXdtQ2j6CPXKIiRg6/EmZcUIB8x5F
	k/F2dWJsb0YCvxzTEmk8H8uxDGq5He4=
Date: Mon, 02 Feb 2026 04:54:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shakeel Butt" <shakeel.butt@linux.dev>
Message-ID: <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
To: "Dev Jain" <dev.jain@arm.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Muchun Song"
 <muchun.song@linux.dev>, "Harry Yoo" <harry.yoo@oracle.com>, "Qi Zheng"
 <qi.zheng@linux.dev>, "Vlastimil Babka" <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Meta kernel team" <kernel-team@meta.com>
In-Reply-To: <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
 <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
 <aYAmGc6lu973jRwu@linux.dev>
 <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13590-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F5D0C83AB
X-Rspamd-Action: no action

> >=20
>=20> >=20
>=20> > Hello Shakeel,
> > >=20
>=20> >  We are seeing a regression in micromm/munmap benchmark with this=
 patch, on arm64 -
> > >  the benchmark mmmaps a lot of memory, memsets it, and measures the=
 time taken
> > >  to munmap. Please see below if my understanding of this patch is c=
orrect.
> > >=20
>=20>  Thanks for the report. Are you seeing regression in just the bench=
mark
> >  or some real workload as well? Also how much regression are you seei=
ng?
> >  I have a kernel rebot regression report [1] for this patch as well w=
hich
> >  says 2.6% regression and thus it was on the back-burner for now. I w=
ill
> >  take look at this again soon.
> >=20
>=20The munmap regression is ~24%. Haven't observed a regression in any o=
ther
> benchmark yet.

Please share the code/benchmark which shows such regression, also if you =
can
share the perf profile, that would be awesome.

