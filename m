Return-Path: <cgroups+bounces-4087-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3EE947381
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 04:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124CB1C20AEE
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A113C9B3;
	Mon,  5 Aug 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIVNCdaX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CA2BCF7;
	Mon,  5 Aug 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826747; cv=none; b=htxch7lDJnPYpMowykWbYRRFXZOhTNNYvWX0xGxudn7VH7kRrevBsF++O1IAfe4wVzJqkVN9TEWmiFvZg08NHY+ja8A+rQRcigfjGI7n0JRY9z2ue3DHkoknUrCEvOdOOt9a81vrmdZVxEfKBp9neXYLC+rJhZA1Cln2IgiVnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826747; c=relaxed/simple;
	bh=V8wh6d6ZtqImE6AX90LtdmD9AzPtO3ZLthBz+nRGAa8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oRrIra3jqnEotbdOZMpFo47gJk+cqxDbbdNH0rn8Rz3fmbmqf1wcmjljS+i/5mMMSqzfaF6HbghcawGvNFVXavoldnziYmruJB+jI2+ZBQ2XwCrX+IHLxAHQM/leePFlxqWP1Gf5El9xkNUqGvG+iZ+Jv3D38E+jRiMsEwLoeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIVNCdaX; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722826742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8wh6d6ZtqImE6AX90LtdmD9AzPtO3ZLthBz+nRGAa8=;
	b=fIVNCdaXXUpDe4+FzNILBIyzwEArX9OQvgfH+bkYslOyM6GDm7l8cR85XTISn4vG0d2yEi
	kHxFWfENnLBK1J53XV8AVKizpJJv2b6SuvUjF/Zl6wTLmEj+uZkD9Y9enyrjduMJU0UHkQ
	I3It5yLN0w2xExgM83mnMqgrVGQoj0U=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240802235822.1830976-1-shakeel.butt@linux.dev>
Date: Mon, 5 Aug 2024 10:58:22 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <39C19964-C74E-4479-AB21-74B7C603CAC8@linux.dev>
References: <20240802235822.1830976-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Aug 3, 2024, at 07:58, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>=20
> The commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure
> after many small jobs") decoupled the memcg IDs from the CSS ID space =
to
> fix the cgroup creation failures. It introduced IDR to maintain the
> memcg ID space. The IDR depends on external synchronization mechanisms
> for modifications. For the mem_cgroup_idr, the idr_alloc() and
> idr_replace() happen within css callback and thus are protected =
through
> cgroup_mutex from concurrent modifications. However idr_remove() for
> mem_cgroup_idr was not protected against concurrency and can be run
> concurrently for different memcgs when they hit their refcnt to zero.
> Fix that.
>=20
> We have been seeing list_lru based kernel crashes at a low frequency =
in
> our fleet for a long time. These crashes were in different part of
> list_lru code including list_lru_add(), list_lru_del() and reparenting
> code. Upon further inspection, it looked like for a given object =
(dentry
> and inode), the super_block's list_lru didn't have list_lru_one for =
the
> memcg of that object. The initial suspicions were either the object is
> not allocated through kmem_cache_alloc_lru() or somehow
> memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg =
but
> returned success. No evidence were found for these cases.
>=20
> Looking more deeper, we started seeing situations where valid memcg's =
id
> is not present in mem_cgroup_idr and in some cases multiple valid =
memcgs
> have same id and mem_cgroup_idr is pointing to one of them. So, the =
most
> reasonable explanation is that these situations can happen due to race
> between multiple idr_remove() calls or race between
> idr_alloc()/idr_replace() and idr_remove(). These races are causing
> multiple memcgs to acquire the same ID and then offlining of one of =
them
> would cleanup list_lrus on the system for all of them. Later access =
from
> other memcgs to the list_lru cause crashes due to missing =
list_lru_one.
>=20
> Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure =
after many small jobs")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


