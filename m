Return-Path: <cgroups+bounces-984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033181A69E
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345AB1C22DBB
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9A481AC;
	Wed, 20 Dec 2023 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McLTJGE+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157E482C0;
	Wed, 20 Dec 2023 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7fdde8b56so68352539f.1;
        Wed, 20 Dec 2023 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703095269; x=1703700069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJzSEoEvuif1BDrUFvDqH2tIiQ4fF92h4jSTRbuCOLY=;
        b=McLTJGE+ItI6rlKoV6vOnN1Un5vqxwZEGotVNwruyLVspye9agmwHxPueIg09rK5z5
         Gc6dcV3vZy+wWZ2TRaTroLxiapbwqmKSO6GTAm4/zokm7CbQruu/uPhX41DDp1BXxuiW
         VcpgtnjZTSOMABQ60d1owN9ll57QLp2sHutcHPIjo63dh61KWsJpvYUd9MuHjARH5YPq
         t/hKz6VRZCznUCisAPAaOuftcKwwR2oAEDNL4yVjByujmD2NMS2qLA5TZz9bdM0MQtp8
         UMIOOtqfu6RkIEWjjFLgitgOQfHsBcbmqwwKh+uY9H2anADF0Rn0s1hPtvag1kpKhu95
         ME2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703095269; x=1703700069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJzSEoEvuif1BDrUFvDqH2tIiQ4fF92h4jSTRbuCOLY=;
        b=JqcSSJAutbZmlDHw2GM1px8t4L737fES1a4LDinFFM2Z3K+9uo3XeWnMMwpnCTut98
         k+8mkE1VCQlM9W5EQUBPesEiogDD7cGChV/06zCU1jHCddkqI2Y0nS15tfX9PApsumFE
         hMjWw64zXkQa6bl3IrNtcusFnwiOpIxlT7sr51GTF0A6/NiXMrtBFhj/qR90UZGhgemA
         p5azigbhRt+OW6OX4RguDaO6EM+7skUFg3oU7qeKmwuEwLEdI7VriR+xJR7mWYmzX2l/
         nwihjNlOgTTAmD4jxlezOLxO7dvDlDj5vFoX5OiH7rG/7HLo8q1/zYnFNCQjnbKmDy9D
         UlFQ==
X-Gm-Message-State: AOJu0YwSh35WTsg3Z6PohRfMnLnvj1yWQawspzLcPD3FJHWg7h0wjF5h
	PinNcnmxXApcWqcduV37l05RSlBP6e5wwLEvaj0=
X-Google-Smtp-Source: AGHT+IFyV8d2RNp2PDX4fUdZmr5runKhc8tqWt5xHA/RVVcp4rAfS4is9TW8I+KHHVVp9KONswzhGSHykb5YQalhmzs=
X-Received: by 2002:a05:6602:2c53:b0:7b3:9356:665 with SMTP id
 x19-20020a0566022c5300b007b393560665mr27215712iov.4.1703095268836; Wed, 20
 Dec 2023 10:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61273e5e9b490682388377c20f52d19de4a80460.1703054559.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <61273e5e9b490682388377c20f52d19de4a80460.1703054559.git.baolin.wang@linux.alibaba.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Dec 2023 10:00:57 -0800
