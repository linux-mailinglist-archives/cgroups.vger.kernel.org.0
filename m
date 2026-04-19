Return-Path: <cgroups+bounces-15358-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED19MCP75GlZcwEAu9opvQ
	(envelope-from <cgroups+bounces-15358-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 19 Apr 2026 17:56:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E14248A0
	for <lists+cgroups@lfdr.de>; Sun, 19 Apr 2026 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF08230058C5
	for <lists+cgroups@lfdr.de>; Sun, 19 Apr 2026 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350C2749DC;
	Sun, 19 Apr 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj5UZIt/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C540DFC6
	for <cgroups@vger.kernel.org>; Sun, 19 Apr 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614177; cv=pass; b=qB7E01KRa1jX4QPuZR77AMSRGKPtB7pRQxdmcGg1ov8dghbJSW2bafdOyOB8wZXMqeMUezH5wkJTqGYEQ4KnKwc7YZMGyiJ4GBFGwvi4KbPho2K4qczCYsmwwhdfKOD/aStqmmHASr7PM1Qq+EWWDzipkRL8TczkYvpUb1E1o9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614177; c=relaxed/simple;
	bh=3Y8kHi3nyA6VNd7vPtjyPH6tK5va4FVW4dMZwVqO6/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhC482P1DkZ1pnC7Dcg4CTA8vbiGsJ2M0zO1OneEa8hXfHM8bmfD35e3jfQapezDljnauh4wFlHj6vcXAIfvv+T0F6e+Hx8iONtGLaclu1l/AjFwTGcvd+RoMvJLRzaSsxAz9+f4/6A+y3Sv93saJlDNp7siD1kp8n1WVVTrnRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj5UZIt/; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so2724327a12.0
        for <cgroups@vger.kernel.org>; Sun, 19 Apr 2026 08:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776614174; cv=none;
        d=google.com; s=arc-20240605;
        b=c3DzMA7sp4TAfxPqAPeldLgMi/Zo8TGoUJ9DX5TTnSmI+pDF1nP+563EzmyGGTGM2f
         oWZO2a04yze0y8y02TbjNULbLgHx+U7Oqprqoq5ZRZwPuWxeQlJmT/0gTpNH7HeH77Xs
         r13JAfYvODD+EavxG620OlCjHgyO++JfbvApDH5YhgtMvwCQ5uzIGI9mJ3ZKCsAb+bxW
         4m5oMzUzUxJcLAPOUCx9nSg9fUJhNtJ+28LcT/yTIfj1ZsEgDPnAllQ2zs1b7n4aIAjB
         k6kRPBIEun9lmTdSkH1nntZ9MBNeq3gCFMN1KsU1D5E5vGbqooVJzn55XzxqlMzcQygy
         z/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bS1cThwHIktcd5p9rJSSzoXzcbmkZO9SdVakwgQGsP4=;
        fh=ibHcPNDG0JiBvXY5dRZZEFDOXRnShVhtpyWfZgyrtms=;
        b=iCGvti28QHMREdWGAcJWinnb0rLX2rLW7oGQTT8eKLDX20nICvA+mA8SArMvD1bDyV
         bhtXpSXMMiGFHyI8I06uHV1Rg9fZ5s29Ym3T9SHO9qIxOtBouAJ6IborvTHWjAkuQu6S
         Iko8AlZldMunXsCF8DN9wf9klkzC0LO9L52It2p6/ofcniYxn9QQ/SYNZnxdQacltE33
         Hl8DDtCZv2dwDs0ldEi5ebzQtZev8o1hg31AUXBP575IAkH7dOdvfBgrqpd3K80XJyqx
         smag8AzUyQrHNcYhjKB+ooIgHM3wrZV3D+h4mKXxcMsBDgZ/9DvYJlad9atd6za5gpPo
         H1Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776614174; x=1777218974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS1cThwHIktcd5p9rJSSzoXzcbmkZO9SdVakwgQGsP4=;
        b=Nj5UZIt/CSBey7dQsMQibYr83P3iDT4EPbRkP+ij/pQLZXPS4aO69hFx4GFkWUph6X
         N0B0vwzEO5IJ/m13MeILx7cOCxhgcK2NpPWbP9ZQtuKAGhiZxheuOPj40Br5VsZvfqHW
         GnrqNu6UJRY17XXvv1J6OnjpYWspH6yrsUm5cFcaQvp0vsbNCQ6LK6M66L0Rv1XmeZPT
         6OsqKfi82hGeW5K+XfrCaFlk3eVUhtTx92FjVtLhIJSQuT9NigUz5+18UXyms4as5IWe
         XTWuIOTSOSaQ01/iiuHjd5vODqkLw/GO/OT+lbA5Ifs9Uyrx3TsyKefd/04ae9l5+YM9
         HTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776614174; x=1777218974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bS1cThwHIktcd5p9rJSSzoXzcbmkZO9SdVakwgQGsP4=;
        b=iAA64mvDuvqw4eFN3wAHO6qFsNrs+3TSUZKwbxjXlED79AS2o0l87Z2j0Ui9xXGsTI
         OdcGQ2Vtz4OBdb31U5Hg1ux5v7fBIzMUQ6e7KeRUvBRVCY6n3I6IxRyFDO01J/82juT8
         +vxEVMqFleheVZ/mGINIkZewu6tUIniGnnMgl48jH0/ZlJo8j0G6ijoIBsn9FdZFFOKe
         2OelYk678Y812ijLK3PFS1FzK8a6IUJDEhW4NGvoYHE58/cSXQefcU/nZX+afI2Be4w/
         yZcL+j2SFsV8PWKtyvp5Lw3GgXrmFK8OuPpitxSHvUEMYXc9L+LHr2ijf7AEb+znNnzU
         r9DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HRrUfSHJP6uObUDVl/Dwpy/dlG+igmkpzfenN0CYk7QS6nPoUn+Tof6KRAsc63Pdq/sodKxUg@vger.kernel.org
X-Gm-Message-State: AOJu0YwltX9JgHiqNOnwm71t0alph8MFqyd0gw1flxDvJ6iSDq4JIJca
	Pu2uShhCKzipSsTnMgsGrgoUDa1cjFVpa0r2nI1pepg8+wFM0iwU136NUfkpJ9934DD5ZStTrNq
	x3UyfLqcLT9FeXoqiC5rzvAJFrP3WEeLLrpk9bqcFsrq0
X-Gm-Gg: AeBDietgLN2upDxmjQwpy8qG8r3RLTZPswSvEEZl487PXQbBYPuQdmLarkYz36/zGn+
	dAsnHOTrkJXv2dAgxHLnDF9gE9VaHCk8cWUCuN4e6XVaa3Wbe8HmxBUNXK0tVdIWvnLZc0jZQRh
	ZY51Lyaq3emFxKNxLnML8HhlZtDTTtmTZiwC7/fPkPuM1J0g+SH9cgiyyuQJ56f0lESatZQGem4
	MKpZaPINiUjnes5BiVSu9B76jUj52VUBIhOQgJmbZC7dVyICIuGW6DNubt94Rudv2CWQtBcyt+b
	Sl45km5fxphjMo2zZG0or+nX1wb0g6tTzV8IBzeMqGomDw2b8xo=
X-Received: by 2002:aa7:da09:0:b0:672:88a7:3888 with SMTP id
 4fb4d7f45d1cf-672bfd82e36mr3319269a12.5.1776614173974; Sun, 19 Apr 2026
 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
 <20260417-swap-table-p4-v2-9-17f5d1015428@tencent.com> <aeOPKlF4qAdM2oMH@yjaykim-PowerEdge-T330>
In-Reply-To: <aeOPKlF4qAdM2oMH@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 19 Apr 2026 23:55:36 +0800
X-Gm-Features: AQROBzAI4J739VXKT-UIynZGa6quQ6SqqMiU-pl0eYmKaSYDrbeDnFMA736To2Y
Message-ID: <CAMgjq7AmizS9v-F-VTeCwgexYdA42DJDMOPx17_aL3FFyhYSdw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] mm/memcg, swap: store cgroup id in cluster table directly
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15358-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 611E14248A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 10:05=E2=80=AFPM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>
>
> > +             if (IS_ENABLED(CONFIG_MEMCG) && !memcg_table) {
> > +                     swap_table_free(table);
> > +                     return -ENOMEM;
> > +             }
>
> Hi Kairui,

