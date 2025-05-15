Return-Path: <cgroups+bounces-8199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F746AB7A79
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0DE7A7FFB
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F158F66;
	Thu, 15 May 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBz/FAme"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822DDDC5
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268391; cv=none; b=ol1CJgm1m/iirBkGWbI2TLKpv7rYElfxxQ1J5V7j0r6ThIYymvzR6H9Jm5qqnqsh4Gjl7b5VWnji9t01jBxhGSn7OSqPY3kk4AoopeW+75+25nnWGKGBCVxtwYHJmL0ElrljOTmQ6CCsMoRzkBo+Ym6r/ZCYwm34OT+wauiCq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268391; c=relaxed/simple;
	bh=zaNtRvLpE+t7Es7rBzQaDChKsEIzwVsWAJ/OdsSLfd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZVZlUoe7roMG7C0iV9++Z+ToFu7T2gqF6lKFAsrOKmMLXABTELwbfAkgXt2M1yEElP7XXBk3N5U9k37HpmaqfhVXtvgmFfrS5Gzrwclnxlp79gOObdPrXQxS08WLXBSuqlPyHkaVbq3UmZMOxZzB6WEAIPsKdSDWRZhT9iEbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBz/FAme; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e4db05fe8so3376975ad.0
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268389; x=1747873189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoHTrur8vFgYGG4ZwqYr5heeWh0VSEnM0Ly4JM1txjc=;
        b=jBz/FAmeMGtGdxZLMowk38N3OQBLY4ar5SoeZ3URILLwvcJdKMPZDo/c4O3HWm579V
         HyjgY0Xd9WSk6OP6wM/Q4MqbglSFyTihM1re65uKFV30MDTRKiLUNtAfvzJ3gU5bzTKK
         7QbXfHzNbfwuJRKuEla0iYw7gt4SVu7b1c9HHMCFiDlvHhvsUT6th4pWAu3kdJqHtFWs
         ZPszX6LDOnjX9fKNFn37nHEULi7fiiP3z1nDs8tzmO97SUOzIqKR9JbuA/KNhCBt0Ppj
         Bwqmr0A667/YDx/LvfZHJSqzo+d9hGM+zurnRTIpPiiHYlo81u5V3uEEUVOVurucmqk8
         jGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268389; x=1747873189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoHTrur8vFgYGG4ZwqYr5heeWh0VSEnM0Ly4JM1txjc=;
        b=QYvy2O9ywK3lY1qhbd1CcptTAR21PLSfYSjWzSgfDBJSTNBHsVCAMvE0ufzhsbdCwn
         YZo3KyFimhLi+LQBlgcgRArOOD0ULDp2td0AHzhEkOFTvFQ6QIgJ+VNVBsy786Y/tkYh
         2P7w35q9C6f4xKh5bxIv+wuHKkUYAR8O64IfUwfQ9/gKAsePplq+0VyW49fBUT30vEDI
         FCXppsL5Ge2uNWGMsnS/K4WTHWBJtZkBuWKMP3zJ8p1bxmsZSiiZ0FI76x/Nw0TssD0n
         8YFEZt4z9Nt3yMMaAR149VTvp6C6aclPMVPePR6BA8J7oCQkVsNfQYdbMkSuHzruBDuo
         cksg==
X-Forwarded-Encrypted: i=1; AJvYcCWtcaZdXGZ3BnNh6trOEX65X4yD47XLGHU5AgUUAwOtyGNVT+EG+5ibvwNZYwul1cjA6GR7HuEa@vger.kernel.org
X-Gm-Message-State: AOJu0YypC/f3wSoBZss4awJyyWwJNnHNOKR8WGrCphdYXMCQd58z2853
	NdJXrhtVRS8wImCiYLZb7lbnSQucg5LCVZfbG2QwFnX+00BNLUfm
X-Gm-Gg: ASbGncv7P8bdZ8hyGwR6/a/v/rimI1DFD73/icy57kgErOSeufu6qwEf8CnSzEkkz6g
	9WM5qQCaRtPTlFpYbkTFV8peKVvEDLOyNfkhpS3ABFef/3PhYHLqbba/tprDUV/y1bZ0J3VT0U3
	VHIHbUpT0/N7HfclqKRUBPJzxu27p8sCH7KYtP44I3Xzuu8AXW95ZlzAI5e0coWqFBjtBHCZA0/
	AdfHaUeQ6gALPfJcrWBEB9DLSW1R7IPvY4fTxzsQe2Ad9a2KKsIKYINggbMWdrt70GIlJ2hf4qJ
	d94um7YW2IL56QOl2BfLNBLEbMAOtm1/Yj/2pjPqaCidnJ6DiF9adQk/PRTg0f0f8tsYN+mYG9q
	/5ia1/dBxVs9ZG5+58VH/o4xO/jb6fexS2rRb0ZI=
X-Google-Smtp-Source: AGHT+IEJR/VRlpD2kJCvyrL2wn90TWebmmOKUCa8C+HTp0tXQdv9ro3m1ilZgBPy8lNMvs+knaGAsw==
X-Received: by 2002:a17:903:2a90:b0:223:5a6e:b2c with SMTP id d9443c01a7336-231b5e31349mr7314155ad.17.1747268388862;
        Wed, 14 May 2025 17:19:48 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:48 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v6 1/6] cgroup: warn on rstat usage by early init subsystems
Date: Wed, 14 May 2025 17:19:32 -0700
Message-ID: <20250515001937.219505-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515001937.219505-1-inwardvessel@gmail.com>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An early init subsystem that attempts to make use of rstat can lead to
failures during early boot. The reason for this is the timing in which the
css's of the root cgroup have css_online() invoked on them. At the point of
this call, there is a stated assumption that a cgroup has "successfully
completed all allocations" [0]. An example of a subsystem that relies on
the previously mentioned assumption [0] is the memory subsystem. Within its
implementation of css_online(), work is queued to asynchronously begin
flushing via rstat. In the early init path for a given subsystem, having
rstat enabled leads to this sequence:

cgroup_init_early()
	for_each_subsys(ss, ssid)
	    if (ss->early_init)
		cgroup_init_subsys(ss, true)

cgroup_init_subsys(ss, early_init)
    css = ss->css_alloc(...)
    init_and_link_css(css, ss, ...)
    ...
    online_css(css)

online_css(css)
    ss = css->ss
    ss->css_online(css)

Continuing to use the memory subsystem as an example, the issue with this
sequence is that css_rstat_init() has not been called yet. This means there
is now a race between the pending async work to flush rstat and the call to
css_rstat_init(). So a flush can occur within the given cgroup while the
rstat fields are not initialized.

Since we are in the early init phase, the rstat fields cannot be
initialized because they require per-cpu allocations. So it's not possible
to have css_rstat_init() called early enough (before online_css()). This
patch treats the combination of early init and rstat the same as as other
invalid conditions.

[0] Documentation/admin-guide/cgroup-v1/cgroups.rst (section: css_online)

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7471811a00de..83b35c22da95 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6149,6 +6149,8 @@ int __init cgroup_init_early(void)
 		     ss->id, ss->name);
 		WARN(strlen(cgroup_subsys_name[i]) > MAX_CGROUP_TYPE_NAMELEN,
 		     "cgroup_subsys_name %s too long\n", cgroup_subsys_name[i]);
+		WARN(ss->early_init && ss->css_rstat_flush,
+		     "cgroup rstat cannot be used with early init subsystem\n");
 
 		ss->id = i;
 		ss->name = cgroup_subsys_name[i];
-- 
2.47.1


