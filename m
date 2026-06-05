Return-Path: <cgroups+bounces-16675-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sfe7BPLwImobfgEAu9opvQ
	(envelope-from <cgroups+bounces-16675-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:53:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14A64980E
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:53:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W+cIeEh+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16675-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16675-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101A230330B3
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C58223A9BD;
	Fri,  5 Jun 2026 15:41:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C93BADBD
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:41:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674101; cv=none; b=ohWvHL6uwhoj0jL536q0qqUR+HtW8mI8oNH+NBaFSI+CdE8gqb1/eWSM659XW0Pi4YhrXx9N8wD2ev/UWZRP3VuQmpv6tDdPUiqefjW0e2vlwg3SFAxzwf+tPb4FEBTLP+E5ICrrSpyZP6syZ3H4ltYm6FdJ2hRURSJNNwtNUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674101; c=relaxed/simple;
	bh=3lG1VFTIzPuOpKHLtUvNxm1Y7EPAysGI8/9QXN/VQjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9k22XXxy7LHIkz0/5xGrcJEbe5nwoPqQ7XhpgTKT4g6/9IAbBCV8luwulZDfEoevpL0yRx41JjaUebuzVozhcOc8AzcPPLUoCOOPiE4NDZ+0LTVmS1LK6dC0r2xMep5LqipOOTxLk+M7LDGYzKHr4wG/yRfkr2cmiOJ5657LK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+cIeEh+; arc=none smtp.client-ip=209.85.210.42
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6cdd78fe6so1034840a34.2
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674100; x=1781278900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFfuDG07qzWYz9cM/uqAnn123BbnDuZibDKFIXN94Bs=;
        b=W+cIeEh+AD5sYEPfx8rpopl7tfNEl5qmqYdcW7cAyg7PJYfavUhMBeHu+iVQURAB25
         fLYmdDzyn0NmXwPMvfRkQnJASpK+zqJtmr5nZL4eBJV1MntK6BYoVcG7GHj2ofv2ztlp
         QA8zw6zASRYEKVLbTXleb+d93oVTlLGSBX24dijO7CGkQThNNXSDy+m5yMI+HSNQAhu8
         oTjBwdgMEWlT9NqL/V+miVp+r6onlwXaJh2NMaWNqbetJS48BnTVIyJgjM2MWLecirja
         yqSq+LkLSe3LR3F1gBoSQYU9fxkFAcJpsgl5nAV7OFQKpCSwkEdLacWGcW+PITZ9aKvv
         dNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674100; x=1781278900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFfuDG07qzWYz9cM/uqAnn123BbnDuZibDKFIXN94Bs=;
        b=A4HWjOkt/9QPjUWZvQMp0KRZ52D8BLiobmGXKCrTfaKDVsjKFimeX7TH7WGXgkhwJZ
         +I8gwJhZCZdNF8gRAQvlNfo5Vieg+fFDoKNLmMf3bMIr/Hn4Q+tu5ylk3maSONZ8qRE5
         dZifX5jWRSpPqFZqOy2jhEn6ejpjkRhi0ZayJD9ng/rRu3/j1Ad0MrCtMjbMUY/qArpB
         a3Cy/9Qt0Arj3+3zmP+0kZszjJy6zt+UWsvXyGOSi12eajA5LFBw+KXQGJaw2iNlwd3M
         XJNKyu3xaOk3MeCT5wJUXs0gzElAwDWmlrW7cpg2OpxNxSxF7kfFhdi4obLUnPNITHLD
         sS0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/gcgyeXoclCFcWZsH2t8NTMdQ1eVMgpRc/X4zSIowqIxrvhVmWCfXggtixbX8rDZ7aEN60Q5EV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6DD0DElHiZL6qwvUDMpYYuhEqtVqPpl5AAF2MP2P1Qn2iOhx
	9pEAcku9eFyH6XQMiA6HWoMtZJL9kxXpwyaZnqoD/pfmKW6S/vz5bCBX
X-Gm-Gg: Acq92OF1GdBgOyGPecSR1coIymlnzmxGm7/5d3pJxPBG/25P4jSGWpoc2ctyPKTObGK
	EHojbx1Vbf62LpEzlGoTMiI+cuxzBnLpIcf26BDe3/U8VGbQZkzTi2rqjFYCBDCFG8DVD79u6nZ
	GcommAxisRS8IMzQjbJvG+d5ozFMFqTTfzuomDjSpfvj28z1Wg9F5zXTuH/hzWoJ2JXvtfviDlg
	dIS/ATgptlXv62T5pDqk6l8rRReVy6TKiQt8ul29SRMs21GRDiwbOdAd3huUIDlEB6xtC6Y7ki5
	xuoRCBURto+cM+g4lCNFATiEyFpL5hoGBoVxtb3b53LlDw09+LyRY6P3QK86uar/8OrzWG5FbRS
	YaGvQcTSjKlFlixp9eSCifIUgQUgnJNISRNQzMoziB9t9UHcrr57ft60kzjNH8ZE5r7sqcLULk5
	0/w/sKqBinYNIJ2O88nLvmQMb06/bPyLTKQ24U7HpSbHXzq+yOqVp5jPO8V8w9Ix3f
X-Received: by 2002:a05:6820:82b:b0:69b:196a:de67 with SMTP id 006d021491bc7-69e685faf92mr2261978eaf.0.1780674099658;
        Fri, 05 Jun 2026 08:41:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464743f8sm5649858eaf.15.2026.06.05.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:41:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/6 v3] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Fri,  5 Jun 2026 08:41:36 -0700
Message-ID: <20260605154137.300900-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16675-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F14A64980E

On Fri,  5 Jun 2026 08:35:56 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> allocations, allowing small allocations to avoid walking the expensive
> mem_cgroup hierarchy traversal and atomic operations on each charge.
> This design introduces a fastpath, but there is room for improvement:
> 
> 1. Currently, each CPU tracks up to 7 (NR_MEMCG_STOCK) mem_cgroups. When
>    more than 7 mem_cgroups are actively charging on a single CPU, a
>    random victim is evicted and its associated stock is drained.
> 
> 2. Stock management is tightly coupled to struct mem_cgroup, which makes
>    it difficult to add a new page_counter to mem_cgroup and have
>    multiple sources of stock management, which is required when trying
>    to introduce fastpaths to multiple hard limit checks.
> 
> This series moves the per-cpu stock down into the page_counter which
> consolidates stock limit checking and page_counter limit checking into
> page_counter_try_charge. This eliminates the 7-memcg-per-cpu slot limit,
> the random evictions (drain & refill), and slot traversal.

Sorry, two things that I forgot to add as reviewers' notes:
- There was a previous v3, but that was just a rebase, so I wasn't sure
  how to name that / this. I decided to name this one v3, since the
  last one didn't have any changes at all. I apologize in case there are
  any confusions.
- I think it is quite late in the merge cycle, this is intended for the
  next cycle, not this one.

Thank you!

