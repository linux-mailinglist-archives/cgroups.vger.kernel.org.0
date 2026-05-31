Return-Path: <cgroups+bounces-16484-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKGyNDzrG2o0HQkAu9opvQ
	(envelope-from <cgroups+bounces-16484-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 10:03:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36532614F0D
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB41304F2D5
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90837F8DD;
	Sun, 31 May 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M62URrwO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8882E8DEC
	for <cgroups@vger.kernel.org>; Sun, 31 May 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780214458; cv=none; b=EJl9COOqjrTxen62bA1lFnNb52Ql4QMa6wobp3uSte8GaCA1mwplBnCgo1lgapHUDEO4L2OByhk075FtS2wJm65LyJiUKodIRwAWKF0UoTz3fRCPsEMxe00vXyo/qsdbz2+Hswzx4z8sdzT++nkIX7EvFRzw9BhwEKYMAuzTN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780214458; c=relaxed/simple;
	bh=8KofXbDEix4B09rNJ37FucbySAdSUpZMskyYwZA0EXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8+nQ9Z/WFwRtudcXu7PFG+c50Nd/fbRgt75gZjNGiLZT63vAwROTThxTrTfXHnTNbG4zuQVhaaiYH75MvsMbr19lx2PY0Z+TaSQjDoWBQEqVi3lr0IAbSZvnBCjCwTCgxPlnC+TOQKUTtocFHLcjMW04DqIt0c/QqGGVRFy9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M62URrwO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so50023466b.1
        for <cgroups@vger.kernel.org>; Sun, 31 May 2026 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780214455; x=1780819255; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwkGhwJc4adPpZ7Bnkh8nEE7m2fCygkfGd6/PO7C4fk=;
        b=M62URrwO52WbUkpBo948N4FdukJJW4BG1HSnISA32/1xJyOifipgqrgBq69IeiWTEY
         d83wJa8br+C1GY7lluO4tkYoJC/pw4ybe510DhJ1wVCNSk1DvQ8HylSS01zl0NTxCbh8
         g0BLE2yOWvfQGbsH84W9Q7P9snnO8xGoeyhlbrMm4S8Nm4xB5odYglWUa/Xwuf5+nRY6
         mo0zZd3uEZuHGWjdEb/K8A6sY9UVLAbRbpHJ9EMG9XIbeYrJAN/K0g5txAhcsJ5XRmPC
         WQNpBsbkcRoy9aL0SO/B3KnUsa+IskYSR+f3wh+NYne9VNNdIzqaDi5KqVu4ifq/JfEG
         g1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780214455; x=1780819255;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwkGhwJc4adPpZ7Bnkh8nEE7m2fCygkfGd6/PO7C4fk=;
        b=MkTLjUjlpPHb3I4bBFEWMNNHYYdbsW6RSS1XNDuJ8HEOr+uiurTHQETY+YHrsV8FqG
         2rwLk1DGtAkf0z/75MYqX/2ry/utyAUc5ggCRehqg1vE9W3Sh9tE9jdiqy55bQv+R9lv
         AFWc+pmuHiNkJYvwDhcInuP65Nmhf2ufe8Qj7LkKO6yq7HSz6pmaxAEdrp8RSXuS6hcJ
         3nkLGas9rpeBXXNds5+05uh6Yan7fWFMLN9UzDYdhC1v5mIglyRGb+3sP7B9/61yq1Ob
         LcuKBAA5yi1dBr+IJSYKySojqnu9tJ/Fkf26D/oZtNWfqC1CnbthI02lyhntuEHyWFPc
         I1YA==
X-Forwarded-Encrypted: i=1; AFNElJ+EtStWEhx8ezUA/HC9mpHvHSnu6H+cHqW6A7JjugOG+4/rJv3hBaPFnUpwxJ8Gu0t2EveWoXgg@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZgbxxNw4/u5Il+3kpCnVlMzmkSNcWGy4HDeOy0HnLhudwCz5
	iu/tTk2me6Cddx3KvXhINsi6m11V8z0xu3FndJErtfAc6LgAbkRzRNRV
X-Gm-Gg: Acq92OGhGb172wgjI5so7GPazckGkAjYIA8Xi75LgCGD0K3oum2OS2lCbceRV4ymGPK
	oVi1bLmrE53XdUdkn1SWd+6g1SPK0LmeH78Hmwi4kKtxeLmNJ01rHXvbqVVyZJCnwGdQ70mK16A
	Fj92+WVeIPgw62mVvtSrqc+AjkPHnlDIIU71roPbMpQQtg8ZZLlIvgz5NcfDy+S+0qkfeHOcKUN
	oi/Jx8oU9K2S1rs02w3KBLVlBgQZjZMUi4GN6LOrvbIfG3v361S7GUYDlhDpVNj1BWKYyP143wy
	V6YTy/NQRgIKApt11gGvuRw+QxQPVtYhlUl96evAj3ZqAxQnCOBNpvg+JllywrmbRw5BQcDGUL2
	WJvMVimdxu5x++0HCyaUmm6csvyNYKTbt8nPtAKHt/67XtX2xv6bzRKD5robubd5pF8pLg4QxSd
	oGxzuP7P096823DcIqxqzB4XoP3yanDhbj
X-Received: by 2002:a17:907:d310:b0:bec:ebd7:90dd with SMTP id a640c23a62f3a-becebd7a10fmr24002566b.21.1780214455180;
        Sun, 31 May 2026 01:00:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bec5e5be0d4sm41821066b.52.2026.05.31.01.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 May 2026 01:00:53 -0700 (PDT)
Date: Sun, 31 May 2026 08:00:52 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Message-ID: <20260531080052.guzobbwdvprrmger@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-10-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527204757.2544958-10-hannes@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,cmpxchg.org:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-16484-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	NEURAL_HAM(-0.00)[-0.961];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 36532614F0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
>The deferred split queue handles cgroups in a suboptimal fashion. The
>queue is per-NUMA node or per-cgroup, not the intersection. That means
>on a cgrouped system, a node-restricted allocation entering reclaim
>can end up splitting large pages on other nodes:
>
>        alloc/unmap
>          deferred_split_folio()
>            list_add_tail(memcg->split_queue)
>            set_shrinker_bit(memcg, node, deferred_shrinker_id)
>
>        for_each_zone_zonelist_nodemask(restricted_nodes)
>          mem_cgroup_iter()
>            shrink_slab(node, memcg)
>              shrink_slab_memcg(node, memcg)
>                if test_shrinker_bit(memcg, node, deferred_shrinker_id)
>                  deferred_split_scan()
>                    walks memcg->split_queue
>
>The shrinker bit adds an imperfect guard rail. As soon as the cgroup
>has a single large page on the node of interest, all large pages owned
>by that memcg, including those on other nodes, will be split.
>
>list_lru properly sets up per-node, per-cgroup lists. As a bonus, it
>streamlines a lot of the list operations and reclaim walks. It's used
>widely by other major shrinkers already. Convert the deferred split
>queue as well.
>
>The list_lru per-memcg heads are instantiated on demand when the first
>object of interest is allocated for a cgroup, by calling
>folio_memcg_alloc_deferred(). Add calls to where splittable pages are
>created: anon faults, swapin faults, khugepaged collapse.
>
>These calls create all possible node heads for the cgroup at once, so
>the migration code (between nodes) doesn't need any special care.
>
>Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>---
> include/linux/huge_mm.h    |   7 +-
> include/linux/memcontrol.h |   4 -
> include/linux/mmzone.h     |  12 --
> mm/huge_memory.c           | 364 +++++++++++++------------------------
> mm/internal.h              |   2 +-
> mm/khugepaged.c            |   5 +
> mm/memcontrol.c            |  12 +-
> mm/memory.c                |   4 +
> mm/mm_init.c               |  15 --
> mm/swap_state.c            |  10 +
> 10 files changed, 150 insertions(+), 285 deletions(-)
>
[...]
>@@ -1379,6 +1285,14 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
> 		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> 		return NULL;
> 	}
>+
>+	if (folio_memcg_alloc_deferred(folio)) {
>+		folio_put(folio);
>+		count_vm_event(THP_FAULT_FALLBACK);
>+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>+		return NULL;
>+	}
>+

Nit: we have three possible failure point, and some duplicate
count_xxx_event/state().

Maybe we can have a followup cleanup for it.

Others, looks good. Thanks.

-- 
Wei Yang
Help you, Help me

