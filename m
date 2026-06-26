Return-Path: <cgroups+bounces-17356-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0maN7bePmrUMQkAu9opvQ
	(envelope-from <cgroups+bounces-17356-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 22:19:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A66CFF75
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 22:19:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cJJDDLVN;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17356-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17356-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F028230179C8
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB53A960F;
	Fri, 26 Jun 2026 20:19:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA12F5A13
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 20:18:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505139; cv=none; b=ecr5l0LzKPFXf+zqfgtT3nhmq52hE1vJagkbbJb28/rc/KTjL3KlTACvl8eku5DI17sj6gkk2K9tR9YzHGEaRmbi5woDFboyM6qf94DHVcW8DS4wF1905e3NDkbnTUaUvdtuWZPsIndzcqaC25zeoHAVehiKktWN0tlK6I5u3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505139; c=relaxed/simple;
	bh=kPGPSVS+tn0YoMexJTZ/d99RoTmnxrVbq42SNtfTZJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuiVJFrU0cD5IimYBJSF4q0JMZwjHod7zXqTfQq5E1KGRkGUY0YJ+qbNpFdoYM27wx0T6wCGXgFp7hE7pIjLHgOX8oCMntNzXMQAsKiR9bbIU9K28IRpy2wDU8HpBjrjZ5IV3k5mBu6AwPV1YoYBdtTWLGxqgiErrgjVzfT3BvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJJDDLVN; arc=none smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-447a81776e9so539413fac.0
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782505137; x=1783109937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGjlyDYhehErqYiWQ+JPN847GkKF9E5lFSL9mEIK8Uc=;
        b=cJJDDLVNUVrquSpapjdOI8avSHT9vDlM+aQzaYGK1LeawpapqpuUteFGGyWNAeE9Zy
         97mRc1GayACVUCl7/hc4pmqtXXEzwEFqvA+uTjJ8jC9e6l/JT3prBG8OZd6dZFkSJ1p1
         r7Yr+/n8N6vYhM7oDzz8SlkCGrAXeoIFpS/OkwLJwhSNWkjDk3XCXibr1Tg2AMcSsfdd
         8MQlpmLY3jgqz2LxCYDJF435YnioYWJj9wDj5h7PdU+3Q0BTGICU6OmsnJftkNFXtU0n
         Jmmab7Eecl/pdP1lvGhtDNV6ZKfGOY45+zb+wIzquSHFcixUgxVcLvV1sXyBDowHkrrG
         bHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782505137; x=1783109937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGjlyDYhehErqYiWQ+JPN847GkKF9E5lFSL9mEIK8Uc=;
        b=KsNfKsae1actXN6zRXKANrCQ0zc5IO8eLFdU8BICntr2cN3DfEQJs8PvsGYi/hgPQi
         FSldFDtX9NaGyro8UQZrhFctFdCKvltf1Q5flsYiDrcAho0DpKM5Wtn4mQf3Ig8QL/ZS
         erAz3VC17fxXvnydd9SxDaKjJtt1wrHaGU7Btei8HCGzCQ5jskng7wDUw0kjK+vhtndD
         LkXR6A152sGWomTd08HKf1BoXoBdF11pDTdClxFS89DViKu1jOI63CokUfpXuBJ1/Axx
         zLR+YQmGZpqxzkZD7ESHLTCR5CF/PN+ENFEwT29JqvPEU7RoTGui1BaN3Aqa7zALRwYJ
         geVg==
X-Forwarded-Encrypted: i=1; AHgh+RrF/nGS62Kl6NYB4bwjSoNNoS0fUOF4z+YwXhgGIEohs8pB/MmnqM73XVU61NVempwfSrNTFvsc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YMmw8rPpqa8Bz911YEwihFJ/Ax1y2gVSLXyl+0x1xi72sspd
	BhUXzBG3ytlo8j4d5zG73H68H23/pK6CmgMwvBsKrpXrVjt+jkSsXLfu
X-Gm-Gg: AfdE7cm1yTlbAwV7FCNmD9jdrG7c1bT1G1Z/YwnxhXMF9AUbDNqrEbM095EEjSs0vVP
	eJpEoIe9ieHptZO2JTcOo0EmT/M20HhYK7QbB3vj2c+4vDcnQ/agUve3cQaQqnrYVPO6c7C9CzS
	P+MUan0XLJrawYqtFX8dDsPJoCA6n3aLwheFQWZAnyGxdDm3gJfKRNrGpchZu1TSK97v4yhfTYy
	lYiNcPlHwEIna1MY8bCZ9ZWEixvEZ5vBHi5gUZaAy8pflyhl7iHmLGZoMFoY661o9E/FtUN+nay
	12r0LwNJiwmGqOItUN2IMzDlFrKMzitCNVVFKB6GnM3RPQXz6UiW6svnualmYNgcVnZK1+bOvKp
	2to+5bWXR8uxz1MUzGOWh78amWbOFKUBqNvDwpQLxl3KfMUml8Ah7Ar7XUtKgRfEuf4JnhYbt2k
	NHnw32UATGvU01MhUmpNC6xAsIT33Qvr+AM741tus/kWU=
X-Received: by 2002:a05:6870:c0d0:b0:441:d09:7f6 with SMTP id 586e51a60fabf-448119a0600mr7118160fac.4.1782505137237;
        Fri, 26 Jun 2026 13:18:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm14027490fac.0.2026.06.26.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:18:56 -0700 (PDT)
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
Subject: Re: [PATCH v4 0/5] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Fri, 26 Jun 2026 13:18:54 -0700
Message-ID: <20260626201855.2966118-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17356-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 370A66CFF75

On Tue, 23 Jun 2026 11:01:18 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> This series is intended for the next release cycle.
> 
> v3 --> v4
> =========
> - Reduced memory footprint by 4x, from 16 bytes per-(cpu x memcg) to
>   4 bytes per-(cpu x memcg). Each page_counter_stock is a thin wrapper
>   around an atomic_t.
> - Removed locking completely and uses atomic operations to use stock.
> - Removed synchronous work_on_cpu. All work is done via remote
>   atomic_xchgs.
> - Added a patch to flatten page_counter charging in try_charge_memcg
> - Split page_counter_try_charge into stocked and non-stocked variants.
> 
> INTRO
> =====
> Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> allocations, allowing small and frequent allocations to avoid walking
> the expensive mem_cgroup hierarchy traversal each time. This fastpath
> offers real improvements, but there is room for improvement:
> 
> 1. Currently, each CPU tracks up to 7 (NR_MEMCG_STOCK) mem_cgroups. When
>    more than 7 mem_cgroups have stock present on a single CPU, a random
>    victim is evicted and its associated stock is drained.
> 
> 2. When one cgroup runs out of memory and needs to drain stock across
>    all CPUs it has stock cached in, those CPUs will drain all other
>    memcgs' stock present in that CPU. This leads to inefficient stock
>    caching and cross-memcg interference under memory pressure.
> 
> 3. Stock management is tightly coupled to struct mem_cgroup, which makes
>    it difficult to add a new page_counter to mem_cgroup and have
>    multiple sources of stock management.
> 
> This series moves the per-cpu stock down into page_counter which
> consolidates stock limit checking and page_counter limit checking into
> page_counter_try_charge_stock. This eliminates the 7 memcg-per-cpu slot
> limit, the random cross-memcg stock drains, and slot traversal. We also
> simplify memcontrol code, since we no longer need to maintain separate
> draining functions or manage the asynchronous workqueue.

Hello,

I just want to address a few things that Sashiko raised. I think there
are definitely some improvements that I can make as Sashiko suggested.

In commit 3/5 mm/page_counter: introduce page_counter_try_charge_stock()
Sashiko raises two concerns.

"Can the per-CPU stock grow unboundedly beyond counter->batch pages here?"

I think this is true. I went back to the original stock design and saw
that when the stock is greater than the batch size, it just drains all
of it (since this means we raced). I can add the same check so that we
never grow beyond the batch size. This should also help with the point
below.

"Does moving the per-CPU cache from a single shared stock to a per-page_counter
stock fundamentally change the memory stranding bounds?"

This is true, and I addressed this in the cover letter. Yes, the worst-case
upper bound grows by quite a bit, but it is difficult to hit that limit
since it would require a memcg process to be scheduled on all the CPUs,
and strand memory there via the stock. Nonetheless, restricting the
batch size should make this worst-case a bit better.

In commit 4/5 mm/memcontrol: convert memcg to use page_counter_stock()
Sashiko also raises two concerns.

"Could this synchronous loop cause cacheline bouncing and premature OOM kills?"

Sashiko is referring to the memcg-cpu iteration we do where we drain the
stock of an entire descendant completely. I also addressed this in the
cover letter and that I couldn't really reproduce the issue in my
testing. I addressed this every version but it seems like Sashiko does
not read the cover letter :' (

"Would doing a volatile read to check if
the stock has pages before calling atomic_xchg() help mitigate this?"

This one I agree with, I'll add:

if (!atomic_read(&stock->nr_pages))
	return;
nr_pages = atomic_xchg(&stock->nr_pages, 0);

And hopefully we can avoid most of the unnecsesary races (of course the
value can still change in between the read and the atomic_xchg but it's
just a best-effort optimization)

So I'll spin up a v5. One thing I'm going back and forth in my mind
is whether we want separate stocked and non-stocked variants, or if
that should just happen transparently within the calls.

Thanks again Sashiko!
Joshua

