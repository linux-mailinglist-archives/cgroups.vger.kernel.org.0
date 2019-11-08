Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC91F58D8
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2019 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfKHUoV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Nov 2019 15:44:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34302 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHUoV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Nov 2019 15:44:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id c25so7341370qtq.1
        for <cgroups@vger.kernel.org>; Fri, 08 Nov 2019 12:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+x5g1UVg7HX2xGAQ0OJa7E0znsv6MEg8H6qRGEA46KQ=;
        b=rKeQu1ZisiH1z4nG/Spx3Hk5NI7OH7ghWVVE4sJnGjupBFTUb0/cXDmc9WqVGLNgsG
         9xiS6GWqUeOvlke3Xd8+2imV2vlrx4dxiG5s7/4la0ZDYNCrhcC084LahTpo0+lwN85G
         K5U6U0mLGthyDy/l6qk4yji+GJEmXY4OaFD527GpqiJy/F83NKDgRM6+NiD9xiaeOa2S
         JOTXb6/dyb+AcZipK9q1SMW/PGTQ+KV0XtGZB9Nfs/u/0wSc+Sl7Bg1VfBkVE16Qtp7O
         saY+Ml0JLyAYbZiW/eX2UOIVkAcpv2AQ0O+WSAzhRvqUjpyNVq9oJR6OUGdkXzeWlk7w
         eYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+x5g1UVg7HX2xGAQ0OJa7E0znsv6MEg8H6qRGEA46KQ=;
        b=CuxNBxBvUvkskJsCehO5wp7Caf0oFxeaiEBEMaLNolbbOKU/5jDdIV4pZuOPg6tfrf
         cqf1pHpTkSHFphXghvzxBXXTXqJ6yPNKJ1zez04YtleAEIveIEF+Dr/TbsA9PwbyTlwd
         CdN+FOE8tLnidmCmMml5+71Afod56og/MF7Mr7aupZTab2x3FTjESUf0b0jR5ts3g6cL
         WfcWj51D2mkbdV7V1rWP9J8nlfj1bP4VwltAFhFiCT8FJoBR93+ioQr7CJlgMK2fbUmJ
         qIn0lVRw5V45HkXbff5/51kTRKCNLhoK40kEjSN3AbCM7r/F3aJFAWkJx/o3aWgVg5d/
         abKA==
X-Gm-Message-State: APjAAAVNyym2ZQwpG1vGdeE2ZVDr7Uhqtj3DjZGM6dWObpttuTwFMDO4
        MyIAcoaLnHX2AwCRyyG5T4hZkg==
X-Google-Smtp-Source: APXvYqw//vDNtVmESgIvld+GVVJAa8OFASSIYuyNEbIaC229uB5fxFRo2kZDfigEVv3+zsL1IKATgw==
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr13159952qta.374.1573245858287;
        Fri, 08 Nov 2019 12:44:18 -0800 (PST)
Received: from ovpn-124-239.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s75sm3602579qke.14.2019.11.08.12.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:44:17 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, hannes@cmpxchg.org, guro@fb.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Date:   Fri,  8 Nov 2019 15:44:07 -0500
Message-Id: <20191108204407.1435-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The -next commit "mm: vmscan: simplify lruvec_lru_size()" [1] introduced
an undefined behavior as zone_idx could equal to MAX_NR_ZONES, and then
zid is then out of range.

[ 5399.483257] LTP: starting mtest01w (mtest01 -p80 -w)
[ 5400.245051] ================================================================================
[ 5400.255784] UBSAN: Undefined behaviour in ./include/linux/memcontrol.h:536:26
[ 5400.265235] index 5 is out of range for type 'long unsigned int [5][5]'
[ 5400.273925] CPU: 28 PID: 455 Comm: kswapd7 Tainted: G        W         5.4.0-rc6-next-20191108 #3
[ 5400.285461] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
[ 5400.295784] Call Trace:
[ 5400.299483]  dump_stack+0x7a/0xaa
[ 5400.304052]  ubsan_epilogue+0x9/0x26
[ 5400.309180]  __ubsan_handle_out_of_bounds.cold.13+0x2b/0x36
[ 5400.316192]  inactive_list_is_low+0x8bb/0x9f0
[ 5400.321952]  balance_pgdat+0x252/0x7d0
[ 5400.327006]  kswapd+0x251/0x590
[ 5400.331725]  ? finish_wait+0x90/0x90
[ 5400.336574]  kthread+0x12a/0x140
[ 5400.341102]  ? balance_pgdat+0x7d0/0x7d0
[ 5400.346330]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 5400.352810]  ret_from_fork+0x27/0x50

[1] https://lore.kernel.org/linux-mm/20191022144803.302233-2-hannes@cmpxchg.org/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d97985262dda..9485b80d6b5b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -317,7 +317,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 	unsigned long size = 0;
 	int zid;
 
-	for (zid = 0; zid <= zone_idx; zid++) {
+	for (zid = 0; zid < zone_idx; zid++) {
 		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
 
 		if (!managed_zone(zone))
-- 
2.21.0 (Apple Git-122.2)

