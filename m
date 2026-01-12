Return-Path: <cgroups+bounces-13083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65AD13E51
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 17:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235353029BAA
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539933644A4;
	Mon, 12 Jan 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwKH/gTl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2B3624C7
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234105; cv=none; b=tVF1oB5o8Ft8yEpD+AmIfuW1H87BTTc+CB+fVjO0DgOrfB4tMdSRvMp+ohw2+cNacv7Ud4INvVeLRkVTL68GpD5x1vGGySRNM8ceO3fg4cx/JqaS/O7NhVpa1r1ObKN33Rn5A6ANYBiflXYNuSYfBdoksOdMr86Hd0+YR0VRKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234105; c=relaxed/simple;
	bh=0XtRZk5NkOQKKYgmfKhfMF8RiEokBH47z05TiDmKqEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxT9kM6no+J3uc0gnR6FYxt+Ww+8GVzoPHPyYRm8oTMwZ8c5Ja40BC0OLfOXVE5GyU7Q4bXqh4qFlfkRTXS9nz86Xc/TgfLThDOdIgaT5MB4T3PA3Ck7m/FRlRA8GUsQKc2hdD6KT3iM1ZfevF/qb2IiocZOxqDUYaygzVsy4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwKH/gTl; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so9495840a12.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 08:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768234102; x=1768838902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhL4JNvGH/Ad37oTzLQ5PqwjNlackbvAhbcxlZaqeQI=;
        b=IwKH/gTl43L2JhEXOm3E3D0uM9AtX5qcoyMjdMfmorF2gJB0/Bw7bAoPYEaFYmMYap
         ++dEgHgT6jrvolHEnVrVChb1W4c8t/bf3108VxJMCzO6FeOTVymaX+5PSft+YAlaD+iX
         VtwTU9tlBLYBkjHakbvyAE6Gf/sD3ixzsCbtZoOkZ17nDQWu6tWqzp4WudOmWdGGUUB/
         oJVUX9uvnOUchWvv4cHnCEG+v5z8GoprFzeKWKATDaPfSZgqZA0yD57ePezm/VK25P92
         qWPEhlmmPkmLYherCLetDYVFqtx7ooGylmzxxiXO1ykjWbABhKUMgdfiU4YVCEDUcA84
         XRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234102; x=1768838902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhL4JNvGH/Ad37oTzLQ5PqwjNlackbvAhbcxlZaqeQI=;
        b=dFqX1zt3BoY8adnEZfdwYvfaHNvrV1j84ZdFVZMek0SOrzcTp82xBo7ieimStIKHsy
         enF6Gj956hPZwRq3G/Ht9ZCyWrp2XUBla4nOtXbJ6OmQRjkkYiYS9YlGD6FOISSXpTr3
         u8Tb8KQh4QCwoHRtQxYCYo1qDu75KWpN2/eP0muW82ivP4Gccf2y77Hclm2BJL2QZDwa
         hB+qrla2vIMDXeEWAOIkfmkFfzDN2azKelnE82Lya7XeBdFwkFFvIGyCwPrfSZaVg/wM
         Wae8lAkDV9kenY5e2TxYJuv5xveT7lBxR4I8Kvwb2EwdyGOEy493xX+6GxzYg5AXEq5H
         v+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTvpRZt5ILAvG+yM2TdeVo/PJXs2G/TnUzednchTdBcIhx+4Vqpg3KawRTcfPj2B+kTHO3CVCu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVysMQk8nucI1CcWuZyMX0Y9QK9NfFxvAnG8yBfGxSqSUPsuZ
	qdw7NToETjEPZdgGl5OLdw48AC5ZfSXPqefWnTeiPQTH8Yx1CXQebMSD
