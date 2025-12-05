Return-Path: <cgroups+bounces-12265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA0CA5C3E
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 01:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD3233075EC9
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041231F471F;
	Fri,  5 Dec 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDzyQ5J0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD81E9B1A
	for <cgroups@vger.kernel.org>; Fri,  5 Dec 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896327; cv=none; b=EO25CT3nmcP12s5MHjHH5uZpW93O5/s0JCP4AxMVuaI4P1RGzSp0fhldE1BWRGeyqHu7TeifWeND2rYMTvE6rGPzBGfDYBFMDH+KdizUraNx4yFGIM+8rqnhYl51ex0nTb3IWbM+R1HoOdHFYhEtLSKhParpQA9qzUAzZfkErcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896327; c=relaxed/simple;
	bh=CIVMhsmo/TLmEOyl5Xrhk9a4+n50fRfvlX0rCbVLbJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jJQqNeq7sh/MQzWnQhT8gzaEJIPuQR7kOb3HNX5TJTCAi/EIXRLsj9tJmSYedIvLldJ33sYsCd4+eiD9CUoAhb4cfqIyyFfwP0jUEFvYVCexBYD9OKV8jmZkek3mznUD0TN3RVcI5ueQUW0uhwsbDMETHIZJShr3/FfHlXCYO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDzyQ5J0; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4510650af52so2166489b6e.3
        for <cgroups@vger.kernel.org>; Thu, 04 Dec 2025 16:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764896325; x=1765501125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkIFDglYe+NNTa2m54quJMQQhad7qn1qBiLg81dFGHA=;
        b=cDzyQ5J0U4qOPMkcoGx0c1R+qunsQRIyLAeqgBgcR2kk9LLmtoaribCYz9cp3x3XDy
         7EMlB0jLhu9zUb6pwexYrjnBqA+8yccAcRKB4GPUjtiPNGSrdDqwMlwUd7+FZiTqqEn0
         67h/1w2b8b2Nwe5F6Z3SdG44E4whXdJuiVPnTsarKG2TH/3g2LDiC59sWnbjmzPcnQia
         2VKQVi3INO5sWYBfcTRVhTfcRHGCBdXXsBy+e0eUNMsxHm1nfaLrZcopy9tpW4Luk5ah
         hKJk6P6KAAWOY4KwEB0M25/xbDJMGYDVSNFrxTi0njkPEehlN3ClwrY1rG9wFWqi8cNk
         EEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896325; x=1765501125;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkIFDglYe+NNTa2m54quJMQQhad7qn1qBiLg81dFGHA=;
        b=prEr0b6vQFzDCJ+IX+nIxSTrzQ7xv5fRi6kw7iGqgocTyyfBm4zd/BF9ga8wlmiXWq
         gsQFQWxvaWaUTF5B+iXB2B1U8U9O484JOTj+I47VYza8QIQcbsa1b3MYh2M51PKbhZfV
         hhqAikn86gGIFIVkLVvOhCR+fquEZ41wmBp+IRHzDrx8fy7SqAv2jjVnduoifLhVtqiv
         tiTnspi5zkRYM+C9Yw1oNUTs5tP60TfNMZ14RetWbNGRoMVIg133LnE6pAM+woz8U1Oi
         L2PWpVZ3lRhJKPM9B9UmcWObuQ8Khac5NOITK9qiMhr0QRcP1RekYi1HC6Q0/kwAEeEM
         LGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXq8ZuA7T9ZZ82NnIPkoKnZl9uOxVR+UGMYQCLCO8A5LMmzGfmw5oieD3bF7mttbfaUKUa5Fyy@vger.kernel.org
X-Gm-Message-State: AOJu0YydxWzmGidtcHYMirYTqic93MGH94yYgQaodh3sQitSuW1Vmpxq
	DO2e+C/th8N5SSHTtcL41rb7q9OO1xlTE5P2WwL7cg1TU9NxC2wJrrsv1KBtzQD2K70sGTfNeyo
	dmGalSA==
X-Google-Smtp-Source: AGHT+IHj0LPEa/ejQQf0MUYWeJwJfYADQwqU4BCYqxCRyoUpapAb59gw8xQzZvkTJOVDLbICm1TVHGWi4NY=
X-Received: from ioby11.prod.google.com ([2002:a6b:d80b:0:b0:949:806:8e17])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2383:b0:44d:aa8b:58f6
 with SMTP id 5614622812f47-45379d21b91mr2858055b6e.1.1764896324986; Thu, 04
 Dec 2025 16:58:44 -0800 (PST)
Date: Fri,  5 Dec 2025 00:58:28 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205005841.3942668-1-avagin@google.com>
Subject: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series introduces a mechanism to mask hardware capabilities
(AT_HWCAP) reported to user-space processes via the misc cgroup
controller.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster. This patchset allows users to
configure a mask for AT_HWCAP, AT_HWCAP2. This ensures that applications
within a container only detect and use features guaranteed to be
available on all potential target hosts.

The first patch adds the mask interface to the misc cgroup controller,
allowing users to set masks for AT_HWCAP, AT_HWCAP2...

The second patch adds a selftest to verify the functionality of the new
interface, ensuring masks are applied and inherited correctly.

The third patch updates the documentation.

Cc: Kees Cook <kees@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>

Andrei Vagin (3):
  cgroup, binfmt_elf: Add hwcap masks to the misc controller
  selftests/cgroup: Add a test for the misc.mask cgroup interface
  Documentation: cgroup-v2: Document misc.mask interface

 Documentation/admin-guide/cgroup-v2.rst    |  25 ++++
 Documentation/arch/arm64/elf_hwcaps.rst    |  21 ++++
 fs/binfmt_elf.c                            |  24 +++-
 include/linux/misc_cgroup.h                |  25 ++++
 kernel/cgroup/misc.c                       | 126 +++++++++++++++++++++
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/config      |   1 +
 tools/testing/selftests/cgroup/test_misc.c | 114 +++++++++++++++++++
 9 files changed, 335 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_misc.c

