Return-Path: <cgroups+bounces-15536-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB0CHkWb8GmGVwEAu9opvQ
	(envelope-from <cgroups+bounces-15536-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 13:34:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D76483D82
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A382D3038CE1
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BE63FCB23;
	Tue, 28 Apr 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ouFfKrgt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E083FBEC5
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375250; cv=none; b=gnOsjoYYhUo2QIoRGAHgsYvDdgy/Z773sxyH1CRgS9DA3Mwuoi+5JebVGjoLxIbGtiEk+2/jsByNbwHZ2bOQb5k54kFeBaGPhQiREh+ZRHXXB6pOSIDkxb90NMoAgEEbw/iBOD1ywDIUANggTsHwy6D87YfNdvrqmvWrpKkK4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375250; c=relaxed/simple;
	bh=353j0C2lYD1WIG79bf3Cw3KHgKsdbAQBBwuyhawQXhE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XorsrJYuFtRoWAv0u1GO5Hwm55nYIYDGOgVlWL3fiWnS7VPSbkQYH1yQIeqU+H+Sc2r2JhOdnyQ+a3HL4V47LdghOBRzswX2fuicK3/RLxUNoezJW1YEg57/co1KPlkQRDJPdyB+Y1Gq0KqY8OL8wcyHFODso1oMvFQ70JBv/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ouFfKrgt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777375236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZRrlNftEWSaYkPlYuyXhwwlyx7ubbXUhvki06OMnS0=;
	b=ouFfKrgt/mJqUG5kM3lCytRYJiFU1dwYzJobXtg/Bm5vhjQnLD8Gq0EKE4L1LJ0bOgU+u6
	O37+6087Dyg8tyYOC+FHSwuGIrtG9YbBCGuvp0KgLCkdsVlmAuhWovFj4T9CADc4y+eOy0
	v+frVy954rFZDXsCOy7HwrWa7R87LSU=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] mm: memcontrol: fix rcu unbalance in
 get_non_dying_memcg_end()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260428103108.45719-1-qi.zheng@linux.dev>
Date: Tue, 28 Apr 2026 19:19:55 +0800
Cc: akpm@linux-foundation.org,
 hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 yosry@kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <794DD00D-D6A1-469D-89D9-66FA972D0661@linux.dev>
References: <20260428103108.45719-1-qi.zheng@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 19D76483D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15536-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]



> On Apr 28, 2026, at 18:31, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> Currently, get_non_dying_memcg_start() and get_non_dying_memcg_end() =
both
> evaluate cgroup_subsys_on_dfl(memory_cgrp_subsys) independently to
> determine whether to acquire or release the RCU read lock.
>=20
> However, the result of cgroup_subsys_on_dfl() can change dynamically =
at
> runtime due to cgroup hierarchy rebinding (e.g., when the memory
> controller is moved between cgroup v1 and v2 hierarchies). This can =
cause
> the following warning:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: bad unlock balance detected!
> 7.0.0-next-20260420+ #83 Tainted: G        W
> -------------------------------------
> memcg-repro/270 is trying to release lock (rcu_read_lock) at:
> [<ffffffff815f57f7>] rcu_read_unlock+0x17/0x60
> but there are no more locks to release!
>=20
> other info that might help us debug this:
> 1 lock held by memcg-repro/270:
>  #0: ffff888102fa2088 (vm_lock){++++}-{0:0}, at: =
do_user_addr_fault+0x285/0x880
>=20
> stack backtrace:
> CPU: 0 UID: 0 PID: 270 Comm: memcg-repro Tainted: G        W           =
7.0.0-next-20260420+ #
> Tainted: [W]=3DWARN
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 =
04/01/2014
> Call Trace:
>  <TASK>
>  ? rcu_read_unlock+0x17/0x60
>  dump_stack_lvl+0x77/0xb0
>  print_unlock_imbalance_bug+0xe0/0xf0
>  ? rcu_read_unlock+0x17/0x60
>  lock_release+0x21d/0x2a0
>  rcu_read_unlock+0x1c/0x60
>  do_pte_missing+0x233/0xb40
>  __handle_mm_fault+0x80e/0xcd0
>  handle_mm_fault+0x146/0x310
>  do_user_addr_fault+0x303/0x880
>  exc_page_fault+0x9b/0x270
>  asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x5590e4eb41ea
> Code: 61 cc 66 0f 6f e0 66 0f 61 c2 66 0f db cd 66 0f 69 e2 66 0f 6f =
d0 66 0f 69 d4 66 0f 61 0
> RSP: 002b:00007ffcad25f030 EFLAGS: 00010202
> RAX: 00005590e4eb8010 RBX: 00007ffcad260f7d RCX: 00007f73c474d44d
> RDX: 00005590e4eb80a0 RSI: 00005590e4eb503c RDI: 000000000000000f
> RBP: 00005590e4eb70a0 R08: 0000000000000000 R09: 00007f73c483a680
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffcad25f180 R14: 00005590e4eb6dd8 R15: 00007f73c4869020
>  </TASK>
> ------------[ cut here ]------------
>=20
> Fix this by explicitly tracking the RCU lock state, ensuring that
> rcu_read_unlock() in get_non_dying_memcg_end() is strictly paired with
> the lock acquisition, regardless of any runtime rebinding events.
>=20
> Fixes: 8285917d6f38 ("mm: memcontrol: prepare for reparenting =
non-hierarchical stats")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


