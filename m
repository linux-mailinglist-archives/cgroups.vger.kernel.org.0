Return-Path: <cgroups+bounces-10332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC950B8FCEA
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 11:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B882A02E1
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB242FB623;
	Mon, 22 Sep 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K41XHuHd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AC2FB98A
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534129; cv=none; b=lkNwst8I7Mzfrn03QNtzxAzbnL/s/95U7Sa5p9y0IjRfYaFIX8agco182hEpwxo4MRe12xB8PcxqSKNYkibq7/0G6bKwp3hF7QOYmvjafA+RfzFSaY4u52w1TsxfKIxBiZhzf3eThgeWUie/yaEqQxk6/KHpzmZVl6eX48xqwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534129; c=relaxed/simple;
	bh=1fZ7uZviR12rEngACFAWSQEQQ2EujzRN08ukEAfB3yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwJ9jh9DeVo1oVXcEprAXm/DYOHPVq4Iwg6zy52KrsN4UEagva+r9OvjS0V9fBkVGfZAUhlfjDeRo3Cn47XwHX83eo8FbM6IBceSo6kYHqhVsbx6nGqFu4YETDWN2fe4bprZHVGPYrOKbth1hbkek53njmlhhZoUxCKI3Xj+1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K41XHuHd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5518177251so1743063a12.0
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534127; x=1759138927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knShu2WB1nekyCXSMkQd4YYY4q1/2M50bRHS1z1OFIA=;
        b=K41XHuHdO1kdod3v2kDZ6xADmhQyxvefbQjKSRB4OBC1QuzjrUlWSNAcCILxkF27vs
         AkTqsIyQalAXoWGadaWOwm1NSacTLnmCU9yMWgl2nKGarmeqSslJlf3S3Nh+RJCzVWeK
         a324n3thQ+u7UKF3pH0cDMg3MzdZQMRR2T54WFHCcZfgjJzLVXiA1HyxhH12d5vAAdtE
         ZYfjQh2nItO107Ab+Z1m7b7EwyCOuuQz0hIoXA5DjMf+GPSb7lxuYN2NBJAzxMSYeyWZ
         48I2xu8tKURSuLKg9QU/NTQuw6YGy+xolOlWT8s3rsHyNrF2MBY+WDZzkNXgJ1v+n7LM
         +zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534127; x=1759138927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knShu2WB1nekyCXSMkQd4YYY4q1/2M50bRHS1z1OFIA=;
        b=II+/zBVXy5dDgHANECEyPlji1j7Xb65O6vff3KabOlJt4LeigRqlPOEjZAHBJPBfA2
         z8GdEVr2hqPh0d3s29H6DJo7KXrJMotved7+1Gd2GBny01kvPzkMRZg1tYhMulWphCDq
         Ih/9WdxLrBjCD/9INs6JIl6uUwkOCex/0EoobS20TVqOLUCiwlDRjFtygs6LSQF8kLk5
         YHGZZ/35TXe0anOA3y/HA+PdiX8y+34oytJLUCHzsoxVJxBznSeP4cQ1PtUYRuPSVElc
         Nczgu6LrPYgznSsx9jCnT6uk2pWVHldJ4bXUGx7O61I5mZTWOrWKU8s1MRf2EQN/eLD/
         H7LQ==
X-Gm-Message-State: AOJu0YzKU36SUspgEuqK3wQx0CspNkGlcUiAeEl3At/kjSAku31mxs8k
	I2w+1T2R2RMwhIIbe10SKAoa+eTSCe9ZcwmyJZfaEyTMAy0dta160QC3QnCzI5n6AkbV5Ww997i
	qx8+UGPU=
X-Gm-Gg: ASbGnctVKWu1EfmKSc3sk2wpy6kKqyPP3124QqEnok9gx5xxECm2wFN5dRrHPImvyzn
	tq4CHu+40Nd/iXHQiCZdGOl63ol3AOuOYRSdH5LF8+H7upxrLrPkT4WAwy+9X5XD6rInS1Us8r9
	DE4IfgtaIgx68KX5WGwJHLiqlIJcP9SKVN33BQjw4A+fPKB6lMb8WCMNbuK73Ue1G9cty9Ik1Q8
	ZXrK/3M3q0nr6FmzUWyz3IW4B59yXUXko4SNRbJYgiKC26dYAt02q1KH2Y5MnUwcXqSeCHaPevf
	A72k9/XNPHecsRGn9FUMHlJ+fpuk5rwiiqj75it+iitZSKuQxejmbT2iV4pbhNj1J2HOc0bSazZ
	Q4SHUfdgQLSZHOrpJZ9FLbsO5QrEDhrgNfPz5
X-Google-Smtp-Source: AGHT+IEKQqaW75NwldMxFG0uIxBj1RxwlHvk40EHsE9KBkx/V3aCLEgpZJRJGmMKZpoisXIb1QsxfQ==
X-Received: by 2002:a17:90b:2681:b0:32e:38b0:1600 with SMTP id 98e67ed59e1d1-33097fd897emr15908772a91.6.1758534126690;
        Mon, 22 Sep 2025 02:42:06 -0700 (PDT)
Received: from localhost ([106.38.226.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55268e73f6sm7544132a12.21.2025.09.22.02.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:42:06 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 3/3] memcg: Don't trigger hung task warnings when memcg is releasing resources.
Date: Mon, 22 Sep 2025 17:41:46 +0800
Message-Id: <20250922094146.708272-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hung task warning in mem_cgroup_css_free() is undesirable and
unnecessary since it does not affect any user behavior and there
is no misbehavior at the kernel code level.

Use wb_wait_for_completion_no_hung() to eliminate the possible
hung task warning.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..b7d9e795dd64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3913,7 +3913,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+		wb_wait_for_completion_no_hung(&memcg->cgwb_frn[i].done);
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


