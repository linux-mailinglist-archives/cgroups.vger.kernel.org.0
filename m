Return-Path: <cgroups+bounces-4917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBBA97D3AA
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895831F2763B
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0574C13AA27;
	Fri, 20 Sep 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HL3nKabx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A81CD2C
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824813; cv=none; b=Jj5htshTl9JMkUNrZHf+CekmsKxFimwnd+Bdw/6FywGNVWMsyww1NKOjNIM5yFayZLDd1Zeb84KJjuoZZGbc03vlMIrRDRRVyU3B7knRtClVoRoxpJWqpT3INhWybe0LO1ljM18WFzfWTulzcGFZwH8k64IQHRkkgC2P4zRkJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824813; c=relaxed/simple;
	bh=ZllCOAIlqEFkJuGBN7DnQ6ERmuR0KccvKqhqJjzU+9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqPEZ19z1GQVYW+u65tmCBBXpegWkE4Wyd56ICIZxRA+kQegPJWXnwvLoZZjyC6Y9qNFL0O0+NQgJVIGKBsoIqmG/F3/ZwhwEKTHvamD/J8QogrnCv5iBN/vigR8lCXwFjGXHYE24eYlGmljBzVBgoL1F27N3dSjY0mkW5BOHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HL3nKabx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-208ccde82e6so15504855ad.0
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726824811; x=1727429611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjDICCYdMHK9p7Vg6FZCstajk3nIc6y5STGdL+C9iIk=;
        b=HL3nKabxsicmVuLOXk6UAUWjdsSu/1QhnV4PD74zYDw56l8VQnfovEBhJxMVngugb1
         A0zOV67webqs/qTrFl6DxFr5kyidgix0FdqsdCsJLiMxTeM12LeiV/gPolJYKiVuBUDu
         gRUmzvdRD3/smflKMkvjoBoNBKmQSFlPU60oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824811; x=1727429611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjDICCYdMHK9p7Vg6FZCstajk3nIc6y5STGdL+C9iIk=;
        b=dVHmT986NyKp9oITvKsCseQLyLxdGSepMU0mFBCTkeU019vl2nppF1J5uoRudhG57Q
         5p5whdrwwWb7cwWj7Cr8jjmNHL4hq2aH46GjUj42me0t/3upMIFGo/LeGVobVMNWKAtg
         sEqs5Y15oETHzpWh3oqLQ0fFRwnUhWaStZ7PJNyMnxnmHfPcc/xFtXKoZgvJIbTmzrAP
         h7NMD9EL/6AcbhlFYhazYac00lDkrQ1bHs6ogiBNosBxKeSRDdO+YWedZi/PmgyB5ZZ8
         XRmaavrHI5YktiQe/O5ifnP7j1ZD9FKWlQ0QlOhkI6KxxBejLYqiulO8yIEFJpQfiw8X
         wJJA==
X-Forwarded-Encrypted: i=1; AJvYcCUFk4gKRndWbaEnq6XL0GKOJ13wd3er0CCfnv5HFpeKiWACFRN8763aUi7NoFw+C2pn7I4wnWew@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GCbglVmmet1ujdyVqr6hfpKyGGQHeJauWE9pTsDUPRunzzUQ
	hisES9IUgGcgyhe0hMladFPeA/+35XaVrvA5yxBzI417xeGWxfg6HELo+A8OHg==
X-Google-Smtp-Source: AGHT+IGzYqWtcLKjVx7ZjBwW06hxxEP0BFYiYRaSYnmmStMwHRUjNQRiqIn0/PreFojq0PGVQRDxeA==
X-Received: by 2002:a17:903:191:b0:207:1913:8bae with SMTP id d9443c01a7336-208d8397c1amr25156115ad.14.1726824811514;
        Fri, 20 Sep 2024 02:33:31 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794602c3asm91638755ad.92.2024.09.20.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:33:31 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: pchelkin@ispras.ru,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: chenridong@huawei.com,
	gthelen@google.com,
	lvc-project@linuxtesting.org,
	mkoutny@suse.com,
	shivani.agarwal@broadcom.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	cgroups@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Waiman Long <longman@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yafang Shao <laoar.shao@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v5.4] cgroup: Move rcu_head up near the top of cgroup_root
Date: Fri, 20 Sep 2024 02:33:22 -0700
Message-Id: <20240920093322.101414-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
References: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

commit a7fb0423c201ba12815877a0b5a68a6a1710b23a upstream.

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The current implementation of kvfree_rcu(), however, has the limitation
that the offset of the rcu_head structure within the larger data
structure must be less than 4096 or the compilation will fail. See the
macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
for more information.

By putting rcu_head below the large cgroup structure, any change to the
cgroup structure that makes it larger run the risk of causing build
failure under certain configurations. Commit 77070eeb8821 ("cgroup:
Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
the last straw that breaks it. Fix this problem by moving the rcu_head
structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1803c222e204..4042d9e509a6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -467,6 +467,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;
+
 	/* The root cgroup.  Root is destroyed on its release. */
 	struct cgroup cgrp;
 
@@ -476,10 +480,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-	struct rcu_head rcu;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-- 
2.39.4


