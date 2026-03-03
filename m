Return-Path: <cgroups+bounces-14582-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI4NFY90p2mehgAAu9opvQ
	(envelope-from <cgroups+bounces-14582-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 00:53:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0221F8872
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 00:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E2BD302CE3F
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 23:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E4375AB8;
	Tue,  3 Mar 2026 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMmAWs69"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43540372EEF
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582025; cv=none; b=js24/qAkKDorDUn2dUrH7dlFrBIUIhCLCI8oZccvtzunAFXxv65rGLIIllhmqheC8cF8t51dbj8oeC+8Kgtij+Y7ObtxOjT1sB3SsQf8SmTleYpC24+Z260gvRJhryOHp5pQyuEM7fGD3ac4G13sYcDtt+YP2I/z/cfGcUmeznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582025; c=relaxed/simple;
	bh=fObzBjsb6GX+dDjfb/ilAFCOs/Qr4uRWvHMt1EbvpjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaPwrBw3zZP/qwyPGXNWMyr/lnk30DFF4+AfDTnMk96+06/XnV+PqBhC6aD5qyDNeidjSbnIMCVMdU3yAhSxaOTi8JJO86gwQOWI7kcrzbuuuTxokoJVsJEIgPTFlL5acQoYlIVUd0VMQ83P+pplUqrQtV/uu9xw2bTKZbD+Ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMmAWs69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E494BC2BC9E
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 23:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582024;
	bh=fObzBjsb6GX+dDjfb/ilAFCOs/Qr4uRWvHMt1EbvpjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GMmAWs69v3XjcA7diChAmGds/YQKJYo7+vvq9uQ/9Z/pD1joKE13/j3uyvP1Mp27q
	 zYoRF3nGeE0/D0WitHw5zhFKhs1K9XL1CO5cXMJQC5HzpsMmhu3L6E8BLg4SeY4HqM
	 wcrKSOI7dXSYEW0eqbCXKFgHAoyfLDq6fFN1wYdNa6VU3mZfuE9iOJzh78Se+lJiTo
	 m6PtTJoAEjgM1ZblGGf7SSh/C5f0lDMDmyGQ9bZeuB9xZHYpf9kVh0nCVm+QyiC+ao
	 T7unJb7qDF07GuOyNb2O5gvy3N3XuIKuUv3spN4htl8ZQESM1IpUSeXSXhyLaBCJa3
	 wYxjQt+qOxH+A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8fd976e90cso791070666b.0
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 15:53:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQdO48lpdT5hdfrSOArp0ixhoyP9ClnBrJVMM8L24lFu0CanpeRB3jfNoh3i3ikBKwzHH8A+Pv@vger.kernel.org
X-Gm-Message-State: AOJu0YySesZqSib3/Ui7xtxzjfa1VkQxKbI0ME8vM4BqAJ/Yt+DIOIlV
	BECSPJZ/PjuYobSRojhOn+NBf0fK+qZZKnnEc9nzZyOx+/MJEU7VtIyVGdou8ektMGJRcNyvQgL
	WYRB+ht+iVQVD0gxBWLaWsyQFyHds3bo=
X-Received: by 2002:a17:907:3c94:b0:b93:51df:dd23 with SMTP id
 a640c23a62f3a-b937639ba94mr1099210366b.16.1772582023631; Tue, 03 Mar 2026
 15:53:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com> <20260226192936.3190275-7-joshua.hahnjy@gmail.com>
In-Reply-To: <20260226192936.3190275-7-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 15:53:31 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOFS7zU-eGkErcjud=DW0t00_WqNqCzq_QDf061dOsYSQ@mail.gmail.com>
X-Gm-Features: AaiRm52Yk463FChq_84ojqG3qlKdUbfHqxoYs1pEzz26FFpHqxgDwturcqbb_Yg
Message-ID: <CAO9r8zOFS7zU-eGkErcjud=DW0t00_WqNqCzq_QDf061dOsYSQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm/zsmalloc, zswap: Handle objcg charging and
 lifetime in zsmalloc
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5A0221F8872
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14582-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,cmpxchg.org,linux.dev,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 067215a6ddcc..88c7cd399261 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -963,6 +963,44 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
>         return true;
>  }
>
> +static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
> +                           int size, unsigned long offset)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +               return;
> +
> +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> +
> +       /* PF_MEMALLOC context, charging must succeed */
> +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> +               VM_WARN_ON_ONCE(1);
> +
> +       rcu_read_lock();
> +       memcg = obj_cgroup_memcg(objcg);
> +       mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> +       mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);

Zsmalloc should not be updating zswap stats (e.g. in case zram starts
supporting memcg charging).  How about moving the stat updates to
zswap?

