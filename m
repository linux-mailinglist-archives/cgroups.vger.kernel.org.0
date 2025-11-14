Return-Path: <cgroups+bounces-11970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F95C5EDD4
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6F14F482F
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808D34B18B;
	Fri, 14 Nov 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cJetZ2j2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241434572F
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144516; cv=none; b=N7TaprKVLklwT2NExZEPCzwqFiB73ebNtC0wKsSYpN92y7tRZXV08A8Te6xncSsTdppWDbkyQPJR4XEb0CjaNudcT25sfi2VHrxBsDd7Wf2yWgaqSFm7Qq4jhhzb3diE+W3OB3Q90J+RBoExR+gzQC2Yv+ozgwyHkmZa9J8CoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144516; c=relaxed/simple;
	bh=8qNH+bv6qnOKRk8Ht91oNJxRGlDhaipub/m6U+pzcsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JG4Ii7SbcJ7tYjhElnzTZF5FL1tVNfDD2EqSm6or9sbMUNQVvxQhOq2AnF9gAaZ/Pm71zFbiVgx7Nt8cEw67PoeeReXxEEG3gu68RywsfA1XurQK2P+b5YlF426VGdWUjPXzkGB40keRt6NMNX2xnRYndTBCOuBeKkUIiXGmocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cJetZ2j2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so13365445e9.3
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763144511; x=1763749311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOShTwAArIFHr3R9C6zEKOQttwiCluYdM1UARxYplgk=;
        b=cJetZ2j2/PRUXdkMxuHGwFMqEhhoA0QBzmSX1u4hlsG2zvCHALbT1d7zqfA3Rqnw8Y
         2VZyI0+WYL0W+00ADBCXPpeCWfFtLYi2Nwxq3sVVBk1GWMi7UtWeiiscgsqoqRjK5sk3
         PgCuUIf74lmHyPOQ0uHISOETrtD1KcciKS8reZdMnYWr60PURfj5Ji7Yoj7XoRX92pHD
         66nYzgQXFAtyH4ZyHxssA4bqhrOSHX8MctNf7B1yauginputyJdhmcydpl8/6aHHSa89
         jXy1/LrtpXlOKXNv16LnfxbQx+iCtcFRJKDwJ2Jz+Dn+GfCeMpetevQbYHgMd94WRxQS
         miLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144511; x=1763749311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOShTwAArIFHr3R9C6zEKOQttwiCluYdM1UARxYplgk=;
        b=aURbn+Y9n5UB91wHlTYpqcqB8KkxIMHVx16ajx5eKYLil9gUL4X+zi10zuppXuzVFH
         hwEabJ9OVotAtCibLodtuzOgA29r6sbj1ieL4OkH0VICT+zMQfmriaVYWh++bzXpqtXO
         69Nu3Hd95m0MRPtkaf4+wAD+2uU4JWL0yKr4Ss4mJ0A3kntzObOBFrH/q6tJ72oR1IeI
         ZCWZVF1wqjSDqVEGsBA8Ou7wMPYhYX3plGJ+WqWhHHB8q154kvYyVg/BIgbdKKqAxi9r
         GXkk8B77ktzOQS4ffzRTriZlhDphZN7F+df1hIl+IpB3RB5hWSo2pNmRXu9XxKsncDYz
         auYA==
X-Gm-Message-State: AOJu0YwptECLUZfwEOhp3QpDoPv5z94JE3gG/vkCcN6DUULipYSJ7Vjj
	sAZst2lOh7bQEA6p5aTQ0F2ewR/wVKmJ22pYMRKc2hsi53LQq4pm2FilIrX6ZdsNjr/gJ1WU+8c
	c4tng
X-Gm-Gg: ASbGncthkHp+jhFNz1KTQADcFZ9IKR+jQXlVW6qy5dzJbOWgH8q01Yhk1AN+YuMQSf1
	6Mj4Mc5OEPldsaYy5FDI2lnnqBHl0VB499gUi7L0y3wCHVdjk9PElGqdgYcyLpxghOGfK5iTgmI
	bVI+TYvCQVFGW2FaY4+bzpUwx0KdPeQavfaOZccenDCysEvIRYcyoCyk4Jjo8KSKSS8QKcaJjwU
	FD7V+y49CDyX67j2bP0xJ0Ky3kVcn0YUNYPmMzg+q6jLXFAAFhPfy3GXXiZA5OnVyr2tZADC+DB
	5fWqY/V1KBIY3E8M6cZU1mhf/+HsgfQZHWSA/9p2ga9XcggKRg3nEk2kyskeBa2VXH5x5tJlhYe
	G1frlKJ7R1XrqdLBYW5Mmg1UKc9v2+tvzjhr9fiKwsRu7+/a/XK1b9Ys3nR5+VX1rYozqkOvfks
	vqJmjvlSAY6rWy0GAfTUW6
X-Google-Smtp-Source: AGHT+IEi672ocN9HJOjDk4mkON5X1Kwc+vDF8kTUOrO8ZZ/Mjdjg3mnnnul14tWFLNhxG+MPCcczKQ==
X-Received: by 2002:a05:600c:4f93:b0:477:bb0:751b with SMTP id 5b1f17b1804b1-4778fea1056mr38183415e9.27.1763144510774;
        Fri, 14 Nov 2025 10:21:50 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm163601805e9.3.2025.11.14.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:21:50 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 3/3] docs: cgroup: No special handling of unpopulated memcgs
Date: Fri, 14 Nov 2025 19:21:27 +0100
Message-ID: <20251114182130.1549832-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114182130.1549832-1-mkoutny@suse.com>
References: <20251114182130.1549832-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current kernel doesn't handle unpopulated cgroups any special
regarding reclaim protection. Furthermore, this wasn't a case even when
this was introduced in
    bf8d5d52ffe89 ("memcg: introduce memory.min")
Drop the incorrect documentation. (Implementation taking into account
the inner-node constraint may be added later.)

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index e0a659474fa47..4c072e85acdfe 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1327,9 +1327,6 @@ PAGE_SIZE multiple when read back.
 	Putting more memory than generally available under this
 	protection is discouraged and may lead to constant OOMs.
 
-	If a memory cgroup is not populated with processes,
-	its memory.min is ignored.
-
   memory.low
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
-- 
2.51.1


