Return-Path: <cgroups+bounces-6821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A2A4E549
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395C68A0FA6
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B45290BB7;
	Tue,  4 Mar 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CIjlrGVD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73627C873
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102743; cv=none; b=Stot0egTxU8feaK+/jwzu8mZy7RfL+GtRnt0/Td3Yru+rSZScB4pEgwQojECLRNHVv02ruNgpmtHB0/kO2LxgmqYB7eD7efWdn4Z7SI4VVYRV8rMzEK61UpE+io1RPjdXrfRrcCHpE2+KsrI7eORAl+gn+EJ+uHP3XTi8VkExyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102743; c=relaxed/simple;
	bh=m52peCNVice4dNNY5xbCz5VOoTIMY+0qmJAW8b2N3QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTd2fXi+oIGrEdzGFBNLwfC4fAGX1ZH0sjwlGk1xEwlj9GYzM7CaiY5qzlFeY7aP4VvQCAY1/i5/hyhYVWl45BOSlwjEbuELSilefbLyjmFp24G9BZ4PdtCx3Qz6JR7QswYw7dykZ9CJa745UmjW+aClAK0ya2BZnktLGbLI9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CIjlrGVD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bbb440520so27358855e9.2
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102740; x=1741707540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0SMnkypgJ+E0WuuzIPm19tlt9b9dHVVlixZH4mmHVo=;
        b=CIjlrGVD0tl2N1dEl0VymJokuUjMCJi27QUmXaxHeMRaLwon9MBFTUQSJLV9rbUAm9
         avvwf5k/Pc1u5vYR1tpZihY+tzq0nyhjjeP2DmbTdKrEAfkvOSt5S3tZ0jdE3dVMm7DH
         dv6tswX6zFpK7r7/mP+iViWiapeG+9ty+cT4W3kDycLoo+mBRVL52aeWFAwvBUvAZbjC
         3skbz+xMJQjhnrGSZnNIkmXl2Q9RcBhPb3ZG8dXDXe6FgBR7d7J7h/SQicnuPAwPYgZE
         oTlvsQlzzir8ZRPxynCEJreh5tFrBVqRbnLIoYsbgW6HGeAXemeL4RuOKh/T/wKxUbAe
         w4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102740; x=1741707540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0SMnkypgJ+E0WuuzIPm19tlt9b9dHVVlixZH4mmHVo=;
        b=RIddmk5D2qMWDE1+9hh9bTRQEk7J+Fe8wE2iYttPy/sTedxPvYqXyTnty06nzb8GAG
         2rJDUYRgPcJJwmpn/wjhNjxk6ADpKHE7R3TRTBHtIGPZSxOP0cNV9gOzQ75jKCgNYdfm
         u0ESLhglf/cP4U/r0igugasetcLY5CktSnSE+wAhsZYlcuM5ELYb7WztS1GDRrwf1W0I
         0lRygcrknPJoIE0bW1C/KOtg/9fLXC5lcUhRNKjGhz0Q1MALaoJxZvq/iP8TY85c6KbI
         2ii/jcCnHATBWtHEWAwTVzqsQWvyC+U6Qz43S4K29vnQTqaH3VT9Mnptc3cnGh9s/yJm
         EYpw==
X-Gm-Message-State: AOJu0YzY1hDxWwVK+TqIWNPcUh5jy4Uk476ZgSunD2PuuhtRaM8wqYrA
	nSiGOSB6PRUZhbO6Pheozb+9l1qXY9aM3655r63R7otROEhk2ZwTkRSOF445t7pzmfSCL9Oj3kh
	WxRg=
X-Gm-Gg: ASbGncsarK2Msm50ZMMZaQoDljRcL1JjslnPR8pYJe5wQTOBV4RrAJIxBAIJKRdq9c4
	TX/Y1o3sNApr6KyJ58pgYPjJLPZBqAwcXIwIKUdBdpmRgfnTEevVLRPeRb7Tuu21KDe3i+5ojsm
	skkO0eM3iMQ8Fh1BcrJCGNA+67SV1bpmnxoKV2aSjAiX3p6AgYneGjx1HmsOdc3cCw9z1HiJho8
	Qsh56XDQlam9VxX39/KnTtYq362bIpv0IHAmnQdPJvlRjXiEddH5URzardRLHQm8giFzUpfYgNz
	90bLqxyVq9Qmnb5iGm+AB1HOse7ccezJb56BhvMotWl1i1A=
X-Google-Smtp-Source: AGHT+IHVsiEQmN3Y21537PIQvBH5PobiQYRSPlH0O79ylXjcUAzUwaUszPliAbCkCArUCFHUG5m/LA==
X-Received: by 2002:a05:600c:4685:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ba67045camr187495795e9.14.1741102740250;
        Tue, 04 Mar 2025 07:39:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:00 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: [PATCH 7/9] RFC cgroup/cpuset-v1: Add deprecation warnings to sched_relax_domain_level
Date: Tue,  4 Mar 2025 16:37:59 +0100
Message-ID: <20250304153801.597907-8-mkoutny@suse.com>
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

This is not a properly hierarchical resource, it might be better
implemented based on a sched_attr.

Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 6155d890f10a4..ada6fcdffe0b5 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -175,6 +175,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 
 	switch (type) {
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = update_relax_domain_level(cs, val);
 		break;
 	default:
-- 
2.48.1


