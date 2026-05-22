Return-Path: <cgroups+bounces-16196-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGaJApD3D2oTSAYAu9opvQ
	(envelope-from <cgroups+bounces-16196-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:28:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B715AF80D
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B49301F1A1
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411436AB77;
	Fri, 22 May 2026 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lq5o7TK2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24E33F588
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431300; cv=none; b=KXAMEvm+MFn2gtXDLsfj7I1Q+eiY3Yg3PALEUCVIHZAyfVyegJd3Z45CdDNq4soWKkBsTLOkMBdxuw2cGqPJKheG9amdqIlglGxlXO+ms4bd5IinrOWEkWd9RA/DLt+ZJ3IpQ1Fwk1QaBntMcZ9m/5uZmNTBvU4p9FAxNaQzqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431300; c=relaxed/simple;
	bh=fP00X4k8MmjG+IguaSew3taRAL1FxN+RIEhfaao2zVk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K6M4NRPPAiZDra8pLR996UBLoOhZfmwRm/EvKvba5MGI8T6hWr8/TcMt7AC/VYzbyUq1rxLrGqxa/YCiiQdXmQ58w/gxEXlGcWuTwWI3m7FcrWAUhsKCYIhtCnKi7R92/sokf410oWnGg42tZ3+F6DoNLpuF/fNEwNterqbge0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lq5o7TK2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779431296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V7UQqNrZ9uHp5/iZSBaT8tXf5HPRHPJw5/0rwYb3Qg=;
	b=lq5o7TK2C5sv98lfHMgrVSITzYSD4jMhnl/rsr/dC1xxmIz0sAkB+EhOF0dpwqD3qNx7mU
	fVVse2Kyo3f0wbrnIqtoqtozvQ7vnbeV50hNaOr+qgBkq6S3Dz/D/Bau2JLNPmFuJW+96s
	9IUeMwSqGmlMZ7T/XGOprzFHUl5XRxY=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260522011908.1669332-3-shakeel.butt@linux.dev>
Date: Fri, 22 May 2026 14:27:41 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Harry Yoo <harry@kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3BDAA74-EE1A-46BB-B818-30A2D70C1FA6@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
 <20260522011908.1669332-3-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16196-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.915];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 64B715AF80D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 22, 2026, at 09:19, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>=20
> Currently struct obj_stock_pcp stores nr_bytes in an 'unsigned int'
> which is 4 bytes on 64-bit machines. Switch the field to uint16_t to
> shrink the per-CPU cache.
>=20
> The kernel supports PAGE_SIZE_4KB, _8KB, _16KB, _32KB, _64KB and
> _256KB (see HAVE_PAGE_SIZE_* in arch/Kconfig). After the
> PAGE_SIZE-aligned flush in __refill_obj_stock(), the sub-page
> remainder fits in uint16_t up through 64KiB pages where PAGE_SIZE - 1
> =3D=3D U16_MAX, but on 256KiB pages PAGE_SIZE - 1 =3D=3D 0x3FFFF =
exceeds
> U16_MAX. The accumulator also needs to stay within uint16_t between
> page-aligned flushes on 64KiB pages where PAGE_SIZE itself is
> U16_MAX + 1.
>=20
> Accumulate the new total in an 'unsigned int' local, then:
>=20
>  1. Flush whenever the accumulator would hit U16_MAX. Together with
>     the existing allow_uncharge flush at PAGE_SIZE, this keeps the
>     uint16_t safe on PAGE_SIZE <=3D 64KiB.
>=20
>  2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
>     powerpc 44x), push any sub-page remainder above U16_MAX into
>     objcg->nr_charged_bytes via atomic_add before storing back, so
>     the store cannot silently truncate. The PAGE_SHIFT > 16 guard
>     folds the branch out at compile time on smaller page sizes.
>=20
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg =
per-node type")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


