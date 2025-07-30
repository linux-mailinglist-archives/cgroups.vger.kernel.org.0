Return-Path: <cgroups+bounces-8933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8AB16500
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A961895BB5
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327892DCF74;
	Wed, 30 Jul 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujyuz8fp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B94263F4E;
	Wed, 30 Jul 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894118; cv=none; b=OePfNzvczXPE6gbXZcdT+NFkUsq2ZF/zGbxZE2XOtSyxb5iLCtJRcnTkCmhwbf4/ann7poKikn3HTnf1jvnED9JkT/wegAKLTEoEc/5NhAY8PxJMqbjyL9Od0neLzpSDTVJ+WW0rl0NyxABaDemymJlx+yiqrsAMFpzuQ4NQT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894118; c=relaxed/simple;
	bh=+6qBoQkibUASVJZX3Mtx3+8pZyaeqRlt/01TtVfNdaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFyV0tNB++iT5opNkHdLIXwH6npTIjA6kp3elmpOF199Bo7Sj+WB5iPqgBNAaSfU18XrjPX5IjARAcLPNB5/SDS34mVBxZHvs6pPW64C4houpvnrLEFnxByLQX6WdqNmr+lqa9bWPy52pSQeGvEzsvOn0nyOLTK/08oVh7RP1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujyuz8fp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so25704b3a.0;
        Wed, 30 Jul 2025 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753894116; x=1754498916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aNlkWFUgststInEezhmJ1v9QJOfUo81bz0je3iD3r8k=;
        b=Ujyuz8fpoRbJFPOIU7MhnqdogTUSESGc/7KEbIKX6kFJpn7xVkDG2baBwk+O13jpjH
         qUOGjtiYd1d8gCiWEnmTZ6GMWc5isXC8dY4JzhuI9sJ99rkXeXHV66g4RcWdH2KTTX0v
         wIcRQ2LHTGLDjK3oaVrVxrNd6+nYAfOes+zgXKgLke4yG47KgZgH6qs1d6xCmW8AgPWh
         v6PAQ3sGgTTu2H/ZlhglWewxd59cRmSHww1xUmF21JfJWfAaCQpFz34BMkPjJO7L/GBZ
         pkmLV0dCTihDprfeMVEJnTr1/tBPnOzYpnNJITpOyYnKFbG1wE6SuTl+Em3AGllYJzpu
         5LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894116; x=1754498916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNlkWFUgststInEezhmJ1v9QJOfUo81bz0je3iD3r8k=;
        b=wVX4NEzEwmcPnRylwNEwKYxTALu3KTXDVhjRNNo0CuGbIAE+w5xwYJ/DRyoBGtxHEs
         KZqFHO5YiHrHvX3zRRiBG+Dh42gZ55bnFb7yEbsdjN+85oZJUkAr6ecc7RIE07jjP1kg
         y/wsCAvuHXxAhK1/Oqml087iq86eobXGl8bQ4FC2fFTP+tUTldWwqkyGKQgICeCszYJX
         1Ca8Ojo9AFblAIlVVX5HAXZsLKTZeOaj85qSN7hSIzBaZBdRiI95YtsSCYutLlo6uVsv
         hqpaU7CuPV9p77IRKTDvVGdAXVWtjTZqChdAfDOn2sgDHL+kC8zc1yjadMGPfO7r6kQl
         mZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUBKTb9benUmTzQm0uMcbDkoE3HBwe+x1yPCWoN6fKTQkXZuURdsv1Asu/O3/SkLK/KW5HN6lApvZvjF873@vger.kernel.org, AJvYcCWhULQZfLF3wICdlmW5/UHfGtIGwRmHCuLbN9TGl7QkWxGPaiSMkXhy4dxaVx29VyASfqNjgZlC@vger.kernel.org, AJvYcCXnQKtjfXnuedTCmj9v1ZAch2E6HHOl8KvoX1mTqhUD9vn8fB4dWfxZu+9GiYoZRMu1Evavg+xmflUZjTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2smc4lQmX7EvDKHl+3Znz8+W0cTbhiOhz6W9q9moVDSzksI3
	s4xbPc+wBsyYNvuo2QN3ZowvYxaTFd25jkyZ2hq+Wpij7hp4cWgvq3uA
X-Gm-Gg: ASbGncvqZ4VtmDiEl/TzVcr3U0y5n02MV8W//UuYC/+RmPMTXHgEegLf74U7RWHm1QD
	bPRfPlgDx+y4z0kbWSImuxp4xoFIqRqxFder5VkBLXDgl9W9jsVrXS2p2CCwB5O2kLr5KJZghGI
	Tf3N2uiOAnfiE1NpjUYs4gerkLMk15Jbq7wvysJLsLga2mNZjVAa+/wfH4nNAjxELcwftcNiv2+
	Auxri4HJJUnbX1aLtj9CIu11PIDKS/PZEznBVn8dprqdlII9dn0tUkUPXlgUmNpc1U0ISgqElY6
	43MSLG7/qGas4SzNqNpbL1D37Ew380pUMSVqb3czif3vXThbnufLCerBK+5NA0QNJ2ufwJoOVRW
	a+Q4XGVwvp3gt8+6QiSpNjV8usnIucLzuThE=
X-Google-Smtp-Source: AGHT+IFKJvVjN4PEOag+lnI1ihd6YLDHK9HDN39cje54yQhUV3yhkfogg6y+67o1j4p4qNMijF+nbg==
X-Received: by 2002:a05:6a20:9392:b0:23d:7a31:53e8 with SMTP id adf61e73a8af0-23dc0e130cfmr6312396637.19.1753894116224;
        Wed, 30 Jul 2025 09:48:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640afeb9a5sm11082238b3a.83.2025.07.30.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:48:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai3@huawei.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/2] block/blk-throttle: Fix throttle slice time for SSDs
Date: Wed, 30 Jul 2025 09:48:30 -0700
Message-ID: <20250730164832.1468375-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"),
the throttle slice time differs between SSD and non-SSD devices. This
causes test failures with slow throttle speeds on SSD devices.

The first patch in the series fixes the problem by restoring the throttle
slice time to a fixed value, matching behavior seen prior to above
mentioned revert. The second patch is optional and replaces the
throtl_slice variable with a constant.

----------------------------------------------------------------
Guenter Roeck (2):
      block/blk-throttle: Fix throttle slice time for SSDs
      block/blk-throttle: Remove throtl_slice from struct throtl_data

 block/blk-throttle.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

