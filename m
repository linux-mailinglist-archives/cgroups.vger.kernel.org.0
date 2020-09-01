Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A761F259E81
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgIASyS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731867AbgIASyC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F30C061244;
        Tue,  1 Sep 2020 11:54:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f2so2008970qkh.3;
        Tue, 01 Sep 2020 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGd+L4+CkY8CX0oqEN26vP4g80+Fyvx1ej68utXe9eU=;
        b=ev7eg3EzJbXpbqkUt0lt7tPqxrWvM49cng+IcVXF/RxITjxvPt9frEoVle9Dm8HVvR
         WJ6m+rPTklgKM6eUGAYXkR+kU0RSykq/51LEy/BipmfpyUbB00Q/EEhDity8wyseFhN+
         VkH5Svpq1Gu0Tio1IZpfn7yPc5fB1JVtzOxaw7VMg7Y4iibIwXrx4RfS3hKF7rOI7pFI
         D3v2+5d1IuYuXuO1wujQtLYnJxbngTbMwmu0xPOD466mOP0eu1cdeKD93J2vVKD3oNHT
         OfyQQDl3EMiUHF1YaJjfH76tCV9QPGZYJ4b0Tl47VkjJBq2qizVhnRP67q8NqHNP0Brd
         g6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jGd+L4+CkY8CX0oqEN26vP4g80+Fyvx1ej68utXe9eU=;
        b=lmOFXBw+C7irWfE7T/e+fYOogxc483Xs4C28UYEm1DXuPqQRk+SDbQNt+a9UATDm4u
         y6cG/1aVwDkknnnYpa84A55PwVPSwaEubTIveghlb0PueilvOisOmFJORIztYYE60uAT
         6AxGESRtxYmNNlaVZlLso4ifPEM1YSLWbgReP2UUzhoTC1nUTWtFWfHEDj15dW23s6MH
         p7MpiYPIB51wKMDXJvmff5hejzI2CAfLvE0Sd/F7yaq8aG92zDSol731RlgU+ydzcSfw
         nivvQZmOsikAYVGw9kIQpTnNjxL0fY2qp04F0Jl8yNiBkKOtOgHwg6qEItYOWBSzVQe1
         nWMQ==
X-Gm-Message-State: AOAM531hHWVK42gF7amabERfLcYft5pyeCEdl+TLDb+uAOBjCpY3+Ttl
        mNQeSWZUyQwbu0pwXxFIDKg=
X-Google-Smtp-Source: ABdhPJz0FYHxtYz1RIlzqJCDxI7tk17SYzcBe+F3uolKbJ7xCAv8goMCyA6Gg//S8Tw+iH/N3/WwIw==
X-Received: by 2002:a37:5fc6:: with SMTP id t189mr3003354qkb.78.1598986439743;
        Tue, 01 Sep 2020 11:53:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id d9sm2585814qtg.51.2020.09.01.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:59 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/27] blk-iocost: implement Andy's method for donation weight updates
Date:   Tue,  1 Sep 2020 14:52:48 -0400
Message-Id: <20200901185257.645114-19-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

iocost implements work conservation by reducing iocg->inuse and propagating
the adjustment upwards proportionally. However, while I knew the target
absolute hierarchical proportion - adjusted hweight_inuse, I couldn't figure
out how to determine the iocg->inuse adjustment to achieve that and
approximated the adjustment by scaling iocg->inuse using the proportion of
the needed hweight_inuse changes.

When nested, these scalings aren't accurate even when adjusting a single
node as the donating node also receives the benefit of the donated portion.
When multiple nodes are donating as they often do, they can be wildly wrong.

iocost employed various safety nets to combat the inaccuracies. There are
ample buffers in determining how much to donate, the adjustments are
conservative and gradual. While it can achieve a reasonable level of work
conservation in simple scenarios, the inaccuracies can easily add up leading
to significant loss of total work. This in turn makes it difficult to
closely cap vrate as vrate adjustment is needed to compensate for the loss
of work. The combination of inaccurate donation calculations and vrate
adjustments can lead to wide fluctuations and clunky overall behaviors.

Andy Newell devised a method to calculate the needed ->inuse updates to
achieve the target hweight_inuse's. The method is compatible with the
proportional inuse adjustment propagation which allows all hot path
operations to be local to each iocg.

