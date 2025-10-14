Return-Path: <cgroups+bounces-10737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C15DBDA01F
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 093EE354BF9
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7D2D2485;
	Tue, 14 Oct 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdsralV2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD72D46D6
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452323; cv=none; b=UO/rLCfzoVYG7B6MG5p/cKg0PqvE0rINQzvRnCvB35UStsBQXB0wxZFpEQ6pjlOUH1MHXEYx2mBIUs0Na2QfqBZ/bS8l6G8Pv8ktCC6COW/RFxUlqo4j2gKkesnkWlWIhaz6ehSzOF+DB+HUNJgnZAmEwqvDWzO2iT6i1DFw7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452323; c=relaxed/simple;
	bh=gjh4QhBHu4Qc9BhdSnXBnaee4e/zkqPVaQGo2x9dGik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbelgvRRH3qaya9VY2fN90u61NV5J+wWApsOZ9v7I2B1zjacshuRLcUh8PSveVDCiPKC12hv2wzB8PQ/y9Q5h4ysxCsJPFl8u3Qd0LGOlioCeQtIeuqx8wk7cADh/EaE8v7wdV+cenohGzZDXtbV1/gAWBHnbipoqTljbyyoeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdsralV2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so4521713f8f.3
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452320; x=1761057120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+NkHoDNL6WKsnr+YBvVlS30RTqS9Ya1EtCaQ+zR5AA=;
        b=SdsralV2tOP3DcyDPactBVE1FQadmO4hghIKsgNo1wIdMnXn16Z9ZOztsZcTv/Xxy4
         fbw+Dc7qC2LIAcyDglNDHh5pxmYUGQYbJ59u1l/i0dSqxxjOBeTajl0M4m/g/NnrXWbg
         xlmkjtWMDcsTYP0x2UUMZz7b3Z1Pjxp1Rpe8jdiH/fMrDbMvs5dD/KuLLzOm2pJ9l97F
         Fa5VWkx6nb3PwZ4jvuWQWqy1QiKYnNLFWPbv1ENFjXxqdE9cv0GBU1jaCN7mj9FR1w1H
         w2er1zyacEqh8ILPCMbHx6a7WVwIlFjsbFpELhB9OZLjwzCLyx1iydt7Cd5qFbDS6pKP
         FsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452320; x=1761057120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+NkHoDNL6WKsnr+YBvVlS30RTqS9Ya1EtCaQ+zR5AA=;
        b=cWVL3Oe0hD+MGef8qejt9A0PvIiRQvbH/ZGWUyNDxOFQl9W8EsT8i3rd8tZRLviuIc
         1cOtsyMWjjoXL2QphKA7mWbNghXSgVS54/csZOlA6Xp3Jwv2PGFFo9Wx5UCxKy4/pEOQ
         IIQWLPN7s/K5PA2SPYEF/7cRHamxd8yYghK7H+Vn2aCd7JNcxFJwRACHjlNE7uuVS0q/
         3hvytI/CEKFLsvc+Vc2lDVzmv0eR5o6ahunMNek+kkGWrZZi8mfGfJPo1uourKC6KQZX
         YqzzbB2W8oTuEnHT8PpepbxY4WG+2ZqVgrQBHaq26BchI41Cc6cr4BizlSLVz032ElHt
         PJKQ==
X-Gm-Message-State: AOJu0YyHtzgc9KHk6j8NaYYCSJrXclpziof1VUXtCX6/ihtAHv8laoDr
	BLHtYVZzWJI7f6riHg5MZDAI1zjfKRwrWXB5u5II5wbwHP6qwKDd3R7o2gvA3A==
X-Gm-Gg: ASbGnctWzc1lMb0vhJgh3zTa2oXw5JNcq3NKPcbaWxcIhpuSLzkKG6EihoOKuwS+43e
	57MqjXI+c9cWCUS7UpJ0FSc6X/sLfwO4CmfN56hzV+Cja7nBAxptnOkSxqKbNUWN3T3vdosF4qw
	6zPCbDD9+rvVtXU7fgQp6Sz49iflUxOBu7ZVp8FM+eW6bnXWH6LIPk218Vd5U50skuOP/E1ZuFG
	QuW8uTTXiwFUvf6prkeBOj0PB12skPOVGF9bNkiHbT5X7c+eFiG4s3KP5aVH8xCPsntjy8UMbe/
	T23Y/uO9ORrz/YfATIKEpUj/6RV5RbT5oynO0Vb41qfWBabitxtAwgo7FEk7/eHkWBdSEnGcAmS
	94TSw1YNinwOZ9hkj/Ao1c2pY5IGkmLjDJg9h6AomTDorGRSk5l4g5mdyNHLVy3nL6YWtvZ6WRF
	Z0Zl614gZOaTinwYfVwm3BFV1+sA==
X-Google-Smtp-Source: AGHT+IHqDJ4UL0p7RjgX7jXuBxLEuB4NO/aaVcCCcLDUdDOY0RXYRs03l9r48fmrI3+IfYQSU7RdCA==
X-Received: by 2002:a05:6000:4382:b0:3fd:3bcc:c239 with SMTP id ffacd0b85a97d-42666ac465fmr18903600f8f.5.1760452319813;
        Tue, 14 Oct 2025 07:31:59 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e13b6sm24044431f8f.44.2025.10.14.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:31:59 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 0/2] selftests: cgroup: improve diagnostics for CPU test failures
Date: Tue, 14 Oct 2025 16:31:49 +0200
Message-ID: <20251014143151.5790-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While running cgroup selftests under CI, the `test_cpu` tests sometimes fail
and it is impossible to tell how significant is the deviation. Often times the failures
are very marginal, but the existing output does not provide enough context to
understand how far the actual values were from the expected ones.

This is an initial idea to get this sorted by adding a new helper: `values_close_assert()`,
which prints detailed diagnostic information when two values differ by more than
a given tolerance.

This makes CI logs much more informative in the event of a close
failure without changing normal test behavior.
If the direction is fine, the next steps will be to extend this verbosity to additional
cgroup selftests for easier CI runs and debugging.

Thanks,
SebChlad

Sebastian Chlad (2):
  selftests: cgroup: add values_close_assert helper
  selftests: cgroup: Use values_close_assert in test_cpu

 .../cgroup/lib/include/cgroup_util.h          | 21 +++++++++++++++++++
 tools/testing/selftests/cgroup/test_cpu.c     | 18 ++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.51.0


