Return-Path: <cgroups+bounces-8767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE2B0A3A7
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 13:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620AAA862B8
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546872DA760;
	Fri, 18 Jul 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS4ka61F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F622D9EFB;
	Fri, 18 Jul 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839669; cv=none; b=Al3ihGxtzryqVcWaVIb4Q2w9My0RA/58MIej2RS4mUWeGMa77Htw8W14fqAWx0UO3ogE7Tp9zj2tX5EjNxjwsLHzAd5uCfbNGpR8Jip0C/fhibBWtShy2q1lUREEQNWPnLteC9XW7MigQ15AVswzdTiUXmjRpZfR8O89HkBEE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839669; c=relaxed/simple;
	bh=9st3IHn6u/y3zo43PHPLGChjIhOflPkiwCPLGMc4Bu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOhlMLrgxAYYBbCeSaOFnKDSHdgZpN0+7JuwbG/kaGbyohioYsiD3H3wRvar+GRmefDmj/cxjP8Rfna/E7r6HPLP4gqEOCslXZdMQLOtDX8DPF2cssKPXWxqK20tnMu2M6zGYnhGkzMcBTihzixxaKqJh6lsr1DdyVEipAXQibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS4ka61F; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so1661483a91.2;
        Fri, 18 Jul 2025 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752839667; x=1753444467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4YPdE2VFlYLmREWLlB8PpFNm1Wxjq1Lo89FitBiU4A=;
        b=CS4ka61FwTAS1xDat0O2R8xFYZpxD1Nvv6dnFqI5SlgW0PsRM9UeftFDO6MgomvU5z
         IHKGesLm+gF9Z+Tfdv8bZlhk78Yt9QnDfqulKylyTMg1P8UiKbez25gffFZe4ruqaC0u
         O1Ilh9ml4vGLzW3VnMBSua4ZsVWXpdR0O+j5f44Vs1x9qR4KxAkYgW6c7IwDicUIH5CS
         K5PrKYCGLhauoKj1Ylq/8HVgogxF2+Db3GBmAssBfYKb/ectoJWmkL/enq7+9qKC70GD
         g+Rhu9CvdItTsYu9SF/UUChPW1MZ6LhuRZq/nHXhVebIC5V9NB746+E6s8s5MwphaQ2h
         20xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839667; x=1753444467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4YPdE2VFlYLmREWLlB8PpFNm1Wxjq1Lo89FitBiU4A=;
        b=qGZmRdLs7WasgPqqFh9xTHY3SpLW+6hefBhckPIo/3VMXl6Ui8CIMp2mDWkIWXGNQC
         4KltBmPvtmOH+kR6Q8rUjD++uCzBT9bS8baWyGrUenYkJEddAK+AvP6K3AK2R9YdlmfF
         8NRHURx7HTLyqvWAELocoXh3gnWSKh8K0Bn0cl9oG6sgC+wyi4L6FasFT3zaA/Lu7q6Q
         0Uz79kShzdFCEXNh/Sg7sNDSDEwEWQ/LUBu55O47aZLYLcjksmeABBsPxKq95gmyPBB5
         OJxRBkx6QTOwG8bEXRh7xvBH3mKbeAG2DRIcGTrUq0McTtuhoIKubc+jW/8faofhwwzt
         1qjg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwjbqssxSI0SrDM7yy6g9A7/OKagU8H4d2qtTbmvhTromEuIS90YPgpKkHbNGrC5Z4lc5UOBssm3/6Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jb1/v3Yxl389ZpTg6ggpR1sDZgVvnTlhE+LHBWdtnhgmTjdb
	4UtNPkz3y6ky/FU+SIXMrLAsIzHXLNrKneHT789KvKkG0sjwL6gLkRlc
X-Gm-Gg: ASbGncu8Z1t1jzCGJa4y0jAODWqIlW2hW9+nCQL7bnIHdWGO5xAlTVDa/4tG0XsxaNh
	CW6zXc2BpyOqfzWJ3l3liDZfBratxkmEgFrya4VojNHffL4H+4jzh3Zi2obOedAv9NzQ+upxdHr
	BNRak8s4Sv2D5gIk5Pesq1M3hib43gsgAcuGdlkuGSMiRKKf18owMmhZnSS7hfS+kMaoLR3N4Ny
	SaYSRY4nXjdpJfdcks7SEQ0vMS1rjNR7rSUJiOZeBFSn3Runm3OSrPwtNyOtbMjOtkgwbmHXXuk
	ivBaezxCpZGy8ge8bbaorfIJXo3Fbn4M1lZr3wS83TV2Smw7GA5ckWVvZZLh8gAdKuki2pqbF3b
	csodIMDVueA3kuoyado7iu+ncDC230k+XdLGezCUOmhXAD1X/FG4YrPOXe7w=
X-Google-Smtp-Source: AGHT+IH1c3VpxRTwSpcSTXbYU5F4DSyMdKf+U5LqT9NWyUPwZ0Wi8WYknRBEy52dXGNZASOCMjrnRg==
X-Received: by 2002:a17:90b:3f8d:b0:316:d69d:49fb with SMTP id 98e67ed59e1d1-31c9e70915amr17571856a91.14.1752839667006;
        Fri, 18 Jul 2025 04:54:27 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb603aee1sm2729890a91.30.2025.07.18.04.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:54:26 -0700 (PDT)
From: Zijiang Huang <huangzjsmile@gmail.com>
X-Google-Original-From: Zijiang Huang <kerayhuang@tencent.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijiang Huang <kerayhuang@tencent.com>,
	Hao Peng <flyingpeng@tencent.com>
Subject: [PATCH 2/2] cgroup: Fix reference count leak when cft->open is NULL
Date: Fri, 18 Jul 2025 19:54:09 +0800
Message-ID: <20250718115409.878122-2-kerayhuang@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718115409.878122-1-kerayhuang@tencent.com>
References: <20250718115409.878122-1-kerayhuang@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cft->open is NULL, it will cause ctx namespace reference count leak.

Signed-off-by: Zijiang Huang <kerayhuang@tencent.com>
Reviewed-by: Hao Peng <flyingpeng@tencent.com>
---
 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..9bde0f4be687 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4134,8 +4134,10 @@ static int cgroup_file_open(struct kernfs_open_file *of)
 	get_cgroup_ns(ctx->ns);
 	of->priv = ctx;
 
-	if (!cft->open)
+	if (!cft->open) {
+		get_cgroup_ns(ctx->ns);
 		return 0;
+	}
 
 	ret = cft->open(of);
 	if (ret) {
-- 
2.43.5


