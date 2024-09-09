Return-Path: <cgroups+bounces-4770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922A971F4E
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 18:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B94AB230E5
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAF170853;
	Mon,  9 Sep 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MpjFeQ6t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2116BE01
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899551; cv=none; b=AlG3d5uxxnUJUjd0hSqL55x/Ku/kgfGkX5vyRNdl+8ktayR22mzwprde+CjAkrFPKcJ4o7mNA+g3+hqceZC0o3oUUkINhqncXAe2BT8YCf3ifOztpdwr2glyBWmNlg7EK6p0UD6CPGcQxPfq2Spca7KUy7ktJvnGxd84xEBRBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899551; c=relaxed/simple;
	bh=6q24Sp43zvOQTSTocJSxRysPj4M+BbhTWRuqYELVHXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwtVJNoh0VaOl1AKw9yR+lGgDU+cxrai0mvZpIGh7nZPBtm7oxb0ZNHLPkRoAqcc74LmXNTEhqCHF/ekb2SkLKXMTidO9aREvnCTf+4McC75whBdnXhPQ1P3DVc2qG9WM5cEkgZ2TI5EFKCz67aFm/jj5t5pY/gq+1bnLV8SkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MpjFeQ6t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb2191107so12985575e9.1
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899548; x=1726504348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHl5njwEzB57TRyVYxUn9e/V7vkUkmiZqA1k5LmJoXo=;
        b=MpjFeQ6tRlXW3eQz59/Wu+XipbKWGHlmoKSsMNvcQJrFeuNtPTh44sfQCungAoin26
         ARlX8wMn3v9nrqOST06wscoWNVc8znIu1kYhOvfIjyohOHIOgUoWqsFYYLx4N51I6Fsb
         /lDQ1FTe6ObM4jruhdyc3XT/aJRvgaXBYua5NaHRddp9rjpVqZ15sGWfsnWEA64mJbLt
         64W7Gd4qNJi353cZ7CnI1PhmKCIQ6jQge1FPgOjlQw3b8g4pTRy4nZSJv+6fgKtkdDzp
         W+B49TAehdcOATFpxUQQRa0mezrO8QJ2dusQ1FEk/5bJOij/WLtKYLIGaMhgtJbJYxGm
         au/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899548; x=1726504348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHl5njwEzB57TRyVYxUn9e/V7vkUkmiZqA1k5LmJoXo=;
        b=kRxmP+YPJUss4hDXoGDncASQz6Y5XLsc19MxJ14aQLS+aq7spRmrxFtGku3LUHQDle
         7htEtJefe60KR7J/57obyVCYsRoR3dQKrx8wKOjSwRWDuoL0BkcVimKifHxVBfE+/LSx
         +S+0ZD13/f1FcxSZqhCqHjDeqpmKGnF3Clt97cGnpgGwvX01OcawgWrkC8IEwG6012mA
         Xj/er93hJMtXpypNv9FNx32YAobDi75mPxMi5KydXsMdgExankSDKHflu951BpIdSeUA
         k4JmLQhAyu9hqfiXdPlgyPQq8DCCT9IVAOWIdPKR6rVa9zx4tUH75Jp0NxNeJgQAlTVu
         B2pQ==
X-Gm-Message-State: AOJu0Yw9F9l8qGpZkCSVnS5ya0LwSaoqtKNz4mEmwye1q27sWyObtjaq
	IU3MyeROREyz6FLwyJDBQqmFxClip6bNOLqH30pxBQi39hq8pK8TN2msiJGouj7uLp0IPEzDACk
	X
X-Google-Smtp-Source: AGHT+IH/NtJ7GDbpp/KCJNR64qpb8/rUL9ftAz+gBxAS7bLeKc9E0iYJrQXSaE8AaWMsJe84oBWC9A==
X-Received: by 2002:a05:600c:314c:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42cadb699b9mr62524805e9.32.1725899547875;
        Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in /proc/cgroups
Date: Mon,  9 Sep 2024 18:32:23 +0200
Message-ID: <20240909163223.3693529-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909163223.3693529-1-mkoutny@suse.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a followup to CONFIG-urability of cpuset and memory controllers
for v1 hierarchies. Make the output in /proc/cgroups reflect that
!CONFIG_CPUSETS_V1 is like !CONFIG_CPUSETS and
!CONFIG_MEMCG_V1 is like !CONFIG_MEMCG.

The intended effect is that hiding the unavailable controllers will hint
users not to try mounting them on v1.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 784337694a4be..e28d5f0d20ed0 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -681,11 +681,14 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 * cgroup_mutex contention.
 	 */
 
-	for_each_subsys(ss, i)
+	for_each_subsys(ss, i) {
+		if (cgroup1_subsys_absent(ss))
+			continue;
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
+	}
 
 	return 0;
 }
-- 
2.46.0


