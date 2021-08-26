Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D83F886C
	for <lists+cgroups@lfdr.de>; Thu, 26 Aug 2021 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhHZNNC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Aug 2021 09:13:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52518 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhHZNNC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Aug 2021 09:13:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 38A931FD3F;
        Thu, 26 Aug 2021 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629983534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDDVzWBIyA6YbwDsNboXLU1D63o94APUAg+7fxjXrqw=;
        b=VAOrEfSZ5nMlMZoT/Qz9t7idhIUjt4cLZY8SfRvhsPnZTAhFV9+EP0/MZ+H8rmA7OftVbg
        6vfwMGGbezOhvVj5sjYrW60KgbsxYRIcqDysh5haTXPn7fHQOretWUo0EIChjlBuNU3aNY
        CNi5tkMwK/fhXl51m7AXITTZRL3Vits=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1E74A132FD;
        Thu, 26 Aug 2021 13:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FGlkBi6TJ2GMTwAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Thu, 26 Aug 2021 13:12:14 +0000
Date:   Thu, 26 Aug 2021 15:12:12 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org
Subject: Re: BFQ cgroup weights range
Message-ID: <20210826131212.GE4520@blackbody.suse.cz>
References: <20210824105626.GA11367@blackbody.suse.cz>
 <EC36D67F-D7CC-4059-8D3B-E0E64DFC3ADB@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EC36D67F-D7CC-4059-8D3B-E0E64DFC3ADB@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 24, 2021 at 02:51:47PM +0200, Paolo Valente <paolo.valente@linaro.org> wrote:
> BFQ inherited these constants when we forked it from CFQ.  I'm ok with
> increasing max weight to 10000.  I only wonder whether this would
> break some configuration, as the currently maximum weight would not be
> the maximum weight any longer.

Thanks for the reply. Let me form the idea as a patch (and commit
message) and discuss based on that if needed (+ccrosspost into cgroups
ML).

-- >8 --
From: Michal Koutný <mkoutny@suse.com>
Subject: [PATCH] block, bfq: Accept symmetric weight adjustments

The allowed range for BFQ weights is currently 1..1000 with 100 being
the default. There is no apparent reason to not accept weight
adjustments of same ratio on both sides of the default. This change
makes the attribute domain consistent with other cgroup (v2) knobs with
the weight semantics.

This extension of the range does not restrict existing configurations
(quite the opposite). This may affect setups where weights >1000 were
attempted to be set but failed with the default 100. Such cgroups would
attain their intended weight now. This is a changed behavior but it
rectifies the situation (similar intention to the commit 69d7fde5909b
("blkcg: use CGROUP_WEIGHT_* scale for io.weight on the unified
hierarchy") for CFQ formerly (and v2 only)).

Additionally, the changed range does not imply all IO workloads can be
really controlled to achieve the widest possible ratio 1:10^4.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/blkio-controller.rst | 2 +-
 Documentation/block/bfq-iosched.rst                      | 2 +-
 block/bfq-iosched.h                                      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
index 16253eda192e..48559541c9d8 100644
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -102,7 +102,7 @@ Proportional weight policy files
 	  on all the devices until and unless overridden by per device rule
 	  (see `blkio.bfq.weight_device` below).
 
-	  Currently allowed range of weights is from 1 to 1000. For more details,
+	  Currently allowed range of weights is from 1 to 10000. For more details,
           see Documentation/block/bfq-iosched.rst.
 
   blkio.bfq.weight_device
diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index df3a8a47f58c..88b5251734ce 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -560,7 +560,7 @@ For each group, the following parameters can be set:
 
   weight
         This specifies the default weight for the cgroup inside its parent.
-        Available values: 1..1000 (default: 100).
+        Available values: 1..10000 (default: 100).
 
         For cgroup v1, it is set by writing the value to `blkio.bfq.weight`.
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb081e..786b7f926dd2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -16,7 +16,7 @@
 #define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
 
 #define BFQ_MIN_WEIGHT			1
-#define BFQ_MAX_WEIGHT			1000
+#define BFQ_MAX_WEIGHT			10000
 #define BFQ_WEIGHT_CONVERSION_COEFF	10
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
-- 
2.32.0

