Return-Path: <cgroups+bounces-864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB37806F30
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 12:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081801F21628
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94435892;
	Wed,  6 Dec 2023 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZF4Ux4a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC04B1BD4;
	Wed,  6 Dec 2023 03:53:38 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d855efb920so4008538a34.1;
        Wed, 06 Dec 2023 03:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701863618; x=1702468418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea4fx7tf3EdIdbvH8Aap6LzVpgikoR6v5si5mFB5mQA=;
        b=nZF4Ux4aB4DQ9ay02QeGimqCd9aJWTte2j+eV6fFFMzurSy4mfMb2Tt3r2g+Ftlt/M
         9DsvuZ9C0p960iyFx/mQBeey2AHBMrCEeEeCuKayeSv7XIKOmuyj+YDyy18j1aN4xsUX
         B33WdNOGFjsn6ZC5tYaYrTDUGTodjtODPv9OP141zUZ1qp+u2hMZDRXlRVoFOf1alf3X
         NrgqwonzKDbfJtPeyvgUawWWNxJifO4+aspSXgIYbsthf65CdWTEe1MaTAUL3MExGkq0
         CQKxwMGR8NZSKNQTpjFv3Yq9JjotYAJlG9dpbcFyYFLTfXKwl5xseBoRRl6fPoWIBIc5
         KdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863618; x=1702468418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea4fx7tf3EdIdbvH8Aap6LzVpgikoR6v5si5mFB5mQA=;
        b=perebvSntsxSNJnX+U3aGiE32WxMGHPIiKQMUKyzLXEAP8S9OB/3hdwlqXpgWXrgbN
         MmL29L8MWDvuBLisYzNJWmgImc5BOACJjQrEQa5dsuKUylkakVKLPK52fkWrQGhzK1Cc
         TmhBmjURJPUOYBXgwVNj8KWTkO+s32+VAnh2PZdYQOcf2RAtrG+84XO3MtX4vd+VxHOI
         yq/s01DsfNdsNFkim7yKuV+lG3+8jaP/ivOIg5mrhyZzjsW0e7HpFMhGCmMuhETaij0r
         YAizwM04B55soOCthgP2kYcKJacg+neDke1CqLvok6ZU9U/DlgkYdPkBrtGqRvQUEj9g
         ez5g==
X-Gm-Message-State: AOJu0YxrRs4e6+lZ6Qw/ASS1Ccp2eD9A0aW7BxZQbi9oOAD8kw4wlPr1
	S3Kj+PEwJW50esRFENWnVj8cPnZCF6dnaEHx
X-Google-Smtp-Source: AGHT+IFuSrtaxMLQeDaoWZZu5QFiRJJP5r/IgMZgt6tQnsGehWvCOQGz7EfNVBBpLQLoxUxs4mQoJA==
X-Received: by 2002:a9d:4d88:0:b0:6d8:7820:aaf8 with SMTP id u8-20020a9d4d88000000b006d87820aaf8mr878411otk.21.1701863617853;
        Wed, 06 Dec 2023 03:53:37 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5484665pgd.28.2023.12.06.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:53:37 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
Date: Wed,  6 Dec 2023 11:53:24 +0000
Message-Id: <20231206115326.4295-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206115326.4295-1-laoar.shao@gmail.com>
References: <20231206115326.4295-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current cgroup1 environment, associating operations between cgroups
and applications in a BPF program requires storing a mapping of cgroup_id
to application either in a hash map or maintaining it in userspace.
However, by enabling bpf_cgrp_storage for cgroup1, it becomes possible to
conveniently store application-specific information in cgroup-local storage
and utilize it within BPF programs. Furthermore, enabling this feature for
cgroup1 involves minor modifications for the non-attach case, streamlining
the process.

However, when it comes to enabling this functionality for the cgroup1
attach case, it presents challenges. Therefore, the decision is to focus on
enabling it solely for the cgroup1 non-attach case at present. If
attempting to attach to a cgroup1 fd, the operation will simply fail with
the error code -EBADF.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/bpf_cgrp_storage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index d44fe8d..28efd0a3 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -82,7 +82,7 @@ static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
 	int fd;
 
 	fd = *(int *)key;
-	cgroup = cgroup_get_from_fd(fd);
+	cgroup = cgroup_v1v2_get_from_fd(fd);
 	if (IS_ERR(cgroup))
 		return ERR_CAST(cgroup);
 
@@ -101,7 +101,7 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 	int fd;
 
 	fd = *(int *)key;
-	cgroup = cgroup_get_from_fd(fd);
+	cgroup = cgroup_v1v2_get_from_fd(fd);
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
@@ -131,7 +131,7 @@ static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 	int err, fd;
 
 	fd = *(int *)key;
-	cgroup = cgroup_get_from_fd(fd);
+	cgroup = cgroup_v1v2_get_from_fd(fd);
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-- 
1.8.3.1


