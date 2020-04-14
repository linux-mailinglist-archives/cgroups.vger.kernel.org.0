Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC271A8944
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503857AbgDNSXh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:23:37 -0400
Received: from mx0b-001e9b01.pphosted.com ([148.163.159.123]:58194 "EHLO
        mx0b-001e9b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503791AbgDNSVU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 14:21:20 -0400
Received: from pps.filterd (m0176109.ppops.net [127.0.0.1])
        by mx0b-001e9b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EIDIAC005305
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 14:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=magicleap.com; h=from : to : cc :
 subject : date : message-id; s=pp09042018;
 bh=fZfKoumGyhhUhnpNwaeOKlaokdakEYLl+yjOnNzfDuU=;
 b=T8Ct4Rx2tHtkz81wq8vzedPGxgcA6aZW6p3BL3PWnZThs1D12eKpvtd5QvUAY4N/1p3c
 xUNpgfLk9TDuTAyE1l/7blDaHTYH5umMY8wRxe0W+mak4P0QgWoBdpvA4QZ68TPdyZY8
 G7RZUZk63CMomWdDs4p5XKaLMEiVjz5TQCYckGT2yMC74l9QhbNpWsg3qYO3/3KsiGke
 JCqFfltrdIOhlwJp5fJtfUPIj9AYsqbq8+FzDaHBXfe8QyrTqIgNoLgJ35zjntD7THuz
 yya+IBKmEWSzqeDEyYpanB1aA8dnbZKnfy0uIE7k5O2SZbCI580Q8gImtpGEYi5HWDC/ Bw== 
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by mx0b-001e9b01.pphosted.com with ESMTP id 30bapbakxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 14:21:15 -0400
Received: by mail-pl1-f198.google.com with SMTP id t9so658474plq.10
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magicleap.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fZfKoumGyhhUhnpNwaeOKlaokdakEYLl+yjOnNzfDuU=;
        b=ourVl67jKozOKoolrod7Y9uQdDWgHTTaTEH/KkTHbV6Y/dHW1i7oI92eRF32DP8nhK
         fJ4cIK6hodc50LQgxYD11GJBsjoJzC1ZUvtcAXQ80iXRF5CGt69KT2IttWIIr3eOPVMn
         m9jhKhNytrOs8ZXV85c4Lldjf15CljMyGN6to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZfKoumGyhhUhnpNwaeOKlaokdakEYLl+yjOnNzfDuU=;
        b=oie0chUk0OIaii0wefFS7qD/9UBQMhHZfDMH6BQsH2xnOVaEzKg6eSAZHOeNeYYjGd
         GHdc4dNJABqbSdJAvrNk0OnGCkC9ZNE9whyG/n6D0qRtJxmvzIk7ervq4DK98olbC0WF
         8aunR8PGZ0NIWiJA/CFEL2Y+GVHKgm6kFeH4l1E8pQfYpK00Q3xqkfBgwh/eVt+kt2pj
         EYAZ9nMVSIQWthlY/MaPOJlonYsVv2jPu+S0RGkKPzqviHhwmKh3cfl0YNYR9LdWzpaW
         bUvSK6od53pVZEWnlAi+Enf9gl49DoF4IBUm9KTMAWyzNAdD8ZmCLx7bW6hW4CotmPak
         jh/g==
X-Gm-Message-State: AGi0PubHFp8WgN4buI08T7uOCRBrSrvDdT56uGbDskDJg1ZRIm0ryM8P
        Q6TuIYMFFnoir/8DPkNdd6HDoj9vSSXqz4wh1WNb8Tvj9+6P/Lmj/a7eiiVw6UF7ma8LX55ACfG
        w1UbmR/1VfW1wwJubiQ==
X-Received: by 2002:a05:6102:2045:: with SMTP id q5mr1130714vsr.199.1586884733039;
        Tue, 14 Apr 2020 10:18:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypIzUBaNgEu+oJbBWhexZTjZs3dQq+q2GoyOOHnpP3bxuN2FK+3YXPf3Y/V/4cIg+xqVANNcFg==
X-Received: by 2002:a05:6102:2045:: with SMTP id q5mr1130697vsr.199.1586884732725;
        Tue, 14 Apr 2020 10:18:52 -0700 (PDT)
Received: from mldl2169.magicleap.ds ([162.246.139.210])
        by smtp.gmail.com with ESMTPSA id z79sm4252684vkd.35.2020.04.14.10.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:18:51 -0700 (PDT)
From:   svc_lmoiseichuk@magicleap.com
X-Google-Original-From: lmoiseichuk@magicleap.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: [PATCH v1 0/2] memcg, vmpressure: expose vmpressure controls
Date:   Tue, 14 Apr 2020 13:18:38 -0400
Message-Id: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_08:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=997 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140131
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

Small tweak to populate vmpressure parameters to userspace without
any built-in logic change.

The vmpressure is used actively (e.g. on Android) to track mm stress.
vmpressure parameters selected empiricaly quite long time ago and not
always suitable for modern memory configurations. Modern 8 GB devices
starts triggering medium threshold when about 3 GB memory not used,
and situation with 12 and 16 GB devices even worse.

Testing performed:

* Build kernel for x86-64 and aarch64 (Tegra X2 SoC)
* Booted and checked that all properties published
* Tuned settings and observed adequate response
* sysbench and memory bubble application (memsize from lmbench)
  used to verify reactions

Change Log:

  v1:

  => updated commit with 8 GB numbers per Michal Hocko request

  v0:

  => initial implementation
  => tested on x86-64 and aarch64

Leonid Moiseichuk (2):
  memcg, vmpressure: expose vmpressure controls
  memcg, vmpressure: expose vmpressure controls

 .../admin-guide/cgroup-v1/memory.rst          |  12 +-
 include/linux/vmpressure.h                    |  35 ++++++
 mm/memcontrol.c                               | 113 ++++++++++++++++++
 mm/vmpressure.c                               | 101 +++++++---------
 4 files changed, 200 insertions(+), 61 deletions(-)

-- 
2.17.1

