Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5996815321A
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBENok (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:44:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:52246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgBENok (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Feb 2020 08:44:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6317FAF7E;
        Wed,  5 Feb 2020 13:44:38 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] cgroup/pids: Make pids.events notifications affine to pids.max
Date:   Wed,  5 Feb 2020 14:44:23 +0100
Message-Id: <20200205134426.10570-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191128172612.10259-1-mkoutny@suse.com>
References: <20191128172612.10259-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, when pids.max limit is breached in the hierarchy, the event
is counted and reported in the cgroup where the forking task resides. This
isn't hierarchical neither binds event to its limit

Reasons for RFC:

1) Introduction of new event type.

2) Missing one step further would be to distinguish pids.events and
   pids.events.local.

Changes from v1:  https://lkml.kernel.org/r/20191128172612.10259-1-mkoutny@suse.com
- introduce two separate types of events
- make event counting hierarchical

Michal Koutný (3):
  cgroup/pids: Separate semantics of pids.events related to pids.max
  cgroup/pids: Make event counters hierarchical
  selftests: cgroup: Add basic tests for pids controller

 Documentation/admin-guide/cgroup-v1/pids.rst |   3 +-
 Documentation/admin-guide/cgroup-v2.rst      |  14 ++
 kernel/cgroup/pids.c                         |  92 +++++++--
 tools/testing/selftests/cgroup/Makefile      |   8 +-
 tools/testing/selftests/cgroup/test_pids.c   | 188 +++++++++++++++++++
 5 files changed, 288 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c

-- 
2.24.1

