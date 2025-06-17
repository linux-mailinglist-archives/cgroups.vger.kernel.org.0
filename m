Return-Path: <cgroups+bounces-8561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500BADCDA1
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890B43A6DA2
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379EB2356C6;
	Tue, 17 Jun 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eeeubEMo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734702E2643
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167433; cv=none; b=d2vAW1n6oow/les1Kzpxo353zjgjIi3n8yFkH7IMcKynQs9+5O1NCiMEtRGvXuf4HcxhZvfM8IL8VRI8flelilq+vFttoxJt9+6VwbelPNB6SNK5Hzyd5MERv/JaiSRlv0tXFhOebmnI3NEBrClePo+LXZPL+mScN7J1rwlCZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167433; c=relaxed/simple;
	bh=syEOF23WYnR+m4ZXDu5w2UCFevHV0uRwaU7OFMcE7RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zp2OJXHr75zZlyWr8XHAEHFv78ZckKTaSKYKmaIWb4EE0xgv0il6sBAzmTLDv36DzMjlnGSSK2OQDV+CS3Hz9hzJoiyYDgn036PJeiSAA1z+UW09BWv4MZL/Q7e1vJooJvjOrDh4S481qR9/A+WcDAyFtQA86x6QDTOcH/Yjs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eeeubEMo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45347d6cba3so6940235e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167429; x=1750772229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAb6vAt4cs//1SvpF4Ccxpw3YC8TLR2gb172yFffxHY=;
        b=eeeubEMojDy8IavtdzD88nb70r8zDEOBGSONI9yUjo8UqzFDIGqlTE1j/a1PXJ29z7
         f8m1JJ0PiT8S223orRhpW1QTRerbgaFXLXv6b4TQtMsPgh0I0RWP9sOTR2EEnw0ebY+2
         wRHMKxP6Jc2C5hYk6kgc2kgXp4G9z/ob7F6vANYHUO1IJU+UzD48bhHxAmMlXzT3ha9r
         1NhceHyrJ9Y1CpKCaB9KzEJ1BK/BitLLsXTY284RUvzI0De+aqvC25e+iWMy6vdnPLDX
         dFhsCnKTth+CTIy8vNTjG7SRiAIoxvOWkBYgOKjVePGlsDV4eYeNr+jYIqAsovEkZbDD
         VAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167429; x=1750772229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAb6vAt4cs//1SvpF4Ccxpw3YC8TLR2gb172yFffxHY=;
        b=aeXhBv1qGtflGnW0INONXwjDKI78pyawD/OMg8Tka7KK6BxF/qdyIcgsMqmYbbhl7U
         MQJXt/CGA1WZ3mLw7CpMs51ou1N78Zz/f8B612yAlRskq4d4qMONQ6Bcw0IT3BLj76QB
         itOmNHM7kPbMMZ/gdhjntF2BA9zRNUcnF/ghoUsyxOwyuaYK4eaC/F5c4RRSbcxaJX3Z
         YS7jOp5kDhCWRYoJ9qDwFdWqKXXbeFsS1a9hOmzkTjj8/Rsb9JX9c5jSfxYelQi+VyNv
         oIAuCJHrvOyJJcvwNq5v2tynLOxfohJOtWz8VnJwTvkfK1+xRyLcSv81U/6QoWyJ5Txl
         vF9w==
X-Forwarded-Encrypted: i=1; AJvYcCXZWQuRLPO4G034E/6/RpjlyTjK1u4kxlxJmRO0bsDy7QxviO05O3HispzJEuTJJQODi17ym3KS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AnJSX5CeaN4gDO88V33bTm8/+g/MSByIBcM40LHcxgsQbvR/
	7ikW7c+NXc7gZVd9Fga5IMsDtbXx2Kk7hMy0QxPHcoVuVpwBaJwGJhgtUj6eybSEEjQ=
X-Gm-Gg: ASbGncuRtK/ngSviVE17T5orhKqh05l6bYKdYTjZoUdwk8x3QMgcmVD/GgrVQ9LvCuB
	4MyJaxmY/vbtJhzO3ewIIrPkNgc+4TRveHmojRsMVDwSsTr6CFfjptgHp9VPyB6BDw6rQ4ER/Zh
	Sg4ERCUdWCgjIaNYnKXqP4klsdOmBHcL5ZMZofv1Wa9PQRV3EEQxM4ul2FELECsxwwPR+Hw4P0O
	wr6Do6ddW9D2+fFp8wVAZ0KbXgp7JAc/uSOP4HBQ+VYTKPQsHtYrwrWPV6p+ak2bNHlmuNXCsKM
	+QNAEy16eLNQdsJ24qx1OLGtPF3X8eE0NOqGwW0T6AWVCyJ3YSZm0FfAXnfpf6MbQcchEpI7eOk
	=
X-Google-Smtp-Source: AGHT+IGyp/xTGp5oc1Flc0suMmUx+z84Pn68KeWyBolHGZeBeRUJhIRXZcDbZoi8bBEnqcyDMtHfRg==
X-Received: by 2002:a05:600c:470c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-4533caf534cmr134483935e9.8.1750167428760;
        Tue, 17 Jun 2025 06:37:08 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:08 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/4] selftests: cgroup: Add support for named v1 hierarchies in test_core
Date: Tue, 17 Jun 2025 15:36:52 +0200
Message-ID: <20250617133701.400095-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This comes useful when using selftests from mainline on older
kernels/setups that still rely on cgroup v1 while maintains single
variant of selftests.
The core tests that rely on v2 specific features are skipped, the
remaining ones are adjusted to work with a v1 hierarchy.

The expected output on v1 system:
    ok 1 # SKIP test_cgcore_internal_process_constraint
    ok 2 # SKIP test_cgcore_top_down_constraint_enable
    ok 3 # SKIP test_cgcore_top_down_constraint_disable
    ok 4 # SKIP test_cgcore_no_internal_process_constraint_on_threads
    ok 5 # SKIP test_cgcore_parent_becomes_threaded
    ok 6 # SKIP test_cgcore_invalid_domain
    ok 7 # SKIP test_cgcore_populated
    ok 8 test_cgcore_proc_migration
    ok 9 test_cgcore_thread_migration
    ok 10 test_cgcore_destroy
    ok 11 test_cgcore_lesser_euid_open
    ok 12 # SKIP test_cgcore_lesser_ns_open

Michal Koutný (4):
  selftests: cgroup_util: Add helpers for testing named v1 hierarchies
  selftests: cgroup: Add support for named v1 hierarchies in test_core
  selftests: cgroup: Optionally set up v1 environment
  selftests: cgroup: Fix compilation on pre-cgroupns kernels

 .../selftests/cgroup/lib/cgroup_util.c        |  4 +-
 .../cgroup/lib/include/cgroup_util.h          |  5 ++
 tools/testing/selftests/cgroup/test_core.c    | 84 ++++++++++++++++---
 3 files changed, 82 insertions(+), 11 deletions(-)


base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
-- 
2.49.0


