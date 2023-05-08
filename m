Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428EA6FA645
	for <lists+cgroups@lfdr.de>; Mon,  8 May 2023 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjEHKSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjEHKRx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 06:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516DED2F9;
        Mon,  8 May 2023 03:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A7C624A0;
        Mon,  8 May 2023 10:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB9FC433EF;
        Mon,  8 May 2023 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541066;
        bh=3g1ezkSeNovKyNA/mYRnkKvsFp4NaVHgDIm4yL0ohA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nH9cQ5102anxDuDoNNzcs1IoG+7edNzXyKetIcXZkn58VZhjC/8vBZH0pOD1NjCzI
         EzuTJ1KRo2se7XX1NFRJ5Hqts8Sd6fLlaoHh7sjJUFMGENeNinmHMwcOBtHViTWcog
         C+zC2COBbnyMkrdFrKGo5uwnNiQEa7XCrx2YjSDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Liska <mliska@suse.cz>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6.1 604/611] block/blk-iocost (gcc13): keep large values in a new enum
Date:   Mon,  8 May 2023 11:47:26 +0200
Message-Id: <20230508094441.528448895@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

commit ff1cc97b1f4c10db224f276d9615b22835b8c424 upstream.

Since gcc13, each member of an enum has the same type as the enum [1]. And
that is inherited from its members. Provided:
  VTIME_PER_SEC_SHIFT     = 37,
  VTIME_PER_SEC           = 1LLU << VTIME_PER_SEC_SHIFT,
  ...
  AUTOP_CYCLE_NSEC        = 10LLU * NSEC_PER_SEC,
the named type is unsigned long.

This generates warnings with gcc-13:
  block/blk-iocost.c: In function 'ioc_weight_prfill':
  block/blk-iocost.c:3037:37: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int'

  block/blk-iocost.c: In function 'ioc_weight_show':
  block/blk-iocost.c:3047:34: error: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int'

So split the anonymous enum with large values to a separate enum, so
that they don't affect other members.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

Cc: Martin Liska <mliska@suse.cz>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org
Cc: linux-block@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20221213120826.17446-1-jirislaby@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-iocost.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -232,7 +232,9 @@ enum {
 
 	/* 1/64k is granular enough and can easily be handled w/ u32 */
 	WEIGHT_ONE		= 1 << 16,
+};
 
+enum {
 	/*
 	 * As vtime is used to calculate the cost of each IO, it needs to
 	 * be fairly high precision.  For example, it should be able to


