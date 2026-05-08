Return-Path: <cgroups+bounces-15674-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGLlMylg/WkkcQAAu9opvQ
	(envelope-from <cgroups+bounces-15674-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 06:01:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C314F157C
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 06:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FDC23005A91
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6542DB788;
	Fri,  8 May 2026 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNE+jU+4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCC1DD0D4
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212901; cv=none; b=jnqQL1a1Dog8512H5Cl2GaCd8oYcIonBJY5uYg7CBZMFzU41cS/UM72L7w/p5s/dIqECBtbCemWb3QM/ydsBwZJB51p0S8mfDjgmveu12s0JeQNX7FICVIQ/9osxXasu8MkCzX4MtnrBrEFZ0N1giD8cUui1HlhuGLDNGsXNSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212901; c=relaxed/simple;
	bh=bFtvUB3+z2oLu1yX9g4cDCufT+/WzAyRWXWCk2y77O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8adQU63BYIdECL4qPW6VSZDDDaOBM6xKTCeaZG/uGJQN68D2QmWsyf0WyW0Z3nEMFxvPEPnW2WWaAV4yqNtZgeQMntvyiqBNTxZSYnxcET131fdd9fMKL6t1OjIel7ZefwBHJL66HBmDzCy8SBW15ZmB+F+/Ar7rVa2Nqk3YsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNE+jU+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771F9C2BCC9
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778212900;
	bh=bFtvUB3+z2oLu1yX9g4cDCufT+/WzAyRWXWCk2y77O4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HNE+jU+4f7ZjUHuzs/LtFn+kz9B6ZexM0fMeVnArOOBkJ7r4M3ez98EbtQPEcy1vS
	 dGN9RBYVGCnq1o44btwZNk+3VMJBfGNUgmELC4nvJkxj3k7uXbPs4PH8onuLZ94wli
	 DnPd/VJupyTrAKWxUJgdkpJGqJAC0SLapSD77KcAE/ntDlZH8WjExQY3GPtN8DUZyL
	 NiKu3WknUWIUKyn8g06N1l3KcxKci1lkEQ2cZrg2TfniKKqn4A4JNSGByOfBAem+Us
	 im2rkdb/eaHJhRPOWAJi4Vt7ay5xvUgizuQeww4k0RzQ816tAOjYVhBbZ/3j3PvUnH
	 Z30EczN0L911A==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c5361142fso1695731d50.0
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 21:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+uR6HD20iAG1JvJsiwAHJzuxik3zX5tFKWPGux07Wh71gsYlrpHd8f4GYQAo0YtMdXjGl7YyfS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27b3ywCcHMbf9QjRlL0kx/W0MOg2YXHVM1/qVGPMfDy1tPb/9
	yo7v+AcR5k4kk1Kv5tHd/NJRCUFry+5773AR08Mqkd0LIu6PVzowRGV6rSc5y+L8kmHbxppPYRv
	n5qQBTNtADAfUdWYh5KNCP6zngk6nafCyjymkwzxubQ==
X-Received: by 2002:a53:cf08:0:b0:651:c782:6a8 with SMTP id
 956f58d0204a3-65c798f12abmr8129362d50.15.1778212899788; Thu, 07 May 2026
 21:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-7-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-7-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 8 May 2026 06:01:27 +0200
X-Gmail-Original-Message-ID: <CACePvbVnDrR6e7wvpF-nf1CWgoMdX4MTf7RSv2bCr28W6d8b2A@mail.gmail.com>
X-Gm-Features: AVHnY4K3mMy-e35GzbuzGDUDWwNv7K0aRs6FbOSf6WoJUyBYy6_6WeUzQb6RfJ4
Message-ID: <CACePvbVnDrR6e7wvpF-nf1CWgoMdX4MTf7RSv2bCr28W6d8b2A@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] mm, swap: support flexible batch freeing of
 slots in different memcgs
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 89C314F157C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15674-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 7:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Instead of requiring the caller to ensure all slots are in the same
> memcg, make the function handle different memcgs at once.
>
> This is both a micro optimization and required for removing the memcg
> lookup in the page table layer, so it can be unified at the swap layer.
>
> We are not removing the memcg lookup in the page table in this commit.
> It has to be done after the memcg lookup is deferred to the swap layer.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Overall, it looks good. Some nitpicks follow.

Acked-by: Chris Li <chrisl@kernel.org>

> ---
>  mm/swapfile.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e1ad77a69e54..8d3d22c463f3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1872,21 +1872,46 @@ void __swap_cluster_free_entries(struct swap_info=
_struct *si,
>                                  unsigned int ci_start, unsigned int nr_p=
ages)
>  {
>         unsigned long old_tb;
> +       unsigned int type =3D si->type;
> +       unsigned short id =3D 0, id_cur;

Nitpick: I'm tempted to rename a few variables to improve my
understanding. Feel free to keep it as it is.

id -> batch_id

>         unsigned int ci_off =3D ci_start, ci_end =3D ci_start + nr_pages;
> -       unsigned long offset =3D cluster_offset(si, ci) + ci_start;
> +       unsigned long offset =3D cluster_offset(si, ci);

Nitpick: offset -> ci_offset. This is the fixed offset of the ci which
is a fixed in the loop.

> +       unsigned int ci_batch =3D ci_off;

Nitpick: ci_batch -> batch_off, this one go with the batch_id.

> +       swp_entry_t entry;
>
>         VM_WARN_ON(ci->count < nr_pages);
>
>         ci->count -=3D nr_pages;
>         do {
>                 old_tb =3D __swap_table_get(ci, ci_off);
> -               /* Release the last ref, or after swap cache is dropped *=
/
> +               /*
> +                * Freeing is done after release of the last swap count
> +                * ref, or after swap cache is dropped
> +                */
>                 VM_WARN_ON(!swp_tb_is_shadow(old_tb) || __swp_tb_get_coun=
t(old_tb) > 1);
>                 __swap_table_set(ci, ci_off, null_to_swp_tb());
> +
> +               /*
> +                * Uncharge swap slots by memcg in batches. Consecutive
> +                * slots with the same cgroup id are uncharged together.
> +                */
> +               entry =3D swp_entry(type, offset + ci_off);

Nitpick: This line confused me a bit. Two offsets are mentioned here:
"offset + ci_offset". One would assume that ci_offset is the offset of
the ci, and the offset is the incremental one. It is the other way
around.

> +               id_cur =3D lookup_swap_cgroup_id(entry);
> +               if (id !=3D id_cur) {
> +                       if (id)
> +                               mem_cgroup_uncharge_swap(swp_entry(type, =
offset + ci_batch),
> +                                                        ci_off - ci_batc=
h);

With the above rename, this become:
"... swp_entry(type, ci_offset + batch_off)," ; This combined the
offset turn into the swap entry.
"ci_off - batch_off". That is the running length from the beginning of batc=
h.

> +                       id =3D id_cur;
> +                       ci_batch =3D ci_off;
> +               }
>         } while (++ci_off < ci_end);
>
> -       mem_cgroup_uncharge_swap(swp_entry(si->type, offset), nr_pages);
> -       swap_range_free(si, offset, nr_pages);
> +       if (id) {

This becomes `if (batch_id)`, meaning if we have pending batching, we
flush the current batch.

Chris

