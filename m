Return-Path: <cgroups+bounces-10138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1AB58D12
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075F03219BA
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CF279346;
	Tue, 16 Sep 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isoHk3lp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D826E6EA
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998094; cv=none; b=mAF877l/zI2LsWeO5jE+jk5QCRagINkZzD0ZGDqHMmj8My3usjMCS7gOgB0xjvST1pyHMr4Uuj2GCPRSh2TIAPgB64xCf6Uf8ZJJ+BtwZULEudrdksMbkUwIYlXKG6tWRzIdy7kG9jjGgc1doMRBdb4VVM/4aAoI9M8/osT90Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998094; c=relaxed/simple;
	bh=VmO2kvinS3A1vRaM0G0YEMkRq/84D/KeYXH2dYVRBxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARR2Bl//ofqV24Uz4/7+n9U+oRWeLS/qi39hJa9disxLw+COYUNxHlZs01K5BvbaCQ3UDz/3lGCsVqtUXb0HhjA3MydY5x0mJdtDz6uXABdkfQZXASGmbC91Mfgi6iyQqfutH/Bv/3tQc7dyGxogSQutJe1Rd33JmOoHRaKn9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isoHk3lp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54b301d621so3114122a12.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998091; x=1758602891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTEHvDm/IKR4tm1Bmr0HolxO+dzLmKu0Q858we1M/so=;
        b=isoHk3lp/kmFTFnaHeJYBE80r7sNHEqVqjZ+45wb6IrmWrMuz2flgeColLovQOaDuf
         NAUEFM9ecfmQSoQDeE3u58V7ghpBpdv4KxGtxqBh30vKMmepgvfCq+7U9/cFrLVukYUy
         wCdIUGtwK53qcFRptBDC3bX9az7dK/Rm58f0Z7lcEN69v0Aq9ZW1Tla134rQD+4diuKQ
         U1mOcz+P1CMlczkDX+mozr45Fo25Vl1zNXr8PZEeNHO2dwYuEZcfQruKhKuhy7ccFLfp
         wjsvIEAE32onlHyrYQyak2+zcwEanV+eHJlD8AgPCiVP3AOf/bJjYCePLjhBDFEI6CeG
         rMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998091; x=1758602891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTEHvDm/IKR4tm1Bmr0HolxO+dzLmKu0Q858we1M/so=;
        b=ViPUHj5S4n39L8cANDmGvftrUzczIzY2IrUajfoqwVjbX9dWZwz9CZrgDkP53deisj
         oM9pyQXhZpS18NCUsk99PZHya0dVUvltOWMtCrw0V8fz9hHMXHYnsoXFX4+SCEWKoOcr
         zOju6lLDHyBY8ctybHkLCxRG+WOTEPX0PhVXk2LqhPMKFY0sCaERsVSYQXsye6Kky7dV
         V0MlCGY/GHx5VAex5KbZ7kBM0T8dQjgiLyL1ZcCWGK7cHIjP/xm4yuhJMmcWvFO6GT2N
         K2d6wosJQw8BeOU8itqK1mBhzMV0xFgEFOocA+3O99gO29zY3eQUqzy6PIOV8M9UCi9P
         kCxw==
X-Forwarded-Encrypted: i=1; AJvYcCWnqbQFjV/N16ReqoMUCFpuLMNnp3fAml4yx7v8h21tqzFMZw9zKpsniVs6s/ztmvXqvZZX5c1I@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcyz2JnyWI0Apyn40gEmnlLrpDADEVJw+Y0Ng60o/VEh6ArSMK
	rmDikg8iO61owzFe7qDyQrdwfZ996eG3yI3oNTGDwtO1cyFgGVIxau46
