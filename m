Return-Path: <cgroups+bounces-16088-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD0vIfOKDGo1iwUAu9opvQ
	(envelope-from <cgroups+bounces-16088-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:08:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFD581F88
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7F193095B33
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248622DEA8F;
	Tue, 19 May 2026 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YenKr1BH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8X18DB+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E602DCBF8
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206439; cv=none; b=KDRw8mwZSJf9cnsJvTA+5/ejix3hm2gyXh34r+8hNRcoOxrRfwc9fpFK+HwYoRmKytUdDJvdg5qIKEvRUvyTmpziWfopqivOwli6kOThPZ9az3PrmziWtde5ep+CQtsw5Ay5ToBkYV4MmhyVAtAb/HYrx0LWYb9P/4zw7rbZAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206439; c=relaxed/simple;
	bh=OWvl2gDr2tO8/A0xx+YxYDi6nhszzlOeBBlrlVUDVH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m77viBYshOF3yRl9KrOWa8ZjUtfGSbg5y/9XV74Zn+jZPGr5OU5vy0u0/2GD+D7KYee0w2ehZiKNthMMGjMIv+mxhVZ/auTF5iUqQQ/q9Gw2GQpSwricgc+Rt00hqSB3mrEMotTGGDiJmy9c+kJQWWGSZnqQAdDwlCsj1AnL1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YenKr1BH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8X18DB+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779206437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxAuh/+LJ+cDVuOYgE+wIRcTwCiP9gqh5qSpye35R00=;
	b=YenKr1BHZLGp0juZYcRCKwuqZNhqgkSISZtXjp1+5PlgmgY95HNIPUeJ8/FTeAZRIpfMJD
	Z4DmUfsReUIZunHnw3N4f87H7MSQ2kJi+cxqlT8hj9r5WyqmTwmIuTRMzsYls46cy0Jy/P
	d7cloeLAKOChCR6jVCRVdWofxDUUkW8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-zhF_KSxNPwC9vrZzOdWF_g-1; Tue, 19 May 2026 12:00:35 -0400
X-MC-Unique: zhF_KSxNPwC9vrZzOdWF_g-1
X-Mimecast-MFC-AGG-ID: zhF_KSxNPwC9vrZzOdWF_g_1779206435
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8baa173eacbso17516826d6.0
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779206435; x=1779811235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxAuh/+LJ+cDVuOYgE+wIRcTwCiP9gqh5qSpye35R00=;
        b=P8X18DB+GAmxeHl2m7T18XCC1vbWNkLiYSRw4QGRrpwM/F6e6LigNviI1n4QxKhMgt
         WXZsJVZLeiMRzyEmp5wyyIUiR2vOUUhhik7jkA1hdcrVcklsbS/a5f9iu/xKLTrnGRc3
         3TeZ5FauihjBSKP9d3RMZShGWX3YVrp82unaQZSqrlO+ASelDJyS8DQIXa96VKmaqeBd
         zSM+rmHl+dudOXieyW6ES5OT+vdmlDj3lTcXyVwMWkvjA3hfQqEi6vC+R6d7JPpt9ipS
         c6gdDmuxjPoF9fnY9RV4cQLucIdEtDt/+g+mfQ4GqedtHGblLyS/9FxbNJ7xOTWb4NHt
         MGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206435; x=1779811235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxAuh/+LJ+cDVuOYgE+wIRcTwCiP9gqh5qSpye35R00=;
        b=Z/G7gckWjbL91gwN8JIJJPArebEp/qEPE5psfXopi3SXUnRgQaH5elnV5aMfhevA2Q
         HKi6XkOj21tM1YzgaGYpKHRNdPdycfhipIj8r/ImrE29Z/vkyQ+MdNls4WgJIbGo+1/v
         eWpnij0kBzAag/ikIpr33euPeLhg98VTyqIqyRCvhbucuqYsUM1GiSe7HTuTqz37NqOO
         xzrlOvPv1m42Tc+1IA9VJndbAy2iT1UvyUqJr8geK3iVwaQtC1MPCdiVgt1j7T6Vtcja
         iyXvoY5UH9j+MHAauPJTkiT4TU+J7EBqe+rzjZlHILcDJ9DxT5Ebqw7jiv1nIG6fzpdk
         Il9Q==
X-Gm-Message-State: AOJu0YxG5ATH6CpTXmyE7iTDXyg60ZX4Or9N1WEBmLM2INuv+VVLTKFV
	3YMTEdZZAA4jwCb44uy7aGzNy1uErdZ2K2D+uIFqL/6TZBIjg/aHv3eUcydA1rrON+VEiOH50Bh
	VbjDf/KBvbrRqftxbhmGjN4d56h3ugSLjvrJJQtVE82zBH5mGNemKP21ZBok=
X-Gm-Gg: Acq92OGiz95c8vDHekbpZ+ivq3sxLRriP9/RzEp2IfH3hMA29i54/oeUk/yWWLmEf2P
	XhtMLDmFMSw+jPjXB5N5zNMBmIQFXdRCll95Q3iml8SHj6zeVJmi6FUOE3DQ2+TRDfPbIwJZcRQ
	8ABZicQ7emssfvYyJTPrsGZ66nmF8P3zkLQfEMpz775CUnw6GHJGujpjmq22fzscQVjVgb5Rpah
	bJkflwra3iBaDqHUZrEgk8H7OqIA8+Zu+jza3YrqZ1ueMMzivJG/XIyRaL+Sjr8Ec5AYP2pwdcZ
	AMe+kYI8OkQQCydkkQuyzJBYTHO90waOPvxdQqpv0YDdDmEWgrpidxfito9ebvVB/CzBeDS0r7N
	DBgc+VKE9C1pz5OgJbUdLgFuRC0CvIccwFABSfkIjOtixKIFUXqB53PG1rXWOA6vc7NId0jZOo2
	Z/
X-Received: by 2002:a0c:ea52:0:b0:8c9:c38a:20e1 with SMTP id 6a1803df08f44-8ca0f5ab3bemr240747376d6.10.1779206434515;
        Tue, 19 May 2026 09:00:34 -0700 (PDT)
X-Received: by 2002:a0c:ea52:0:b0:8c9:c38a:20e1 with SMTP id 6a1803df08f44-8ca0f5ab3bemr240746326d6.10.1779206433782;
        Tue, 19 May 2026 09:00:33 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net. [100.17.21.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm95016266d6.14.2026.05.19.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:00:33 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Tue, 19 May 2026 11:59:02 -0400
Subject: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org, 
 Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16088-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,lwn.net,linuxfoundation.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 13CFD581F88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
configure whether allocations in a dmem region should also be charged to
the memory controller.

To handle inheritance, dmem adds a depends_on the memory controller,
unless MEMCG isn't configured in.

Double-charging is disabled by default. Once a charge is attempted, the
setting is locked to prevent inconsistent accounting by a small 4-state
machine (off, on, locked off, locked on).

The memcg to charge is derived from the pool's cgroup, since the pool
holds a reference to the dmem cgroup state that keeps the cgroup alive
until it gets uncharged.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  23 +++++
 kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2828,6 +2828,29 @@ DMEM Interface Files
 	  drm/0000:03:00.0/vram0 12550144
 	  drm/0000:03:00.0/stolen 8650752
 
+  dmem.memcg
+	A readwrite nested-keyed file that exists only on the root
+	cgroup. It configures whether allocations in a dmem region
+	should also be charged to the memory controller.
+
+	Upon the first charge to a region, its setting can no longer be changed
+	and is reported as "[true|false] (locked)".
+
+	Charges to the memory controller are visible in ``memory.stat`` as the
+	``dmem`` entry, reported in bytes.
+
+	An example read output follows::
+
+	  drm/0000:03:00.0/vram0 false
+	  drm/0000:03:00.0/stolen false (locked)
+
+	Writing uses the same nested-keyed format::
+
+	  echo "drm/0000:03:00.0/vram0 true" > dmem.memcg
+
+	This file is only available when the kernel is built with
+	``CONFIG_MEMCG``.
+
 HugeTLB
 -------
 
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..e07b20b8025c528f190f84c76b088cb8a32a7f5e 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -17,6 +17,14 @@
 #include <linux/refcount.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/memcontrol.h>
+
+enum dmem_memcg_status {
+	DMEM_MEMCG_OFF,
+	DMEM_MEMCG_ON,
+	DMEM_MEMCG_LOCKED_OFF,
+	DMEM_MEMCG_LOCKED_ON,
+};
 
 struct dmem_cgroup_region {
 	/**
@@ -51,6 +59,14 @@ struct dmem_cgroup_region {
 	 * No new pools should be added to the region afterwards.
 	 */
 	bool unregistered;
+
+	/**
+	 * @memcg_status: Whether allocation in this region should charge memcg.
+	 * DMEM_MEMCG_OFF/DMEM_MEMCG_ON or
+	 * DMEM_MEMCG_LOCKED_OFF/DMEM_MEMCG_LOCKED_ON, frozen after first allocation.
+	 * Transitions to a locked state are one-way.
+	 */
+	atomic_t memcg_status;
 };
 
 struct dmemcg_state {
@@ -609,6 +625,34 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 	return pool;
 }
 
+static bool apply_memcg_charge(atomic_t *status)
+{
+	int state = atomic_read(status);
+
+	for (;;) {
+		switch (state) {
+		case DMEM_MEMCG_OFF:
+			state = atomic_cmpxchg(status, DMEM_MEMCG_OFF,
+					       DMEM_MEMCG_LOCKED_OFF);
+			if (state != DMEM_MEMCG_OFF)
+				continue;
+			return false;
+		case DMEM_MEMCG_LOCKED_OFF:
+			return false;
+		case DMEM_MEMCG_ON:
+			state = atomic_cmpxchg(status, DMEM_MEMCG_ON,
+					       DMEM_MEMCG_LOCKED_ON);
+			if (state != DMEM_MEMCG_ON)
+				continue;
+			return true;
+		case DMEM_MEMCG_LOCKED_ON:
+			return true;
+		}
+		WARN_ONCE(1, "Invalid memcg_status (%#x).\n", state);
+		return false;
+	}
+}
+
 /**
  * dmem_cgroup_uncharge() - Uncharge a pool.
  * @pool: Pool to uncharge.
@@ -624,6 +668,12 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 		return;
 
 	page_counter_uncharge(&pool->cnt, size);
+
+	if (atomic_read(&pool->region->memcg_status) == DMEM_MEMCG_LOCKED_ON &&
+	    !WARN_ON_ONCE(size > (u64)UINT_MAX << PAGE_SHIFT))
+		mem_cgroup_dmem_uncharge(pool->cs->css.cgroup,
+					 PAGE_ALIGN(size) >> PAGE_SHIFT);
+
 	css_put(&pool->cs->css);
 	dmemcg_pool_put(pool);
 }
@@ -655,6 +705,8 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	struct dmemcg_state *cg;
 	struct dmem_cgroup_pool_state *pool;
 	struct page_counter *fail;
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	bool charge_memcg;
 	int ret;
 
 	*ret_pool = NULL;
@@ -670,7 +722,28 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	pool = get_cg_pool_unlocked(cg, region);
 	if (IS_ERR(pool)) {
 		ret = PTR_ERR(pool);
-		goto err;
+		goto err_css_put;
+	}
+
+	charge_memcg = apply_memcg_charge(&region->memcg_status);
+	if (charge_memcg) {
+		/* mem_cgroup_dmem_charge limitation from try_charge_memcg */
+		if (size > (u64)UINT_MAX << PAGE_SHIFT) {
+			ret = -EINVAL;
+			dmemcg_pool_put(pool);
+			goto err_css_put;
+		}
+
+		if (!mem_cgroup_dmem_charge(pool->cs->css.cgroup, nr_pages,
+					    GFP_KERNEL)) {
+			/*
+			 * No dmem_cgroup_state_evict_valuable() could help,
+			 * there's no ret_limit_pool to return.
+			 */
+			ret = -ENOMEM;
+			dmemcg_pool_put(pool);
+			goto err_css_put;
+		}
 	}
 
 	if (!page_counter_try_charge(&pool->cnt, size, &fail)) {
@@ -681,14 +754,17 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		}
 		dmemcg_pool_put(pool);
 		ret = -EAGAIN;
-		goto err;
+		goto err_uncharge_memcg;
 	}
 
 	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
 	*ret_pool = pool;
 	return 0;
 
