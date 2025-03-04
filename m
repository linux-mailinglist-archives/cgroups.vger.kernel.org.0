Return-Path: <cgroups+bounces-6817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785CA4E5AC
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5948D8C0FF8
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCB283CAB;
	Tue,  4 Mar 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXppXQkD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8412836BD
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102733; cv=none; b=Mgrqut9h0vZjvoh+vmCpmBdDnJA1/vA01Xy/+HwLHuoigmbDVC5h1WzxG9xwOMtuiCmXotgDH6PrYIad49RaTMzAmOuYE1ai0bQsc8pYyxmfdPwq2BWb7J2EqyH+1I7g57PE6hDf1KpPpKlYoAJBN2C0aq2oC1FPAOWamf2k+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102733; c=relaxed/simple;
	bh=7wYWG9ZVBBfm6qGUhQl1CLl2MgF3R1Q5kOXcuHck6Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEUZJzFW9/XfKO+VWidGupujd0Bmpbp03wTkYWncuNI1vQI+iY1vV3p+FXjRe3Le39+JAoFcc3zpxW5kyjPUWrWA1J5U+T162Wd3MAUwWjC5JsiHS2kjNSB7fbsfsZUc4TXPk/n8B9oH7Jz1XQmJUarvyirJqyw8RQqsOGOMVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXppXQkD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso2512305e9.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102729; x=1741707529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3wpAZuZ4KSnXLbNZ2vVh3tj9jZngNuo0DCz+MLkfDs=;
        b=KXppXQkDk92JQzy4v8GmbTtE/SQwvZcjp9mxH5CnBZD0Ct1HgT8D6MfFKmyp9bNVvn
         bCd2aQtt8D0SjeXq0Oc5MLpuq3g1LieVC/EBNfKgcA59dBAJKVYJXwQd+f6/GAIm9/m0
         rwOyD/nWBci8Vdb67QEUsZ3nnXTatRKAvBfHDt6shbRGUKtS3yq6PjkUVw8vy7cfKH1S
         gobZTYmTgBK0hjnyJ935+55kW3goVuJYaCtFNtxc3yCehR83a4NKnRf26R0fnhpeImEF
         /F+GtfKR+7dp296RxtwxL0wmTtrWhviygtM91yL9hFO5ju+DKY+olPXolzXKg1FNyq4/
         Ujxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102729; x=1741707529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3wpAZuZ4KSnXLbNZ2vVh3tj9jZngNuo0DCz+MLkfDs=;
        b=pxzYqxdSYeKMH9mcfEDaacgB2+JhRKhgh3I5fIGaeC1XNDvCYE6hBAjTHr5e/wHtgH
         731DLoI+rYTyJET+RqP5iG/Eo/Z75O0KcIHVGhWBXqBDOPqopvLq84e+qKPSN4jJIFTc
         NruyMadSWHg1VpRzkdbf+oWz9K47ke1Uo9QM1DyWN19wIXKoXGl0loMbI+W2T8TIZm5e
         dEAYpvjtl+eX6hlaWIYgvmoNqkAyxsvcqHHXr4XaVzTtIfTx1FM1cY3dMw3mzIJbjBPv
         WmymUDZQbpiY6TbjsfmOPFYkEDnl55JoIFOBMvtqHf2imkM67dJGTaDzsmBaeH8rKo6O
         g6xA==
X-Gm-Message-State: AOJu0Yxcw1mpNEFnYLR5ynfEg7rW0oy8GCEfadyz5DT2ZjXRV4XQLM52
	/y7p1c/beyZBqCQfzDjdDsCJN0xjxnX5ye7sBEaUGUhPtRze+LyEMLy8WsQZBX44vpZR3PJW4K1
	1Das=
X-Gm-Gg: ASbGnctlFoDrqK1hBGYV/t1CaRISnlhMIxwbtRpsg6dQCa8OS4JioT/m4vyk5Z+/fH0
	Reb3kTMJC8vFbpDFEWj8EK8m3A24BLwUc48qJPEUeBcRUSmaN+iDnTTenf4t5hcwXCuPCPpjTA9
	VYa0Wbs6h/CUWsmAGFr2tdr0jW5zhBLhzRykO9urx+dCs2fd8n99mhlUq/rol0hxcBe04rHoXSL
	lggkGpCqxcrV+BdXjWxtDowRkxYpDSGWrseBjUVOF7Pr3aYy68kM165VTyPfIH7+C2CCQj+NQTW
	a2LHOnukzOryVT2n+JGHR9xrSTVjtxvgmFlysNC7w46tjro=
X-Google-Smtp-Source: AGHT+IGuIQECszQqXO1I3O177p66zxaZAZdsZPbssWdo0WGLgBAu3ofXHTqWUVYSmtGpaEjf12Uqqw==
X-Received: by 2002:a05:600c:19cd:b0:439:8346:505f with SMTP id 5b1f17b1804b1-43ba6747836mr136899675e9.20.1741102729333;
        Tue, 04 Mar 2025 07:38:49 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:49 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/9] cgroup/blkio: Add deprecation warnings to reset_stats
Date: Tue,  4 Mar 2025 16:37:55 +0100
Message-ID: <20250304153801.597907-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is difficult to sync with stat updaters, stats are (should be)
monotonic so users can calculate differences from a reference.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754a..b77219dd8b061 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -659,6 +659,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	struct blkcg_gq *blkg;
 	int i;
 
+	pr_warn_once("blkio.%s is deprecated\n", cftype->name);
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
 
-- 
2.48.1


