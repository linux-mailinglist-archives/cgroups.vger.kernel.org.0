Return-Path: <cgroups+bounces-13724-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD58Gm1MhWlw/gMAu9opvQ
	(envelope-from <cgroups+bounces-13724-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:05:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCCF91EA
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A9E6300E396
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 02:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2322A4EE;
	Fri,  6 Feb 2026 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wbldWILU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8D1990A7
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770343530; cv=none; b=nb0v9SP1NlivnJIfRK9tY3OoGl+Ih3PV5/rBcWCB2p13ZZ7oVTAvaUeAmFiVCgryIR+dw/sbyHz1lRRGdqrfKJ4Q86EPjCWBNOAbrACME6o9vzjS5AdK9N8IyijtBCUp/2ye6BvfwUn9ZeigTXGc3QGiiyktPJvplfvnhamcRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770343530; c=relaxed/simple;
	bh=eXv3Gadpzqaefasa4nPu0VsmXstnGU53NaSK3JKGaQQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=t7erj1oKf5KP+JDeTYj8zkv3/s25jbQk91dG9YMiQUDpdmBFCv7UcDVqabTY4ShgKZThZ5Pp9fd3FEjJWeOBBihWjfWwxX+u5m3L3hLZEaApWgCa5+g4GvZGdllZotdVq+Ic3quW1RynWeH3UQix5tagx6CkCL8xC0pabmVoccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wbldWILU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770343527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=up/dDjrNtGtbs/J4QNKu2FJN7ZuLHi+NXEsM8fpT+Ss=;
	b=wbldWILUm7i4AbJrg+nbp2QzH/ahNV/2Pq7EwYybJfeROrzg41/mh58FXPdDrKz/mQpvL7
	SZvJQlvyxXO8EX6tq1gOmNYtbvEDv2UAqnW9KZHgZYVUfywuB4aeGmvjuQvhY8gJSfKbrO
	4n2AEQ1R5fKf5Jz1Oau41RMHepOMI3o=
Date: Fri, 06 Feb 2026 02:05:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <2928382d5614d5632e3508c81878c8ad720ccd7e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible
 pages
To: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Nhat
 Pham" <nphamcs@gmail.com>, "Chengming Zhou" <chengming.zhou@linux.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Nick Terrell"
 <terrelln@fb.com>, "David Sterba" <dsterba@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <hevovghpl2udhpof66oz26ulrpqcrtuwjxcakyskoeoil2wo6x@osbrncj7ifwz>
References: <20260205053013.25134-1-jiayuan.chen@linux.dev>
 <hevovghpl2udhpof66oz26ulrpqcrtuwjxcakyskoeoil2wo6x@osbrncj7ifwz>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13724-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,shopee.com,cmpxchg.org,kernel.org,linux.dev,gmail.com,linux-foundation.org,fb.com,suse.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0CCCF91EA
X-Rspamd-Action: no action

February 6, 2026 at 08:39, "Yosry Ahmed" <yosry.ahmed@linux.dev mailto:yo=
sry.ahmed@linux.dev?to=3D%22Yosry%20Ahmed%22%20%3Cyosry.ahmed%40linux.dev=
%3E > wrote:


>=20
>=20On Thu, Feb 05, 2026 at 01:30:12PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  The global zswap_stored_incompressible_pages counter was added in =
commit
> >  dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as=
-is")
> >  to track how many pages are stored in raw (uncompressed) form in zsw=
ap.
> >  However, in containerized environments, knowing which cgroup is
> >  contributing incompressible pages is essential for effective resourc=
e
> >  management.
> >=20=20
>=20>  Add a new memcg stat 'zswpraw' to track incompressible pages per c=
group.
> >  This helps administrators and orchestrators to:
> >=20=20
>=20>  1. Identify workloads that produce incompressible data (e.g., encr=
ypted
> >  data, already-compressed media, random data) and may not benefit fro=
m
> >  zswap.
> >=20=20
>=20>  2. Make informed decisions about workload placement - moving
> >  incompressible workloads to nodes with larger swap backing devices
> >  rather than relying on zswap.
> >=20=20
>=20>  3. Debug zswap efficiency issues at the cgroup level without needi=
ng to
> >  correlate global stats with individual cgroups.
> >=20=20
>=20>  While the compression ratio can be estimated from existing stats
> >  (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> >  "uniformly poor compression" and "a few completely incompressible pa=
ges
> >  mixed with highly compressible ones". The zswpraw stat provides dire=
ct
> >  visibility into the latter case.
> >=20=20
>=20>  Changes
> >  -------
> >=20=20
>=20>  1. Add zswap_is_raw() helper (include/linux/zswap.h)
> >  - Abstract the PAGE_SIZE comparison logic for identifying raw entrie=
s
> >  - Keep the incompressible check in one place for maintainability
> >=20=20
>=20>  2. Add MEMCG_ZSWAP_RAW stat definition (include/linux/memcontrol.h=
,
> >  mm/memcontrol.c)
> >  - Add MEMCG_ZSWAP_RAW to memcg_stat_item enum
> >  - Register in memcg_stat_items[] and memory_stats[] arrays
> >  - Export as "zswpraw" in memory.stat
> >=20=20
>=20>  3. Update statistics accounting (mm/memcontrol.c, mm/zswap.c)
> >  - Track MEMCG_ZSWAP_RAW in obj_cgroup_charge/uncharge_zswap()
> >  - Use zswap_is_raw() helper in zswap.c for consistency
> >=20=20
>=20>  Test
> >  ----
> >=20=20
>=20>  I wrote a simple test program[1] that allocates memory and compres=
ses it
> >  with zstd, so kernel zswap cannot compress further.
> >=20=20
>=20>  $ cgcreate -g memory:test
> >  $ cgexec -g memory:test ./test_zswpraw &
> >  $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
> >  zswpraw 0
> >  zswpin 0
> >  zswpout 0
> >  zswpwb 0
> >=20=20
>=20>  $ echo "100M" > /sys/fs/cgroup/test/memory.reclaim
> >  $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
> >  zswpraw 104800256
> >  zswpin 0
> >  zswpout 51222
> >  zswpwb 0
> >=20=20
>=20>  $ pkill test_zswpraw
> >  $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
> >  zswpraw 0
> >  zswpin 1
> >  zswpout 51222
> >  zswpwb 0
> >=20=20
>=20>  [1] https://gist.github.com/mrpre/00432c6154250326994fbeaf62e0e6f1
> >=20=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  ---
> >  include/linux/memcontrol.h | 1 +
> >  include/linux/zswap.h | 9 +++++++++
> >  mm/memcontrol.c | 6 ++++++
> >  mm/zswap.c | 6 +++---
> >  4 files changed, 19 insertions(+), 3 deletions(-)
> >=20=20
>=20>  diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol=
.h
> >  index b6c82c8f73e1..83d1328f81d1 100644
> >  --- a/include/linux/memcontrol.h
> >  +++ b/include/linux/memcontrol.h
> >  @@ -39,6 +39,7 @@ enum memcg_stat_item {
> >  MEMCG_KMEM,
> >  MEMCG_ZSWAP_B,
> >  MEMCG_ZSWAPPED,
> >  + MEMCG_ZSWAP_RAW,
> >=20
>=20Please change the name as Shakeel suggested.
>=20
>=20>=20
>=20> MEMCG_NR_STAT,
> >  };
> >=20=20
>=20>  diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> >  index 30c193a1207e..94f84b154b71 100644
> >  --- a/include/linux/zswap.h
> >  +++ b/include/linux/zswap.h
> >  @@ -7,6 +7,15 @@
> >=20=20
>=20>  struct lruvec;
> >=20=20
>=20>  +/*
> >  + * Check if a zswap entry is stored in raw (uncompressed) form.
> >  + * This happens when compression doesn't reduce the size.
> >  + */
> >  +static inline bool zswap_is_raw(size_t size)
> >=20
>=20Internall as well, please rename this to zswap_is_incompressible() or
> zswap_is_incomp(). Not a big fan of the helper because it doesn't add
> much, but I don't feel strongly either way.
>=20
>=20>=20
>=20> +{
> >  + return size =3D=3D PAGE_SIZE;
> >  +}
> >  +
> >  extern atomic_long_t zswap_stored_pages;
> >=20=20
>=20>  #ifdef CONFIG_ZSWAP
> >  diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >  index 007413a53b45..32fb801530a3 100644
> >  --- a/mm/memcontrol.c
> >  +++ b/mm/memcontrol.c
> >  @@ -341,6 +341,7 @@ static const unsigned int memcg_stat_items[] =3D=
 {
> >  MEMCG_KMEM,
> >  MEMCG_ZSWAP_B,
> >  MEMCG_ZSWAPPED,
> >  + MEMCG_ZSWAP_RAW,
> >  };
> >=20=20
>=20>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> >  @@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[]=
 =3D {
> >  #ifdef CONFIG_ZSWAP
> >  { "zswap", MEMCG_ZSWAP_B },
> >  { "zswapped", MEMCG_ZSWAPPED },
> >  + { "zswpraw", MEMCG_ZSWAP_RAW },
> >=20
>=20Here as well: zswap_incompressible or zswap_incomp?
>=20
>=20Other than the renames and doc, LGTM.
>=20
>=20>=20


Thanks=20Yosry!

I'll rename everything to use "incomp" (MEMCG_ZSWAP_INCOMP, zswap_is_inco=
mp(), "zswap_incomp")
and update the documentation in v2.

