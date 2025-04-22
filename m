Return-Path: <cgroups+bounces-7696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCBA95A7B
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 03:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BF23A5881
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72013C3F6;
	Tue, 22 Apr 2025 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uz26Yi3V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795C74059
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285182; cv=none; b=FeaFFblPn2rfyy3cHrwgA6LoRy/AeSkaX9pJWg2y7aL8RaEI2zl1NCL80B+lLkGaBWpfKAtHZ3ZJReVFij0IVYPc9hhdiY4NqGrV4o158qV3i/svztSTtG0N+0hqu09BMf/Vt/sppuT8OrtEtT9QaOOTVpUjvJU14gxaX7dJeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285182; c=relaxed/simple;
	bh=5B16rGU+2k+wStQl5NGI8RjKMaLbRadkXKi9vkJ/oho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCgsBVA2cETE/yTkOvzE2/mBKgIXeMXiPbIFSv8FvbrSmWcnCZyXtoDeFA4tW1e8XkAtISqTuPB8R9cgH5VmBnddsfLq/DkKuzZO7IvjLkPHyY9zfYfuvp0+dVHQYZraePHmZcE7AaaJNo/S69+08OjVkw/HSn0qcOb1h+Bevdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uz26Yi3V; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47692b9d059so68559191cf.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745285178; x=1745889978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShM+OPRo4tkARwcyIJhuiyqycqSNpimqPcyhrf6R0T8=;
        b=uz26Yi3V8UGsVpLfIRcKlQeM62t2W/URAKwJzgrGIBm/jGqkwOaJBdFBmafqZjrx30
         B3mpsmFF0rZnwW3/QhAkfUQG8QWGbz0n5TClwXfbq+IUbgnPMTldRUDCsrxw/HswJboi
         xJECqFft7B5zsyTm6Uic1RCkKfc+R6TX1bcekr37mzAzO1HnrahEED+JBNrM9l/afqUf
         gzfZ5ksYOherYK4d9OD0HiB2Sarf7teCwi+5pCP3ETkyC92trAAWByN02TH5l1oyusbz
         LR5FlWZOuOElRRuEq5CWGa8aKGvZ/qbQnoRD2/m+nDvIDcRjIbMVVTV25lIJesBPMtm/
         IhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745285178; x=1745889978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShM+OPRo4tkARwcyIJhuiyqycqSNpimqPcyhrf6R0T8=;
        b=e95pVyTGHb+3JQAhw7hIeNg4ejGm4sIcS57d/PlimY7DNvnzz9HsThcGqqXen4zVrp
         prZbChXItcgj3RxlgzrIup9CDR/fb9rQEH1RBI3SMiaXt/3fYq4QvoW4bOXhK2Cmly8k
         w/jF28OKTspgNUYiF4jm44SIzY1VbcECPxy8yg1MlaCXtJqBIsvElb2zMPG3hyE+kj1D
         KozQoG6LloanZFqnhRYoDsiAsh0TpDn8umk01FBV9TWMF6X1vHyAzUHPyI/feeb1WaRI
         RL5LCU++4zwEacWUvXWO71X80wnjAjEuZcxM+LId9Yy9mM03ydcp9PE+y7m52hQCc60m
         FabA==
X-Gm-Message-State: AOJu0Yzm09HAqCIBmedXC3eGDCIBPVTxiFG+gC2+7QnOVJkhvkQMYgKU
	x25Th8HFMTDVb19GCQZ+QM8Kr+35mQHZeXanrLc5Xwzad7fpNPMQcyFfk0ovvLU=
X-Gm-Gg: ASbGncuoK/pfuTtqsG+8oXeXzf7S+MrPkmBGQNiJ4siYv9G9+n9TQblQa4VumWoGVZ3
	XUeZVg7Z2Vo4j4JgDODyZtaIujRe/t8J38IqqJXeV/eGeVa72US3WtWqGa2K5u0HulCWBMI+8Gx
	D6KRvLqfroQy3VTcNLw0i83E4i2p5eiexJosqtCV31fegZEpPXozaLbwI5HLHvt6Ge8c5D/+7ti
	rpQR+nhlvvaDEEBQNs00IxYsLIVjbNgkhKUk4VdSV6mkfogySLz3iFMgoImxqctKcF9h3GDNLVO
	2V2naY/Xq+DBt6sHPrc3DfFUhWuvVj5K8ZZmyapr6soY375XnEhh1yzAsiu4eM09JThjoHpsDiR
	5blpilMwNaDq47CWhoehFrMJXGjKp
X-Google-Smtp-Source: AGHT+IHA09oLgmb2N1FkvGXbNK6Ei2QvTetwNGSUKWYaIIAktisNIJsenYqDkUExZvqsSRrL/Qzp4w==
X-Received: by 2002:a05:6214:248a:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6f2c44e963cmr251526376d6.4.1745285178136;
        Mon, 21 Apr 2025 18:26:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c00d78sm50985746d6.79.2025.04.21.18.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 18:26:17 -0700 (PDT)
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
Subject: [PATCH v4 0/2] vmscan: enforce mems_effective during demotion
Date: Mon, 21 Apr 2025 21:26:13 -0400
Message-ID: <20250422012616.1883287-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
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

v4:
- explicitly expect v1 instead of checking for empty effective_mems.
  this was the case anyway since cpuset and mem_cgroup are in different
  heirarchy in v1.
- update docs to reflect this
- rcu_read_lock instead of taking a global lock.
- cpuset header fixup when compiled out.

Gregory Price (2):
  cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
  vmscan,cgroup: apply mems_effective to reclaim

 .../ABI/testing/sysfs-kernel-mm-numa          | 16 +++++---
 include/linux/cpuset.h                        |  9 +++-
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 30 +++++++++++++-
 mm/memcontrol.c                               |  6 +++
 mm/page_alloc.c                               |  4 +-
 mm/vmscan.c                                   | 41 +++++++++++--------
 7 files changed, 84 insertions(+), 28 deletions(-)

-- 
2.49.0

