Return-Path: <cgroups+bounces-14575-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E9ULDQip2mMegAAu9opvQ
	(envelope-from <cgroups+bounces-14575-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 19:02:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EE1F4E77
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A081A306C7C7
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D2377EB5;
	Tue,  3 Mar 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOZQEe8Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3F4F798C
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560926; cv=pass; b=D4KLr+j12SG365Tkn5CDVBhy1DueBxFNlJtPWKx46hyMNJTf0zCH60r8PwkaTvsdmaqR6l7iBz4pbkdiikuq4WXJx2fshX8zYOUNftvbGb0nQCPFkP3vn7fCvfQ23RhrPMP0xjF9CSCiUNNR42SovlPV+me0DHbn8v0Cmp7jtKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560926; c=relaxed/simple;
	bh=o7qPOzAiSSdqgf2DMo6sKmHB4y4GpUXZUyPwv6glSFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLCtNCezt4ZbX5hQ4PlWoc+Zo7Im6FYx3gZ4Spxcc19LmYsn3ti3SUSDc4kSyHsP29PcCuh5DImN1XsXVcVUoz+pGTKSWTK3n8rzoI+QfegMuGJwkupxfrTKVamujfEuPGa6k7DZFZFfNC9aigg2hA5x2V3KOD98KAI00u4JM8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOZQEe8Y; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439af7d77f0so2710070f8f.0
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 10:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772560923; cv=none;
        d=google.com; s=arc-20240605;
        b=GuH1Wtxi84nfRo+QsZw2s95ezES1IsdSlznkRuoIfuLNaNYEUrM6twjuFCfKc/CGQI
         ATeLDpkTkWE8qMuQG5G8BmwIzIaGHe85BfN7W/ieraMfVBW6Q4ZWuJuC20EKMXCwtxsG
         KUwJ3Smj8xwJ3cVUxZgnpU2YIZU+tecPthhmZf8xAwAz824ffKV2eHs/fQhv5zdMbAqP
         BEz/hy40c+0q9+PZBBEBKfInASvAbDgrAFdhGEyAKCQfp38B23O3I5wIiNStv2xHjLMM
         2eq7bbU3zw+QgK8SF1hc891+wq7sp4cF4nmJty22A9jYhOQwsMi2+0jSPXlV4RHGk2UD
         HKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=foIbnYRvZEeozwct/vuUZhLqaBM8H9J20Y5TG3JAcfE=;
        fh=/X7/42hCcYJjhFtFInVs77OwCmwyYlMGNFQKkiwHGys=;
        b=ApXe3xkvLAneG77SVJ0JYbCroUzs9CCznnlK16IUgRVlR0uqm57+jO500cM4fwzXCS
         EA6tavFmZ603nN7+raqV9dcUpFVUQlz9SNZ6hJev57LDu0DuXq1h6nCr3y8D6uciqPYh
         X+mneSIVriZfVGlWv1HS699fxMNJOgrCrUsxR6fWFa6/MPV22dY/oQBkBuRyttvhHvr6
         Fybi1oQ5fp/WZas5LaNKtbrdDSP0JdSWt0IA1F9xt2N8oo0tg40dVNoNRoRb98DOolUL
         EgTYvA7BZWbKqCFo5+jiMQbLA2GVB96RbnlVc3LX28OfLsPuYZL0m9afLg74JMYZ1wNk
         G5eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560923; x=1773165723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foIbnYRvZEeozwct/vuUZhLqaBM8H9J20Y5TG3JAcfE=;
        b=hOZQEe8Yr7oON/QfQJ7KcwljWMDGfj2COB2wk4m1rgvOiNJ/ntCI4bmrkMMfzI9Qqi
         b6ewNrK5GE2raIrjx73ONltZGiue1EITLkVlUhuxlw2X6fSC9IWZxzxcNkq3m+Q84fzM
         kXimVtDs9j2DmhsTW7Z2AKwlEDM1g+ebjegG+VcikPTlBld3O/nnJwnojBG1eOdGyyjj
         ofapkgMXXEuEvVpPIwKrgmiKrS4+YLH4z9KWJCXT+ROS5G/+AqZ0j9njBXS+iDR0lqd9
         eleHFA6CkcB/XXJgvPQSMdPDaKNt7hKz8YfIG2JxhoxtIEtv+3aCxQiO+lARUgU+CfGl
         /WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560923; x=1773165723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foIbnYRvZEeozwct/vuUZhLqaBM8H9J20Y5TG3JAcfE=;
        b=ivYgNVVHZ9nLdoOP7DLqk6BrKX0bhMIMudD3qsUjetPLuYgBaVKAamKMta7GzecrY2
         2C9Vpm1IdmpoF70IvRBUOgCZBQ5KgWpVrP/A3B5nn/bOIY51Jmtrp35XtLC+1FxvDhWc
         rlzroBIcphMoUIZkzwG9KSuMhMsQvLMlSDhdRIwCvmgs30h8YLNU9S0QFkQaaMGoFa2j
         MosH3OyZ82RjicapIIxSD/90xBDdFxb4aWCj/mlCYntQ15JRqufNd0APnW3GOXbCFgpW
         s0Sk1FhSyi6GBWywQ1WJGh5DHXGWZ5zNKIvfqh6FhEDrS4jvwb71Ep+oxnYWI+SXpqOt
         qLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeZbi+MX3xSO8oH7ViR33Rikno58x3N14D+1zVcV95ucQAnD9YP7T8Vyxyky9s7/axXCtox1f0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PYVXzSWsOJ2SlaNKgQY7QCQyHPbNvk4k4ILli1MNjgvehL4t
	hvc/LJ8rlF0wl0S0FB0JYI/8I5tiMJVlcmw6QVUtkNU8SbHBK57WNeSBr0Bw5VLUIqLiw2dNtDo
	Vk2Ni/kuUMlUCElhVmLbI19T83nZXHwQ=
X-Gm-Gg: ATEYQzyrtjzOSomlTTZo0ju6tAxhQLv2STdnFlJtNAGFqlZLccjQcBn+nhyFOds4U0r
	QM8my7m+S4CX1UC6PgdrxE8x7fCb+zKxHzTkF2Q9Lx6Z6y+H404RgJbH/eSgs3exHccWaLJStIR
	Ttg+Zh/JtVlqZ0NxgPiBO5KpL5MaA9urqqe/w1Q2RPqXFXCVaHiIBTQzaYa8ioB3V+BUxPbZRHs
	GftbghW1iAdIrKkOjfdXkKqjvu+rtdgJeLEx6Gec++/04xjOsfVt3eaPuTDJFrrUN9h8RBGhxC+
	ng8vxE1ES1UGN2Soz7Y9dqlygSITMJPkIXPg0tU=
X-Received: by 2002:a05:6000:238a:b0:439:c550:d92a with SMTP id
 ffacd0b85a97d-439c550d9d5mr2304995f8f.53.1772560922568; Tue, 03 Mar 2026
 10:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=N-yzg66Ge5YgDNG7nh3ues62fSjmi6oGq1B=gkz6e2Uw@mail.gmail.com>
 <20260303175140.1032459-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260303175140.1032459-1-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 3 Mar 2026 10:01:51 -0800
X-Gm-Features: AaiRm52gDOCcmDbHXVyYPo26Ma_Va4b_HvYpOS1jbz0JVcTO_7EGhjCQqYnuMK0
Message-ID: <CAKEwX=NW75_ftM5ZuJJRMB2CLnB-25KPvamb4L1eP=i0XuFS_g@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/zswap, zsmalloc: Per-memcg-lruvec zswap accounting
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C3EE1F4E77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14575-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 9:51=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.com=
> wrote:
>
> On Mon, 2 Mar 2026 13:31:32 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > On Thu, Feb 26, 2026 at 11:29=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gma=
il.com> wrote:
>
> [...snip...]
>
> > > Introduce a new per-zpdesc array of objcg pointers to track
> > > per-memcg-lruvec memory usage by zswap, while leaving zram users
> > > unaffected.
>
> [...snip...]
>
> Hi Nhat! I hope you are doing well : -) Thank you for taking a look!
>
> > I might have missed it and this might be in one of the latter patches,
> > but could also add some quick and dirty benchmark for zswap to ensure
> > there's no or minimal performance implications? IIUC there is a small
> > amount of extra overhead in certain steps, because we have to go
> > through zsmalloc to query objcg. Usemem or kernel build should suffice
> > IMHO.
>
> Yup, this was one of my concerns too. I tried to do a somewhat comprehens=
ive
> analysis below, hopefully this can show a good picture of what's happenin=
g.
> Spoilers: there doesn't seem to be any significant regressions (< 1%)
> and any regressions are within a small fraction of the standard deviation=
.
>
> One thing that I have noticed is that there is a tangible reduction in
> standard deviation for some of these benchmarks. I can't exactly pinpoint
> why this is happening, but I'll take it as a win :p
>
> > To be clear, I don't anticipate any observable performance change, but
> > it's a good sanity check :) Besides, can't be too careful with stress
> > testing stuff :P
>
> For sure. I should have done these and included it in the original RFC,
> but I think I might have been too eager to get the RFC out : -)
> Will include in the second version of the series!
>
> All the experiments below are done on a 2-NUMA system. The data is quite
> compressible, which I think makes sense for measuring the overhead of acc=
ounting.
>
> Benchmark 1
> Allocating 2G memory to one node with 1G memory.high. Average across 10 t=
rials
> +-------------------------+---------+----------+
> |                         | average |  stddev  |
> +-------------------------+---------+----------+
> | Baseline (11439c4635ed) | 8887.82 | 362.40   |
> | Baseline + Series       | 8944.16 | 356.45   |
> +-------------------------+---------+----------+
> | Delta                   | +0.634% | -1.642%  |
> +-------------------------+---------+----------+
>
> Benchmark 2
> Allocating 2G memory to one node with 1G memory.high, churn 5x through th=
e
> memory. Average across 5 trials.
> +-------------------------+----------+----------+
> |                         | average  |  stddev  |
> +-------------------------+----------+----------+
> | Baseline (11439c4635ed) | 31152.96 | 166.23   |
> | Baseline + Series       | 31355.28 | 64.86    |
> +-------------------------+----------+----------+
> | Delta                   | +0.649%  | -60.981% |
> +-------------------------+----------+----------+
>
> Benchmark 3
> Allocating 2G memory to one node with 1G memory.high, split across 2 node=
s.
> Average across 5 trials.
> +-------------------------+---------+----------+
> |            a            | average |  stddev  |
> +-------------------------+---------+----------+
> | Baseline (11439c4635ed) | 16101.6 | 174.18   |
> | Baseline + Series       | 16022.4 | 117.17   |
> +-------------------------+---------+----------+
> | Delta                   | -0.492% | -32.731% |
> +-------------------------+---------+----------+
>
> Benchmark 4
> Reading stat files 10000 times under memory pressure
>
> memory.stat
> +-------------------------+---------+----------+
> |                         | average |  stddev  |
> +-------------------------+---------+----------+
> | Baseline (11439c4635ed) | 24524.4 | 501.7    |
> | Baseline + Series       | 24807.2 | 444.53   |
> +-------------------------+---------+---------+
> | Delta                   | 1.153%  | -11.395% |
> +-------------------------+---------+----------+
>
> memory.numa_stat
> +-------------------------+---------+---------+
> |                         | average | stddev  |
> +-------------------------+---------+---------+
> | Baseline (11439c4635ed) | 24807.2 | 444.53  |
> | Baseline + Series       | 23837.6 | 521.68  |
> +-------------------------+---------+---------+
> | Delta                   | -3.905% | 17.355% |
> +-------------------------+---------+---------+
>
> proc/vmstat
> +-------------------------+---------+----------+
> |                         | average |  stddev  |
> +-------------------------+---------+----------+
> | Baseline (11439c4635ed) | 24793.6 | 285.26   |
> | Baseline + Series       | 23815.6 | 553.44   |
> +-------------------------+---------+---------+
> | Delta                   | -3.945% | +94.012% |
> +-------------------------+---------+----------+
>
> ^^^ Some big increase in standard deviation here, although there is some
> decrease in the average time. Probably the most notable change that I've =
seen
> from this patch.
>
> node0/vmstat
> +-------------------------+---------+----------+
> |            a            | average |  stddev  |
> +-------------------------+---------+----------+
> | Baseline (11439c4635ed) | 24541.4 | 281.41   |
> | Baseline + Series       | 24479   | 241.29   |
> +-------------------------+---------+---------+
> | Delta                   | -0.254% | -14.257% |
> +-------------------------+---------+----------+
>
> Lots of testing results, I think mostly negligible in terms of average, b=
ut
> some non-negligible changes in standard deviation going in both direction=
s.
> I don't see anything too concerning off the top of my head, but for the
> next version I'll try to do some more testing across different machines
> as well (I don't have any machines with > 2 nodes, but maybe I can do
> some tests on QEMU just to sanity check)
>
> Thanks again, Nhat. Have a great day!
> Joshua

Sounds like any meagre performance difference is smaller than noise :P
If it's this negligible on these microbenchmarks, I think they'll be
infinitesimal in production workloads where these operations are a
very small part.

Kinda makes sense, because objcgroup access is only done in very small
subsets of operations: zswap entry store and zswap entry free, which
can only happen once each per zswap entry.

I think we're fine, but I'll leave other reviewers comment on it as well.

