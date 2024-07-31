Return-Path: <cgroups+bounces-4028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B675F942734
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4195FB21385
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8218A6DE;
	Wed, 31 Jul 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLuiSbwv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B04EB38;
	Wed, 31 Jul 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408861; cv=none; b=EdJgaQiLwUo2d73aodk32I/ngcEO0PK0c95CdQUOqsdMaGzDg44UbnLuAuqbSad1FhvkMD6V6nuEUKfjm89wSin+n8rK2A1XUiey9zXQ7BfIOHQMlFH7UFm3bz0QxTSTFlgiQSUg5XGslBB/W/kJU9SeGFRo0PGpqaamk1NIap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408861; c=relaxed/simple;
	bh=v+EIVKDNPqvaaT3oRokxYgpvf8uHcseLZMrSYcvL1LE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LOtt7rCmFhmZ+OYKJ+wWKLOf+j5NtUu6SEPb+JA+m5wtKrHDBFd6yXoEUxdw1fJVOZo+Yu4ipr+4TvjGAQh9Q0fsP/VOuRpMfW5QHykMihsMHg88C9pfwQhwpup9udB3lw0PpEo3fUt+HKAwmyw7H6dF1XQxoBd42vFuDnDAgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLuiSbwv; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722408854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvgJmZbrDRLsS6oz4Eg9VHVE2v9H9tCwFtyuFn+wwGk=;
	b=jLuiSbwvVplsNFZrNgqq71DTw7aFJC+NU0Pqv1XJdCgc4F2Sze2HBVcqplv6wdObfndPgC
	tPX26jI/pCpZLrrvfH8EoA2d41oJnk16CT3rjdOGlGOd77V7++YGEYIQlfqgBRnOKrDgcj
	yd2ynquHowVH8MCtEsqU6zydSmocCEk=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240730131822.a170e6da169da396a833aa4f@linux-foundation.org>
Date: Wed, 31 Jul 2024 14:53:34 +0800
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>,
 cgroups@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <305D2228-2BE5-407B-95C3-FE4C9FD59826@linux.dev>
References: <20240725094330.72537-1-songmuchun@bytedance.com>
 <CGME20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d@eucas1p2.samsung.com>
 <3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
 <20240730131822.a170e6da169da396a833aa4f@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 31, 2024, at 04:18, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Tue, 30 Jul 2024 20:52:04 +0200 Marek Szyprowski =
<m.szyprowski@samsung.com> wrote:
>=20
>> This patch landed in today's linux-next as commit 230b2f1f31b9 ("mm:=20=

>> kmem: add lockdep assertion to obj_cgroup_memcg"). I my tests I found=20=

>> that it triggers the following warning on Debian bookworm/sid system=20=

>> image running under QEMU RISCV64:
>=20
> Thanks.  I'll drop the patch while this gets sorted out, to be nice to
> linux-next users.

Hi Andrew,

Please pick up this patch first [1], it is a fix for the above issue.

[1] =
https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.co=
m/

Thanks.=

