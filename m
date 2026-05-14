Return-Path: <cgroups+bounces-15927-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IdJBT5LBWreUQIAu9opvQ
	(envelope-from <cgroups+bounces-15927-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:10:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13153D8E8
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD58D3031CE8
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EE3A7F47;
	Thu, 14 May 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="K8c0tnOQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED312DB7B8
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731832; cv=pass; b=ldZJl8+Bz/ybuFwwUWKDOPurKUWYtvLyjNwMK2XCidgSmNpawIkMw/cdmlp3zNrJs+0pjYAPp7tFrjYYTbMmphkc/tJHEAz2ivjrGUNm4tzXqV8ir+ogxEeNeFgW+QBE0wcjb/FEBH4zSpnqp39PDeFygQWNVcSwIs/TIHTRMi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731832; c=relaxed/simple;
	bh=JVPabDDdvKrn7EBLPEmOyiSJdaBZOZuyzIIogirfsgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1hCnLBLbskgnQis2k9k0Kdy9ro7eh4YKdpHfJAQVP9KaL+L9joK/vC9PgDjq59PswWRZNlTkDRBZr4g4j2kTFPPAU7pxrrVyv/VhIkFOa0ZA1ZNmUsiRyF+hUG5iNVY70607wD+a7yICzIPmVHW2FDyGfqweJYadt/xsRYKB+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=K8c0tnOQ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso1213214a12.3
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 21:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778731830; cv=none;
        d=google.com; s=arc-20240605;
        b=UH/u7YyRNPA9QlJj22Y4whnWXKTLU9ke6skhGysqX5evSnFpElc8jg/LH+BdZbdjHi
         SWU6lTq2mmRIUUZr1t1B18dBrn3AoZeLSLm9w+M040gMCxe266pPwncM++7vW2qO+rTl
         VaXPQYkEprEbX0DAjA7dbFY/Ai+bByVK9RBk8fN/SBl66yFxHtwKkx3kcUXrM22zl2v8
         210GAsp5xD2+NHvD1tpcY4sXSwsRa6v0M/zpBlMgDHbAU25wyZdA8upPvDaSlVIeswHM
         Clj0gmi5D3ffNG93zoIetDsaU38bDcpk2LCv/SRn1ZdaGeAIm/DsugvsIbwaFq14fL3z
         RzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IZyvinl3RBbw0wPTvpYB5i7OkQNZ8q30qzuT9enN60E=;
        fh=DMCDlTe0Ic/oXZZET55bqoLBfPHZYdr8CDuZNXHRtwQ=;
        b=CDZYtSCSK4KmpJfjOYsSS0ATuWTghzeO4BwxjKBgWyRgMOgKm04ncJDuUL06LKa7ht
         Vllk8iqXy8A2Kz6wfKZ3DtuKGkMen4Tc9O2siuLeHd9CN3emKGHTY8l4F5fccwLX3jk/
         NnT3njJH6tO+1vTZ9cOzSpF4bJ08GqEuo3QucrDCIHcI/EnvcSUuFBZOFukhPCHex7Qa
         sIVyXCiWAuImV9zBYNUU1X7gO7bjfHsYSNiVGwZtVtRhMGOcGw1H6EubiqzFpAKJxxRS
         8f0dEvmk7wrK1k2gywNgED2g9xl4iQ+JeJMmNoFazvZ9g6/1jDFLycyQ8UnXVRQmwQzT
         C84A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1778731830; x=1779336630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZyvinl3RBbw0wPTvpYB5i7OkQNZ8q30qzuT9enN60E=;
        b=K8c0tnOQLhYaTS8okfAQ5cEJTL9+VNQ4KIPaZLw+Y+RLY0pCKPhN+4bqsoolkPRuY/
         SfHtq+uGC2DNpQ3v//a+5HWYEiuGCQvGU50GuudpoNnJVuJJBKqAf8nwkqcVThQ3pnm3
         S0sM7zKm/ChGa1icP4xnRYb5iz61VMJq4dWUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731830; x=1779336630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZyvinl3RBbw0wPTvpYB5i7OkQNZ8q30qzuT9enN60E=;
        b=CwrhiAiet/vF+9rJ7HNXQfk7Hex2fFNB3RAif4+qf1Gr01OlDt1ZfR/bdlkZru+7Se
         UBoeCLOE8bmvOWv1I/iEEZITi/sr7KhBYUoNsO6wl8JU1PUgwnHA8E+BSdbGRNat/1Wi
         3MT1Na/4cabVzCCflE5C3UtjjTa+PwlhUqVDVk2wGFQ92vPxtO41Q5+zIleMTIbFn6B3
         Fp2gsLAKrm+2AHazM7Mn2e/vtl6phz6PiBCXaAemCezVAZCUCP4GJu9giv2vV2estmRF
         sxeiEYJ3Kq/K5fVVh/f76ny+0Js6gHI1Xm5QLvLIbNgkNMYEjJj6YFV0xN+xMETa7dF0
         W4zA==
X-Forwarded-Encrypted: i=1; AFNElJ/btQ5CuDO3JD2S0v3zkSEGwMWsDYhViFnKNbBQBF4RNPEd8UDd0YFJZKOrPDy33ISvDQMgiEX6@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2dfmqIVPHPit+TVj9yudChfmx7leOSmifh/AIRas0RXqP73J
	BJvkRx4SXArS44ibYX9r8yRZ7mxgDvfve/pkyq3rCha5e7gaYw6AsAqvwxrkbyCl2KoZL7n49Ey
	WBufzwGFJdFwfKfvfSwXfgRXaEgr4JqG8lJVdLM7W+w==
X-Gm-Gg: Acq92OFFCanqO6XVZU+PzUD3Ta5j76VLJgEzqRoI9GiscBvHEPy2MmdEf5eOL2rioB5
	g4wil1l97NKhAvoBPfI2GzVx6zOKjHTsIQOkbZwc7C8mNHaLZeMqCLhSlRLJGUPT8xWC7pK0RMx
	Gt1jU1yaHBYhmqKYwcqEeGpkAgbLkHAapAkT4GPrapZiD2Y2pzAHJd1Mmuj4Vqbvxu/dIzN7FtE
	qrfNQv614NV15xj4YKOg7lIOqgoJtdwo8UgG//8tTxPQ0iR3p4HFrYvPNZkqkxPIJ+/su9XdmbD
	6CoO75OOakEeVQ/BgtnGFvqT6kCwctfkOX+ZUBhg
X-Received: by 2002:a05:6402:4284:b0:67c:2674:a57 with SMTP id
 4fb4d7f45d1cf-682a64e44ddmr3155758a12.0.1778731829214; Wed, 13 May 2026
 21:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501-rfc-memcg-dirty-v1-v1-1-9a8c80036ec1@uber.com> <pbwzmyglpz33d3k63aopi5vlghz4jmur2k2g4res6mhktuujhh@rmqooz6bqaao>
In-Reply-To: <pbwzmyglpz33d3k63aopi5vlghz4jmur2k2g4res6mhktuujhh@rmqooz6bqaao>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 13 May 2026 21:10:10 -0700
X-Gm-Features: AVHnY4J5GZ7JBzfRkA-sfCo1uEK-ixoCcB3uvVHBJUoZ4dZkaVGCZkTX2MJ_bAU
Message-ID: <CA+w=M=RkewNB0Fc=KNXTrOnt-YABFy+7ZALLmp1wQOP5k_=13Q@mail.gmail.com>
Subject: Re: [PATCH RFC] memcg: add per-cgroup dirty page controls
 (dirty_ratio, dirty_min)
To: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kshitij Doshi <kshitijd@uber.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6D13153D8E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[uber.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[uber.com,quarantine];
	R_DKIM_ALLOW(-0.20)[uber.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15927-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haghdoost@uber.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[uber.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,uber.com:dkim]
X-Rspamd-Action: no action

On Wed 06-05-26 16:21:00, Jan Kara wrote:
> Things like motivation actually belong to the changelog itself, measured
> results how the patch helps as well. On the other hand stuff like history
> is largely irrelevant here, frankly I don't have a bandwidth to carefully
> read the huge amount of text LLM has generated below so please try to make
> it more concise for next time.

Understood. Will trim for the non-RFC posting; apologies for the
volume.

> ... I quite don't see how a multisecond stalls you are describing would
> happen [...] If we are below freerun in the memcg, the task dirtying
> folios from that memcg shouldn't be throttled at all, once we get above
> freerun we throttle by maximum of throttling delay decided from global
> and memcg situation [...]

The stall is reachable even with the victim's memcg well below its
own freerun. The freerun shortcut in balance_dirty_pages() is an AND,
not OR:

  if (gdtc->freerun && (!mdtc || mdtc->freerun))
          goto free_running;

Once gdtc is over freerun (because the noisy neighbour pushed it
there) the shortcut does not fire, even when mdtc->freerun is true.
After the shortcut fails, the per-task pause is computed from the
dtc with the smaller pos_ratio:

  if (mdtc->pos_ratio < gdtc->pos_ratio)
          sdtc = mdtc;

When global is the worse domain, the victim sleeps against global
state, not memcg state.

> So can you perhaps share more details about the configuration where
> you observe these delays to innocent tasks due to another task
> dirtying a lot of memory? How many page cache in total and dirty
> pages are there in each memcg [...]? Is the delayed task really
> throttled in balance_dirty_pages()?

Yes. Re-ran the reproducer: stock 7.0-rc5, ext4 on virtio-blk
throttled to 256 KB/s, dirty_bytes=32M, dirty_background_bytes=16M
(freerun = 24 MB), noisy = single fio job doing unlimited buffered
randwrite, victim = single fio job doing 4 KiB sequential write
rate-limited to 500 KB/s.

Per-memcg snapshot during the contended phase, ~10 s into the run:

                       noisy memcg     victim memcg     global
  memory.current        47 MB            21 MB           --
  file (cache)          38 MB            14 MB           --
  file_dirty            26 MB           1.7 MB           27 MB
  file_writeback       1.5 MB           4.0 MB          5.3 MB

Victim memcg holds 1.7 MB dirty, far below any reasonable per-memcg
freerun. Global dirty (NR_FILE_DIRTY + NR_WRITEBACK ~ 32 MB) is over
the 24 MB freerun ceiling, driven entirely by noisy.

The victim writer (fio with psync) is in fact sleeping in
balance_dirty_pages(). One stack snapshot during a stall:

  [<0>] balance_dirty_pages+0x5c5/0xac0
  [<0>] balance_dirty_pages_ratelimited_flags+0x2a1/0x380
  [<0>] generic_perform_write+0x194/0x280
  [<0>] ext4_buffered_write_iter+0x63/0x110
  [<0>] vfs_write+0x28d/0x450
  [<0>] __x64_sys_pwrite64+0x8c/0xc0
  [<0>] do_syscall_64+0xfa/0x520
  [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

Sampling /proc/<pid>/wchan at 100 Hz across the contended phase
yields the histogram:

  104  balance_dirty_pages
   88  hrtimer_nanosleep    (the fio rate-limit sleep between writes)
   12  RUNNING
    4  p9_client_rpc        (virtfs, host-guest filesystem RPC)
    3  d_alloc_parallel

The vast majority of non-rate-limit samples have the writer parked
in balance_dirty_pages(). Victim per-IO clat in this run reaches a
3 s tail (worst single 4 KiB pwrite blocked ~3.0 s) while its own
memcg holds < 2 MB dirty.

I'm happy to share the full traces and the reproducer if useful.

Thanks for the review,
Alireza

