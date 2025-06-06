Return-Path: <cgroups+bounces-8454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E99AD067E
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AE117B19D
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0227E7CF;
	Fri,  6 Jun 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOncAOwa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1925776;
	Fri,  6 Jun 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226732; cv=none; b=RNy16OPQhg24FTFNM02LfDi6HflQ0T+9AdRgJLSFY6PWB2rVhhAPi6GcOzmWFANk5tG3B6Dr8HpUMF2ST4qhNConbUOZ1DKtqDJZOAhCwK36Nva9myONu/mQ2ck3+e0+4SgT9Qw+y+3ibXNdvW2OdNJxdVJfvMB+dEN591EPRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226732; c=relaxed/simple;
	bh=dWnFfR86+yRV1AqMW+1ZmDq/fHzV4eGNUZ9bqCtwo0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7C8HKXiFVPQ4nvu9bVNbsBcXBM4769xMTBeGMHbjy0oj7W03uGXDAXvhHTDa+ObihCAt/Lkv+jRQlscBzwtyLSnWNc/xVjentPZOWnTkk6b5EcIfg+7JYtxbun6OT0Ati2W886gUQBHLfdzZZt7l26A51BB69IvcEy7QUpUXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOncAOwa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742caef5896so2032843b3a.3;
        Fri, 06 Jun 2025 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226730; x=1749831530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khnZK0HxH+RVmPgUu4L2j9Kp/5clVYx6qzOMk6qDvaI=;
        b=bOncAOwazRTmIzUAIAxu58VNoRBHlmYHrtIwc1ugWcNoNFd32MdOHtrt/aLn/Evvw8
         Ri9dkTC5ZobMrilzNhwBDmvZ4FGRX9M9PzpSPhGogFDexwWXB3kE1g5VRIZtxF/zFc1/
         16I2uaL8NEzbfNZiQOl/iiJRrPlD20Xi8HzIaiPzoFvrX2MOLBKw6Xga2GNYxxAfeCyl
         w42NQ7cGU29Hoxk45w+A1XDyF1Xnxufx/UMiOqBPIkfzaqEfGTRxZh4RlyTG4KtjoBlP
         xeJi3ir8vjpoFd/VYQDDMK40GAlwpy1GDyW4ao5GJ852P3mpDnJYoWISRU/iJ2iEVZ/Q
         QI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226730; x=1749831530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khnZK0HxH+RVmPgUu4L2j9Kp/5clVYx6qzOMk6qDvaI=;
        b=D11jYeaharIC3iN7QgWCG715TyV0iLJ2drZUxJxP/K9Fstoisn+FyL3YtHxTjX7ufD
         hvFdDONmaWVrzLwhs+YkCw5406SVfRCOSLby9n0FrkmzNixPEc7qarLJAHkpBRW/YgAT
         +CBJ40OMeEeLDKc4MqZcMWPfV7cTCC9iFN5aLOygSAhmqJD5RdlGPTvUC4A7225mAdmZ
         Nh9Y+Tn5EoOrNKKOr94B3ZnN/yEEtCXqOcwKGpUvT399OhV2N7Om2RpjsVYWWz5129KB
         k5ktcArvd5vGw77S0R4D6kj/LpxCiNj/9vgiNc+m2VgOIKFUFYFtsGwt5C7fMSDo9LkV
         FJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4XP3CuY+BIEoJsIpiV287+HyN5zyQBpjpdZ8j12JrE5qGsan9wdl7VyH+aCWpm8Kd5mycqBqG@vger.kernel.org, AJvYcCWmv77Irmw/3Al5JewN7UlsUVG59nlnTw84TO/VzHj0yDQU/WSiMu19NvlnytINasVnP/0b1pvDQQ+uJs9T@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+59qcTsbakGZUxXjIVwVuvYjzB+5z+sBSJXRuNynvN7Y/rVo
	tieW+LvDY08tQf0bvzJDNEQmDZ8nJ0V7gISw792d2h2fDU6MC249kXfR
X-Gm-Gg: ASbGncsxZRFv0NPgHNOPKYlZU+GRYim9Hy3LhOkq8h8EcVbARy6ejJar9ZLpFQpLapt
	Jkb49arShKksMc2VKK28DwbvUpJQZmSDMV80oZr8glj8b8nv7iCYyVS2ZRZ1m0ez5KLnyx5zHsH
	W3h9E4IxOt21N6B2lGxxrK/VrCQcz9z9ocZoYC76rdRA/eYI5fAXegm0FPy4XKIVQj7rQE8Mmgh
	OycuyYe6HaWiM443eXV8vhkQgMA+AkvPU5caPFunaH4oSwujvEO3K8xpq9vmU1yXeNiK3w6OjDw
	A9TOfW6bbkxi8nuYOVbdiRgpZabDvJdOCyD+A6w8q+1j4h6OkfZ05LSsqSN1Pw==
X-Google-Smtp-Source: AGHT+IHg3rn/J5WiRw4n46BOfiR1gQXAzMgYDco05ru6GjD/i//8yDpuC7tIQ7TeWHWyfqVEqAso9g==
X-Received: by 2002:a05:6a00:3c88:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-74827fd5f47mr5154507b3a.10.1749226730178;
        Fri, 06 Jun 2025 09:18:50 -0700 (PDT)
Received: from jemmy.. ([180.172.46.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38353sm1518675b3a.10.2025.06.06.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:18:49 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] cgroup: Add lock guard support
Date: Sat,  7 Jun 2025 00:18:38 +0800
Message-ID: <20250606161841.44354-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 changes:
- remove guard support for BPF
- split patch into parts

v0 link:
https://lore.kernel.org/all/20250605211053.19200-1-jemmywong512@gmail.com/

Jemmy Wong (3):
  cgroup: add lock guard support for cgroup_muetx
  cgroup: add lock guard support for css_set_lock and rcu
  cgroup: add lock guard support for others

 include/linux/cgroup.h          |   7 +
 kernel/cgroup/cgroup-internal.h |   8 +-
 kernel/cgroup/cgroup-v1.c       |  56 ++-
 kernel/cgroup/cgroup.c          | 720 +++++++++++++++-----------------
 kernel/cgroup/cpuset-v1.c       |  16 +-
 kernel/cgroup/debug.c           | 185 ++++----
 kernel/cgroup/freezer.c         |  28 +-
 kernel/cgroup/namespace.c       |   8 +-
 8 files changed, 483 insertions(+), 545 deletions(-)

-- 
2.43.0


