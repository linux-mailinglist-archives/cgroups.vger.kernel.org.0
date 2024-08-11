Return-Path: <cgroups+bounces-4198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE094E2E2
	for <lists+cgroups@lfdr.de>; Sun, 11 Aug 2024 22:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B291F2108E
	for <lists+cgroups@lfdr.de>; Sun, 11 Aug 2024 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE014F9F4;
	Sun, 11 Aug 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZNlx0iQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C411CAB
	for <cgroups@vger.kernel.org>; Sun, 11 Aug 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407417; cv=none; b=c+eZG1BbUM0p2SA4JdcqmhU7TgQU+nc+8976dQUxi0dUmtPOGrCNGkAI8t/sodbFYurS76nMBYWt+QQcl5vaDw8LBhPY5O3rff9X2b44pHLC/F/kj//jXeDbpSgXv7AV70xMQTlqEtlNfk06N0DMqJlqrotwQArqGmYMLa4j/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407417; c=relaxed/simple;
	bh=tmD2Y5QmLgqhxfA/Y0E9f318SD+AiDzfhZG38n1nVAY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C6Yp/QbaZfkQGMo6u5iaCjGAqtNgIx1w590RQXelspMCfFjxPuhSHt9Q8pnw9nvzOHDmFEt1Pp2/JLuvhaJqgD6/xh99NRzMvlWypkN5Jl1919kN0/Q2WmaFJBzTL0W5q6xoyMZyz1oAID/PVrYXG8Rzkr+oO3triMOEhi5e0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZNlx0iQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-200aa53d6d2so224285ad.0
        for <cgroups@vger.kernel.org>; Sun, 11 Aug 2024 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407416; x=1724012216; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAhUoo5pDgGhIiuV+sHAbITY8GMWO4IlHepz/Cnoit4=;
        b=wZNlx0iQ+83BKOOdCDkB5acqnq6AwwThYqEIcjtIaaXqTQ8CkwHisqLcMrZUjpyEc2
         /c6rrY33lzUVoOETetM6fwvttU/wL2yyxyYJ6ZNsJZhyh7ubumDFsPJjJQTlImEUKyIB
         PvSkRJ4SaHstwhDwCzMHjSkwuDnGyk0Fo1UNndh63ZC0kV6VxUrzg+v4ETt39kRpa9oh
         OYf/Zu7bs0bvtIfqsZUzV2V63/i8IAzIK3ee9xcEdLANdKBk8k4Bo02K4daF/Ovr8hfO
         Pk5x5Giqc6v7XzBfLfTjb29CrFLPl+vCFk58U+cuBp5KcC9ABO9L66u1xM9Vr7OXp+T1
         +RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407416; x=1724012216;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAhUoo5pDgGhIiuV+sHAbITY8GMWO4IlHepz/Cnoit4=;
        b=XwjUIeVMVd6FK02flvtVHwSDt8GH6nvuK8aDPGzgMfyjm70apmsBVoTKVGwXVf/sym
         stTmHgBNIFdywxyI3p5Nywz9f1V0qlqYUuKGcTJZcU3oVBl5xAbCpKFq03XvTX4T0BD1
         q4IFm7XrGy7Uqa5gksVBd2dtKUzgMLE7TlcJFr1h67C2c+dC019mVXhaJOi0JkZenOEG
         Upl2VNKZcjOfzxzV4j7vwWxj7O2CSvJThf5e9iIxZxV2KPyNcIzJxKlJHukCVkb14pfe
         Dnm0gk+5KV4mECcvICn7sP1EWzQROg07g/odGpQDu4IZuvK4Ruc65fekhMMgUWQvnksc
         z3TA==
X-Forwarded-Encrypted: i=1; AJvYcCVdaGJ16kBCIxvnN/cu5FZf5tdEIxRqHD1Ppf1NZWqnThLtQPqzC3UkMZH1xlEw0EHRBZ6CGuUQkI5efdDblhXK6w4wxAg3aQ==
X-Gm-Message-State: AOJu0YzQjNn0EtRCGwrjJWCtU9ZMXwVl7aqiRCbBQDGq1+dLl4ElMItb
	0YdqbbfXK04JtZnN2XK1Smsx9jr4N8oyArX/OctFpq0WFfcMmhWsngRKnyb8fA==
X-Google-Smtp-Source: AGHT+IFv4yaKcppkZbdBT6BpaVbXa612XbC3+tUsPYrhO7uViPdMKbr68w5ZQhUbQvBnYT+D3oGyBQ==
X-Received: by 2002:a17:903:1c6:b0:1ff:4746:8ccf with SMTP id d9443c01a7336-200bbe23396mr3228185ad.26.1723407415369;
        Sun, 11 Aug 2024 13:16:55 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb39c05sm25687225ad.276.2024.08.11.13.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:16:54 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:16:53 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev, 
    shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
    mhocko@kernel.org, nehagholkar@meta.com, abhishekd@meta.com, 
    hannes@cmpxchg.org
Subject: Re: [PATCH] mm,memcg: provide per-cgroup counters for NUMA balancing
 operations
In-Reply-To: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
Message-ID: <e34a841c-c4c6-30fd-ca20-312c84654c34@google.com>
References: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, kaiyang2@cs.cmu.edu wrote:

> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> 
> The ability to observe the demotion and promotion decisions made by the
> kernel on a per-cgroup basis is important for monitoring and tuning
> containerized workloads on either NUMA machines or machines
> equipped with tiered memory.
> 
> Different containers in the system may experience drastically different
> memory tiering actions that cannot be distinguished from the global
> counters alone.
> 
> For example, a container running a workload that has a much hotter
> memory accesses will likely see more promotions and fewer demotions,
> potentially depriving a colocated container of top tier memory to such
> an extent that its performance degrades unacceptably.
> 
> For another example, some containers may exhibit longer periods between
> data reuse, causing much more numa_hint_faults than numa_pages_migrated.
> In this case, tuning hot_threshold_ms may be appropriate, but the signal
> can easily be lost if only global counters are available.
> 
> This patch set adds five counters to
> memory.stat in a cgroup: numa_pages_migrated, numa_pte_updates,
> numa_hint_faults, pgdemote_kswapd and pgdemote_direct.
> 
> count_memcg_events_mm() is added to count multiple event occurrences at
> once, and get_mem_cgroup_from_folio() is added because we need to get a
> reference to the memcg of a folio before it's migrated to track
> numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
> shrink_inactive_list() before being changed to per-cgroup.
> 
> Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Hi Kaiyang, have you considered per-memcg control over NUMA balancing 
operations as well?

Wondering if that's the direction that you're heading in, because it would 
be very useful to be able to control NUMA balancing at memcg granularity 
on multi-tenant systems.

I mentioned this at LSF/MM/BPF this year.  If people believe this is out 
of scope for memcg, that would be good feedback as well.

