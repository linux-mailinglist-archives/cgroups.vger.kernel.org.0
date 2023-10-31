Return-Path: <cgroups+bounces-133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D837DC3D1
	for <lists+cgroups@lfdr.de>; Tue, 31 Oct 2023 02:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6096FB20D4B
	for <lists+cgroups@lfdr.de>; Tue, 31 Oct 2023 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B427F4;
	Tue, 31 Oct 2023 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBywXDG2"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7736D
	for <cgroups@vger.kernel.org>; Tue, 31 Oct 2023 01:15:54 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284DD3;
	Mon, 30 Oct 2023 18:15:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc29f39e7aso19945205ad.0;
        Mon, 30 Oct 2023 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698714953; x=1699319753; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Msq/IlXvOEPMAU3g3lkN4kARG/rMIaVSEW8uzl6dLrE=;
        b=ZBywXDG2g42umOqd8kyC34r1VGQwpMcprjuOXaB8yD1iLGdM6Qk9FoZ5b73A3NdzcB
         2cx9nF0OxLZps9SiL8cnC1QRLC6LLrM2LEvTLZQXGVmM25fB4WfS8Tb965dRvi8cyBF7
         CDFaq0OzW0xLIXAg/KLX7rupdv9wHGuWzCpc7fefsutfG4HVTf2ivaWvdzM0Y3joABV2
         uds/0gVTcDMOwJUr5bZgP8A7IdZUdtnPpb3ubXo2htwwqvHlTN/Iya1Of2eLIwkw7OdT
         k64QVIxkHq5qHEkquJSs6lYkuvwAHGvCDhDu+nRf+3g1ztfZHhK3zlU2KKTCqpdUVtOR
         7dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698714953; x=1699319753;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Msq/IlXvOEPMAU3g3lkN4kARG/rMIaVSEW8uzl6dLrE=;
        b=TUC0WSh2nyI8jtQpHqLyEswx29zyYRf3F/kTvDcWdc37oy0nqCrdTusgtaYyzuun8N
         gGe45Ky0lcYXfCq/MIzeh43TrUR9nYnczyQNFlDn8oQZPbuZy/4v8MeSFY957s5ubouk
         oRIdBUXbiz0fTbfw/ONy8yK0skaX34Gubr3mSWVS5syovW1rEhb1pmsAMnnbGJmBVlpd
         Ja7yfj42zQI08JPf1E/5TXiMokPRFg9IblkaZh4vQXnfok97bK/JFsi3Z7twla29JHLP
         2yRN/c7sE6iX9ucgVpLgmFljVrlRS8m2LZjODGVMEeiHwnUnlaIfS5FkNGYXgU8rtQy9
         NScw==
X-Gm-Message-State: AOJu0YyYvjUjgN5SbD1pa4aEIDdi8PS6emRrjKLmzFdFn0zqoSWHEONp
	7Jh8Hl1AQ3c+ZuZURvYCowkZ755obpnkWA==
X-Google-Smtp-Source: AGHT+IEd6qYSaWSCxVZQH9CWgTSuikrWFlFkp2YfLwqZT/OlfztbUgt/qDuD56N0xNkSXwZ7qnUOzA==
X-Received: by 2002:a17:902:e84b:b0:1cc:4559:ea with SMTP id t11-20020a170902e84b00b001cc455900eamr3658959plg.3.1698714952489;
        Mon, 30 Oct 2023 18:15:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:10c7])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b001c73f3a9b88sm123627plg.110.2023.10.30.18.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 18:15:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 30 Oct 2023 15:15:50 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v6.7
Message-ID: <ZUBVRmaimsnGY09k@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7

for you to fetch changes up to a41796b5537dd90eed0e8a6341dec97f4507f5ed:

  docs/cgroup: Add the list of threaded controllers to cgroup-v2.rst (2023-10-17 22:45:44 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.7

* cpuset now supports remote partitions where CPUs can be reserved for
  exclusive use down the tree without requiring all the intermediate nodes
  to be partitions. This makes it easier to use partitions without modifying
  existing cgroup hierarchy.

* cpuset partition configuration behavior improvement.

* cgroup_favordynmods= boot param added to allow setting the flag on boot on
  cgroup1.

* Misc code and doc updates.

----------------------------------------------------------------
Harshit Mogalapalli (1):
      cgroup/cpuset: Cleanup signedness issue in cpu_exclusive_check()

Kamalesh Babulal (3):
      cgroup: Check for ret during cgroup1_base_files cft addition
      cgroup: Avoid extra dereference in css_populate_dir()
      cgroup: use legacy_name for cgroup v1 disable info

Luiz Capitulino (1):
      cgroup: add cgroup_favordynmods= command-line option

Waiman Long (9):
      cgroup/cpuset: Fix load balance state in update_partition_sd_lb()
      cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2
      cgroup/cpuset: Add cpuset.cpus.exclusive for v2
      cgroup/cpuset: Introduce remote partition
      cgroup/cpuset: Check partition conflict with housekeeping setup
      cgroup/cpuset: Documentation update for partition
      cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition
      cgroup/cpuset: Enable invalid to valid local partition transition
      docs/cgroup: Add the list of threaded controllers to cgroup-v2.rst

 Documentation/admin-guide/cgroup-v2.rst           |  130 +-
 Documentation/admin-guide/kernel-parameters.txt   |    4 +
 kernel/cgroup/cgroup.c                            |   30 +-
 kernel/cgroup/cpuset.c                            | 1306 ++++++++++++++++-----
 tools/testing/selftests/cgroup/test_cpuset_prs.sh |  467 +++++---
 5 files changed, 1428 insertions(+), 509 deletions(-)

-- 
tejun

