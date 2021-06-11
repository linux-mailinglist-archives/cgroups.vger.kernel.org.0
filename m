Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB03A3A21
	for <lists+cgroups@lfdr.de>; Fri, 11 Jun 2021 05:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFKDKy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 23:10:54 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:50816 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFKDKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 23:10:53 -0400
Received: by mail-pj1-f43.google.com with SMTP id g4so4895126pjk.0;
        Thu, 10 Jun 2021 20:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Xft++ApoOxYR42OLNycBh2ce7Wqi3wmGJY1H8bTUZw=;
        b=R1zkzJ0z/xn0McME8rMfq55ag87uDM2iBtfYf/q+Qq6lQ3XVn3xK7ZfHz4KVfrt5Rt
         MHVomFydHk6D6a9ynkx65C34pC8Na4MEh/nXEfCsyh/+QMlEinAERmS1zg5+CAhyp1F8
         364FL6kxSSoBt6rX7KzN1fmVA5b1E0zxewnIHwnuYUX6HCbu3kz9hr7hq7bKsji4cM1E
         pxYHLbnoyY/XV1xs3B0bi77FR2eho8X20pyXTqR+w5U5pOFzX3FukIBZ1ZdXqORqjQAy
         wWn8/alzzugM54979MyrCX3DCcz75JPpd23WZNVJviv3mvzFnC6QEmAkYRE0RrDRFHrv
         SPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Xft++ApoOxYR42OLNycBh2ce7Wqi3wmGJY1H8bTUZw=;
        b=etOz2YPLBDVSe9YhEPZxNJhIMCQAdKopLFYUNfw7mCA3gGgLx1bO2iRTYKqEYcfp6z
         FQFXsrv8Zf2tw7vUoNh2CxEvLRNAnaqNg/ikbFXYtd7Q9H730EI+BYs7zhZP1cyQMl4w
         VLMNHOxMdGAxoVmJvYzhSwyKBh4zAfSirlMegD8OKz5Farq+91db5X8xJ5YOmdmGE0bO
         rt7QN26ygmFtCQH/yr5nhCriX9EV8ZfC7hiUp6WRp7F9bF48DXNL+wmNMyV9GF+RYOgM
         hBQPCs5rCTaAZ01siepnncU+2i9g0MovLcRL6xlHhEOcXUtL6w8EG0KKjxY4sOuk/xCC
         C/cQ==
X-Gm-Message-State: AOAM532oU4L5RxgUyUBpanevbhSldjDTNdEeMZ9+NqNFhSYSC033NMVC
        MUTmu+hQ4g+PetfKBkgGfwTzpDOJismyYw==
X-Google-Smtp-Source: ABdhPJxYAwX7Yu7YZMBLDGoVG5roqTOrPB1+ALD93p1nSUFD+7n6b3CaC7TQpI+XeF1nN0l4kw6UNA==
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr2145863pjt.170.1623380863218;
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id q2sm3774319pje.50.2021.06.10.20.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:07:42 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 2/3] docs/cgroup-v1/blkio: stop abusing itemized list
Date:   Thu, 10 Jun 2021 20:07:36 -0700
Message-Id: <20210611030737.1984343-3-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611030737.1984343-1-kolyshkin@gmail.com>
References: <20210611030737.1984343-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix many formatting issues by stop (ab)using itemized lists for
everything (mostly replaced by definition lists).

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 .../cgroup-v1/blkio-controller.rst            | 130 +++++++++---------
 1 file changed, 67 insertions(+), 63 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
index 36d43ae7dc13..8101dcba381d 100644
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -17,36 +17,37 @@ level logical devices like device mapper.
 
 HOWTO
 =====
+
 Throttling/Upper Limit policy
 -----------------------------
-- Enable Block IO controller::
+Enable Block IO controller::
 
 	CONFIG_BLK_CGROUP=y
 
-- Enable throttling in block layer::
+Enable throttling in block layer::
 
 	CONFIG_BLK_DEV_THROTTLING=y
 
-- Mount blkio controller (see cgroups.txt, Why are cgroups needed?)::
+Mount blkio controller (see cgroups.txt, Why are cgroups needed?)::
 
         mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
 
-- Specify a bandwidth rate on particular device for root group. The format
-  for policy is "<major>:<minor>  <bytes_per_second>"::
+Specify a bandwidth rate on particular device for root group. The format
+for policy is "<major>:<minor>  <bytes_per_second>"::
 
         echo "8:16  1048576" > /sys/fs/cgroup/blkio/blkio.throttle.read_bps_device
 
-  Above will put a limit of 1MB/second on reads happening for root group
-  on device having major/minor number 8:16.
+This will put a limit of 1MB/second on reads happening for root group
+on device having major/minor number 8:16.
 
-- Run dd to read a file and see if rate is throttled to 1MB/s or not::
+Run dd to read a file and see if rate is throttled to 1MB/s or not::
 
         # dd iflag=direct if=/mnt/common/zerofile of=/dev/null bs=4K count=1024
         1024+0 records in
         1024+0 records out
         4194304 bytes (4.2 MB) copied, 4.0001 s, 1.0 MB/s
 
