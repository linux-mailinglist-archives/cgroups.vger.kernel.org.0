Return-Path: <cgroups+bounces-5861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F19EF603
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC4D17EA00
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E07D21E086;
	Thu, 12 Dec 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMAxf+2N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34712144C0;
	Thu, 12 Dec 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023619; cv=none; b=KtQgSuXXaA69l2QivACevPEdxGOWClDxQAvUR3NwfCLvZlgqx5pDrrnKLX6rAr44UN3c8RW+DV7ePRzS/nxtQzlPR0NndMuDudUEFkyQvl+8ocf/pcimwKVHc2+0l9EUP3AN68B5UnQOske5vq9h43AqpalaEtUBX6si1a00chY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023619; c=relaxed/simple;
	bh=kf4S/jdgQYOx7jCwcwrana0ZODUIAqThGt9H4Hm4324=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YV+u/GFuZ88rgTk1+n7hZCLAUypgo/k9m9UWtrVwJmL9HP9M1gRl2ckxjRAO/h+qoI4h55cGMrpZMrd9NMnYksOzV68FO4FgUZ+RDlKq4sTZMaPu8MKMJFNmkxza+X32mpjNKxaQatEZoFA+YmHIvV+amb3EiKCm/iApCDnxMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMAxf+2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954EAC4CECE;
	Thu, 12 Dec 2024 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023618;
	bh=kf4S/jdgQYOx7jCwcwrana0ZODUIAqThGt9H4Hm4324=;
	h=From:Date:Subject:To:Cc:From;
	b=IMAxf+2NXf6cOxfAjK2pBt6kSjL0ENFAac1a4rRl3X/RH6NFI1XMEpQOi5cuA/1f3
	 OJmfwfyMGIptlIzfwRCrMXliwnZ+iHMNqptzHupR4toYsCnco/iGtwDX5k9JfRJohV
	 yTnDklKp0SW/qLlQXIfUDe/L7H5b6QUtyED3TqhiojbAU1PHYDl7vmzdrPNM2Wqb53
	 VDjKg5TFvu69HFU/Rsbo6uEj6Vc0rVSZjsR/tw27d2tSud6BxEwi1oHihGxgOAtNzx
	 ckuySj9yYcAfVvfEaER5dqcK2pghWn3snvZk0W0zklnwDH8e5tJKd7OxDgbMC2UUFM
	 YKZ5cPxtWAcBw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 12 Dec 2024 10:13:29 -0700
Subject: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
X-B4-Tracking: v=1; b=H4sIALgZW2cC/x3MSwqAMAwA0atI1gZsUCleRVxojRr8VFIRQXp3i
 8sHw7wQWIUDNNkLyrcE8UeCyTNwS3/MjDImAxVUGjKEw7aieOfDhZM86LZ+P5FVvWJlTe0KsgO
 VFaTBqZySf952MX4dJ3UsbAAAAA==
X-Change-ID: 20241212-blk-iocost-fix-clamp-error-5816c028b245
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 David Laight <david.laight@aculab.com>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=nathan@kernel.org;
 h=from:subject:message-id; bh=kf4S/jdgQYOx7jCwcwrana0ZODUIAqThGt9H4Hm4324=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOnRkgeWXVvwy/7p05+M7BMiM6Rm8Lcelvq4+LrsrhNfT
 h/WODSPqaOEhUGMi0FWTJGl+rHqcUPDOWcZb5yaBDOHlQlkCAMXpwBM5M9nhh+7pHu5g1ekGE32
 /mT8tjMr+KnBuxNPy5advBz8OdpgQwzDP4XHOVcrqwKWT4t+EFa80esXS8smpXl55q1HGpwj9qm
 UcQMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change to clamp() and its variants [1] that increases the
coverage of the check that high is greater than low because it can be
done through inlining, certain build configurations (such as s390
defconfig) fail to build with clang with:

  block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit 1 greater than high limit active
   1101 |                 inuse = clamp_t(u32, inuse, 1, active);
        |                         ^
  include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
    218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
        |                                    ^
  include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
    195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
        |         ^
  include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
    188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
        |         ^

__propagate_weights() is called with an active value of zero in
ioc_check_iocgs(), which results in the high value being less than the
low value, which is undefined because the value returned depends on the
order of the comparisons.

The purpose of this expression is to ensure inuse is not more than
active and at least 1. This could be written more simply with a ternary
expression that uses min(inuse, active) as the condition so that the
value of that condition can be used if it is not zero and one if it is.
Do this conversion to resolve the error and add a comment to deter
people from turning this back into clamp().

Link: https://lore.kernel.org/r/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/ [1]
Suggested-by: David Laight <david.laight@aculab.com>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/llvm/CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412120322.3GfVe3vF-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 block/blk-iocost.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 384aa15e8260bd4d83b00f1c03efb87829950327..a5894ec9696e7e8c1011cbda1d849562e1732d31 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1098,7 +1098,14 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 		inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
 					   iocg->child_active_sum);
 	} else {
-		inuse = clamp_t(u32, inuse, 1, active);
+		/*
+		 * It may be tempting to turn this into a clamp expression with
+		 * a lower limit of 1 but active may be 0, which cannot be used
+		 * as an upper limit in that situation. This expression allows
+		 * active to clamp inuse unless it is 0, in which case inuse
+		 * becomes 1.
+		 */
+		inuse = min(inuse, active) ?: 1;
 	}
 
 	iocg->last_inuse = iocg->inuse;

---
base-commit: 3e42dc9229c5950e84b1ed705f94ed75ed208228
change-id: 20241212-blk-iocost-fix-clamp-error-5816c028b245

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


