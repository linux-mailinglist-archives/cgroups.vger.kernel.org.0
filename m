Return-Path: <cgroups+bounces-5457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47179BF906
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 23:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8612821DB
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028420D4EB;
	Wed,  6 Nov 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtG6PMDS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AE20CCD8;
	Wed,  6 Nov 2024 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931278; cv=none; b=qMv9GSkaK4su+DupDc5yijy+NoOpq4NKZWUPWZvRRiwNHtJCpmWkciSDtz+K4fxKkkQkrwTJ+4CculA7uxgh9lhofpatOO3JHqpOOaLnmhRRAAxbU7x44egFh2N3VR0FbUrTmWfPgltrb2tupkItCVIGO5M0wPpdqzE7DPoHDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931278; c=relaxed/simple;
	bh=P53BPmzv/+iV2jsIzuoNRBsbfjzW6iNbRpShn6rDYzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd41EQ6hYVTUEKpec1p6CGM+umnpYORS5b+/vnqr+JilcdUdapPAZ+aYFjzjEoku/BsGmS98z8rzZ1sF3SMq8S18S19vedsHUpnNJqAx58fk9lVM4iUo+gk57syrsaT8QsHKPJmjdkwC2ov4GEchJewIW59Zl2CSGRkR1U1Mpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtG6PMDS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea5b97e31cso3642737b3.1;
        Wed, 06 Nov 2024 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931275; x=1731536075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBT8+7Y8eGQoStNo8j+EOisJsIkNwtvVgBPv7xvh8pg=;
        b=GtG6PMDSg7FbEQeBHcasaIPjXgpYAPDlOti2KpDHAueMAVXgIiR3Dm7Y4uH0Q/zd4V
         k3cUUOGuFmBqyvXmcORcC9He1DzQtaBns178HTH4JyaiJG0Pn1EwRmNyCzUqk38rhScE
         Vu6K9vA7z3bF8jUor2LQFU0E0ynmAquwq2b9N46C1MwgIzBXFMAI8GMafhUymzrCk+gL
         o7dOXdRcJ1roQ8JOkRxYjY6DyXwh0Piyh3wkR85utWI0znt9Qo7rkXWaaRQksMCBF0OP
         nwv3Ygvdo+XXjrCTLmmJ4rnJh9LBoqSVZBugtR0+WQoU99KsyaYpjjZeF23kZjKMzJCp
         o+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931275; x=1731536075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBT8+7Y8eGQoStNo8j+EOisJsIkNwtvVgBPv7xvh8pg=;
        b=pOy9BtHVxHTMR7gJ1M39pk8fx1L3hKnLWmzuwO1V1EBZizpJSurHkSDsPMjU8M4b7o
         wH2Gj374b1ecH8leXiJLmLmf0nwfo/xRPpnvodILQWs2Hrr+ba63vSkzl+Oxld/FJ41h
         wsRAIrXr4wdVHISpgOj/8RPtelHiDmHQI06r5ax4v0KQjSgbGJcXo6ratyogk8850t8T
         KhR6WxIppecxrkFF/Gp3gYmYE1pHolkcx8rdH7DFahlD/rxWY1E/jJpTImA6DQrk0k7Z
         8zP+HTk+A0vIh9BfXsAex2e6hGMM8LJpEwFpXuRgLr6hML7b9X4ZKkCGSJsQW4dqyqKQ
         aSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCURGRWvcikS0UIVlTZoDyZP3DqQrgcRWmaI0kpwh7gFFqPKdMR5PZvKlSsJKBIWR6bmtfzi3z+94m9g2K3I@vger.kernel.org, AJvYcCVit4ci+5n65MISqN1iliC29YKyPYdU4jNByDSfEKcckEyFx2+7Xh+cz+X4eK7ctXCWXn8cx4SP@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLMNjFTKPokmPEdt2OsbRwvYYHvqyQZjHY7Vv4WIBHn51uWEF
	mDLM4a+blXFoUdBWT/AVtaIJx6WBwkzcolP7PT9/FYS0NwtdyQRN
X-Google-Smtp-Source: AGHT+IG53bD5/wh0AdwmE6KJSqgFkcBXwAWMV1DubYdMhPmG6F3ou0Rj2ZzQOQzCphQc3ElRVgS1yg==
X-Received: by 2002:a05:690c:6f8d:b0:6e9:c117:760b with SMTP id 00721157ae682-6eacbfe3381mr9656507b3.5.1730931275235;
        Wed, 06 Nov 2024 14:14:35 -0800 (PST)
Received: from localhost (fwdproxy-frc-112.fbsv.net. [2a03:2880:21ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb09a6fsm206457b3.68.2024.11.06.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:14:34 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/2] memcg/hugetlb: Rework memcg hugetlb charging
Date: Wed,  6 Nov 2024 14:14:32 -0800
Message-ID: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up memcg's hugetlb charging logic by deprecating the
current memcg hugetlb try-charge + {commit, cancel} logic present in
alloc_hugetlb_folio. A single function mem_cgroup_charge_hugetlb takes
its place instead. This makes the code more maintainable by simplifying
the error path, and reduces memcg's footprint in hugetlb logic. 

This patch introduces a few changes in the allocation error path:
(a) Instead of having multiple return paths, we consolidate them into
    a single error path. Failing when memcg's limit is reached no longer
    returns -ENOMEM, but -ENOSPEC like the other errors as well. This
    makes the memory controller error behavior the same as hugeTLB's.
    With this said, no callers handle -ENOMEM separately, so no existing
    behavior is affected by this change.
(b) Previously, the memcg limit is checked before the folio is acquired,
    meaning the hugeTLB folio isn't acquired if the limit is reached.
    This patch performs the charging after the folio is reached, meaning
    if memcg's limit is reached, the acquired folio is freed right away. 

In the first patch, a check for whether memcg accounts hugetlb [1] is
introduced. In the second patch, the charging mechanism is reworked.

This patch builds on earlier work [2] which adds memcg hugeTLB counters.
The request for this rework is also part of the original thread.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
[2] https://lore.kernel.org/all/20241101204402.1885383-1-joshua.hahnjy@gmail.com/

Joshua Hahn (2):
  Introduce memcg_accounts_hugetlb
  Deprecate hugetlb memcg try-commit-cancel charging

 include/linux/memcontrol.h |  5 ++--
 mm/hugetlb.c               | 35 ++++++++++------------------
 mm/memcontrol.c            | 47 +++++++++++++++-----------------------
 3 files changed, 33 insertions(+), 54 deletions(-)


base-commit: 34d664f9c954f4bce85be506bd81024f64dd5fda
-- 
2.43.5


