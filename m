Return-Path: <cgroups+bounces-10770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B81BDE06C
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E719C3E94
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2E31D39E;
	Wed, 15 Oct 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZMN2nbr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412A31CA7F
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524457; cv=none; b=QHZUywTSKRdETLIPIfSipDUENB4L2eK7jzQcjkjqviAHy6qumWzB1PlKLnXj0GmJnAMojjCxNPOpQxnrYwh+rFup94tZsd7BAWVJM5vYDIjVMZRp9qiaHGJz8JO84lhNMFwSUbYGASgEVXUGor8ohzygAT0N2t7iMEaRRXd9Mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524457; c=relaxed/simple;
	bh=z+k9pFGcXrpyHNYBhNrCeSXm1h8nOj3orm3Pp/rYV8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1T9C26jNZrZxauvLyg/ABCBmW8pmqOD71DexmM6YB7naUMFN7s1Icc8t+LEZsy4RrRiXatD8uqzGbV0UcopFoqUwZaj4W4qDdDKMzAuHfU0Utw1xciWPAWxK3fcpUluYZMjAubcPkb5zLgse9QMXWcRYcuGx8iewCNekSgrSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZMN2nbr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4256866958bso3645573f8f.1
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524452; x=1761129252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=livyvVpcVOE9Vl+t+E/yZTPdQ/CvYKVygd350VRVh60=;
        b=LZMN2nbrXwdMJkcgJZNtK/gLHIIdzhbHo4alx4VTMOLGKiYwnuTtLvIn4AkAUNDXz0
         U5mjCeT0TsLoLltY4IHsK+ZoRKgJUFroz0EU/IApHy22dm31SQYpT412hyiO9x+ynA7i
         bzgJeZNBoUpljb/nsqSiOCvwRsZju2ZcwjOeVyKnWA3Ixkgpj1OFY5PPQYszz6udezkq
         MqF1Y+rKAON3HRDGgIAnrRQGWVe22qJGbKQujdlkad0fO2Jo+HEcYV+ZsuP8W0GLOtC+
         tRA3DFmCn49PLio140GOCqj+nJJ8d/JUHCK1h6CIo7N3Jbk1HTmxhgich/lrLUVa/N7h
         SYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524452; x=1761129252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=livyvVpcVOE9Vl+t+E/yZTPdQ/CvYKVygd350VRVh60=;
        b=LTE9XvZfuunSX9eIUUbFoKgz9myBl8dVrGMQmT56xLNzEBd33VhMt+6OqzgPWSsm9O
         ZBjxuJXZjkql3M3pC+SvNBCgW7Uuu/2yOYFhMebr6Wbz+D9LWfumTrHmYsfDagC77+Ed
         Tozz8bTgWkLLhKqVhCkSQ8Z7n6LTjdwMAEHTfKCLxfYDkC4jDOrznaYYmIuQcsRX4gLJ
         Bg9jMiCUVYYInL8TZ/so3qjGorwk1T0QGakdrOy97925RKv985j3x/0yhf36SPHDf+gm
         vY4hu2DrWsNXcn0mXBKXiqAfhKO18HofkH/VNw4jZjiftSD+zIzOkNRE4zLmAx/u6I89
         5SWA==
X-Gm-Message-State: AOJu0YwMKVpQZKhOof53KB2sv54iSJ6uNcEhzFzHwD2rqShAT0yRLvqu
	C2rYTi7+cLWmF43PLaAG//Ime6CBZp/1NZA6UkXwaH1h/tpj4CXpn5DLI5khfw==
X-Gm-Gg: ASbGncsYnxFGk9YKCAyqBpsqUNgfMtAw2ShboOFtaovrAobAZ/+aZ4xaDqKSTSnggRE
	glYLuKDCeTRIJtIYGG7eDwnHHl3ykxqBnOm/MJL11mYUX0mYCLD92/MXR1QQpsMqPexGXn+2CX6
	IXg5BSzA9HXvBMKZhqQ3hxFOURxehe71gkvCd/lSGKqMcvPV2F7pgis7859I3zGkxxAP1bg3HBJ
	SIb4R6clGJPsVu49X8Ms9pJfW8jJJ5LqFEPWxsmtFNz1JfVXQk7QnQ0CxDdYrae7/nYMyEiN39l
	+lGPDk2Z2+1xlsbenc4wsfqWsdhNQRXx6sYUhSaRhzF0ax9Z9vKxvNrKRvcDy/KZFJEUvG5ziKE
	ZpR7OHfynfSMeQO5h0jLmZ2BHhV7UgmaLspP/Dk8XEgE7cXuozV/dwgPVU9/hF1Hl/8B9oEeLgx
	Y+O8c6QHuYrlHhq48=
X-Google-Smtp-Source: AGHT+IGU3cOL41cMWrikdlVntCe9lZnkdeIJyC27pZLHft+dtSQuc25d+DkQQZm/NRMbh9kyUSKiAQ==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e39c with SMTP id 5b1f17b1804b1-46fb42ee509mr135556055e9.41.1760524451794;
        Wed, 15 Oct 2025 03:34:11 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be4876sm26032825e9.4.2025.10.15.03.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:34:11 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v3 0/2] selftests: cgroup: improve diagnostics for CPU test failures
Date: Wed, 15 Oct 2025 12:33:55 +0200
Message-ID: <20251015103358.1708-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015080022.14883-1-sebastian.chlad@suse.com>
References: <20251015080022.14883-1-sebastian.chlad@suse.com>
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
Changes since v2:
- sorry, I forgot to amend the git commit messages, so corrected here

Thanks,
SebChlad
Sebastian Chlad (2):
  selftests: cgroup: add values_close_report helper
  selftests: cgroup: Use values_close_report in test_cpu

 .../cgroup/lib/include/cgroup_util.h          | 20 +++++++++++++++++++
 tools/testing/selftests/cgroup/test_cpu.c     | 18 ++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.51.0


