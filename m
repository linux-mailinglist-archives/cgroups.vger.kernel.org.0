Return-Path: <cgroups+bounces-13727-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCJaHGhWhWmnAAQAu9opvQ
	(envelope-from <cgroups+bounces-13727-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:48:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95ADF96EF
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0A51301A159
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 02:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9A827D782;
	Fri,  6 Feb 2026 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IMPBFxSu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905F1339B1
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346083; cv=none; b=ZN3O0dkP1sb4z4Mbd6lzH7H7QdhLhqMi0Ap7pATnUgptODplxHERv+1VBwFgJ0cVpMkdYLiGO3Ag19xOrkXSsBwVY+hOhGbGwha9xxaR4auEk7loaSF4R1EtqKTWvQPJQ0nXCsps8XUCmwSEM57y9ybuXX8b2Pax0af8CT5hY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346083; c=relaxed/simple;
	bh=oSiHb39C3CwNoYn3NEdsu46Nt3Mnkt7EDotjYtviSJ0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VBFcIpqW69u3tV6eOEW/STtdMUj7E7MsXAB71OEvtTxgcb0RBGajtKHaT9lCjQw5VgDR4g62Wd4BoTMXyvxwiESKmIEEc5T/5ms4PGvpMSHN7B0cK36gFDU/Ig6hq5kNX/bJk+HXphp0vKOOzgr8v7txj9xg9sPSGSiEU8VCdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IMPBFxSu; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770346081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8cUYDug+KA/z/+qG82tQKkyvE+6vqzDr2LKkma6cU4=;
	b=IMPBFxSu+8uQOW4JZAmYU378vjSSckXrZngrEjjc1dar8KyBJyMASGc9I43eGOFSz5SJo8
	4DyVZaP8DtARAOTh71nbxYIhoXIw0i1dceOTE4MvOA5bLdmlgL14cCMN1GBcIwmqd7/p0E
	drJzC+os8uGwbIuik+nmamkyTkB4c/s=
Date: Fri, 06 Feb 2026 02:47:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e155ad8af874f10baaed91f1d12fde222b82036b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible
 pages
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, linux-mm@kvack.org, "Jiayuan Chen"
 <jiayuan.chen@shopee.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Nick Terrell" <terrelln@fb.com>, "David
 Sterba" <dsterba@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260206022152.67992-1-sj@kernel.org>
References: <20260206022152.67992-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13727-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,shopee.com,cmpxchg.org,linux.dev,gmail.com,linux-foundation.org,fb.com,suse.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C95ADF96EF
X-Rspamd-Action: no action

February 6, 2026 at 10:21, "SeongJae Park" <sj@kernel.org mailto:sj@kerne=
l.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:


>=20
>=20On Thu, 5 Feb 2026 13:30:12 +0800 Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
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
> >=20
>=20As others also mentioned, the documentation of the new stat would be =
needed.
>=20
>=20>=20
>=20> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.=
h
> >  index b6c82c8f73e1..83d1328f81d1 100644
> >  --- a/include/linux/memcontrol.h
> >  +++ b/include/linux/memcontrol.h
> >  @@ -39,6 +39,7 @@ enum memcg_stat_item {
> >  MEMCG_KMEM,
> >  MEMCG_ZSWAP_B,
> >  MEMCG_ZSWAPPED,
> >  + MEMCG_ZSWAP_RAW,
> >  MEMCG_NR_STAT,
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
> >  +{
> >  + return size =3D=3D PAGE_SIZE;
> >  +}
> >  +
> >=20
>=20No strong opinion, but I'm not really sure if the helper is needed, b=
ecause it
> feels quite simple logic:
>=20
>=20 "If an object is compressed and the size is same to the original one=
, the
>  object is incompressible."
>=20
>=20I also feel the function name bit odd, given the type of the paramete=
r. Based
> on the function name and the comment, I'd expect it to receive a zswap_=
entry
> object. I understand it is better to receive a size_t, to be called fro=
m
> obj_cgroup_[un]charge_zswap(), though. Even in the case, I think the na=
me can
> be better (e.g., zswap_compression_failed() or zswap_was_incompressible=
() ?),
> or at least the coment can be more kindly explain the fact that the par=
ameter
> is the size of object after the compression attempt.
>=20
>=20>=20
>=20> extern atomic_long_t zswap_stored_pages;
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
> >=20
>=20No strong opinion, but I think Shakeel's suggestion of other names is
> reasonable.
>=20
>=20>=20
>=20> #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> >  @@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[]=
 =3D {
> >  #ifdef CONFIG_ZSWAP
> >  { "zswap", MEMCG_ZSWAP_B },
> >  { "zswapped", MEMCG_ZSWAPPED },
> >  + { "zswpraw", MEMCG_ZSWAP_RAW },
> >=20
>=20Ditto.
>=20
>=20>=20
>=20> #endif
> >  { "file_mapped", NR_FILE_MAPPED },
> >  { "file_dirty", NR_FILE_DIRTY },
> >  @@ -5458,6 +5460,8 @@ void obj_cgroup_charge_zswap(struct obj_cgroup=
 *objcg, size_t size)
> >  memcg =3D obj_cgroup_memcg(objcg);
> >  mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> >  mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> >  + if (zswap_is_raw(size))
> >  + mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, 1);
> >=20
>=20I understand the helper function is better to receive size_t rather t=
han
> zswap_entry for this.
>=20
>=20>=20
>=20> rcu_read_unlock();
> >  }
> >=20=20
>=20>  @@ -5481,6 +5485,8 @@ void obj_cgroup_uncharge_zswap(struct obj_cg=
roup *objcg, size_t size)
> >  memcg =3D obj_cgroup_memcg(objcg);
> >  mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
> >  mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
> >  + if (zswap_is_raw(size))
> >  + mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, -1);
> >  rcu_read_unlock();
> >  }
> >=20=20
>=20>  diff --git a/mm/zswap.c b/mm/zswap.c
> >  index 3d2d59ac3f9c..54ab4d126f64 100644
> >  --- a/mm/zswap.c
> >  +++ b/mm/zswap.c
> >  @@ -723,7 +723,7 @@ static void zswap_entry_free(struct zswap_entry =
*entry)
> >  obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> >  obj_cgroup_put(entry->objcg);
> >  }
> >  - if (entry->length =3D=3D PAGE_SIZE)
> >  + if (zswap_is_raw(entry->length))
> >  atomic_long_dec(&zswap_stored_incompressible_pages);
> >  zswap_entry_cache_free(entry);
> >  atomic_long_dec(&zswap_stored_pages);
> >  @@ -941,7 +941,7 @@ static bool zswap_decompress(struct zswap_entry =
*entry, struct folio *folio)
> >  zs_obj_read_sg_begin(pool->zs_pool, entry->handle, input, entry->len=
gth);
> >=20=20
>=20>  /* zswap entries of length PAGE_SIZE are not compressed. */
> >  - if (entry->length =3D=3D PAGE_SIZE) {
> >  + if (zswap_is_raw(entry->length)) {
> >  WARN_ON_ONCE(input->length !=3D PAGE_SIZE);
> >  memcpy_from_sglist(kmap_local_folio(folio, 0), input, 0, PAGE_SIZE);
> >  dlen =3D PAGE_SIZE;
> >=20
>=20Below this part, I show 'dlen =3D=3D PAGE_SIZE'. Should it also be co=
nverted to
> use the helper function?
>=20

The=20dlen variable represents the decompressed (plaintext) size.=0D
Since we compress individual pages, the decompressed output should
always be PAGE_SIZE in normal cases.

This check validates whether decompression produced the expected result, =
not whether the entry is incompressible.

Using zswap_is_incomp() here would be semantically incorrect - the helper=
 is meant to check if an
entry was stored without compression (i.e., compression failed to reduce =
size), while dlen =3D=3D PAGE_SIZE
verifies the output of decompression is valid.

