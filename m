Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96BEF185
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfKEAAB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 19:00:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42211 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfKEAAA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 19:00:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so11110961qtn.9;
        Mon, 04 Nov 2019 15:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3SAFhWytWRsOw7arfqXaOD5T2u5Zhg2vpO9SXodrC/A=;
        b=CTCLfdhkpDgX8suXA2/gh1Z6TjiX6DhZVUPJ8sPRgTSylvD0AFGxKvnJdEBi6n6wn3
         fMBhWroP9nhCGOI0To5j/dkt0C9nee87OfCaxB1e+kzhhr4yQQyFf0tZIlX0R3c2BmCQ
         TexU+JfD94MQ47ekObZWXLdusQHVTMvc64k+UYTbTCgg7Er1g3YPsarS+YNmvdYwFAXz
         CpDO8dFf17J8Uhh0ZluJk5Rk5D132YQC9/rUkwNZ1ynTyTq/CeG6NhLshpxg0Kc2iM+a
         emAjEZ1SiujyMWC+UN1zJMkgPkYAeLQ+QT1EkGgAlFLx6Z2XDXfJ5wGp1p/kCLmOJbp2
         BM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3SAFhWytWRsOw7arfqXaOD5T2u5Zhg2vpO9SXodrC/A=;
        b=ga6RqtRSQr5sjlwZSpt/5T4yEwuR7NyXYrnjcuZxuAWhqu4ao1ROiWRD+C6mmPTLVt
         306K4Q9rvfsdiSysbzs/+8eDHGMIDHEF6WGiFEYenMV2Ka0IECMowxTnNqFs3fIhwsR3
         zNk/DgquojUQ1BJyO3thGPbVCbr7ae6pIGMKWqEs0AtkM9XirN6Fp4cYIFA5/ex9N2Uh
         bWUflADnI4/EEGacfvGemgpVlWIudqAt+gFSlLRZBh++FDiTmGIJGaIByIgXuCxPS7Df
         /TKRL/8xrH5nCNnbAfDJblnRvSf0Z5Am+ssdhtCPXc7bzJJYmhEMz9cfA2jzkrqXTCJI
         o6Sw==
X-Gm-Message-State: APjAAAWhNR77ejMHrb/bdFcJz6U/KsEUgsJ7rWmSnNhH6JbVTpeDcEPA
        LS7AzZOAy1hKR5OAf+icAqs=
X-Google-Smtp-Source: APXvYqyOlVhf+C9gENRHHF3UIxuKTD0HhnnGzVSi1PQS+gS8eGio0sHeuOr5C/PKlqJQSL314jZsXw==
X-Received: by 2002:a0c:bf4d:: with SMTP id b13mr415128qvj.115.1572911999034;
        Mon, 04 Nov 2019 15:59:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id f24sm6499126qkh.81.2019.11.04.15.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 15:59:58 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/10] kernfs: kernfs_find_and_get_node_by_ino() should only look up activated nodes
Date:   Mon,  4 Nov 2019 15:59:39 -0800
Message-Id: <20191104235944.3470866-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kernfs node can be created in two separate steps - allocation and
activation.  This is used to make kernfs nodes visible only after the
internal states attached to the node are fully initialized.
kernfs_find_and_get_node_by_id() currently allows lookups of nodes
which aren't activated yet and thus can expose nodes are which are
still being prepped by kernfs users.

Fix it by disallowing lookups of nodes which aren't activated yet.

kernfs_find_and_get_node_by_ino()

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 fs/kernfs/dir.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 798f0f03b62b..beabb585a7d8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -714,7 +714,13 @@ struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
 	if (!kn)
 		goto err_unlock;
 
-	if (unlikely(!atomic_inc_not_zero(&kn->count)))
+	/*
+	 * ACTIVATED is protected with kernfs_mutex but it was clear when
+	 * @kn was added to idr and we just wanna see it set.  No need to
+	 * grab kernfs_mutex.
+	 */
+	if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
+		     !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
 	spin_unlock(&kernfs_idr_lock);
-- 
2.17.1

