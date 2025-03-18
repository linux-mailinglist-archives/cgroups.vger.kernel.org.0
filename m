Return-Path: <cgroups+bounces-7121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E1A66D0B
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470CA3B926E
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683C1F866A;
	Tue, 18 Mar 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuXKBEqO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DE1EFFA8;
	Tue, 18 Mar 2025 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284727; cv=none; b=SBSAs7RgcsdJbT93f1CtplMBEMyrwy7tAbJe8bBoCb0OmfxqLsjnv1pulNx+odLTOZUv7N2jKsySPNe6YuPYa6g4gGuLzUXm5eY8xsa0mfhiTXxC/EruJN1mRbeT0h7H/uYPAWoSCkO5l60lRMGApUYy68J0nKrLmVw+Kbq9LZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284727; c=relaxed/simple;
	bh=PCzm1Uv6dvQihuvSi9Y7zt9Fyzb7GOfU0TdWTSqR4CU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JHCKiLXWScbyrfl07WYq6C5sQFwIv7cKoDtkB2ELJuPcYEmUWoUYWDqoKTytnY559ciTFgQRyjNH+LQdQmtjWSytqq9hk7I+4E60iNBGwv/8pLlwd3HFhseYiPs9H8COzKwYeAFGsFKsggvqzeMy70+Z4qLX7Ic+KzLnEc/B9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuXKBEqO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso464165ad.1;
        Tue, 18 Mar 2025 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742284725; x=1742889525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmi/upa2sTtbXf6Q7CoVFmlat4h2nyC9ICZjWOCUZzw=;
        b=BuXKBEqOhKJ5IecUSXuO1d8eZhJpPDJd51dQA1lnvBBFbGQ1mpJyPWc32bXnx8R+b5
         B4OPH3cbj0Z0/56ee3RvDqr9Ai8kVkMYX6NwaHoHhCkD4NKaYUSF76SbzEuYxrvihQ+x
         TxQJcoh79i7RVlM9BIJ4Apnvf7fu4wejSXfwVYekR1ZHSm7TVJwtiSFMKKLcRHbrmVRe
         GlgdYRqKSkw7r1wsnb92hqASpbIc8GQOzWWLhKWv4561vqx9omvAgwch15zOEtLis8xB
         +HdenjTJ/keQ5RqWWjxGWaxnQyNiMaL5HVVzGDX72OpccEzwbf1k4SBjtETCRxnqICgw
         mtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284725; x=1742889525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cmi/upa2sTtbXf6Q7CoVFmlat4h2nyC9ICZjWOCUZzw=;
        b=b/PgR+9FEmMTdq9R2IcC18xwiMuDs/Ha55M3JlbihD5jz+H9o71SFglVceerKuCw5N
         Svnlt9YpMXkrPDWfAKAjN9uDZFJsWqUzP0+nQOqV8kOgHQhE0qh/ngjrfrSCIIz0m5yQ
         EvwVlaqPOU2poMazO5DOvsIAb/6rEF7tfMgarGV9AReqvXzleJyENgwgFxEukAYmDCvN
         CohK9rGXHTcbdUFtx0/t1ts1X9lTIXb7pjPR9+WZKn5nF0CjMcToSU2tCXW6fVRlLT3f
         zc6shPZyPhpKiOKjIRLHt3crSIgCzKD8ikTtZx3+E4D1UsrkCx+xv25mOzEa44AcbREb
         uFgA==
X-Forwarded-Encrypted: i=1; AJvYcCUuGm4KLR73q/Wf5pDD+FkRj9FozVyLUVx6Jc28XP8AgKLfbmt0GjUoXcP5qrKMfA1HMlSAcRZxUlw=@vger.kernel.org, AJvYcCVoWPQ+KMA5iAvyD1EZSagelFfArhqXv42ecPYMO2hhvQ2k2Ad4KL2BQIDYA7LFnIyvZ+4jr3N1Jiy+9RYt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8KYXgveEH9QW9yTNMvVQgsPHkRfohJWtAyP0hErxnvW8UMHi
	i6YvjSittbMPyfELvPAy79UENcA+2VP8xwWu6QojgvKYJK8DhtW7
X-Gm-Gg: ASbGnctt4ZtPg/S0xsyxMWJ833PVHMhVaISDp2HPGvdkZIXVw0PASUAtEP3RUtmwy+b
	kQjXS0U2qqIqu5eiHQ8Jl8B10D1Y/d+qRbmNLM15RP9CkCncHJU/TBHtU+tbrjhIHwa/AGmYuH6
	VLhNC7GD9CDcBZ1JBU9kvx4xu7mDkvPwUnp8agr3KsZQBT58ILaVbGl75BgUbiJqck3Kx45XIMs
	kMoBDCjgkWIloCDYp/J3PHvHnfR2vexTqHXEISsaXDqGxhW20mqUPE8yZ9CL5nPpuXqCMxcGw5R
	6IHheRT5Nb4pkm0DThA2nHD4L17LVVlHoelFtaEIDogYGGDST2QygzxV90O5RZxhqj5FsF7meg=
	=
X-Google-Smtp-Source: AGHT+IFUKsoujjlo/WHI6q9sp0EJXaYl5Lu3bIObvFl6VcEXwX8wPmmirb00eK1bvkP8CYfzr23N/Q==
X-Received: by 2002:a17:903:11cf:b0:223:37ec:63d5 with SMTP id d9443c01a7336-225e0ac37d3mr222554505ad.28.1742284724947;
        Tue, 18 Mar 2025 00:58:44 -0700 (PDT)
Received: from localhost.localdomain ([103.165.80.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfdfesm88149865ad.203.2025.03.18.00.58.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 00:58:44 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH 0/2] Adding Proactive Memory Reclaim Statistics
Date: Tue, 18 Mar 2025 15:58:31 +0800
Message-Id: <20250318075833.90615-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

These two patches are related to proactive memory reclaim.

Patch 1 Split proactive reclaim statistics from direct reclaim counters
and introduces new counters: pgsteal_proactive, pgdemote_proactive,
and pgscan_proactive.

Patch 2 Adds pswpin and pswpout items to the cgroup-v2 documentation.

Hao Jia (2):
  mm: vmscan: Split proactive reclaim statistics from direct reclaim
    statistics
  cgroup, docs: Add pswpin and pswpout items in cgroup v2 doc

 Documentation/admin-guide/cgroup-v2.rst | 15 +++++++++++
 include/linux/mmzone.h                  |  1 +
 include/linux/vm_event_item.h           |  2 ++
 mm/memcontrol.c                         |  7 +++++
 mm/vmscan.c                             | 35 ++++++++++++++-----------
 mm/vmstat.c                             |  3 +++
 6 files changed, 48 insertions(+), 15 deletions(-)

-- 
2.34.1