Message-ID: <CAKEwX=N9zXX9GZWT9v_wuJB0Sbj27U6qeV6iz+CrJ362j_mY7Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix split queue list crash when large folio migration
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	david@redhat.com, ying.huang@intel.com, shy828301@gmail.com, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:52=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> When running autonuma with enabling multi-size THP, I encountered the fol=
lowing
> kernel crash issue:
>
> [  134.290216] list_del corruption. prev->next should be fffff9ad42e1c490=
,
> but was dead000000000100. (prev=3Dfffff9ad42399890)
> [  134.290877] kernel BUG at lib/list_debug.c:62!
> [  134.291052] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  134.291210] CPU: 56 PID: 8037 Comm: numa01 Kdump: loaded Tainted:
> G            E      6.7.0-rc4+ #20
> [  134.291649] RIP: 0010:__list_del_entry_valid_or_report+0x97/0xb0
> ......
> [  134.294252] Call Trace:
> [  134.294362]  <TASK>
> [  134.294440]  ? die+0x33/0x90
> [  134.294561]  ? do_trap+0xe0/0x110
> ......
> [  134.295681]  ? __list_del_entry_valid_or_report+0x97/0xb0
> [  134.295842]  folio_undo_large_rmappable+0x99/0x100
> [  134.296003]  destroy_large_folio+0x68/0x70
> [  134.296172]  migrate_folio_move+0x12e/0x260
> [  134.296264]  ? __pfx_remove_migration_pte+0x10/0x10
> [  134.296389]  migrate_pages_batch+0x495/0x6b0
> [  134.296523]  migrate_pages+0x1d0/0x500
> [  134.296646]  ? __pfx_alloc_misplaced_dst_folio+0x10/0x10
> [  134.296799]  migrate_misplaced_folio+0x12d/0x2b0
> [  134.296953]  do_numa_page+0x1f4/0x570
> [  134.297121]  __handle_mm_fault+0x2b0/0x6c0
> [  134.297254]  handle_mm_fault+0x107/0x270
> [  134.300897]  do_user_addr_fault+0x167/0x680
> [  134.304561]  exc_page_fault+0x65/0x140
> [  134.307919]  asm_exc_page_fault+0x22/0x30
>
> The reason for the crash is that, the commit 85ce2c517ade ("memcontrol: o=
nly
> transfer the memcg data for migration") removed the charging and unchargi=
ng
> operations of the migration folios and cleared the memcg data of the old =
folio.
>
> During the subsequent release process of the old large folio in destroy_l=
arge_folio(),
> if the large folio needs to be removed from the split queue, an incorrect=
 split
> queue can be obtained (which is pgdat->deferred_split_queue) because the =
old
> folio's memcg is NULL now. This can lead to list operations being perform=
ed
> under the wrong split queue lock protection, resulting in a list crash as=
 above.

Ah this is tricky. I think you're right - the old folio's memcg is
used to get the deferred split queue, and we cleared it here :)

>
> After the migration, the old folio is going to be freed, so we can remove=
 it
> from the split queue in mem_cgroup_migrate() a bit earlier before clearin=
g the
> memcg data to avoid getting incorrect split queue.
>
> Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migrat=
ion")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/huge_memory.c |  2 +-
>  mm/memcontrol.c  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6be1a380a298..c50dc2e1483f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3124,7 +3124,7 @@ void folio_undo_large_rmappable(struct folio *folio=
)
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (!list_empty(&folio->_deferred_list)) {
>                 ds_queue->split_queue_len--;
> -               list_del(&folio->_deferred_list);
> +               list_del_init(&folio->_deferred_list);
>         }
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae8c62c7aa53..e66e0811cccc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7575,6 +7575,17 @@ void mem_cgroup_migrate(struct folio *old, struct =
folio *new)
>
>         /* Transfer the charge and the css ref */
>         commit_charge(new, memcg);
> +       /*
> +        * If the old folio a large folio and is in the split queue, it n=
eeds
> +        * to be removed from the split queue now, in case getting an inc=
orrect
> +        * split queue in destroy_large_folio() after the memcg of the ol=
d folio
> +        * is cleared.
> +        *
> +        * In addition, the old folio is about to be freed after migratio=
n, so
> +        * removing from the split queue a bit earlier seems reasonable.
> +        */
> +       if (folio_test_large(old) && folio_test_large_rmappable(old))
> +               folio_undo_large_rmappable(old);

This looks reasonable to me :)
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

>         old->memcg_data =3D 0;
>  }
>
> --
> 2.39.3
>

