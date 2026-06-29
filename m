Return-Path: <cgroups+bounces-17378-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lq6iGTTDQmqqAwoAu9opvQ
	(envelope-from <cgroups+bounces-17378-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:10:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D96DE384
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:10:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CTsUoAeU;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17378-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17378-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9BEE303A109
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0739DBF5;
	Mon, 29 Jun 2026 19:10:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A9382F05
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 19:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760232; cv=none; b=taUkVJiQHAcM8fKCtZHHOyCaZ/ns6YSEU9aKCnewMHiwTtXAJPxZaD2AoBTjLDkXZ9ipZZSppbNcOp0BIAyGObZ+VcOoH9VpQTR1u0gdoxha7mO+XucNl+NM6ZvIQq0+j2taHhkUpa6nGIhv62rDqvUx+ErbyiR3OKkT0eBt+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760232; c=relaxed/simple;
	bh=5GCD0k2wHB4fN5o0m9P+G5gpRGGLNrHpg8q8caPBXYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgjDk7kK7AaYFTDdtzxkL9IKt7IsFrrl/6qnfD3Vh9+TSJD6rdFz8fNDHnXMuq8N+3/B5Q7Q/9YcxKOP6jRgIA73g4xUxyo9qopGFOTE1lEN3Tn9Gp/OPG+8KGfxFBmN8foPvFhMTcgUgjJ9yRoOznufkPibxRi/NhJCGPivSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTsUoAeU; arc=none smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9b4f8ade0so1856981a34.2
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760229; x=1783365029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqlqX82xmlKGNezyrTYUwMGt6l+Ufnqh/0K5ySWqGfo=;
        b=CTsUoAeUvw3T0Qrmk3eYWPUY2930H3IkRSmlnX9iyZBq9nL/kSd3LGmcBE+OLwRJc9
         8pDBJCDvO5oHR52K2OFR77cottprYe1JvNa5NXDmhSmnF1IDIn67Wq6Uz3d9xGKBa8WA
         FrRc1SB9XccisuBn303BRw4md6PSdE8/24PHhoz9ycz67GoBwVxSQM+FfJ7J1FY7joE0
         Nupl8L3ThyO6GvEHEWZTpPVXXc48zqEkbDODxj+IJHCND0tRUralH25t8CkMEhT+1ueo
         pZuk/DsPf9oIDTtnpYJmzpqJqGqjPuTcU9k3pDaIJN6UYi2kJS3q2K8PQ8QaeGKovVWJ
         A8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760229; x=1783365029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YqlqX82xmlKGNezyrTYUwMGt6l+Ufnqh/0K5ySWqGfo=;
        b=X5tGp7V1/UuX1fuNIIdwxhp3YCyzTkY5KfdOc8FM/ujHewyqpO8XYXYEzXlILFFpfz
         3RWSrRuO0x+S550HifsXAMtqdfypvSH0s7WIM5eSeeXfccqB4OZ/vpCQQoRniMfNLwYn
         mohEjFXh8KGZRUfJRaIhoq/q4G6xnd+HtoVur5EU7TSd0iGm9fIhT6OxM+4T0p/WV6pn
         T2mxacWE3d/cSLl/O76Nd3F9gh8haGogdtmHhbvHcigZiwe5AyGOfA8V3qYuHkf/MHlr
         gDy87XMtJymlv4l3xUuCkw67Bn1v3/uXYuSO0vbSV2tP+4ucIHu/wWKzMXTWsXyxHfrI
         ks/g==
X-Forwarded-Encrypted: i=1; AFNElJ9KnEwfuMPQzoMra5iBDoNzUPS0Ji7HQSpcZP3doQGVz+YNPMPNQTmcOYCjLeJz10x8oB0iuCMI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FQhbRDUOtz3oROwEUYGDcTGFNWTLZ3tQSgG7hLpC5jYpQ2UK
	F1x/XhJ0311CwklyfU94RNEJVzEflX72DDYRZMpkejo1oVxd5DlHRb1y
X-Gm-Gg: AfdE7cnatcAvn/fNbEj+D7xVvElCpVlEWzqtmh5DhYyWuooXl08kXiDVtSQWeWNiB+t
	qm1/NW/4hMdt7OXpSwK4oqetrjKKgUMgdqCpZn0UAQKAfpCG0ECOCfqjLTM+QuesJoyBWo5sbvi
	ZF5j6nJCezunuEojCyh7C9J5HxWvRYkJQbLH61Mluik+/7kWH9ifxgg/CGtRMmjK4lYCBNbrVxj
	VImXN5cu8Nfq5aAOHYIJixTTHQGLhDmvE/MU1mk7ZNV+O2sC1z72/BRiVwOx/3AwpFALBK9c3vI
	Yfi4hojazr8GqUreZFjUWzHTkJwM7m8jeAi5K+YWE+9XmV+qWypfrOBdA7mEGHsuzd8Ph64x/uG
	rvlYibYzf7x0grk4uDedEg/rVi5uL03sYJGAQ2vT+qHm2bqjkXo6r222hcw1FElg32p9TiYX2un
	ZsBNudi3JaaC06gv2PjGgAc8aXyzhg+ucH2XHVpfnslQ8=
X-Received: by 2002:a05:6808:1821:b0:492:c931:4d67 with SMTP id 5614622812f47-495ead9873cmr594933b6e.1.1782760228797;
        Mon, 29 Jun 2026 12:10:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49352506000sm7433362b6e.3.2026.06.29.12.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:10:28 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: alexandre@ghiti.fr,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Ben Segall <bsegall@google.com>,
	cgroups@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kairui Song <kasong@tencent.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH v2 4/9] mm: percpu: Split memcg charging and kmem accounting
