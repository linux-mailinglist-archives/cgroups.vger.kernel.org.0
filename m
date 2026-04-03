Return-Path: <cgroups+bounces-15169-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG6POLXMz2m50gYAu9opvQ
	(envelope-from <cgroups+bounces-15169-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 16:20:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7EE395223
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970C530D67F4
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2026 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236C3C4542;
	Fri,  3 Apr 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw1vH9Wz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6LGROoX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA2386427
	for <cgroups@vger.kernel.org>; Fri,  3 Apr 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225596; cv=none; b=sLk9Qe50LcLpIsfpqL2aEydJLFvgLJBtCeYnt5WOgfkPpEvN+8T86lJXFZZ+4McGFV252+TongUSD+cO99hHoywMcCpXkbORP+hZMTmaSWCRhO1PBv5BH2xX0D5CWAvIRVZJpTkQu4rpWImT6lewURxxmfKfjL03tlxIreLy5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225596; c=relaxed/simple;
	bh=pKR+okoCybqgnvAwwN0fmXR4Q8RrZm0wNhzQW0p4g3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8vtyL8NNUQGUGYtAVfBZHAtd8sxgW7ST2M02/32vJ2IxjraczNuoVxFku1GAnv8JJCyKFvo6jpX1QPglKi7uGdY+04VFmBCmDqwu0RNskh8p0ulPvnA7F0Ozh1Zei5/R64y3J0B6lAjFsfUVpyuVmdbhODJr7N8GWll85Nwx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw1vH9Wz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6LGROoX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775225594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2OXmkPnk3xdLi6S85WCOSMj2pCVYR8dHaWwnDoveRE=;
	b=Fw1vH9WzkLV0kB9htYYwuju/QCwYnEvPzffJOimRcNAeznXBhISWp+VYz9UlnCbOj11r0g
	Sqs5tI4LVCLw+sGc9XJ8FxhiYs4fdyPV2PwTJMJ6XXFSyxJufboYPSqi56NtSr4D/Ni9YY
	sZXM9JUmkiloJ9jwD0B1eDZn+mnJECE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-uSOGESxkNke9B8CR8YZ6bw-1; Fri, 03 Apr 2026 10:13:13 -0400
X-MC-Unique: uSOGESxkNke9B8CR8YZ6bw-1
X-Mimecast-MFC-AGG-ID: uSOGESxkNke9B8CR8YZ6bw_1775225592
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a1f96bf221so74041636d6.3
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775225592; x=1775830392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2OXmkPnk3xdLi6S85WCOSMj2pCVYR8dHaWwnDoveRE=;
        b=R6LGROoXW6ZwzHBKEiwXnn2uA8/HHGcRPAdjqne9MXGYk5BbntXhXWE3b62fgUFQVm
         gLTmWnWOZmjM32R5vFYbvXZSg2WVIp7EtqvINWEZq78j9OjwdyQ/btUwC+m2eP0kJQgF
         zP1Msj88PxEGhGd3P6Qga5tXg3/XeFpR+ReZrnrQ54rOQva73wCeCSlKgRhuaAG10w1E
         qQKnUVkbOsvhDrMnjpi0A4Jndr6GCkyKAwXLEsTOfHMEK88dY7+5gtvDXqypoVbuTVDj
         vy9Dcj/lkIwQqH6c0DIMiNTaLbYt+MpXz/N3QxHUJE0tvCAQiOuRIfVhjw/6YunUcxWl
         o/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225592; x=1775830392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F2OXmkPnk3xdLi6S85WCOSMj2pCVYR8dHaWwnDoveRE=;
        b=f0myXCSnyGSXZ5UevOT6uiHFywS8c23APOwPmoQVwS7t3VOU4RGakMG8PGnc1ZkekA
         UVWA9pVEe8O3SAU9NZLxSOC/ptbwbPwU1T++a2gusZR1riaDqaCcXPTeUQHGp7am+Hw8
         qriTJ11uFzmhXJWOYl+Blmprnj2BtkGVQuZ5lFsqM33LjF1hRVV1iQ3g+5f4aVpGnUtH
         QjzMi/8yXoASs1xGJxg9HHWeFMG1u0S8lUY4uOQjLxan0XmWitQetdZRMF6wT6hlTuqT
         Ac1qOb7EYtbUo2UnERdsXLcDPFn/SSqo7GxxlDwt0yG1ozFH5qONvIN61yquTJeN+/Q7
         2vNw==
X-Gm-Message-State: AOJu0YwdXtJXjtvY6Tphk9syGoIa1sQJZ2+E7Wg+3GcGSEWvqtFlrfV5
	OnB4IE51GGmgEbUzVeVzjGQc8/yJ/8LZjUwhs+Y9qeyc6NxEeha6pBJ5ivz3HUDbaZdpUyxhjUL
	T5KR0J2Ab3VwWk+dyQ9tXHTkF7GRLVeHjKJWXO0qoDNEpHx+zg7C3wCGpIHw=
X-Gm-Gg: AeBDieuB95QcPVQFaUsK8RwMo+yLsgCSrZ4ZQZb9MGH7u0su3SvR75HFm2OtfQcIMz/
	BuDengPLAW/l5N2drDY/QqZgJL+kbfgShjSShO6OPRJOIt8FYf5krvy5drWLIzwIIz2EAKJNMqe
	ThiECO+GhEMrBijixSBnp2/2zJjLCE1iF5e2oeV9CmM5bXZ9jmScMraEluputWBhJ1NA3afTxCL
	CYUjUzDU8OWY5XnDL66rRwlW2NCdGw7XcMcuJ8+95+uWcgDYpZ0SD2O2S9fgOPPbxWcoa9vpKQR
	k/o3H6bmQ/5gxYFgZAovDPSYsqJ6BtPjcbQqFN8D8BUVZvg2ENqojQTRRLTkZVjghXPjdfePn3o
	B9Zcgu6p4kj10KQImHQL3Rdg+ALO2TBLkNimeD6nUIIhdQ0hRte1eV9W4VcgarDU=
X-Received: by 2002:a05:6214:76d:b0:89f:123c:4d9c with SMTP id 6a1803df08f44-8a7025b7636mr47917186d6.18.1775225592236;
        Fri, 03 Apr 2026 07:13:12 -0700 (PDT)
X-Received: by 2002:a05:6214:76d:b0:89f:123c:4d9c with SMTP id 6a1803df08f44-8a7025b7636mr47916446d6.18.1775225591562;
        Fri, 03 Apr 2026 07:13:11 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net. [100.17.19.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593330a98sm50147126d6.2.2026.04.03.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:13:11 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Fri, 03 Apr 2026 10:08:35 -0400
Subject: [PATCH RFC 1/2] mm/memcontrol: add page-level charge/uncharge
 functions
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15169-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E7EE395223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose functions to charge/uncharge memcg with a number of pages instead
of a folio.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 include/linux/memcontrol.h |  4 ++++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 70b685a85bf4cd0e830c9c0253e4d48f75957fe4..32f03890f13e06551fc910515eb478597c1235d8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -642,6 +642,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
+int mem_cgroup_try_charge_pages(struct mem_cgroup *memcg, gfp_t gfp_mask,
+				unsigned int nr_pages);
 /**
  * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
  * @folio: Folio to charge.
@@ -692,6 +694,8 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	__mem_cgroup_uncharge_folios(folios);
 }
 
+void mem_cgroup_uncharge_pages(struct mem_cgroup *memcg, unsigned int nr_pages);
+
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 772bac21d15584ce495cba6ad2eebfa7f693677f..49ed069a2dafd5d26d77e6737dffe7e64ba5118c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4764,6 +4764,24 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
 }
 
+/**
+ * mem_cgroup_try_charge_pages - charge pages to a memory cgroup
+ * @memcg: memory cgroup to charge
+ * @gfp_mask: reclaim mode
+ * @nr_pages: number of pages to charge
+ *
+ * Try to charge @nr_pages to @memcg through try_charge_memcg.
+ *
+ * Returns 0 on success, an error code on failure.
+ */
+int mem_cgroup_try_charge_pages(struct mem_cgroup *memcg, gfp_t gfp_mask,
+				unsigned int nr_pages)
+{
+	return try_charge(memcg, gfp_mask, nr_pages);
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_try_charge_pages);
+
+
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
  * @folio: folio being charged
@@ -4948,6 +4966,12 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 		uncharge_batch(&ug);
 }
 
+void mem_cgroup_uncharge_pages(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	memcg_uncharge(memcg, nr_pages);
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_uncharge_pages);
+
 /**
  * mem_cgroup_replace_folio - Charge a folio's replacement.
  * @old: Currently circulating folio.

-- 
2.52.0


