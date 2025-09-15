Return-Path: <cgroups+bounces-10066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D9EB572B9
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B57189612E
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EA2ED15F;
	Mon, 15 Sep 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfJa1qXD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394B2EC567
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924397; cv=none; b=MhWy8Ecp+7P6Nw0METZec161imQKOOhT+gxqmFZ6P0qyBLMFobhv6jgGAQAKwCo8w1FAJZwJLtsfZNfl6OUNYX+hRX66lWXGwJica4J9louU7aNGhvcEVB5Dw71O9iSrHE4nA+ifgmPZys03ta1svPqpm/QfdF4oAgxfq9rJ9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924397; c=relaxed/simple;
	bh=gvyVXDAN+PRAExWv2YFpEC6fbhrhU8H3L0vY5TSVLGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr3uMM4uIujFOHwr6SqM2NXtLQ3C8+PE+nwa6RGF1BpPTnap63cVOcaygae8KiO8EYSayvEgOagXhFIIKeUv5RPzGsVeqNI/jy1oqwwY2W3//mpcP8okty4JH38E4GwWP0vFymkM8LpWxIMVDlKyxFyc180zhDxxZWOYvsY0nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfJa1qXD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so3096041b3a.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924395; x=1758529195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXJupOmkIaxYSorJ/E2Lxs1az8QJSAWePObgIta/6Wc=;
        b=jfJa1qXDjRGCGIFTDFqeAEZLL1pPPSTZo1GOGv0MD2aKDgB+Bu4sQb0xwGT4oslWF8
         5pjuQbpI4taYvvbOPxSxkOeD1AUErGpfDFoi44aDaEf01fPu+fFyBXjdqZKEwMNj0p2Y
         kmVJeGqDOK+r7Mtgvc/SV+Og6qEBxWs+loN7+9nFKIxw3He11E9vrhFDVjXZawnKx8gQ
         3T60zYMhkZX1F/L8kx2YsTyWiG4sUyqBdSN/GQviY9uJ17hT9DFYypdfF5VpeAqXA4sN
         jyxePJ19oI5tvycF8FFS1WkNIJN9TLXDk1+Q0LxRTFK0B7t9DEZZBIt3jK2z22P18Kn0
         dK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924395; x=1758529195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXJupOmkIaxYSorJ/E2Lxs1az8QJSAWePObgIta/6Wc=;
        b=Cdhmd4rdMo8YQ/8RoSEPW51T/Zud4Ubf3N84z87n1q7uFdSW44JUjjvGp0PymQg0c1
         VJn/RPBnUbl+UjP7CwaWoHq+wxadLEZPeTI2PJFxL1Lowa+ERBO0FaOOX8r72Er2v6a7
         SFeoNwRcFbfM2Qmeb54uvA7Pc5PJrD1paioItU/WyccXfbw7RwrinvdW7XQpvn81S9hE
         7PWjdeYduuzKHtqfGrvZJUMUe+BTMFIctDPFSfyWFAocCmfv7Tss+MvKtNOOcVgkMZwJ
         FjTjfPPkQDn7CocJFBoTG29baFUFuQskzV7RagAKjx2NqJyj9w9u6odVOhaNfnpZqfLO
         yPdg==
X-Forwarded-Encrypted: i=1; AJvYcCVL9ru8aQ3cj65n0qwe5cOPcbQIfODwSKsL0MIkxP1Lr8ppiK6EeXl7YHL6oaIM8AoeO1bPBdjC@vger.kernel.org
X-Gm-Message-State: AOJu0YziMpjZx1joWZ818czta/PYRihPerHPNg2yxVbya6vP8xatxtxn
	NnDU7cVEUTT+BRYW6qXuq5m5XHKI6GeQ5sq20ElFMJRb5nxz0zGl0EhH