- Limits for writes can be put using blkio.throttle.write_bps_device file.
+Limits for writes can be put using blkio.throttle.write_bps_device file.
 
 Hierarchical Cgroups
 ====================
@@ -79,28 +80,31 @@ following::
 
 Various user visible config options
 ===================================
-CONFIG_BLK_CGROUP
-	- Block IO controller.
 
-CONFIG_BFQ_CGROUP_DEBUG
-	- Debug help. Right now some additional stats file show up in cgroup
+  CONFIG_BLK_CGROUP
+	  Block IO controller.
+
+  CONFIG_BFQ_CGROUP_DEBUG
+	  Debug help. Right now some additional stats file show up in cgroup
 	  if this option is enabled.
 
-CONFIG_BLK_DEV_THROTTLING
-	- Enable block device throttling support in block layer.
+  CONFIG_BLK_DEV_THROTTLING
+	  Enable block device throttling support in block layer.
 
 Details of cgroup files
 =======================
+
 Proportional weight policy files
 --------------------------------
-- blkio.weight
-	- Specifies per cgroup weight. This is default weight of the group
+
+  blkio.weight
+	  Specifies per cgroup weight. This is default weight of the group
 	  on all the devices until and unless overridden by per device rule.
 	  (See blkio.weight_device).
 	  Currently allowed range of weights is from 10 to 1000.
 
-- blkio.weight_device
-	- One can specify per cgroup per device rules using this interface.
+  blkio.weight_device
+	  One can specify per cgroup per device rules using this interface.
 	  These rules override the default value of group weight as specified
 	  by blkio.weight.
 
@@ -130,34 +134,34 @@ Proportional weight policy files
 	    dev     weight
 	    8:16    300
 
-- blkio.time
-	- disk time allocated to cgroup per device in milliseconds. First
+  blkio.time
+	  Disk time allocated to cgroup per device in milliseconds. First
 	  two fields specify the major and minor number of the device and
 	  third field specifies the disk time allocated to group in
 	  milliseconds.
 
-- blkio.sectors
-	- number of sectors transferred to/from disk by the group. First
+  blkio.sectors
+	  Number of sectors transferred to/from disk by the group. First
 	  two fields specify the major and minor number of the device and
 	  third field specifies the number of sectors transferred by the
 	  group to/from the device.
 
-- blkio.io_service_bytes
-	- Number of bytes transferred to/from the disk by the group. These
+  blkio.io_service_bytes
+	  Number of bytes transferred to/from the disk by the group. These
 	  are further divided by the type of operation - read or write, sync
 	  or async. First two fields specify the major and minor number of the
 	  device, third field specifies the operation type and the fourth field
 	  specifies the number of bytes.
 
-- blkio.io_serviced
-	- Number of IOs (bio) issued to the disk by the group. These
+  blkio.io_serviced
+	  Number of IOs (bio) issued to the disk by the group. These
 	  are further divided by the type of operation - read or write, sync
 	  or async. First two fields specify the major and minor number of the
 	  device, third field specifies the operation type and the fourth field
 	  specifies the number of IOs.
 
-- blkio.io_service_time
-	- Total amount of time between request dispatch and request completion
+  blkio.io_service_time
+	  Total amount of time between request dispatch and request completion
 	  for the IOs done by this cgroup. This is in nanoseconds to make it
 	  meaningful for flash devices too. For devices with queue depth of 1,
 	  this time represents the actual service time. When queue_depth > 1,
@@ -170,8 +174,8 @@ Proportional weight policy files
 	  specifies the operation type and the fourth field specifies the
 	  io_service_time in ns.
 
-- blkio.io_wait_time
-	- Total amount of time the IOs for this cgroup spent waiting in the
+  blkio.io_wait_time
+	  Total amount of time the IOs for this cgroup spent waiting in the
 	  scheduler queues for service. This can be greater than the total time
 	  elapsed since it is cumulative io_wait_time for all IOs. It is not a
 	  measure of total time the cgroup spent waiting but rather a measure of
@@ -185,24 +189,24 @@ Proportional weight policy files
 	  minor number of the device, third field specifies the operation type
 	  and the fourth field specifies the io_wait_time in ns.
 
-- blkio.io_merged
-	- Total number of bios/requests merged into requests belonging to this
+  blkio.io_merged
+	  Total number of bios/requests merged into requests belonging to this
 	  cgroup. This is further divided by the type of operation - read or
 	  write, sync or async.
 
-- blkio.io_queued
-	- Total number of requests queued up at any given instant for this
+  blkio.io_queued
+	  Total number of requests queued up at any given instant for this
 	  cgroup. This is further divided by the type of operation - read or
 	  write, sync or async.
 
-- blkio.avg_queue_size
-	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
+  blkio.avg_queue_size
+	  Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  The average queue size for this cgroup over the entire time of this
 	  cgroup's existence. Queue size samples are taken each time one of the
 	  queues of this cgroup gets a timeslice.
 
