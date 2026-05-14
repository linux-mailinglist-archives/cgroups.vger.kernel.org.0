Return-Path: <cgroups+bounces-15943-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APGfBcjQBWosbwIAu9opvQ
	(envelope-from <cgroups+bounces-15943-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 15:40:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 730595426DF
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F33983018750
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B193DF013;
	Thu, 14 May 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sMs6L8mI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F63CF69B
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766019; cv=none; b=c4qTtnapvYoXoQCBcWlLCPladKMBjKDCyZAAwSHuTpx/pdDaRDstclr7yuv3b7pITS4P/GTeaj/qerSxYQmWFGEIWRbpFr6IjALJ4XygDr8NQYUClkszgs5acghp9GB6UfncdkAwJDKxlF9YpjLc9JfTdN4ZAqbu0n47cMKt+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766019; c=relaxed/simple;
	bh=jzTGJQLw/9AavogGSZBetr2f2wX9PT5Dgc7Dd1s6C1g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Dhnsq9B1+xeiUDWIxYqRsCUBAKIoDkXcmgwVgB0cupqhmEcRDMh/cCLEHUR15xgNojZJFJaDFvaGO13z/TaXSEDN0UMP7eY3V/+2LQk79ltlQB2PyMFV22EJQOJ/FDXbOi4Uk7Q6rqkWdv/2Gu8sBoe8Dt7+LXMij0h0hHUdag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sMs6L8mI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778766013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcirupfxPBQzJs3shFv2nK9lIarxk5Jfe1IH9MumCF8=;
	b=sMs6L8mI85LFABgq1nI4z8nla660NI9Pa3FIENgPJdyoosQzy2I0JhilXHQ+C9fPDjifj4
	+4wwd1Zy6+4gcDY+F0BEI9an9TxoTa2GVLXik93wFBWJPxkypYnN72Ep+dYLs6Jq7SFtNg
	8gmsvhU21e+0KIOd58IKisLVJ8ACs6M=
Date: Thu, 14 May 2026 13:40:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shakeel Butt" <shakeel.butt@linux.dev>
Message-ID: <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
TLS-Required: No
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
To: "Qi Zheng" <qi.zheng@linux.dev>, "kernel test robot"
 <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Carlier"
 <devnexen@gmail.com>, "Allen Pais" <apais@linux.microsoft.com>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Baoquan He" <bhe@redhat.com>,
 "Chengming Zhou" <chengming.zhou@linux.dev>, "Chen Ridong"
 <chenridong@huawei.com>, "David Hildenbrand" <david@kernel.org>, "Hamza
 Mahfooz" <hamzamahfooz@linux.microsoft.com>, "Harry Yoo"
 <harry.yoo@oracle.com>, "Hugh Dickins" <hughd@google.com>, "Imran Khan"
 <imran.f.khan@oracle.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Kamalesh Babulal" <kamalesh.babulal@oracle.com>, "Lance Yang"
 <lance.yang@linux.dev>, "Liam Howlett" <Liam.Howlett@oracle.com>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>,
 "=?utf-8?B?TWljaGFsIEtvdXRuw70=?=" <mkoutny@suse.com>, "Mike Rapoport"
 <rppt@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Muchun Song"
 <songmuchun@bytedance.com>, "Nhat Pham" <nphamcs@gmail.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Suren Baghdasaryan"
 <surenb@google.com>, "Usama Arif" <usamaarif642@gmail.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Wei Xu" <weixugc@google.com>, "Yosry Ahmed"
 <yosry@kernel.org>, "Yuanchu Xie" <yuanchu@google.com>, "Zi Yan"
 <ziy@nvidia.com>, "Usama Arif" <usama.arif@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
References: <202605121641.b6a60cb0-lkp@intel.com>
 <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
 <agSAT4ldp3dzKWPl@linux.dev> <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 730595426DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15943-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,linux.dev,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

May 14, 2026 at 12:46 AM, "Qi Zheng" <qi.zheng@linux.dev mailto:qi.zheng@=
linux.dev?to=3D%22Qi%20Zheng%22%20%3Cqi.zheng%40linux.dev%3E > wrote:


>=20
>=20On 5/13/26 10:27 PM, Shakeel Butt wrote:
>=20
>=20>=20
>=20> On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
> >=20
>=20> >=20
>=20> > On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
> > >=20
>=20>  On 5/13/26 12:03 AM, Shakeel Butt wrote:
> >  On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
> >=20
>=20>  Hello,
> >=20
>=20>  kernel test robot noticed a 67.7% regression of stress-ng.switch.o=
ps_per_sec on:
> >=20
>=20>  commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol:=
 convert objcg to be per-memcg per-node type")
> >  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git mast=
er
> >=20
>=20>  This is most probably due to shuffling of struct mem_cgroup and st=
ruct
> >  mem_cgroup_per_node members.
> >=20
>=20>  Another possibility is that after objcg was split into per-node, t=
he
> >  slab accounting fast path is still designed assuming only one curren=
t
> >  objcg per CPU:
> >=20
>=20>  struct obj_stock_pcp {
> >  struct obj_cgroup *cached_objcg;
> >  };
> >=20
>=20>  So it's may cause the following thrashing:
> >=20
>=20>  CPU stock cached =3D memcg/node0 objcg
> >  free object tagged =3D memcg/node1 objcg
> >  =3D> __refill_obj_stock --> objcg mismatch
> >  =3D> drain_obj_stock()
> >  =3D> cache switches to node1 objcg
> >=20
>=20>  next local allocation tagged =3D node0 objcg
> >  =3D> mismatch again
> >  =3D> drain_obj_stock()
> >=20
>=20> >=20
>=20> > Actually I think this is the issue, we have ping pong threads run=
ning on
> > >  different nodes where though theu are in same cgroup but their cur=
rent->obcg is
> > >  for local node and thus this ping pong is thrashing the per-cpu ob=
jcg stock.
> > >=20
>=20> >  The easier fix would be to compare objcg->memcg instead of just =
objcg during
> > >  draining and caching. In addition we can add support for multiple =
objcg per-cpu
> > >  stock caching.
> > >=20
>=20>  Something like the following:
> >  From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 20=
01
> >  From: Shakeel Butt <shakeel.butt@linux.dev>
> >  Date: Wed, 13 May 2026 07:24:55 -0700
> >  Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled o=
bjcg
> >  shares memcg
> >  Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> >  ---
> >  mm/memcontrol.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >  diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >  index d978e18b9b2d..01ed7a8e18ac 100644
> >  --- a/mm/memcontrol.c
> >  +++ b/mm/memcontrol.c
> >  @@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgro=
up *objcg,
> >  unsigned int nr_bytes,
> >  bool allow_uncharge)
> >  {
> >  + struct obj_cgroup *cached;
> >  unsigned int nr_pages =3D 0;
> >  > if (!stock) {
> >  @@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgr=
oup *objcg,
> >  goto out;
> >  }
> >  > - if (READ_ONCE(stock->cached_objcg) !=3D objcg) { /* reset if nec=
essary */
> >  + cached =3D READ_ONCE(stock->cached_objcg);
> >  + if (cached !=3D objcg &&
> >  + (!cached || obj_cgroup_memcg(cached) !=3D obj_cgroup_memcg(objcg))=
) {
> >  drain_obj_stock(stock);
> >  obj_cgroup_get(objcg);
> >  stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
> >=20
>=20This change looks like it should be able to fix the ping-pong issue, =
but
> I stiil haven't reproduced the performance regression locally. I'll
> continue testing it.

Same here, couldn't reproduce locally. It seems like we had to craft a sc=
enario
where the pair pingpong threads get their current->objcg from different n=
odes.
I will try that.

>=20
>=20Hi kernel-test-robot, could you help check if the patch above fixes t=
he
> issue on your end?
>=20

In=20the meantime, Oliver, can you please help in testing this patch?

