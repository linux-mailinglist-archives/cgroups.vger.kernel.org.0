Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3C1A8936
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503829AbgDNSWW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:22:22 -0400
Received: from mx0b-001e9b01.pphosted.com ([148.163.159.123]:27866 "EHLO
        mx0a-001e9b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503816AbgDNSV5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 14:21:57 -0400
Received: from pps.filterd (m0088348.ppops.net [127.0.0.1])
        by mx0b-001e9b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EID5Mi023060
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 14:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=magicleap.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=pp09042018;
 bh=w/qRpVJWlv8XupjZp41y7klSw+TDxGexre95wiqpeCI=;
 b=pgH5rboVZk+3nYg7mmd6Ld7nY9hS6e+WeeHzj89AhxHvXqjz7XwQ5o6LV2375Ez/ZvUx
 EuCHniD600/Hv+mtSvUMX8HTmClj0K4lVpCBzyPHMjro+fbq2ahF0iH8OMl8p5vo+dod
 SDBu6GxsOoShOwtdcCDjhbaocRDalnSlEgNL+2tl5CdZ/jrEJEtV22AxrWZyjFlr1mML
 t7iOVEvN4i1ubdXu2B1RHs1QCZKrmFhVb7Mo/AatkIvmsryloaYAbVx3CyvrqL5BpO1F
 mp+Hcez+8FnUHYx5UVvqfN5cjcc1kDV/4KIYfm63KiJEbV4pfE0jDhWT/SKJLurOToZM Yw== 
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        by mx0b-001e9b01.pphosted.com with ESMTP id 30b8rgjnj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 14:21:52 -0400
Received: by mail-yb1-f200.google.com with SMTP id e140so16657637ybb.8
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magicleap.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/qRpVJWlv8XupjZp41y7klSw+TDxGexre95wiqpeCI=;
        b=RzPGP4DK8FNrCIIritILyTbfeuCXhJPbCca+J7GL5RxguH77pGXSgz4gM+ADjSWDvL
         2Ns9zskvWM7zDx9uyod0wd0uM5YgnBPYbr1Egz2KPQkS+B+8EtrDkIa4ukU5iBYJ8jJg
         N07bD6qSQ+GwcUoS4UUcUKEIbU7o4COcBNtHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/qRpVJWlv8XupjZp41y7klSw+TDxGexre95wiqpeCI=;
        b=jngC8mJj3L/BINuv50s8hApVr1Kd7kXgl3X9YHoC8uH/quxvcBer/gcK8+SqVJuqFH
         Y0O6Rd6DsLDDNiROq9rn/TJf2Dv4noPg1xddFTix/S+ltY6J9/zy0X2i/3pzxNsH1ax2
         0cw/UEVr9CJlSgysiq+4XR7hj7bcUHxk/F7vWJCTQD6qPd4UC1C97Ezp2J6i+PU9BN3Q
         xkxTFs2+HdGf+Nm+PtrT9mSXyxeCrdu6RPIj2ny3ADAgf3wbPAy6x6IvnFGaON/WZ2Gg
         Y7k/0CDgM0bKWLwI/NxgUHCXb7TkBQfwPTxKbinSLl3BFW9ILpfa0PEbIZ8jMs4bhYYT
         s/bw==
X-Gm-Message-State: AGi0PubkFC1/6XMdmpl63gcO8Nm08bbrOxMHASmRCwMfCGX3VcZpSiQo
        nRAm+QRVxzZIq8a0Ua/fv9xowssWgqNfx29pGYR9rbOHOLHLKa3RrNjIACn77VOzkhGWOE9I9ss
        jgSCUJG5rOGdwdEn6wg==
X-Received: by 2002:ab0:3416:: with SMTP id z22mr1242052uap.9.1586884733890;
        Tue, 14 Apr 2020 10:18:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHBQK32vSYKyh0GrZgLa1wWTKCSCGT1IaRLb/zMw3ZLsMTAQK+q8n7jBC1BEbJ2yTP3g+E5A==
X-Received: by 2002:ab0:3416:: with SMTP id z22mr1242032uap.9.1586884733602;
        Tue, 14 Apr 2020 10:18:53 -0700 (PDT)
Received: from mldl2169.magicleap.ds ([162.246.139.210])
        by smtp.gmail.com with ESMTPSA id z79sm4252684vkd.35.2020.04.14.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:18:53 -0700 (PDT)
From:   svc_lmoiseichuk@magicleap.com
X-Google-Original-From: lmoiseichuk@magicleap.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: [PATCH v1 1/2] memcg, vmpressure: expose vmpressure controls
Date:   Tue, 14 Apr 2020 13:18:39 -0400
Message-Id: <20200414171840.22053-2-lmoiseichuk@magicleap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
References: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_09:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=2
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140131
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

Updated documentation for populating memcg vmpressure controls
with legacy defaults:
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

