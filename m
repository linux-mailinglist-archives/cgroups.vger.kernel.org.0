Return-Path: <cgroups+bounces-17600-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Du0/HFNuT2pjggIAu9opvQ
	(envelope-from <cgroups+bounces-17600-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:48:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E272F1DB
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:48:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AjVxzibm;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17600-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17600-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A6FA30078AB
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D303E5ED7;
	Thu,  9 Jul 2026 09:48:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C183FE66F;
	Thu,  9 Jul 2026 09:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590479; cv=none; b=kzwKQD3qDH39wuwdx7EbjX8gg3pB2XDEfzHGBX43/tzbyE/crvWKF4FVCNWBP7XXhXS79YgUjlEKPYAfWmAwAQlekvwhg/Q8lxg+4C5itzb4/HzlXJWbBhvTCUEnXAOiDsGRTvNU5PYjuCxySRm844qVayVQf0f2yJn+4rQhwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590479; c=relaxed/simple;
	bh=SSuJLx9SE57A7qIxtS+wkjg1DUj+y6sjOCSXMaWQQak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peMla/atiKBRcKw8gM8VOU5Eh7xgmnvcntafQ+C134aXrorcIYi1Qe6aOKHvYFRNfyd1/8Sau2+ZnOqSTZLeYjXVC7gff84Tev2dosYBBgxYzKiNxL14zqJWi0NdY5QzVlPVTiKNN8g9MV9+peKmxA0OW6D+1XCRh1bsq91JbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjVxzibm; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783590475; x=1815126475;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SSuJLx9SE57A7qIxtS+wkjg1DUj+y6sjOCSXMaWQQak=;
  b=AjVxzibmyO214EGZ4e7wsWTmGI0V9C0XpRPvHLzBCJ+N3ET1xmcZUqLq
   QMxK+rNDOKnqt6Z5VqAHo1bXEL4asZt0NZ54psLNrMKWr2AHTQJiOg571
   AKm3u+mkiAuVF1Mp6bqRCs0yBi5K/NcAkvKurEAQX/Klys9eu1iqoo/8O
   WDuhgHalTKm64LqYte2tkfsMtIW3ETlRf1LXab++Tp/kkiJwQn/hN/RtS
   okLdv7tV71f2cFxAcWrwJHenFx+lwAJL67C+BGjk9uk8SvKs4tVo5S3yU
   oCyDZaSugK3yPx4KjPvLEvkH5AcZUYT1aLEdgxXcGw7navMhDoRhogLKK
   w==;
X-CSE-ConnectionGUID: c1fheDprQeOYeLxTuwV7Og==
X-CSE-MsgGUID: 7ufVOjO2TbGgD6QX7BL7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84380019"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84380019"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:47:48 -0700
X-CSE-ConnectionGUID: 4ygGpAhyTYeln8kGMGST4g==
X-CSE-MsgGUID: th6FiBwhSfakI1Bu3JJT6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258142936"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.44]) ([10.245.244.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:47:41 -0700
Message-ID: <265737ad21d42a7509a8c43619975f0ef150f275.camel@linux.intel.com>
Subject: Re: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jing Wu <realwujing@gmail.com>, matthew.brost@intel.com
Cc: christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 	airlied@gmail.com, simona@ffwll.ch, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, natalie.vock@gmx.de, mhocko@kernel.org,
 roman.gushchin@linux.dev, 	shakeel.butt@linux.dev, muchun.song@linux.dev,
 intel-xe@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	cgroups@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 09 Jul 2026 11:47:38 +0200
In-Reply-To: <20260709061114.1623774-1-realwujing@gmail.com>
References: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
	 <20260709061114.1623774-1-realwujing@gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17600-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:matthew.brost@intel.com,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:natalie.vock@gmx.de,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de,linux.dev,lists.freedesktop.org,vger.kernel.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1E272F1DB

On Thu, 2026-07-09 at 14:11 +0800, Jing Wu wrote:
> On Wed, Jul 09, 2026 at 12:44:37AM -0700, Matthew Brost wrote:
> > This looks quite similar to work Thomas is doing here [1].
>=20
> Thank you for the pointer, Matt.=C2=A0 We were not aware of Thomas's
> series
> before your mail.=C2=A0 After reviewing Thomas's v7 [1], the two series
> turn
> out to address different =E2=80=94 and complementary =E2=80=94 problems:
>=20
> =C2=A0 - Thomas's series hooks a reclaim callback into the dmem.max write
> =C2=A0=C2=A0=C2=A0 path: when an administrator lowers dmem.max below curr=
ent usage,
> the
> =C2=A0=C2=A0=C2=A0 kernel calls the driver's reclaim callback to bring de=
vice memory
> =C2=A0=C2=A0=C2=A0 usage down to the new limit.=C2=A0 This is analogous t=
o what happens
> in
> =C2=A0=C2=A0=C2=A0 memcg when memory.max is written below current usage.
>=20
> =C2=A0 - Our series adds dmem.high as a soft limit enforced in the charge
> =C2=A0=C2=A0=C2=A0 path: when a successful allocation pushes a cgroup's u=
sage above
> =C2=A0=C2=A0=C2=A0 dmem.high, TTM proactively evicts one BO from that cgr=
oup before
> =C2=A0=C2=A0=C2=A0 returning.=C2=A0 This mirrors memory.high semantics in=
 memcg, where
> =C2=A0=C2=A0=C2=A0 reclaim is triggered per-allocation to keep usage belo=
w the soft
> =C2=A0=C2=A0=C2=A0 threshold.
>=20
> Both mechanisms coexist independently in memcg and serve distinct
> purposes: the max write path handles capacity reconfiguration by
> operators, while the high-limit path provides automatic backpressure
> for workloads approaching their quota.=C2=A0 Having both in the dmem
> cgroup
> controller seems correct.
>=20
> > Are either of you two aware of this seemly overlapping work?
>=20
> We were not, until your mail.=C2=A0 Now that we are, we would like to
> coordinate with Thomas on a few interaction points:
>=20
> =C2=A0 1. API intersection: Thomas's v5+ replaces the bare u64 size
> argument
> =C2=A0=C2=A0=C2=A0=C2=A0 in dmem_cgroup_register_region() with struct dme=
m_cgroup_init
> (which
> =C2=A0=C2=A0=C2=A0=C2=A0 bundles the region size, reclaim ops, and driver=
 private data).=C2=A0
> If
> =C2=A0=C2=A0=C2=A0=C2=A0 Thomas's series lands first, we will adapt our p=
atches to the
> new
> =C2=A0=C2=A0=C2=A0=C2=A0 registration interface.
>=20
> =C2=A0 2. File-level conflicts: both series modify ttm_resource.c and
> =C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo.c.=C2=A0 The changes are semantically ind=
ependent and should
> =C2=A0=C2=A0=C2=A0=C2=A0 compose cleanly after a rebase, whichever lands =
second.
>=20
> Thomas, would you be open to coordinating on merge ordering?=C2=A0 We are
> happy to rebase our dmem.high series on top of yours once it lands,
> or
> to split out any shared infrastructure as a common prerequisite if
> that
> helps.

Sure. Let's notify eachother of imminent merge plans. I will rebase my
series on yours if yours go in first. If needed let's look at a topic
branch that we can merge into drm or vice versa.

My work is stalled on lack of reviews ATM.

Thanks,
Thomas

>=20
> Thanks,
> Jing Wu

