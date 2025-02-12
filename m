Return-Path: <cgroups+bounces-6515-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D055A32124
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 09:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BA53A1F4F
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1327204F81;
	Wed, 12 Feb 2025 08:32:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D91DED5F;
	Wed, 12 Feb 2025 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349152; cv=none; b=grSQeJZvJsLTGgbzBGcQrX47sWt33SZu0zfVBpgZcbNH8bnhQSyA/epFXlyJbUTvI0EuNiin2GnZmucWthaAY6Mkltzkxw2UYnjPSDqBmu9cEB8KoGAz/DCdDwN7vkW1h1JCkmcV7DyfNH01eSRrpBPnimSREQGOOL2aiDaoXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349152; c=relaxed/simple;
	bh=M6WO1IkI0Q7T3bIAJj97I6HVMTsXJ9vlKr3NrrCq6kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4GXorLIVfx9U7ey0u28jPyJ0BD76M6t5yN4izdOC8El/0eTd4mB0tSRrQz7FJtTEqZ6bi3OxqY9AwNMDRADaDFZwt70kT/WYbrk0C0ziEyf8CU1yjPyllhdT+HOd7/6XFkQgJaB5HMSLwz1ZZNxGU3GyXVv9r3qn0caavdXy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAnkMmUXKxnuhRoDA--.44357S2;
	Wed, 12 Feb 2025 16:32:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] block: Check blkg_to_lat return value to avoid NULL dereference
Date: Wed, 12 Feb 2025 16:32:03 +0800
Message-ID: <20250212083203.1030-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnkMmUXKxnuhRoDA--.44357S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWDZrykZry8JF4DXF1xGrg_yoW8XF1rpa
	18urZFvay5Gw47XF18Ka1rCryrCr4UKFyUCFZ5Aa4FkF1IgF4rtF10vF10yFWrAFWUCrs8
	Jr1UtFZYvr45C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMqcUUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAULA2esWj4JCwAAss

The function blkg_to_lat() may return NULL if the blkg is not associated
with an iolatency group. In iolatency_set_min_lat_nsec() and
iolatency_pd_init(), the return values are not checked, leading to
potential NULL pointer dereferences.

This patch adds checks for the return values of blkg_to_lat and let it
returns early if it is NULL, preventing the NULL pointer dereference.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/blk-iolatency.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ebb522788d97..398f0a1747c4 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -787,6 +787,8 @@ static int blk_iolatency_init(struct gendisk *disk)
 static void iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
 {
 	struct iolatency_grp *iolat = blkg_to_lat(blkg);
+	if (!iolat)
+		return;
 	struct blk_iolatency *blkiolat = iolat->blkiolat;
 	u64 oldval = iolat->min_lat_nsec;
 
@@ -1013,6 +1015,8 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	 */
 	if (blkg->parent && blkg_to_pd(blkg->parent, &blkcg_policy_iolatency)) {
 		struct iolatency_grp *parent = blkg_to_lat(blkg->parent);
+		if (!parent)
+			return;
 		atomic_set(&iolat->scale_cookie,
 			   atomic_read(&parent->child_lat.scale_cookie));
 	} else {
-- 
2.42.0.windows.2


