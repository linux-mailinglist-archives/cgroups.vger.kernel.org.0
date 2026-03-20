Return-Path: <cgroups+bounces-14957-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDqkKtGgvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14957-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:32:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218D2E0052
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FAD33090F9C
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930293F1669;
	Fri, 20 Mar 2026 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5jDX5eZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3923F075F
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034884; cv=none; b=t+OthMjLFYMyATCdqqfaEeAOauS/6Hy0NMhk+jlbG5fhoqG171Xeom1XLpJglBl3/Y3Q5tzkRMhYEaVu8MwZ4mMeOMCQVDzWeXTCvsQCt/nzTYP+VdP8Upvqmq1TVRoesPNj+P70e6R02FmyS2Q7VSbuNIN87yloIxs2h6NYjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034884; c=relaxed/simple;
	bh=XUG2nMpJeoG6B9ljhBEIzGZmx65mAIf5essHdmFCXwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G99Z0S2lcn185WlbcI5qfnJbdsUWm2sGF8GfMSvQ0wdltKCafmVkfBjMv4i7UCVxTCuoKeVLjzU2dlo141sHGbsLUNIzVUcfeGn0VJOfWJ1E8CpE8bRB8Lz9/p8Hd9JT0qkj1r1cnoxNALRxkPnV9VMkq781twMz4pJLM8Sum5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5jDX5eZ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d1872504cbso2094130a34.0
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034880; x=1774639680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNNnmWHnRUZm7wwtDTGZLy0ujBXuugSXcNtRiTK4tAk=;
        b=G5jDX5eZ2N8vsVsh3AW57fvTO13stWOPKCHCVBnmLB4ZPbwTv00jDue2osfhDFzEks
         fGdVlICJszPw/EexqrvkznTjgMQg3KbljDqR3v+P09CElbo+dsZg1o81ElQNyee5C2Wk
         VBZ8ukXobDw939y8Ugqp9E9ZujgA1K6zjUOjFAbIEZg5ex7r9+GTM45vDOfXItFoK1Q9
         tZeJd1w6gJF/jKvXOtOoCYBDlvIN413msPNVfJ2q+ahyYU7uHBa/l3QjdliHjx62tUVN
         +Gk/yI9gC6mEVn3DOOoaaB6aPhkksIL992akGZGAHYThBkDPotx27/7NEQ8Pxtiwu9mF
         1rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034880; x=1774639680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNNnmWHnRUZm7wwtDTGZLy0ujBXuugSXcNtRiTK4tAk=;
        b=oYKVSJdQIsOaJPH0G6MTs/bU2THMFS72GZN8K3d7YHsyPCX4lGWJrNeROxZNBCTgBN
         v7a+I8uYtBk9YVjWd/A2v7RQ08+ANgnpPqvjokIlOGwVD4FmLFl6m5+wbvfYRTGiKJFD
         juJaajJpTqVGZQAjxZpTqTeXetZZmdufUtBCXln0Hrld7lB3uERLlrVyWrIwf416p/QA
         WujjAytt+Uvc5G4psY/SttoWSA6H9ylnNMMBH76EIg/cGbP7Q5gvtH0oXrB/O/mxAqKf
         SBPC5YeGFKwwQO6wkVkGxf+/uExnqnY8vjniz/BLjfZzaOHK8PujbluPSg51Fti28jg5
         VMZg==
X-Forwarded-Encrypted: i=1; AJvYcCXMloHynlRuBCkh6yiw4Sf2AsFL7goavfQm7KlfJ1P9qkSVSqIb8YZd4VwyJoRL7SRjs2ppac0/@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuruxcGCuq68akYMDlvHy2m+zsccTsuD/YFbZRJoUnBxV/Hzn
	/PsptnOHkweKavWQPfOGHROE85vjNOZ2BqzwXL7BYL4IP0Q5XaiLdeDY
X-Gm-Gg: ATEYQzwyeV8BuHkZFK6Dnml3/3vxPwLdqzgxtCHa/tx7zFsiTUaZpACPQ5goUvIotXD
	WME4RatxMmoAiQjgh0vBHDk0zQ2a+M4GMFMPyJnBwat1wyyS/ylMpcDNpS+1Vfz1coZHcy058Cq
	BrIgJXD20hbuy0R18P3yTUFSCDIrGRz+SBUP4LXBjf3+13CXQYvM39kDACUDwvQAsNmCnbXhghX
	OPrnpsc34YmUUEczJNnQ75dz3xmtXaKV0xOGbXcqE/POZ+ONTwRjAg+dvbXu3O3zUQHzR90b22u
	p7i9KsJexGJsJmKCkfEe5fhVRciAakZ/yzsdOWD048934TNKCSl8Cd/1w1X+vQciKlPV2QFJLdV
	xXpNlDAuoT3okpt4DN9M1cOeAHcEz8V7brstvvWJpyfb+UXl2e1RjZrwWKz+uuujoJX3jINVEK/
	pr84v638AmbseQUbQhQHPgOpyI5HHiMBFI+l0wNN+iLA==
X-Received: by 2002:a05:6830:2c08:b0:7d7:4eaa:8b82 with SMTP id 46e09a7af769-7d7da7d0888mr4861812a34.17.1774034879806;
        Fri, 20 Mar 2026 12:27:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae27691sm2931366a34.24.2026.03.20.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:59 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v5 15/21] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Fri, 20 Mar 2026 12:27:29 -0700
Message-ID: <20260320192735.748051-16-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14957-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.882];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6218D2E0052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.52.0


