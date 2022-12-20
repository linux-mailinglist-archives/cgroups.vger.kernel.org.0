Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA876527C2
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiLTUU2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 15:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiLTUUA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 15:20:00 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FB1FCE2;
        Tue, 20 Dec 2022 12:18:34 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:dc8b:b602:9bcd:3004])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 7B28D780350;
        Tue, 20 Dec 2022 21:18:23 +0100 (CET)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH] blk-iocost: don't make all constants unsigned long long
Date:   Tue, 20 Dec 2022 21:18:19 +0100
Message-Id: <20221220201819.1497577-1-ydroneaud@opteya.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

My shiny new compiler (GCC 13) is reporting the following
warnings:

  ../block/blk-iocost.c: In function 'ioc_weight_prfill':
  ../block/blk-iocost.c:3035:37: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
   3035 |                 seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
        |                                    ~^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                                     |                             |
        |                                     unsigned int                  long unsigned int
        |                                    %lu
  ../block/blk-iocost.c: In function 'ioc_weight_show':
  ../block/blk-iocost.c:3045:34: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
   3045 |         seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
        |                                 ~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                                  |                      |
        |                                  unsigned int           long unsigned int
        |                                 %lu

It appears WEIGHT_ONE enum is unnecessarly unsigned long
(or unsigned long long on 32bit) because of VTIME_PER_SEC
and/or AUTOP_CYCLE_NSEC need the enum to be that large.

Addressed by lazy splitting the "catch all" anonymous
enum and placing the unsigned long long constants in
their own anonymous enums.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 block/blk-iocost.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 495396425bad..bb1f8522c0f1 100644
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
@@ -255,7 +257,9 @@ enum {
 
 	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
 	VRATE_CLAMP_ADJ_PCT	= 4,
+};
 
+enum {
 	/* if IOs end up waiting for requests, issue less */
 	RQ_WAIT_BUSY_PCT	= 5,
 
@@ -293,10 +297,14 @@ enum {
 
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
+};
 
+enum {
 	/* switch iff the conditions are met for longer than this */
 	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
+};
 
+enum {
 	/*
 	 * Count IO size in 4k pages.  The 12bit shift helps keeping
 	 * size-proportional components of cost calculation in closer
-- 
2.37.2

