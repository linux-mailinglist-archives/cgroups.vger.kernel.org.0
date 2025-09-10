Return-Path: <cgroups+bounces-9865-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52565B50F6F
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C931C80505
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DABA25D218;
	Wed, 10 Sep 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqLacYC+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540F1E5219;
	Wed, 10 Sep 2025 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489517; cv=none; b=YM5bnx6maLg8Kqp2okyLVyXW4Oxu9HwiwxLL9xSWp4Lpi7zaQ2KBVPNZ+1Fb+Rm4ehm7dYNtvM3ys6cQVb3ImtORnXqL3KZNVUu3fL8iRwdLIP/ujwJu9dTQuu7BcgeQTa4AqykZiZHAkLR2Bpa1TrIsMQuim2OfCVwdf1xTIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489517; c=relaxed/simple;
	bh=Hdr2Tf1DBDM8PZbgIXMvuFC2zCTYQ3GcUj66ljSSZpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxcCtAXuYaVcUK2WECaJ7zmg+o2mbFXiCnsG1khzEJ6xQnrEHMxmGikyrMKIwhA7h4BMSjtS6Dz08q8ipOBalVtNvoal1hs+KK9P/P/3DxRpGeeE+h7NZWosYkojtj0HsMITEtlJ2FTzdN9jULufJa8tpoFRowVqUbLQYWdtnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqLacYC+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so5417159a91.2;
        Wed, 10 Sep 2025 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757489515; x=1758094315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYmCRSZ5YZDf6SRxvO9+byFu7D/FmsrW9LChG8eCQ4Q=;
        b=kqLacYC+QwWu4pz42FE+Yi1WDIs6mqWlyIxXgf0iVbiGP1by9g/RKy3lY9uF4N0rr7
         LK7bYTctmsy/Tz62Nn69EfF8V4X1m327+26iLSznXriOT+x3YCE7EH4mqpB5+sDdQrlz
         sRNyfLPeqqShVf0YOQzwcJYlUyonmsS4UwPXASumE+wGxNM3YuWCYunsgoDtoymqvVaM
         4isg9Jw96+qP1k2QpYcRnwNOoYWDIWCDQNLbBf3JafqIfHOH2T2Ob9p+dJ/U1x1tUKUY
         tbSii5hf3qz8EBRcDpJCs9xYVA7e1prqA2q3c0ofGWYItWzWEiRyC16hPuEsmyevZ9cS
         XKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489515; x=1758094315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYmCRSZ5YZDf6SRxvO9+byFu7D/FmsrW9LChG8eCQ4Q=;
        b=hyrLzzx2FCP6sz1L4tg+gHLcepTHMdiJ885ekEdHy+m/8uqY1KA5AE/AbzZK+OdZih
         YrTxqUsa9AAchA9ngPQxpDo+1zVykEzgue4jRrbrqCzS12fq0WjRgkaOotgN2xv5WjVC
         JXYCfhR6gX54maBrvxh7LgRhkWPqZcNcCtGKRtnsMrgog6G5MhHG2J2shI1XJdLvydJ5
         lI2drZ56jNoxdbzCxWIqxF8ttMl3wI6b4zLl/30fDcBlJw9Midf/uNvRdnZHQ7TAezEp
         VNufabpbVMq6t9jNrTYpP74QusfvyTwBwdGb673EFAPWO18oXMJQlqumWGM5BY869Ae4
         6+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWLsOLSu8ccuJlXwzGFuKviypHigcml9bubykFV8wItTYffEA1wvGIzqPnuht9iu2jIr963AH3s@vger.kernel.org, AJvYcCX84dPScY4UKOb1XHxcCmeowmVTSjlK7GlRbGzCTEmy92g59OjEXhFNt6y2nAds9trNgCqJC6WPNZjS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76r8vEqqUh/v9aQCqlhE6wwh7zc50JrTzmDBE5mSQlWpkpVux
	UXxRa+WytAfPKj8uaPZKEt4IUelN3DryUWOmTBLYwB7+BqhbHK0meEiU
X-Gm-Gg: ASbGncsP5XQCEHo3vLhf2TlOH4Ql1d9Jn7ieyTuW5WAEfr4sGfRyq7gFzHKOgUkRt80
	4C7BmATHIEow3yQyem3LwIEB85NebfVVyTEY48qnRFqMAYbAMMEhlUYfrgaK9BtEGj4yPEvPJb+
	MOe82ouOzbCg17oSDBJSVsNy3O4WSKrI1lNO25wC/pMai6cRemP2ErolZlHe1Lm7UhpOKeiOzmP
	pWaB5tvMIQlMaJhOyQf0iSd+e3kLmvvvaEZBO7rfsAfkL/5jCBmMKVPl2TnXAIW64SPqRZp9pDo
	gHOPcWsLrJA3lLiUpKEnhsrZhUI/ni7qto2XD1wouKvqszOQ6jzv0Opa4s6lR5yewp2cIw3LR9t
	OCcHS1ksZLYWycVSTMWa+CRpkCHXuawex/zLdHbWtRPD8GuE=
X-Google-Smtp-Source: AGHT+IHtoW7yqTSs88VXQwkRKdpCydUh3MOHv9se5dsw4+ymAlEF2aSX7iGdkiRJRBgF07MhgCJ8GQ==
X-Received: by 2002:a17:90b:1d8f:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-32d43eff84dmr18391628a91.9.1757489514829;
        Wed, 10 Sep 2025 00:31:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775f6b42023sm1296372b3a.87.2025.09.10.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:31:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7A42E41FA3A4; Wed, 10 Sep 2025 14:23:36 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH 0/2] cgroup v2 docs update
Date: Wed, 10 Sep 2025 14:23:32 +0700
Message-ID: <20250910072334.30688-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=bagasdotme@gmail.com; h=from:subject; bh=Hdr2Tf1DBDM8PZbgIXMvuFC2zCTYQ3GcUj66ljSSZpU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkH1blXtcz0ipjsFmfSdjF+TlzwmrleOzrieD6LL/+3e 1ZF3emjHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZgIdw4jwwSmxT7PTgX5X74e vnJ/7IVItpkeC706JgQ9EFN4cOje/WZGhtvnGPQeHq68bpEvqj3Xh+tT4H/fr2eVDm4L+Wq1f9P tfewA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Just two independent docs update for cgroup v2. The shortlog below
should be self-explanatory.

Enjoy!

Bagas Sanjaya (2):
  Documentation: cgroup-v2: Use document path for cross-references
  Documentation: cgroup-v2: Replace manual table of contents with
    contents:: directive

 Documentation/accounting/psi.rst              |  2 -
 Documentation/admin-guide/cgroup-v1/index.rst |  2 -
 Documentation/admin-guide/cgroup-v2.rst       | 91 ++-----------------
 Documentation/scheduler/sched-ext.rst         |  2 -
 4 files changed, 7 insertions(+), 90 deletions(-)


base-commit: 8bfb4580b4be057b99256029ce4010dc63544777
-- 
An old man doll... just what I always wanted! - Clara