To roughly summarize, Andy's method divides the tree into donating and
non-donating parts, calculates global donation rate which is used to
determine the target hweight_inuse for each node, and then derives per-level
proportions. There's non-trivial amount of math involved. Please refer to
the following pdfs for detailed descriptions.

  https://drive.google.com/file/d/1PsJwxPFtjUnwOY1QJ5AeICCcsL7BM3bo
  https://drive.google.com/file/d/1vONz1-fzVO7oY5DXXsLjSxEtYYQbOvsE
  https://drive.google.com/file/d/1WcrltBOSPN0qXVdBgnKm4mdp9FhuEFQN

This patch implements Andy's method in transfer_surpluses(). This makes the
donation calculations accurate per cycle and enables further improvements in
other parts of the donation logic.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
---
 block/blk-iocost.c | 252 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 244 insertions(+), 8 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 61b008d0801f..ecc23b827e5d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -491,9 +491,11 @@ struct ioc_gq {
 	/* see __propagate_weights() and current_hweight() for details */
 	u64				child_active_sum;
 	u64				child_inuse_sum;
+	u64				child_adjusted_sum;
 	int				hweight_gen;
 	u32				hweight_active;
 	u32				hweight_inuse;
+	u32				hweight_donating;
 	u32				hweight_after_donation;
 
 	struct list_head		walk_list;
@@ -1551,20 +1553,252 @@ static u32 hweight_after_donation(struct ioc_gq *iocg, u32 hwm, u32 usage,
 	return usage;
 }
 
+/*
+ * For work-conservation, an iocg which isn't using all of its share should
+ * donate the leftover to other iocgs. There are two ways to achieve this - 1.
+ * bumping up vrate accordingly 2. lowering the donating iocg's inuse weight.
+ *
+ * #1 is mathematically simpler but has the drawback of requiring synchronous
+ * global hweight_inuse updates when idle iocg's get activated or inuse weights
+ * change due to donation snapbacks as it has the possibility of grossly
+ * overshooting what's allowed by the model and vrate.
+ *
+ * #2 is inherently safe with local operations. The donating iocg can easily
+ * snap back to higher weights when needed without worrying about impacts on
+ * other nodes as the impacts will be inherently correct. This also makes idle
+ * iocg activations safe. The only effect activations have is decreasing
+ * hweight_inuse of others, the right solution to which is for those iocgs to
+ * snap back to higher weights.
+ *
+ * So, we go with #2. The challenge is calculating how each donating iocg's
+ * inuse should be adjusted to achieve the target donation amounts. This is done
+ * using Andy's method described in the following pdf.
+ *
+ *   https://drive.google.com/file/d/1PsJwxPFtjUnwOY1QJ5AeICCcsL7BM3bo
+ *
+ * Given the weights and target after-donation hweight_inuse values, Andy's
+ * method determines how the proportional distribution should look like at each
+ * sibling level to maintain the relative relationship between all non-donating
+ * pairs. To roughly summarize, it divides the tree into donating and
+ * non-donating parts, calculates global donation rate which is used to
+ * determine the target hweight_inuse for each node, and then derives per-level
+ * proportions.
+ *
+ * The following pdf shows that global distribution calculated this way can be
+ * achieved by scaling inuse weights of donating leaves and propagating the
+ * adjustments upwards proportionally.
+ *
+ *   https://drive.google.com/file/d/1vONz1-fzVO7oY5DXXsLjSxEtYYQbOvsE
+ *
+ * Combining the above two, we can determine how each leaf iocg's inuse should
+ * be adjusted to achieve the target donation.
+ *
+ *   https://drive.google.com/file/d/1WcrltBOSPN0qXVdBgnKm4mdp9FhuEFQN
+ *
+ * The inline comments use symbols from the last pdf.
+ *
+ *   b is the sum of the absolute budgets in the subtree. 1 for the root node.
+ *   f is the sum of the absolute budgets of non-donating nodes in the subtree.
+ *   t is the sum of the absolute budgets of donating nodes in the subtree.
+ *   w is the weight of the node. w = w_f + w_t
+ *   w_f is the non-donating portion of w. w_f = w * f / b
+ *   w_b is the donating portion of w. w_t = w * t / b
+ *   s is the sum of all sibling weights. s = Sum(w) for siblings
+ *   s_f and s_t are the non-donating and donating portions of s.
+ *
+ * Subscript p denotes the parent's counterpart and ' the adjusted value - e.g.
+ * w_pt is the donating portion of the parent's weight and w'_pt the same value
+ * after adjustments. Subscript r denotes the root node's values.
+ */
 static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 {
-	struct ioc_gq *iocg;
+	LIST_HEAD(over_hwa);
+	LIST_HEAD(inner_walk);
+	struct ioc_gq *iocg, *tiocg, *root_iocg;
+	u32 after_sum, over_sum, over_target, gamma;
+
+	/*
+	 * It's pretty unlikely but possible for the total sum of
+	 * hweight_after_donation's to be higher than WEIGHT_ONE, which will
+	 * confuse the following calculations. If such condition is detected,
+	 * scale down everyone over its full share equally to keep the sum below
+	 * WEIGHT_ONE.
+	 */
+	after_sum = 0;
+	over_sum = 0;
+	list_for_each_entry(iocg, surpluses, surplus_list) {
+		u32 hwa;
+
+		current_hweight(iocg, &hwa, NULL);
+		after_sum += iocg->hweight_after_donation;
+
+		if (iocg->hweight_after_donation > hwa) {
+			over_sum += iocg->hweight_after_donation;
+			list_add(&iocg->walk_list, &over_hwa);
+		}
+	}
+
+	if (after_sum >= WEIGHT_ONE) {
+		/*
+		 * The delta should be deducted from the over_sum, calculate
+		 * target over_sum value.
+		 */
+		u32 over_delta = after_sum - (WEIGHT_ONE - 1);
+		WARN_ON_ONCE(over_sum <= over_delta);
+		over_target = over_sum - over_delta;
+	} else {
+		over_target = 0;
+	}
+
+	list_for_each_entry_safe(iocg, tiocg, &over_hwa, walk_list) {
+		if (over_target)
+			iocg->hweight_after_donation =
+				div_u64((u64)iocg->hweight_after_donation *
+					over_target, over_sum);
+		list_del_init(&iocg->walk_list);
+	}
+
+	/*
+	 * Build pre-order inner node walk list and prepare for donation
+	 * adjustment calculations.
+	 */
+	list_for_each_entry(iocg, surpluses, surplus_list) {
+		iocg_build_inner_walk(iocg, &inner_walk);
+	}
+
+	root_iocg = list_first_entry(&inner_walk, struct ioc_gq, walk_list);
+	WARN_ON_ONCE(root_iocg->level > 0);
 
+	list_for_each_entry(iocg, &inner_walk, walk_list) {
+		iocg->child_adjusted_sum = 0;
+		iocg->hweight_donating = 0;
+		iocg->hweight_after_donation = 0;
+	}
+
+	/*
+	 * Propagate the donating budget (b_t) and after donation budget (b'_t)
+	 * up the hierarchy.
+	 */
 	list_for_each_entry(iocg, surpluses, surplus_list) {
-		u32 old_hwi, new_hwi, new_inuse;
+		struct ioc_gq *parent = iocg->ancestors[iocg->level - 1];
+
+		parent->hweight_donating += iocg->hweight_donating;
+		parent->hweight_after_donation += iocg->hweight_after_donation;
+	}
 
-		current_hweight(iocg, NULL, &old_hwi);
-		new_hwi = iocg->hweight_after_donation;
+	list_for_each_entry_reverse(iocg, &inner_walk, walk_list) {
+		if (iocg->level > 0) {
+			struct ioc_gq *parent = iocg->ancestors[iocg->level - 1];
 
-		new_inuse = DIV64_U64_ROUND_UP((u64)iocg->inuse * new_hwi,
-					       old_hwi);
-		__propagate_weights(iocg, iocg->weight, new_inuse);
+			parent->hweight_donating += iocg->hweight_donating;
+			parent->hweight_after_donation += iocg->hweight_after_donation;
+		}
+	}
+
+	/*
+	 * Calculate inner hwa's (b) and make sure the donation values are
+	 * within the accepted ranges as we're doing low res calculations with
+	 * roundups.
+	 */
+	list_for_each_entry(iocg, &inner_walk, walk_list) {
+		if (iocg->level) {
+			struct ioc_gq *parent = iocg->ancestors[iocg->level - 1];
+
+			iocg->hweight_active = DIV64_U64_ROUND_UP(
+				(u64)parent->hweight_active * iocg->active,
+				parent->child_active_sum);
+
+		}
+
+		iocg->hweight_donating = min(iocg->hweight_donating,
+					     iocg->hweight_active);
+		iocg->hweight_after_donation = min(iocg->hweight_after_donation,
+						   iocg->hweight_donating - 1);
+		if (WARN_ON_ONCE(iocg->hweight_active <= 1 ||
+				 iocg->hweight_donating <= 1 ||
+				 iocg->hweight_after_donation == 0)) {
+			pr_warn("iocg: invalid donation weights in ");
+			pr_cont_cgroup_path(iocg_to_blkg(iocg)->blkcg->css.cgroup);
+			pr_cont(": active=%u donating=%u after=%u\n",
+				iocg->hweight_active, iocg->hweight_donating,
+				iocg->hweight_after_donation);
+		}
 	}
+
+	/*
+	 * Calculate the global donation rate (gamma) - the rate to adjust
+	 * non-donating budgets by. No need to use 64bit multiplication here as
+	 * the first operand is guaranteed to be smaller than WEIGHT_ONE
+	 * (1<<16).
+	 *
+	 * gamma = (1 - t_r') / (1 - t_r)
+	 */
+	gamma = DIV_ROUND_UP(
+		(WEIGHT_ONE - root_iocg->hweight_after_donation) * WEIGHT_ONE,
+		WEIGHT_ONE - root_iocg->hweight_donating);
+
+	/*
+	 * Calculate adjusted hwi, child_adjusted_sum and inuse for the inner
+	 * nodes.
+	 */
+	list_for_each_entry(iocg, &inner_walk, walk_list) {
+		struct ioc_gq *parent;
+		u32 inuse, wpt, wptp;
+		u64 st, sf;
+
+		if (iocg->level == 0) {
+			/* adjusted weight sum for 1st level: s' = s * b_pf / b'_pf */
+			iocg->child_adjusted_sum = DIV64_U64_ROUND_UP(
+				iocg->child_active_sum * (WEIGHT_ONE - iocg->hweight_donating),
+				WEIGHT_ONE - iocg->hweight_after_donation);
+			continue;
+		}
+
+		parent = iocg->ancestors[iocg->level - 1];
+
+		/* b' = gamma * b_f + b_t' */
+		iocg->hweight_inuse = DIV64_U64_ROUND_UP(
+			(u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
+			WEIGHT_ONE) + iocg->hweight_after_donation;
+
+		/* w' = s' * b' / b'_p */
+		inuse = DIV64_U64_ROUND_UP(
+			(u64)parent->child_adjusted_sum * iocg->hweight_inuse,
+			parent->hweight_inuse);
+
+		/* adjusted weight sum for children: s' = s_f + s_t * w'_pt / w_pt */
+		st = DIV64_U64_ROUND_UP(
+			iocg->child_active_sum * iocg->hweight_donating,
+			iocg->hweight_active);
+		sf = iocg->child_active_sum - st;
+		wpt = DIV64_U64_ROUND_UP(
+			(u64)iocg->active * iocg->hweight_donating,
+			iocg->hweight_active);
+		wptp = DIV64_U64_ROUND_UP(
+			(u64)inuse * iocg->hweight_after_donation,
+			iocg->hweight_inuse);
+
+		iocg->child_adjusted_sum = sf + DIV64_U64_ROUND_UP(st * wptp, wpt);
+	}
+
+	/*
+	 * All inner nodes now have ->hweight_inuse and ->child_adjusted_sum and
+	 * we can finally determine leaf adjustments.
+	 */
+	list_for_each_entry(iocg, surpluses, surplus_list) {
+		struct ioc_gq *parent = iocg->ancestors[iocg->level - 1];
+		u32 inuse;
+
+		/* w' = s' * b' / b'_p, note that b' == b'_t for donating leaves */
+		inuse = DIV64_U64_ROUND_UP(
+			parent->child_adjusted_sum * iocg->hweight_after_donation,
+			parent->hweight_inuse);
+		__propagate_weights(iocg, iocg->active, inuse);
+	}
+
+	/* walk list should be dissolved after use */
+	list_for_each_entry_safe(iocg, tiocg, &inner_walk, walk_list)
+		list_del_init(&iocg->walk_list);
 }
 
 static void ioc_timer_fn(struct timer_list *timer)
@@ -1705,16 +1939,18 @@ static void ioc_timer_fn(struct timer_list *timer)
 		if (hw_inuse < hw_active ||
 		    (!waitqueue_active(&iocg->waitq) &&
 		     time_before64(vtime, now.vnow - ioc->margins.max))) {
-			u32 hwm, new_hwi;
+			u32 hwa, hwm, new_hwi;
 
 			/*
 			 * Already donating or accumulated enough to start.
 			 * Determine the donation amount.
 			 */
+			current_hweight(iocg, &hwa, NULL);
 			hwm = current_hweight_max(iocg);
 			new_hwi = hweight_after_donation(iocg, hwm, usage,
 							 &now);
 			if (new_hwi < hwm) {
+				iocg->hweight_donating = hwa;
 				iocg->hweight_after_donation = new_hwi;
 				list_add(&iocg->surplus_list, &surpluses);
 			} else {
-- 
2.26.2

