Return-Path: <cgroups+bounces-3016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552098D112B
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98221F21800
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621AB9479;
	Tue, 28 May 2024 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzuW6M0b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7452907;
	Tue, 28 May 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857814; cv=none; b=jgBzKwVEgaVQomkRri6CvwgZMkshMYdAPpvBzuHggOL828NkKcr2CqSj4XFUy6z7eOEmV2zoXIE+lMzml98WKzXnB7YEm+ZOOEsuhCAU5u4xUPE9nOSykEJjbPUfiS8/+Qf+JOyWvl79E8PmJ6eF7upu/cFxnp68LBRHkL4Pye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857814; c=relaxed/simple;
	bh=yi/EszHUlOpCwgzZqVjrzflrzIMfLJP7BNBpSEMhkYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z98i+bPxtTdKfTU/6O5Zu8Q89i6eQ1V6bnXAjale1s4hEXHs2GzprAKQUGsJx9IEsC1ZuCaUxg6FL01cGLRDp2Xr0u2TJ4AxxlIXUU9QIkMl+6EtE5LCooPeNRLSbX5O7YHEjS23RTAeVAb+Nl0vIKOdu6mr8Q3j3ha1auBEVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzuW6M0b; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a08099115so2935007b3.0;
        Mon, 27 May 2024 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857812; x=1717462612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrtpjA7rbTF+FvnXXEAEsUdT24L7/cDqcK77C2g3SmA=;
        b=KzuW6M0bN9Np5HtDKb2U6OWQ5/5ovDW5k4dlOPLvJGibUEtg8l5wvWIyanvQ/+gMaP
         8kLEy0KaKoFoG4fhBM4TaiuXT2JPDqtJ5qhtFVBCePFRgydWF2Sn6Z+bgvshBiAvMtY3
         M5KzszTIh43wbWzT2tJOj7MF9xHrCCNN3RyK2WseUZiGcZwdfgQCQWsUkbX+2Cyav3NI
         AZMkibY+xC01TL7JXG8OwhVXmvn3TYgMROZ+c/e+9IVTz27MM+4DUR1uYCTpfqEWiHtz
         VWMebhWA7KdJrLFLzTsP2RBcvO57RxTvcgmU0NNKccZLX3mQr6X/vEJdAa8z7/lzBjtE
         TF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857812; x=1717462612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrtpjA7rbTF+FvnXXEAEsUdT24L7/cDqcK77C2g3SmA=;
        b=d2RAeHJH7t91x50XvkMPXG+a94REGYrF+8zRvthkBEqfaCJjlw4qxdASTV7RtzC0i9
         hE79ZGEka2cQVK1tMdNqP5pTm/hzUW4HqasW7AVTmFjgw/r/7WQpDtNWJFbXgkgA8sA9
         ZXpo274F2ArVbvm/lUju+OCE9OyWtyUv7OTbbyXwhxnaUxk9E/ltFeLHLGoutcK9w6s/
         5rslk/Q9meXH+F7skue3dZSOQEzYCxTxHqC59IP/kqZHcr0UMqmazoOCh74vG/NJ1pos
         z9SgHJnoDWFfyDRKIr4G5CnvO1XkxsZyZk2SHdpWBQ7BXvch/xWUPuAZd5t+XquIETMC
         MTSw==
X-Forwarded-Encrypted: i=1; AJvYcCWs+gq9rkaxe5lC8vJIGGIFrWquV9rnkkrRUA1QwG7v3RfiXkc7Ekl+MtuzzOg4nOVS2UF6SgfZn3j83pVzfEanT1nfzXnOqfp95JANVIubCkwWRfcFO804zNNbfv9wmLZLpqMxUPzrDJn3tvFX865WLA0X3FkiqhP3wXx9ipChYA==
X-Gm-Message-State: AOJu0YyBr2INXl3OCTuXKcVLSpkv77Mo070rhca+Cyb44J3KNxhLBuAf
	h2yU9SSRDX000ifX19e/u+05TsJrRLnVkfs/roDzMJ0GBDNHSyolP/gpLw==
X-Google-Smtp-Source: AGHT+IF6oojh7SVjXJ8sdTcrbsy+EFZrvDSMwjEXLGSGTF684UQ1adnnZZP0XdnvzUZCDMb9dLHmcw==
X-Received: by 2002:a81:6d12:0:b0:618:9353:100c with SMTP id 00721157ae682-62a479dc17amr20084727b3.23.1716857811724;
        Mon, 27 May 2024 17:56:51 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a27d13bsm18412197b3.12.2024.05.27.17.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:51 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Christoph Lameter <cl@linux.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Dennis Zhou <dennis@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 1/6] MAINTAINERS: add linux/nodemask_types.h to BITMAP API
Date: Mon, 27 May 2024 17:56:43 -0700
Message-Id: <20240528005648.182376-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528005648.182376-1-yury.norov@gmail.com>
References: <20240528005648.182376-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bea32141764b ("nodemask: Split out include/linux/nodemask_types.h")
added the nodemask_types.h but didn't cover it with corresponding record in
the MAINTAINERS file.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..6ae73aaee305 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3733,6 +3733,7 @@ F:	include/linux/bits.h
 F:	include/linux/cpumask.h
 F:	include/linux/find.h
 F:	include/linux/nodemask.h
+F:	include/linux/nodemask_types.h
 F:	include/vdso/bits.h
 F:	lib/bitmap-str.c
 F:	lib/bitmap.c
-- 
2.40.1


