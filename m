Return-Path: <cgroups+bounces-3321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA376915B4E
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 02:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A0B215A8
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BC411CBD;
	Tue, 25 Jun 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CUq2yEEM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0A101D5
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277171; cv=none; b=Zb9Z2CTJHYctN5VPA9XP3hj9lZxEfa8Yqqr+APqZC8ZHIrbXLJiaFgzadq6aWTlpoa3mUj/wAJWfrREUpaRCV6/Khtme17a9wJRInSqJ1/atw8eZr6BqDhzIjX+nTmqVD9i2xM8Ei4ExAPyZ8SXvhg1x0+TuxgQ6nJDIpc2+LY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277171; c=relaxed/simple;
	bh=rIXFAqjxe0cJSUBpK6xkSnnnzUwKh0rPrvyUChLaLjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvSd5x2ZbmuvWCIAb7XpkD2lfb9xQrU5IE4n3ufi1ScFh/zi4sAhwsVOWF0pX4N7b9nY5Kx+lfUNW4dgwOXohF/tSmpa7VTQrI78eSDZ3egeOvAu9L1gr5JFJfJ7bJid1+DURxULmT7/MhAg2iyw2t3jbvlXZYMkdEeuLY22FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CUq2yEEM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7bUCDVvcPw74a9i1dFIsogz30aPOz1LJXzLxaSUcaf0=;
	b=CUq2yEEMBuNG7r6fXhRo2oS+j4h2y3UGm/AKdRNOpWS6hrotNEUzQAfR4qQRzJZW7s4M3G
	iO7MSsYp63Cpt82yYgqOQMizDapyVacyf6+/19UYOxZvT5PgTKHYAugYnQXbiRCbWaClr+
	zfQ+5mJqYEVHLCuV8hl/TqhjSvn3i74=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: willy@infradead.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 00/14] mm: memcg: separate legacy cgroup v1 code and put under config option
Date: Mon, 24 Jun 2024 17:58:52 -0700
Message-ID: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cgroups v2 have been around for a while and many users have fully adopted them,
so they never use cgroups v1 features and functionality. Yet they have to "pay"
for the cgroup v1 support anyway:
1) the kernel binary contains an unused cgroup v1 code,
2) some code paths have additional checks which are not needed,
3) some common structures like task_struct and mem_cgroup contain unused
   cgroup v1-specific members.

Cgroup v1's memory controller has a number of features that are not supported
by cgroup v2 and their implementation is pretty much self contained.
Most notably, these features are: soft limit reclaim, oom handling in userspace,
complicated event notification system, charge migration. Cgroup v1-specific code
in memcontrol.c is close to 4k lines in size and it's intervened with generic
and cgroup v2-specific code. It's a burden on developers and maintainers.

This patchset aims to solve these problems by:
1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
   mm/memcontrol-v1.h header,
3) introducing the CONFIG_MEMCG_V1 config option, turned off by default,
4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set.

If CONFIG_MEMCG_V1 is not set, cgroup v1 memory controller is still available
for mounting, however no memory-specific control knobs are present.

This patchset is based against mm-unstable tree (b610f75d19a34),
however a version based on mm-stable can be found here:
  https://github.com/rgushchin/linux/tree/memcontrol_v1.1-stable .

v2:
  - minor compilation fix
  - #else/#endif comments fix (Lance Yang)

v1:
  - switched to CONFIG_MEMCG_V1 being off by default based on LSFMMBPF
    discussion [1]
  - switched to memcg1_ prefix (Johannes)
  - many minor fixes
  - dropped patches which put struct memcg members under CONFIG_MEMCG_V1
    (will post as a separate patchset)

rfc:
  https://lwn.net/Articles/973082/

[1]: https://lwn.net/Articles/974575/

MAINTAINERS                |    2 +
include/linux/memcontrol.h |  156 ++++---
init/Kconfig               |    9 +
mm/Makefile                |    2 +
mm/memcontrol-v1.c         | 2933 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mm/memcontrol-v1.h         |  132 ++++++
mm/memcontrol.c            | 4169 +++++++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------------------------
mm/vmscan.c                |   10 +-
8 files changed, 3794 insertions(+), 3619 deletions(-)

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>


Roman Gushchin (14):
  mm: memcg: introduce memcontrol-v1.c
  mm: memcg: move soft limit reclaim code to memcontrol-v1.c
  mm: memcg: rename soft limit reclaim-related functions
  mm: memcg: move charge migration code to memcontrol-v1.c
  mm: memcg: rename charge move-related functions
  mm: memcg: move legacy memcg event code into memcontrol-v1.c
  mm: memcg: rename memcg_check_events()
  mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c
  mm: memcg: rename memcg_oom_recover()
  mm: memcg: move cgroup v1 interface files to memcontrol-v1.c
  mm: memcg: make memcg1_update_tree() static
  mm: memcg: group cgroup v1 memcg related declarations
  mm: memcg: put cgroup v1-related members of task_struct under config
    option
  MAINTAINERS: add mm/memcontrol-v1.c/h to the list of maintained files

 MAINTAINERS                |    2 +
 include/linux/memcontrol.h |  156 +-
 init/Kconfig               |    9 +
 mm/Makefile                |    2 +
 mm/memcontrol-v1.c         | 2933 +++++++++++++++++++++++++
 mm/memcontrol-v1.h         |  132 ++
 mm/memcontrol.c            | 4141 ++++++------------------------------
 mm/vmscan.c                |   10 +-
 8 files changed, 3780 insertions(+), 3605 deletions(-)
 create mode 100644 mm/memcontrol-v1.c
 create mode 100644 mm/memcontrol-v1.h

-- 
2.45.2


