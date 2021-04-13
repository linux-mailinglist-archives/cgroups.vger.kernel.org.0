Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2C35DA97
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDMJD3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhDMJD1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 05:03:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1825BC061756
        for <cgroups@vger.kernel.org>; Tue, 13 Apr 2021 02:03:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u20so18500684lja.13
        for <cgroups@vger.kernel.org>; Tue, 13 Apr 2021 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzM4K64HP+ENrA/kOG1Fm4dQKmRzcsmui7InMaV8aSU=;
        b=F4W7kx3mGrFdIG/6Akw+ma0TN0uhnUoqlb1MQJGLG0wOGyKksu0k4QGwYhmYEnD3F1
         HR0OfFx3pAagCxh1pitD+GIPOIcOBms5zp0uLTqNnNLxT2r9Abh8iWXu289sIJBoqNqU
         E54+BnBUAOgRUaG2awx7fcufOtsDhyjRqWI5h3qvBQwv2TQ7u6JJ1LgzBsaQrpRQDsKN
         gduXxMYNK8CsH5VQRmFdfXzApbwHl3w8ESQtAY6F55Uz9L0vDJxIaSggrhIDJNw3HuRr
         g/puRMRLWX3sep1bobm5LitZ4dMTz8/H2R4RS939BhZ9H76apYYKhEIHRF5NgB2wNE7e
         +oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzM4K64HP+ENrA/kOG1Fm4dQKmRzcsmui7InMaV8aSU=;
        b=sMDq4N+ZQpRTSyQD0qOojh7rXWX4B0Vy8k62/p+50ERXpcAjQRCnnRORjYzIR0id+7
         giqK628oCycu9CAPbKUzVWx74uxijRc/7qXIGvpAnV9hQX7onRjJtCxBaaxR47riJWN0
         ug2Rcbt4zQrRxsVFvynT+uOYQpzrho+tCLFqluIS/J9lUsp8QynJS3t7jwtiKUbY5smg
         PQpb2k6sDyYdOH9/KKX5zNmmfwMDMjjyhENxrNYPChVlYHxVOrSsoe8795aEJSJ+nKn7
         X7cxxv2/U8I2+ZtNKY4GtYPhOSrRUr6oMK1EVn829LnhfmLvsy/NjjCqFGbvENW3uPLk
         gFeg==
X-Gm-Message-State: AOAM532KSQJ16vJTSW6R0kUArDZsJ254Fnsh8DtjraRV0ToINN4TIqrk
        EATtsXuvDYnsE26swgD9aqm0Dg==
X-Google-Smtp-Source: ABdhPJyuv91KeVkfiGx1MTLefuNgkR6alNFYps9XsecESd9lxhNDuqBZZaIjvRSfFZzRAOCEWZSpRw==
X-Received: by 2002:a2e:5454:: with SMTP id y20mr4774430ljd.504.1618304585548;
        Tue, 13 Apr 2021 02:03:05 -0700 (PDT)
Received: from xps.wlan.ntnu.no ([2001:700:300:4008:3fb5:15ad:78ca:d9c1])
        by smtp.gmail.com with ESMTPSA id o11sm3722912ljg.42.2021.04.13.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:03:05 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     tj@kernel.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 0/2] Relax cpuset validation for cgroup v2
Date:   Tue, 13 Apr 2021 11:02:33 +0200
Message-Id: <20210413090235.1903026-1-odin@uged.al>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Two small validation relaxations for cgroup v2, making it easier to
manage the hierarchy without the current pain points. Both changes
work for both mems and cpus (but I have no NUMA machine to test mems).

Hopefully the patches has an ok description about what change they
provide, and why they are helpful.

Odin Ugedal (2):
  cgroup2: cpuset: Disable subset validation on set
  cgroup2: cpuset: Always allow setting empty cpuset

 kernel/cgroup/cpuset.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.31.0

