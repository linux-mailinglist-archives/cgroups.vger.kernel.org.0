Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5E1A6F0F
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbgDMWYo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 18:24:44 -0400
Received: from mx0a-001e9b01.pphosted.com ([148.163.157.123]:5884 "EHLO
        mx0a-001e9b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389528AbgDMWYn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 18:24:43 -0400
Received: from pps.filterd (m0176108.ppops.net [127.0.0.1])
        by mx0a-001e9b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03DLtDRR017369
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 17:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=magicleap.com; h=from : to : cc :
 subject : date : message-id; s=pp09042018;
 bh=ULBffSSWiOkyC0UR59o7WDkKeU3p81EFjrY635dhS+U=;
 b=f3l7rFKUzkcoM6KQGgSHmVZAnhe+VEgmqVy8P01gzUxXpL0G+NXbe/XkGqleHPFiixKV
 TlG93I2LrH/G50XHWYew5i6AdBfLnn/UGJT+S7/Lcbl0RGgqvbsLgUpvSXKuLGcCD2ke
 EHtw38bz/CTf5A16HfMnE1dvMYM0zOjWKUgJOPtXg7CwB2j9+r8pGdRKoE92yOnLzP5d
 GYXNr6BxD82wIEM6k24soPhE7u0N7gfeiZHFlKr7iNBfAPt5sd/iCN595/zzxwMUI4kW
 ZEDycoNnI+LC+t0wIB1OgDJUrLVdQscEH5e/sv3/P5oNAvbKKeMilD4oYS1G7OmvkEn6 0g== 
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
        by mx0a-001e9b01.pphosted.com with ESMTP id 30b7xqhuh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 17:58:16 -0400
Received: by mail-vk1-f200.google.com with SMTP id q136so5057501vkq.6
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magicleap.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ULBffSSWiOkyC0UR59o7WDkKeU3p81EFjrY635dhS+U=;
        b=ph7XMJp0u7u47D42UuMsJEZo++sq1SAbd5hRXfZm9Ps9o3lAWcIxA//cc06JvLdvwD
         b/E+KO4wT1LoNQEZwQriMNexQ1kyJBtVgSr+DVf7Auy4GmYerSyxUCFnVE/dNm4Sb7wy
         xBeHz8K1IG5SP1hfUz4D0vI77KEpmBbo6BZb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ULBffSSWiOkyC0UR59o7WDkKeU3p81EFjrY635dhS+U=;
        b=Tgo7+M41pybjT0aLAqbsW2COf0v/Sw9xWiohbTy7m/zXqwTlwdEs7GsbKmD6G7XDR7
         6l/SU8Wftj+wT4K8xm5o2LMRkbBYLZrYfQCiEVLADHSnTgWyl6NkJ95WCrM4mFSO1tEU
         DwG8GM/AvfChhK8eeTKMiX5aLi4iitY1ILePetDKeQFGknYH4eRC4R6TTzLKFi1P/CSj
         L7zcYYPAUwE9Bl52VLiawXQfi9oQRq0jEU3rteXXPzagt//BXAZDem9xY3cqHyX2U2U1
         aug9+khV4qJW3b3qQJkNA5Utn4QRAlk3B6oqcfkvudoYtOEMah4rEnSILSMTtITb59ly
         UjbA==
X-Gm-Message-State: AGi0PuY+81vD9psM0DMpKLHQRzhxv0IAzqKU6+1p1t4jnbd8R3BlFVtp
        Gusp7/srpe8/SRirK9SSyhDOtArXcTJswGEvbd1Tw6d8066Ea38dWZa5zI+6hbpiT5MNXVXIDUJ
        Pih4sYml9gg3HDIBKrQ==
X-Received: by 2002:a67:6a41:: with SMTP id f62mr4523372vsc.53.1586815095384;
        Mon, 13 Apr 2020 14:58:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypL8zQdCzsDsun22hrzwlsdYnH9ozrBJS0zSpjEgE8LiesK7yGn0a26frHSr7541sEDE84eu8g==
X-Received: by 2002:a67:6a41:: with SMTP id f62mr4523361vsc.53.1586815095215;
        Mon, 13 Apr 2020 14:58:15 -0700 (PDT)
Received: from mldl2169.magicleap.ds ([162.246.139.210])
        by smtp.gmail.com with ESMTPSA id 20sm2988529uaj.13.2020.04.13.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:58:14 -0700 (PDT)
From:   svc_lmoiseichuk@magicleap.com
X-Google-Original-From: lmoiseichuk@magicleap.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        anton.vorontsov@linaro.org, penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: [PATCH 0/2] memcg, vmpressure: expose vmpressure controls
Date:   Mon, 13 Apr 2020 17:57:48 -0400
Message-Id: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=739
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130160
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

Small tweak to populate vmpressure parameters to userspace without
any built-in logic change.

The vmpressure is used actively (e.g. on Android) to track mm stress.
vmpressure parameters selected empiricaly quite long time ago and not
always suitable for modern memory configurations.

Leonid Moiseichuk (2):
  memcg: expose vmpressure knobs
  memcg, vmpressure: expose vmpressure controls

 .../admin-guide/cgroup-v1/memory.rst          |  12 +-
 include/linux/vmpressure.h                    |  35 ++++++
 mm/memcontrol.c                               | 113 ++++++++++++++++++
 mm/vmpressure.c                               | 101 +++++++---------
 4 files changed, 200 insertions(+), 61 deletions(-)

-- 
2.17.1