X-Gm-Gg: AY/fxX5V4SaEdE/nCVX+q9Vw8OnaWfQj2NXxYujeMN1LkYtCxd6GfpmqeKTgbKo028N
	lxSIFn2N8phJo4OaqGg8/bGlx7U7AzJU4FDDSf6G6+jnIu7hat95cokQ/SrNGf344j5jubuKg9s
	fS5qTrRMvv8wmk6DjeYskKK5Hcz6pmu4ZNBL6HpmsrJEbrYj1sR5mOBZfsaAWsjZ3aKQeAAD+Ha
	O+V2vyqIgzHw7ot5C2TD2bEA9Q9S8esZUuHxa7FE6aiQq0+AH0lC4YCHfdn/DAKwkgtOQN2n7+S
	kgEANA/fzxq1UMzCsryiSfR52i8x32FhDoWOfbJifgk0Z7WIbOAbXyhKfxatWh2SOadLd+ix1RJ
	at66PQeowMmp17AXJ/iNFjPT2QBrxG/QM4Pg5P2Av0NaqtleltMXvZPp+Ut4yNbV4PsXnunOhRV
	viDXccpiFLlNviiuPYAbCu5rnlHZVQtXB+1EJvaAxGsyg=
X-Google-Smtp-Source: AGHT+IFazFrD0ua/D+OyOxZV/TILTiOYzJ/3DUB89wm9e5Xuy/h95OK98M827+C0BmLeSL4ZrMLPsQ==
X-Received: by 2002:a17:907:1b1d:b0:b73:6c97:af4b with SMTP id a640c23a62f3a-b84453eb56amr1811673766b.45.1768234101567;
        Mon, 12 Jan 2026 08:08:21 -0800 (PST)
