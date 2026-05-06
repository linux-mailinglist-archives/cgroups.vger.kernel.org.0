Return-Path: <cgroups+bounces-15643-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBcDGYlR+2mSZQMAu9opvQ
	(envelope-from <cgroups+bounces-15643-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:34:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F2D4DC46F
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E571307D5C3
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287547DFA8;
	Wed,  6 May 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLuzzjcn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EOUSp8x8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLuzzjcn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EOUSp8x8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B846AF0F
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077316; cv=none; b=G99/iXhIAAIIO7quaVJNAiRF1SZhmFPZBto+y+9VVJZbEaeuJJkFWenl2CETjyJ34TpjhoRorz3Jbnl3AHlOvlul3dwfGolcZk17hS+VfptaeEq3liMBsuDFs5G7DKxN9Q0utgPf9RCOjz9h1deDB+T7StpwO1v+GZlr1W8yiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077316; c=relaxed/simple;
	bh=LSmt/T72DjI+ugBXLmd6bhQ5c9vr0phhu+Kbobfwn/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhFgA8cXDtVrIIODE6/yPaMNPr3h7yM7bn6inrvuNO6jVcdELebLytXkw/qvIg2H/plv4+Rq7xU1q/tCTrxen0KC7agSPbtcuvheCzwNzP6UshDuCL6+hmNpJGs2fblHcVyingihIUhQ+XTgj5Ocw3GqdXBAZd4i/8VINd4b2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLuzzjcn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EOUSp8x8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLuzzjcn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EOUSp8x8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51EFF6B886;
	Wed,  6 May 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778077311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzV0dka53ImtdegBi+wfTHA6D9gWMH0wHVJGJOejyi8=;
	b=eLuzzjcn52FHYcnJuAa8ovT0RxEYSQBseM6EK/Bq8dvP9RfuUhGmRj32Y02LeCznSp/PhE
	TjVLESrCt4XuIXrmWDi+1bwbzlcrjmkTvAYkYAT6BttjzaBGz95HKDJTJj5R4r0OMrbbk0
	axad32FREMOy+GwuaPvI6qzeZuyDCxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778077311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzV0dka53ImtdegBi+wfTHA6D9gWMH0wHVJGJOejyi8=;
	b=EOUSp8x8PKwebXxB+GEPBZ+nia5Zaonifslc9vM/BAKx3WxbvzhMon4JPRJOO5reWlWLcu
	mXIA4YmcoPKOMNAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eLuzzjcn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EOUSp8x8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778077311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzV0dka53ImtdegBi+wfTHA6D9gWMH0wHVJGJOejyi8=;
	b=eLuzzjcn52FHYcnJuAa8ovT0RxEYSQBseM6EK/Bq8dvP9RfuUhGmRj32Y02LeCznSp/PhE
	TjVLESrCt4XuIXrmWDi+1bwbzlcrjmkTvAYkYAT6BttjzaBGz95HKDJTJj5R4r0OMrbbk0
	axad32FREMOy+GwuaPvI6qzeZuyDCxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778077311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzV0dka53ImtdegBi+wfTHA6D9gWMH0wHVJGJOejyi8=;
	b=EOUSp8x8PKwebXxB+GEPBZ+nia5Zaonifslc9vM/BAKx3WxbvzhMon4JPRJOO5reWlWLcu
	mXIA4YmcoPKOMNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B4D1593A3;
	Wed,  6 May 2026 14:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bf9yDn9O+2liJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 May 2026 14:21:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6EE3EA069E; Wed, 06 May 2026 16:21:46 +0200 (CEST)
Date: Wed, 6 May 2026 16:21:46 +0200
From: Jan Kara <jack@suse.cz>
To: haghdoost@uber.com
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kshitij Doshi <kshitijd@uber.com>
Subject: Re: [PATCH RFC] memcg: add per-cgroup dirty page controls
 (dirty_ratio, dirty_min)
Message-ID: <pbwzmyglpz33d3k63aopi5vlghz4jmur2k2g4res6mhktuujhh@rmqooz6bqaao>
References: <20260501-rfc-memcg-dirty-v1-v1-1-9a8c80036ec1@uber.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-rfc-memcg-dirty-v1-v1-1-9a8c80036ec1@uber.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 55F2D4DC46F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uber.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15643-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On Fri 01-05-26 22:28:38, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> Add two cgroup v2 memory-controller knobs that bring
> balance_dirty_pages() throttling into per-cgroup scope so one noisy
> writer cannot stall peers sharing the same host:
> 
>   memory.dirty_ratio  Per-cgroup dirty-page ceiling, 0..100 percent of
>                       the cgroup's dirtyable memory.  0 (default) leaves
>                       the cgroup subject to the global threshold only.
> 
>   memory.dirty_min    Guaranteed dirty-page floor, byte value (default 0).
> 
> The two knobs compose: dirty_ratio bounds how much dirty memory a
> cgroup may accrue, dirty_min guarantees a floor below which it is
> never throttled.
> 
> Motivation, design trade-offs, cost analysis, validation data, and
> open questions are in the cover letter.
> 
> Co-developed-by: Kshitij Doshi <kshitijd@uber.com>
> Signed-off-by: Kshitij Doshi <kshitijd@uber.com>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> Assisted-by: Cursor:claude-sonnet-4.5
> ---

Things like motivation actually belong to the changelog itself, measured
results how the patch helps as well. On the other hand stuff like history
is largely irrelevant here, frankly I don't have a bandwidth to carefully
read the huge amount of text LLM has generated below so please try to make
it more concise for next time.

> This RFC adds two cgroup v2 memory-controller knobs that give operators
> per-cgroup control over dirty-page throttling in balance_dirty_pages():
> memory.dirty_ratio (per-cgroup ceiling) and memory.dirty_min (guaranteed
> floor). A third knob, memory.dirty_weight, is forthcoming in a follow-up
> once we have validated the application site (see "Follow-ups" below).
> We are posting this as an RFC, as a single squashed patch, to get design
> feedback before splitting the prototype into a per-logical-change series.
> 
> Motivation
> ==========
> 
> balance_dirty_pages() (BDP) is a global throttle. It sleeps writers
> once the host-wide dirty count crosses a single threshold. On a
> container host that threshold is shared across cgroups. A cgroup
> that dirties pages faster than storage can drain them pushes the
> count over the limit. Every writer on the host then parks in
> io_schedule_timeout() -- including cgroups that have not dirtied a
> single page of their own.
> 
> cgroup v2 already has per-memcg dirty accounting, but that accounting
> does not translate into per-memcg dirty throttling.

Not quite true. We do have per-memcg writeback workers and we do have
per-memcg dirty limits (inferred from global dirty limit tunings) that are
enforced...

> We see this in production: a buffered write-heavy container generates
> multi-second stalls for co-located latency-sensitive workloads.
> Moreover, dirty-page accumulation from a single noisy neighbor is a
> recurring contributor to mount-responsiveness degradation on shared hosts.

... and I quite don't see how a multisecond stalls you are describing would
happen. There is something I must be missing. The throttling works as
follows: Until we cross global freerun limit (that is (background_limit +
dirty_limit) / 2) nobody is throttled. Once we cross it, memcg dirty limits
start to be taken into account. If we are below freerun in the memcg, the
task dirtying folios from that memcg shouldn't be throttled at all, once we
get above freerun we throttle by maximum of throttling delay decided from
global and memcg situation so then long delays can start happening but it
would mean the "innocent" task's memcg had to get at least over the freerun
limit.

So can you perhaps share more details about the configuration where you
observe these delays to innocent tasks due to another task dirtying a lot of
memory? How many page cache in total and dirty pages are there in each
memcg (both for the aggressive dirtier and wrongly delayed task)? Is the
delayed task really throttled in balance_dirty_pages()?

								Honza


> Prior work
> ==========
> 
> Per-memcg dirty-page limits have been proposed before. Andrea Righi
> posted an initial RFC in February 2010 [1]; Greg Thelen continued the
> work through v9 in August 2011 [2]. That series added per-memcg dirty
> counters and hooked them into balance_dirty_pages(), but it bolted
> per-cgroup limits onto the global writeback path without making
> writeback itself cgroup-aware. Without cgroup-aware flusher threads,
> a cgroup exceeding its limit triggered writeback of inodes from any
> cgroup, giving poor isolation. The series was not merged.
> 
> Konstantin Khlebnikov posted "[PATCHSET RFC 0/6] memcg: inode-based
> dirty-set controller" in January 2015 [4], which proposed
> memory.dirty_ratio (the same interface name this series uses) via an
> inode-tagged, filtered-writeback approach. Tejun Heo reviewed it
> and rejected it as a "dead end" that duplicated lower-layer policy
> without solving the underlying isolation problem; this rejection
> directly motivated Tejun's native cgwb rework described below.
> 
> Tejun Heo's 48-patch cgroup-writeback rework, merged in Linux 4.2
> (commit e4bc13adfd01, "Merge branch 'for-4.2/writeback'"), took the
> different approach of restructuring writeback to be natively
> cgroup-aware: per-memcg wb_domain (commit 841710aa6e4a), per-memcg
> NR_FILE_DIRTY / NR_WRITEBACK accounting, and cgroup-aware flusher
> threads [3]. That work deliberately deferred user-facing policy knobs.
> This series adds the policy surface that consumes Tejun's
> infrastructure. The dirty_min reservation concept is, to our
> knowledge, new.
> 
> A November 2023 LKML thread by Chengming Zhou [5] independently
> identified the identical throttling regression on cgroup v2 (a 5 GB
> container constantly throttled because memory.max * dirty_ratio yields
> too small a threshold for bursty workloads). Jan Kara participated and
> endorsed a bytes-based per-memcg dirty limit; no patches followed that
> discussion, confirming the gap this series fills.
> 
> [1] https://lwn.net/Articles/408349/
> [2] https://lore.kernel.org/lkml/1313597705-6093-1-git-send-email-gthelen@google.com/
> [3] https://lwn.net/Articles/648292/
> [4] https://lore.kernel.org/all/20150115180242.10450.92.stgit@buzz/
> [5] https://lore.kernel.org/all/109029e0-1772-4102-a2a8-ab9076462454@linux.dev/
> 
> Proposed interface
> ==================
> 
> Two new cgroup v2 files under the memory controller, absent on the root
> cgroup (CFTYPE_NOT_ON_ROOT):
> 
> memory.dirty_ratio
>   Integer [0, 100]. Per-cgroup dirty-page ceiling as a percentage of
>   the cgroup's dirtyable memory (mdtc->avail: file cache plus
>   reclaimable slack), the same base the global vm_dirty_ratio scales
>   against. 0 (the default) disables the per-cgroup ceiling and leaves
>   the cgroup subject to the global threshold only. A non-zero value
>   that is stricter than vm_dirty_ratio overrides the global ratio for
>   this cgroup via min(mdtc->thresh, cg_thresh); because both sides
>   scale off the same base, the knob can never widen the cgroup past
>   the global ceiling. A memory.dirty_bytes companion for byte-precise
>   caps (mirroring vm_dirty_bytes) is noted under "Follow-ups" below.
>   The prototype reads the value for the immediate memcg only;
>   hierarchical enforcement (clamping against ancestors, like
>   memory.max) is not implemented yet. We would like guidance on
>   whether this is required for v1 or can follow in a subsequent
>   series.
> 
> memory.dirty_min
>   Byte value (K/M/G suffixes accepted), default 0 (no reservation).
>   Guaranteed dirty-page floor: while cgroup_dirty < dirty_min,
>   throttling is bypassed (goto free_running). Lets a latency-sensitive
>   cgroup buffer a small write burst even under global dirty pressure.
> 
>   dirty_min is an admission guarantee, so we have to prevent it from
>   breaking the global dirty invariant. Two aspects:
> 
>    - Global cap. The sum of dirty_min reservations across all cgroups
>      must not exceed a fraction of the global dirty threshold (our
>      working number is 80%), so the system always retains some shared
>      capacity. The prototype does not enforce this cap yet; we expect
>      to either reject at write() time or clamp on read in a cheap
>      precomputed effective_dirty_min. We would appreciate feedback on
>      which approach the cgroup maintainers prefer.
> 
>    - Per-cgroup cap. A cgroup should not be able to reserve more dirty
>      capacity than it can hold. Our tentative rule is
>      effective_dirty_min = min(dirty_min, memory.max - memory.min),
>      evaluated at enforcement time so it tracks live memory.max changes,
>      rather than rejected at write. This is similar to how memory.low
>      composes with memory.max.
> 
>   Neither cap is implemented in the prototype; both would land before
>   a non-RFC posting.
> 
> The two knobs compose: dirty_ratio bounds how much dirty memory a
> cgroup may accrue, dirty_min guarantees a floor below which it is never
> throttled.
> 
> Test setup and results
> ======================
> 
> To show the problem and the fix, we built a single reproducer that runs
> on an unmodified stock kernel and then on the patched kernel, using the
> same setup for both.
> 
> Setup: QEMU guest with a virtio-blk disk throttled to 256 KB/s
> (bps_wr=262144). Two sibling cgroups, no io.weight; both share disk
> bandwidth equally. dirty_bytes=32MB, dirty_background_bytes=16MB
> (freerun = 24 MB). Files pre-allocated with fallocate before dirty
> pressure. Two phases per run: (1) victim alone (baseline), (2) noisy
> fills global dirty to the 32 MB cap, then victim runs contended for
> 30 s.
> 
>   - noisy:  single fio job, unlimited write rate, fills global dirty pool.
>   - victim: single fio job, rate-limited to 500 KB/s (128 IOPS target),
>             4 KiB sequential write().
> 
> The high freerun (24 MB) ensures victim's solo dirty accumulation
> (244 KB/s x 30 s = 7.3 MB) stays below the threshold. BDP does not fire
> during the solo phase on either kernel, giving identical baselines.
> 
> Stock kernel results (the problem):
> 
>                        solo (no contention)  contended  inflation
>   victim IOPS          125                   5.1        24.5x worse
>   victim p99           0.6 ms                152 ms     253x worse
> 
> The contended p99 sits at fio's percentile bucket nearest MAX_PAUSE =
> HZ/5 = 200 ms (mm/page-writeback.c:49), the hard kernel ceiling on BDP
> sleep. The victim has near-zero dirty pages of its own but is forced to
> sleep because balance_dirty_pages() sees gdtc->dirty = NR_FILE_DIRTY +
> NR_WRITEBACK above the freerun threshold. Most of noisy's pages are
> queued in NR_WRITEBACK waiting for the throttled disk.
> memory.events.local on both cgroups shows max 0 throughout the run;
> this is not memory pressure inside either cgroup.
> 
> Patched kernel results (the fix), with victim/memory.dirty_min = 16 MB:
> 
>                        solo (no contention)  contended  inflation
>   victim IOPS          125                   125        1.0x
>   victim p99           0.9 ms                0.7 ms     1.0x
> 
> The patched kernel checks cgroup_dirty < dirty_min (4096 pages) before
> computing any sleep. Because the rate-limited victim's resident dirty
> set stays well below the reservation, the check fires on every write()
> -> goto free_running -> write() returns in ~7 us. The victim is fully
> protected.
> 
> The figures above are the per-kernel medians of N=5 iterations and
> reflect a deterministic outcome on every iter: stock had cont_iops in
> 4.4..6.1 (retention 0.035..0.049) on all five iters, patched had
> cont_iops = 125.0 (retention = 1.000) on all five iters. The 5/5 stock
> iters all hit BDP's throttled regime; the 5/5 patched iters all
> bypassed it via the dirty_min check.
> 
> Implementation
> ==============
> 
> The patch touches five files:
> 
>   - include/linux/memcontrol.h: two new fields on struct mem_cgroup
>     (dirty_ratio, dirty_min).
>   - include/linux/writeback.h: a per-pass cg_dirty_cap field on
>     struct dirty_throttle_control used to publish the memcg clamp to
>     BDP's setpoint and rate-limit math.
>   - include/trace/events/writeback.h: cg_dirty_cap added to the
>     balance_dirty_pages tracepoint so operators can distinguish the
>     memcg clamp from the global dirty_limit at runtime.
>   - mm/memcontrol.c: registers the two cgroup v2 files with input
>     validation.
>   - mm/page-writeback.c: the throttling changes.
> 
> The key changes in page-writeback.c:
> 
>   - The dirty_ratio clamp lives inside domain_dirty_limits(), keyed
>     on wb->memcg_css (the inode owner's memcg).  Every consumer of
>     the memcg dtc -- writer throttle, flusher kworker,
>     cgwb_calc_thresh -- sees the same clamped thresh and bg_thresh.
>     The clamp uses mult_frac() so a small memcg does not collapse
>     to a zero ceiling.
> 
>   - The dirty_min bypass lives in balance_dirty_pages() and is
>     writer-keyed: the writing task's memcg is looked up under RCU,
>     and when its dirty+in-flight backlog is below dirty_min the
>     loop jumps to free_running, bypassing both the global and the
>     per-memcg BDP gates.  dirty_min is an admission guarantee for
>     the writer's own cgroup, not for inode owners.
> 
>   - When the clamp engages, mdtc->dirty is replaced with the
>     memcg-wide NR_FILE_DIRTY + NR_WRITEBACK sum so freerun /
>     setpoint / rate-limit smoothing see the real backlog and pages
>     migrating from NR_FILE_DIRTY into NR_WRITEBACK cannot silently
>     widen the cap.
> 
> Fast-path cost when neither knob is set: one rcu_read_lock/unlock
> pair plus a READ_ONCE(dirty_min) per balance_dirty_pages()
> iteration, and one READ_ONCE(dirty_ratio) per domain_dirty_limits()
> call.  The memcg counter reads are gated on "knob armed" and do
> not fire on the default path.  We have not measured the added
> cost yet, but we expect it to be in the noise of existing BDP
> bookkeeping.  A tight pwrite() microbenchmark will confirm this
> before a non-RFC posting.
> 
> Scope
> =====
> 
> This series affects the writer-side throttle (balance_dirty_pages())
> only. It does not partition the flusher-side writeback queue. A
> cgroup's fsync() can still block behind inodes from other cgroups in
> writeback_sb_inodes(). We document this limit explicitly and expect
> writeback-queue partitioning to be a separate, larger effort.
> 
> Interaction with block-layer throttles
> ======================================
> 
> The two knobs are orthogonal to io.max / io.cost. balance_dirty_pages()
> runs before the bio reaches the block layer, so dirty_min simply allows
> a cgroup to keep accepting write() syscalls up to its reservation; the
> actual I/O is still subject to whatever block throttle is in effect. In
> the reproducer above, the disk-level bandwidth limit (256 KB/s) is
> applied at the QEMU virtio-blk layer, and the protected victim dirties
> roughly equal to the rate it can drain, so the block throttle is
> exercised on both kernels. We have not yet tested interaction with
> guest-side io.max settings; this is on the list before a non-RFC
> posting.
> 
> Questions for maintainers
> =========================
> 
>  1. Is writer-throttle-only scope (no flusher/writeback-queue work)
>     acceptable for the first series?
>  2. Does dirty_ratio belong on struct mem_cgroup (as the prototype
>     has it) or on the memcg's wb_domain? Routing it through wb_domain
>     would let us reuse __wb_calc_thresh() and keep all threshold
>     policy in one place; a possible split is dirty_ratio on wb_domain
>     (it is threshold policy), dirty_min on the memcg (throttle
>     bypass). We can go either way.
>  3. For dirty_min safety caps (per-cgroup and global sum), which
>     approach do you prefer: reject at write time, or clamp on read in
>     an effective_dirty_min?
>  4. Is hierarchical enforcement of dirty_ratio (clamp against
>     ancestors) required for v1, or can it follow in a subsequent
>     series?
> 
> What's missing before a non-RFC posting
> =======================================
> 
>   - Split the monolithic prototype into a proper series (one patch per
>     concept + Documentation + selftest).
>   - Documentation/admin-guide/cgroup-v2.rst entries for both knobs.
>   - tools/testing/selftests/cgroup/ test for interface surface and
>     noisy-neighbor protection.
>   - Implement the per-cgroup and global dirty_min safety caps described
>     in the memory.dirty_min bullet.
>   - Fast-path microbenchmark: confirm zero measurable regression for
>     cgroups that have neither knob set.
>   - Larger-N validation on real hardware (the current N=5 data is from
>     a QEMU guest on a throttled virtio-blk).
> 
> Follow-ups (out of scope for this series)
> =========================================
> 
>   - memory.dirty_weight: a priority weight knob that scales the BDP
>     pause length, planned as a separate series. The prototype validated
>     the interface surface but the application site (post-pause scaling
>     vs. folding into pos_ratio / dirty_ratelimit) needs to be settled
>     before we ship it. Happy to discuss in advance of that posting.
>   - memory.dirty_bytes: a byte-value companion to memory.dirty_ratio,
>     mirroring the global vm_dirty_bytes. For operators who want a
>     byte-predictable per-cgroup dirty cap rather than a ratio of the
>     cgroup's dirtyable memory. We have not prototyped this yet; we
>     are listing it so reviewers know it is on the roadmap, since
>     the ratio-only interface omits that use case.
>   - Writeback-queue partitioning: flusher-side fairness across
>     cgroups, as noted in Scope above.
> 
> Looking forward to feedback.
> 
> Thanks,
> Alireza Haghdoost <haghdoost@uber.com>
> Kshitij Doshi <kshitijd@uber.com>
> ---
>  include/linux/memcontrol.h       |  10 +++
>  include/linux/writeback.h        |   4 +
>  include/trace/events/writeback.h |   5 +-
>  mm/memcontrol.c                  |  62 ++++++++++++++
>  mm/page-writeback.c              | 179 ++++++++++++++++++++++++++++++++++++---
>  5 files changed, 249 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index dc3fa687759b..45ca949a4c68 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -323,6 +323,16 @@ struct mem_cgroup {
>  	spinlock_t event_list_lock;
>  #endif /* CONFIG_MEMCG_V1 */
>  
> +	/* Per-memcg dirty-page controls (memory.dirty_ratio, memory.dirty_min) */
> +	/*
> +	 * dirty_ratio: [0, 100] percent of dirtyable memory (mdtc->avail),
> +	 *   matching the global vm_dirty_ratio base; 0 inherits the global
> +	 *   threshold.
> +	 * dirty_min:   dirty-page reservation, in pages; 0 disables the bypass.
> +	 */
> +	unsigned int dirty_ratio;
> +	unsigned long dirty_min;
> +
>  	struct mem_cgroup_per_node *nodeinfo[];
>  };
>  
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 62552a2ce5b9..e37632f728be 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -318,6 +318,10 @@ struct dirty_throttle_control {
>  	unsigned long		thresh;		/* dirty threshold */
>  	unsigned long		bg_thresh;	/* dirty background threshold */
>  	unsigned long		limit;		/* hard dirty limit */
> +	unsigned long		cg_dirty_cap;	/* per-memcg dirty_ratio clamp for
> +						 * this pass, or PAGE_COUNTER_MAX
> +						 * when no memcg clamp applies
> +						 */
>  
>  	unsigned long		wb_dirty;	/* per-wb counterparts */
>  	unsigned long		wb_thresh;
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index bdac0d685a98..0bf86b3c903c 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -672,6 +672,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		__array(	 char,	bdi, 32)
>  		__field(u64,		cgroup_ino)
>  		__field(unsigned long,	limit)
> +		__field(unsigned long,	cg_dirty_cap)
>  		__field(unsigned long,	setpoint)
>  		__field(unsigned long,	dirty)
>  		__field(unsigned long,	wb_setpoint)
> @@ -691,6 +692,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
>  
>  		__entry->limit		= dtc->limit;
> +		__entry->cg_dirty_cap	= dtc->cg_dirty_cap;
>  		__entry->setpoint	= (dtc->limit + freerun) / 2;
>  		__entry->dirty		= dtc->dirty;
>  		__entry->wb_setpoint	= __entry->setpoint *
> @@ -710,13 +712,14 @@ TRACE_EVENT(balance_dirty_pages,
>  
>  
>  	TP_printk("bdi %s: "
> -		  "limit=%lu setpoint=%lu dirty=%lu "
> +		  "limit=%lu cg_dirty_cap=%lu setpoint=%lu dirty=%lu "
>  		  "wb_setpoint=%lu wb_dirty=%lu "
>  		  "dirty_ratelimit=%lu task_ratelimit=%lu "
>  		  "dirtied=%u dirtied_pause=%u "
>  		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%llu",
>  		  __entry->bdi,
>  		  __entry->limit,
> +		  __entry->cg_dirty_cap,
>  		  __entry->setpoint,
>  		  __entry->dirty,
>  		  __entry->wb_setpoint,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f..c43fe4f394eb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4748,6 +4748,56 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static int memory_dirty_ratio_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +
> +	seq_printf(m, "%u\n", READ_ONCE(memcg->dirty_ratio));
> +	return 0;
> +}
> +
> +static ssize_t memory_dirty_ratio_write(struct kernfs_open_file *of,
> +					char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned int ratio;
> +	int err;
> +
> +	err = kstrtouint(strstrip(buf), 0, &ratio);
> +	if (err)
> +		return err;
> +
> +	if (ratio > 100)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(memcg->dirty_ratio, ratio);
> +	return nbytes;
> +}
> +
> +static int memory_dirty_min_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +
> +	/* seq_puts_memcg_tunable automatically multiplies by PAGE_SIZE for the user */
> +	return seq_puts_memcg_tunable(m, READ_ONCE(memcg->dirty_min));
> +}
> +
> +static ssize_t memory_dirty_min_write(struct kernfs_open_file *of,
> +				      char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned long dirty_min;
> +	int err;
> +
> +	/* page_counter_memparse converts strings like "512M" into a page count */
> +	err = page_counter_memparse(strstrip(buf), "max", &dirty_min);
> +	if (err)
> +		return err;
> +
> +	WRITE_ONCE(memcg->dirty_min, dirty_min);
> +	return nbytes;
> +}
> +
>  /*
>   * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
>   * if any new events become available.
> @@ -4950,6 +5000,18 @@ static struct cftype memory_files[] = {
>  		.flags = CFTYPE_NS_DELEGATABLE,
>  		.write = memory_reclaim,
>  	},
> +	{
> +		.name = "dirty_ratio",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = memory_dirty_ratio_show,
> +		.write = memory_dirty_ratio_write,
> +	},
> +	{
> +		.name = "dirty_min",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = memory_dirty_min_show,
> +		.write = memory_dirty_min_write,
> +	},
>  	{ }	/* terminate */
>  };
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 88cd53d4ba09..2847b2c1e59a 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -124,14 +124,17 @@ struct wb_domain global_wb_domain;
>  
>  #define GDTC_INIT(__wb)		.wb = (__wb),				\
>  				.dom = &global_wb_domain,		\
> -				.wb_completions = &(__wb)->completions
> +				.wb_completions = &(__wb)->completions,	\
> +				.cg_dirty_cap = PAGE_COUNTER_MAX
>  
> -#define GDTC_INIT_NO_WB		.dom = &global_wb_domain
> +#define GDTC_INIT_NO_WB		.dom = &global_wb_domain,		\
> +				.cg_dirty_cap = PAGE_COUNTER_MAX
>  
>  #define MDTC_INIT(__wb, __gdtc)	.wb = (__wb),				\
>  				.dom = mem_cgroup_wb_domain(__wb),	\
>  				.wb_completions = &(__wb)->memcg_completions, \
> -				.gdtc = __gdtc
> +				.gdtc = __gdtc,				\
> +				.cg_dirty_cap = PAGE_COUNTER_MAX
>  
>  static bool mdtc_valid(struct dirty_throttle_control *dtc)
>  {
> @@ -183,8 +186,9 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>  
>  #define GDTC_INIT(__wb)		.wb = (__wb),                           \
> -				.wb_completions = &(__wb)->completions
> -#define GDTC_INIT_NO_WB
> +				.wb_completions = &(__wb)->completions,	\
> +				.cg_dirty_cap = PAGE_COUNTER_MAX
> +#define GDTC_INIT_NO_WB		.cg_dirty_cap = PAGE_COUNTER_MAX
>  #define MDTC_INIT(__wb, __gdtc)
>  
>  static bool mdtc_valid(struct dirty_throttle_control *dtc)
> @@ -392,6 +396,58 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>  		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
>  		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
>  	}
> +
> +	/*
> +	 * Apply the per-memcg dirty_ratio clamp on mdtc (gdtc != NULL
> +	 * iff @dtc is a memcg dtc).  dirty_ratio is scaled against
> +	 * the memcg's own dirtyable memory (@available_memory), matching
> +	 * the semantics of vm_dirty_ratio so the two knobs share a base
> +	 * and compose via a plain min() on thresh.  The clamp is keyed
> +	 * on wb->memcg_css (the inode-owner's memcg) rather than on
> +	 * current's memcg, so balance_dirty_pages(), wb_over_bg_thresh()
> +	 * (flusher kworker context), and cgwb_calc_thresh() all see the
> +	 * same clamped value.
> +	 *
> +	 * Published on dtc->cg_dirty_cap as well so hard_dirty_limit()
> +	 * callers in balance_dirty_pages() can ignore the slower
> +	 * dom->dirty_limit smoothing when deriving setpoint/
> +	 * rate-limit from the clamped ceiling.
> +	 *
> +	 * Clamp is applied after the rt/dl boost: dirty_ratio is a
> +	 * strict override, not widened by priority.  bg_thresh is
> +	 * scaled by the same factor we apply to thresh so the
> +	 * user-configured bg/thresh ratio survives clamping instead
> +	 * of snapping to thresh/2 via the bg_thresh >= thresh guard
> +	 * below.  mult_frac() preserves precision for small memcgs
> +	 * where a plain "(avail / 100) * ratio" would collapse to 0.
> +	 */
> +	if (gdtc) {
> +		struct mem_cgroup *memcg =
> +			mem_cgroup_from_css(dtc->wb->memcg_css);
> +		unsigned int cg_ratio = memcg ?
> +			READ_ONCE(memcg->dirty_ratio) : 0;
> +
> +		/*
> +		 * dtc is reused across balance_dirty_pages() iterations,
> +		 * so reset the published clamp every call -- an admin
> +		 * clearing memory.dirty_ratio mid-flight must take effect
> +		 * on the next pass.
> +		 */
> +		dtc->cg_dirty_cap = PAGE_COUNTER_MAX;
> +
> +		if (cg_ratio) {
> +			unsigned long cg_thresh = mult_frac(available_memory,
> +							    cg_ratio, 100);
> +
> +			if (cg_thresh < thresh) {
> +				bg_thresh = mult_frac(bg_thresh, cg_thresh,
> +						      thresh);
> +				thresh = cg_thresh;
> +				dtc->cg_dirty_cap = cg_thresh;
> +			}
> +		}
> +	}
> +
>  	/*
>  	 * Dirty throttling logic assumes the limits in page units fit into
>  	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
> @@ -1065,7 +1121,9 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>  	struct bdi_writeback *wb = dtc->wb;
>  	unsigned long write_bw = READ_ONCE(wb->avg_write_bandwidth);
>  	unsigned long freerun = dirty_freerun_ceiling(dtc->thresh, dtc->bg_thresh);
> -	unsigned long limit = dtc->limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
> +	unsigned long limit = dtc->limit = min(hard_dirty_limit(dtc_dom(dtc),
> +							       dtc->thresh),
> +					       dtc->cg_dirty_cap);
>  	unsigned long wb_thresh = dtc->wb_thresh;
>  	unsigned long x_intercept;
>  	unsigned long setpoint;		/* dirty pages' target balance point */
> @@ -1334,7 +1392,8 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
>  	struct bdi_writeback *wb = dtc->wb;
>  	unsigned long dirty = dtc->dirty;
>  	unsigned long freerun = dirty_freerun_ceiling(dtc->thresh, dtc->bg_thresh);
> -	unsigned long limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
> +	unsigned long limit = min(hard_dirty_limit(dtc_dom(dtc), dtc->thresh),
> +				  dtc->cg_dirty_cap);
>  	unsigned long setpoint = (freerun + limit) / 2;
>  	unsigned long write_bw = wb->avg_write_bandwidth;
>  	unsigned long dirty_ratelimit = wb->dirty_ratelimit;
> @@ -1822,22 +1881,122 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  	int ret = 0;
>  
>  	for (;;) {
> +		unsigned long cg_dirty_min = 0;
> +		unsigned long cg_dirty_pages = 0;
>  		unsigned long now = jiffies;
>  
>  		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
>  
>  		balance_domain_limits(gdtc, strictlimit);
> +
> +		/*
> +		 * Under RCU, snapshot the current memcg's memory.dirty_min
> +		 * reservation.  When it is non-zero, also snapshot the
> +		 * memcg-wide dirty backlog.  These feed the per-writer
> +		 * dirty_min bypass below; the dirty_ratio clamp itself
> +		 * is applied inside domain_dirty_limits() keyed on
> +		 * wb->memcg_css so balance_dirty_pages(),
> +		 * wb_over_bg_thresh() (flusher kworker context), and
> +		 * cgwb_calc_thresh() all see a consistent clamped
> +		 * threshold.
> +		 *
> +		 * rcu_read_lock() is held only for the __rcu dereference
> +		 * of current->cgroups; the memcg pointer does not escape
> +		 * the critical section.  The counter read matches
> +		 * domain_dirty_avail(mdtc, true) so the bypass compares
> +		 * the same dirty+in-flight backlog the global path uses.
> +		 */
> +		rcu_read_lock();
> +		{
> +			struct mem_cgroup *memcg =
> +				mem_cgroup_from_task(current);
> +
> +			if (memcg) {
> +				cg_dirty_min = READ_ONCE(memcg->dirty_min);
> +				if (cg_dirty_min)
> +					cg_dirty_pages =
> +						memcg_page_state(memcg,
> +								 NR_FILE_DIRTY) +
> +						memcg_page_state(memcg,
> +								 NR_WRITEBACK);
> +			}
> +		}
> +		rcu_read_unlock();
> +
>  		if (mdtc) {
>  			/*
> -			 * If @wb belongs to !root memcg, repeat the same
> -			 * basic calculations for the memcg domain.
> +			 * For !root memcg, repeat the same three-step
> +			 * sequence as balance_domain_limits(gdtc):
> +			 * avail -> limits -> freerun.  We inline it here
> +			 * so we can insert the mdtc->dirty override
> +			 * between step 2 (domain_dirty_limits, which
> +			 * publishes the per-memcg dirty_ratio clamp on
> +			 * cg_dirty_cap) and step 3 (domain_dirty_freerun,
> +			 * which consumes mdtc->dirty along with
> +			 * thresh/bg_thresh).
> +			 */
> +			domain_dirty_avail(mdtc, true);
> +			domain_dirty_limits(mdtc);
> +
> +			/*
> +			 * When the dirty_ratio clamp engaged, replace the
> +			 * per-wb dirty count from mem_cgroup_wb_stats()
> +			 * with the memcg-wide NR_FILE_DIRTY + NR_WRITEBACK
> +			 * sum so freerun, the setpoint, and the rate-limit
> +			 * smoothing see the true memcg backlog instead of
> +			 * the subset that has migrated to this cgwb (cgwb
> +			 * migration is lazy and can lag by many seconds),
> +			 * and so a burst of buffered writes cannot silently
> +			 * bypass the clamp by shifting pages from
> +			 * NR_FILE_DIRTY into NR_WRITEBACK.
> +			 *
> +			 * Keyed on wb->memcg_css to match the clamp itself.
> +			 * The cgwb holds a css reference, so the memcg
> +			 * pointer is stable without additional locking.
> +			 *
> +			 * Caveat: memcg_page_state() aggregates across ALL
> +			 * backing devices owned by this memcg, while mdtc
> +			 * is scoped to one wb.  A writer to a fast BDI may
> +			 * observe backlog accumulated on slow BDIs in the
> +			 * same memcg and throttle more than strictly needed.
> +			 * Accepted for v1; the alternative (summing per-wb
> +			 * dirty across the memcg's cgwbs) walks the cgwb
> +			 * list under RCU on a hot path.
>  			 */
> -			balance_domain_limits(mdtc, strictlimit);
> +			if (mdtc->cg_dirty_cap != PAGE_COUNTER_MAX) {
> +				struct mem_cgroup *wb_memcg =
> +					mem_cgroup_from_css(mdtc->wb->memcg_css);
> +
> +				if (wb_memcg)
> +					mdtc->dirty =
> +						memcg_page_state(wb_memcg,
> +								 NR_FILE_DIRTY) +
> +						memcg_page_state(wb_memcg,
> +								 NR_WRITEBACK);
> +			}
> +
> +			domain_dirty_freerun(mdtc, strictlimit);
>  		}
>  
>  		if (nr_dirty > gdtc->bg_thresh && !writeback_in_progress(wb))
>  			wb_start_background_writeback(wb);
>  
> +		/*
> +		 * dirty_min bypass: when the current memcg's dirty+in-flight
> +		 * backlog is below its memory.dirty_min reservation, let the
> +		 * writer proceed without throttling.  This check must live
> +		 * outside the if (mdtc) block because a writer's file may not
> +		 * yet have been migrated to a cgwb; without cgwb, mdtc is NULL
> +		 * and the per-memcg block above is skipped entirely.
> +		 *
> +		 * cg_dirty_min and cg_dirty_pages come from the per-iteration
> +		 * snapshot taken above under rcu_read_lock; both are stored
> +		 * in pages (page_counter_memparse converts bytes -> pages for
> +		 * dirty_min), so no unit conversion is needed.
> +		 */
> +		if (cg_dirty_min && cg_dirty_pages < cg_dirty_min)
> +			goto free_running;
> +
>  		/*
>  		 * If memcg domain is in effect, @dirty should be under
>  		 * both global and memcg freerun ceilings.
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260501-rfc-memcg-dirty-v1-ed4644c3fa8a
> 
> Best regards,
> -- 
> Alireza Haghdoost <haghdoost@uber.com>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

