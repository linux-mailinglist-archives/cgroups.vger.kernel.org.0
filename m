Return-Path: <cgroups+bounces-6963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D056EA5C16B
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B63189ABF4
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46882571B2;
	Tue, 11 Mar 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MxRf14Iw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49A25525A
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696619; cv=none; b=G58TUXzggOb+zVK2ZlFOzxF5A+3bBvMYQLb0sjWn8C4TgM1ewk0P3FYrrnNesG9PA7r2YI++DUFt9cAOOlQg1YQIShlF8vc11Rt7O5yKFmNiXr02Vlwbr5/YoYin+wCvG7dxzBnKuO0n+RWkauziX54YB4aOjwbMpTg+TQ5a6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696619; c=relaxed/simple;
	bh=8xlbP+kPuJXj1ujVkaKJJ/Ff/doqow82behndxtTC6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIk7o7Zrw9Dx1r5IzPbajyEM3B7QB39+UBuFuIv1uDn0S+auY/BFmHObLEAyY4wnmCJBHKrL9QSkWWk4pv5oML7pSL44RFGzEtYDAF4YTz6iSVAZXI0QQwYbxN97LOoUrE3AeGmgg/FZvC9q5yUbDRfSsEGNFPfnKif2DXPlGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MxRf14Iw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so12304795e9.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696616; x=1742301416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pokNekKuPIs26oz3GPhZwq4tj8n939iVWBrHJ6WBnec=;
        b=MxRf14Iw5+GDGa/WdDxrbcra34DUz0Vmh92YgIe7Uzt3/FE3j0sBBr+sdOaCwEg048
         0ANvq/BEOvWHJH6Gs8fTZqt2ii3T8vixyHsqV1QdxvhvoM8robZ8WH7zjKgZ0GnlZ0fB
         fK5I71HCGkaLSuRNCc7Mgtr/oaWbP2QcfD9u1hJBz0EJAHk0KGkRo1ifOHwkVCP8xYX8
         2LrXzYf99AduAIQisk3fv9rPEGVhulrVp59O8LvP07kCk8JiA4R62Sa3R7pfp94habp4
         HMO7rtRO4rohkYiP0fx28Z9kpkpJkWM8yytxBBNuHDDY5CluB9o5fH2ZxXjB9qNlTMZ+
         2THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696616; x=1742301416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pokNekKuPIs26oz3GPhZwq4tj8n939iVWBrHJ6WBnec=;
        b=dETUAEg992uR2BRlvw4kUQjfc1PgKETHSvSBnQqRfip6K1vxCaaDQtI1asfAGxBqgT
         U+UVmi/NTmBwz0RXFza6v/cNkqh6jJuI5luK/dTjn5X8tD7Qi1zyR2oz7k3XBn7r5I0j
         RROck+7PDEyMi3rpFV3brIOwXExva4y3PXpO8fs3s1SppeNoQtjWSViOVYJh/6bVI6lt
         AzfSs8kS8CTipkazLuTeEfpxp9yCoHPeJzGL+JCG04iySBqDvVRdVq/rD+ZiskVyEYAh
         RHAXgCDR03/a7Yd/bDVMOXx5+86sphvMXSYQdcXLdBaN257A6emjCifUmu7klZX1AE4T
         b6fA==
X-Gm-Message-State: AOJu0YzQvioc43bcl79wXQy748rGQ6a/aT91AzYGsQbmhsNuhNSe0m6T
	ww0z3x73PEZnBGBbXriX7RokQnuvEJnww9q/hfeCg3S+nAGNtrcIqOV7d7jzl0TmH+5pdrg8ZQQ
	g+d8=
X-Gm-Gg: ASbGnct2RbFvE6UbE6L7RD24nXrnkaKBclZj0m20gtOvSK3fgDehc1iPRSViIm5hDWX
	A+Zc8sg5SJQvMaQ49XfymfBi8KFwwbjy9FNPKyTzkUctxIMie61mpxMmfpd7R/QRWlcAnGU1l9d
	Dr4mWuoLhpZdSeVK233hcBBd/DboA7PE1oLrV6Ac0iA6iuzs4mQk5K92OpBxg6gdJyafNRYyI8d
	twjYTxu9x+g3Aj7lY6kt16+N29H40ehGFXOZDr7DvIferhufWtYVIkbmir/QymgAHDYabj54hJb
	iUEC/jEvB4jN854NR0rWgeg87VbJMO0BF4nKBUAyJIlnjUA=
X-Google-Smtp-Source: AGHT+IHODza/GMf9T09SMT422tZdvwqWv0XTo4CpUj/5PPPS2WJqoiJLOke3WnMQoceqcT1Uu1Y5Xg==
X-Received: by 2002:a05:600c:4f02:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d01d25bafmr42168185e9.9.1741696615816;
        Tue, 11 Mar 2025 05:36:55 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:55 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 02/11] cgroup/cpuset-v1: Add deprecation messages to memory_spread_page and memory_spread_slab
Date: Tue, 11 Mar 2025 13:36:19 +0100
Message-ID: <20250311123640.530377-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is MPOL_INTERLEAVE for user explicit allocations.
Deprecate spreading of allocations that users carry out unwittingly.
Use straight warning level for slab spreading since such a knob is
unnecessarily intertwined with slab allocator.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 9d47b20c03c4b..fea8a0cb7ae1d 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
 		break;
 	case FILE_SPREAD_SLAB:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
 	default:
-- 
2.48.1


