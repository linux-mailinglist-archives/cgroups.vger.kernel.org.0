Return-Path: <cgroups+bounces-11761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5EC49195
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C83489BF
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80533B951;
	Mon, 10 Nov 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXipsfvt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06830216A
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803410; cv=none; b=LzZSe5IEhmgkhe9NEHUxFI0sEvpmvb+mDJxT1S1hQABMZO9M+6/LSvNFc4BQlKpxdt+6wXXxaVOzi/pTOg0eKC/6Lb0kDCNSE7sWmZVBdJy0hGsJxMOcgc7CpActFPurCO7hLvFVaqYlLlD7+6uGYhx9DQsr/pww8v/DxG9N8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803410; c=relaxed/simple;
	bh=8bSDt6Sg/YjrTXUgYA3DkJzVQ6m3hYydLmfQSne4sVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbdNzi58NE33GWwsxJInLaWnHg+Br3MUNIekDTwbuZ8/7f2owc+kZwleUjbQ7kc8Yq8vQtN1NlWcyyohs0tI/dJtuczhDm4CyAj+qt1ofgbrp+cPVgYZ5FxWzCU5qZJkKwnbHanA43I86Jc/dK/kZVdvjVsQ0oGySOcb/cvKL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXipsfvt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3c965df5so689819f8f.1
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762803407; x=1763408207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neDRog/Ekcy0Lef8h9kFmYGsPx1FWmrolZIk562CgBQ=;
        b=NXipsfvtvlLw2IONctRhKaA48GArRiRGcgsvZoS8Uge9dQu2N0ZkTwTSgVlF91K8iW
         HA7fBJ+U6fbNB/vI5NO34W+3W3KXo4qt31Zmwqw81+9hlqf5p+yIWfrCu5135jFdpJUY
         R3ejWkhH1aIIKuDYYGRzCf2PDRE6vV+bI+RX2dU6UBgXserUxr5mnPE1pvKpH+Bh6lIw
         cJOg91vkbG8teIPqwWrtSlLBXfgfliHjzRc/sRmxkqmVA0lkEskBQST54NMDdK+TFGOd
         tQ4a3uXjAjYvAklbLDwH8Cl7slAktYIuiqbDOoNROGbkyapWASePAK/W3WAsvf2Q3EgG
         BEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803407; x=1763408207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neDRog/Ekcy0Lef8h9kFmYGsPx1FWmrolZIk562CgBQ=;
        b=H3OTDrq6DqyG8hBwKbMj4FS4uEcsmgn0iYlmn5US5DOv/hr/bzx+5jGIkjBv2lSz+J
         3u9bRRWLrMEdSkcLIXMb+FJTTmUHNdhz7Zxgcc0vL6Lh5jDGvmebgmT+V06uebsDN2k4
         9jS8LpZKM0RF/9iSzfYx7dKzeVCRRKtdg3U8hcmhrzSLVDAuKQz/U6WKui5l2BTBrfpO
         rWYRPDMOolUdfEj3WkJKFKELr5B3Vn1m8DNI0cR8aNXq9JWr1Qy8hfFMwXO6JbuxVQ5u
         izlN6FSx3+lF5hEuJIWpi/LhdGBDgu/BtAjVF3/7GgSnOY4N//gOZ7FEbuxA6sTbFV+y
         fPbw==
X-Gm-Message-State: AOJu0Yzi2tRd1rLPKgGlLNA2VMqSdWI6fdqOSRi4pO4fD2le62OfUb4T
	lwtNmwoG1hw6swKhrIWHGnQ/b4pnLtl2IOr6PlNXgwGri4nCpLTIhepIQ0RrfEbGX1OnBvlyqWD
	F1uet
X-Gm-Gg: ASbGncsfPW7WU74IiizLCrHfifuXiTPPVxX70y+Hewjsey/k0mEF+Adu8nNgaMU3awN
	kWShWa43YW90nFULgaOy97pKMrpQC0VnGGrdOVybTV6bRkAHraQSnh8ivq09JlMIy8k2b12jp8F
	jVBO8WjXd0yarajA11cFB7sB7sQls6l3u7IF8eMVysHnTNby/9xMLa02fnXtb4aS1Il8CN38cZ2
	+JRW8RSR+3MY5qZze2JmGX+LE9pAEAnd0hXVZUPakyiO38u5dC30VQOko+YZjdXoBpJjzgA4qAr
	Pl3g6DW7BI1jocP4JmizKZuhyZ6jpmjuzhId/Losv6g4oeL1mEARB+ElGKBfjOJcjK3JAfnVtmH
	MqiTBAmVPSR6feuiuxXON7qrRQmTlYGp16E4hEJPKSn20dWx1Nrv/ZD22WLjm5FU9zzn4zNN9MJ
	YH21AivAPURAJ919CtygLr
X-Google-Smtp-Source: AGHT+IF2h1TXIgUgdAGFGgAj8I/0Z7UVK0V5sWyQ2BHKHfBJkTvoEfi0Y20lPlByyzzwSf922qHPLA==
X-Received: by 2002:a05:6000:2905:b0:429:b751:7916 with SMTP id ffacd0b85a97d-42b2dc497bamr7399170f8f.45.1762803406888;
        Mon, 10 Nov 2025 11:36:46 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm336766725e9.13.2025.11.10.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:36:46 -0800 (PST)
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
Subject: [PATCH RESEND 3/3] docs: cgroup: No special handling of unpopulated memcgs
Date: Mon, 10 Nov 2025 20:36:35 +0100
Message-ID: <20251110193638.623208-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110193638.623208-1-mkoutny@suse.com>
References: <20251110193638.623208-1-mkoutny@suse.com>
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
index be3d805a929ef..84985bb20c452 100644
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


