Return-Path: <cgroups+bounces-16369-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A6HG6xYF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16369-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026705EA2F9
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F603084458
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D34377EA7;
	Wed, 27 May 2026 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="FTUDVFrU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784D3B7B8B
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914894; cv=none; b=dBfzcHWb80lSCtBjoMLX9p8z3cfWf+xcMmeBCnPH7tkkT0gW1dMMcnop3/JxpkajrEZfvoqmy2RK0xEEefFrqHe7xE1kHelccPmHvmn3uLCrOAjCgJSaRLgohTUmkGIZdu/832j7rcucW8ZHpEOVm7bnu0Lqwu8RcvbKst9JD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914894; c=relaxed/simple;
	bh=xYOAXmbD5tgE83jUvwcepWiOiMWhzYpTMw9lq13ecuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evsatfaeAInxr2p/Us3eRwX+Wmae9b/F8MzZoiFVtc6G7mvxi4x7kjP+CMjCSrFB3YhzZxIC7n3wvqOPNSVitd34FfmBaasj/gN5Arir5RKyRrwICn7JZfKErkFHNsshlraltapIi/LnlEMWOF/BZaZKVClsQdwm7r9p06JG58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=FTUDVFrU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51306c9f2a8so145159631cf.1
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914889; x=1780519689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD5lidUUheRvEbRogBFjUkTmTjQ7nHIsLysSJlSHMzs=;
        b=FTUDVFrUX3A3O6aKdwycdgeHHiuAEC7hNluhlqdOI8Cj0NpsmgerS2K+2LQO2yfxZ4
         i9vahFPakvJ9n2rwlEPcD8zdtG0SqVniCtfSV4fj8ri4DJc03lFvM/vAhNgVtwTaqNiU
         QMOr3+EWMsATYjOrwNU35ivBeWo/GStb03T5rmn9xWFOam6pZYYXr7Aj3CGop0ny2eB+
         UHxEsZ3r+c0nNwcMatjCNrU473CdyXo/lhmgmk9ZcGTjFqOS4ugklF6ISfk+3tXmyVjB
         Gw1QAodXWcNJkq9bSYzQNS99ZT6NK6PdK1YRrvHoTXiHWwZdzD/zFRe4yow10o2xSNLE
         ep1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914889; x=1780519689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TD5lidUUheRvEbRogBFjUkTmTjQ7nHIsLysSJlSHMzs=;
        b=WfMRarniNaw+DBA4koG9ajK50SWcV4UUtkem67H9Skf3iO8stql+35EVZjde5f+SWY
         TqrE5PV7Nk3AvMPS2sTuN+h0SXotEHXuZqRj+vRy2VkTMtMoWPCIPMfG9krMHLL0x1dc
         d28aA8prl8nytU0F72BTc5gLTMMBZiwndWawtojNZsfPd8fsdzJ34HB32bXufC7kGZmy
         wuAqALEa4UiTGMkAyQkBqVcVoariKSjWVPpB6uyVkJIrRnVeez3S+GjpXV30SCxMuTtZ
         pzEPwlr4BNxviNoipLJJnjANkgsHSgj20kUxUDi7/zhxt50iIGF+xh/RlG8SKllR1HlJ
         C+ew==
X-Forwarded-Encrypted: i=1; AFNElJ/vhGo8MZgT5DKhypMIvq8cskRdU3MY8DRZRRIKTuAp+u09k2k82ovAYOskAoEM/8cRBENePzrs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XhK/IhxaXRaPSKUyQhJLhRgy7xahOm2oaS+eYKVe/qJHMLmz
	FKytJC7WmHbOAyqZLvB3HqgeAwUbXS3jTELlNtKWzcUQzoTA+wUn+aDHoJqv+k5fp/4=
X-Gm-Gg: Acq92OEEc6dd6kX4/usSqu78KEPWNF2Cplp9CFej68dUdikxWfYlRzIKb8dSjVPUqAV
	YbT5XxA0UqeW313SP2w+HVIBNbOUzO4hfGafu94RQPE0SHRzIuQu6ONm+MQsINbs93W7jpJtIJy
	pjVvuxDF1XrZyWWQF07icy1JPPLOWs2/D80aMJY0f7GPoCBox1Y9NfqhnPVlhx36qQ9DolOnpA8
	MJRxyh9CfZGDmc9veIVkUU0OHHL+zI1LVd5xiF1tNbwdItblvAdxdbIQY9S8BqNYTVOOAIlJy9m
	JQ9ARX5RHN/xDzcQmDzuYIxVvrLkYdtBnY//quh6w0oOK3qtt84msywOZ51bUM4citNCdnmXhwC
	CBB3weR+pVRlWMZ48Z2c2z6WxPri6nDTjgQMdc1kieShYlP1eoJplC30FXo7eJ9ZcIgT4EgQ53R
	iAO9WkewAcaOWYv28+rM4LXx4CCmwRP8eB
X-Received: by 2002:a05:622a:2508:b0:516:ddc3:622e with SMTP id d75a77b69052e-516ddc36797mr330589551cf.33.1779914889279;
        Wed, 27 May 2026 13:48:09 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adcb59sm52568411cf.17.2026.05.27.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:08 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/9] mm: list_lru: lock_list_lru_of_memcg() cannot return NULL if !skip_empty
Date: Wed, 27 May 2026 16:45:09 -0400
Message-ID: <20260527204757.2544958-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527204757.2544958-1-hannes@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16369-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 026705EA2F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skip_empty is only for the shrinker to abort and skip a list that's
empty or whose cgroup is being deleted.

For list additions and deletions, the cgroup hierarchy is walked
upwards until a valid list_lru head is found, or it will fall back to
the node list. Acquiring the lock won't fail. Remove the NULL checks
in those callers.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
---
 mm/list_lru.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 45d1b97737ea..77999ed78fa5 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -165,8 +165,6 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 	struct list_lru_one *l;
 
 	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
-	if (!l)
-		return false;
 	if (list_empty(item)) {
 		list_add_tail(item, &l->list);
 		/*
@@ -208,9 +206,8 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
+
 	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
-	if (!l)
-		return false;
 	if (!list_empty(item)) {
 		list_del_init(item);
 		l->nr_items--;
-- 
2.54.0


