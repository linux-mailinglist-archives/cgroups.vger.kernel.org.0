Return-Path: <cgroups+bounces-15619-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOIaIR0R+mmfIwMAu9opvQ
	(envelope-from <cgroups+bounces-15619-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:47:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F94D089A
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03A9D3097D75
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B4948AE29;
	Tue,  5 May 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN32cNin"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944648A2CB
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995576; cv=none; b=FhmDLgeyHe47EY2xJbcUjk5Ahlgz2DD8XBYcWbrg6waaBUb2FzSoq41gCY3PxR0/Uh15KobPRklC/yLYhcKKJ8KWrbOZ31TDsjP8dMq7qyzWZHLe2CJb1gOUM4+be5DFDB37uhgNfjK9Ieb7FNlbfFpV/qNHalpHG/8Ms2DsuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995576; c=relaxed/simple;
	bh=WJv7TbTBHsX/A9NDJmolsXLXY2Rt5GLjEbUFUMhf4TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9iCAX0uY4pPlvAiNnURhSlNYcWnAZObqXsIdqLUAOs5Y6sm4nBalBNF55vQU4Jloc40wrohZnVkIwRXwuZiGwtrAGtsYvKU6nx5HoKo+Di2jq77ypaw5HGep/xAdhyMK9jHQU3qUzy1nZImsDTeLu+QK8BNmbEcJxo7rgV9QTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN32cNin; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4233e152457so4151351fac.1
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995571; x=1778600371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O97PAflqjjtCiKkA3gTz4fMVjeIt3GdTmnKsTZ8H7Z8=;
        b=cN32cNintGy2+tB7v2MIB9ZIOITD2tfOWGVEA09gxvIhPKazxQfqL9DCB7daniMBb1
         qfFMeL7QI4bOk7GZmjHBSQR+gOtKehWxoY1ikc5kxnWaJ+h1GQ1YrnHt4ljs+7O2IOeb
         ntrooqYPXibYLljXw+rgTXod8/DngJwpzIy53BjMxy/bOtcgD7IuxiWleJT6vfJyoKAX
         2t4cihlAtmrTZ97OUXnOUR4tbtJV9cwRIxwxiJ964Fg1AxKxoQ+z2/hLTj01wbR4foET
         uAXXaq2Kmd+Ru8VMtXx8BTbTzt2C4JZ2Z1bc/bCXKVW8Vt1ddHDAFnkmiExWijHShWFL
         Fzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995571; x=1778600371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O97PAflqjjtCiKkA3gTz4fMVjeIt3GdTmnKsTZ8H7Z8=;
        b=LT6xSxXBTeYJmldP+D76Xr4tXCtFsZbKGxXPuJCZb3z8ZR27Ad2dIJAMMi4NEMgQzq
         PyPvh4nb6GreBhLv4/VGLQ6Y5HlAg9uppl6Jb+MOSzFzj188kepBT+RMNYRWt/USAGtL
         WvsFLyU3Gm1gEwKgWFEAZBU/ANHNi0uHtpcrMiCZjnYtK483UD99okt1U/1DdWVeUu2r
         DG6CwqMPRzHSnLRYEYI/IHhjHqfVBlZzI1q40vRAm+lGBeqpRIfUdSOe3t4SUyPiO7RW
         bRU9gIZRsJaThvb7uTuKXDtcnz/PuO9j29x33zIog4k6msYBk/i+C4Ya9rnUYAb6LcYl
         /4hg==
X-Forwarded-Encrypted: i=1; AFNElJ9QIFC2wnc7OgwZvAS7NlEq/7/z0hYBNTQ/CioTI6AG50YFzqfKqlymvWll31+M4HlhwXQMMqFM@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdOQGaavVrXqW7V8vexDtyhs3jdY9TJUaFX984eVmDUqyU7S+
	FO52amxWQFso8QS5pCPRHcr6cy/IViMh9HZuBZiYKIeBHFtU3B3SiIw7
X-Gm-Gg: AeBDietKllVgPjRRx3hjAzF86dXTa49ALB0fRsb9u7T2Os63gPk8PSGYcwBbdFJ5zj7
	77wZ5P7UmWPkHov9L1THvY3SPwhP5JfgGxQn4k7rmtApBV5HN8wp+YTiL8UT2X7tQDg8cIgyOkS
	y9EacBDrTYSBCuOEVYEIi2Md+Bwr5fSFRKgwy/olsnql0V2/8DQqsDSGOPVI0wZ5GxckLN/hEBI
	kRj688IISAh+knH0ouqYuFx3Ra1YWx2QsxOcM6ha/xz4tYl033K/MuTyT3kGqUNmaIvudKJi5c6
	pDk+bdRmnr7WwTzKoz2gguSrCUh14tzLFl59iLBf9R69ZwcqbRIDUDOCTHi4oQKX6gthzUYwi98
	VXet83LBlVKhi5MtBbZuyff3n9zuhb0E8kDv+J78nIXwGpzxKEvo6/zieNndOAC3iM9wRtr1Bol
	XeKyqXXe6eypXfHXyDihCXXFSKFUH9uPUTvreCOj4DixJqQ6YCY9K1dp8=
X-Received: by 2002:a05:6871:3861:b0:417:a283:9c81 with SMTP id 586e51a60fabf-43476281571mr7457002fac.35.1777995571187;
        Tue, 05 May 2026 08:39:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d35e5bsm13955814fac.15.2026.05.05.08.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:30 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 15/22] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Tue,  5 May 2026 08:38:44 -0700
Message-ID: <20260505153854.1612033-16-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 005F94D089A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15619-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When swap is virtualized, we no longer pre-allocate a slot on swapfile
for each zswap entry. Do not start the zswap shrinker if there is no
physical swap slots available.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index e8aa9201ea30..751687b7e2b9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1214,6 +1214,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
+	/*
+	 * When swap is virtualized, we do not have any swap slots on swapfile
+	 * preallocated for zswap objects. If there is no slot available, we
+	 * cannot writeback and should just bail out here.
+	 */
+	if (!get_nr_swap_pages())
+		return 0;
+
 	/*
 	 * The shrinker resumes swap writeback, which will enter block
 	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
-- 
2.52.0


