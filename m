Return-Path: <cgroups+bounces-13576-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gpT/N9V7fmnsZgIAu9opvQ
	(envelope-from <cgroups+bounces-13576-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 23:01:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AEC4184
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 23:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D79B3013B48
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E1340DB1;
	Sat, 31 Jan 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R4KcuKBf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764172E6CC2
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769896912; cv=none; b=U4BdL+nWY6uPi8FEpi3YZ8c5Yod26Q3s378nKbppEiWrMCkE7BrTsE48fCv+uXDTOsHMx9+c/g2xrs71UvP1UynuI5kfEP2QuIJOffbtv9+1Wzkw6yNCHw5rw9uqI3I81liBUXmIWa82bqeCc/Gg8JlJOCHki5MPjviHKCh8cPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769896912; c=relaxed/simple;
	bh=IoNp8lAUZggjMNRuBTjqXS6Ph/tNW9JXJ8GGl+eg/vA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=epu+8cdtMmxAx9RkMRGwnvcfXY85+hJt1Oq4Y2/c3bUugCr7AYnyGhxTUAz5cGhf+gzEl9Gv0RJuD/MfR7tFRQeQTGmaK0ftS5kRnMPO3WMS8Tw1U9jBxudT8a0v4lUDoMEeuuwlWrrk3YYSzH29h8hFSjilVOsvBh2iWIpbm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R4KcuKBf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769896908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoNp8lAUZggjMNRuBTjqXS6Ph/tNW9JXJ8GGl+eg/vA=;
	b=R4KcuKBfhFTwYO7Y7Lv6/a8/QUrEjmRP6nSIE/P1vSGlydH2+kjcSnNwU/sQnDClTROohU
	uVU/e1oMBOAoJYTGkd9TBcNy2gkaEYc/PZUe7j0sAMR4xRjEXcUqOynIOwlS7aAiiTU7i6
	1KNlhbg23gME0V+AXLMccKscuWXxBCU=
Date: Sat, 31 Jan 2026 22:01:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shakeel Butt" <shakeel.butt@linux.dev>
Message-ID: <d88b91766dc017e0705b7400b5b2aae313cc64e5@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in
 collapse_file()
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Rik van Riel"
 <riel@surriel.com>, "Song Liu" <songliubraving@fb.com>, "Kiryl Shutsemau"
 <kas@kernel.org>, "Usama  Arif" <usamaarif642@gmail.com>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Zi Yan" <ziy@nvidia.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, "Nico Pache" <npache@redhat.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry
 Song" <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Matthew
 Wilcox" <willy@infradead.org>, "Meta kernel team" <kernel-team@meta.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260131131511.e5f1ec520fec066b22ca04c1@linux-foundation.org>
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
 <20260131131511.e5f1ec520fec066b22ca04c1@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13576-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,infradead.org,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux-foundation.org:email]
X-Rspamd-Queue-Id: 516AEC4184
X-Rspamd-Action: no action

January 31, 2026 at 1:15 PM, "Andrew Morton" <akpm@linux-foundation.org m=
ailto:akpm@linux-foundation.org?to=3D%22Andrew%20Morton%22%20%3Cakpm%40li=
nux-foundation.org%3E > wrote:

> As the bug is 10 years old I think I'll queue this for 6.20(?)-rc1 with
> cc:stable. Just to get it a bit more time-under-test before -stable
> kernels pick it up. Sound OK?
>

Yup, sounds reasonable.

