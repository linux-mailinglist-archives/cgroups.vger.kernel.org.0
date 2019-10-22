Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD255E0D29
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbfJVUPW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 16:15:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38159 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfJVUPW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 16:15:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id p4so17575255qkf.5
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6k43Ins8ShDUccC1LdBvMXrfhZMN86K2kUQuaiv7Mo=;
        b=G6GQH0AR0jPSft2ppe6Krr/rZ5GlNjjcDjh8uq21Mch7IOkfMJPJ6y8CGYHqjeZnRv
         Z82dyGlkUmpnrQUBDNlEbomTWJFZjTonGAtP+KWs1/C1lYr5lpWixX5fS4x8g1/pnjaI
         l+2sZb8+h8PVY95WqVGA2Z3wHkTZ5GJmzwN6p8slt1PJfa3X9acHSQ9TwJh6O9hoz8yK
         QoDS9inHtGfOdYETaFcmImy68omaIjrSwXUv00ynL3dDOGxlMHQeZN4xH1DKUj15Seb/
         4B+CZLYcbnEkE5LYhr+FWPasz/NfM9n5wmSZzFIvbKNULO+4fsvtj9SnmUeuv1klLi0C
         eunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6k43Ins8ShDUccC1LdBvMXrfhZMN86K2kUQuaiv7Mo=;
        b=Fvt72EEyL9lAA4YUBTVest2XyYrNdCnm0mVcj59D27UWTaSLx4p9yE88fP4KhslARt
         ETiF3otIbnFmrAOli7E7Flc+SiF6gDZP0855Q6ScrAURPPhT/OUF15e733lo0ipQCWs5
         hwQC3ZXAjZCD2nzALufHmYH9UdohKGjnDghdhp4h7lK9FoqcZNLh/QGmMmGojGasy9GG
         Oz/SljWXU4b4vugnuGkcYunRiEpOT/gDA+ZuCphGYQFjU9DsyoDpGAgONQQFfgDrixUy
         3EwGXovxZr3nYD+KHqCH+zxYkcjkEfEFlxIFuzmC3ohJ6H/y/h6eUWtihdfr9hP7elEm
         HvWA==
X-Gm-Message-State: APjAAAX5saTDidxDCZ2260rKhw6tJBa+9et1UVKsUTUVITF7zwV2BtIg
        ew+iw1n9v4+pH6Ggyzq/2UqRDd8HLnA=
X-Google-Smtp-Source: APXvYqwf83Q3oMgxGQXXVkIgEXOw8vw6FhbO2OSQt0mKSX9kQGxr6dmirL8tHiP1nzutNQLLmqtnhw==
X-Received: by 2002:a37:f70f:: with SMTP id q15mr4521717qkj.428.1571775319334;
        Tue, 22 Oct 2019 13:15:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id d205sm11273855qke.96.2019.10.22.13.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:15:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] mm: memcontrol: remove dead code from memory_max_write()
Date:   Tue, 22 Oct 2019 16:15:17 -0400
Message-Id: <20191022201518.341216-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the reclaim loop in memory_max_write() is ^C'd or similar, we set
err to -EINTR. But we don't return err. Once the limit is set, we
always return success (nbytes). Delete the dead code.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 055975b0b3a3..ff90d4e7df37 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6122,10 +6122,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		if (nr_pages <= max)
 			break;
 
-		if (signal_pending(current)) {
-			err = -EINTR;
+		if (signal_pending(current))
 			break;
-		}
 
 		if (!drained) {
 			drain_all_stock(memcg);
-- 
2.23.0

