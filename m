Return-Path: <cgroups+bounces-16678-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8NFCLA0DI2qbgQEAu9opvQ
	(envelope-from <cgroups+bounces-16678-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 19:10:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ECD64A043
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 19:10:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y9vUBRrg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16678-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16678-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59BAF30082AD
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5137DEB5;
	Fri,  5 Jun 2026 17:07:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4B416CF5
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 17:07:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679267; cv=none; b=N8+2ENXJ+J9DjkMa/PdA1qfpossd2DCFZjapg4as2MjhscxCKdJ5qa3jXquTTooz0b00BJipFWvCRTW5hETgMryJ0D9U70SEfmfE+fTl6d4jgefTx6BYeFyIroeT34FbQ/xp/TKdTMSWYOH10cr21/EBHis6fvacOAxEv2jzIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679267; c=relaxed/simple;
	bh=zyAzjgNheCu5UzZcmkW2Vo/6l+PANb/K/lhIHU2Fsyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiaCblNZl7oiMGR8xNQl5T0fstC04iFAAOXYMhYlB/THoO/dvQ5eCJYARi1qz+oH8Tr+6ZvbO96SlvFgI4eWYXB/VjM+UCGdxFDCbEkvoh5Ck0bOt9jd9TKN0hYYYiIMDVbwIS33QpZhXdqUYFenwILcuIzDy0rUH6wZsKEU1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9vUBRrg; arc=none smtp.client-ip=209.85.161.41
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e66e11386so593052eaf.3
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679265; x=1781284065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfdqaOn+smG9hY8rD85LL22KMJy+2AytX3mGNk8Tobs=;
        b=Y9vUBRrgcGTVJjtKm0Q0pV+ANQZAaQXVrqG6wPakXhH6CctBGkZTn+0Gwsu5Y5ZoYZ
         Wf1eJjE/Y2JCpkkhMizoRNAALjbrgDb5zSWCjrzSe5FKSGM7ofTzrsqqLpoE40hCKuiI
         v5JzBPP9h85Odx6rM0U2Xe6VbWk2M7E/6OdawDV9x6GIjO8F2K2nEhrNsWDtQJdlPK4t
         OZYQ1mkEbZNNOKEDBqhUqyV5TsfREWqCCqSpifdtCXHVNvPaKloYAaYm7kifg1wx00/T
         8E/P0n2ET9+jRVoHkL8uPsx8LiCe6wB1R4AZKWKKXTKD/f21lSs4WGJYYGKfiOVxKS4u
         +dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679265; x=1781284065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wfdqaOn+smG9hY8rD85LL22KMJy+2AytX3mGNk8Tobs=;
        b=WTs3oP/nxcFbGIRiuOJajGmiK9jNDG9Lpj2I0NSKjRUlyrcy3wlga/VUNQVcL7r5CY
         6BYQCCD/xlIZ+k7xfLI/bgRw3R7CcBZys7ogXmFQFbSc+RLbc6kSoU2FKkMAXU/MJ6fJ
         N9ZRIsFrT78MVeHm466bOwrBzkcQfJ0akY45KnNgPSKCrtOIn6FnkT5qPZIsulcbJybr
         n2u1SjnlOfp6D7wN4zJtWrXYtyM4srTKawtIt6tyoQYl6vzJ5b+nh5/kJ3+MYSQNzOS2
         mYq0GoG1MlNePR2Nc73fygZ3UYTiYGK2p/yfSPNLCiqqqo+wnwl+Ebr/08Ipz+u226qS
         lD6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8prgnkMjzJiTVxL9W8pxt7/nJ58gjw7olOgiyTPWdYvwn624gOWMR/cBPxAXTRQUVGOt2dE+37@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jE3ivUQ7gPAQ3oQGKOBuPYgtnurzHKfvme/yGAeKGKZHT1j/
	CLvY707bXpUT2XcQi+0sVMWC3KxaE4W6q0uWBdOE59wi4ncth6bN7X1p
X-Gm-Gg: Acq92OEWp54B00wqu1LzkBEgPFJjdBuVkcQDy6Vz5X4MOWfj7gqt+ptSXJ1I7//9Wqe
	Bc4SCF6sNBk+R2k2rInbWCsllD6+l7KPNS6t9vyGwGMZONwBGhTwxKV6W/ijNCFcZ1r2HUR0mAB
	680YyeSi/LIzWh/QcGBJVngK/AEu10bhomThi+SqI3A8Ju6BBBY/7whuO8UtpIA6jKVpoPhsCnM
	7G2ySGCAdR4AI4MFdcZItOjRnefhaPVPIkLfBSRcs1znHanP/8nf5IV/mS9VoRU9wiLIQZN3F2/
	1DNrFHpfud0RlkR0wnMa13spfl1S/Nmx8575xoSBPCdPEi7TS68aVF1T2szA6KSLFc3j6bsvNLL
	rVIJQmw1rSSw6bhCVr0GW5T7iWPEUWopHbOiFAZHAiRVF9Y8uimXEny8QHs+soXYb91wUlNvDbd
	4d2d+2CnJr0ArRQ2UpCAqXnboFIkwsQytc4xAWhF86bhZu/YzIv9q4dnre5xPd4xf6
X-Received: by 2002:a05:6820:4dcc:b0:69d:7a88:9ccb with SMTP id 006d021491bc7-69e68b94fe5mr2444413eaf.24.1780679265289;
        Fri, 05 Jun 2026 10:07:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7c42c33sm7420128fac.6.2026.06.05.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:07:44 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
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
Date: Fri,  5 Jun 2026 10:07:42 -0700
Message-ID: <20260605170743.1292597-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16678-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org,kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25ECD64A043

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

Hello reviewers,

I was hoping to receive some input on a point that Sashiko raises.
The draining work we do per-cpu uses work_on_cpu(), which does
schedule_work_on() and flush_work() on the system_percpu_wq, which is
not WQ_MEM_RECLAIM. And drain_all_stock() runs from try_charge_memcg()
on the reclaim path, so it actually triggers the check_flush_dependency()
since a wq_mem_reclaim is flushing a !wq_mem_reclaim.

In my testing, I haven't seen this become an issue. The flushing work
and draining only takes a local_lock() and does atomic operations,
and it never allocates, so there is no question on whether we can make
forward progress.

But this does slip up the WARN_ON since this is not obvious to the system.
I see three options here:

1. Trust that this is OK, and document that we can alwyas make forward
   progress.
2. Keep the draining work synchronous, but queue and flush on memcg_wq
   marked WQ_MEM_RECLAIM instead of just using work_on_cpu(). This would
   add 2 words per-cpu-memcg for the work struct backpointer.
3. Go back to asynchronous, which would get rid of all the synchronous
   concerns, but add an additional 2 words per-cpu-memcg for the work
   struct backpointer here as well.

What do you think is the right decision here? I was thinking about this
quite a bit recently but just decided to send it out, but I think I should
have asked for upstream opinion sooner...

I would prefer to keep the memory footprint of this series minimal, and
opting to do things synchronously helped achieve this goal since we can
get rid of the backpointers. But I think this is beginning to show up as
a tradeoff, so I would really appreciate any input on what seems to be
the best decision here.

Thank you very much for your time!
Joshua

