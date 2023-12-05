Return-Path: <cgroups+bounces-810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5F805777
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2961B1C21018
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B7537E9;
	Tue,  5 Dec 2023 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It2xyhk6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8501B1;
	Tue,  5 Dec 2023 06:37:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28647f4ebd9so3686893a91.3;
        Tue, 05 Dec 2023 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787057; x=1702391857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDMyRJVRBU1Pl/vxTZrHzj6WgoSS150xZKVOkhLmh/Y=;
        b=It2xyhk6HdXnVvEClXBSH/X+E3GMyVy546mpKBSGE8aEtzP2K21j85CIYH/tgEabyW
         9EXUVern/j4AE3JJbeIYhzkfLMidOf1StdrVsPpZNNiaBzR1aNGGeoOPZmXgs10DbqUW
         YY/DKhxBs4W0JHoWdg4z2ksItskioIdhu23z2uSsSjfctuAHYlDrLjchnbTqW6qxCNKV
         xFH82763msDyF9Y7ORk7kWKGEHdqG4rrpy6wtGYek7OkIh4PFOZMeBul8MeZ8Jl7evgc
         YC39vt+UsH1QSIkYboOmh2/+7VunNzA6IKL7COxRQIbnksTvRtkTp23NRgaTDrds2Huy
         90zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787057; x=1702391857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDMyRJVRBU1Pl/vxTZrHzj6WgoSS150xZKVOkhLmh/Y=;
        b=ZWdz/0U/O0NEpk2SajdrXg95MUzxjDe+e028U4YhTqVg4TBF9znEu2JgAhOhC0tgGS
         2ez0iDpY78zLaBdFEK8MaNZ/z6dQNnovf+5FDOkshgGBrJ1hDPElPYPYMdGtEfz3lpt0
         ZQc3kn5egsToJc9i8i0IKSLrs5Vgf0D+qyfuCLTSB0ezWzXOOZ28NKGJo5j8uDSBpznE
         AVoqQUvoPyJ2NJ1YmuY0ujXW4yIzfsHyLevRuDIi7m57/n4AvhEyiX8p39UEenrFJaoT
         Zwq1sV3c8f4K4+NW2/yQpRPrtQ6nuDSfxhGt0pZumqyoJ61n6RggL2l4bamleS+LiC/+
         24jg==
X-Gm-Message-State: AOJu0YzM91VeXhNYSCE1+Gi8boTrP/hkfQx9mXOdi7GKu5IqrIT0EL4U
	uq+3cxxPDXuIq+kldpOnhCY=
X-Google-Smtp-Source: AGHT+IFzgm5rd9O79Jv9E2h4zcirqybqctZxARlYcYxvAvBT99bKu0yXQhxKJg6fe1HnbmktFi1wRw==
X-Received: by 2002:a17:90b:1e43:b0:286:b062:ab7 with SMTP id pi3-20020a17090b1e4300b00286b0620ab7mr1010314pjb.41.1701787057205;
        Tue, 05 Dec 2023 06:37:37 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001a9b29b6759sm10286502plt.183.2023.12.05.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:37:36 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 1/3] bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
Date: Tue,  5 Dec 2023 14:37:23 +0000
Message-Id: <20231205143725.4224-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205143725.4224-1-laoar.shao@gmail.com>
References: <20231205143725.4224-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current cgroup1 environment, associating operations between a cgroup
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
---
 kernel/bpf/bpf_cgrp_storage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index d44fe8dd9732..28efd0a3f220 100644
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
2.30.1 (Apple Git-130)


