Return-Path: <cgroups+bounces-7143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E204A68539
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5494243EA
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239324EF77;
	Wed, 19 Mar 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhqkxPxt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4128211486;
	Wed, 19 Mar 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366548; cv=none; b=qUu3qmf/SaixNeUR9Jr3lwSXA6GFmmZvC4YKmWwCz941gziT5UW2ilwc4Qls+dHsc8vg3Nlh8W3gBzBnv+GGm5w194aqfLmkzjb042Rt5wTDG0KNC9sQYa0Q59KKNr5eHEMXWZDxPYvWDJXu7ku43NK05fvY+ReZ9wg1n8Pdu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366548; c=relaxed/simple;
	bh=yFX+tNRG+cyoEMpYQZtrIgkGdqwU2A6wwNqYVnh2f90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqKyrAdn7Zz/2sCFy53UdG/wM0E/IZOU7rYkxG+DE7mm7QZP5iMvRLj9xaFUxSZEDSYINRAkV11nfM5iAWnzMsDEUnmdhFMjvf9c91zo0wn23fFrRHUXMRNxDQi1PF0htzGh8QFxCe/aqacH/cXrkW4Wi7EsEmkzBHNG4Hxi8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhqkxPxt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22403cbb47fso121806165ad.0;
        Tue, 18 Mar 2025 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366546; x=1742971346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sp0DFTtVb9BoLhEjuOHuZHKpQHrM7JXx2GisdIMoCLI=;
        b=BhqkxPxtQ7+qiJzuuaTjM0BJZXMidG8sv8lknhpnfczftokJWSW3xf6VYm5AOlszpU
         XrEsbSwGChUNYvib7l0QT/nv9kDVkCzbfURnc+RrcBBTmpe+UOTIIWFb2/LJhgSBFA+0
         YgobXsJ+hTmGOGbxpyynKi18tgWfWYx5nEzPY+vNDK9QlmDyG+Rs7ejgzTH3Vu5MOEZk
         UHQkgfajcR23d9ClS5LfPYF9Ek0QCQ6aUKgX0W0sKg4ukkLZ+44O5Q617X9hFHvk04WR
         R4W1jBORxPPHX3sGzJV5Mk/iytNqZ6NFSknFrltuF4hc4L9x6xGOXDj+Ow4DA51+VV2k
         LSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366546; x=1742971346;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sp0DFTtVb9BoLhEjuOHuZHKpQHrM7JXx2GisdIMoCLI=;
        b=Bzq4chmEUu+2aXQC8N8ea4Q3/OCHWnvIjGaOQrxEulJuExyK3/+UwLPoea5n76UeIH
         QsMbjQLz49S0sw/GyRw/gL4/bgrGUnN58KZufsqP/mR+J1z67IH4U+3h5gDTiv1lHSjC
         OQVFs6/86Pv4lq2t8MzNQEuoXfL4YX4rmunRA+/zG2+tqBD2L9yB8JQde8ZUwEf0f4Sy
         QX9k+lgfRnesNxS8f49oFuJirusNBCYlGrIBfneYLE2fzz0ItDnrpZKJx9JlXjApPRLk
         0Ynkd8yOCSb+xciYvDfAQKhHnOJmIn/sNv8mPK+Su9e71nmvW/UvqOLtmcOclpCjtoWo
         z29A==
X-Forwarded-Encrypted: i=1; AJvYcCUrTfKEDv4lpd2eYL97uvgg6fpf2FrSjnbF9LSz2jMK9ONeERVcSx6wtfoyZ1Zh1YqMX/zbb8ZJpi7WwS6g@vger.kernel.org, AJvYcCXTkWMG9TRdSaeBPVxT/ZSrjesv7pFiqdw51J7OgyhmCFMWepGYYKGkMroNhOSUq5O68usuVKgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyPr2+mNEmOr5IDa9gYQC47z3E7VIow48xD6fgYnPhCAYKlm1vT
	QZTt1gE10ktf4FGXEHFafvT5PW58ruhAQPWu2dztw4PHBhI4T1ZE
X-Gm-Gg: ASbGncv6S5BLpnw6D3SdZYGe60LgfVVYYfsGCECZSGMlCbgGt2V6suzm4nbPjaMJ3AJ
	Q2D6KmFmxVCHnsjAeAPvA2QJ/OzxA6iee2uuZsAO7LIa6uXm6BqYJYVqlMEbkxjt6lVcZ2O8jXZ
	ljw+l8gq8JSqU3jWoERlk7VCwCEbZ0AIPNqV8o9oE5I6b5muRHVA67rJBRsDJ9Y57oe/ec+3y98
	FP0iBPXbooxxWICQJPWK8UMXOEgdIKbj3SF62/WiRrt2uGbbTFuc3+fxQPKO5I6a8/KN5sLYZg/
	1xmVdBbqzIWVPqibru65oIfrafMcd/fAqEp7nkfweett/Gid43hC5yKCHYNWfFcDkQXQ194NgCq
	uHbRWnde6i7ENyQ==
X-Google-Smtp-Source: AGHT+IHEPdhlKFwFwnOTSvPf4IDO0wzZjBYO2qh3ge8Q7B0xYnKSmm8x+kb9JdKPYwCJ9YhdNLB2kg==
X-Received: by 2002:a17:902:e5c9:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-2264982afffmr25696235ad.5.1742366546036;
        Tue, 18 Mar 2025 23:42:26 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm106191835ad.70.2025.03.18.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:42:25 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [RFC 2/5] memcontrol: add boot option to enable memsw account on dfl
Date: Wed, 19 Mar 2025 14:41:45 +0800
Message-ID: <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

Added cgroup.memsw_account_on_dfl startup parameter, which
is off by default. When enabled in cgroupv2 mode, the memory
accounting mode of swap will be reverted to cgroupv1 mode.

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 include/linux/memcontrol.h |  4 +++-
 mm/memcontrol.c            | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dcb087ee6e8d..96f2fad1c351 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
+DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
 /* Whether enable memory+swap account in cgroupv2 */
 static inline bool do_memsw_account_on_dfl(void)
 {
-	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
+	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
+				|| static_branch_unlikely(&memsw_account_on_dfl);
 }
 
 #define MEM_CGROUP_ID_SHIFT	16
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 768d6b15dbfa..c1171fb2bfd6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
 subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_SWAP */
+
+DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
+static int __init memsw_account_on_dfl_setup(char *s)
+{
+	if (!strcmp(s, "1"))
+		static_branch_enable(&memsw_account_on_dfl);
+	else if (!strcmp(s, "0"))
+		static_branch_disable(&memsw_account_on_dfl);
+	return 1;
+}
+__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
+
\ No newline at end of file
-- 
2.41.1


