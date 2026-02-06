Return-Path: <cgroups+bounces-13731-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBgINWBqhWlqBQQAu9opvQ
	(envelope-from <cgroups+bounces-13731-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 05:13:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA7F9ECF
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 05:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF2023007BB6
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD00337690;
	Fri,  6 Feb 2026 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xspz+Efq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B3336EF1
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351196; cv=none; b=u9KWpC5jFWq898RSHDFsCut4Eoy56/jRtCAV9In7eI3fSt4hgvV3TG71kkG8kV/RXAUK6Qp7+zEts+slNAu3r6kOSWHTjvX3Ytl6DkmGR6SrrebeT8C4r4WpV4mOiiqmDY1NLF4jCUEEf1YI61T3o14+658wgkW9HJXA3C58nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351196; c=relaxed/simple;
	bh=OkIxjItV5J7u4JTVDrMV2vPm2O8q/0oqj8QfRwzGxHA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ORqOHqEbFfn+xJwnzrwrSQtWaULdqame9Vrv0SNrfLvPi3MYC0MXzWtn2NL3+fHgwbTapIn6g1DkfnFo8iiF00oYDnFgu7Zn3me5RpDk+fJ9klKrqCALqmNnw/t8e2ojuBZ0FxMz2v/qFzUleeJhfWBzbfgC48h7tCH4HF7OwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xspz+Efq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770351184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2nb7m/lJo+RpXLZ4jqQFzQjiRXw6teH08HYzSdnXqs=;
	b=xspz+Efq/TClnHX6aZjGa8how1UeJlibzMvrHFBhNPg3bwRVYPKbGtaSt+RW8hloaLNyE6
	D9Jx3KG2+gvtBFS6wcc7usHkrUMMXkBQI9W1pRHJipcIU6FlLaNfA4VGlhdRQ0e3Sj5KXu
	8XIkPbPxT4jtZ1NwxcXHgLXT7UOLZVE=
Date: Fri, 06 Feb 2026 04:12:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <b40e6e0a63c4303e048ed0dbc61c09788de98e19@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible
 pages
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, linux-mm@kvack.org, "Jiayuan Chen"
 <jiayuan.chen@shopee.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>,
 "Chengming Zhou" <chengming.zhou@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Nick Terrell" <terrelln@fb.com>, "David  
 Sterba" <dsterba@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <3179fa38027bdacdd38b4ef34b493bdb5ef7a19a@linux.dev>
References: <20260206022152.67992-1-sj@kernel.org>
 <b0b984be60ffa366929d363ec2b63f5c92187556@linux.dev>
 <3179fa38027bdacdd38b4ef34b493bdb5ef7a19a@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13731-lists,cgroups=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 79DA7F9ECF
X-Rspamd-Action: no action

> >=20
>=20> On Thu, 5 Feb 2026 13:30:12 +0800 Jiayuan Chen <> wrote:
> >=20=20
>=20>=20=20
>=20>  From: Jiayuan Chen <jiayuan.chen@shopee.com>
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
>=20>  As others also mentioned, the documentation of the new stat would =
be needed.
> >=20=20
>=20>=20=20
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
> >=20=20
>=20>  No strong opinion, but I'm not really sure if the helper is needed=
, because it
> >  feels quite simple logic:
> >=20=20
>=20>  "If an object is compressed and the size is same to the original o=
ne, the
> >  object is incompressible."
> >=20=20
>=20>  I also feel the function name bit odd, given the type of the param=
eter. Based
> >  on the function name and the comment, I'd expect it to receive a zsw=
ap_entry
> >  object. I understand it is better to receive a size_t, to be called =
from
> >  obj_cgroup_[un]charge_zswap(), though. Even in the case, I think the=
 name can
> >  be better (e.g., zswap_compression_failed() or zswap_was_incompressi=
ble() ?),
> >  or at least the coment can be more kindly explain the fact that the =
parameter
> >  is the size of object after the compression attempt.
> >=20=20
>=20>  I vote to drop the helper.
> >=20
>=20The reason I introduced the helper is that the incompressible check n=
ow lives in two places:
>=20
>=20In zswap.c - for the global zswap_stored_incompressible_pages counter
> In memcontrol.c - for the per-memcg MEMCG_ZSWAP_INCOMP stat
>=20
>=20By extracting a shared helper, both modules use the same logic, which=
 helps with maintainability.
>=20
>=20That said, I'm fine with dropping the helper if preferred. I can add =
a comment in memcontrol.c
> explaining the logic. My only concern is that if the incompressible det=
ection logic in zswap
> ever changes, someone might forget to update the memcg accounting accor=
dingly.
>=20
>=20But perhaps that's an unlikely scenario.

Well, a selftest would be the right way to detect such a problem imo. Eve=
n if we need to have a customer definition for incompressible later, it s=
hould remain in zswap and we should pass it into memcg code.

For now, I think let's keep open-coding the PAGE_SIZE check.

