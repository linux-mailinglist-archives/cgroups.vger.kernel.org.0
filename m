Return-Path: <cgroups+bounces-13175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D8D1E529
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76EAB30453B1
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948F3921D4;
	Wed, 14 Jan 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="AjzIh0RA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F82392C4D
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388931; cv=none; b=lTWgiHAT2Bn7Jnry4FnDRlagcK2ujbxAwdE908mdh5jjWM+5EBEc06V0qG7LxYksPQ0OZKjlqv6neEWDKvKGJywHpDMfjSpRGNFKkZfznCloqyvQ6Rv6mn0hRGx4kVat8KtvYHSQsgKy1Kjx9vEJ4ie8ylAqbgVp17VSfxaivjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388931; c=relaxed/simple;
	bh=NGDpNgaYAnKJpFJ27LdnKRDIF7bjbzvgTyRhQktCjO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdlImqUBRiiEUUERBOwmxIMf4J7xje8+wzelo+hUZb5hCSXpNc3ioJnc+Cg9s/TQ7TQJEzuGB2t20mpFVHzMXacMlnlgtsxtBy+m2HrkL67jSpSwmjZzVbGSjmAweToBGFFT5ylFbWYrfZrVdrInIqsZFkxbq3pEvwLxjEuVP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=AjzIh0RA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a07fac8aa1so64362715ad.1
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1768388926; x=1768993726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rp+ERt1dfU/la6Ha2tXOSz2jWN3a9Tr4qXg0gnWoaNY=;
        b=AjzIh0RArrWimh5hKL1MDgEkrBOHoLNgMq5EiwNcySzypMjPTjqCX64siqpiSNN56b
         SmeTA5PQAM0EyhqIRMLfq+bQ0qDBAIxcxYbntdZxXmrKaf6cNigi5+TVmZYbRQ4Murcr
         M+P3N4WhtF5p51/ofqEWiFcOUQrMa5Va40ApfVoclVX+ZD2gOB6x/8bdIke5LnDXqTF3
         1wIbE/hCDYn0l/r1TNd8vnbGGjMJGEoUrAfmd1KmKMOrjAFzKbRAW5JScqKjlV7S9sVA
         cRGmT0KvIDO3oX9SjJRu5P/B1xbR79oaBCl5LEWKzXuvhkK5r/DJO/vMGG6eGZuUGwHF
         uTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768388926; x=1768993726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp+ERt1dfU/la6Ha2tXOSz2jWN3a9Tr4qXg0gnWoaNY=;
        b=LfbeqcZW+VFMFCMfQLIHd8kjTtzs+/ogo7vpfvb3YPPe7azZL0q3fHwdZE4pqpyQMu
         QuUSfPsh7d0/qOn4upDb2JVGiHC5s5h80BM+8/ly7+DjEzo5YyOlfC5svpZ7EWUNwB3+
         i9BEbOehTSyyuRLhCIAc9SzpcZb5ebEMJywZrMTzuJxZuT+Dy3Q/d2OjZH+qTT1jq09y
         QjIcEd50qRPoG8t3Q4SAvbkpybszlO1hR7ZooqWixAuuRyaNK3uF6CHOEDRFk2unC2Xo
         /mhN3R9qqg11x63geY7eQjM5Bsem7PKyIv2lBlDm1k+n3KUuKTDUsXk0vNWSY8e22E9Y
         WqIg==
X-Gm-Message-State: AOJu0Yz76BZMrBiBNRntG4U2xsA6dUI2np5BhR4YPdN1ksVPnkd7WQYP
	nMKN1oJbKmlySwVQYHGOY1QDvuF5+k23HeHFx+o6WUTnmWh9yKsgrfbCZhzpn26LsNlbV5RxVDV
	G2R/4JNg=
X-Gm-Gg: AY/fxX7c007mzpxysVw6P6a7gu5mmBs01fT3UCtYse4xkR3RkwRvidoDCcPkC7xqoU1
	RJbIGj0e1djomc1zpcBAKNU4TIAvbUua+vo5LpR7TIbYG4Jep5ju9TLjt8vP0u3Lgzohv77Lqgr
	ATe82Kk//cBFF3Tt1VLPgax3W+9NabW8y3B5rGVJEOXAd+xibWWU0D4CggM7gRXiuHREv7qLdV0
	FyJZQJFWp6XqhCrElbDpytFCFkBqE09uR5ed0I0fSxC0uunaEgRuifdyZWLMX/LEkQ2If5lhOSl
	zWFisypmdFvNodWSw34OqI8qDAfDBO2TgtKIF4qs3YPZxwLk6Mhphmrf8ZdklwL3OqP9rB6SHso
	993yjDEWiaPnKUSrWsYy6SEJxS66ztN7yCQzV8bKAwGPijKlnNEor6nTjseS8OHpPpLQM2ii1
X-Received: by 2002:a17:902:f686:b0:2a0:d728:2e79 with SMTP id d9443c01a7336-2a599e05654mr24223935ad.16.1768388925818;
        Wed, 14 Jan 2026 03:08:45 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm103732285ad.98.2026.01.14.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:08:45 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	corbet@lwn.net,
	axboe@kernel.dk,
	hch@lst.de
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] docs: Fix blk-iolatency peer throttling description
Date: Wed, 14 Jan 2026 19:08:37 +0800
Message-ID: <20260114110837.84126-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The current text states that peers with a lower latency target are
throttled, which is the opposite of the actual behavior. In fact,
blk-iolatency throttles peer groups with a higher latency target in order
to protect the more latency-sensitive group.

In addition, peer groups without a configured latency target are also
throttled, as they are treated as lower priority compared to groups with
explicit latency requirements.

Update the documentation to reflect the correct throttling behavior.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..d6f7ef08b67d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2238,8 +2238,9 @@ IO Latency
 
 This is a cgroup v2 controller for IO workload protection.  You provide a group
 with a latency target, and if the average latency exceeds that target the
-controller will throttle any peers that have a lower latency target than the
-protected workload.
+controller will throttle any peers that have a higher latency target than the
+protected workload, as well as peers that do not have a latency target
+configured.
 
 The limits are only applied at the peer level in the hierarchy.  This means that
 in the diagram below, only groups A, B, and C will influence each other, and
@@ -2265,8 +2266,9 @@ How IO Latency Throttling Works
 
 io.latency is work conserving; so as long as everybody is meeting their latency
 target the controller doesn't do anything.  Once a group starts missing its
-target it begins throttling any peer group that has a higher target than itself.
-This throttling takes 2 forms:
+target it begins throttling any peer group that has a higher target than itself,
+as well as any peer group without a latency target. This throttling takes 2
+forms:
 
 - Queue depth throttling.  This is the number of outstanding IO's a group is
   allowed to have.  We will clamp down relatively quickly, starting at no limit
-- 
2.43.0


