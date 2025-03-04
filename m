Return-Path: <cgroups+bounces-6815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0856A4E4CE
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1009E8A3E74
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744C283697;
	Tue,  4 Mar 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5Gbhjvy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA528368C
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102725; cv=none; b=uhb3qv8IhoO0iyi+D4Ot80S2+Bboc4wyoB3zL4XHykp+gmjE9IXaFZz8nOvLKOBLTv5SaDzMy6mggclluDFLtB/BUhiOK9d50VxnYBP7My9HcMilXSMIK9FVm73MGm1Y/RndiGENE4g2KWZPD5M8yyZWm3uC8uyE+s3LCY/RKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102725; c=relaxed/simple;
	bh=n4HhF0iE5d/zFnVCBm46vTJrbP1QNpIud73Lm3o314M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtYJ3Oae0OR/MTkeTJlTlWNdyNI8JtJbUBZQURLRawm5Bqh+H65iVKqZgTukbUmarjEIbCbSIE+1hC2Y3vJ4YVvH5GmXgvCc79jWjH09DRZ1uVIDYuXINBCQ2dD6OjdVXKbSCfUBBUb9l5UmMjHiMNuo7HKxn3IDOJ6dqmsxQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5Gbhjvy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so37838995e9.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102721; x=1741707521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDY1B2OgIPZSJkU1XkPMYSxsKEiRbouQuwYY7R8HO+0=;
        b=O5Gbhjvyz1AbPH2XY5j8usKVLea3mIH8afcb1jSDErxdguD/2ZgCi9YaQvXRXJU4nS
         c/hG42fQ9ixjctO6Ae+Nx69F0j7DDfE9YTp3gf3aVKTUC4fJQSofvi2/O7QAJgZtC9FY
         8BCC87kqSq0GyYbo3EgH5jrnGsGSli/8Jo3UVgbhf+G0012VnwLXnz4W48rj9Nd/42ug
         wS2JidLH+p8Ug97ruqcBc06XyRAbMZg80jXtVfhW4CxmWlkadtmSLWm1sxr/b/9NUQrp
         GvYt3IVOaqcpjYCdG7JrCdazwg6cxBWA/rFnEnsgZ80W+dSuKSSVgJxO6raVRsRhozlc
         dGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102721; x=1741707521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDY1B2OgIPZSJkU1XkPMYSxsKEiRbouQuwYY7R8HO+0=;
        b=h2389ZM+XCY05sOBNx3o/ilupQYVqHm68zmI7qap86EQ88w2HrW25Br3yNGKhow0QA
         xq7whpFu4cyXHEAyRvcAhzqjskiT6FzcjMVf8DWoY6fNiAXwVM8V018Z8sMHC/NU+FdO
         JTnBWjG5+Hta8WviVwZAlX4RlHKhI+YWdIzfCplRK7B2h7aIdRmaKjkmu6kmkaU9w/YK
         tAGxBdTA/3hHerxUuZkyILxsIz+tymR9KE5U/nuNn8/TnQfO+Y4EGGKCAXCJT5PEJ8ac
         BEiOc27hVzq0XNUs2gDH+Os3+l21ICShMTNsNk9eAyMgpGUUqfeiAzJNB5+SbGSj0kvd
         fwpg==
X-Gm-Message-State: AOJu0Yx4CGJeQ2xK0c7HFefD86FacSevxbEVShW+/RX1h6UoRL03s22o
	z8IG7uToJUQVt2XBptmRXn0eLDK7M6BPHFngf87DUZTWeatugl/CQ+6XmzuADc2Ll3BY+9FgoCl
	MKFM=
X-Gm-Gg: ASbGncstZvSZwYR/bPAfl0vfZ15+7KSksFMm7wBGHVf5/0xqCEQbH7KGn3Ak9nXWUU0
	Dh9gRUnhJgHOzTba2eFwRbBR75RP5U1IVuSZpa8bqd9wLFZfbbzDNlVB1Pa09+ZRMXG7Yi5HxJJ
	arRtZXsemfs+bNuWq6NgoSOB/Nn9+y7YB1NUI3D6/H50bLgbsd8slDFWtXXbh0XmuWZbLSzK1vR
	BH+OITaynRjmAlm1xpGfp0oH5kUmXhT3+tdEMwutNXExgZb3/JlJ8572iKCxp7NFrybuO4K/DME
	RHxZGsDwj5HJjlvusYps1mAEKG0dT6OF+P2Mf+OAALYMHWY=
X-Google-Smtp-Source: AGHT+IEK7jyhUNwdxioelGYxeSf+GoJMffZJrLOw6owQIFfGVyUvngoXcwDOhtyH+GDoI3MOes9CWg==
X-Received: by 2002:a05:600c:4685:b0:439:9a5b:87d4 with SMTP id 5b1f17b1804b1-43ba67047bemr148306905e9.13.1741102721047;
        Tue, 04 Mar 2025 07:38:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:40 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to sched_load_balance and memory_pressure_enabled
Date: Tue,  4 Mar 2025 16:37:53 +0100
Message-ID: <20250304153801.597907-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These two v1 feature have analogues in cgroup v2.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f2..3e81ac76578c7 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
+		pr_warn_once("cpuset.%s is deprecated, use cpus.partition instead\n", cft->name);
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
+		pr_warn_once("cpuset.%s is deprecated, use memory.pressure instead\n", cft->name);
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
-- 
2.48.1


