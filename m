Return-Path: <cgroups+bounces-16255-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKi1BHSdFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16255-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D15CDE83
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2DC330098A3
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39153392C25;
	Mon, 25 May 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsOgzCmz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB70386564
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735906; cv=none; b=UvyOcsc8gNCYgp+quKL3ly+IB1PPi9WpFQBDLGcdaByyW4criGxzusD0ndVz1xsQMb0RvUGDNFYWsjfuIPnd7HvqboWYiHASaxg64fIS+sFIC6771Ei/KFa9ZslVX9g5TqFu7MpkXNJjVE4905UtygSO/RohXZPG6seXjZUBzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735906; c=relaxed/simple;
	bh=bTlx5xfQqrhQmXD9/D84ZEOgc8v5KD0QPZ0MqCBJAak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOPYS80mAATzyjl1zy/hTLIu1XU/BUtrRjbahVUWv1r0XRTDhjkSdZEJHTPsN6nLAzIE155x4bpAZ009WkmlM0Sjkx5vmlG/m/9Q19kHm9WR0wawqvjWQ91dUjaNZ5qpvkUZOtXHtRAhio6/1K9GcRmXG6uVfaWDiqLZU1KBveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsOgzCmz; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7de44ed7a11so9250104a34.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735903; x=1780340703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMrn8GveLC1NdRQvZAymrZa6CvaW/GKC3sRoShkKmw8=;
        b=RsOgzCmz19SDcp7N2tzO7U20cJnRdApwyrwl91AREGuSiJHM2aqVBAB2OReqHdtkv3
         37Fn4wzXMO+s/vkJk+7b6VBQBkd/aYqtPVFcZA3OKqpSDsBpfCD811HuIj52oyOdSvfJ
         9XEaePuBwDe7m+AulLrErG6LlLx3YyhAhYPOTn2on/cavANlXTVi5B2ziJmEq0NkFuV5
         zu3T/L8HV3tl3nkmCHbIshJxWukdIHUhg96SiNMMdKO/sUJgnQCdCm22+M3PLWBhCcF1
         FqcH+pGrRScyW5HXkS+xmA/tA2D1EPgGcfbTX9POJu4bB+9GRq+mg7g13E6zxmW77PNl
         xSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735903; x=1780340703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMrn8GveLC1NdRQvZAymrZa6CvaW/GKC3sRoShkKmw8=;
        b=dN0TI0IkgbMjqgv//h8iH0Ga5KBf7RuTDU31J9D52hVF4P9mUl1TlRbJFTykF1Rn1z
         dxw0ltcpJgZRHpyb1BDvd+JC1aHPIrlbT30RxqT54Xv4Yj0A54c08mzdCD+QrOfQkW1N
         odZI2k4hEJtpGybl4t/vfRB3hOR+fUPWzuh/TXwNiqrxzz3qK6AsPkfq269eYBDkIhQD
         4cmo6hnKg61LXMMgNVrwHcxHGVRdsq+T1YUAf0C9zKlM0ZR/qle9EVey/BuhSbydvOdy
         kpDWoXCQCtRcxnWso6LzeWJINdwMlp2hx1/vEzaHc9kY1qcbNeaHmZftmmUlwxfqH/0h
         oX+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8kOyvWr2vujxBAE8mQLNJ4beapJalPD5PlJCZ9c1oGnlsQcj884BCUkbj9Hh/yvk58SLsa6raK@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtJH3DqHNb/FjFZ4ow1lZeFxrelwYcSj3GrvYc+39JakckakU
	gos45umykQLKiszOYsECa6Hkb6kvPLVuKeEDnD2KGsDgiPKIxeA2C6bk
X-Gm-Gg: Acq92OGJhv2N1mP1Mkd/CdGmhSQ1jmSmppS5AVnmWDP6pEoSow7/hCqf1AbV2JJEXZ7
	cTF1euwwsk4IpL3G+dJheyA6GHmxFkAwBS3M2oPViKpNrLXmc3OKOLakHE9tOh1O3dDX/usw1Rd
	19NuZcDFok6W7Ck00z7jAUwH7LdSPW6UxUKAzf4eCErs4NZNinmii4ntCijjboUVDRxhurN+vaK
	SnE8FkETfWetmfrRPxLGEoDRgQfjyH/oNZ+MPhMU6f68G4KvPXSqVF8K+i+9mnKnP22oMcbD3KR
	lAhTh50cuF7PXb80N+6ykDEm3ZvoJnnwjlhMMNpva5altuzufVTnVxcEsimyX22FtidNCZ9PK1B
	81iP+v1yOIzl9OE4wqwXGPqywBjhQLou1Rc//VZupQq8nEocCBv5Nsg2NQH9noZBDmVY53CcMnn
	hPwAdw2AI0NUMI5i5qBotRwJf++Rz+Jbt+u9oXM2xEZu5UicCCecfYgg==
X-Received: by 2002:a05:6830:610d:b0:7d7:c985:3a30 with SMTP id 46e09a7af769-7e5fee82ab6mr9298026a34.11.1779735903615;
        Mon, 25 May 2026 12:05:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6065e6aabsm7915197a34.13.2026.05.25.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:05:03 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH 3/7 v3] mm/page_counter: introduce stock drain APIs
Date: Mon, 25 May 2026 12:04:50 -0700
Message-ID: <20260525190455.2843786-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16255-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B00D15CDE83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce page_counter variants to replace memcg stock draining
functions.

page_counter_drain_stock_local() drains the stock of the local CPU,
taking a local stock lock to serialize against concurrent charges.

page_counter_drain_stock_cpu() does the same, but without taking a local
lock. This is possible because it will only be called from the CPU
hotplug path, where the CPU is dead and there cannot be any more charges.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h |  3 +++
 mm/page_counter.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c7e3ab3356d20..ffe13224213c9 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -111,6 +111,9 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 int page_counter_enable_stock(struct page_counter *counter, unsigned int batch);
 void page_counter_disable_stock(struct page_counter *counter);
 void page_counter_free_stock(struct page_counter *counter);
+void page_counter_drain_stock_local(struct page_counter *counter);
+void page_counter_drain_stock_cpu(struct page_counter *counter,
+				  unsigned int cpu);
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index e002688bf7f1a..fbfe9a1b29d2e 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -389,6 +389,40 @@ void page_counter_free_stock(struct page_counter *counter)
 	counter->stock = NULL;
 }
 
+void page_counter_drain_stock_local(struct page_counter *counter)
+{
+	struct page_counter_stock *stock;
+	unsigned long nr_pages;
+
+	if (!counter->stock)
+		return;
+
+	local_lock(&counter->stock->lock);
+	stock = this_cpu_ptr(counter->stock);
+	nr_pages = stock->nr_pages;
+	stock->nr_pages = 0;
+	local_unlock(&counter->stock->lock);
+
+	if (nr_pages)
+		page_counter_uncharge(counter, nr_pages);
+}
+
+void page_counter_drain_stock_cpu(struct page_counter *counter,
+				  unsigned int cpu)
+{
+	struct page_counter_stock *stock;
+	unsigned long nr_pages;
+
+	if (!counter->stock)
+		return;
+
+	stock = per_cpu_ptr(counter->stock, cpu);
+	nr_pages = stock->nr_pages;
+	if (nr_pages) {
+		stock->nr_pages = 0;
+		page_counter_uncharge(counter, nr_pages);
+	}
+}
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.53.0-Meta


