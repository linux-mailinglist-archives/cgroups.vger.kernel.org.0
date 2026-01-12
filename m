Return-Path: <cgroups+bounces-13061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DECD11721
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753FC30124D8
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3669345722;
	Mon, 12 Jan 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arAhRpIP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C743090D5
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209431; cv=none; b=QVrRboHRkg+/4fT1HfAt46nia7mHq1XJbmfHt5dYjepNWkVD6StC31OWmrcOLqG6ijnVH9PoqWryG3FU7ye1r1X7DDj6lB6+uVdxj6HZWhPDED9SIhiw0xiQlIQlrWGF5ssMNE/sbirCjecn4YhQgaLH3CkUYox4jj6jW9Gzvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209431; c=relaxed/simple;
	bh=7JQzKSeQVZx457uwRMkr4aCIBLk4y7oY3Lw/r19JkC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOCYV/gvF7EUIt7cToCIPDdAL57Iw8vdPSpwG0uVkZMblkqgDn/KR1noClt2SMrnFhzLmYAHq5gzsiOfPkwFvjOQUnaQeWtTIDXP2Yae/DyWh3bLYHDdBbU91oAiRgqHRDHa3EYSiRrg0Uw8azsepm7L/W3V1B0/Ri/7ePHaXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arAhRpIP; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so9591164a12.1
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768209428; x=1768814228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zd0BPdweYbYZbQyn2qW1okTKg1KegiW0299KXASGYXY=;
        b=arAhRpIPJOIZE4JPX3GVuwxOOJCYX5WoSOlFTrT2D8Vsv2LeID0RpiJsuZXZ12fvqJ
         g70rNpszBFEP5Zqbf8Jkv3Y3ieMRcZV0ou0O/7wc6Mqv4fvas/YHSUALmcx+WqdESD6I
         HnwyaCZB3sfigAKVNpmv/aoVlwnaIIrzpznCXRB2svRDUzocNHlKOdprCHb3au5gysuo
         /J4J3sYaRt9YJFjvA2L4Azcju2XJvrlWBRVAOZBMpiJN8nVEmvm2l215OnsRqW9muD7S
         2g8BSzW7YeVCnlYaISJkS8s1g5zg19o5aV9Ca7CoZqPiQxkpv/al4GMl5dGJUkYg1wNz
         KiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768209428; x=1768814228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd0BPdweYbYZbQyn2qW1okTKg1KegiW0299KXASGYXY=;
        b=ePEdipvSzLY7XCUlCwvYgEwWeBTlAp0c6XMj4NGKtDU5rXXJ2tItrAnlqhm3YLp/IW
         ORdRn84Wcs30eP3LxYSmSVpfP/PBl7nN7v+msgm1ltJ/dKFrdQHsYfBN/ifKA4e8lURC
         squkwyA+ll5Sf3xXzjoja8xMuQ272TaVBueWGcpKRZkNvsjC/q15lj4kaqLUik9itsYB
         zj3Yaxlnn3bswk74joFPYjnlMPHcxfR9EIwVuljh2VtNv/WtVGJH5Jp9JCY9lEXCReC3
         VC/2GRCjMlLnJB7Izi+NZetH7ZgsCQ0TNJjBpIGLgvv1e0bPEo8Xh2K4h1bNocov+eJs
         nXjA==
X-Forwarded-Encrypted: i=1; AJvYcCXNwQypU24gtGLEi8hZASnG8l2WLzH+HtMCR9qp2QBvPabi5uElQZI4RiQl4mNAabsbxSgyeKXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2st9/qSwmcPfwHust3BiPOXFFhOV2U9CNfuFllS8QRWcROBt+
	HQYqempw9RMR/6EWyiw9sQIoV1Rf7BFQo96pL3L+Zt8TQQtX6m+uV8VZ
X-Gm-Gg: AY/fxX6IWa0+8NYRO6XmmI20pP/QssKtWDFlGcQaKGi09MdtsK1HU8ytcivRdFbyPSp
	kCSdBqAsDy4tALuTrnf/iI/2xW2SGbG+lb9Far0Phf1VNATScmfIOgbZcLERZ/k24S8LV1rVJpj
	eTg1wZnwT7muUgdGliWzLk6/JmK2xU6UMh39J499lSkEZPmGd1Eu0B1h/sh0hNxhpStgXAy3712
	ETz5dJnRxovpDnDdhAN8ECBifBSDQz8YtbQt1l3Lel1R4AT/R3Gb93db03y8ZpgIVBdLU5ii73/
	cEulTCxiNaQB7kDl1BYSDnUeZC2LCR8nKkgPPOIU3t1aWs00kSpvQb0FLeIPR+YPDD4Mqscq54u
	0WtKEy4Us8kpQq7HEJ1XG21FI/sGpuSFxP26r94QTjG37Yvj8kmaRXNGCLaL6f86uGlUZc41fIb
	E0J0KpqrVPRW7bomkDTL/f4okU7gxt0BX1jCY2sISbxuA=
