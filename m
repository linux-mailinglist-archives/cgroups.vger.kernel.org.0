Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE7296644
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897301AbgJVU6u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 16:58:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48200 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897292AbgJVU6t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 16:58:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C68D41F45E92
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/2] Fixes to blkg_conf_prep
Date:   Thu, 22 Oct 2020 16:58:40 -0400
Message-Id: <20201022205842.1739739-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

In addition to addressing your comments the previously submitted fix to
pre-allocate the radix node on blkg_conf_prep, this series fixes a small
memleak on the same function.

Gabriel Krisman Bertazi (2):
  blk-cgroup: Fix memleak on error path
  blk-cgroup: Pre-allocate tree node on blkg_conf_prep

 block/blk-cgroup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.28.0