X-Gm-Gg: ASbGnct3+b8Wr2JshlWNpX49IAXa6fBNHxQwHip7rmDjUKoujbMeCXFdxYhQEQeW+Wg
	T84+DHXFWPbnDDN58xXFDEACx0jl+ul2CnSkfhm0g8TncUa/o52RrT0S5JbMzal9s+XdXS2u67s
	nJE8ITgEyiSPTgivQZrUI5bZauXqnY1NPjMtCu/J3RtAftMb6P8+VxfArSPfMBHgkhAau36Jm3N
	7RTrEN38JO7TRfUQ9xSxbArz3JXIkCNml+/uYbCY/9tsKvwiariZp2PqQG2dNNG/rkjzB5qhIUO
	E6Nn8QsRGGEJFV5jkI+5Cpplcl4dtrJGjVp+h++EbVVFDopIhMVZYQQ7FS0ceQtobJKS7EjiL6B
	I3amuEA12TMNiMtsQXEToMhELp8kk35LjaOzSuN0=
X-Google-Smtp-Source: AGHT+IEF2ZVvpNxJJFMqOknMo3Fo0PQL8lIHY8yKPy5AwqV+Fi26iyI0GpvDt9oGgKPIwk00E+AHOw==
X-Received: by 2002:a17:902:e790:b0:267:95b2:9c0f with SMTP id d9443c01a7336-26795b29cb0mr59076565ad.28.1757998090662;
        Mon, 15 Sep 2025 21:48:10 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:09 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>
Subject: [PATCH v3 00/14] Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:21 +0800
Message-Id: <20250916044735.2316171-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

[1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
[2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
[3] https://lwn.net/Articles/777036/
[4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/

pengdonglin (14):
  ACPI: APEI: Remove redundant rcu_read_lock/unlock() in spin_lock
  drm/i915/gt: Remove redundant rcu_read_lock/unlock() in spin_lock
  fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
  nfs: Remove redundant rcu_read_lock/unlock() in spin_lock
  s390/pkey: Remove redundant rcu_read_lock/unlock() in spin_lock
  ipc: Remove redundant rcu_read_lock/unlock() in spin_lock
  yama: Remove redundant rcu_read_lock/unlock() in spin_lock
  cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
  cgroup/cpuset: Remove redundant rcu_read_lock/unlock() in spin_lock
  wifi: mac80211: Remove redundant rcu_read_lock/unlock() in spin_lock
  net: ncsi: Remove redundant rcu_read_lock/unlock() in spin_lock
  net: amt: Remove redundant rcu_read_lock/unlock() in spin_lock
  net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
  wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock

 drivers/acpi/apei/ghes.c                        |  2 --
 drivers/gpu/drm/i915/gt/intel_ring_submission.c |  2 --
 drivers/net/amt.c                               |  8 --------
 drivers/net/bonding/bond_3ad.c                  |  2 --
 drivers/net/wireless/ath/ath9k/xmit.c           |  2 --
 drivers/s390/crypto/pkey_base.c                 |  3 ---
 fs/aio.c                                        |  6 ++----
 fs/nfs/callback_proc.c                          |  2 --
 fs/nfs/nfs4state.c                              |  2 --
 fs/nfs/pnfs.c                                   | 12 +-----------
 fs/nfs/pnfs_dev.c                               |  4 ----
 ipc/msg.c                                       |  1 -
 ipc/sem.c                                       |  1 -
 ipc/shm.c                                       |  1 -
 ipc/util.c                                      |  2 --
 kernel/cgroup/cgroup.c                          |  2 --
 kernel/cgroup/cpuset.c                          |  6 ------
 kernel/cgroup/debug.c                           |  4 ----
 net/mac80211/cfg.c                              |  2 --
 net/mac80211/debugfs.c                          |  2 --
 net/mac80211/debugfs_netdev.c                   |  2 --
 net/mac80211/debugfs_sta.c                      |  2 --
 net/mac80211/sta_info.c                         |  2 --
 net/ncsi/ncsi-manage.c                          |  2 --
 security/yama/yama_lsm.c                        |  4 ----
 25 files changed, 3 insertions(+), 75 deletions(-)

-- 
2.34.1


