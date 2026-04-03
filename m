Return-Path: <cgroups+bounces-15170-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ksg1GLzLz2nT0gYAu9opvQ
	(envelope-from <cgroups+bounces-15170-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 16:16:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5F395147
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA899307CEB1
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2026 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E23C3C00;
	Fri,  3 Apr 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvw43mvB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqHN8YTK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9713C3C1B
	for <cgroups@vger.kernel.org>; Fri,  3 Apr 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225598; cv=none; b=tJYofpd0Gh8mIiPRf3h+aqhwg0ZynzKIGoXzXbHseMNJuqp/PG6i1EqXCC+gRI7Y1rMViR2kzynRLcxWJkdZBGjtu/IQkgbKdzfGuc+PBLAcwINUEG915m1139E3IFOJ/uoFVlzc4NkHHpDv33lO+6O1VaOv2Ic540oZaHrly2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225598; c=relaxed/simple;
	bh=i3I3h69ANM+/CCAB91aIzVIiJh++XXV/lD/iV3+eRWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DvWcEor5bAC+zBx7Wys7MFmAuTpglPtRK5L3zMLJpj7f+015PnudUq0RkCCHTHw0AfF8JJJ9fOxrl0wZYI0MEUzMzJZ8e2pAdSfEfXNELlRRU1wSq7zEt/YM5CsmPcXexIYqiNo76qDh3HAwS55UV2AkR0YzL3mBRG+im86UShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvw43mvB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqHN8YTK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775225596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7VPU0rCKfWfvPJl/4bosCPDJZ8iv97Cw6zG7IjIUB0=;
	b=Mvw43mvBveue6wUU4etsmb4EtRnjUYBj4bo1UKsZTpKeKvmVuZm46xXPF53caUFMCjLtzv
	pqARb/hvVXm1ylR5iG1HVzIU2/DAQuo8ioQQaI4Mpd80hKEd30DeVtw3QVhC32C3/MZU5u
	QgpXzoBRFvlbNp2kUIIU2dGjORILyVk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-GaPErGZKNXySD09BiyqGRA-1; Fri, 03 Apr 2026 10:13:15 -0400
X-MC-Unique: GaPErGZKNXySD09BiyqGRA-1
X-Mimecast-MFC-AGG-ID: GaPErGZKNXySD09BiyqGRA_1775225594
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so45023641cf.3
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775225594; x=1775830394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7VPU0rCKfWfvPJl/4bosCPDJZ8iv97Cw6zG7IjIUB0=;
        b=HqHN8YTKyazlS3jkzrbXku2iMXo+0dljNmCZ5vE27uR5kg0j32MrEpK66HsCnmHTpV
         8WDlCQaqejPfg952+Q3ljQKRaXVr9j6Y74n73c5WKsR1bUbbr+vfErHybAvT1pw38PmP
         il0u3PyuQxMqzBjv1NOubExJZvOxF+HwTtRpmnAXHMSQWoR8S7BBfjSWRjaVteTUdN73
         o0qJiN4M0Ec5B3AxfQrotX/wV/gvVV9LH75k07ZQwQTiBLJocfk6kQqlvYjhONvaXJFm
         FpEtZ1f6zJi4Zhii3ZkRl5xZ4V0Me81j1xK/L18VL4dN7epNDU9i6O85x42OZJ8ZEQcn
         DA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225594; x=1775830394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7VPU0rCKfWfvPJl/4bosCPDJZ8iv97Cw6zG7IjIUB0=;
        b=GdCuRe2kRhwfCvAQh6ynW+L0oIZGAS9cd8YMtpxLEsCuJKOdVKAp6sc+DN3YfDhavw
         6wW7QDExX+3YPX0t5BbZPl72eCdbHE8xQ7DcVU+tUA8oTlE/h115McxezYDETLgR9TI2
         w84t0OhON0nRfMUprD57+BWAGINfyeCGqMDzOvqRuJEqvJOXl4Hq+VF8unB5Nclp8yjk
         yXUpchKQrgh7v0H9RCk3pyX5k9FCeUNT+ujkwlnLXAPIzHh1LGAlwaErL6lihoCyo7IQ
         RbHWsE7AMXWTvwfEOLEYyVRqfVzngdCanuKpWbMVZiXol5mP6+PJbC37bpIfL4eTwqNB
         il9Q==
X-Gm-Message-State: AOJu0YxMJG74WrlN+wP9eLTsECLKeJnzvdGqZ3G7ggGL1PT53aB8RG2Z
	hUon723ie+WPFOrqs3R0Bgzc1450GgV6Z6Ge87XCG1KbmmwvVIFGW+XJZxqUVO7mn8J3FLrVIRY
	mNFRAOWjf5wA86UCjvtqjumt8nuWGxfDZArT2Kv9D7nAO5g7WRTTC01ZMQxc=
X-Gm-Gg: ATEYQzzR1Th06aE1ThO85njhsBgUYlNWAnmnQPG0X1sti2r5aL2ky1Qp7x66kePbj6i
	tKWVFjeu0u3Ge6kP3gff/XSHR1TvLT6aMEZtHSE/P1Qpngn6NrY5Xhl9iSu9wHKGcpPm+yugkMz
	hf9Q657tesjbF7qW34+YBgnkfy/teF7dPO0nfyqafTRoBtokh7Ij+87vcSCY21R8OSnDPiZfZju
	gEPTVAdkFAp7FadsCksGTlHcMub+jGTWkkbOI0T11mRmKA9Iu9dj3UXglYgoN0nOvFuY3MZMeeU
	CQ/2viNwa5E7QOpkV6+drY/h4vLtpnxPFMykELM5vVazGA1xM15fKIcwyqFLwIjJ9RK2IbRaouX
	Er9HVB12Pz92Rt+7Q+/hbtfsgPLR1nPBisqk8ad0aK4Nb9OM2PLXtGkUoLRcWJZQ=
X-Received: by 2002:a05:622a:1922:b0:509:2ef7:7048 with SMTP id d75a77b69052e-50d62cd74e1mr43969761cf.66.1775225594360;
        Fri, 03 Apr 2026 07:13:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1922:b0:509:2ef7:7048 with SMTP id d75a77b69052e-50d62cd74e1mr43969031cf.66.1775225593742;
        Fri, 03 Apr 2026 07:13:13 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net. [100.17.19.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4d9ad4b6sm40723031cf.15.2026.04.03.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:13:12 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Fri, 03 Apr 2026 10:08:36 -0400
Subject: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15170-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EBC5F395147
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce /cgroupfs/<>/dmem.memcg to make allocations in a dmem
controlled region also be charged in memcg.

This is disabled by default and requires the administrator to configure
it through the cgroupfs before the first charge occurs.

The memcg is derived from the pool's cgroup, if it exists, since the
pool holds a ref to the dmem cgroup state keeping the cgroup alive and
stable.

The behavior is quirky. Since keeping track of each allocation would add
a fair amount of logic without solving the problem entirely, disable the
memcg switch once the first charge is issued. Having this as a dynamic
configuration doesn't seem relevant anyway.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 kernel/cgroup/dmem.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa09422274422313b63c25986596de..b65ae8cf0c302ce3773a7aa5f0d6d8223d2c10c9 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -17,6 +17,7 @@
 #include <linux/refcount.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/memcontrol.h>
 
 struct dmem_cgroup_region {
 	/**
@@ -76,6 +77,9 @@ struct dmem_cgroup_pool_state {
 
 	refcount_t ref;
 	bool inited;
+
+	bool memcg;
+	bool memcg_locked;
 };
 
 /*
@@ -162,6 +166,14 @@ set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 	page_counter_set_max(&pool->cnt, val);
 }
 
+static void
+set_resource_memcg(struct dmem_cgroup_pool_state *pool, u64 val)
+{
+	/* Cannot change once a charge happened. */
+	if (!pool->memcg_locked)
+		pool->memcg = !!val;
+}
+
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.low) : 0;
@@ -182,11 +194,17 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static u64 get_resource_memcg(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->memcg) : 0;
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
 	set_resource_low(rpool, 0);
 	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_memcg(rpool, 0);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -609,6 +627,20 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 	return pool;
 }
 