X-Google-Smtp-Source: AGHT+IEVkFHwWdARDiOC3T5oubH1b0HSoQYmd/NAnJNXQ0ysw0Xt1Fgn+FqRVmFL8guwSSYOYkTxEQ==
X-Received: by 2002:a17:907:7202:b0:b87:efa:8786 with SMTP id a640c23a62f3a-b870efae612mr369083166b.55.1768209427070;
        Mon, 12 Jan 2026 01:17:07 -0800 (PST)
Received: from MacBookPro ([2a02:8071:2186:3703:6de9:eb98:99c8:7af2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870b0dba4esm411401466b.17.2026.01.12.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:17:06 -0800 (PST)
From: Nauman Sabir <officialnaumansabir@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jitao shi <jitao.shi@mediatek.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kbuild@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] Documentation: Fix typos and grammatical errors
Date: Mon, 12 Jan 2026 10:16:56 +0100
Message-ID: <20260112091659.12316-1-officialnaumansabir@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various typos and grammatical errors across multiple documentation
files to improve clarity and consistency.

Changes include:
- Fix missing preposition 'in' in process/changes.rst
- Correct 'result by' to 'result from' in admin-guide/README.rst
- Fix 'before hand' to 'beforehand' (3 instances) in cgroup-v1/hugetlb.rst
- Correct 'allows to limit' to 'allows limiting' in cgroup-v1/hugetlb.rst,
  cgroup-v2.rst, and kconfig-language.rst
- Fix 'needs precisely know' to 'needs to precisely know' in
  cgroup-v1/hugetlb.rst
- Correct 'overcommited' to 'overcommitted' in cgroup-v1/hugetlb.rst
- Fix subject-verb agreement: 'never causes' to 'never cause' (2 instances)
  in cgroup-v1/hugetlb.rst
- Fix subject-verb agreement: 'there is enough' to 'there are enough' in
  cgroup-v1/hugetlb.rst
- Remove incorrect plural from uncountable nouns: 'metadatas' to 'metadata'
  in filesystems/erofs.rst, and 'hardwares' to 'hardware' in
  devicetree/bindings/.../mediatek,dp.yaml, userspace-api/.../legacy_dvb_audio.rst,
  and scsi/ChangeLog.sym53c8xx

Note: British spelling 'recognised' retained per maintainer feedback.

These corrections improve the overall quality and readability of the
kernel documentation.

Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>
---
 Documentation/admin-guide/README.rst           |  2 +-
 .../admin-guide/cgroup-v1/hugetlb.rst          | 18 +++++++++---------
 Documentation/admin-guide/cgroup-v2.rst        |  2 +-
 .../bindings/display/mediatek/mediatek,dp.yaml |  2 +-
 Documentation/filesystems/erofs.rst            |  2 +-
 Documentation/kbuild/kconfig-language.rst      |  2 +-
 Documentation/process/changes.rst              |  2 +-
 Documentation/scsi/ChangeLog.sym53c8xx         |  2 +-
 .../media/dvb/legacy_dvb_audio.rst             |  2 +-
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 05301f03b..77fec1de6 100644
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
index 493a8e386..b5f3873b7 100644
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
index 7f5b59d95..098d6831b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2816,7 +2816,7 @@ DMEM Interface Files
 HugeTLB
 -------
 
-The HugeTLB controller allows to limit the HugeTLB usage per control group and
+The HugeTLB controller allows limiting the HugeTLB usage per control group and
 enforces the controller limit during page fault.
 
 HugeTLB Interface Files
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
index 274f59080..8f4bd9fb5 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Jitao shi <jitao.shi@mediatek.com>
 
 description: |
-  MediaTek DP and eDP are different hardwares and there are some features
+  MediaTek DP and eDP are different hardware and there are some features
   which are not supported for eDP. For example, audio is not supported for
   eDP. Therefore, we need to use two different compatibles to describe them.
   In addition, We just need to enable the power domain of DP, so the clock
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194..e61db115e 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -154,7 +154,7 @@ to be as simple as possible::
   0 +1K
 
 All data areas should be aligned with the block size, but metadata areas
-may not. All metadatas can be now observed in two different spaces (views):
+may not. All metadata can be now observed in two different spaces (views):
 
  1. Inode metadata space
 
diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index abce88f15..7067ec3f0 100644
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
index 62951cdb1..0cf97dbab 100644
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
index 3435227a2..6bca91e03 100644
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
diff --git a/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst b/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst
index 81b762ef1..99ffda355 100644
--- a/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst
+++ b/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst
@@ -444,7 +444,7 @@ Description
 ~~~~~~~~~~~
 
 A call to `AUDIO_GET_CAPABILITIES`_ returns an unsigned integer with the
-following bits set according to the hardwares capabilities.
+following bits set according to the hardware's capabilities.
 
 
 -----
-- 
2.52.0


