Return-Path: <cgroups+bounces-14851-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDQyJPunuWkhLwIAu9opvQ
	(envelope-from <cgroups+bounces-14851-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 20:14:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0332B1667
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 805BD300E69A
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127F3F880D;
	Tue, 17 Mar 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gosyCRMh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E573F881E
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774811; cv=none; b=psq8X1spyXVBJ+XWnhWcCLXjemVYNfWnwr3A7pmkfsHvAOxKZKnHQtwvpHvlLU57AWVZq3bj2vw4rbwuhXON62Fmb/Vz2gg6WWJP5d0qX6FNiTW+UsKnWl05raoqp6wet7ML39NKVEHekSQUbUmYWbYOEOkXMkoY7FUfHH8/wLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774811; c=relaxed/simple;
	bh=FIH3EfPbv9x9yhqNZFM8ItzyRZreHzjELJ0ci6yh64M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6J0WtFkCC6tyG/O53fxXG0H+2nf/1oy/5sQvc3lJlDcf6mT1UcrnIU8MyNaFZppce4pCVRySQaawbuxSQFANOgpFeLrIFlGE3v5VXTPTMobrAS+rYNfTDzYAATQLKyZDvaNnXoTvxLVVifOt78/jPBoWLbAjmIbfdTXmG1ogZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gosyCRMh; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40ef10ec84cso4271053fac.2
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773774809; x=1774379609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1WSlRQanpR5FK/cre1jv5yq/0lla158MVh0Hd3IbjY=;
        b=gosyCRMhgSFw48b4a2OurjBNDNhO/meUQHofZV3da0eBRe5/BQSQsZDae0Ob7y0Hth
         egtAw41yF2C3P2svOkEkyWrP4YmPR2JfahzhhBSsZ9/qh2cn63MNKqbYj2Ug0OCwkrqE
         uzMaG+mJCdMc5DXKTopBJDnUJ7aBCynYSek+t4qYRCmA+OdyH+ZyL1gArM8UxriNwhsV
         V9w1CTZ8P/AOfbWN1aXSxjSmrbhvC82kf5dVxXPAs+kzNUIE3fmWfTNsiWWiy0YExlhC
         2DFCe7gh3ANtJUX1qd8ROhERQIa5LV3Q41zrslbu1W7x72Khusa5uxYRJXBj4T1fBKkB
         fDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773774809; x=1774379609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U1WSlRQanpR5FK/cre1jv5yq/0lla158MVh0Hd3IbjY=;
        b=nQYrFLZYuzaGw3syMlg+Tcr5lUEqu0NRZIZ8jkT4Eo6BwRJlzE2IziRnpjYpq5Gf/g
         9CuRd0ewJ2buwPriFp9TxkSFM2//WSM7IENyf7b+n2oN5yw5bGsSg48D7CRkMo2LpGSx
         BpUZ9g3r6N1izJzY1mcmOoJ8fA5YgOmjtj9Yeyps8Wa5XozPBFwrC918h9uSrQJM5fyA
         6CXmPBRbMI5hYkPnVC/uss92RU8hLGDhC4u+AcwrlhrhqemIXs8fAWWenFzGW0p8KlsX
         w2TfL+LMmWCOAw2nENHpTB5G9P0b5TzyiiRlsoID6qQThEq/8EGtXkCZsOWhvXarFTwT
         iczw==
X-Forwarded-Encrypted: i=1; AJvYcCVyx7VpSUTPRCHftizTXKLdrZfC+N5G92okB+1wSyuFoDlnXYXxDwsSgqL7X47hKzt+kMj5sJQT@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYPleuVQ81NVenkBwzw/4cnnMzSr03+BNRzVpKu5GtSWD4gWj
	R117HYXBv21OI7tsdoRp5OIXWSFDoyorle5p5tiLTTuGPaHY+MJCX2/a
X-Gm-Gg: ATEYQzx88RF1O0w6uM+Dh62yQcXuSv2jMZ6W4HKknWcDYY5d6kXUUgoF8EpFfHI7x8y
	9L5YZkBUyGwWEBZW0nVfDdhg8U4+UYk+U09g/tHSwE7T1AHw2nl6FlVBd2MuVRFFhe0jp2FTCw/
	VQYxaFgC8gnjdXUpvAkXTqdNX+Sp3sYKIhZqvbDmZjUpYIWcgzSYiVbl7pFVCnn7tsNOo/rV3dz
	L4UGjmZiCPkB4J65BrWe1R+Xa/l9oO3LltyAaCcf3khjUgiju8m+L1wNKceC4IbsxUL+2uAAxUI
	4GKxhEBN08JRP6h4JnjgREsovdiH/gDpRylHqiq5wzAzHrXjoTWfhNrfP+V4Xe/JTRDFINMVMTP
	RXlCj3QD02RmrjF2NNAOIleDDAwjdV4wmvDw054MMJtWv9lcX0BD6ersPcmZPlWGeope4NGlY3h
	/ZQmGAheZBFIWH/dC5JA==
X-Received: by 2002:a05:6820:4812:b0:67b:b5db:f0dd with SMTP id 006d021491bc7-67c0da82fccmr277290eaf.15.1773774809295;
        Tue, 17 Mar 2026 12:13:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d7e5ca8sm279832eaf.1.2026.03.17.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:13:28 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 08/11] mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
