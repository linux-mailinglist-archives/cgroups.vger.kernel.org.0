Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72E91A6F01
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 00:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbgDMWUp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 18:20:45 -0400
Received: from mx0a-001e9b01.pphosted.com ([148.163.157.123]:52294 "EHLO
        mx0a-001e9b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389509AbgDMWUo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 18:20:44 -0400
X-Greylist: delayed 1346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 18:20:44 EDT
Received: from pps.filterd (m0176108.ppops.net [127.0.0.1])
        by mx0a-001e9b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03DLtIt9017401
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 17:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=magicleap.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=pp09042018;
 bh=2LYr+6fk9jc+ruNP83QWvUWdwCvITiOBEiV9JY3ziDQ=;
 b=HdyBBN0yThk4EXVbQ8mZ9GFO+jNAmUXwLvFiakVexr/O7ktaI5W/3W8oV6oCYWkSX2Jz
 96RkDeO7DbtQ/DxE7fhfEAJiXvsnQEhiPukuUeODRtWThXaYpZmmr/isIoHJewfndGxd
 hjDXz2x7rVL1ohNrr4HENi2S9jRdeGZl6ILgh6HYaFlgCuC2OvudLWjs54qxaQDCDEXE
 gASj4OpRcnP1jygBJEqGCBMI8QMRhoC+CyULhcXufOl3F9EWtDtjITz1WejIqCcXdOvA
 oYDb35/KSmirbEyIR8R0Syket7hK8/RpfWEj6dlN0Bx/kAu2bQrZ6Hw/BRmqhb+k60ov 3Q== 
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
        by mx0a-001e9b01.pphosted.com with ESMTP id 30b7xqhuhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 17:58:17 -0400
Received: by mail-ua1-f72.google.com with SMTP id y23so4732272uar.2
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magicleap.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LYr+6fk9jc+ruNP83QWvUWdwCvITiOBEiV9JY3ziDQ=;
        b=GvwpjXIJdz7nDkgPYrZZvtBfCeiGi2XORRj68alYd6piMcXloFazhQkh9L9tVlDzeA
         Wi2ToTlPJey7l6S8spMVnQDfD/JfFdR+6Ab+l1Gw1tFoZa6P3I4v6zD5e5GRp2kbGRG0
         DwLJn7veoKFZI7kitdXi1SnmJRWB2keFHejko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LYr+6fk9jc+ruNP83QWvUWdwCvITiOBEiV9JY3ziDQ=;
        b=Xz7O/GkSC3CmGhOPnBfga8Na4mTr3MfBlJWEuPgoIl91kDUwtrf62XxLvhn9Ipaz47
         bWzhkzUeqeuGyiCS+WFFChpbhu/gVE8KsuJnjsyJBnGSnybigMRctUPpmv7G5uwb0NQW
         6JJi07D7/6Hj9c7z6NBwbJ3vs8ufGbAH0t0cVbQQeNyobwXYpk7UqHvqqPfL8dP9rfI1
         PqbJX1578X9MpDxetpXo2o15N7hgTJ6j1+BjHheXMAwqQvpV9vKi0w0JN8L5ZXVlNgIh
         4G1Wbm0tvfcyXEh4y7Twz+MhOP87dL0huELunxge+nSMxjtHxr8UO36qD89pA4MZkG5x
         7nSg==
X-Gm-Message-State: AGi0PubUhxOJSjRdPAOJ3hDLObqev2Z8EWYdgBOqxSCT+v4+vQQdprcw
        e1wz/L/w4XngzjMw+2NDMn97fQdwXHtArqW07AB72/eiAGtnMrHVsvnz0JmhFHL7PfLYC7TMmqZ
        1AnnCwqN/aSb+T0W6NA==
X-Received: by 2002:a67:edd9:: with SMTP id e25mr13851040vsp.216.1586815096594;
        Mon, 13 Apr 2020 14:58:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMGPLZnRtmTVpXfPqtZWc18Gf0bs/HZgZPXoFUY/YUf9rKLxCXLVFVeGuWQy7Zgvj40mZklA==
X-Received: by 2002:a67:edd9:: with SMTP id e25mr13851022vsp.216.1586815096308;
        Mon, 13 Apr 2020 14:58:16 -0700 (PDT)
Received: from mldl2169.magicleap.ds ([162.246.139.210])
        by smtp.gmail.com with ESMTPSA id 20sm2988529uaj.13.2020.04.13.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:58:15 -0700 (PDT)
From:   svc_lmoiseichuk@magicleap.com
X-Google-Original-From: lmoiseichuk@magicleap.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        anton.vorontsov@linaro.org, penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: [PATCH 1/2] memcg: expose vmpressure knobs
Date:   Mon, 13 Apr 2020 17:57:49 -0400
Message-Id: <20200413215750.7239-2-lmoiseichuk@magicleap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=2 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130160
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

Populating memcg vmpressure controls with legacy defaults:
- memory.pressure_window (512 or SWAP_CLUSTER_MAX * 16)
- memory.pressure_level_critical_prio (3)
- memory.pressure_level_medium (60)
- memory.pressure_level_critical (95)

Signed-off-by: Leonid Moiseichuk <lmoiseichuk@magicleap.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0ae4f564c2d6..42508123a8e1 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -79,6 +79,12 @@ Brief summary of control files.
  memory.use_hierarchy		     set/show hierarchical account enabled
  memory.force_empty		     trigger forced page reclaim
  memory.pressure_level		     set memory pressure notifications
+ memory.pressure_window 	     set window size for scanned pages, better
+				     to perform it as vmscan reclaimer logic
+				     in chunks in multiple SWAP_CLUSTER_MAX
+ memory.pressure_level_critical_prio vmscan priority for critical level
+ memory.pressure_level_medium	     medium level pressure percents
+ memory.pressure_level_critical      critical level pressure percents
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
  memory.move_charge_at_immigrate     set/show controls of moving charges
@@ -893,12 +899,16 @@ pressure, the system might be making swap, paging out active file caches,
 etc. Upon this event applications may decide to further analyze
 vmstat/zoneinfo/memcg or internal memory usage statistics and free any
 resources that can be easily reconstructed or re-read from a disk.
+The level threshold could be tuned using memory.pressure_level_medium.
 
 The "critical" level means that the system is actively thrashing, it is
 about to out of memory (OOM) or even the in-kernel OOM killer is on its
 way to trigger. Applications should do whatever they can to help the
 system. It might be too late to consult with vmstat or any other
-statistics, so it's advisable to take an immediate action.
+statistics, so it's advisable to take an immediate action. The level
+threshold could be tuned using memory.pressure_level_critical. Number
+of pages and vmscan priority handled as memory.pressure_window and
+memory.pressure_level_critical_prio.
 
 By default, events are propagated upward until the event is handled, i.e. the
 events are not pass-through. For example, you have three cgroups: A->B->C. Now
-- 
2.17.1

