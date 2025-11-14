Return-Path: <cgroups+bounces-11967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F753C5ED9E
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E32C34C0F2
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898D343D86;
	Fri, 14 Nov 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BMyrQNof"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24D2D8375
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144511; cv=none; b=Eu8zuaum8QF0kafGM5u1FJnW0CdZOY5vNLThs3FGnNuPp7M2M/SzNzUsXSxESw7l61jqwV+aaOKX7tWuPrTy5matDjPef5+q5pC39UZv2jBZLvXIHpZtuoEFpA6JBG19rsmAQZOxhHeFUxC0Hg5kNIX4qwJbVEyt40Uga5et2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144511; c=relaxed/simple;
	bh=hsqr68Oc9vX8/voUHFbFnAFPuLsn0bL7K2WG4/BGRRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=so4T+7+Sx1mIyIpCybH0/x9kr2ELb1jvwG6Ec1xgZ9vm2VMm2ELfnw8ldIfHPS9zy2jJ0aP2Qz6IuyXcRNABRdFqEAuUd7OG6NB4pPl+cx6ZKcYmDbuakGOwAxrKkggyIuxmpiYQTh6Be2hMZTrEjySuC+l35Rctc4rQl/+JVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BMyrQNof; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477775d3728so23537455e9.2
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 10:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763144507; x=1763749307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtWFceKwF1EAqIZt5xjQ7BMpYVptXpAtK9rrD1k8iuk=;
        b=BMyrQNofdgcx2ZeiF4SmQDMGdPZPc3yfmYV+jPRiSxJSkQW1S8xndh1odPDqhzXKIE
         MDaebUWyYUePVT78WYkbwAyVyXdiBUTdyQ8JcASFYfhpXuWgCGNXI3AbGA8BMu2nhhih
         AlO+znMqhdUx3pGW81IxnNCZt5y5GRCBM1zbb55mWRFV3ne8OfNoEGlh5+TGKiEkarZL
         215ST8PWVEUaeX9g1iVNotiYZ0vm/WKoYGcD45fG8RAW20i5Des1Bh6QgVOLeBGnDj5K
         Xw9iVyoygfV5cfgOR5BjL+m0FpX/PoM5f9wIasBB+CgB5eeOvzNOLF+ZJUG8L+MLL4Gk
         w3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144507; x=1763749307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtWFceKwF1EAqIZt5xjQ7BMpYVptXpAtK9rrD1k8iuk=;
        b=JzxHH6MNYw9zIGAFjhdlIY/M3zRevwX07AkiWK3eVNdd5/ngvRNTSrVpGQZcQp7XXE
         oKVMzCmyD1jzuIM1L/+hkDarD/zbwaZsAmMH9aNMgPEaEfC+o/HBi2FLQFXjGYip4b8r
         bPlRRfi9VspMiyc5Mjo3yZqCQ783R6Z1UCAmhQgBSPMgARDSmFqMRyxNkAbLoo21YjAO
         UXN9DLZjSLJS2k9qIORPhuU1zkUD049WzWdTTXATHkZExBzD682c76Nvpi3Ux35FwfF+
         9SEliTFEkf5fpNA7Li+1XnLo1oGs6l8g7pA/PdJg5wPrSaUtByNesIQCQx7LLMOQfD1Q
         FBwg==
X-Gm-Message-State: AOJu0YwH0hbmgEfinsHPIhMGnlwLauusb9p/G5lMePj/r+T/0RtI4F5d
	Z3BTq/n+ixqY/jgFId5NwamqoBbo7kZBnNqV1W29wxCQw0oaCLdkWh702XO1fmDb0wiyjHzoTFV
	Yfz+s
X-Gm-Gg: ASbGncuiFbnqbT+Dt4YhqgROOu4jUXqgO2KmZ9IO3ctNDHgEGx1q/fRR7cOLBWct0GQ
	4aolyhE2gI/kjB5NMMeMn2jV55vU6pgtnenOJnWJ8vN9UHQ9ZSJ86EvkvWO857IOnbVJCr4Iin5
	1boo3kUDfnOLu7rwiOtghbhwK7uzO9CRlhSTD87raSxrAuPSKR4khUSDFqv598fr9tdDOS70wzk
	aOnV2RGfdYGOirePEEOJvVttHj8TN6NliFairq9WJc7ijVYfpHYujbhRV3eDFQxmnjVPQXh233Z
	hEfM51VK1JRqFU4+GU0C/Tcr9C2S2MnMC1R9NJsMpewlmog6g3C8rare8bCfPTxJGu8wNyq2Dmf
	R14wgT1G5qliTPR0J3em9a2xVlSjrj4ifSiuLD+FY72dFJbZycmkRQEON1UZuouCGpIA5SNsFAu
	TYG4tGSA0NJib2hIhTSvM1
X-Google-Smtp-Source: AGHT+IEcs/T48J7wTe4MWRcUWjdNfsWJ5f6070GgChLsF9nfWT5BV7gXI0SadHc5N88QrXzkYcnJ9g==
X-Received: by 2002:a05:600c:1382:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4778fe9b394mr41688645e9.19.1763144507606;
        Fri, 14 Nov 2025 10:21:47 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm163601805e9.3.2025.11.14.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:21:47 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 0/3] Memory reclaim documentation fixes
Date: Fri, 14 Nov 2025 19:21:24 +0100
Message-ID: <20251114182130.1549832-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I think the reclaim target is a concept that is not just an
implementation detail and hence it should be documented how it applies
to protection configuration (the first patch). Second patch is a "best
practice" bit of information, it may be squashed with the first one. The
last patch just makes docs indefinite until the idea is implemented.

Originally sent in [1], this is rebased and resent since I still think
it'd be good to have the concept somewhere documented. (E.g. for the
guys who are implementing protection for the dmem controller [2] to
arrive at similar behavior.)

[1] https://lore.kernel.org/lkml/20200729140537.13345-1-mkoutny@suse.com/
[2] https://lore.kernel.org/r/20251110-dmemcg-aggressive-protect-v3-5-219ffcfc54e9@gmx.de

v2:
- diagram syntax (Jonathan)

v1 (https://lore.kernel.org/r/20251110193638.623208-1-mkoutny@suse.com/)

Michal Koutný (3):
  docs: cgroup: Explain reclaim protection target
  docs: cgroup: Note about sibling relative reclaim protection
  docs: cgroup: No special handling of unpopulated memcgs

 Documentation/admin-guide/cgroup-v2.rst | 31 ++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)


base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
-- 
2.51.1


