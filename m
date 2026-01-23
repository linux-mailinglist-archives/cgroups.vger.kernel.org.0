Return-Path: <cgroups+bounces-13403-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFS3InqPc2l0xAAAu9opvQ
	(envelope-from <cgroups+bounces-13403-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 16:10:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92777857
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 16:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41B2C306E311
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971F27CCF0;
	Fri, 23 Jan 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEJnt3IQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9387238C2F
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180488; cv=none; b=KIEO23+YqwbKBVVeqmcYqQHeixPf2+/az94tOQsKhlmo5ifGAGHfzvlabAuz2TpVAlNcWOzXrIWfBCjMbhtsFNtxq1nsHHqNZ5ieS0v7/lo0745UDsDmn5p40ah5BpvmdqUXanR37ZX9HkUuPjsp7OW9X1MkeT4WxlhO70pzaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180488; c=relaxed/simple;
	bh=l65vAWfIchAA4EBaJeuPIIcy/0bQu1TDjnafKhOcHBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7E40QWw5vL+mfvCsjs6yU4wNywbhH6ftuD3iw99DE0wokSPeudQWaa8JM8MVWgA+figp4nWfzvkgvTFnTGgJiDodW1Ek5w1lwm0KA4KYbOHBgph/mCMgdkryVWkZuFQd5QLBKECLcvt3KIz1W3A0DnAWVd76pQDqtxmGssGj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEJnt3IQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7a94c6d4fso10964785ad.0
        for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769180486; x=1769785286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+lpncMkcciaETgIgCV8/VHPr8GktIzZ/P9zCkM2a1o=;
        b=QEJnt3IQL7Wzcs8ZQHYO3K7KtBiCwxylId/nAzGWAdgU3avQxiZ4t6ZeURwoIgTkp4
         Lz6V7jBOOtLO47VxirGWm9VtdWHM6bgCKhQSLUhgKxnJ8Zv+o71/DwT+C8kLdjeS8sOw
         5IajRFgUfw5ONBDeECmceHcqTZJjVjTT3OCz41MJE5u2676SdcUMoqPZ8UljNIN0YcWq
         10zKuMwsmWKN71h2GVOqqcdbml/i77CwsucQxVAKXMC4GUPRWzn07EQUBg7oLhCmw/iN
         kq1C0bQPlE7Dt+aa2uy9OKv4Xa0fsBIhuldbNNnqiMKAsruCkeNTyvWIQ3MiIyTH8wJk
         jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180486; x=1769785286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+lpncMkcciaETgIgCV8/VHPr8GktIzZ/P9zCkM2a1o=;
        b=QTiaZDtPl/Qvu7dDBx4ZzLr/8WIa0ei+pTHmn2jQXnJf43wmEwwAbcP49a9LVb4AUK
         xV0em3VtdeC3qVZ/v6CKDnvp3Frj50LBJoR6GP70rGoZZ00y0Xbn7JThMZLE4GFJoqka
         /27stxkmiH9vivv6Qa1lX8m69Xo4r+RSMNVxUA48DQb6XKNdnitHWIMN0C/YLptXJAAn
         HbSAAY7NenxxQuhmGcL+0IOaxiAPUMsEAKQSi51G0MWGkgjvoodqhwqo7NujvAbemKmH
         7o4N1yhY0+zJotiwuMBbSZtS8Yb5RUJZ7GYRTtABhWlyPzjZomJcfItRoIYRTlFHNVvN
         DekA==
X-Forwarded-Encrypted: i=1; AJvYcCWfIgzoeph9wQAP99kDR5z8+f+5pgOc4LigBa01IxHczrRUyCGYLt/qMQD0p0cE0GZtGf3naPTR@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGBz2cp4ATn8ObcH6Qw5IS3ojpFb+NdnPdtKErcx2WjriLXZm
	aM1QIdOTj+tn6qx4wQKEN+sr9KrGySMDhISdDXpUN0Xx8W5LDNcD1Hju
X-Gm-Gg: AZuq6aJdmWyfgL2P7ZytTt/UHCBoIYYqEJ0qn7htnwj0n0z9VA4UWlhhewlQkZzwfiO
	3ReKRMXKZr/E2YuClyQBUJLRsYsgSu4sKvHaZ+vqGwvF9o3utj2StlU8am4RzIqUucvz5Fv/sQN
	C5CYO/iFVjfKu5Zv8GDr3G/UPBUrqnnMhq+/6bsog/as1ad0hGFD7ofMkGpGiNCNDt6WHAgDW2U
	NZdJYLXtwHShcJXWhXXwmj8Vbr+nUpc3rHYHbBmvJbAqBVtRZBjHVUcCFSxhhIM2LjvC32f5XYE
	8UFN0dsYJyyikQLfg4rcb12lH/Tx5h5i5F9f6tniTQMeTIKLKPfSW1adoi+xTsqJ+gpUcNJc9bm
	y/gr+LOlcOdenvyuG0Ju4aMJ3Da8ibYHo0HceKGQi7lZg1Tg7K6zcvecybkid98K0Kkoa/WzIOB
	hMwNt4bGA/Q0prrzvcz5iAbCFIHU8=
X-Received: by 2002:a17:902:f54c:b0:2a7:cecb:9844 with SMTP id d9443c01a7336-2a7fe74b66cmr28603775ad.48.1769180485491;
        Fri, 23 Jan 2026 07:01:25 -0800 (PST)
Received: from NV-J4GCB44.nvidia.com ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fae9b5sm22297685ad.80.2026.01.23.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:01:24 -0800 (PST)
From: Jianyue Wu <wujianyue000@gmail.com>
To: akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	inwardvessel@gmail.com,
	Jianyue Wu <wujianyue000@gmail.com>
Subject: [PATCH v4 0/1] mm: memcg: optimize stat output to reduce printf overhead
Date: Fri, 23 Jan 2026 23:01:07 +0800
Message-ID: <20260123150108.43443-1-wujianyue000@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ec59f7-2d76-4c7a-a2b0-57bc4e801d1d@gmail.com>
References: <20260122114242.72139-1-wujianyue000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13403-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C92777857
X-Rspamd-Action: no action

This patch optimizes memcg stat output by replacing seq_buf_printf() with
a lightweight helper and replacing seq_printf() in numa stat functions with
direct seq operations.

Changes in v4:
- Embed separator and newline in buffer to reduce function calls in
  memcg_seq_buf_print_stat() (suggested by JP Kobryn)
- Optimize memory_numa_stat_show() and memcg_numa_stat_show() by replacing
  seq_printf() with seq_puts() and seq_put_decimal_ull()
- Add comments explaining the optimization approach
- Note: Did not add a separate API for the numa stat case because the output
  format "N0=value0 N1=value1" is too specific - the "N" prefix and node ID
  are separate values that don't fit a name=value pattern. Using
  seq_put_decimal_ull() directly is more flexible and clear.

Changes in v3:
- Rebased to latest mm-unstable
- Updated commit message to clarify the optimization approach

Changes in v2:
- Initial version with seq_buf optimization

Performance improvement (1M reads of memory.stat + memory.numa_stat):
- Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
- After:  real 0m8.909s, user 0m4.661s, sys 0m4.247s
- Result: ~11% sys time reduction

Jianyue Wu (1):
  mm: optimize stat output for 11% sys time reduce

 mm/memcontrol-v1.c | 84 ++++++++++++++++++++++++-------------------
 mm/memcontrol-v1.h |  4 +++
 mm/memcontrol.c    | 88 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 123 insertions(+), 53 deletions(-)

-- 
2.43.0

