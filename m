Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB62548935A
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiAJIah (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 03:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiAJI31 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 03:29:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ECDC06173F;
        Mon, 10 Jan 2022 00:29:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e19so4505494plc.10;
        Mon, 10 Jan 2022 00:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZbHmoJTvhu1ZJHvYjVegih6S2199NdYzTfdyg0if26A=;
        b=HYBLvzRW8JYt51HdI/oGR7NhCjlv3HKUo+3R8MK/A2QmXDOpfeXDrE4OjEKm9hyr/f
         z5hX0nD3/ELjvCIWF3aW7LoLRpbBM3CKM9oC0yCAspprbuIglE0aPyjqcHkod9waOtca
         jACUuUUMU78auMMafwnfGwvnN7p3AZGIQrnJFXjhJgW9a6cjPA5f4TfMTLNcrk6/lSrj
         dBnOaXvOggkJTMyvlJqd2KtzgMZ/4mtVYVoAjFAQ2Bkc0sZySQB6oQ8/btLK5dPWlvZ/
         2ywGopmL+wwuf31otpzF9BsUiYay3Gy7Ib/XhmoOHpMu6jaer01guxfqSmTd4wrbNiol
         Fb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZbHmoJTvhu1ZJHvYjVegih6S2199NdYzTfdyg0if26A=;
        b=XJYzNoY+Hll/kDUaiu0k5hpRe02wTjkuHY31ds8cAxjyS1o7xpySXLT7tziRdnPn35
         8AQAD+je3MyrEWUboKu4hiA7BU8irG5tQ+2ljJYdaCC2cE0p7tM66jQE3YGSMwhKqbSs
         jd95kCOzVNgLAzTieXoJLCBW26QhhBG9RYsiX5IH2NkuDRF2L0QmFulU4BdOqKUFGNnJ
         40Dla8b0yTKLSBMboGsYPFcybk7UfCMI9l1EJhE5wuk0v4vC5xt8gF/JwBUi9L7/oCdz
         PHn/qtierI72qPvTIH+RDtgZOWccANnKxsBwiopM1JcQo7JvBvg3A04EkhzUWVnWq9km
         2rpw==
X-Gm-Message-State: AOAM532qaP3BsPLOsiJbPs/eEvpok8iZmEQokB+KNJYhWHU93jnJ8Grw
        0w0CH5Ri+TlUMNkXvsXYq0c=
X-Google-Smtp-Source: ABdhPJyU5uW0w9xPoxodl96z0xjfHCXHzkuF3m3FvUNE58KKuxPvBJMw0Qwd4L1dVj5i44JThwNdrw==
X-Received: by 2002:a17:902:a601:b0:148:adf2:9725 with SMTP id u1-20020a170902a60100b00148adf29725mr74531784plq.136.1641803366161;
        Mon, 10 Jan 2022 00:29:26 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id h2sm6223356pfh.55.2022.01.10.00.29.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:29:25 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     ming.lei@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-throtl: avoid double charge of bio IOPS due to split
Date:   Mon, 10 Jan 2022 16:29:23 +0800
Message-Id: <1641803363-27550-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

After commit 900e08075202("block: move queue enter logic into
blk_mq_submit_bio()"), submit_bio_checks() moved to __submit_bio_fops()
and blk_mq_submit_bio(). The IOs go through blk_mq_submit_bio()
may be splited before entering blk-throtl, so we need to check
whether the BIO is throttled, and only update the io_split_cnt
for the THROTTLED bio to avoid double charge.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-throttle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 39bb6e6..2b12fc7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2049,6 +2049,9 @@ void blk_throtl_charge_bio_split(struct bio *bio)
 	struct throtl_service_queue *parent_sq;
 	bool rw = bio_data_dir(bio);
 
+	if (!bio_flagged(bio, BIO_THROTTLED))
+		return;
+
 	do {
 		if (!parent->has_rules[rw])
 			break;
-- 
1.8.3.1

