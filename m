Return-Path: <cgroups+bounces-14573-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN2KObYfp2mYeQAAu9opvQ
	(envelope-from <cgroups+bounces-14573-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 18:51:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE11F4CD2
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 391EE30237B1
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5813B8BC9;
	Tue,  3 Mar 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo8A3QZ1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB873B3BF5
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560305; cv=none; b=KH8ItB/wgh6ajjBLhRXe63KtdCWZt4z0RZxe2Yxr4FnMa3NxMi9a9IeZH4GLsZHefz6H0F/Scf8xz2CJ769L6iZ+lt2UWOhm20nYrCDv/+CZieZ4uOX8swSjNMLWlBlcDNcPXKCzbfY4aNiM4C+QhzK0Y6T9Eyfl5X89UGHQi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560305; c=relaxed/simple;
	bh=V7QsVEzWTojtnTlj+UydSgx3mnAjbPVl9RTcbR2T1uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0sTflgRLIug47DfQZr2CsTQvSu/Fi8klcegx+FOoxTNIbgT/yk8Q3CHKuhBTgcGFDMchdGNfgzDzq6xrqEXxYMn1qtOuDW+z0i+uy7eUtDL5Vr/GYAMzxxAr1Zt2JNuIcERg8wgrslf7fShf/oRUzSMcNYSnuw4VRDcjyzfU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo8A3QZ1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f015a3259so2473634b6e.2
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560303; x=1773165103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL6WbRDTWPclsvE0UMM34YVtaLXqlF6tBavQfG2bQhc=;
        b=Eo8A3QZ10/1DwjWVDgl3puKcWLwMCkDWelYPiGYBWfhIBWyji+s2MCgPW+GB0vj7yv
         Tj9JjOLutTlOC96Ik5AdO6tkOtn1Gu5BvJgA9NHvyIl59w2qtVIst6t5x11J0ygMefBF
         FHYU0TDRNB75Hjb28V182Ax8oucq4B0vt1RaEaqu3Ob7//wSR4Q30yLOUXr3/UlL2LNe
         VH0ntFC90cCHVr4l1cOPN34nkkbumgLFqihet55vuTYQLTrvecoi8Ykbj7Sd3kgUFc9L
         S9TsxU1GbeD3vbl2dfV35TETGm+Zp3LR8UxzCBeitOnFqVghrGbdMhq1WlN2nsBSqfLf
         B8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560303; x=1773165103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fL6WbRDTWPclsvE0UMM34YVtaLXqlF6tBavQfG2bQhc=;
        b=Z07jf/sGN9OJtMwxfWw7wSSF1QI012A5Q0lU+hlo43xch0sYwMKgkKy1LpOtJ6uB66
         XHMGFzVT/mLq/y0Ma/+LuDtfAGjLq1eJSlXI+/3aSmtAqTG+11HA8WMaghlhK8Dhze5o
         GplqwOGYUivBAxczZeUSd+p7mLMbPUSvd0n5EFWWjJKo1y0ILB9gSZwMZaFmQYWwlO4b
         SB9BlmYL6n3plDg6QV1H07nnOWmvv9eubaBYtcn/npo8+mAx0AMy+fqnDHcJ5m38xoG6
         AQwvSTecx2bB+6wPs8taaYNOsNNd9KfKxkcaMl89ILCdb7aWHHjSTYRtlpcuy6W8wV7v
         +99Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTuYvi93UK+qh0NsvM5hZuO4ISGXTMGgpW9AuAOKbh9Gg2WY9b0WnzM5mkkSe/jEN10nm+g0Hi@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUGSJwPSEvXlWstaQ6DicJKzFt/qGwFlQ83HaJiQjmG80Q0b7
	OBdmikkqn2H6RGUVpNCKB0ucmkrTIcKF+WPPXQquc++oHgwqV7ANwEO0tbb08Q==
X-Gm-Gg: ATEYQzxgc48LhvqhN7TwixEnNpBPWQJaCP1jkb+XwRaHqpdvQr/SPqtYsm0E31sEmu4
	ojx2xg4PQ3qgogW3SGjqQlO0f+jAKYAd4dRqU8My3MqBUpuA12phZMlQ2DtsNY/X1mioAuCcQbQ
	73QFUoeqGPmZGzNa3LbdDHbJcvyU2yQyKxRm65tanIuUy88579mRfypP95xlll1ITgrmUcM6XQU
	ozpIIlz9BVynL2p/q8i5FSYScXOM6JkLFgN/eC3xhHzAAG7CESqiQ7gYrVz7QeOPz4zparwsPxz
	W/0bMUyb8//wyqh9ksFj7WDZaXX1gwx1+WjugDEDzDLonmmNZYLKQqq/Po5BFuCPu0MaFl7SRE3
	BGp/9BtkF4LAMcFTT9GavvcrXHR1SBc3Va9Mecaqnw9nJVcQ1+e1zPMt4eUva7F3IiOlVew8wVR
	TTV3E2Z3z69mx90ZcuDAdmRg==
X-Received: by 2002:a05:6808:4f08:b0:450:4782:2b0e with SMTP id 5614622812f47-464beca70e5mr9277735b6e.15.1772560303135;
        Tue, 03 Mar 2026 09:51:43 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586474d4csm15115726a34.9.2026.03.03.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:51:42 -0800 (PST)
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
Subject: Re: [PATCH 0/8] mm/zswap, zsmalloc: Per-memcg-lruvec zswap accounting
Date: Tue,  3 Mar 2026 09:51:38 -0800
Message-ID: <20260303175140.1032459-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAKEwX=N-yzg66Ge5YgDNG7nh3ues62fSjmi6oGq1B=gkz6e2Uw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06BE11F4CD2
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-14573-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 13:31:32 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> On Thu, Feb 26, 2026 at 11:29 AM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

[...snip...]

> > Introduce a new per-zpdesc array of objcg pointers to track
> > per-memcg-lruvec memory usage by zswap, while leaving zram users
> > unaffected.

[...snip...]

Hi Nhat! I hope you are doing well : -) Thank you for taking a look!

