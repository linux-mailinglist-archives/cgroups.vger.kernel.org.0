Return-Path: <cgroups+bounces-7634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE7A93013
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 04:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C621B63A14
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A9267F4D;
	Fri, 18 Apr 2025 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sze9aXEi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839A267F52
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943950; cv=none; b=K5pBRgAUCWCoTHPm4GBWT2ByBfon82TrfvcfRk0ibk9//0a3AisN54XSTA6JWONU4EuwC+LpwoxE8WcnIvUDwjTZZ7UfZXa37zyqt6tbuBU/U37W6DLHbuJ2M1w9Bu5oCvpu0b3+ywTyL41DOSlaiA5GKwzc6JVwxIytoQZCWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943950; c=relaxed/simple;
	bh=qV1odNb6L0lGUDLMPzAp+dLpmFc6+O5QpFjH5I0hzos=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ERfsb6CIN5NSQb1IgtwFg0wm9LVdb2OusgzBL9WUNWVh+H0xZ5iA9tTUmCf1PYP6cai32xm56Q68/21BdClN7qfE/msAUZgIPPwPBW7IULunUfLdMIo3uHtlHI9qlJaMZYiW7EctvgqafQ5VG7G9dqsziiZm3LQQbCjEnNaTi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sze9aXEi; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744943935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3T5feFtMm9osiqs4YoVP8jsIW7MLQcBFz0h+GbzCeOU=;
	b=sze9aXEi7pXJRNYM0HR3oAbpsg50yYWuYiYEjWnQFJglSUh3bULKkNzrb6DIRlm1WdF8JT
	P3BA5uj0f0oiW0FLFQl5Qkq+0GSOa0MSLfF6D6gffcOl1bYRz4Sy3QWuP4MNmi/ZJPrP6t
	nW1+WXYjbeEqYSIKeFlEDUqE0jCkyxc=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RFC 02/28] mm: memcontrol: use folio_memcg_charged() to
 avoid potential rcu lock holding
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250417144835.GE780688@cmpxchg.org>
Date: Fri, 18 Apr 2025 10:38:10 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 yosry.ahmed@linux.dev,
 nphamcs@gmail.com,
 chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD857422-95FD-477D-809A-C7ED0780E188@linux.dev>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-3-songmuchun@bytedance.com>
 <20250417144835.GE780688@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 17, 2025, at 22:48, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Tue, Apr 15, 2025 at 10:45:06AM +0800, Muchun Song wrote:
>> If a folio isn't charged to the memory cgroup, holding an rcu read =
lock
>> is needless. Users only want to know its charge status, so use
>> folio_memcg_charged() here.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/memcontrol.c | 11 ++++-------
>> 1 file changed, 4 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 61488e45cab2..0fc76d50bc23 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -797,20 +797,17 @@ void __mod_lruvec_state(struct lruvec *lruvec, =
enum node_stat_item idx,
>> void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item =
idx,
>>      int val)
>> {
>> - 	struct mem_cgroup *memcg;
>> 	pg_data_t *pgdat =3D folio_pgdat(folio);
>> 	struct lruvec *lruvec;
>>=20
>> - 	rcu_read_lock();
>> - 	memcg =3D folio_memcg(folio);
>> - 	/* Untracked pages have no memcg, no lruvec. Update only the =
node */
>> - 	if (!memcg) {
>> - 		rcu_read_unlock();
>> + 	if (!folio_memcg_charged(folio)) {
>> + 		/* Untracked pages have no memcg, no lruvec. Update only =
the node */
>> 		__mod_node_page_state(pgdat, idx, val);
>> 		return;
>> 	}
>>=20
>> - 	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>> + 	rcu_read_lock();
>> + 	lruvec =3D mem_cgroup_lruvec(folio_memcg(folio), pgdat);
>> 	__mod_lruvec_state(lruvec, idx, val);
>> 	rcu_read_unlock();
>=20
> Hm, but untracked pages are the rare exception. It would seem better
> for that case to take the rcu_read_lock() unnecessarily, than it is to
> look up folio->memcg_data twice in the fast path?

Yep, you are right. I'll drop this next version. Thanks.

Muchun,
Thanks.




