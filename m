Return-Path: <cgroups+bounces-15630-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB/XDXlt+mm2OwMAu9opvQ
	(envelope-from <cgroups+bounces-15630-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 00:21:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F34D4448
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 00:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE83304704D
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1DB48AE0E;
	Tue,  5 May 2026 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhDzHdpI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89967223DEA
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019700; cv=none; b=slumtT4NH2J5x8IkJppvGlr4lrqGadCOIVzs92dunG0CLSN8Z/MEE3upL9rpbl9htMv5qfZv2ozpDCzGOsDaeRi2Txpu0ktjWnD7Vl46J6RZTS4XVxLGmYRD3EK2HVeSc86nx6u0/Qctyuw3kv6+V6foDEwmP97kH2LpVY21Fb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019700; c=relaxed/simple;
	bh=zOuCto/ei+q5X9zizDWicsGgHsnCs3KdS/blOqZ3EtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XTf9HI5lpdHewUdnNVE1SD3yBNO3nw4X8F1TqnXnZ2RW48KtEQiI/JMgpYmY2a+mTbgmPOJpAYuvABCnxkq64OskzGjHBkU8M7StIHgzvA/P2uFJ5eG0fUsxKf2wyJshF/yAejC/dTEScFCIjCPs035EWE7pxX0ka4FoxFFNxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhDzHdpI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a01c80c34so56954001fa.0
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778019697; x=1778624497; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+bTaNE0dwTN+qN6h1nZ07Pw7t4BRJtO96DbmMB+uZo=;
        b=dhDzHdpIngACreNbzmbm8RCTIW8zTkMR7G79zhBScFUHXStxwQkbuMfibjp3A5hkb7
         VY3gq/jXXPJX0ubyimF6ucvb5UKE0NmZTkVcfeHg7Usbq443o+75yUrmA72uYV1vcKn/
         6M7/X+8D9m073BIkO9sFGATy1oHktJ7AjRuzhsZW/tvtgO8k4lASmElJVpysbsjfqKs7
         si/GDUhTLmuikvwccp96TYSor5G70rqgIh0BiAhHF07mIccyEH8ZNL2Aby29hqk4dvzd
         uLMd33ZifyA0qp8QnR4lNnjg8P6fuLaFXpehFwqydeJB0wVfz4TI/p3pOPOBY/jWzqTo
         ii1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778019697; x=1778624497;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+bTaNE0dwTN+qN6h1nZ07Pw7t4BRJtO96DbmMB+uZo=;
        b=Pk7tgvX9xkaPrVHIHj10/ycP8BvzoMELbHuJ3uczvtp+wmv6KAvNhjpRLsx3VlNhR1
         NwY8uhu31HVQE8cea5zcmI1wEB5HqTi9ef2Jgqj7rzval5NCLIviFkp6KJNSmTirPmdQ
         iD16f01PAmzKf0k4FGK1V99SnqzgCA/NuvfhfzYhLzyuDx3orUqIbilEDBLZ2YXkz+b/
         zvGrL8XIOevDHpExdVNgqOg55T/HGsjgvq+z0nJW96jVFe7imT9LFMLHY4ARrDSQIETB
         469zzd709M7MR6GKlCeG5M8PpHcH8o3zZM5PorEFw5lYubhdSPABnSEOmWqOWjbstoJc
         wN5g==
X-Forwarded-Encrypted: i=1; AFNElJ/x7Qu5Rs+GjtEJxGlHpMt8h8E+tYF5yrfCza1v84G1rsD7z6xNy4JfSPSpyRiVqAkChHgtGOC7@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4OKBkLcYHUJPK7eXq9GOV/fYj7qegEBhHj3hILgnaPNzf+7z
	VhpXPL0Xn/ya4R2hoz1AlqFCj9v8mIK1Ag/vBkNn1Jj6KtZrVGV7h6Zw
X-Gm-Gg: AeBDiesZayG8dx/50EiI5VznzUIptcIcAJ2vNfjKp1G5EAiiwxFh3Q75gbFh5oyq/0z
	v8jUYDL1+FWOjhc7RVWiz9CU5k+/NJCXdc9OAuRaJA0TsSCR1hGALxGYF+eNSmVsT8isl5hgSup
	wvX4XL8r5r+ejkkOs5roaEInJ0x7CYAyW155HPXy5oP3e6Hxlkj1C0LUPhz6u3mhNwQp6s7hRsz
	R/2zCE2rGRITtbw3LgZfKoUDGDCekAKIIoFobt67JxgLPqSgBxRBu/dEsjgpzgyK4RgpGToNzHY
	YkF4oaJcWnb/3TIGqDv4e1rTU9v8ZSK1QBVp1HnkCokC8oYBTGFwa5yAPtVwkwSkiFDMJBmwTpJ
	DGe4wyiPjLjkP9VHZ8w0Jac9Nx6xD6NU+0M44sPmVLVfrR6aySFB1RoM4nw5sEaN7jOPGEZG9zU
	olIHpQGFG6dwzh+z+10ey4DAVQn/zPi/kc/2BXzc3iJ9HvISrm6J4rSe6RtECVHCF3BnLqBF9NM
	f4z1gbR2Sv3EFftUNzeXp5FBRyKtadez4y3Gp9E
X-Received: by 2002:a05:651c:4210:b0:393:8b23:a194 with SMTP id 38308e7fff4ca-393c41cedeemr3503181fa.19.1778019696437;
        Tue, 05 May 2026 15:21:36 -0700 (PDT)
Received: from smtpclient.apple (h-155-4-132-115.NA.cust.bahnhof.se. [155.4.132.115])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3936108fb80sm46308161fa.6.2026.05.05.15.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:21:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
Date: Wed, 6 May 2026 00:21:23 +0200
Cc: lsf-pc@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 damon@lists.linux.dev,
 kernel-team@meta.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 dakr@kernel.org,
 dave@stgolabs.net,
 jonathan.cameron@huawei.com,
 dave.jiang@intel.com,
 alison.schofield@intel.com,
 vishal.l.verma@intel.com,
 Ira Weiny <ira.weiny@intel.com>,
 dan.j.williams@intel.com,
 longman@redhat.com,
 akpm@linux-foundation.org,
 david@kernel.org,
 lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com,
 vbabka@suse.cz,
 rppt@kernel.org,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 osalvador@suse.de,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 ying.huang@linux.alibaba.com,
 apopple@nvidia.com,
 axelrasmussen@google.com,
 yuanchu@google.com,
 weixugc@google.com,
 yury.norov@gmail.com,
 linux@rasmusvillemoes.dk,
 mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 jackmanb@google.com,
 sj@kernel.org,
 baolin.wang@linux.alibaba.com,
 npache@redhat.com,
 ryan.roberts@arm.com,
 dev.jain@arm.com,
 baohua@kernel.org,
 lance.yang@linux.dev,
 muchun.song@linux.dev,
 xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev,
 jannh@google.com,
 linmiaohe@huawei.com,
 nao.horiguchi@gmail.com,
 pfalcato@suse.de,
 David Rientjes <rientjes@google.com>,
 shakeel.butt@linux.dev,
 riel@surriel.com,
 harry.yoo@oracle.com,
 cl@gentwo.org,
 roman.gushchin@linux.dev,
 chrisl@kernel.org,
 kasong@tencent.com,
 shikemeng@huaweicloud.com,
 nphamcs@gmail.com,
 bhe@redhat.com,
 zhengqi.arch@bytedance.com,
 terry.bowman@amd.com,
 Yiannis Nikolakopoulos <Yiannis@zptcorp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21B8D62E-38AB-4FA5-8942-DA4417A7E7E9@gmail.com>
References: <20260222084842.1824063-1-gourry@gourry.net>
To: Gregory Price <gourry@gourry.net>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Queue-Id: 8A6F34D4448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,zptcorp.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15630-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[75];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yiannisnikolakop@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email]


