Return-Path: <cgroups+bounces-2905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0308C5EC1
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 03:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774102823B6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E663A5;
	Wed, 15 May 2024 01:25:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EB79C2;
	Wed, 15 May 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736318; cv=none; b=A08GPpkET3EE0eEG/lXtfRL+qTzPqN5A0lBW5dT2tXsg2It4Rd2SskyA1sC7sDD+kNMc/2wLfMsf72o0qTVLxGdTG2M8Sda3F4Q0IHQTTIbX2ze4GWP3wGyPuKIHe25x3Uev43uvjEMzDFZtw9RU2SE9848HuZYjSnVrsC83Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736318; c=relaxed/simple;
	bh=4s9NDPoOxitNkT6OaXSxKymih9MpTgrsHi49G1AA++Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftsPbRAvEWHopsUz70ZIymfAwK0Ttwnz2HcPD3DV/M5p1PkCY+nbjmKx0vNVJOganYLfAHUEMoXHdW1+/+5+2Pk8ik9DB3ea5aHswAxMU9YzJiN6cyasH9NuXfIplFKTnHmktG11o5aQnXKP4G0g9l34MJePS5FkE+OJRSRqhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44F1O3vE051219;
	Wed, 15 May 2024 09:24:03 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VfFlw2713z2QDRDl;
	Wed, 15 May 2024 09:20:44 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 15 May 2024 09:24:00 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo
	<tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: [RFC PATCH 0/2] introduce precised blk-throttle control
Date: Wed, 15 May 2024 09:23:48 +0800
Message-ID: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 44F1O3vE051219

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There is always an error between blk-throttle's configuration and the
real value which should be introduced by over-sized bio as there is no
control on ra->size during readahead. This series patches would like to
introduce the helper function to provide the bytes budgt and apply it
on readahead.

Please find below for the fio test result on v6.6 which presents 2%-10%
improvement for BW and lat. Besides, we can also observed stable BW
instantaneous and lower stdev value during the test.

blkio.throttle.read_bps_device = 1MB/s
   before:  read: IOPS=223, BW=894KiB/s (915kB/s)(175MiB/200919msec)
   after :  read: IOPS=239, BW=960KiB/s (983kB/s)(153MiB/163105msec)

   before:  clat (usec): min=4, max=16795k, avg=4468.74, stdev=265746.14
   after :  clat (usec): min=11, max=209193, avg=4105.22, stdev=27188.04

   before:  lat  (usec): min=6, max=16795k, avg=4470.57, stdev=265746.14
   after :  lat  (usec): min=16, max=209197, avg=4120.03, stdev=27188.04


blkio.throttle.read_bps_device = 10MB/s
   before:  read: IOPS=2380, BW=9524KiB/s (9752kB/s)(1007MiB/108311msec)
   after :  read: IOPS=2438, BW=9754KiB/s (9989kB/s)(1680MiB/176405msec)

   before:  clat (usec): min=4, max=2494.6k, avg=412.72, stdev=25783.51
   after :  clat (usec): min=4, max=201817, avg=399.58, stdev=8268.85

   before:  lat  (usec): min=6, max=2494.6k, avg=414.48, stdev=25783.51
   after :  lat  (usec): min=6, max=201819, avg=402.10, stdev=8268.85

blkio.throttle.read_bps_device = 20MB/s
fio ... -numjobs=8 ...

    before : IOPS=37.9k, BW=148MiB/s (155MB/s)(11.6GiB/80333msec)
    after  : IOPS=39.0k, BW=153MiB/s (160MB/s)(15.6GiB/104914msec)

    before : clat (usec): min=4, max=1056.6k, avg=197.23, stdev=10080.69
    after  : clat (usec): min=4, max=193481, avg=188.83, stdev=4651.29

    before : lat (usec): min=5, max=1056.6k, avg=200.48, stdev=10080.76
    after  : lat (usec): min=5, max=193483, avg=192.68, stdev=4651.87

blkio.throttle.read_bps_device = 30MB/s
fio ... -numjobs=8 ...

    before : IOPS=57.2k, BW=224MiB/s (234MB/s)(15.6GiB/71561msec)
    after  : IOPS=58.5k, BW=229MiB/s (240MB/s)(15.6GiB/69996msec)

    before : clat (usec): min=4, max=1105.5k, avg=126.20, stdev=6419.22
    after  : clat (usec): min=4, max=183956, avg=120.60, stdev=2957.28

    before : lat (usec): min=5, max=1105.5k, avg=129.45, stdev=6419.29
    after  : lat (usec): min=5, max=183958, avg=124.40, stdev=2958.18

Zhaoyang Huang (2):
  block: introduce helper function to calculate bps budgt
  mm: introduce budgt control in readahead

 block/blk-throttle.c       | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 10 +++++++++
 mm/readahead.c             | 33 ++++++++++++++++++++--------
 3 files changed, 78 insertions(+), 9 deletions(-)

-- 
2.25.1


