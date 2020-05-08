Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC411CBA4B
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHWAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHWAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 18:00:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9FC061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 15:00:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so2129102wml.2
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HJaSGZ1p1+2gTGleg/polxs+Iy4GGrNGzSb8aVDGzrQ=;
        b=IaPO7e8heLcfhT9bkoaHzPo555GzJw1+LYpUUo0zXxp4egYkIo8uKH2hJ12Gf60np7
         6ThjNHhMdYtWeGtQ+yVnic8OSNXCdGjK1zQbTpFLQTCWUwFjUVW+F9PW+u3ohqNYIVDv
         4ryJk5yYm5OV9PVscfngBf44Qc+EJWGxjQI4lgGJ5f0Tf+UlZs3H+iK1ZX4x0ZO0ghfE
         dcmCNmAKY5bQs3/rA/aOm8iIOQ67grMUEvIYLLFIO2VnxdUs2VL7ERL+yM6M7YZo8KwA
         AuByX002gvPWVYrIud5jWNMQbrHgHcvgTMKrg0tvYmEfqaMjftdBCj11iZVHhw+zemO4
         +GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HJaSGZ1p1+2gTGleg/polxs+Iy4GGrNGzSb8aVDGzrQ=;
        b=dPEuO76roELvLbKYkSVzIQGAT6k/GLNKCtTBLZC3SJsp9Qb9iNoyHmbk2ipYfDkO3W
         N+4axI8RkBx17R2C4HyIrTPnGDLzMCe/N1sxeD9+gYcu5CwqULtSRw3bUuMkEZtEqfdk
         lpxkturcUH/YD76n9JqotGCln5WQ2a52yzGtXdBrDHfFQi5XY3MQkm1TvfsWXz0NN3uT
         2wg9J1jtFJhfV/oj3jt3vIafR6m4aI7KAOnyYnqZGY2L6r0F4rJ1rE5QaPCPoI9yLCX5
         VwNbaTJGaZk4vUqf1FsdOzilmgYY3+X765xobL7Z0a8kW0EkZ8/lZrTChxOonf/fIGZS
         851Q==
X-Gm-Message-State: AGi0PuYjEGWS62YWWjFTxAB8p0KF2P2QeAG5zLCKNpwGZafqQkOYmPnE
        9X//Nw5md5OOkTQXLsLv1JMKiw==
X-Google-Smtp-Source: APiQypJLnh6LtTckOQfEbPKkVnV4ntXLy1KkxIyL4FBqg3edpvuCqixk6f15YHj2QiF0QmhrVzmjuA==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr19492194wmg.65.1588975219937;
        Fri, 08 May 2020 15:00:19 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:19 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/4] cleanup for blk-wbt and blk-throttle
Date:   Sat,  9 May 2020 00:00:11 +0200
Message-Id: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Find some functions can be removed since there is no caller of them when
read the code.

Thanks,
Guoqing   

Guoqing Jiang (4):
  blk-throttle: remove blk_throtl_drain
  blk-throttle: remove tg_drain_bios
  blk-wbt: remove wbt_update_limits
  blk-wbt: rename __wbt_update_limits to wbt_update_limits

 block/blk-throttle.c | 63 --------------------------------------------
 block/blk-wbt.c      | 16 +++--------
 block/blk-wbt.h      |  4 ---
 block/blk.h          |  2 --
 4 files changed, 4 insertions(+), 81 deletions(-)

-- 
2.17.1

