Return-Path: <cgroups+bounces-7288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F4A78419
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799BF188E00C
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C082147E0;
	Tue,  1 Apr 2025 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jy6SaD/C"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED92036FA
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543489; cv=none; b=hzT0JH04UAzJukOVrXwXwkhChLiTgJ0Gt2sSodyZn1WPSue5QkKu8pTnNAVuRxr+/tfF35riIma5SIidq4OUt/C346kF1vBnVx1DT6q4C+b5yno+9joeJoqr6UxsLWcMkLbJdBiD4VC5CBs/bU4UINADOzxEfZzqmt3xtDBcvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543489; c=relaxed/simple;
	bh=Td1LRDkkGYyldpNI6UbONyAt4GsxuIED4xPo3I8nrrk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=d55mo3HhSTF8jo7zZeLK1SaPViuySQyoaW7I4QOYfqQPe8OvT+9WO3yXUvlfKA1YjtNJNapzhvs5fQs88riyEoSUy9gfC32b09SQ3nZg3ZG89b+jajxiAxSmCAUFsBpYhhV2y2jrDyi5osDEDl1JlcYSNqQEzS1zCb86npQ2te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jy6SaD/C; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743543475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td1LRDkkGYyldpNI6UbONyAt4GsxuIED4xPo3I8nrrk=;
	b=Jy6SaD/CMeGr3h+1j0RP7cdzlPLbYg1V84A4lkTh/GDTbsZBDGOfHDMAJuoFgpHe7wa12c
	sse06pJw3QHlcMVA8Oou5jG5XU/+q9KZmHzqdemdCFsX3xpww2Th55S93kYHFiAD9OsKj0
	yIlFYyswy0NAlnJCVqc+b36HjoJI8gE=
Date: Tue, 01 Apr 2025 21:37:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <07d65709cbc9e4e0fbf25da7d7e70e19aec7409d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] cgroup: rstat: call cgroup_rstat_updated_list with
 cgroup_rstat_lock
To: "Shakeel Butt" <shakeel.butt@linux.dev>, "Tejun Heo" <tj@kernel.org>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>,
 "=?utf-8?B?TWljaGFsIEtvdXRuw70=?=" <mkoutny@suse.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Meta kernel team" <kernel-team@meta.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>
In-Reply-To: <20250401170912.2161953-1-shakeel.butt@linux.dev>
References: <20250401170912.2161953-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 1, 2025 at 7:09 PM, "Shakeel Butt" <shakeel.butt@linux.dev> wrote:
>=20
>=20The commit 093c8812de2d ("cgroup: rstat: Cleanup flushing functions a=
nd
> locking") during cleanup accidentally changed the code to call
> cgroup_rstat_updated_list() without cgroup_rstat_lock which is required=
.=20
>=20Fix it.
>=20
>=20Fixes: 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and l=
ocking")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6564c3d6-9372-4352-9847-1eb3aea07ca=
4@linux.ibm.com/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks for fixing this.

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

