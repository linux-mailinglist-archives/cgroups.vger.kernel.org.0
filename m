Return-Path: <cgroups+bounces-14878-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENGVGgggu2lofQIAu9opvQ
	(envelope-from <cgroups+bounces-14878-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:58:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF02C331C
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B6933134676
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA9342C88;
	Wed, 18 Mar 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdpMEsSa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E942D1913
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870993; cv=none; b=Z2XZTtOCnpj4J1yOpNT8D1AsEVirdxldgH8e1j80ftsIfWcffd+ohhrCGqJkDJnmHukJOxkQhpZhstL98r3HcaRHQN15O8Qvd2QoX+hXDhdMwHSi3D3FGTiknTmum5X+Gm0nqTrywyPgEBYJeVD6RXKNRYRcmOVlieyql8Cab/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870993; c=relaxed/simple;
	bh=e0x8hojThMgnc4nAAWULGmSUzZ71a6Z6ijKXYo1/91E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ie0abWpcNDpvGTMhkZ5MWJ/xGFN9UzWLSGWChjuUr0bJYM3H/UXrrxUW10HRfRAcl7cvCGu9vYrSiDUXvKFoCw7oFU/Ss5yNIzMtgdyFc8bX8btUVJpl22SSrIZyJlLFy5edkVm1l+TJ9WRnEC4zlUtc0MzAxgFkY7RXW1XyX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdpMEsSa; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so380243eec.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773870991; x=1774475791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctmE5aFMWKkncy3sWCLL07LF9OqWa0rsovqCMz1tZkA=;
        b=UdpMEsSac49oOW8a+OrtTBdnrSuLTRFbnSHvzIoFUO3B42wSXmQAeQjm5SBt3hKhTV
         tLvoCcA5YmLnKY9vN9xx2n9rGfe6/wXnsDb5RiTbZ3PzRipcDrEon4fRK4mYIQov6nk8
         PDlujiuyGRjBIY5YbWoKDht7tQ61xve1bBKDFbXC8gNi7LoiYjUHQu0jwYPnI7N7SIis
         lU7uMZxCu+tXCAlx0YDG1Da9UIOaktQmC6v3tD7tSmgQMIQEg1ujhOr/sVGGsOzAhq0o
         erQSzKOma/wDhf2YPyjQHg/LgG/661O662upsXmWbXVu7tS4Y2iUUOli35ETI8BWKMos
         E+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870991; x=1774475791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctmE5aFMWKkncy3sWCLL07LF9OqWa0rsovqCMz1tZkA=;
        b=n5dfR9538RD1qLjuQmUmoE6RmQuXBPt/iFjSIbv8WPqod4OeK4HqbwWOsBeKx9lC3L
         OXL2xAjw2jdLgeI+jEkfSf/zGouqAsDKlFFeCX28l/rzlZYw7SEYHEi/FR6gq4RSj2qE
         i0dmVGhzYh+Xpi2IK5E+m9lLE9wgPj+LR4Lui48+eQtgDQQ1pqJGYc8AbFDsu3GyDWXX
         dEnpu7w6A/ESWotERpWWIUkIuXCEz7i+u7WpNCW98bP5XjXIK00+aO2cjNSBZgOiYn4+
         y/udy6DH/Vvc7BdVZO0PTgnnfP6E0dsuBFcvr9NjcIdbnEWrHMseFNtIquQYY/4iVfaQ
         wcCw==
X-Forwarded-Encrypted: i=1; AJvYcCW3kV4lfvNtmlI42+AMjJCGmepkFazipIMYQHcXYw0sFCUUSllgR8lcsPrBypvPJIzLenl5jtT1@vger.kernel.org
X-Gm-Message-State: AOJu0YwI62OkO+IShwsPWNUT+V7LEwUqocAPtWkbm6FNhy19kXwvwftF
	dp/Qg/of+RXdJuVnVXxD+T5l3ZN4QWVA1e/D+0MTtmAUkG9Awi01ykilxJz19u3g5b4/229CS6t
	H9W2NvyCGMOYqIQ==
X-Received: from dybuh11.prod.google.com ([2002:a05:7301:750b:b0:2be:82ee:95dc])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1285:b0:2c0:dd99:f0b with SMTP id 5a478bee46e88-2c0e5089246mr2321633eec.25.1773870990982;
 Wed, 18 Mar 2026 14:56:30 -0700 (PDT)
Date: Wed, 18 Mar 2026 21:56:05 +0000
In-Reply-To: <absRz4U_IMk0ofxl@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <absRz4U_IMk0ofxl@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318215629.2849052-1-bingjiao@google.com>
Subject: [PATCH v2] mm/memcontrol: fix reclaim_options leak in try_charge_memcg()
From: Bing Jiao <bingjiao@google.com>
To: bingjiao@google.com
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, nphamcs@gmail.com, 
	rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, weixugc@google.com, yosry@kernel.org, 
	youngjun.park@lge.com, yuanchu@google.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-14878-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.773];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14EF02C331C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In try_charge_memcg(), the 'reclaim_options' variable is initialized
once at the start of the function. However, the function contains a
retry loop. If reclaim_options were modified during an iteration
(e.g., by encountering a memsw limit), the modified state would
persist into subsequent retries.

This leads to incorrect reclaim behavior. Specifically,
MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
is reached. After reclaimation attemps, a subsequent retry may
successfully charge memcg->memsw but fail on the memcg->memory charge.
In this case, swapping should be permitted, but the carried-over state
prevents it.

Fix by moving the initialization of 'reclaim_options' inside the
retry loop, ensuring a clean state for every reclaim attempt.

Fixes: 73b73bac90d9 ("mm: vmpressure: don't count proactive reclaim in vmpressure")
Signed-off-by: Bing Jiao <bingjiao@google.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
---
v2:
- Dropped other patches.
- Refined commit message to clarify the impact of the leak (Yosry).
- Added Reviewed-by tag.

 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a47fb68dd65f..303ac622d22d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2558,7 +2558,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
-	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
+	unsigned int reclaim_options;
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
@@ -2572,6 +2572,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		/* Avoid the refill and flush of the older stock */
 		batch = nr_pages;

+	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	if (!do_memsw_account() ||
 	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		if (page_counter_try_charge(&memcg->memory, batch, &counter))
--
2.53.0.851.ga537e3e6e9-goog


