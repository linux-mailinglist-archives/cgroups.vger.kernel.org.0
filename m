Return-Path: <cgroups+bounces-16318-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF4MC269FWrKYQcAu9opvQ
	(envelope-from <cgroups+bounces-16318-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 17:34:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C35D8D0B
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBDC93033AD7
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1A1C860C;
	Tue, 26 May 2026 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEiFln++"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C02AD3F
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808598; cv=none; b=pcidJozB2k+TbfS3CjuVc7Xd16MMLfthPCDHk/C9TOcGRGOwtes5Ll6gqIUjd6IUgvPxvBFSWxUlSU63EsN3UPnKWIHDwCYZr0un3NWzAsu/rabL+tDNu3ymrzD2ewIZgjHI7Xk8MKoogx6EeFrCx7FD9WZi2Vhu4h6ptQJJthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808598; c=relaxed/simple;
	bh=1xH8BBQab0RxrIhXfm/7YY2miDCgb3JE46znIT031kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOzQwVVxq2OfLTt2oqmMQja3MHPBpM7Y1n/T2Xktp2T5X8Hg+NGSOHqkTtQRNUGc2z7BOoJLsuB+EqMY2tq6aEAucxWKbh5un3otF2nA4FDjku4NbemooF1v6/sOFRx+xa42aFl1Qv88coz38WMEnJTfYpqY0bEs0bmnQahAlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEiFln++; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43b6f19b7d4so2842929fac.0
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779808595; x=1780413395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVmfi+uDn4MQKurIQE45dLQAanWv2IAzX5ZFf3oRwXU=;
        b=XEiFln++cZicGcvm4AuszbFWusF486pCj1LwuEzhMTgRD1RwN8CyKpqipemMhcT+mL
         TQcfXKM+tw3hdDz/aoJ79+/+NiAfwIB0HUJvif3qpZBVUjrbgp1djYhDIH+7Ea3Kge0b
         WwkJMIg6YteoI6lpA6WEZJAOBKc6Cm47cmqkvSzWvGFD9K95ACHzudKLRp/j1CEVbI7Q
         9R4PY0VXK+5CDYZ8NV4rtLlxSW4s8Rnt3Ivf1jFDl2/F+UW+kfxGtvqPVvQEYZ6LSxeH
         +mOhvoyt+4SYLeTJdP0X3Bvzg7Bhkq4+rMJvuRA8aF4PfoyfZutkt0/hqFEjTBGGAGgH
         pxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808595; x=1780413395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVmfi+uDn4MQKurIQE45dLQAanWv2IAzX5ZFf3oRwXU=;
        b=GM2SpQENTORoKOm+9iK8AhclPsEiUEZMI7gxQCuDFqWNdQNDpTi8f+a1F6pKjGuuDO
         ThJh2WaNWZv1tDBc4mwHuiPtWIXoPNciA+tMMojSSYyS0AQ9MzRKsDJyOTk8Y6oGSerD
         Rz0ow7Nj2+QFAawZqPlE+r81jXSXU46CyX/67RXIMbe01fXP4WcguOdot4TbVzpBkyeY
         aCvUFOTqwFASBgmCDDKaRWxW6N8RCZ3p5iSw+YJUAv7kcuQg2Ooqg5yHx4HOQ8AfDZPK
         M9iR6Jr9RiFyGIowcB2QcDD2Aq78wP6dsRHoAUJbIaKMuF/tEHQCjotFLEB7zkYjZ8SJ
         92Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+2fCN4vaz36HCoDf0kcWLhm93CvOUI154yEcgQOVBhvTIHro0p8U/qAYbgSbo8F0gQPmq7gIeE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7Pz0dEpKKPNWtNlwt5rfj4sX18pL43/Y8zWt/MaxCagb47Hi
	tEQAoGctazLR4kn34InXG7EeHvBDdSJTL1bsFqsXUs6++7B1rEmBxqvA
X-Gm-Gg: Acq92OGzmTrGVNNk7OOGyBrIMzLTQxLTiTkaWv6cyJx9vLF3Wmzzy+PMEyeaYYoJ93Z
	+5ASyguJAnLM6Nn8Hao5cNelL4oTNQmvuPqdWuhAOGdb17vgM7WS1LjLRstW8dUzApdXqfK7pgf
	lLSPAELgJJur6BK1bpTKomDV+a83HGO4qozz85nLfj8k3S8SNFSPcoS++QgKdXeN/GIPoShIJQ4
	Skc5U8On8LiWYi8LyGnth3Vpm6cOWj5JJA0+/Pkm1qVABJPF2q92uVrURlU3D2LhzrjKHRiPdr0
	X9Mo32MjX1lAXJjZRS/dgwLazNZCylNyPvis9PzPJ8xKol03FR3bWvP1TSitTvyuJi8MabX1HSJ
	reaXz5yGx27UC3wVmMOTn/Xr0achV70Q92K+Kc8k69XqQDpqAjRVHOWLC3XCGRAPIqXEhGeZGTv
	4J4eta1o0gN/XTIG+5MKrFZbQrT9iGosIQExa0Zp1r0pXu3K+ie8pIwg==
X-Received: by 2002:a05:6871:5d05:b0:424:23a2:5cd with SMTP id 586e51a60fabf-43b5a9f6fe4mr10168185fac.6.1779808595391;
        Tue, 26 May 2026 08:16:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b62e4211fsm13405421fac.0.2026.05.26.08.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:16:34 -0700 (PDT)
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
Subject: Re: [PATCH 0/7 v3] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Tue, 26 May 2026 08:16:30 -0700
Message-ID: <20260526151633.3738554-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16318-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 961C35D8D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 12:04:47 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> allocations, allowing small allocations to avoid walking the expensive
> mem_cgroup hierarchy traversal and atomic operations on each charge.
> This design introduces a fastpath, but there is room for improvement:

Hello everyone,

Sashiko has left some great comments on the series, some of which are
things I need to address for the next iteration, while others are false
positives. There aren't a bunch, so I'll go over all of them below.
Note that the same warning brought up in 1/7 is duplicated for the rest
of the series; I've addressed my thoughts for that in [1].

> Joshua Hahn (7):
>   mm/page_counter: introduce per-page_counter stock

Sashiko raised a concern about how zeroing per-cpu stock during the
nolock drain could race with in-flight charges that read the value
before it gets zeroed, leading to duplicate drains. I think this is
solvable by just changing the order in the callsites (disable, then drain).
More details can be found in [1].

>   mm/page_counter: use page_counter_stock in page_counter_try_charge

Sashiko raises the same concern as [1].

>   mm/page_counter: introduce stock drain APIs

Same concern as [1].

>   mm/memcontrol: convert memcg to use page_counter_stock

Sashiko raises 4 concerns, of which I think 3 of them are false positives
(or not as serious as Sashiko makes it out to be).

(1) Sashiko asks whether the synchronous draining with the percpu_charge_mutex
    lock held could lead to more time spent holding the lock, which means
    more callers of drain_all_stock would fail the trylock and just skip draining.

    To clarify, even in the original code, two tasks simultaneously calling
    drain_all_stock would serialize and only one of them would schedule the
    drain work, so this problem definitely existed before as well. It's just that
    the window for this race is a bit longer now.

    I do think that there is actually a behavior change here (for the better).
    Previously, drain_all_stock had no guarantees on whether the stock was
    drained before retrying. Now, if the caller can get the trylock, they have
    a stronger guarantee that the stock is drained before retrying the drain.

    On the note of premature OOMs, each retry loop takes much longer than the
    draining itself; I would imagine that by the time the next retry loop happens,
    there's a better chance that the trylock succeeds in the next iteration.

(2) Sashiko also raises another concern about a potential ABBA deadlock with
    the mmap_lock. I think this concern is not really true, the synchronous
    work being done (drain_stock_on_cpu) only takes a local lock. Hopefully I'm
    not missing anything here.

(3) I think Sashiko's concerns about NOHZ / CPU isolation is real. But it shouldn't
    be too bad, all I need is a cpu_is_isolated() check in the for_each_online_cpu
    iterator. Again, not draining a CPU is not fatal here, so it shouldn't be too
    big of a problem to skip some of them.

    I also just wanted to note here explicitly that we don't need the
    migrate_disable() for the memcg stock drain, since we don't differentiate
    between local drain work & remote drain scheduling (like objcg_stock).

(4) Finally Sashiko asks if we should enable the memcg->memsw stock here.
    That's included in the very next patch : -) I separated them so that they
    can be reviewed separately, since they are separate ideas. 

>   mm/memcontrol: optimize memsw stock for cgroup v1

Both concerns here are addressed in the previous section.

>   mm/memcontrol: optimize stock usage for cgroup v2

Sashiko raises 3 concerns, of which I think all of them are actually OK.

(1) If we drain the parent memcg stock on first child creation, then this would
    mean that there will be additional synchronous work being done with the
    cgroup_mutex lock held. I personally think this is fine, since it happens
    once per parent cgroup, and the draining work is pretty cheap. But I would
    appreciate it if other reviewers could chime in here.

(2) Sashiko also asks whether we need cpus_read_lock during the iteration.
    I think it's fine without it; if a CPU happens to go offline during the
    iteration, then that work will be scheduled on another CPU. That's fine,
    duplicate draining work on 1 CPU isn't the end of the world (and preferable
    to taking a cpus_read_lock here). As for the dying CPU, it will drain its
    own stock during the destruction path anyways, so no stock is lost.

(3) This one is not related to this series, so I'll move on.

>   mm/memcontrol: remove unused memcg_stock code

No comments for this patch.

I think that's all the comments that Sashiko raised for this patch. Most of them
had to do with performance tradeoffs, for which I hope that my testing results
in the cover letter were able to instill some confidence that a lot of these
tradeoffs aren't as bad as they seem. Regardless, I would really appreciate
reviewer feedback on whether they think it is acceptable.

There are definitely some real bugs that I want to address, so a v4 will be
incoming to address those (in a week or so).

Thank you Sashiko!
Joshua

[1] https://lore.kernel.org/linux-mm/20260525194506.3414995-1-joshua.hahnjy@gmail.com/

