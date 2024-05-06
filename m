Return-Path: <cgroups+bounces-2802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95A8BD4F0
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 20:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C812B2411B
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D16158D99;
	Mon,  6 May 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVtN66iQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D79158D90
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021602; cv=none; b=S453HHvWa0ZoCLhiMFrTpL73X6uTN0XHmvcLUVEJ79GFSoTRfOgx7ARuaU+zDmfdQPxNGZNkhnCbdMRXjQ4i+HuriVGBC8Mz/47YVsIp9Yfqo5vdWjlOTt0cEnU2oGUOl6hgwDswhwpiYyma77eSW7iEkBSOVkbRkV8j7vqb67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021602; c=relaxed/simple;
	bh=uvqnx8a52JgW44MRDiVGrtHg7doUR6XkYawNsmmAJKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORdCyD8fcgxpfU/HDDOctMnhocuPY3NPTp0FiQMYID4LiZYKh/4cvnLgCET/WbflOZV5x9yqayXM/H2aTdW02Zr5aAYYz/lUnW518nfZX0gyWYdHr9KCNXoe3GFv3nXSk7cFnxqXXBMu+P9rXBS+MV80KEduoclTWGRJxk/H7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVtN66iQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a387fbc9so551099166b.1
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715021600; x=1715626400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvqnx8a52JgW44MRDiVGrtHg7doUR6XkYawNsmmAJKQ=;
        b=jVtN66iQL0RfTOdb1SDM+NMEkYX1oyAsXgnAk59XSPCBpUb0X/pgP4I7nWHDeLxhmv
         ibYFgEO4a4iMNBHxNVivxhN5UHjngYwOOM6O4sGUFgz0PmkK6VRsu5RsMjMaUelfi0sR
         cqpNEOGDed8h2xlpN8dIhtvBFPtItaJG4W8SdftQ0ySwsGTEbgZ7GA5D/3H9qxMy31Cw
         841sB4i0U0S20avkLpzh+QYmqQvsgbLSXfVBKFrSPEka2pZlZKeJZjt5mHb/SVjnMRBY
         wOB/M2DFm9jqWBlu5FyviUpgW+nhsDktxayfTp1Vg9Mm4fgzZ8Qi+9Ut/4MNNJqWYEnl
         wHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021600; x=1715626400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvqnx8a52JgW44MRDiVGrtHg7doUR6XkYawNsmmAJKQ=;
        b=gmHyxW3wIeIVAakeABUaTEAD5glNVmOuBPjEG9GEkFDUdkU+hrKIvCcVf8yU78us22
         E0E0DxwHN4kIEbTiWknu4sECbhHBGs7Om1Ylcz6qsY/q9toEUs9zpMLQMdpv1aN6klOy
         bWKA5j0gR4wuIUuvnTJFbWckOsyyORJH5pAai0SzdnCGN6WBqYDBWGEBZgWFquXBQMJr
         zJS23Iy+AIOpiBNksBEacQSs0Y/te4QBQArbfJrhlLWdXcMHFfCjaTP8d1dhIY55LdWp
         hG4RnmVOnXfG0cxZHe8VCNwKIy4Wyte2iC5SZWm73yqfv6QdoxoH+XpHC11jFBpQ7N4F
         5scg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3hfQ+Tlx9rwuzA2Pw5fJ91Hlr8o4dC+Zdhj/id8lkwu+H9u9McNo6NIYutzYVW2WhvkPuLr7ohJ/cAvLYwfqwHT/DLWwWg==
X-Gm-Message-State: AOJu0YyEa0lb/urtwco4hKuKlHfKaqGoLEIXDSZ5LlQvSUSWDHLTxCdP
	HeSEaLcLmuOdQqnfZW3ED7iE775RqhqzoFa8ac0jxMpNhQEjkzUo6njD/t2aZUgw+dOOQjO9PLA
	N4DMkIXGEYqtIKz2w9K6j0I1pDsel6Q6XlD6m
X-Google-Smtp-Source: AGHT+IHaoPMigFap9qR56mDK6IoGtW0CNZrr495O28d2oa2CU+qgAxuG5JrPxUlJnGEnR0Odtvd35E9w1QRml/F5ldY=
X-Received: by 2002:a17:907:7e8b:b0:a59:bfab:b254 with SMTP id
 qb11-20020a1709077e8b00b00a59bfabb254mr4113478ejc.64.1715021599491; Mon, 06
 May 2024 11:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506170024.202111-1-yosryahmed@google.com> <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com>
In-Reply-To: <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 11:52:40 -0700
Message-ID: <CAJD7tkaPvYWhrMSHmM0n0hitFaDdusq7gQ=7+DTUQLODGdo6RQ@mail.gmail.com>
Subject: Re: [PATCH] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:35=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 06.05.24 19:00, Yosry Ahmed wrote:
> > Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED an=
d
> > NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
> > __mod_node_page_state() instead, which updates the global per-node stat=
s
> > only.
>
> What's the effect of this? IIUC, it's been that way forever, no?

Yes, but it has been the case that all the NR_VM_EVENT_ITEMS stats
were maintained per-memcg, although some of those fields are not
exposed anywhere.

Shakeel recently added commit14e0f6c957e39 ("memcg: reduce memory for
the lruvec and memcg stats"), which changed this such that we only
maintain the stats we actually expose per-memcg (via a translation
table).

He also added commit 514462bbe927b ("memcg: warn for unexpected events
and stats"), which warns if we try to update a stat per-memcg that we
do not maintain per-memcg (i.e. the warning firing here). The goal is
to make sure the translation table has all the stats it needs to have.

Both of these commits were just merged today into mm-stable, hence the
need for the fix now. It is the warning working as intended. No Fixes
or CC stable are needed, but if necessary I would think:

Fixes: 514462bbe927b ("memcg: warn for unexpected events and stats")

, because without the warning, the stat update will just be ignored.
So if anything the warning should have been added *after* this was
fixed up.

>
> Fixes: ?
>
> Do we want to CC stable?
>
>
> --
> Cheers,
>
> David / dhildenb
>

