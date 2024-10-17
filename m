Return-Path: <cgroups+bounces-5152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30039A27EB
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301FD1C211F4
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5D1DE2A6;
	Thu, 17 Oct 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La2duIdQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01213B797;
	Thu, 17 Oct 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181082; cv=none; b=Bhhj/on/ckkPQOls/JfwGdk8h8b1MqKRdOM6t6YFLikQr2s9D3CXf5UCWDi8QQEnTsPVeH4ASgde+WyxO4hXkLh1nOBrdLlaKNTKtCW2UMawE/40r1ZybIn1yTk78LrhR8sUNe++KZXgAwl1xTWPLBmHHyG5Ww5K3Egc58BAsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181082; c=relaxed/simple;
	bh=SZv9Ge2gLPPyhzWPwz/aM196GoNOneNQoedvRLu3PBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6Dyx1LhIAETI7JfzAR8Wwn/65wO/m7Uw3gZyCca/l4NX+vurADYyhK4pgh83/EeJ2fUtHr+gLL9mlFpBp4E1Xb6hrZz074yQAFavY4akr4WwYn+nFb8ilJx+SA+Ncaz4qCgEEQVolX5uI5trx/KcjfYcAjxh+vHfL3VwLZAOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La2duIdQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e305c2987bso11440277b3.0;
        Thu, 17 Oct 2024 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729181080; x=1729785880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQQfcVXhiZjyD5+Uuz4bB71/1uXjkNUShX25v17NHhI=;
        b=La2duIdQt38pJFWm5Zh3eZDCBsAdn+qgICG1HDmoeP3Q9tic7AMIRXwuMuVYZr/igl
         aHmQar13JfAqWl2zX8HBM/nLLfuQvcVwSdB1nFFFIUgwkpAG4RBuV7T4GrBiKRZfuzuS
         jpACCB4SZmqYyPknvOC7WMtNHS/Y1q9ZM+Alg+TYKUZt8pQRV0TJU36UfT8XuKB3wrFW
         QbYnfWn9XWqdl05kOR+39tmro4wVq2F1XlW/ZdvMq6DiBrLTeLnVPFvyL2dl8Tisf9Qq
         ATeL6mjm6r4yofkzRs2At42nSx40AibeDgnv0rHvn54fYbZvouF45+qZH3vVcBZwobmF
         pmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181080; x=1729785880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQQfcVXhiZjyD5+Uuz4bB71/1uXjkNUShX25v17NHhI=;
        b=daCNzRrkPKcJJnEWZbQmgzJ6uISh/fLZPpNXdeyTADSvCKKUe1TdMZ5nO8iu4jFki4
         1zfQiQSYzdTzRZTRxjDt5MaYLTBuSsZG++/bEyAWB9rzC9QEK7bUPbEmT3fXHZgIqKP+
         xySBKku7xrPWUXM3t9UEPkYj7SgbTiUnLiTA89FX5DkOboRYKUQFbIhfKRcVePonpTRe
         x5S4VMi5Ukmx5mrUufCeBG49wyxhZez483Vmxz3QNSVMyTNIdthkzGXMymDPG2tTW1IA
         dkswxAT/o8eKj/kAUtN9Im3Nr2ulg4W5g1SFLcnF5YvYrIH68B8QxxSpWGZB5IpnQkJK
         ss/g==
X-Forwarded-Encrypted: i=1; AJvYcCVnj+CJWGndJT52/CVhJYXDO5rpWTtOZMNSMPmvyU3e0ZZYzwlp13b1icJukO7tBHz+HeKqJBSpQuMgHwA0@vger.kernel.org, AJvYcCW90SDa/6LUVaeoEVaFD8yofmPfdTab+XbdyCPDYMo4RQQWm/CztpiMrrbpHKqY4rRUf0uX8OCT@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsU6eQ4qSAH46AdFvuHAAB95Bevmnj3CgRkebW8ntArdVCWCs
	2xuhefn7wbJCwQkd0G48MEYltuq2WlL9n41uhvZ2BaeZaGhqsfHqLd4h2g/3
X-Google-Smtp-Source: AGHT+IGN/xdBom9ZZqdHTpsB+1NWpcYL8veo5a8BAcCHN4xw06eY7bO5RU2+0auKELs7aMZh0mSUqg==
X-Received: by 2002:a05:690c:4c0f:b0:6e3:d4e3:b9b7 with SMTP id 00721157ae682-6e3d4e4fc02mr82899327b3.35.1729181079842;
        Thu, 17 Oct 2024 09:04:39 -0700 (PDT)
Received: from localhost (fwdproxy-frc-029.fbsv.net. [2a03:2880:21ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b370f8sm11770317b3.31.2024.10.17.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:04:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org
Cc: nphamcs@gmail.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lnyng@meta.com
Subject: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory controller
Date: Thu, 17 Oct 2024 09:04:37 -0700
Message-ID: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HugeTLB usage is a metric that can provide utility for monitors hoping
to get more insight into the memory usage patterns in cgroups. It also
helps identify if large folios are being distributed efficiently across
workloads, so that tasks that can take most advantage of reduced TLB
misses are prioritized.

While cgroupv2's hugeTLB controller does report this value, some users
who wish to track hugeTLB usage might not want to take on the additional
overhead or the features of the controller just to use the metric.
This patch introduces hugeTLB usage in the memcg stats, mirroring the
value in the hugeTLB controller and offering a more fine-grained
cgroup-level breakdown of the value in /proc/meminfo.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Joshua Hahn (1):
  Adding hugeTLB counters to memory controller

 include/linux/memcontrol.h | 3 +++
 mm/hugetlb.c               | 5 +++++
 mm/memcontrol.c            | 6 ++++++
 3 files changed, 14 insertions(+)

-- 
2.43.5