X-Gm-Gg: ASbGnctqEFi412ezw9x4XWWrESCXIi5H8U1lZMmHd5bKsA4NiImrkbQACrmVR6ktXKy
	M9fUNzEc6w4ELgWOLARPL8ilOsVB8jNSXnA6KU8fIrqDTm9XiyiLE/gV1DEdC6SwXjHJVvHfrbI
	iP+cT4cw9d8hje0nk3xHuFf6KJ/T/AeqrFBz1y7rPx1agvGYgYLUMxXnBR8MnjKMBOOqoqg3849
	T5jqyiiyB1FKQrctGKSaswXIWqJAhpJtADH8rdd6oLKd3O869z+9k4nKeB/6olF6sqJgvSI3jdH
	rwvaVz5y/31VVjf//Z9QCX2+4t206SAY7I6yYrdCHIZ2WI1QolYsxoZP1l+xO68AuU9aKs1+n4y
	INLTkQr5l1zr+TcC0Mz46/GyqFdIbjxQ0J2Iv
X-Google-Smtp-Source: AGHT+IFaPTKZ5L7QGynopLRlymyt3sutrsE9UT7Flmj2NzAt7FTbK7sGSLueOqI3SFAEwnGEtIVHhg==
X-Received: by 2002:a05:6a00:139a:b0:774:2274:a555 with SMTP id d2e1a72fcca58-77612167d2fmr14310264b3a.15.1757924395491;
        Mon, 15 Sep 2025 01:19:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c471dcsm12581782b3a.96.2025.09.15.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BFF114209E9D; Mon, 15 Sep 2025 15:19:48 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v2 0/4] cgroup v2 toctree cleanup
Date: Mon, 15 Sep 2025 15:19:23 +0700
Message-ID: <20250915081942.25077-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=bagasdotme@gmail.com; h=from:subject; bh=gvyVXDAN+PRAExWv2YFpEC6fbhrhU8H3L0vY5TSVLGQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnHT+ftFawoT5Zt8rHS15fm4uvyO2PHpBQjnFv++hiP3 pSwLxwdpSwMYlwMsmKKLJMS+ZpO7zISudC+1hFmDisTyBAGLk4BmEjDd4b/KZ+jZZ235Ztdyb/8 5eBx69kaq3c+MefaYTIno+HLSbGXkYwMO45O5qncVfb4hM2CnGftDy+zfph+89v8m3enrz6QHy2 0nwUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Unlike cgroup v1, cgroup v2 documentation is a rather lengthy single document
(Documentation/admin-guide/cgroup-v2.rst), although is not as long as KVM
API docs (Documentation/virt/kvm/api.rst). As such, it needs a roadmap for
allowing readers to easily navigate it: the toctree.

While plaintext (reST source) readers are delighted with already-existing,
manually-written toctree, readers in html format (including docs.kernel.org
visitors) don't get such luxury. Let's add reST toctree for them.

The first two patches ([1/4] and [2/4]) are section numbers preparation (just
as one would see the book toctree). Actual toctree generation is in [3/4],
and in the service of plaintext readers, also sync the manual toctree in
[4/4].

Enjoy!

Changes since v1 [1]:

  * Drop unrelated cross-reference patch
  * Keep the manual toctree, but fix it up to sync with actual sections
    listing/automatic toctree (Jon)

[1]: https://lore.kernel.org/linux-doc/20250910072334.30688-1-bagasdotme@gmail.com/

Bagas Sanjaya (4):
  Documentation: cgroup-v2: Use dot delimiter in manual toctree section
    numbers
  Documentation: cgroup-v2: Add section numbers
  Documentation: cgroup-v2: Automatically-generate toctree
  Documentation: cgroup-v2: Sync manual toctree

 Documentation/admin-guide/cgroup-v2.rst | 447 ++++++++++++------------
 1 file changed, 227 insertions(+), 220 deletions(-)


base-commit: cf9c2bbba2735831f1200227c7f13404b7d7908e
-- 
An old man doll... just what I always wanted! - Clara