> On 22 Feb 2026, at 09:48, Gregory Price <gourry@gourry.net> wrote:
>=20
> Topic type: MM
>=20
> Presenter: Gregory Price <gourry@gourry.net>
>=20
> This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> managed by the buddy allocator but excluded from normal allocations.
>=20
> I present it with an end-to-end Compressed RAM service (mm/cram.c)
> that would otherwise not be possible (or would be considerably more
> difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
>=20
>=20
> TL;DR
> =3D=3D=3D
>=20
> N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> explicit holes in that isolation to do useful things we couldn't do
> before without re-implementing entire portions of mm/ in a driver.
>=20
>=20
> /* This is my memory. There are many like it, but this one is mine. */
> rc =3D add_private_memory_driver_managed(nid, start, size, name, =
flags,
>                                       online_type, private_context);
>=20
> page =3D alloc_pages_node(nid, __GFP_PRIVATE, 0);
>=20
> /* Ok but I want to do something useful with it */
> static const struct node_private_ops ops =3D {
>        .migrate_to     =3D my_migrate_to,
>        .folio_migrate  =3D my_folio_migrate,
>        .flags =3D NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> };
> node_private_set_ops(nid, &ops);
>=20
> /* And now I can use mempolicy with my memory */
> buf =3D mmap(...);
> mbind(buf, len, mode, private_node, ...);
> buf[0] =3D 0xdeadbeef;  /* Faults onto private node */
>=20
> /* And to be clear, no one else gets my memory */
> buf2 =3D malloc(4096);  /* Standard allocation */
> buf2[0] =3D 0xdeadbeef; /* Can never land on private node */
>=20
> /* But i can choose to migrate it to the private node */
> move_pages(0, 1, &buf, &private_node, NULL, ...);
>=20
> /* And more fun things like this */
>=20
>=20
> Patchwork
> =3D=3D=3D
> A fully working branch based on cxl/next can be found here:
> https://github.com/gourryinverse/linux/tree/private_compression
>=20
> A QEMU device which can inject high/low interrupts can be found here:
> https://github.com/gourryinverse/qemu/tree/compressed_cxl_clean
>=20
> The additional patches on these branches are CXL and DAX driver
> housecleaning only tangentially relevant to this RFC, so i've
> omitted them for the sake of trying to keep it somewhat clean
> here.  Those patches should (hopefully) be going upstream anyway.
>=20
> Patches 1-22: Core Private Node Infrastructure
>=20
>  Patch  1:      Introduce N_MEMORY_PRIVATE scaffolding
>  Patch  2:      Introduce __GFP_PRIVATE
>  Patch  3:      Apply allocation isolation mechanisms
>  Patch  4:      Add N_MEMORY nodes to private fallback lists
>  Patches 5-9:   Filter operations not yet supported
>  Patch 10:      free_folio callback
>  Patch 11:      split_folio callback
>  Patches 12-20: mm/ service opt-ins:
>                   Migration, Mempolicy, Demotion, Write Protect,
>                   Reclaim, OOM, NUMA Balancing, Compaction,
>                   LongTerm Pinning
>  Patch 21:      memory_failure callback
>  Patch 22:      Memory hotplug plumbing for private nodes
>=20
> Patch 23: mm/cram -- Compressed RAM Management
>=20
> Patches 24-27: CXL Driver examples
>  Sysram Regions with Private node support
>  Basic Driver Example: (MIGRATION | MEMPOLICY)
>  Compression Driver Example (Generic)
>=20
Hi,

As I think this is about to be discussed in the conference, I thought
to share some high level comments.

I have tested this for some time on a device with compression (after =
some
necessary fixes for CXL RCD to work, that Greg helped me with).

Overall, the isolation property that this provides is something I deem =
necessary
for this technology. Others are better placed to judge the MM plumbing
itself, but I wanted to say that this functionality is an important =
piece of the puzzle
from the device/use-case side.

For cram itself, as it is in this RFC, I think there is still =
performance and
value left on the table (as noted in the description), but I fully =
understand Gregory=E2=80=99s=20
premise in approaching it this way.

<snip>
>=20
> Future CRAM : Loosening the read-only constraint
> =3D=3D=3D
>=20
> The read-only model is safe but conservative.  For workloads where
> compressed pages are occasionally written, the promotion fault adds
> latency.  A future optimization could allow a tunable fraction of
> compressed pages to be mapped writable, accepting some risk of
> write-driven decompression in exchange for lower overhead.
>=20
> The private node ops make this straightforward:
>=20
>  - Adjust fixup_migration_pte to selectively skip
>    write-protection.
>  - Use the backpressure system to either revoke writable mappings,
>    deny additional demotions, or evict when device pressure rises.
I have some quick hacks playing with these ideas but I haven=E2=80=99t =
had the time
to test it thoroughly and get to something robust yet. I saw in another =
thread
that there is a follow up cooking which looks interesting.

Thanks Greg for pushing this, and I=E2=80=99m happy to test more on HW =
in our lab.

Best,
/Yiannis




