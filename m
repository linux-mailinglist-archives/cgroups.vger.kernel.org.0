Return-Path: <cgroups+bounces-2873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3428C4972
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCA41C21364
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE91272CB;
	Mon, 13 May 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLC5n8OF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C586263;
	Mon, 13 May 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637721; cv=none; b=USUcUbUfcvX9lFDJJTGxWPmWlnrGqbfW4cBWcY812RBZHLcj6MAWu0wohGkirSo+JAkTHz1QSe75XncWu6qsm5DPVBHB84Cs6u4gL5XyJvu/fA5hWV4Hjo8m2qKWUeIaLkG518tTdm2aGFceQ0FBTQS8BbfYMAYckBFj7mBBfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637721; c=relaxed/simple;
	bh=5ByyuK9842Nu7izTwGN2VcAUuV2L/M3R2rM7RX17BDM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sURYTqgcRoPU4QrGgHhftXSLAQy0qexi2VOUfK7jEVLu3GzGQ/xCPEgSYjksFNiupUOs20NT80VXVOEbquGIBkNHW36ZKUAWDbrxieVnZi/nNquLgnXL/zf+mzBf3eeT3ARikeLiQknb3rYZF0cE9HYXEI8lNs5P1ROYStvBEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLC5n8OF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61ae4743d36so48874047b3.2;
        Mon, 13 May 2024 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637719; x=1716242519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoKk7MW4sbJ1HdpDCTP5sGub4zDeIvETZgNgOMQPec=;
        b=dLC5n8OFK7DTaXyOe5SM6ugqKQv4tEZSjFtBNJCs6WMeCEzUPaR3PHHD88WL2pAWA0
         K2qImvJ3bcWCUeiu5oWY31q/r00i0Z9pKF3d1olDuC81UQPmAey0prXXbQQ3OcjCWrDu
         Pi+rQinP313bRJoyoebExTkJYItD347yb5ZJNKmnUJtyZjHu16K99PMfv6HbqVDobTaY
         v3ARrDeS/8/pyDplUk5DLPcHxYBoC+XAEtFNG/juZirgpC8NiI5BVEmF3aOrAcNYv0/1
         keFxgysjJEP+Gdd0lY1kSha/mye/8H7bB+rXVRf2TJBBict+hVMybHwG+imFJQ+mFlf1
         KZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637719; x=1716242519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHoKk7MW4sbJ1HdpDCTP5sGub4zDeIvETZgNgOMQPec=;
        b=bX2gwZ9dVFdQyxl/jqze1JxZG9uYx9AMBAJ2y3GkmLndxE073xoHtSNpMjoeSMA9bU
         ZvSuv2xiY4v5HVRPYpMZRlOD6qBKf2+pZ21eD881NrBgMWrc1hhkkbLU8tV2nXiXf+8Q
         ll71sNrKd3sejJthWcIREBvvU3kQdQ39QRWPeH1/Z2q6LxVpcZ0keLbjC+8Oena2sAIm
         nwf6l/as15Vy48rOO304IiFdmyjAbYoEWyYYzlGIA/YOWCWZ0WpJys6a1aLHxMySKEMj
         iYhIpCuvgd9RXaJpGtC/M+jODa7lLXA+wtkLn4it4fRzn/9AGOoPZWDnm7TndLSGq7dE
         L1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWbgxccNMDjNtREmV6lGD2I2BX035ZynT6dtcskjxQv56OOI1yY9R7ZxpzsKgHWuo13zTxpdoOTOWh2DxedDwhtRWq5Vij7Iw==
X-Gm-Message-State: AOJu0YwW07NWFDxKc0LnpANpVwePc4sOSJ4CKqNCZEN+iqN7Pf9BY+bV
	YPlB1C9hJ4nOLpooPc8eQdvuEYNNuSe+3AqwQ/+yqc46ju54/y8Pb1H4Xg==
X-Google-Smtp-Source: AGHT+IFTlI8CDWLzh1gFwdZRMrAoioQ9tcsgRyUqvojMsVv2gUyIhCnDYWwXaiijr84v+5R9CSRc9Q==
X-Received: by 2002:a81:af1d:0:b0:61b:14d8:a816 with SMTP id 00721157ae682-622afff6a51mr92700237b3.29.1715637719145;
        Mon, 13 May 2024 15:01:59 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e346810sm22961617b3.95.2024.05.13.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:58 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 6/6] tick/common: optimize cpumask_equal() usage
Date: Mon, 13 May 2024 15:01:46 -0700
Message-Id: <20240513220146.1461457-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240513220146.1461457-1-yury.norov@gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions in the file call cpumask_equal() with src1p == src2p.
We can obviously just skip comparison entirely in this case.

This patch fixes cpumask_equal invocations when boot-test or LTP detect
such condition.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/time/tick-common.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d88b13076b79..b31fef292833 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -253,7 +253,8 @@ static void tick_setup_device(struct tick_device *td,
 	 * When the device is not per cpu, pin the interrupt to the
 	 * current cpu:
 	 */
-	if (!cpumask_equal(newdev->cpumask, cpumask))
+	if (newdev->cpumask != cpumask &&
+			!cpumask_equal(newdev->cpumask, cpumask))
 		irq_set_affinity(newdev->irq, cpumask);
 
 	/*
@@ -288,14 +289,19 @@ static bool tick_check_percpu(struct clock_event_device *curdev,
 {
 	if (!cpumask_test_cpu(cpu, newdev->cpumask))
 		return false;
-	if (cpumask_equal(newdev->cpumask, cpumask_of(cpu)))
+	if (newdev->cpumask == cpumask_of(cpu) ||
+			cpumask_equal(newdev->cpumask, cpumask_of(cpu)))
 		return true;
 	/* Check if irq affinity can be set */
 	if (newdev->irq >= 0 && !irq_can_set_affinity(newdev->irq))
 		return false;
 	/* Prefer an existing cpu local device */
-	if (curdev && cpumask_equal(curdev->cpumask, cpumask_of(cpu)))
+	if (!curdev)
+		return true;
+	if (curdev->cpumask == cpumask_of(cpu) ||
+			cpumask_equal(curdev->cpumask, cpumask_of(cpu)))
 		return false;
+
 	return true;
 }
 
@@ -316,7 +322,8 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 	 */
 	return !curdev ||
 		newdev->rating > curdev->rating ||
-	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
+		!(curdev->cpumask == newdev->cpumask &&
+			cpumask_equal(curdev->cpumask, newdev->cpumask));
 }
 
 /*
-- 
2.40.1


