Return-Path: <cgroups+bounces-6063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A50A03777
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 06:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA1E1884A3C
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2719750B;
	Tue,  7 Jan 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL8idOBo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3C86333;
	Tue,  7 Jan 2025 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736228911; cv=none; b=hyCSpA5BLyPTtWMpK3dQ6kIA3+gpK3zOlAfV77l62zUzNTTNy2tLdvTWpM1tgXNZH0sC6dl0NqOkB0IIockuLA3WGmLU9/sndVf+dzi7rzgav3P78Iyc+tC0UQsXAoYjhRB2jD35zewMa1sdogzwd23wq6wcjbwiedPHj0xZPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736228911; c=relaxed/simple;
	bh=ti+5XE6tfC4JKKtGReFhK914eu9ZIodcBuEMcVGtWsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcH5FTGfKPbUUiH+QXeTxpd08GwX283IzIaJgSdupMi9aM84KmICi6ZTIJVUE78xpG7NblAh9VPvPbLby8BQyaB6Qp+IcztlSIrpNWYUo5U/+H+OtwsP3TG8Hx4Qpf4Usb3pQSid54z20rJjVNMURpVyCdeRSgtKFd7IuJVjA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL8idOBo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21619108a6bso204791205ad.3;
        Mon, 06 Jan 2025 21:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736228907; x=1736833707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb8vDpP0ne9342d9v8Y2G2jn/m3HiJMLqSWtTPbylfI=;
        b=WL8idOBolLrLUOsZ7jxbgVIiq0J/V9RNXFL+EvM2xSMU1peHpifGJU6D7tsN5PfQJa
         GQjEaJ5wPPnhqoQNPGj4MB3C5tE9fUcL7xANy2SGzZSqhy9IZnmFdtqePJV9oN+ArkGP
         /lkk910QZo3fS6Inqug4x0+31ySbxLVYgJgX876AZgtGkNSV8Gg22OEF3X9HZ9ReLatX
         qy/yWd2aO6+lc1BhE8R6mILADw7F8RoACKQ3Y7ZZmUi4hPKVq4L9i6nxYFPNZuxJxv+O
         udjZpo2rNap29dejmA7uWChoXA+blFargn2u5ktb8KdbwiF+Cj/xmD2b1UQN+tCAeArK
         WjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736228907; x=1736833707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb8vDpP0ne9342d9v8Y2G2jn/m3HiJMLqSWtTPbylfI=;
        b=sh4qxw/gjEk7gpQJxTiP2SMfwwT+9Qqj0qKXQrDKWVAh6y0AejSmHwU8ZVoLXoXSdr
         l6M31AJ5CpAKd6PNJqX6gc6VrYtvrv5U1s09Dja217qdwZ3uXAB9O5uWc2oYUEsdYOI+
         dJg0bQa3/s5dIT8JPKuMuLUQVX9giC+ML6s9xKhiYPb3eO3Dq4jLvj/CYcg2iAHWmSri
         303w56uPhcT0ygKZp/f1pcOzSNBpoqb+GTJLQM6M9gNyzSt7qlEwxPJI9nFD4EJHSKef
         POS5V3maQ1+Hcllpb9nonDu+Xxj/V/dTjentCP6e6ElwiWDvVzQe80rvv9zVmhsRjhQU
         YH0g==
X-Forwarded-Encrypted: i=1; AJvYcCVjzZXRw6CQVCZWD+mN/m9TJkPObJn55sYHJRjPlWpXt4QdZ/8KBL8N8ab5joUs0lb5j4jBgWdQzdvtQ92a@vger.kernel.org, AJvYcCWnfKeMYQLCzEmNFvBJw3y7eHALETCjwnxDc/5YVCJNpA51xYedJaysBol8cjJVus4XUSsP6Iuj@vger.kernel.org
X-Gm-Message-State: AOJu0YyojMSzWtriBmxG4GWfSgILTfHFGB8isIDZcq/cYMbw/XUd2rCN
	cbtNWZ2qZ9ZLiH4xK5dvV3oUi0oDKaZECN1kVIWUlYnZ2WyN8w1b
X-Gm-Gg: ASbGncuBP8EIVRSB+SdegjoZc5mjd8oG+zue7gbJ6fbjLd9/EgXgG12zorwULEX1hCe
	EBA52L3tOHOxXmUuCPgJt7Bf1Fs+Cl0BCrwXby57lzD+8PNsvWsW4D6stjvg9Qpb9Dhevv6nyv1
	kaR/10Wjkf84BMhEbrCorNL0lNShGmQgnksvVR24Zcr78m1V50ZmzsGZXvRDY+NTs+X5LdCMuDt
	OuaqQY9Kndx+o4vdgb4i4KFsRvbeAVB2bqmJ/PvOo+BJQynpp4xLs2/a/x2lNnyTFYRk6wEig75
	wZNe23cnnfgUS9rJHGRF3GRDgJ4=
X-Google-Smtp-Source: AGHT+IHkTL3SbYfX6L+Tuct4Rbi2QdqSQ9V6GLY1TbWXikdQiMAGP8zFdP+8lz5Tt6B5qHzinX+fUQ==
X-Received: by 2002:a17:902:f687:b0:215:b473:1dc9 with SMTP id d9443c01a7336-219e6f0e62dmr751340975ad.46.1736228906833;
        Mon, 06 Jan 2025 21:48:26 -0800 (PST)
Received: from mm2dtv09.. (60-251-198-229.hinet-ip.hinet.net. [60.251.198.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f738asm296897285ad.205.2025.01.06.21.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 21:48:26 -0800 (PST)
From: Kenny Cheng <chao.shun.cheng.tw@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: c.s.cheng@realtek.com,
	cgroups@vger.kernel.org,
	chao.shun.cheng.tw@gmail.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev
Subject: Re: [PATCH] mm: avoid implicit type conversion
Date: Tue,  7 Jan 2025 13:48:17 +0800
Message-Id: <20250107054817.3278424-1-chao.shun.cheng.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107040631.GN1977892@ZenIV>
References: <20250107040631.GN1977892@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That makes no sense.  Do you have bool (or _Bool) defined or typedefed
> to unsigned char somewhere?  If so, that's the bug that needs to be
> fixed.

Yes, you're right!

It has defined in the other header file which is the root cause of 
compiled error.

This patch can be ignored, thank you.