+static struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *c)
+{
+	struct cgroup_subsys_state *css;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	rcu_read_lock();
+	css = cgroup_e_css(c, &memory_cgrp_subsys);
+	rcu_read_unlock();
+
+	return mem_cgroup_from_css(css);
+}
+
 /**
  * dmem_cgroup_uncharge() - Uncharge a pool.
  * @pool: Pool to uncharge.
@@ -624,6 +656,13 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 		return;
 
 	page_counter_uncharge(&pool->cnt, size);
+
+	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(pool->cs->css.cgroup);
+
+	if (pool->memcg && memcg)
+		mem_cgroup_uncharge_pages(memcg,
+					  PAGE_ALIGN(size) >> PAGE_SHIFT);
+
 	css_put(&pool->cs->css);
 	dmemcg_pool_put(pool);
 }
@@ -655,6 +694,8 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	struct dmemcg_state *cg;
 	struct dmem_cgroup_pool_state *pool;
 	struct page_counter *fail;
+	struct mem_cgroup *memcg;
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int ret;
 
 	*ret_pool = NULL;
@@ -670,7 +711,22 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	pool = get_cg_pool_unlocked(cg, region);
 	if (IS_ERR(pool)) {
 		ret = PTR_ERR(pool);
-		goto err;
+		goto err_css_put;
+	}
+
+	pool->memcg_locked = true;
+	memcg = get_mem_cgroup_from_current();
+	if (pool->memcg && memcg) {
+		ret = mem_cgroup_try_charge_pages(memcg, GFP_KERNEL, nr_pages);
+		if (ret) {
+			/*
+			 * No dmem_cgroup_state_evict_valuable() could help,
+			 * there's no ret_limit_pool to return.
+			 */
+			ret = -ENOMEM;
+			dmemcg_pool_put(pool);
+			goto err_memcg_put;
+		}
 	}
 
 	if (!page_counter_try_charge(&pool->cnt, size, &fail)) {
@@ -681,14 +737,21 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		}
 		dmemcg_pool_put(pool);
 		ret = -EAGAIN;
-		goto err;
+		goto err_uncharge_memcg;
 	}
 
+	mem_cgroup_put(memcg);
+
 	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
 	*ret_pool = pool;
 	return 0;
 
-err:
+err_uncharge_memcg:
+	if (pool->memcg && memcg)
+		mem_cgroup_uncharge_pages(memcg, nr_pages);
+err_memcg_put:
+	mem_cgroup_put(memcg);
+err_css_put:
 	css_put(&cg->css);
 	return ret;
 }
@@ -846,6 +909,17 @@ static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_max);
 }
 
+static int dmem_cgroup_memcg_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_memcg);
+}
+
+static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
+				       size_t nbytes, loff_t off)
+{
+	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_memcg);
+}
+
 static struct cftype files[] = {
 	{
 		.name = "capacity",
@@ -874,6 +948,12 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_max_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "memcg",
+		.write = dmem_cgroup_memcg_write,
+		.seq_show = dmem_cgroup_memcg_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ } /* Zero entry terminates. */
 };
 

-- 
2.52.0