Thanks YoungJun,

>
> Nit:
> (Just a readability nit. purely my preference, feel free to ignore.)
> the checks around swap_memcg_table_alloc() reduce to two
> equivalent forms of the same memcg success/failure question:
>
> (!IS_ENABLED(CONFIG_MEMCG) || memcg_table)   /* success */
> (IS_ENABLED(CONFIG_MEMCG) && !memcg_table)   /* failure */
>
> A macro for the failure side would let the call sites read as plain
> positive/negative:

Your suggestion is really helpful! I also thought about maybe I should
do some cleanup of metadata first before adding more metadata cleanup
for a memcg table. In this V2 it's still not that hard to follow, but
in V3 if we have an optional zero map bitmap, things may get really
messy if I just keep piling up things like this.

>
> #define SWAP_MEMCG_TABLE_ALLOC_FAILED(t) \
>         (IS_ENABLED(CONFIG_MEMCG) && !(t))
>
> SWAP_MEMCG_TABLE_ALLOC_FAILED(memcg_table)     /* failure */
> !SWAP_MEMCG_TABLE_ALLOC_FAILED(memcg_table)    /* success */
>
> Equivalently, the same macro can be expressed by splitting on
> CONFIG_MEMCG.
>
> #ifdef CONFIG_MEMCG
> #define SWAP_MEMCG_TABLE_ALLOC_FAILED(t)  (!(t))
> #else
> #define SWAP_MEMCG_TABLE_ALLOC_FAILED(t)  (0)
> #endif
>
> What do you think?

Good idea. I also agree this part needs some cleanup. I will take your
suggestion and do a few more cleanup in a seperate commit. Maybe just
let the helper return early if MEMCG is not defined or something like
you suggested.

Thanks for the review!