Date: Mon, 29 Jun 2026 12:10:26 -0700
Message-ID: <20260629191026.2124952-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626102358.1603618-5-alex@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17378-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex@ghiti.fr,m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[ghiti.fr,linux-foundation.org,kernel.org,google.com,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ghiti.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B46D96DE384

> This is preparatory patch for upcoming per-memcg-per-node kmem
> accounting.

Hi Alex, I hope you are doing well. Thank you for the series!
And sorry that I took so long to review. I'm slowly going through the
series, so I expect to leave more comments in the future. 

> Percpu allocations charge memory before knowing which NUMA nodes the
> pages will land on. So we need to decouple the memcg charging from the
> kmem accounting:
> 
> 1. In the pre-alloc hook, obj_cgroup_precharge() reserves pages for
>    memcg limit enforcement without updating kmem stats.
> 2. In the post-alloc hook, obj_cgroup_account_kmem() accounts kmem
>    and places the sub-page remainder into the obj stock after the
>    allocation succeeds.
> 
> Because of that decoupling, we must not rely on the stock in the
> precharge function and always charge the necessary pages that will
> be accounted after the allocations happened.

I was thinking about this, I think the reality of the sitaution is
actually a bit better than the description makes it seem. We're still
using stock, just a different level so we're not losing any
fastpath at all. Previously we would use the objcg stock to do the
charge quickly, but if we're going straight to memcg charging, we'll
be using the memcg stock instead. Maybe a clarification here that
we're not relying on the obj_stock would help your case here : -)

> That means we may
> temporarily overcharge the memcg but the obj_stock draining will get
> things back to normal.

Nice, this is quite clean. We might hit memcg limits faster because
we overcharge up to PAGE_SIZE bytes but... I'm not sure if this is even
worth noting since the window is so small. 

I think in all the places where you use PAGE_ALIGN(x) >> PAGE_SHIFT
we can instead use PFN_UP(x)? Or maybe DIV_ROUND_UP(x, PAGE_SIZE)?
Just thought that this way we could avoid some of the two-line function
calls ; -)

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Anyways I think the split looks clean and makes sense to me. Sashiko
raised no concerns either, just wanted to note some nits. I imagine
there will be a v3 in the future? I think this patch looks good but
I will wait until the next version to leave my signatures in case
some of the context changes.

Thanks again, Alex! I hope you have a great day,
Joshua

