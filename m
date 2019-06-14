Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FDF45A23
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFNKOT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 06:14:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:58851 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfFNKOT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 14 Jun 2019 06:14:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 03:14:17 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2019 03:14:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hbjDt-0008pU-HR; Fri, 14 Jun 2019 18:14:17 +0800
Date:   Fri, 14 Jun 2019 18:13:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@01.org, cgroups@vger.kernel.org
Subject: [RFC PATCH cgroup] blkcg: iowg_to_blkg() can be static
Message-ID: <20190614101349.GA28205@lkp-kbuild02>
References: <201906141828.vHqYOehI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906141828.vHqYOehI%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Fixes: 3ddd9fc7fba6 ("blkcg: implement blk-ioweight")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 blk-ioweight.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-ioweight.c b/block/blk-ioweight.c
index d10249f..43a6fec 100644
--- a/block/blk-ioweight.c
+++ b/block/blk-ioweight.c
@@ -611,7 +611,7 @@ static struct iow_gq *blkg_to_iowg(struct blkcg_gq *blkg)
 	return pd_to_iowg(blkg_to_pd(blkg, &blkcg_policy_iow));
 }
 
-struct blkcg_gq *iowg_to_blkg(struct iow_gq *iowg)
+static struct blkcg_gq *iowg_to_blkg(struct iow_gq *iowg)
 {
 	return pd_to_blkg(&iowg->pd);
 }
@@ -2229,8 +2229,8 @@ static const match_table_t i_lcoef_tokens = {
 	{ NR_I_LCOEFS,		NULL		},
 };
 
-ssize_t iow_cost_model_write(struct kernfs_open_file *of, char *input,
-			     size_t nbytes, loff_t off)
+static ssize_t iow_cost_model_write(struct kernfs_open_file *of, char *input,
+				    size_t nbytes, loff_t off)
 {
 	struct gendisk *disk;
 	struct iow *iow;
