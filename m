Return-Path: <cgroups+bounces-6032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D076A00289
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840BA1883E0D
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8114A08E;
	Fri,  3 Jan 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG6uJ7rS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1D3232
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869044; cv=none; b=lokbPoemqsCdVS+98COPw7UnleRT8v7uN0oi1h7inWJW5W/hMbBFKMTEIuIs+3N2WJ4akY0iMdedleyxwPRws6NfqxgXZspl5MaYmtXvjWS7EL3JcQP8g/aua0M5o6KGm3dLTtMjAV2SZI3Ta7JGjoaqQn1csM2XwNYbyvAgkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869044; c=relaxed/simple;
	bh=JV/aPqB8rXBsxySbYZ6oHjF+kJiisd4jj+F+uLcT5dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+TQnbxYEnBiqHw7sVTciqxjDji7fNppW+qydn2RRFMb2OL0t4M261BaKaw5imEy0StKd8LaNUcktepdUzhUwGuOA70TDsc4SbLjC1xoSx6zRuSuV9N0FI3LIPRa55f2DptWmIlJ1QBK9DTGTJQOrx+igRsfRV9BZPrhtRLLF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG6uJ7rS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb94cceso115146455ad.2
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869042; x=1736473842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yySB7M2h6IxrKtXZnUHVaoTBxDNRO4MzaqO/1vgyTwU=;
        b=hG6uJ7rSkVq9n0eudOwBH7E/oiZY10BA3wvNcPOIfraCW4Xvup8ielzngv8/tR4JIy
         Qbc/BvJtcaUUGtS5eo3pCYsCVFkyFjhEK47rwgFtI0wXWAuBJpa4pD9SEdcFkMuWih+p
         s4RzT6l8XRIz87vNJqEsum7BBjo4utHMGdt8AoLg7u3Q5Q8tgpfdRa1d7x+VOWyFoFjD
         qwsAoyD/7i5zCR2gAoGQUkzp3x9KmLlYgX2vs9ve+jfxEe1DtUHVoUIYXciN7t1J5Q6S
         dcKyIBofDG3Jcfd30i5aJ2SVewBkSNELcUgw6M2pP2s5v2r/O0LlP364WqYaAx1uoGy8
         Fpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869042; x=1736473842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yySB7M2h6IxrKtXZnUHVaoTBxDNRO4MzaqO/1vgyTwU=;
        b=bJeZHO4KF7keC9YJpIsG2AUZ3rnPuO7S8wWuLYt9YSsPgTF2dnBp3bqdIpkDTx3/Z6
         4O0rAEYQitW6BXZqc+GeQ1efWWn9Y5MANsDcYKCBrPcZnJulSc9QUgS4XvUYwgj5m0HC
         O0FPR+37Pxg6w9K87dmzMY8CeUI9406k6MzIvCzJaKcYVUqdR41VXW4heMOLBggt1Atu
         OHszRroKaQsL5s3CsqJ9rgBhUFuLAEwuNvmPMIRQ1MRkAJ09sId7xWNyFS/cokTnD/u2
         ZvAojz3Ykx9srZKw8to7bambXYEeZ7dpjluyqbhtG5W8iK2el/DDI8E4v4rr1BNQx2r3
         5GJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8USDWTdxMU1bXEmoUYEUBcAEgXT1gVF4S5rGem3+dYYx0PjL0kx0kUZ9PAxCbzYHAX9S1Xy1l@vger.kernel.org
X-Gm-Message-State: AOJu0YwbibvsoI6x3N4NI8c7oi0G3B17CuIlzMtgkHtpsGruBlSNbjCa
	u/t82oK2yRNJ585CtfDn/+vfNz18BcB0A4eIY9NpikRrymppx3HG
X-Gm-Gg: ASbGncuVCzistw+6scWhaBG7nZMIIlZ2Kgvv/2NgF8VbmvTxl8FyUpXw5uMefLKPVXO
	XJ0A6Tdk48pT3MyS69W3QbHrQAwIOhvnTj3WyBaicEI5RMc9fWhFU4I/wO0Qg79hnZ9so2zNzry
	fS/7LjXlFGtaUR9HfLEj+quCkoGbKnIY1N19Qa66BVEWaxOeKWDUbNF8VpHTxq99JpRXsduwukj
	gRV8SHGejzQo3y1r33RriRtVymJbKc0IqJtu2iEfjVvB7ZwBe+pcngmYq5Jn7at98GUpm8kaGzh
	yinIybqIuarVhNvEiQ==
X-Google-Smtp-Source: AGHT+IECu6ABKn1pd4uHiROyoxYhMZo/Ay/F4QxXtatl8UwP6Qp0oTpLfZ1n23xS7eENlQtjkGSayA==
X-Received: by 2002:a17:902:da87:b0:216:554a:212c with SMTP id d9443c01a7336-219e6f12d63mr582089575ad.46.1735869042055;
        Thu, 02 Jan 2025 17:50:42 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:41 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 8/9 v2] cgroup: remove bpf rstat flush from css generic flush
Date: Thu,  2 Jan 2025 17:50:19 -0800
Message-ID: <20250103015020.78547-9-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the bpf-specific flush call from the generic subsystem flush. Leave it
up to bpf programs to manually flush any subsystems desired by using the kfunc
cgroup_rstat_flush().

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c52e8429c75d..03effaaf09a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -346,10 +346,8 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos = cgroup_rstat_updated_list(css, cpu);
 
-		for (; pos; pos = pos->rstat_flush_next) {
-			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
+		for (; pos; pos = pos->rstat_flush_next)
 			pos->ss->css_rstat_flush(pos, cpu);
-		}
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(lock)) {
-- 
2.47.1


