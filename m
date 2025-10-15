Return-Path: <cgroups+bounces-10763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D395EBDD452
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53F01922766
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303D2D374A;
	Wed, 15 Oct 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFxHDPOQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3722D193B
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515231; cv=none; b=X+vaQZuqZygIMSHPM4uP911g+uWf7RTOGNYnnKI9ylew7Jr9ZRju/eO0I1x9OBk1uMyGBRt1A0ONV7OnguNAsMKsNoO7TZaiRJZjemd11iDoEOAnNH/lre+Kmy4abb6g7pjL8xeAG3OPIcWi3nvhx53plzVhwNovGxaIU5BJfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515231; c=relaxed/simple;
	bh=ihfbrynIE1US6FWZy7JBjMz6YmqZfvj4fXiUsiwmi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMsbZj71IraHi3jSIR8ef98QVmiOn/4iwByzGBX/Fv6tDwgaPhGpM8N1GKhioh5pbjTu50CDSPBCBhPv3If7YYKuJBL5JF14fV8Obq3NWYb1XEF0Mw0YqtRIu3f6U+Zg5ywJ8Zkz39g/SqdR1y2uHN41qf05mh/hBtzvgbTfFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFxHDPOQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421851bcb25so2908144f8f.2
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760515228; x=1761120028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1QNXQzDPagIwTO2xf0eLIjdnCzrADDhywUsVu7wzRA=;
        b=CFxHDPOQM1kngbgnR77W643uf9lDtnMLMBqTSLFlI+mPiWYSF/8ygtLYrpm9CEcjdc
         OOVr8+8EC12lmfWdBGszjfNVdTZuoV+sROPdaasM7lHwpmKWZdo74+Qik+TkVx2jcbgr
         zYmpQzRaABOIx3ONlBQtjFaqEHeGMTI2gYYRaccK/UZfo5l2X6OzO+MHDpwwch6J3U23
         Y+ahXLjTmLens1ZTqZuyhmPCmeAmH8tS9hVYGJjidygWF1i061a9fdobMFKzpSeEWw2Z
         fTxGga8e/cbP1TXVmrtlFH9wzJqnTYE6/+KpTd5yEPqK5CmmbgDU27x+LJ9yrfBSqcZc
         aUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515228; x=1761120028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1QNXQzDPagIwTO2xf0eLIjdnCzrADDhywUsVu7wzRA=;
        b=H71LOGzQis1qUI5tvPhcIgCpmg28kkFID23TV3hFOAKfYQq5u+5gEgNGvfQx2msvSS
         FQrGPh5OmqmW7bwZQ5Y83pdR0Ab6jU0i06LDJ/X8c+qomEjNU/Y7ZXz34UZkgETRXilY
         XWXeqb6YUr323FALZ+cuX12GrORS0J/GLO8MDggFvQYk48wkWbaFDv8yIuDPrMc3DCAz
         QxEspvbCU/ZTHTotQUfbIg88eiqr0Gp7rxGb8MPVV2WT+jUBNp9qtzm5cORgJSngUS5Z
         09wXUO1y7Veo1oQ0KujZMmJuo9GFwBa1vnJKLw6UybFsqHiEbYnvazeLtsgwzedV/0I2
         C6Aw==
X-Gm-Message-State: AOJu0YwDGpQ0r5S3JJ74oYbRJ7wCz6dc+tB6kLSzmJ3HKGxnrMS9C/vR
	nxm+Gvl8WpsrsIcOkkl0NmXcxnW1lkPTlPEnISwmx6MtQHQZlRIThAEV/ygBSA==
X-Gm-Gg: ASbGncuKR1T5F9YuiFtvFq+Cjz/mjUF2Nqe9+4O5uPCK0fhPFcYd9XAM0byAC8C1cYK
	x/GSgQtTV0hMYt7OrNKyLwNWnRfDwAVPV5EPTV4gDcWEYznnIAPMaMUOOuKVNzgAwQ/5o6L35QJ
	/ZmylA+5iSF3a4DsdeB3rvBL4Eck6iOXaFtPN+2+l9e5W3cLYE/NFK/iEp/1XrQdjwDVgibSVxH
	pkSmqadykcgqCG919OslvPOirv+v/E7CM74t4JaJ27ehZWRbjvyzQbLzjZ5PyD3zyZYc9ADTPcc
	9+kddlpVOiChDr5Zp5M+qFADhRGo5JBEivPS9Q75dMc8KRJzaVcHoQjOsPmz811WogP3A2OXfx2
	6f2s20WyIut6RD7dazdCDFbNKbIMBsqSEVN6829I8tnOkXclMj6ScZfjnF0BEwHmaj95W1VAYPJ
	Dmm8KaDr9VrmcGwNGyUEPz2cTFfQ==
X-Google-Smtp-Source: AGHT+IGehKvPmi8O04adi0+evvv1af4DbY7VnWCBjBVoShE/f9P+wxczVAdMGpVn+rb/mfaY2/gCQg==
X-Received: by 2002:a5d:5d85:0:b0:3ee:155e:f61f with SMTP id ffacd0b85a97d-42666ac6188mr14037522f8f.8.1760515228027;
        Wed, 15 Oct 2025 01:00:28 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm27520095f8f.42.2025.10.15.01.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:00:27 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: tejun@kernel.org,
	mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v2 0/2] selftests: cgroup: improve diagnostics for CPU test failures
Date: Wed, 15 Oct 2025 10:00:20 +0200
Message-ID: <20251015080022.14883-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014143151.5790-1-sebastian.chlad@suse.com>
References: <20251014143151.5790-1-sebastian.chlad@suse.com>
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

This is an initial idea to get this sorted by adding a new helper: `values_close_report()`,
which prints detailed diagnostic information when two values differ by more than
a given tolerance.

This makes CI logs much more informative in the event of a close
failure without changing normal test behavior.
If the direction is fine, the next steps will be to extend this verbosity to additional
cgroup selftests for easier CI runs and debugging.

Changes since v1:
- Rename values_close_assert() -> values_close_report()
- Remove braces around single-line fprintf()

Thanks,
SebChlad
Sebastian Chlad (2):
  selftests: cgroup: add values_close_assert helper
  selftests: cgroup: Use values_close_assert in test_cpu

 .../cgroup/lib/include/cgroup_util.h          | 20 +++++++++++++++++++
 tools/testing/selftests/cgroup/test_cpu.c     | 18 ++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.51.0


