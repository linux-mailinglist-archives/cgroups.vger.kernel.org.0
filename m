Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5403A3A1C
	for <lists+cgroups@lfdr.de>; Fri, 11 Jun 2021 05:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFKDJv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 23:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhFKDJu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 23:09:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F63C0617AD;
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id n12so1290272pgs.13;
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cww4YAD4W8e5YtVsLar88kpQ76E3chRpXf1PGNQpk6o=;
        b=CKh9czTQUO98TR4VM0uad4kJNDB2x3J1rSXbP6I44BFYVmJ6GmxdfInEAcbD4BpPOX
         582qg9ZY1jJ6wjehaPMUgl2e5RXTiBwg2Q9oREu6xzi16d9WJTGJZaeZCIa38rsWU4w4
         utJEeCOEX2O0+Kd4iRyO7/vy9auXrQOxKSOnGF5+kyMiaGxe48DS+zAk0pmZbdXavPfN
         Fi2k0UlNBT8HqJu8T0/JoVrY4HPiWp42Wz/qtUZ/N6bcauusj5gYb0YuhVxUhGf9VCDX
         IrZljKbEq/gay+39QXhstMBVlPNIVpKBpZGgTYin/BMHz2m3JPd3iagprl1p831bC3yc
         U8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cww4YAD4W8e5YtVsLar88kpQ76E3chRpXf1PGNQpk6o=;
        b=LOQSJkuVU0FPzuRMVG/MFVGIVyhpcSxtmjrQxH14ZvR2rSdQ17Qlmj2u1CtXlQOLUu
         5CHYd12Ob6Ct5BtbU0+BFdUXd/9kb0DlB+86a0wIJLGRMmCdk7Qwz8605CqsXzFBLehF
         8Op/wPv5fmoOnaeVCbprVqw9Vdyn8gHMoqD0jY5jVrAW0wUmUCAn/HHB1psLWq+N1399
         eTAE5jZyPSQAa8w12XLpidqs8mkIm8x7zp6xT3/ikK1BpPPUXc9ryW5wrVeu7xJv6ssL
         f/fRqCmAq3cq31LEtc5uKAbjTMMgxhVa2WCUNp+nzNZQQhEprs4AfKoolyQcPBje5DFp
         SyYA==
X-Gm-Message-State: AOAM533Gd39nURlP8NdNZh0AOwj937GsNQ7CbKIUoxrwyhQ6tXJLDghZ
        JjXruWxwGQ3xPIi0T+7Yyl/S6Mudqj+LDw==
X-Google-Smtp-Source: ABdhPJy9/Pdgs6aaraNzkW4nMF2MydCn+C/5NccebOlL6iiLq7UONo5Baog4APKzANDauh7vAcjfkw==
X-Received: by 2002:a63:f13:: with SMTP id e19mr1444328pgl.112.1623380861398;
        Thu, 10 Jun 2021 20:07:41 -0700 (PDT)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id q2sm3774319pje.50.2021.06.10.20.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:07:40 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 0/3] add/update/fix BFQ docs
Date:   Thu, 10 Jun 2021 20:07:34 -0700
Message-Id: <20210611030737.1984343-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Improve BFQ docs: fix formatting, adding a missing piece.

Fix cgroup v1 blkio docs which are not updated for CFQ -> BFQ.

Patches are on top of the latest docs-next (commit acda97acb2e98c97895).

Kir Kolyshkin (3):
  docs: block/bfq: describe per-device weight
  docs/cgroup-v1/blkio: stop abusing itemized list
  docs/cgroup-v1/blkio: update for 5.x kernels

 .../cgroup-v1/blkio-controller.rst            | 155 +++++++++---------
 Documentation/block/bfq-iosched.rst           |  38 +++--
 2 files changed, 107 insertions(+), 86 deletions(-)

-- 
2.31.1