Date: Tue, 17 Mar 2026 12:13:25 -0700
Message-ID: <20260317191326.2208313-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAKEwX=OySmc1SnnzYBjL7vn4o9bf2BiSzUUHtx+6hpU4oCu93Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14851-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F0332B1667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 13:33:34 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Wed, Mar 11, 2026 at 12:52 PM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > Zswap compresses and uncompresses in PAGE_SIZE units, which simplifies
> > the accounting for how much memory it has compressed. However, when a
> > compressed object is stored at the boundary of two zspages, accounting
> > at a PAGE_SIZE granularity makes it difficult to fractionally charge
> > each backing zspage with the ratio of memory it backs for the
> > compressed object.
> >
> > To make sub-PAGE_SIZE granularity charging possible for MEMCG_ZSWAPPED,
> > track the value in bytes and adjust its accounting accordingly.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> LGTM.
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

[...snip...]

> > @@ -1066,7 +1066,7 @@ static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
> >         rcu_read_lock();
> >         memcg = obj_cgroup_memcg(objcg);
> >         mod_memcg_state(memcg, pool->compressed_stat, -size);
> > -       mod_memcg_state(memcg, pool->uncompressed_stat, -1);
> > +       mod_memcg_state(memcg, pool->uncompressed_stat, -(int)PAGE_SIZE);
> 
> nit: seems a bit awkward lol?

Hello Nhat,

I totally just saw the Reviewed-by and moved on and didn't see this nit
here :p sorry!!

But yeah, I agree that it looks very awkward. AFAICT I don't think there's
a signed version of PAGE_SIZE or a negative PAGE_SIZE definition, so
unfortunately this cast is needed : -(

mm/zsmalloc.c: In function ‘zs_uncharge_objcg’:
mm/zsmalloc.c:1068:66: warning: overflow in conversion from ‘long unsigned int’ to ‘int’ changes value from ‘18446744073709547520’ to ‘-4096’ [-Woverflow]
 1068 |         mod_memcg_state(memcg, pool->memcg_params->uncompressed, -PAGE_SIZE);
      |                                                                  ^~~~~~~~~~

I will note that this is a temporary cast, we immediately remove this line
in the next patch. I did this because I wanted to show a natrual transition
from MEMCG_ZSWAPPED --> MEMCG_ZSWAPPED_B --> NR_ZSWAPPED_B and thought it
would be easier to review, but this does leave some intermediary changes in
this patch that are removed right away. If you would prefer that I squash
this commit and the next into a single patch so that there is less
intermediate code, I would be happy to do that instead!

I hope you have a great day!
Joshua