> I might have missed it and this might be in one of the latter patches,
> but could also add some quick and dirty benchmark for zswap to ensure
> there's no or minimal performance implications? IIUC there is a small
> amount of extra overhead in certain steps, because we have to go
> through zsmalloc to query objcg. Usemem or kernel build should suffice
> IMHO.

Yup, this was one of my concerns too. I tried to do a somewhat comprehensive
analysis below, hopefully this can show a good picture of what's happening.
Spoilers: there doesn't seem to be any significant regressions (< 1%)
and any regressions are within a small fraction of the standard deviation.

One thing that I have noticed is that there is a tangible reduction in
standard deviation for some of these benchmarks. I can't exactly pinpoint
why this is happening, but I'll take it as a win :p

> To be clear, I don't anticipate any observable performance change, but
> it's a good sanity check :) Besides, can't be too careful with stress
> testing stuff :P

For sure. I should have done these and included it in the original RFC,
but I think I might have been too eager to get the RFC out : -)
Will include in the second version of the series!

All the experiments below are done on a 2-NUMA system. The data is quite
compressible, which I think makes sense for measuring the overhead of accounting.

Benchmark 1
Allocating 2G memory to one node with 1G memory.high. Average across 10 trials
+-------------------------+---------+----------+
|                         | average |  stddev  |
+-------------------------+---------+----------+
| Baseline (11439c4635ed) | 8887.82 | 362.40   |
| Baseline + Series       | 8944.16 | 356.45   |
+-------------------------+---------+----------+
| Delta                   | +0.634% | -1.642%  |
+-------------------------+---------+----------+

Benchmark 2
Allocating 2G memory to one node with 1G memory.high, churn 5x through the
memory. Average across 5 trials.
+-------------------------+----------+----------+
|                         | average  |  stddev  |
+-------------------------+----------+----------+
| Baseline (11439c4635ed) | 31152.96 | 166.23   |
| Baseline + Series       | 31355.28 | 64.86    |
+-------------------------+----------+----------+
| Delta                   | +0.649%  | -60.981% |
+-------------------------+----------+----------+

Benchmark 3
Allocating 2G memory to one node with 1G memory.high, split across 2 nodes.
Average across 5 trials.
+-------------------------+---------+----------+
|            a            | average |  stddev  |
+-------------------------+---------+----------+
| Baseline (11439c4635ed) | 16101.6 | 174.18   |
| Baseline + Series       | 16022.4 | 117.17   |
+-------------------------+---------+----------+
| Delta                   | -0.492% | -32.731% |
+-------------------------+---------+----------+

Benchmark 4
Reading stat files 10000 times under memory pressure

memory.stat
+-------------------------+---------+----------+
|                         | average |  stddev  |
+-------------------------+---------+----------+
| Baseline (11439c4635ed) | 24524.4 | 501.7    |
| Baseline + Series       | 24807.2 | 444.53   |
+-------------------------+---------+---------+
| Delta                   | 1.153%  | -11.395% |
+-------------------------+---------+----------+

memory.numa_stat
+-------------------------+---------+---------+
|                         | average | stddev  |
+-------------------------+---------+---------+
| Baseline (11439c4635ed) | 24807.2 | 444.53  |
| Baseline + Series       | 23837.6 | 521.68  |
+-------------------------+---------+---------+
| Delta                   | -3.905% | 17.355% |
+-------------------------+---------+---------+

proc/vmstat
+-------------------------+---------+----------+
|                         | average |  stddev  |
+-------------------------+---------+----------+
| Baseline (11439c4635ed) | 24793.6 | 285.26   |
| Baseline + Series       | 23815.6 | 553.44   |
+-------------------------+---------+---------+
| Delta                   | -3.945% | +94.012% |
+-------------------------+---------+----------+

^^^ Some big increase in standard deviation here, although there is some
decrease in the average time. Probably the most notable change that I've seen
from this patch.

node0/vmstat
+-------------------------+---------+----------+
|            a            | average |  stddev  |
+-------------------------+---------+----------+
| Baseline (11439c4635ed) | 24541.4 | 281.41   |
| Baseline + Series       | 24479   | 241.29   |
+-------------------------+---------+---------+
| Delta                   | -0.254% | -14.257% |
+-------------------------+---------+----------+

Lots of testing results, I think mostly negligible in terms of average, but
some non-negligible changes in standard deviation going in both directions.
I don't see anything too concerning off the top of my head, but for the
next version I'll try to do some more testing across different machines
as well (I don't have any machines with > 2 nodes, but maybe I can do
some tests on QEMU just to sanity check)

Thanks again, Nhat. Have a great day!
Joshua