Received: from MacBookPro ([2a02:8071:2186:3703:6de9:eb98:99c8:7af2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4c15sm17955883a12.4.2026.01.12.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:08:21 -0800 (PST)
From: Nauman Sabir <officialnaumansabir@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kbuild@vger.kernel.org,
	Nauman Sabir <officialnaumansabir@gmail.com>
Subject: [PATCH v3 3/3] Documentation: Fix typos and grammatical errors
Date: Mon, 12 Jan 2026 17:08:20 +0100
Message-ID: <20260112160820.19075-1-officialnaumansabir@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various typos and grammatical errors across documentation files:

- Fix missing preposition 'in' in process/changes.rst
- Correct 'result by' to 'result from' in admin-guide/README.rst
- Fix 'before hand' to 'beforehand' in cgroup-v1/hugetlb.rst
- Correct 'allows to limit' to 'allows limiting' in hugetlb.rst,
  cgroup-v2.rst, and kconfig-language.rst
- Fix 'needs precisely know' to 'needs to precisely know'
- Correct 'overcommited' to 'overcommitted' in hugetlb.rst
- Fix subject-verb agreement: 'never causes' to 'never cause'
- Fix 'there is enough' to 'there are enough' in hugetlb.rst
- Fix 'metadatas' to 'metadata' in filesystems/erofs.rst
- Fix 'hardwares' to 'hardware' in scsi/ChangeLog.sym53c8xx

Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>
---
 Documentation/admin-guide/README.rst           |  2 +-
 .../admin-guide/cgroup-v1/hugetlb.rst          | 18 +++++++++---------
 Documentation/admin-guide/cgroup-v2.rst        |  2 +-
 Documentation/filesystems/erofs.rst            |  2 +-
 Documentation/kbuild/kconfig-language.rst      |  2 +-
 Documentation/process/changes.rst              |  2 +-
 Documentation/scsi/ChangeLog.sym53c8xx         |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 05301f03b717..77fec1de6dc8 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -53,7 +53,7 @@ Documentation
    these typically contain kernel-specific installation notes for some
    drivers for example. Please read the
    :ref:`Documentation/process/changes.rst <changes>` file, as it
-   contains information about the problems, which may result by upgrading
+   contains information about the problems which may result from upgrading
    your kernel.
 
 Installing the kernel source
diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index 493a8e386700..b5f3873b7d3a 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -77,7 +77,7 @@ control group and enforces the limit during page fault. Since HugeTLB
 doesn't support page reclaim, enforcing the limit at page fault time implies
 that, the application will get SIGBUS signal if it tries to fault in HugeTLB
 pages beyond its limit. Therefore the application needs to know exactly how many
-HugeTLB pages it uses before hand, and the sysadmin needs to make sure that
+HugeTLB pages it uses beforehand, and the sysadmin needs to make sure that
 there are enough available on the machine for all the users to avoid processes
 getting SIGBUS.
 
@@ -91,23 +91,23 @@ getting SIGBUS.
   hugetlb.<hugepagesize>.rsvd.usage_in_bytes
   hugetlb.<hugepagesize>.rsvd.failcnt
 
-The HugeTLB controller allows to limit the HugeTLB reservations per control
+The HugeTLB controller allows limiting the HugeTLB reservations per control
 group and enforces the controller limit at reservation time and at the fault of
 HugeTLB memory for which no reservation exists. Since reservation limits are
-enforced at reservation time (on mmap or shget), reservation limits never causes
-the application to get SIGBUS signal if the memory was reserved before hand. For
+enforced at reservation time (on mmap or shget), reservation limits never cause
+the application to get SIGBUS signal if the memory was reserved beforehand. For
 MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
 limit, enforcing memory usage at fault time and causing the application to
 receive a SIGBUS if it's crossing its limit.
 
 Reservation limits are superior to page fault limits described above, since
 reservation limits are enforced at reservation time (on mmap or shget), and
-never causes the application to get SIGBUS signal if the memory was reserved
-before hand. This allows for easier fallback to alternatives such as
+never cause the application to get SIGBUS signal if the memory was reserved
+beforehand. This allows for easier fallback to alternatives such as
 non-HugeTLB memory for example. In the case of page fault accounting, it's very
-hard to avoid processes getting SIGBUS since the sysadmin needs precisely know
-the HugeTLB usage of all the tasks in the system and make sure there is enough
-pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommited
+hard to avoid processes getting SIGBUS since the sysadmin needs to precisely know
+the HugeTLB usage of all the tasks in the system and make sure there are enough
+pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommitted
 systems is practically impossible with page fault accounting.
 
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..098d6831b3c0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2816,7 +2816,7 @@ DMEM Interface Files
 HugeTLB
 -------
 
-The HugeTLB controller allows to limit the HugeTLB usage per control group and
+The HugeTLB controller allows limiting the HugeTLB usage per control group and
 enforces the controller limit during page fault.
 
 HugeTLB Interface Files
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194b94..e61db115e762 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -154,7 +154,7 @@ to be as simple as possible::
   0 +1K
 
 All data areas should be aligned with the block size, but metadata areas
-may not. All metadatas can be now observed in two different spaces (views):
+may not. All metadata can be now observed in two different spaces (views):
 
  1. Inode metadata space
 
diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index abce88f15d7c..7067ec3f0011 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -216,7 +216,7 @@ applicable everywhere (see syntax).
 
 - numerical ranges: "range" <symbol> <symbol> ["if" <expr>]
 
-  This allows to limit the range of possible input values for int
+  This allows limiting the range of possible input values for int
   and hex symbols. The user can only input a value which is larger than
   or equal to the first symbol and smaller than or equal to the second
   symbol.
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 62951cdb13ad..0cf97dbab29d 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -218,7 +218,7 @@ DevFS has been obsoleted in favour of udev
 Linux documentation for functions is transitioning to inline
 documentation via specially-formatted comments near their
 definitions in the source.  These comments can be combined with ReST
-files the Documentation/ directory to make enriched documentation, which can
+files in the Documentation/ directory to make enriched documentation, which can
 then be converted to PostScript, HTML, LaTex, ePUB and PDF files.
 In order to convert from ReST format to a format of your choice, you'll need
 Sphinx.
diff --git a/Documentation/scsi/ChangeLog.sym53c8xx b/Documentation/scsi/ChangeLog.sym53c8xx
index 3435227a2bed..6bca91e03945 100644
--- a/Documentation/scsi/ChangeLog.sym53c8xx
+++ b/Documentation/scsi/ChangeLog.sym53c8xx
@@ -3,7 +3,7 @@ Sat May 12 12:00 2001 Gerard Roudier (groudier@club-internet.fr)
 	- Ensure LEDC bit in GPCNTL is cleared when reading the NVRAM.
 	  Fix sent by Stig Telfer <stig@api-networks.com>.
 	- Backport from SYM-2 the work-around that allows to support 
-	  hardwares that fail PCI parity checking.
+	  hardware that fails PCI parity checking.
 	- Check that we received at least 8 bytes of INQUIRY response 
 	  for byte 7, that contains device capabilities, to be valid.
 	- Define scsi_set_pci_device() as nil for kernel < 2.4.4.
-- 
2.52.0


