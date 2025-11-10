Return-Path: <cgroups+bounces-11758-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5AFC49172
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 20:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0958234287E
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE13176E0;
	Mon, 10 Nov 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2VjVHLy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247873002A0
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803407; cv=none; b=KZNIc6+OwUisC3U0yEzBQLekyC79joWODKIrgykTlVDB0bKg6lIWi1M7qY2V7eBmbyZl1o9/nzN3IEna5EG5gEiKmbg7xSzgoxVcsgsym+QyaSff9aScvehs/Y5WPXVxCEj2FIrCiNJJ8vIeU3U6Ra3Rfkz8tGXrfEPcB4k+6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803407; c=relaxed/simple;
	bh=uOPdRM2zXUbj0uAF4/Y1KdXhAAYdQVcF5zz7omcQwNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIv/u36gthL3ed42kaLMhvj6C08eVpLKsiBHLJxx8EfY/dfRtSGgOeBwpPzkpYRAO0qza95O6mX/jgp9G7abyYGX0dG3jrRwukSFx2QLvNNFeASNHbAtlUZz1bAyqTkdotA1rL4D73qtLx4hI6OPJucj/ygF27bi/AUyKi1b3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2VjVHLy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso17704805e9.2
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762803403; x=1763408203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDpt0zy7PtnsCd6fKg/NI/I37lccoSys25WO0LkUemM=;
        b=H2VjVHLyJvbeTUJmvaX6D1/Mk5MMIzvGOzaQ0YqgDPSWmjLUWywvO7mHfVQVCldqig
         FdYnboyQqE7doRR1hyBJx7CVkbvbgNsg3Xz1/fkOoodMaZhFarOWw3geJOxwLGXTnTKc
         funqi5dWl05SbdIRZ2bWB0GgackLEXXsk8XSH9QPK5PTY5ZXIlOY0v1S2pKYcBi0KZL9
         u4LEJt1P6dfaUAMwXJgZaVwVN4c4jei3eQes4nZ7cX4eV5mPjJ39f7JcXcm0LqCMkwTK
         Nll6ntBK/xDWfEyF7iBtf+rK2TOlIfemg+tIQDboywb39uqAWYHQ1QdTCgE5vtqmRosW
         Axxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803403; x=1763408203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDpt0zy7PtnsCd6fKg/NI/I37lccoSys25WO0LkUemM=;
        b=hmAaC/h1XGncJfJgarAD6MZjJbnGE7yy6+ga1AhhRg33Vby+jyKfmgPM6ya2s/M61N
         mq8zDI2TPYAw3n4CzcNxHZ7mZavk5mvwsqOjhctXhoeY2ehyY7EhY18soOZ1VpasQL0r
         WApdHIJkWROQbRlIv3ZhFkuVLyM5bK3AFuRTzkDVBVnE538qN+czF9s5z4+eogSD6KDs
         3ndqPkb/95Wzdvm0tZhfY4awul7L1bHSMNVS9Kjc+VIVScG/TSEnuBaiibdtUK9hVhgv
         X+cX2+oQIFvDXwL4CoAYAxOUzBkqWGDDEnO1Y7vB5HXVH9Edd2LRzk+pS+bzIst8xZZd
         fyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXFpeL7gani1fmHvJxc396Ex4tPVa/4vF2YiDtug2tKuex+aZ0s8AeI0pt6mebd6BXnQBSNikFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5pVMEOBJ8caeCU3cYTwz9nPPw7XdiHKZ3W+3mljatAaZOlkQ
	9eSXp7otycej5egtspNwdXud7tDdVTaHvC2hfVLJTV3FexL0eF+3zsAvetOX6L9+fbk=
X-Gm-Gg: ASbGncsK1eSkX/GooKQnJSSvov0PS27WhB56tnm3+jpHigZOdnpJ8WCQMQciz4POZ3j
	RrUuHpUPSiRFs/Hb6cGj2M9ysvPRREO/8klGKBsNKZ+6+jyND7iu8yWFwL/MG2vwVqC+ZdKjh/+
	GXEyDuOVyXtcSPnHS7o+3BTzEfZlG328dPpRD0NHsityOsmyQl4GzG3V+mXlauNV23kh3TE9TYW
	OYIHYo73/xudz8jWatljGhYOa8LTDwMbEP6yOwXN/30OC7d3SJqj0vk/W5ZH7OGe1mbhu7ZBGrL
	3EaetequTTuli/6DOvAvSJaPas9KHjz4GjNdC9OiY26lKkMB7HsiWLb1/Rqi1opMKxUcUKZviuj
	kzJraFpCB9DP8T55IKoYZF8Bb06xF12axOhcQWEr06xShTFpdw+Cvx97rkRSPuWQI4GU0aCHi+x
	qxqTIsionWhpeG74oPh8GECLkE11PUbWs=
X-Google-Smtp-Source: AGHT+IHeuLkKSsH8AzcRusY4bSGEmMJr+yCrFo1Kif3KcLfYiwCAAN+hODaeTCLagsz7hdm8X9yqTQ==
X-Received: by 2002:a05:600c:3b01:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-47773288bf9mr97918675e9.31.1762803403412;
        Mon, 10 Nov 2025 11:36:43 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm336766725e9.13.2025.11.10.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:36:43 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND 0/3] Memory reclaim documentation fixes
Date: Mon, 10 Nov 2025 20:36:32 +0100
Message-ID: <20251110193638.623208-1-mkoutny@suse.com>
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

Michal Koutný (3):
  docs: cgroup: Explain reclaim protection target
  docs: cgroup: Note about sibling relative reclaim protection
  docs: cgroup: No special handling of unpopulated memcgs

 Documentation/admin-guide/cgroup-v2.rst | 31 ++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)


base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
-- 
2.51.1


