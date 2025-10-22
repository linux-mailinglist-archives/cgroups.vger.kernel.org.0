Return-Path: <cgroups+bounces-10978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A318CBFA4AB
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 08:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33093ABF1C
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F52F1FEE;
	Wed, 22 Oct 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPmNdNta"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624522F2604
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115579; cv=none; b=u3oWZmUP52zYr6qRmy6iD93bjITTewz3NErm/t56wmMhW2oryJe95kXBeyx5ht6nwKLUiIcnxOpqAPGLSVHhqkCFTuwmdVDaov6NKoPFzL04YYTvuL6ACTtK0rEywo/EZ3S8u3j0jzZLXDQoa18ecYrYb5mg/kAcTvRLnhQ1N+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115579; c=relaxed/simple;
	bh=VoHNU79GvKrSKfQmG6epwNhyluBaNgi52sGNFJTeT0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/cKTPwk23vRxuEo79Oo1uOOxKs6IMTloz1675EuMInVpUkCrsA0pMKd7YyqY9cc/FC7Z0DoZ0tk4dStMPzWRD3HZHOlk1o5muGcFfiAiF6MsFJWEHUXXu0BdV/HVWkepOOdAxnvL9bw3jbYnGsbn+t3LekH8Vh6tKcowBaqpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPmNdNta; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47103b6058fso4012305e9.1
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115575; x=1761720375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC78h9CGmJYdLYYgLZzfeVoSnDU5W9zxrCuIx9lESzk=;
        b=EPmNdNtaNyyxhZWV5ZoCJeLrtKgTk6LGs4rbshdx0zxZfSnjIDRufWp5WuRvYiyy7j
         guSL5PDd7MsCT80sUJczGZVbykJ21Tj8BPXavF6scc46vFt/Ufjx0PdoqLX6mIRXERCe
         EWQagTa77GTdtwKedmojipbYiebWe96SRLvFysL+Cz6t+IqbD6DgIz8rDRw7NZvbj9qB
         8dIf8A+b07gMhsLIGO0/uUqnWtsuns/fkODe60LhIFAxX7kOj/g6l9hvZmqKHP3Oyym9
         3xSZH1AWdwl2LZgEJl2BjlpqsWxbCCIkU2Bo21iHJ+a9ix7ymA4K4h5vZPNiThzp8iUQ
         rUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115575; x=1761720375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SC78h9CGmJYdLYYgLZzfeVoSnDU5W9zxrCuIx9lESzk=;
        b=YcEv8VWG4Wucg9uF7MKLVmwUqEVr4kag2tuCdl2ugJJp1GTy8fDvPxRHC5r+CmN7Rh
         fx1RX5HKOhpyAhfCO8CXuAv00p/QdsTrA4Q9Xwvh3/uIXGGxrdDNKbmLuU0P0RcTlrEd
         tziY4roKTC7Y4hXskAUdaNhgd6WVQx7khtHSrCoCmkZ6S2AyGKeWkbiMfOGGghqigGsF
         z7Z+/K4TZ9HYTXf9DRktn0b9azWGQiR0aZF6HqVuwNx1gruRY2Uifb2TmqQhcVS6DB3J
         JkF7ao5Xzlgnoh0c7Ily3pSQUs5pJQVYq+Uachx49Xb9pWGTwR/ipwX52byrRdRz014c
         y0cA==
X-Gm-Message-State: AOJu0YxsWdmTCVxFxEKusQN8JmWX2Hyi+Hd4fMkAWGHnqMfFA7eaECTc
	RsWidlG1hcltI9e+iJk1fLdLim8YTb1Birdgarb8ybAXUZmMc7vsYNaFQcjZww==
X-Gm-Gg: ASbGncst3592sQ3Pk485wSO87UJEWqySDeWjOOMjqbQ2XGVL/Vk6RVIxEo1gKS0AtV3
	M/A8vxWx28po0WGtdOeNwxxglWPxdbXaoJu1yCM9+6Zq+ZajabnrM9Vf5V/zLRzLeko+C+m46gY
	mgYUZNHaQ+ZYE3nGTVq/NJBsQw6hAyU7O96M+PplKxRcXTLxFp9bhhpwMa11m77gz4PAIRHC+Hs
	I6tLZ1bab4lZAjko+qlZobSdQj3wqTYnEzPNavgygkIvx7MSoDoPnhuKK3/UcX9ESiV4F2YDo/H
	rH+OvVZBmBtWbu7Cy0G8SAxfrH6hRctAFgiZYVIiIeGiGzUErwEibMbG5+REiA+zitlMRskSc1D
	42VWtVVTUdrMOjGq2ktj7OcEk1YFvOjSH9gQ4a6bxNLLnF+IgxTsOgX7ERb84xz0L4Z1AP4+nW1
	/Z+B8s56LMNapNv2N1phiAZrWMRrFjJK/6r2gNQNexXa1Nh+eD1PNPVTQZXwt1
X-Google-Smtp-Source: AGHT+IFtT75sCC+cIJ8tS3pWdbqHOYBRH10Anf71XABUd9YbEISRoY9C0RptuG+0Vrk1OlCkO/wjdQ==
X-Received: by 2002:a05:600c:8b84:b0:471:793:e795 with SMTP id 5b1f17b1804b1-475c6ed4639mr2954135e9.0.1761115575338;
        Tue, 21 Oct 2025 23:46:15 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm29931785e9.15.2025.10.21.23.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:46:15 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 0/5] selftests/cgroup: add metrics mode and detailed CPU test diagnostics
Date: Wed, 22 Oct 2025 08:45:56 +0200
Message-ID: <20251022064601.15945-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

following the idea of better diagnostics and debugging for the cgroup tests:
https://lore.kernel.org/cgroups/20251015080022.14883-1-sebastian.chlad@suse.com
here is a proposal how to go further with this.

The series consolidates helper functions in the utils file and renames them
for clarity. It also introduces the `CGROUP_TEST_METRICS` environment variable,
which, when set, enables detailed per-test metrics reporting. This makes it
much easier to analyze trends across CI runs, track regressions, and assess
how close actual results are to expected tolerances.

If this approach looks acceptable, I plan to extend it to additional cgroup
tests and introduce supporting utility functions where appropriate.
Also I consider metrics_report.txt to be updated with more serious test runs against
multicore server(s) and possibily some cloud-based machines.

Thanks,
Sebastian Chlad


Sebastian Chlad (5):
  selftests/cgroup: move utils functions to .c file
  selftests/cgroup: add metrics mode for detailed test reporting
  selftests/cgroup: rename values_close() to check_tolerance()
  selftests/cgroup: rename values_close_report() to report_metrics()
  selftests/cgroup: add aggregated CPU test metrics report

 .../selftests/cgroup/lib/cgroup_util.c        | 37 ++++++++++++++++++
 .../cgroup/lib/include/cgroup_util.h          | 29 +-------------
 .../selftests/cgroup/metrics_report.txt       | 20 ++++++++++
 tools/testing/selftests/cgroup/test_cpu.c     | 38 +++++++++++++------
 .../selftests/cgroup/test_hugetlb_memcg.c     |  6 +--
 .../selftests/cgroup/test_memcontrol.c        | 28 +++++++-------
 6 files changed, 103 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/metrics_report.txt

-- 
2.51.0


