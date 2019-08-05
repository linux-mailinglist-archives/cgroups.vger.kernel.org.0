Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51808126A
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 08:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfHEGiM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 02:38:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46487 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfHEGiL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Aug 2019 02:38:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so36037995plz.13
        for <cgroups@vger.kernel.org>; Sun, 04 Aug 2019 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=c8VHeq19ya4NgPAfDdaqw+9aj+OFOs4WuaGxyy8ErMY=;
        b=OIeSnNO7cj0zewIOCmHFYjKvW+fx4JZINu923BjB0Hq/ubX+bwiftL7/216vqNXYB1
         Lvks5py6y2q6fGu/M7MagQ8j0/yj5L9KGlvU+Mibf3MLnOSONPXVuTIdfPrUM7z974aj
         /eVzeZ2pbGEtDq1N5I9ns4JjUvVzAwJ2GuM0Dp56b/MMHk55rwpC8sB9F58psHo3HV3f
         yiHG0YyHEFKQXZ6Lwpmr6OB9/t3xUkgMGy95WPvIGYYGwp00ReDgvYx+1hfgOoTkb4Hg
         HooskmgqWCHsPqVKWhVei8eC/pOEyaijR9Pk8/gclfLyAZkvoIiS+vIgNoO0O5tg/PcS
         4VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c8VHeq19ya4NgPAfDdaqw+9aj+OFOs4WuaGxyy8ErMY=;
        b=nRdBYCV42kU1OI/pTS4kpQxoqVV9WKq1Er6oL/aXBLIlm92z7pPX1lZ9uNtyrRGeM4
         yv2rimtx81WZe1YZrhBuhSZ9Td+bC1BXVu7tyfv8anoe4t7UZOI2pRxXJvTWjOzgZy35
         wqkcx4gIyDh92oFwgTdTDKQ3/KlJyia8vV69nHnnPZA3tnOsNu2vc6O2TaPrloMrt9De
         Nsz4RO9zV4pURsQ4IL1MaTl+aicsxhvWOZEwNiUqyROegFf3Nr2kvu2j4sYKTVgBhPL1
         Vz0OKKPsLWZTh/1BBZjVCJOQ+3LFI8JNqkMrI+h2SF8VKrlEcpZS0RGK+f5agGqD8Deo
         XKBg==
X-Gm-Message-State: APjAAAVHLBLbE09uxeRdm8h2pxrLbmob7hd+6O65olg4ZgPdby1oGiny
        AgHdTI/JRvbmgUnktcqzvPhp3Q==
X-Google-Smtp-Source: APXvYqzqL7SmIZkzv/9i2XMvJNac9FyB+DvqB1wnGifjnJX39xY3diG41KDD+0TGRZPyCyR1hnSZ+w==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr83120613plb.297.1564987090946;
        Sun, 04 Aug 2019 23:38:10 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id r18sm88580639pfg.77.2019.08.04.23.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:10 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 0/3] Implement BFQ per-device weight interface
Date:   Mon,  5 Aug 2019 14:38:04 +0800
Message-Id: <20190805063807.9494-1-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(Revision starting from v2 since v1 was used off-list)

Hi Paolo and others,

This adds to BFQ the missing per-device weight interfaces:
blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
implementation pretty closely resembles what we had in CFQ and the parsing code
is basically reused.

Tests
=====

Using two cgroups and three block devices, having weights setup as:

Cgroup          test1           test2
============================================
default         100             500
sda             500             100
sdb             default         default
sdc             200             200

cgroup v1 runs
--------------

    sda.test1.out:   READ: bw=913MiB/s
    sda.test2.out:   READ: bw=183MiB/s

    sdb.test1.out:   READ: bw=213MiB/s
    sdb.test2.out:   READ: bw=1054MiB/s

    sdc.test1.out:   READ: bw=650MiB/s
    sdc.test2.out:   READ: bw=650MiB/s

cgroup v2 runs
--------------

    sda.test1.out:   READ: bw=915MiB/s
    sda.test2.out:   READ: bw=184MiB/s

    sdb.test1.out:   READ: bw=216MiB/s
    sdb.test2.out:   READ: bw=1069MiB/s

    sdc.test1.out:   READ: bw=621MiB/s
    sdc.test2.out:   READ: bw=622MiB/s

Fam Zheng (3):
  bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
  bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
  bfq: Add per-device weight

 block/bfq-cgroup.c  | 151 +++++++++++++++++++++++++++++++++++++++-------------
 block/bfq-iosched.h |   3 ++
 block/bfq-wf2q.c    |   2 +
 3 files changed, 119 insertions(+), 37 deletions(-)

-- 
2.11.0

