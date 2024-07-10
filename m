Return-Path: <cgroups+bounces-3604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4292DC01
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 00:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3AC1F26107
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183D14A606;
	Wed, 10 Jul 2024 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9GN5ooH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8289848E;
	Wed, 10 Jul 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651473; cv=none; b=Hg/WY6IqZ2IZ7t20mh87hLFGIwXUjgnIJY+T5z+olRg731UR0vliH7PYgUdPQ+IDlFaX9yh/14GhrehobLrAKdbGFTpAbYpBsiFq/ww8AxvPvfbeh7CEjZ/X1q/e2qkyOWIKfXOBkhrW0VqUzrzW/uDa/lU/96mZm9umxlIfYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651473; c=relaxed/simple;
	bh=fvWdhHLovgt+jya2TMB20BQz/oBbl2iXoIPBY6cJUtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JSkwHtbWCH46GY7erviP+DgUn3LgTIaHE3GeF7k7gl4U+IyVgrU9eQCVH6Wpa7Vr7TmI247Tke+PsgGaA1h3aAUpzV3XW+MDznuosGTDqWcPPDVb1ZyKN6u33dOdpnHSzM6RF9QbgnVl98w5JPALzCVgDvY641RFtGMEjhQypeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9GN5ooH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb72eb3143so2157575ad.1;
        Wed, 10 Jul 2024 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720651471; x=1721256271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gk6sF82NF1Ybt4+7fvH8lVGCFlFLbxNhBaoEg2984M=;
        b=J9GN5ooH2wgR8MPiS2/hhiYxQZpcKiiPagkVPBOYYwo7bOS1nDledadYXyzMbWhNkK
         VChER6fSo2Ik+0qvg/fISxjkfo4cGO+prQ9YrC2A+nftFyi9HH4XkEddOuDKIGCG4Lsv
         olN/ekBvoA2sCbh5m5L5UUWim5ffZa2wfaPPslN8SqVFvLki/h7Z/F2lgt2tq2xCRNc/
         KiVkPv59Q3WLCGrw5Vk/DVlC7MS/4DFB3M4y0Keeh+NKjev+P9YDtkLsE8+V/rFv+ceF
         7cH+/hAF/iEQ2FWPhGq4M2yHECno2v5nhyQJnXT8V9Ifg6qnt1C3QVz8NAMHgO3dqGWR
         CH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720651471; x=1721256271;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gk6sF82NF1Ybt4+7fvH8lVGCFlFLbxNhBaoEg2984M=;
        b=ZAFC8wOwESmoEQePXSeA98KOvSywbXeBYOsOQJrwrgvl+FlWoLJVt7aIWxBWGmsz0W
         Uo9Oa9pZvVYBTSYrmHzwe9N8UAW/8QtMOP5o8g4yqtNR6bdQ3Uifuvny4EJngR25lVHT
         m0RmrGKnCQl+jpxuLA5Bo4tV3DgLlYjwjWfJ4GfzhSQFo8WWTNiU0n7JHpBosF5dhBIb
         TEmgBLJVNxuB6a2QDAQMy6VLmyAqsZ6GnRYg0AoXdxU09iQDwVxqbjQCYQPaTLL9LATx
         jBric2EVObI1QFMv1Q1xW4xBNSOhjY6qOmlN39Q3HYB4s7Dh57pu62t0TLPwL219vPRz
         iVoA==
X-Forwarded-Encrypted: i=1; AJvYcCU0CTQgl+Ek/x2d7m6gbRJcK1SrwgroBg/jb/8/pAIb5Ivbf8vy4lsQHdzKeAg8E5z92lDkPYCu+RPgf8mRF+Tx33b0j3UyK42CIgKqa9DTMmduDJM6MFW5Vs9xK8NnnHMbQP+PZg==
X-Gm-Message-State: AOJu0YzWCgAX7+CkMUCNZ6lTG3/sVdO5OFwJ/fSrx7ee9ArgyyfFxVkt
	5wDTiqf/pq77cdWRcIBggD1Wx+TbM+zpZYR1JeNUidThCjPt7tk4
X-Google-Smtp-Source: AGHT+IGR3P+DEu0XNM3M/nOjjd4cF4m2J4U96JtQ8AJIJRVngGyjle4NU0oZq3caIF4sXXz6SgRVPg==
X-Received: by 2002:a17:902:db0d:b0:1fa:1be4:1e48 with SMTP id d9443c01a7336-1fbdb9f99bemr12093995ad.11.1720651470982;
        Wed, 10 Jul 2024 15:44:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac3111sm38394455ad.212.2024.07.10.15.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 15:44:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 12:44:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Message-ID: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Michal has been contributing and reviewing patches across cgroup for a while
now. Add him as a maintainer.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..3dd70792f572 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5536,6 +5536,7 @@ CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
 M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
+M:	Michal Koutný <mkoutny@suse.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git

