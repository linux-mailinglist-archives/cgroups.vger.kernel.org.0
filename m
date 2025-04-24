Return-Path: <cgroups+bounces-7806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC3A9B908
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2C55A6387
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430F1FF1B5;
	Thu, 24 Apr 2025 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IUkdzdvD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D81AF0B7
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526134; cv=none; b=abp10uIIh+1fUmMjgBXifPepaCmzmnP9g9hIZcCOQy69AH5Ubpx7byVC9TqbIxjtCM1gr+qJSSbo3aKqqskBC6c5rc0lyHu700sCMJDD4MLF45A6EXMVNHZ9/MkwOsr3hAXS8eoc58yMo6wf0dWgVC0iVyMoENFq7i7vHjci4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526134; c=relaxed/simple;
	bh=JVRxd1bxv/rdSKNVHJhscYrIL7rIp+ssi2F0tDL80/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO+m2fURrMuKSbMz7dqzauutOyWhWcevenpmlLTf9+DAn9AQjfmxqROXyr/linpa2MbnhL+ovrlOWJippZnP0imiwLFC3qWOGXoT1swwU3LlZj8+3aT1ITfBiUeGrt2NPIfwYf5nQF6pBtsbdJJVt56a5eE7uiOT12Lj9yUnZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IUkdzdvD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6eeb7589db4so21049306d6.1
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745526131; x=1746130931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MqqLjEz3abz2XbBlgSzVqyzhHUlBkBot7mBAspwG3c=;
        b=IUkdzdvDfJq8isfvP6W+sMrXNYQEqmtXobzwuI9CFl5JxYvrPfldR+FnZCXqdgSiog
         1M90krYDirC4o0oQUWb7rHY4hREtHb3/VznAZoyYk0kJJbeXJOjg0m0B1ISTx3z++a49
         pupeJjvjwosW2liWJNqVbAkpMC8EAjqWyLQodNbXdSzrKGe8eFQmjpaIQz8zswt5YCJE
         SzZBoEyhHLlS0HUPTs9IfAwsTnM7N0lcghdLMWkOIWkcYcLdjiilgWfKNOJbg0RtVKh5
         4qnxMzgBPdzoBGApdC4C6BcXJQhWT1DsiLADlM1h1p5oMvomG2S933rvrHJv0jT3VCkZ
         +K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526131; x=1746130931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MqqLjEz3abz2XbBlgSzVqyzhHUlBkBot7mBAspwG3c=;
        b=qj4tB7D5UBZvmIcBGPgC3TsPv7tiu6gPmbXzy30vBx8+qJYs98+MHiywja/UN2x0cW
         UAOg4Xf1cX5ffojIYpBZpPqWFozyxSTx+hAjHcfz/p7aMv7FhwKe4CtLna9oH+/Yq1QQ
         KwF7uQKxq09VESJEJhhIcc8mvWP0bKAIkgqDmiqcm2m4Q8BeFlsRsARU9rT0h8JFsuNJ
         OgseoIHuvV2bUfY9mcd6ao/qUB3wj2FPBKbZg87B6Z0ohNTqa3lbEpfQPP2p+bQaC7Yp
         SNZYHmVvINgTC9My4wvdS2ow01mvUwkwuinEwiwvbCc/uKyUutETx4FH0fXA77J5lfNK
         iBew==
X-Gm-Message-State: AOJu0YwwFUs2n/5B0LiPRZ92o63yx3C+2bPIrvMhkoRqmtEkjax/cCZY
	S6GMOQeV2RBcv8hlXN99fMYt41u5nmnbs8uU+JlU3sLyIWMAk2r/60L3DQVynyg=
X-Gm-Gg: ASbGncvwB0G5CYXljMBom7ro3Kuf7dmD42C831ZfqzE5HFEtPoSixNeroeof8ZcpgYb
	WkhfPBX16Q5+WWJ0+OIZ0lHWTNtQze+V9TfBN3JV1kJd4FZSsp+lo7BiAUxuRkL8pBq5u/mx1qK
	jK0zaktx1KXMBtGjoXsH07KxPsiMcSKy5DpFCJQGqw9oQU54bHgx5xQan1Mj0DVOhzwJYZ5lY0Z
	4LQ7RX+w3KpsZiQt1qFTBi1ERSSePHGZjd+ED2hDeo/gGKRwoyo0wCrFAQzOPOfbPRVxTC10wx+
	h690Brfpo6zfRfIvrT8u3Y62tM7NtW74nEdnhpTfkBW1+4hjTdGR8BTlhw4+yvMwkulAYrhxt7O
	EV6afoc+1R6fEBxJLeu46SWIwoCZc
X-Google-Smtp-Source: AGHT+IHzJydVHqLkJW/S73lsyHzdB/5PBag7H57VQIk8FgTn0eiWJ6yg6tmqovHihAgl2dwEGADSww==
X-Received: by 2002:a05:6214:500e:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6f4c9530770mr13650426d6.26.1745526131437;
        Thu, 24 Apr 2025 13:22:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbfb1bsm129618385a.44.2025.04.24.13.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:22:11 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: [PATCH v5 0/2] vmscan: enforce mems_effective during demotion
Date: Thu, 24 Apr 2025 16:22:05 -0400
Message-ID: <20250424202207.50028-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422012616.1883287-3-gourry@gourry.net>
References: <20250422012616.1883287-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change reclaim to respect cpuset.mems_effective during demotion when
possible. Presently, reclaim explicitly ignores cpuset.mems_effective
when demoting, which may cause the cpuset settings to violated.

Implement cpuset_node_allowed() to check the cpuset.mems_effective
associated wih the mem_cgroup of the lruvec being scanned. This only
applies to cgroup/cpuset v2, as cpuset exists in a different hierarchy
than mem_cgroup in v1.

This requires renaming the existing cpuset_node_allowed() to be
cpuset_current_now_allowed() - which is more descriptive anyway - to
implement the new cpuset_node_allowed() which takes a target cgroup.

v5:
- squash drop rcu_read_lock fixlet into second patch,
- changelog fixups

Gregory Price (2):
  cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
  vmscan,cgroup: apply mems_effective to reclaim

 .../ABI/testing/sysfs-kernel-mm-numa          | 16 +++++---
 include/linux/cpuset.h                        |  9 +++-
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 40 +++++++++++++++++-
 mm/memcontrol.c                               |  6 +++
 mm/page_alloc.c                               |  4 +-
 mm/vmscan.c                                   | 41 +++++++++++--------
 7 files changed, 94 insertions(+), 28 deletions(-)

-- 
2.49.0

