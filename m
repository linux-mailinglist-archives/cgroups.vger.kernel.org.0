Return-Path: <cgroups+bounces-6814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72309A4E45A
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE097A63E4
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3A280A51;
	Tue,  4 Mar 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eHPXFtbJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B4259CBB
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102719; cv=none; b=k7Ljet+XMdF63icnNAoSdL2BlfjZ/HU87H1ve79uO+9wkpktsv71u6DPIH7HRnQ8yQURO+3zQSxB6MxAEK9DBzknP0CEvpAypm5NiieLqVyvkn05HBC3f05wBQaRhqH3yXp9lb562qLiUOcruG+QZ0d+nXlqXV98r6EoP+FiCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102719; c=relaxed/simple;
	bh=gPGd2SMtWSwL0Fk7C9vPkOctSj91rK9tyNIlwMh8Ou0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aU3q/LW0Vc1fsJVRrqsXkzLkxoT+1kQyb0PpahZHjgOn9uP7Bjvn//nXAWNuBQAlLga/oY0gBxBdaN7C6lAvLc8fZb5vOte8WvoEbC/tL/X5uo1iWRVfEOUjn4Lu1zCElBijBU3ALJkZYKEtn2QFHwPoxaAPVdo0GOOuNuZTbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eHPXFtbJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bcc04d4fcso6010235e9.2
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102715; x=1741707515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSd8ve04q9jkY+lejohEQNGWVY2Fdf6RaTdBEC1rDCo=;
        b=eHPXFtbJf4SnTELpuH75eqCKgXaee+YKiH9TzGShhiME20ldLqlbWsU7uRso+ugJ3J
         Fz7mhKBUijOOUtznRhRipy1oxuXm8yQSSKHcSPypT5UNIuaH3PRZnSX25uC8Ikd3e8S3
         +zyN2aY7q12Nv8U5OY95gpF27M8SYiMnpcZYD4zQLodPI+IZtd7tfB3jTh0QSe4tw1kO
         X8tnlbzZ7nWN/feBYSmSJmzOLHpGiBdoqHIUYh5+fNDEvVBA0LSVtlEl8h5Yr3bgPjS3
         KC0inlVHBmgDu9pG65k2HSmKnncML0fAOp5QbiVeI9UarCEOG+ktxcUaDXW3gLsgkT85
         T5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102715; x=1741707515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSd8ve04q9jkY+lejohEQNGWVY2Fdf6RaTdBEC1rDCo=;
        b=GR50871T/GC5D7GIlU3d0NMGKmDGKM7bOL0rxVw88UKs4U823gKGZn81e2ZO1OgBx3
         TU2ZeBFW9p2axBGrZ5asiWAsekMLbHUBAcOmTPT5fO39SRMHjatIy1fJM3CMUj3mLi1B
         dA2VBEd9NsQBA2RqlwbhACnOw7OtuWiHBd+2XnbvnSnf3vqo5jCIQV9VD+WWCM2G0jcZ
         sEXMNkC8AK7/ceF7Ul8ht+jrpTat78ONQ14FhddbZLbaciLiL8IF41AnQ+1nbXemocU9
         c5i1X/aeiR5LY9Ks0R/NBOkwO1E0wUrSSjH08gtjKLHe0+O0jCJKo8ye3MoxJqWPGnZB
         3GPg==
X-Gm-Message-State: AOJu0YybUyM/eFeDdsx+Y0TZ2NpFkepBlyCXJhNJNzA57az3MlC8WN9Q
	EqxeTHaORp2pPH6nDn28tEZ0gWC9Cw8G25GVjx1z0FQYSeAWhRGkFANR1ddh1hJYTDfTc4FhzhC
	STtU=
X-Gm-Gg: ASbGncv/3+zy2yypeFUzE4CXmnSJyQ9rUTT0GQkbG5GjknwqHr3RIjpQI/S70YV+5Uu
	k4R+ahLN28sMWM1DJKbL4pF42xrtmzv1+qegHbcwxfmKyaEk2Lm5e1PHwX7S5EvyzT1c1ZYa13L
	jqI5tqZsOM/cYxGu5WEy1mOTju3FjYGJhrq1Sbdv+lSwJ4WsCE9sj77in3DwPmpijWp6bKLTgIA
	89TjmgBsH9/odO8qMrqQ0xInTHmX/+wGvgyoOsmBvJ/v2IHNsJKWzQzW+otXKBW3PxXY/P2CUmh
	H3gbfZRt+JxI1PlzZ0gC2Rf3LvJ5sEfqgiWhgszOa6gPa1g=
X-Google-Smtp-Source: AGHT+IFCKBTaNh1ji5VjlXmlOoDP8Ygx/PbOCIjfOjueWZr/IzcTQzEGN3dOCOuAsGpaq/YEQ/vJjA==
X-Received: by 2002:a05:600c:4fd1:b0:43b:cad8:ca87 with SMTP id 5b1f17b1804b1-43bcad8cc8dmr26424015e9.1.1741102714833;
        Tue, 04 Mar 2025 07:38:34 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:34 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/9] cgroup v1 deprecation warnings
Date: Tue,  4 Mar 2025 16:37:52 +0100
Message-ID: <20250304153801.597907-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory controller had begun to print warning messages when using some
attributes that do no have a counterpart in its cgroup v2
implementation. This is informative to users who run (unwittingly) on v1
or to distros that run v1 (they can learn about such users or prepare
for disabling v1 configs).

I consider the deprecated files in three categories:
  - RE) replacement exists,
  - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
  - NE) not evaluated (yet).

For RE, I added the replacement into the warning message, DN have only a
plain deprecation message and I marked the commits with NE as RFC.
Also I'd be happy if you would point out some forgotten knobs that'd
deserve similar warnings.
At the end are some cleanup patches I encountered en route.

Michal Koutný (9):
  cgroup/cpuset-v1: Add deprecation warnings to sched_load_balance and
    memory_pressure_enabled
  cgroup/cpuset-v1: Add deprecation warnings to memory_spread_page and
    memory_spread_slab
  cgroup/blkio: Add deprecation warnings to reset_stats
  cgroup: Print warning when /proc/cgroups is read on v2-only system
  RFC cgroup/cpuset-v1: Add deprecation warnings to mem_exclusive and
    mem_hardwall
  RFC cgroup/cpuset-v1: Add deprecation warnings to memory_migrate
  RFC cgroup/cpuset-v1: Add deprecation warnings to
    sched_relax_domain_level
  cgroup: Update file naming comment
  blk-cgroup: Simplify policy files registration

 block/blk-cgroup.c              |  8 ++++++--
 block/blk-ioprio.c              | 23 +++++++----------------
 include/linux/cgroup-defs.h     |  5 ++---
 include/linux/cgroup.h          |  1 +
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       |  7 +++++++
 kernel/cgroup/cgroup.c          |  4 ++--
 kernel/cgroup/cpuset-v1.c       |  8 ++++++++
 8 files changed, 34 insertions(+), 23 deletions(-)


base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
-- 
2.48.1