-err:
+err_uncharge_memcg:
+	if (charge_memcg)
+		mem_cgroup_dmem_uncharge(pool->cs->css.cgroup, nr_pages);
+err_css_put:
 	css_put(&cg->css);
 	return ret;
 }
@@ -845,6 +921,71 @@ static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_max);
 }
 
+#ifdef CONFIG_MEMCG
+static int dmem_cgroup_memcg_show(struct seq_file *sf, void *v)
+{
+	struct dmem_cgroup_region *region;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(region, &dmem_cgroup_regions, region_node) {
+		int state = atomic_read(&region->memcg_status);
+
+		seq_printf(sf, "%s %s\n", region->name,
+			   state == DMEM_MEMCG_ON ? "true" :
+			   state == DMEM_MEMCG_OFF ? "false" :
+			   state == DMEM_MEMCG_LOCKED_ON ? "true (locked)" :
+			   state == DMEM_MEMCG_LOCKED_OFF ? "false (locked)" :
+			   "(invalid)");
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
+				       size_t nbytes, loff_t off)
+{
+	while (buf) {
+		struct dmem_cgroup_region *region;
+		char *options, *name;
+		bool flag;
+
+		options = buf;
+		buf = strchr(buf, '\n');
+		if (buf)
+			*buf++ = '\0';
+
+		options = strstrip(options);
+		if (!options[0])
+			continue;
+
+		name = strsep(&options, " \t");
+		if (!name[0])
+			continue;
+
+		if (!options || !options[0])
+			return -EINVAL;
+
+		if (kstrtobool(options, &flag))
+			return -EINVAL;
+
+		rcu_read_lock();
+		region = dmemcg_get_region_by_name(name);
+		rcu_read_unlock();
+		if (!region)
+			return -ENODEV;
+
+		atomic_cmpxchg(&region->memcg_status,
+			       flag ? DMEM_MEMCG_OFF : DMEM_MEMCG_ON,
+			       flag ? DMEM_MEMCG_ON : DMEM_MEMCG_OFF);
+		/* Continue if a region is already locked. */
+
+		kref_put(&region->ref, dmemcg_free_region);
+	}
+
+	return nbytes;
+}
+#endif
+
 static struct cftype files[] = {
 	{
 		.name = "capacity",
@@ -873,6 +1014,14 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_max_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+#ifdef CONFIG_MEMCG
+	{
+		.name = "memcg",
+		.write = dmem_cgroup_memcg_write,
+		.seq_show = dmem_cgroup_memcg_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+#endif
 	{ } /* Zero entry terminates. */
 };
 
@@ -882,4 +1031,7 @@ struct cgroup_subsys dmem_cgrp_subsys = {
 	.css_offline	= dmemcs_offline,
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
+#ifdef CONFIG_MEMCG
+	.depends_on	= 1 << memory_cgrp_id,
+#endif
 };

-- 
2.52.0


