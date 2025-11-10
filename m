Return-Path: <cgroups+bounces-11760-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6162C49192
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 20:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01903188D2B9
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B10339707;
	Mon, 10 Nov 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bmtp8f3i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A4337113
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803409; cv=none; b=VDFL1xlCp+JMaLtLJEzbM1alktWamYTXLKhz0TIE61X4oXfPi7Z4OC/YPMYoIdtQ8RBkDpIN7DpLsSj9TUGrxJuxUL69bZbmeQcHXkWG32xDCHlAec7p1AUUbzpPU9oQOvp/VwoVZgulRqc5dZjfZE6HHZg3C125Cp3ouoBA6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803409; c=relaxed/simple;
	bh=W7QWppO42nNFunrHW0x5wrq6A32TuLyhp6ZUGiac+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=airWJlPPfY2FerQeUtz9B39knV/Co2GCK2x9RsofDKI563wHAdUh4wHF0fLwrIMKOYZRqFIxDHO/jWnjYnTFRu/xn3t37wiKNlr44pWoVOc8T8qQjfE24dw2VS5w44QV0YdeD8CnaBMQ42/h3mIiRsf19ddFR0OTMUDeN0pRoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bmtp8f3i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477770019e4so25000995e9.3
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762803406; x=1763408206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTWCP6bTspm09Lx1U+q7f0BGQls8hOwZj+qwEbwY0Hk=;
        b=Bmtp8f3ihF437cwFJkONx0B0z3nb9BTfIdUZ/AhBRg7D7HpbJAv5crsHZjdQXgOeAA
         MiFifiCKwN691N/naK0GgAf+AEX0SW8TkBtumqkTk8VUPVmu0BN8Ek6bfoUEl2NOvZwZ
         1+vbmjJKUbZCPhIzuIbZ5Z8doWYwBNLaWWwHRpBXfzVE0nozaesXeNoOMOQ/dfcCGdAn
         ijV0M8LOn8zJa63WmV73roZn01oCXnFN9Z8DAmAecfsEfikoWLPGdyJFMbDNcmdXEigD
         1AZOAKeAvKjuklN3446J4X7w7SxVqIqKfSaX0rA0DiJ0QU6uTUv+Py4lNw0p8PgErjQe
         4+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803406; x=1763408206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTWCP6bTspm09Lx1U+q7f0BGQls8hOwZj+qwEbwY0Hk=;
        b=ev+oXMG804AJLmg+8INEFiQF4IWRI8d16KSkJJo9IHbOqy2PXlL8uucQNjqjJjdoA2
         12LsAdYThFrUgxuGiov+zrf6bed2XGZuiqcvzLlmf2ClXmwKTf4DGGOJyeHzH1m9JE0b
         p0Yxm75excAJpDHX2dXFRqeyXAhULMPA7JADdboBlDUkp/TXXN65eZcH+rVTOC4CRf3L
         RwpPgv8gAoxT8w/3evlRasQuo3C0F6udJk9Uxx+83+s0LI/kXtT/YgOG4pLLX0pfXBze
         R4M/wLpFTFoF2Ge5R4Ap4PXKR8xB7lRofDbwoDpsnloRD70q8YfQa1cX3sxnXtatWPHu
         cd9g==
X-Gm-Message-State: AOJu0YyzDKaLvzDcOYW+xTzFQ4VsEK2Cr7oDVrMc5T3aWIjLAs0jBHij
	cTxPirDu0YKPynCqb8pjrXUdPfXgtCY3fSWE7NZPTk+oDKBGBZNeW3+MVbgjZr9DcGnn1UPzI3k
	2ou/o
X-Gm-Gg: ASbGncsnQtvGwLHTLfuvvZn3b4cVa5Foy0dFB56TPXP+AoIt3jeEhaVDPXedB5Bk3+/
	mFEEEjjY0DMMpgyPJ99bHA/vtN36uI2unYAletZjnSd/citofUe3SqqMcMBhwyL0CkIg0QcujKc
	FRUp3GY82MPMlWkEuwos3w1ZhrrjN10FMjAwU8xlbNND2ub4YhpCJec5vhIw0Dv4HN9hYBbtogH
	NibeCw+xsLUgKQq17XdhBkJ8D3GGbJd+mwVKwo4aNI4Maznolt1E6C6ls7pelHeLSyLBwM8l1ep
	snvuegtitWVmX+HgsNJsE47d1mcjvij4YjKZneqzJRd0evJBJc+9SEwCLCjpS/QXWGBg+LrjFm2
	Fmyf0ZOgxqQQs1kz3RiibjroewZjQCZXmXzkbGa7fDmPuh+yU/dL5iK6FPBUtueh6HWgwpzG3jA
	USp06PH1Ox8MMcVbOJyHCcPRAH21hqXo0=
X-Google-Smtp-Source: AGHT+IFUxtkfJc5KA5FIRPDpNTMLzR7n8nqQXez/mScawaL2NDNh5hWWSSs2Qhhirt5MIsnvEx4uwA==
X-Received: by 2002:a05:600c:46d0:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4777327b249mr88103205e9.27.1762803405768;
        Mon, 10 Nov 2025 11:36:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm336766725e9.13.2025.11.10.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:36:45 -0800 (PST)
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
Subject: [PATCH RESEND 2/3] docs: cgroup: Note about sibling relative reclaim protection
Date: Mon, 10 Nov 2025 20:36:34 +0100
Message-ID: <20251110193638.623208-3-mkoutny@suse.com>
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

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a6def773a3072..be3d805a929ef 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1952,6 +1952,10 @@ targets ancestors of A, the effective protection of B is capped by the
 protection value configured for A (and any other intermediate ancestors between
 A and the target).
 
+To express indifference about relative sibling protection, it is suggested to
+use memory_recursiveprot. Configuring all descendants of a parent with finite
+protection to "max" works but it may unnecessarily skew memory.events:low
+field.
 
 Memory Ownership
 ~~~~~~~~~~~~~~~~
-- 
2.51.1