-- blkio.group_wait_time
-	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
+  blkio.group_wait_time
+	  Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  This is the amount of time the cgroup had to wait since it became busy
 	  (i.e., went from 0 to 1 request queued) to get a timeslice for one of
 	  its queues. This is different from the io_wait_time which is the
@@ -212,8 +216,8 @@ Proportional weight policy files
 	  will only report the group_wait_time accumulated till the last time it
 	  got a timeslice and will not include the current delta.
 
-- blkio.empty_time
-	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
+  blkio.empty_time
+	  Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  This is the amount of time a cgroup spends without any pending
 	  requests when not being served, i.e., it does not include any time
 	  spent idling for one of the queues of the cgroup. This is in
@@ -221,8 +225,8 @@ Proportional weight policy files
 	  the stat will only report the empty_time accumulated till the last
 	  time it had a pending request and will not include the current delta.
 
-- blkio.idle_time
-	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
+  blkio.idle_time
+	  Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  This is the amount of time spent by the IO scheduler idling for a
 	  given cgroup in anticipation of a better request than the existing ones
 	  from other queues/cgroups. This is in nanoseconds. If this is read
@@ -230,60 +234,60 @@ Proportional weight policy files
 	  idle_time accumulated till the last idle period and will not include
 	  the current delta.
 
-- blkio.dequeue
-	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y. This
+  blkio.dequeue
+	  Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y. This
 	  gives the statistics about how many a times a group was dequeued
 	  from service tree of the device. First two fields specify the major
 	  and minor number of the device and third field specifies the number
 	  of times a group was dequeued from a particular device.
 
-- blkio.*_recursive
-	- Recursive version of various stats. These files show the
+  blkio.*_recursive
+	  Recursive version of various stats. These files show the
           same information as their non-recursive counterparts but
           include stats from all the descendant cgroups.
 
 Throttling/Upper limit policy files
 -----------------------------------
-- blkio.throttle.read_bps_device
-	- Specifies upper limit on READ rate from the device. IO rate is
+  blkio.throttle.read_bps_device
+	  Specifies upper limit on READ rate from the device. IO rate is
 	  specified in bytes per second. Rules are per device. Following is
 	  the format::
 
 	    echo "<major>:<minor>  <rate_bytes_per_second>" > /cgrp/blkio.throttle.read_bps_device
 
-- blkio.throttle.write_bps_device
-	- Specifies upper limit on WRITE rate to the device. IO rate is
+  blkio.throttle.write_bps_device
+	  Specifies upper limit on WRITE rate to the device. IO rate is
 	  specified in bytes per second. Rules are per device. Following is
 	  the format::
 
 	    echo "<major>:<minor>  <rate_bytes_per_second>" > /cgrp/blkio.throttle.write_bps_device
 
-- blkio.throttle.read_iops_device
-	- Specifies upper limit on READ rate from the device. IO rate is
+  blkio.throttle.read_iops_device
+	  Specifies upper limit on READ rate from the device. IO rate is
 	  specified in IO per second. Rules are per device. Following is
 	  the format::
 
 	   echo "<major>:<minor>  <rate_io_per_second>" > /cgrp/blkio.throttle.read_iops_device
 
-- blkio.throttle.write_iops_device
-	- Specifies upper limit on WRITE rate to the device. IO rate is
+  blkio.throttle.write_iops_device
+	  Specifies upper limit on WRITE rate to the device. IO rate is
 	  specified in io per second. Rules are per device. Following is
 	  the format::
 
 	    echo "<major>:<minor>  <rate_io_per_second>" > /cgrp/blkio.throttle.write_iops_device
 
-Note: If both BW and IOPS rules are specified for a device, then IO is
-      subjected to both the constraints.
+          Note: If both BW and IOPS rules are specified for a device, then IO is
+          subjected to both the constraints.
 
-- blkio.throttle.io_serviced
-	- Number of IOs (bio) issued to the disk by the group. These
+  blkio.throttle.io_serviced
+	  Number of IOs (bio) issued to the disk by the group. These
 	  are further divided by the type of operation - read or write, sync
 	  or async. First two fields specify the major and minor number of the
 	  device, third field specifies the operation type and the fourth field
 	  specifies the number of IOs.
 
-- blkio.throttle.io_service_bytes
-	- Number of bytes transferred to/from the disk by the group. These
+  blkio.throttle.io_service_bytes
+	  Number of bytes transferred to/from the disk by the group. These
 	  are further divided by the type of operation - read or write, sync
 	  or async. First two fields specify the major and minor number of the
 	  device, third field specifies the operation type and the fourth field
@@ -291,6 +295,6 @@ Note: If both BW and IOPS rules are specified for a device, then IO is
 
 Common files among various policies
 -----------------------------------
-- blkio.reset_stats
-	- Writing an int to this file will result in resetting all the stats
+  blkio.reset_stats
+	  Writing an int to this file will result in resetting all the stats
 	  for that cgroup.
-- 
2.31.1

