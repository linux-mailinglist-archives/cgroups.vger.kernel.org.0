Return-Path: <cgroups+bounces-2364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7289B6A1
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 05:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01410B21E62
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE29079C2;
	Mon,  8 Apr 2024 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXV21nBH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA0747F;
	Mon,  8 Apr 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548419; cv=none; b=qHy7F1wy9hHhkaFdPOqWzlf6/l2N/AqPC0sneFkYEGRLseFOZoDy3FwDBMBinW+YIPRxp+90KOGSLeRLMfWbs8fcaFnIuugMYoDT/EH+BT5lfsgMv6nUuEvHZIZr2NYUpm/JNFeNufdaQ2XLTZAXaRVctT7NpQ34rnSJs62YYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548419; c=relaxed/simple;
	bh=oEHbOOo+Ri1kqs5/5aZkyEbpKV8E6A2FxGUiVI2WTv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cceppDfYSCsQGu2Azlm5zuyXju6URDyC3XqSNNMA+uWoEdXkhbQhbFqME5Tb5DGW4d0Oyb0CPEUbT7Ihe4fIpGev4WvtPaoK2hBtkX/YYI2YcjGZg9zLcmfVJLcxfnWOg7+CV/W6/YSK9WLoofHbTx267Ft1hD4h0UIRHFJVijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXV21nBH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0e89faf47so10064615ad.1;
        Sun, 07 Apr 2024 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712548417; x=1713153217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdaKb7vbj+4jUEnI1aBP9RhDrJGBVLsISpGLsJCZpEI=;
        b=ZXV21nBHIj1N2FEUNbZwtkjxiMYUVL9f2VpyfDqxAWMIJu7JjUREamW4lit3H6MH9S
         U2w+A+PSvvgC6ftEmakKukYQ3iTZIoI5I707n+FkW3HS4g1i8V/L05SxDE2ofuZb6AYX
         z+7T7TkIHIqNE8pBxxDmrIpj9u2LvdIVKNPZ4/VEA150ie+DWqxJovtx6LJYuIKhNck5
         f7EGfPvqoGvNYWCWsbLDoPuKEBSN1u4VAPL4cSvm0SqtshDAYzZXZQa7+N90GP3AK+w0
         KZvI/k0hw4M78EMBq/bMHPFIxuzJzDEkhI58sX6KCPzURN6IGsIJvdC9SYdE3H0ZCiSH
         DZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712548417; x=1713153217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdaKb7vbj+4jUEnI1aBP9RhDrJGBVLsISpGLsJCZpEI=;
        b=MDqSmesSgndat1n9UWECuoxQfs1cVMpOlSKjon9F651j28MmThZpOtx1vAKvuSOknL
         cee6/FAYI4kZdVbIDFTPJJ0728ZVDS3LnGszWa5wpQak3GQYMTN3myYmZr321HfR6DR9
         yOxZvGt8g6FSTI9R6r66MKpPi50avamOxGt533ZFRk/4M4YHmboS+lPW5wUOIIs12lrN
         C5fyi3+oycwKq7fXHpSLqBlgOZEFG6xYYc4a+ka7D80uFRUnLm3dhpCEsxyZ3dk8rjMZ
         cC/yvxXiIWCZwmuldDsqUWiDhmFW9zKfxPj5Gs225h9DmSsc5JexFcGyMmVphEb3fsad
         zOKA==
X-Forwarded-Encrypted: i=1; AJvYcCW1jWjAGgg0vYO43bTndsufgRUFYHDrE3Eo4vl4j43lrPvdewHRYrbno2Z0t1frfFc0h8Y8SH/gi3VyPPNZB56y8ZH//EM+3IAqZKY8nqnGZ3o4JnfDPLL6MtV4WwO51VKRFb6xswMdzixoTVACMdhawMgxdzD4MpetskqZSR0f2A==
X-Gm-Message-State: AOJu0YxkKKB/AlA0VIc7y7EOTDpeMmXAn/Gfy3S3/otp80dPFXVrGgHZ
	CUGJ3c+tzbHOyea7TxhO595Wfx01uBpEY11Ox6I8fQEWbOJr3xUI
X-Google-Smtp-Source: AGHT+IGLZl4k8db3AnaLRdS/1JiFbgxr3JLLo6wVIhnsAWiOWBj8HDCBzJF2ZfE47HU1g1KnmKyq1w==
X-Received: by 2002:a17:902:e811:b0:1e0:c887:f93f with SMTP id u17-20020a170902e81100b001e0c887f93fmr10054410plg.1.1712548417216;
        Sun, 07 Apr 2024 20:53:37 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:705b:f2ff:2c4d:3b1b])
        by smtp.gmail.com with ESMTPSA id kp11-20020a170903280b00b001d8aa88f59esm5757512plb.110.2024.04.07.20.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 20:53:36 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: tj@kernel.org
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] docs: cgroup-v1: Fix description for css_online
Date: Mon,  8 Apr 2024 11:53:29 +0800
Message-Id: <20240408035329.5175-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original description refers to the comment on
cgroup_for_each_descendant_pre() for more details. However, the macro
cgroup_for_each_descendant_pre() no longer exist, we replace it with the
corresponding macro cgroup_for_each_live_descendant_pre().

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/cgroups.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
index 9343148ee..a3e2edb3d 100644
--- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
+++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
@@ -570,7 +570,7 @@ visible to cgroup_for_each_child/descendant_*() iterators. The
 subsystem may choose to fail creation by returning -errno. This
 callback can be used to implement reliable state sharing and
 propagation along the hierarchy. See the comment on
-cgroup_for_each_descendant_pre() for details.
+cgroup_for_each_live_descendant_pre() for details.
 
 ``void css_offline(struct cgroup *cgrp);``
 (cgroup_mutex held by caller)
-- 
2.34.1


