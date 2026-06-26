Return-Path: <cgroups+bounces-17314-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fW1jBw1RPmqxDQkAu9opvQ
	(envelope-from <cgroups+bounces-17314-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:14:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951DE6CBF60
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17314-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17314-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ADF9304B7CA
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61513EBF20;
	Fri, 26 Jun 2026 10:14:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432E3EB0ED;
	Fri, 26 Jun 2026 10:14:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468861; cv=none; b=UMVH3M7chalZX0KFLoOwJpb8sGCTng8S3yf7e8rg7/3RCiLxxwgQhJ8eUGN1WkfWlgtPSszeaNwh63XIu0DugbvvBiTj55pyAPNkIlISXwT2GvAbYGZoJTjrxm73+I/zVq3i1G9+0iO8lywgkXVNKSZhKveA/1YzY0vFPqrlxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468861; c=relaxed/simple;
	bh=d5uFmXyI98y9nRyOPM0/269ojXox2TE5rCPhyMeyHgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7SrqyR+9eFoO2uczhKLupsw7IkylXhGTN6vrw0NMsXHyRdyWpm0zxBf0dvSM79rE3XNH99J9qrqoVCkFpPox/2kbwpV96dZBr020Z+MjBcC1Gz5dT4KRdJo6JFs4c2US8vXmRl0lCCRHL4hIe2f4/5QBkRurw+kW3YBOnwMlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Received: by mail.gandi.net (Postfix) with ESMTPSA id 263E620CC9;
	Fri, 26 Jun 2026 10:14:14 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
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
	Yuanchu Xie <yuanchu@google.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH v2 3/9] mm: percpu: fix obj_exts metadata charge size
Date: Fri, 26 Jun 2026 12:09:30 +0200
Message-ID: <20260626101356.1599643-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101356.1599643-1-alex@ghiti.fr>
References: <20260626101356.1599643-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEBI1JGbXlpiiDp14fkAsKfAN5fPZBM2Ab7MYJnFM3+SveTMVF6Fpqo1pIn6X+1iOtVOzIUV5Y0lYysvg8wUhEu6iechcA9ZS1suPyZBWm40kuX54tSMCypoKaVvhov2zRyofq7gzsMmi381Aww594HETMja5HFS74ld7NppEkUPFcpepMRwyMI5cA7mkGe/vhPQABef+NqYfMk9kxiJ6/r8++B4sCphBOA9I/gZUpooOC/H1BTNf8jBjGO3awTrxngcQpM8nhCbLDXRzq4VxFUibvIrp2s4IHqQiAqPfb6IAcP9PvJXxAvxWk/3kLhKU6wNMf25eg1lrylx+omoElrMRhXPRTU5QAg55P1A2fULuVyjLaTCVf7iCHGVBwHvfUvN5AohRVwGfhnIDVwSRogQ8qtU6eHoi21/nWgO7QqbC8D34ZUT6xMWTVoNqENRF6wTglzFj3RFNzyrE64W0+8gPQZTZmZCCEdMOhU12z3BO+Dlx4k1PrIkTJAFe+Ubve4yVGt3pqebgd/QQo5qYcKAZMSbK+ItdwIVu+1CxpwBldP1RCI0BoFxYedUvs9q2yeKwHnxRzF99KLVnof+nFpoen7mheYmrlMO0ml12sKHpjSX73fHArGxufNUjCDHUQEyCfzYVIEatnwZjdax3fVfRGWsCn4cYTj8KhC3x1I2g
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17314-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:axelrasmussen@google.com,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,m:alex@ghiti.fr,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ghiti.fr:email,ghiti.fr:mid,ghiti.fr:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 951DE6CBF60

pcpu_obj_full_size() uses sizeof(struct obj_cgroup *) to charge the size
of the percpu obj_exts metadata. But obj_exts is actually a vector of
struct pcpuobj_ext, whose size, when CONFIG_MEM_ALLOC_PROFILING is
enabled, is 16B and not 8B like sizeof(struct obj_cgroup *) currently
returns.

Fix that by using sizeof(struct pcpuobj_ext) instead.

Fixes: 8f30d2660a38 ("mm: percpu: introduce pcpuobj_ext")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/percpu-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 8cbe039bf847..d1c0a508710e 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -156,7 +156,7 @@ static inline size_t pcpu_obj_full_size(size_t size)
 
 #ifdef CONFIG_MEMCG
 	if (!mem_cgroup_kmem_disabled())
-		extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
+		extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct pcpuobj_ext);
 #endif
 
 	return size * num_possible_cpus() + extra_size;
-- 
2.54.0


