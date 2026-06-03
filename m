Return-Path: <cgroups+bounces-16619-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jkAoKK5xIGo63gAAu9opvQ
	(envelope-from <cgroups+bounces-16619-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:25:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCB63A88C
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hbuAAVaa;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16619-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16619-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB2FA3029CDE
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356263DD87A;
	Wed,  3 Jun 2026 18:23:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9283859EC
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 18:23:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511029; cv=pass; b=dMaxowRHd+Cwg8rwrg4qFAv84bQekQSGdRo1Qv7eqcOJxRBOivX2eFqCdmxGV+znlWmljZWG06HmzKq4VB3LiV+b0RRJp/Xt2Ad0nwGt5yJFuKWjETvK5i2ic4UxPT/ou7lhVC6vZtX2slXzqqvH9z4Lz3D/0G6YBtWnO8O1mvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511029; c=relaxed/simple;
	bh=hl2ne1Atd8E66sDkEQB6tbWJE9BHSgX8uQGAzS+dDjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfN+qQO0ydsyzszxBxVvShv5H+Vpf80FP2KnVYC8CBYZQ/auWf2FtZv2TcJRXQS36QALmDE/l31L2mJ7wY5jqvjMn/fX0+6209EifpFwB5NMXrONIPSo/kPkwSfTfSJZ8iPhEDAqqLIVmZQmBOkn3FTYzGxcI0ReV1RTBS5PqL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbuAAVaa; arc=pass smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso12980035e9.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 11:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780511025; cv=none;
        d=google.com; s=arc-20240605;
        b=ltjpBjZB+XnlVlLYwnTk1jWyNMXE9kaNqTN/flq3Yu5LmhGAZlZeFzFGrw1RnV/+xY
         TW+ZP0Ys+jRMM3mlTDyHfoGOW9g3Y4b3nLWWYtnRT4zOQP7SOX6EUnN5BkPO1+x6rmPy
         XB8Jos8lMb0IfbxjxHAWMPVQKsqwkMxMHOREZSqO6axLuT1VNgCjaJZ8G8oilWduBopz
         eApwKV5bGuumaATkyvtflemBYvA0owVHvShLpGn8RszzhHBwRRkCRZkPOQyH0wdLAM7J
         cf51IRhofLVxFBCNg2n/WwcvqPHOQCzQWqMa1GCwwnEQy/eqD3oDbqssIb+wQAxQp/Qq
         B2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H5/qixCBVKIn17fieXnZwtlY6rJGJD1uIM6atv0ZcW4=;
        fh=zeRFffnUBHMnZpJ0ScjkRVH2/CfmMpPG1YFe+74IFvk=;
        b=lS9cpGl2ViU0MjKnmBwoxxgyhcBUCSiiuP2EIOEgU9Q4KC+vp0Ak7VXh3df2MZr74X
         ykeJWiCo1PKpBzzrep0d5H3c0CN3A3Y01dBjKI7X3Yl5sGutFNiTM7xku+bI8ed9yV5x
         1lEjJNs0ivLN1UbLUerEEB5HsGEhYPRo4HIHBZfNBomVAUV0AHW9Nqys0FtxI3xkI2xM
         vl1X/8y25AdVbcwRntcmw6KafxEToEqQFanh0bKq7Et9d01I7Q6RfxyfgxYdd7v327ep
         mbC2umO6gB5pJPustjYf5rBtFS7iZyrMylrxSdJWMYdAXxTeJw0WV9DU0XddptbYf+b2
         SDLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780511025; x=1781115825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5/qixCBVKIn17fieXnZwtlY6rJGJD1uIM6atv0ZcW4=;
        b=hbuAAVaaJKnlMRv20LTfZjRADSE/eUng9SnVoLQVTkqBZLaAUiRsy1g+qvMcSMlcvI
         VXSsFNHVgzQh/II8IswgT3VR7HRgP9wGEI8WOhys+xVMPH5PHFcTBi6UYXpLpbOqn+sn
         cnppNKGLdposQcUunplxwV1MTJL8FPT4pNWSpKjsgP0L9wZQiCTHdJmyMu+qwzIoi3+n
         zMJ+dwTHXqiijaWD/0rW91MvZIWAxzA/9pZlGZ/jU77Iirr7vl1MGKxMB62djf3bnu3S
         WIIyRYUkQbmU9XICtiHmTRreUbtLfGnWiYIpQApRcf+YLYxjv+Cy3Obs1YEvggbRPR5Y
         5omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511025; x=1781115825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5/qixCBVKIn17fieXnZwtlY6rJGJD1uIM6atv0ZcW4=;
        b=TXeJKxAeuG+HztozHyEFCTvZJBYs9smk5YcczjK1v4izJ1t6hfQGgGQlHFDv1zRAJ/
         z9f9UU/D6F4LmpPkipSfdWRICP0jBeISViQ64GrhKUsHUi/whBfJyGkn6GiqYXLmqq4+
         nr481NCGkGJn8ebz0YhEemsBlVGrmIVuviXmxh7ergXSvfKFawr+gkeni4RuoxNh/h7j
         oublyx1Zq/BJFbi/t+pvNHXvaunw1+nP/1/lj74XW8NngFBNm3b3jvayktIVQ4rTW4s3
         5ZQ9HNnVs5rNM/RxoBdLlaI0IQwpFXsBelxIzZNr8YM+rkikY/Nsbc2koOOGnvplj+CI
         ptsg==
X-Forwarded-Encrypted: i=1; AFNElJ8+30N1ySvsaqYZUQM2RTXuEFZIzAY7HuUis/Y/9uLcjTCYvsYx6iU8ggyzixCrR5WUn9Sjvb8U@vger.kernel.org
X-Gm-Message-State: AOJu0YyDOxv4qCSgjxVv206a4ttCYdQhsla4TkqG2zmvZI83mCAWpQJ2
	SF3PtRr5OB18agg1rDzc0cfbuqfn7+4dOChQGz6wNnaqVd97PbZJOdFfC1i7p4DvxgsYsO7yApr
	69OKbLuJupZiA01hYydRbz2rXYI6DyVI=
X-Gm-Gg: Acq92OH94CZtlwqqvVAoCOJAk7Dl9aLcRBYInqQBQNXS98dR7cx6H5afojcMgwrGiXE
	fOa6BGWjykgyfF5H+YFOTNfr6I3W9xrnB9522vvkJligU0KxoQ6RFYZdRW3H4k0DcpZ9wA75bQE
	lJGEyWQRh2uh1d3AKKmioNMQ28ldk9ilTC+k6gWNk8buTcmxesU6gyTGSP2GmosEu5mOvBv8/0Q
	bBNIqL4XGNfEPuc8Ww/i2Qq1HF8Y958+sBwj50MegjqQxIk0ALg0shUgrrvF7qG6sS0jmdBusi9
	+RUAHTPeMnapld0bHItBZPj3lWzkNuReouWDS/8wqHJ9u+vgj1FUAY4y5bn0
X-Received: by 2002:a05:600c:4695:b0:490:bd1d:472a with SMTP id
 5b1f17b1804b1-490bd1d4865mr418905e9.15.1780511025470; Wed, 03 Jun 2026
 11:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com> <aho-Z6wshceTAYd9@google.com>
 <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com>
In-Reply-To: <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jun 2026 11:23:33 -0700
X-Gm-Features: AVHnY4JV9IZeIUq7QxB_DLa_b3AR5iHZZp6MXPsHjOzMK24TtH3slZqwmfSKyPA
Message-ID: <CAKEwX=PoBZ4ci30tKHQXs1o9=NDpPrtbe7RxxZTbnzVJf74ZYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16619-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFFCB63A88C

On Wed, Jun 3, 2026 at 4:27=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
>
>
>
> On 2026/5/30 09:37, Yosry Ahmed wrote:
> > On Tue, May 26, 2026 at 07:45:59PM +0800, Hao Jia wrote:
> >> From: Hao Jia <jiahao1@lixiang.com>
> >>
> >> Zswap currently writes back pages to backing swap reactively, triggere=
d
> >> either by the shrinker or when the pool reaches its size limit. There =
is
> >> no mechanism to control the amount of writeback for a specific memory
> >> cgroup. However, users may want to proactively write back zswap pages,
> >> e.g., to free up memory for other applications or to prepare for
> >> memory-intensive workloads.
> >>
> >> Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
> >> interface. When specified, this key bypasses standard memory reclaim
> >> and exclusively performs proactive zswap writeback up to the requested
> >> budget. If omitted, the default reclaim behavior remains unchanged.
> >>
> >> Example usage:
> >>    # Write back 100MB of pages from zswap to the backing swap
> >>    echo "100M zswap_writeback_only" > memory.reclaim
> >>
> >> Note that the actual amount written back may be less than requested du=
e
> >> to the zswap second-chance algorithm: referenced entries are rotated o=
n
> >> the LRU on the first encounter and only written back on a second pass.
> >> If fewer bytes are written back than requested, -EAGAIN is returned,
> >> matching the existing memory.reclaim semantics.
> >>
> >> Internally, extend user_proactive_reclaim() to parse the new
> >> "zswap_writeback_only" token and invoke the dedicated handler. Add
> >> zswap_proactive_writeback() to walk the target memcg subtree via the
> >> per-memcg writeback cursor, draining per-node zswap LRUs through
> >> list_lru_walk_one() with the shrink_memcg_cb() callback.
> >>
> >> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> >> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> >> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> >> ---
> >>   Documentation/admin-guide/cgroup-v2.rst |  18 +++-
> >>   Documentation/admin-guide/mm/zswap.rst  |  11 +-
> >>   include/linux/zswap.h                   |   7 ++
> >>   mm/vmscan.c                             |  14 +++
> >>   mm/zswap.c                              | 138 ++++++++++++++++++++++=
++
> >>   5 files changed, 185 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/a=
dmin-guide/cgroup-v2.rst
> >> index 6efd0095ed99..6564abf0dec5 100644
> >> --- a/Documentation/admin-guide/cgroup-v2.rst
> >> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >> @@ -1425,9 +1425,10 @@ PAGE_SIZE multiple when read back.
> >>
> >>   The following nested keys are defined.
> >>
> >> -      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>        swappiness            Swappiness value to reclaim with
> >> -      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +      zswap_writeback_only  Only perform proactive zswap writeback
> >> +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>      Specifying a swappiness value instructs the kernel to perform
> >>      the reclaim with that swappiness value. Note that this has the
> >> @@ -1437,6 +1438,19 @@ The following nested keys are defined.
> >>      The valid range for swappiness is [0-200, max], setting
> >>      swappiness=3Dmax exclusively reclaims anonymous memory.
> >>
> >> +    The zswap_writeback_only key skips ordinary memory reclaim and
> >> +    writes back pages from zswap to the backing swap device until
> >> +    the requested amount has been written or no further candidates
> >> +    are found. This is useful to proactively offload cold pages from
> >> +    the zswap pool to the swap device. It is only available if
> >> +    zswap writeback is enabled. zswap_writeback_only cannot be combin=
ed
> >> +    with swappiness; specifying both returns -EINVAL.
> >> +
> >> +    Example::
> >> +
> >> +      # Write back up to 100MB of pages from zswap to the backing swa=
p
> >> +      echo "100M zswap_writeback_only" > memory.reclaim
> >
> >
> > memcg folks need to chime in about the interface here. An alternative
> > would be a separate interface (e.g. memory.zswap.do_writeback or
> > memory.zswap.writeback.reclaim or sth).
> >
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 73e64a635690..7bcbf788f634 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1679,6 +1679,144 @@ int zswap_load(struct folio *folio)
> >>      return 0;
> >>   }
> >>
> >> +/*
> >> + * Maximum LRU scan limit:
> >> + * number of entries to scan per page of remaining budget.
> >> + */
> >> +#define ZSWAP_PROACTIVE_WB_SCAN_RATIO       16UL
> >> +/*
> >> + * Batch size for proactive writeback:
> >> + * - As the per-memcg writeback target in the outer memcg loop.
> >> + * - As the per-walk budget passed to list_lru_walk_one().
> >> + */
> >> +#define ZSWAP_PROACTIVE_WB_BATCH    128UL
> >> +
> >> +/*
> >> + * Walk the per-node LRUs of @memcg to write back up to @nr_to_write =
pages.
> >> + * Returns the number of pages written back, or -ENOENT if @memcg is =
a
> >> + * zombie or has writeback disabled.
> >> + */
> >> +static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
> >> +                                     unsigned long nr_to_write)
> >> +{
> >> +    unsigned long nr_written =3D 0;
> >> +    int nid;
> >> +
> >> +    if (!mem_cgroup_zswap_writeback_enabled(memcg))
> >> +            return -ENOENT;
> >> +
> >> +    if (!mem_cgroup_online(memcg))
> >> +            return -ENOENT;
> >> +
> >> +    for_each_node_state(nid, N_NORMAL_MEMORY) {
> >> +            bool encountered_page_in_swapcache =3D false;
> >> +            unsigned long nr_to_scan, nr_scanned =3D 0;
> >> +
> >> +            /*
> >> +             * Cap by LRU length: bounds rewalks when referenced
> >> +             * entries keep rotating to the tail.
> >> +             */
> >> +            nr_to_scan =3D list_lru_count_one(&zswap_list_lru, nid, m=
emcg);
> >> +            if (!nr_to_scan)
> >> +                    continue;
> >> +
> >> +            /*
> >> +             * Cap by SCAN_RATIO * remaining budget: bounds scan cost
> >> +             * to the remaining writeback budget.
> >> +             */
> >> +            nr_to_scan =3D min(nr_to_scan,
> >> +                             (nr_to_write - nr_written) * ZSWAP_PROAC=
TIVE_WB_SCAN_RATIO);
> >> +
> >> +            while (nr_scanned < nr_to_scan) {
> >> +                    unsigned long nr_to_walk =3D min(ZSWAP_PROACTIVE_=
WB_BATCH,
> >> +                                                   nr_to_scan - nr_sc=
anned);
> >> +
> >> +                    if (signal_pending(current))
> >> +                            return nr_written;
> >> +
> >> +                    /*
> >> +                     * Account for the committed budget rather than t=
he walker's
> >> +                     * actual delta. If the list is emptied concurren=
tly, the
> >> +                     * walker visits nothing and nr_scanned would nev=
er advance.
> >> +                     */
> >> +                    nr_scanned +=3D nr_to_walk;
> >> +
> >> +                    nr_written +=3D list_lru_walk_one(&zswap_list_lru=
, nid, memcg,
> >> +                                                    &shrink_memcg_cb,
> >> +                                                    &encountered_page=
_in_swapcache,
> >> +                                                    &nr_to_walk);
> >> +
> >> +                    if (nr_written >=3D nr_to_write)
> >> +                            return nr_written;
> >> +                    if (encountered_page_in_swapcache)
> >> +                            break;
> >> +
> >> +                    cond_resched();
> >> +            }
> >> +    }
> >> +
> >> +    return nr_written;
> >> +}
> >> +
> >> +int zswap_proactive_writeback(struct mem_cgroup *memcg,
> >> +                          unsigned long nr_to_writeback)
> >> +{
> >> +    struct mem_cgroup *iter_memcg;
> >> +    unsigned long nr_written =3D 0;
> >> +    int failures =3D 0, attempts =3D 0;
> >> +
> >> +    if (!memcg)
> >> +            return -EINVAL;
> >> +    if (!nr_to_writeback)
> >> +            return 0;
> >> +
> >> +    /*
> >> +     * Writeback will be aborted with -EAGAIN if we encounter
> >> +     * the following MAX_RECLAIM_RETRIES times:
> >> +     * - No writeback-candidate memcgs found in a subtree walk.
> >> +     * - A writeback-candidate memcg wrote back zero pages.
> >> +     */
> >> +    while (nr_written < nr_to_writeback) {
> >> +            unsigned long batch_size;
> >> +            long shrunk;
> >> +
> >> +            if (signal_pending(current))
> >> +                    return -EINTR;
> >> +
> >> +            iter_memcg =3D zswap_mem_cgroup_iter(memcg);
> >> +
> >> +            if (!iter_memcg) {
> >> +                    /*
> >> +                     * Continue without incrementing failures if we f=
ound
> >> +                     * candidate memcgs in the last subtree walk.
> >> +                     */
> >> +                    if (!attempts && ++failures =3D=3D MAX_RECLAIM_RE=
TRIES)
> >> +                            return -EAGAIN;
> >> +                    attempts =3D 0;
> >> +                    continue;
> >> +            }
> >> +
> >> +            batch_size =3D min(nr_to_writeback - nr_written,
> >> +                             ZSWAP_PROACTIVE_WB_BATCH);
> >> +            shrunk =3D zswap_proactive_shrink_memcg(iter_memcg, batch=
_size);
> >> +            mem_cgroup_put(iter_memcg);
> >> +
> >> +            /* Writeback-disabled or offline: skip without counting. =
*/
> >> +            if (shrunk =3D=3D -ENOENT)
> >> +                    continue;
> >> +
> >> +            ++attempts;
> >> +            if (shrunk > 0)
> >> +                    nr_written +=3D shrunk;
> >> +            else if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> >> +                    return -EAGAIN;
> >> +
> >> +            cond_resched();
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >
> > There is a lot of copy+paste from shrink_worker() and shrink_memcg()
> > here. We really should be able to reuse shrink_memcg().
> >
>
> I will do some consolidation and code reuse in the next version.
>
> > Is the main difference that we are scanning in batches here? I think we
> > can have shrink_memcg() do that too. If anything, it might make the
> > shrinker more efficient. Over-reclaim is ofc a concern, and especially
> > in the zswap_store() path as the overhead can be noticeable. Maybe we
> > can parameterize the batch size based on the code path.
> >
> > Nhat, what do you think?
>
> Nhat, since we now have the referenced-based second chance algorithm,
> should we consider doing batch writeback for shrink_memcg() as well?

I just take a look at shrink_memcg() and realized it's reclaiming one
page at a time. Thanks for the reminder - I hated it.

Please batchify it if it makes your life easier :) We don't reclaim
"just one page/object" anywhere else in the reclaim path, Sure, it
adds a bit of latency to zswap_store() if we reached cgroup limit, but
IMHO if we hit zswap.max limit at zswap_store() time, that is already
the slowest of slow path that you should have avoided with proactive
reclaim/zswap shrinker in the first place. And, setting zswap.max does
not make sense to me in the first place (I can write a whole essay
about it).

