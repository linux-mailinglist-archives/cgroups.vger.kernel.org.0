Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8DBE8AE
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2019 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfIYXDi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Sep 2019 19:03:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39666 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfIYXDi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Sep 2019 19:03:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so535466qtb.6;
        Wed, 25 Sep 2019 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WfbXh+sodiUMPQSO5yCeqiJJDmHL2yMhTTI21O9c//4=;
        b=UrO+9FhI4EIs4jI4yXfKf1L+DbuNMlCxcVZ3jN5cwJ77HfdAjqNgQ6FQPxLj6MbdI5
         EQ/qM8/S1CQq7aJbPc4BEHeXaKa0t8kWWT5CI/Ss8KJpfdfe8ErjJVNEUNWUDkWlTdu7
         CHchGLYEiaLnnldmMtFmLQKgaZqfp6lWYUGq4/CRCyN96qPXjBLljijuJ4/6rOpNNE/B
         P/9roPgUV+Yc+bU/97dcTbYlgJnckw5Lls8VQSeJnLllwEXdKFmD+ONt+yzarNqHB0kZ
         WhlCKuVX9JQyMt2nUCrCRDD5K/0JcLluu+G+Yq3HIEN3rNKrvMOGWYzCiyxaKhpZuEsy
         Of9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WfbXh+sodiUMPQSO5yCeqiJJDmHL2yMhTTI21O9c//4=;
        b=ekAeYulb6w4JboYVzWkX/GBojQ73c5G1/mDiGRmwFxIdmx4zZ+s9vktB59bfSQPSfK
         ue/0atMEHabcS8kUt0dlRJBB6V2ZMjNMiln0vxCqv8wxE2foJmMhFjTsHojV6EhKwLeU
         IFvzLS0BX9S1HvKxSjy29yKODkZhuaN6lUx7Gv8riU8lbEeQCn8RjPXAlxm7MhCTth0K
         CiUZRY8iEsmi8rZmWgJ/1KjX93uhW+k8uj0EWgLDuAuTtBa/mQOHtCZoVQcXyXOhI7rW
         QVitvmqzbdIoPnraESfM/H7v5uq3M7tRVrKrGAvsnDtKb0KrU+/WrSNRyzCiPCrenMnt
         nZqw==
X-Gm-Message-State: APjAAAWg4QhdiWFSaEkCwx5xefZdpcDDdEBaEaSg7+BfTjmoO94Ndi6C
        0HT8K9LqdV+AAJWmCMh2vnw=
X-Google-Smtp-Source: APXvYqyC1FyjGChJ2Qd1VW5+w/5vvUgYmAgGVElejt3WCWCezoA05O48V25SM3ipL5VdElk9+zyedw==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr953244qti.377.1569452617529;
        Wed, 25 Sep 2019 16:03:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:a001])
        by smtp.gmail.com with ESMTPSA id u43sm265769qte.19.2019.09.25.16.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 16:03:37 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:03:35 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: [PATCH 3/3 for-5.4/block] iocost: bump up default latency targets
 for hard disks
Message-ID: <20190925230335.GK2233839@devbig004.ftw2.facebook.com>
References: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
 <20190925230309.GJ2233839@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925230309.GJ2233839@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The default hard disk param sets latency targets at 50ms.  As the
default target percentiles are zero, these don't directly regulate
vrate; however, they're still used to calculate the period length -
100ms in this case.

This is excessively low.  A SATA drive with QD32 saturated with random
IOs can easily reach avg completion latency of several hundred msecs.
A period duration which is substantially lower than avg completion
latency can lead to wildly fluctuating vrate.

Let's bump up the default latency targets to 250ms so that the period
duration is sufficiently long.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -529,8 +529,8 @@ struct iocg_wake_ctx {
 static const struct ioc_params autop[] = {
 	[AUTOP_HDD] = {
 		.qos				= {
-			[QOS_RLAT]		=         50000, /* 50ms */
-			[QOS_WLAT]		=         50000,
+			[QOS_RLAT]		=        250000, /* 250ms */
+			[QOS_WLAT]		=        250000,
 			[QOS_MIN]		= VRATE_MIN_PPM,
 			[QOS_MAX]		= VRATE_MAX_PPM,
 		},
