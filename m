Return-Path: <cgroups+bounces-13787-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDCXH20HiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13787-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:00:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C110A533
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 704253009898
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D934FF67;
	Sun,  8 Feb 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfpipKKC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020E286D57
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587955; cv=none; b=J3/EgY0CIpdTce5vGNqzyuUldiECXsuZXGrO81shzSGsoXZs9m5efF71iFD9BnrCr/vuQp13zsTQHV0vwbe6WGeYX/PiKZF806iCbObvVn3Si0MTKZdBj1wGlrEJqjHMZam3hU0GLb2LEUXkLPVOw3cjmWFkQYK2Go589VRvuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587955; c=relaxed/simple;
	bh=XBmrk0o39FAOIaDvlicMy3Eh3cFwDg1bVSNwmZISXsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDlHrOUug9yemeUESjCB61VO/S8xd32k+WUUPfwySot3QsFfAOPx/1/MnXTG9BlkToD9cgFKMRX7nnH+BtiPBWWV/ZvCvXG/hvH2BMvS0h6VMKnp1txZLN19cvBLsotnhv03SujOzukEQKksTtrQsOq2pAcWLNaG+ScVYhMb9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfpipKKC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfd0f349c4so2365295a34.1
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587954; x=1771192754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QY06q/ir2j1hW+S2SjYAeivUq/qdnGKxDWe/px5J+A=;
        b=FfpipKKCVpCqx7HM3BYiH/RMENXLSiIR/koRgxvzc0aEp5P9xmN9glHJwl8q2XaKHZ
         dcckmxhxAPICg0IQe3X0r4r8iUR4Xuz/gGZ33/nZ7uTyUCFjtF1TO+0JlCTXC6YxGM1/
         WVqJtenzA4TS0JTlwjdQD+dj48Gerb4OgoMt1Dx6J4arQkRjDZGjwUSPbdHPwYjzXftz
         Z76+33cpHzq2aWrLh2jFkYDNSA+ocGivVuBHJZc0tdR7ob3swV1fECOPqZ8fFdTUShpZ
         QuZz+vjdwRZGV2kzem/qq0xI+RfM6dQtbWW2XIp43UGUwWpjiLyTVJlQEMQbrvSknzLT
         q13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587954; x=1771192754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QY06q/ir2j1hW+S2SjYAeivUq/qdnGKxDWe/px5J+A=;
        b=oN4bi/0XjXkZkwqD0K2L3s19F4HAuXnMOP+MvIpe66FJeJ3gXfm+qAiOu/aznp164d
         /J3BaXGWXnj0TVSjU4Y1NCL/bd1wk+cFmUkslA1niBMZEfZu+oTaVrmjE6TLs07BWvQl
         VF2IinQWEyVEuuhvzR/GXSg+KkU1HT2VS/CMS4yHP2eobH/RJrsHTIhilidmXT24Bl8l
         EmiXukEr4oj/mxkQySYhu31RJ5BaCWhD/f+45AN+c84Baue26/Aw10hfdjsFovPJxNJO
         qn/BqJAzvqfIZhT5Bf9NTUBNLVYP/jGjlk9t0Q7AIycjzSOOBQHM8mqoMYrrV84xcWmI
         r3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkqbiiDYbfZyK2a2YdN1TFvwY9ulVFDZo6UEIr8Qrd/zpbrpQQ9vBDvBue7xIldlBeOKGHrAl@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXCn96parmdJtfk2exwYHDkdKMqMRvMlu9wteER+TP1cKcCXh
	S6v4G1QPr5RkgDlUV5dvn8cImVHEPwfGof0wE6ssnm76ccI0/3VEkahX
X-Gm-Gg: AZuq6aJu5Eb5j42Gd4xvN3sY5Vo1OnkGCD6q5ri7TqU2XY95xlH3O1iLKinqPg/M0ll
	uMdcldJmYbX1T+bJXlf7CTZ8KSsbt+bipb3F6y0fUN/GYsT/0oYXsKZD2bG0wB9fDiLTMP27Xv9
	IQUjQHeSJ0NL04jBcINaHZEvdVGIPrjvjfrCiM5dUke5i+vhHaCTFj7i7U9i+slef0AeZeX65zn
	qXlUVyuIs/XwIovVawgtYhwbRLxQSMcXP4g2FoyhpEmhvfnOwivcPtYE0QtpIAa1qBjbv/4aqJA
	AJnJph1FSQIYP1m9klVRUtcsQcbAgaoJzK6C0j0swD8b0d0gzj6qrta03QFqJB1KoJSCQFnW99M
	YdzTcRQ2LTPDUP5qqs7k7oSS+b/+HbfERDNClMbVEAfUMCJMYqi1r+lyXNmRr9kqdpHpAO4ZeJL
	7Skk+TGPqqPRco1E/YkPufgJiFg5XQCl9mFsT6aKcpY2o=
X-Received: by 2002:a05:6820:16a6:b0:659:9a49:8f50 with SMTP id 006d021491bc7-66d32bfa23emr4293572eaf.21.1770587954007;
        Sun, 08 Feb 2026 13:59:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d391ae639sm4737086eaf.7.2026.02.08.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:12 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 15/20] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Sun,  8 Feb 2026 13:58:28 -0800
Message-ID: <20260208215839.87595-16-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13787-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 354C110A533
X-Rspamd-Action: no action

When swap is virtualized, we no longer pre-allocate a slot on swapfile
for each zswap entry. Do not start the zswap shrinker if there is no
physical swap slots available.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index c5e1d252cb463..9d1822753d321 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1211,6 +1211,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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
2.47.3


