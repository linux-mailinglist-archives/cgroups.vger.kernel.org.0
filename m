Return-Path: <cgroups+bounces-3271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEE9131D3
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 05:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795EE1F23169
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82D8F5D;
	Sat, 22 Jun 2024 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWVGITms"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03409818
	for <cgroups@vger.kernel.org>; Sat, 22 Jun 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028724; cv=none; b=DBCKNqoe22C6baUdEevrqWakrjrDns9LKa1OlnZ2AL2jnu/5JXo1lQqT5BWtHuzWNH2gJWNEBMRw3EYYay+3CgpBdv+gqQzD8iVhZaVURQbFcyhG9rUPy4z+tYgj4ef6Jd5ChNmav545+xNqgIHkmnWYF9O8oEI7laYSesacf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028724; c=relaxed/simple;
	bh=oCuES5UOotTTeEWk7uHGX6oUQKdCAgtCD8Xmw9EevTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHAjf//uA6Uro+Shg6GEiPF9CEQvJG/dwne0xPtOAz08FR82hm0ylg/wR9f4qzcLPsVJX6I+MXOGnpK+7uFRvY7sm1XKg/h9Twaan0P53JH1qq9ap5qVN6c7GITGILuyUAHyYU1jGHRNtnDehbbD+BsCojpkT3Kb9MRsh/3zqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWVGITms; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=glHWFwF1PVhz6SvXAFFwFqrh96wIoW6X2gSfzajSRBE=;
	b=DWVGITmsk7MW/q9N2k9yoiArEcH0H0ikeKIy5VE8xv/UDsKizbvrJaWjqFTKn+gSsnjGKg
	yfoqGKNkELh5Jt5I3kkg7BTZpTRxKTixJ5uVje7rl2LQf/ufZiG9qeAzaoLVaqGYhhQMRf
	DLabDvyqN3Q4n6y0x0cWoQ29vchb85E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-xBm2cJqHP2OUPOaOcWtRNQ-1; Fri, 21 Jun 2024 23:58:40 -0400
X-MC-Unique: xBm2cJqHP2OUPOaOcWtRNQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f9a3831aa9so24151465ad.0
        for <cgroups@vger.kernel.org>; Fri, 21 Jun 2024 20:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028719; x=1719633519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glHWFwF1PVhz6SvXAFFwFqrh96wIoW6X2gSfzajSRBE=;
        b=T3GjJ+ERyt6onzSi0qYDEtF2eoGXNDt1pv4eqk16BV679KrNmRvqTjN78i9hdHTUr2
         WcJf60eDp/tg2LU2FBkx/8olXkH8lzYnfm4xwO3UF1ob8jrISkuodrNUJYYW1HD8BKOb
         I2ItnDwOl/eLqvqqpCFFh1Sb3J/IZlPqcQBdlhyXPgLtBChlzDJ2wThcgrOKLNUroXUm
         0za4pCx/pLLCl9m927CWYKOsQe1FT43BEMUxNF7Xmjj3Uj7Z5htPwAPPZ8zmqPEebhUA
         AUai7PfLW/Fj6Qd22ch8PUm29Y4+yTAjprcaLaXzPCKY67/S3gDNBD19V2fZJvX+Krv+
         HPEw==
X-Forwarded-Encrypted: i=1; AJvYcCUctE9XgeTJQGb3Cg4+LpCEQzyeuHoqumrNKIsIPfO8O8s/hMSBfzBIeJtXnY91DXEUpc0hW7M++FEcUxzCETOq9qQv3eG3Pg==
X-Gm-Message-State: AOJu0YwIMoVmDNCm4GdzYpb3OPiExg1Lf32CSdtgAtD4wESCNEZhFMdy
	Z1DknBg6awph6dYPdsAXnzjajTJ6ezKdoMCKFs0xQ6ED4z/b7WanV9QCEQNDzRix//CNIjZ81QZ
	M0yOzKhwppkv6sboAFKZ3LyrDpo8bchLEJJ2A/YdMn7RXhi5YB3642V0=
X-Received: by 2002:a17:902:d4c3:b0:1f7:3163:831d with SMTP id d9443c01a7336-1f9aa396e3dmr125385695ad.14.1719028719317;
        Fri, 21 Jun 2024 20:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn6jq5za2vXIACul9YEe/UzkN4xzhEvsBbIbTzW3YiVVEm98izqyGGRygyQeD38+tfCNqDdw==
X-Received: by 2002:a17:902:d4c3:b0:1f7:3163:831d with SMTP id d9443c01a7336-1f9aa396e3dmr125385545ad.14.1719028718901;
        Fri, 21 Jun 2024 20:58:38 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:58:38 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Sat, 22 Jun 2024 00:58:08 -0300
Message-ID: <20240622035815.569665-1-leobras@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem:
Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem: getting
an important workload scheduled out to deal with remote requests is
sure to introduce unexpected deadline misses.

The idea:
Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
In this case, instead of scheduling work on a remote cpu, it should
be safe to grab that remote cpu's per-cpu spinlock and run the required
work locally. Tha major cost, which is un/locking in every local function,
already happens in PREEMPT_RT.

Also, there is no need to worry about extra cache bouncing:
The cacheline invalidation already happens due to schedule_work_on().

This will avoid schedule_work_on(), and thus avoid scheduling-out an 
RT workload. 

For patches 2, 3 & 4, I noticed just grabing the lock and executing
the function locally is much faster than just scheduling it on a
remote cpu.

Proposed solution:
A new interface called Queue PerCPU Work (QPW), which should replace
Work Queue in the above mentioned use case. 

If PREEMPT_RT=n, this interfaces just wraps the current 
local_locks + WorkQueue behavior, so no expected change in runtime.

If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
per-cpu structure and perform work on it locally. This is possible
because on functions that can be used for performing remote work on
remote per-cpu structures, the local_lock (which is already
a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
is able to get the per_cpu spinlock() for the cpu passed as parameter.

Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
current local_lock + WorkQueue interface by the QPW interface in
swap, memcontrol & slub interface.

Please let me know what you think on that, and please suggest
improvements.

Thanks a lot!
Leo

Leonardo Bras (4):
  Introducing qpw_lock() and per-cpu queue & flush work
  swap: apply new queue_percpu_work_on() interface
  memcontrol: apply new queue_percpu_work_on() interface
  slub: apply new queue_percpu_work_on() interface

 include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c     | 20 ++++++-----
 mm/slub.c           | 26 ++++++++------
 mm/swap.c           | 26 +++++++-------
 4 files changed, 127 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/qpw.h


base-commit: 50736169ecc8387247fe6a00932852ce7b057083
-- 
2.45.2


