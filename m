Return-Path: <cgroups+bounces-922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE18280F8FF
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7ED1C20D9E
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1666414F;
	Tue, 12 Dec 2023 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOZlfRw9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F3D2
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:44 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5114511a12.3
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702415864; x=1703020664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qCHVo7XzgiM/gOkeUKMtC009iJZbF6DLauLv10AR0=;
        b=WOZlfRw9wQcJVZU/DcREddJjA4kuDbVQF2DFHbCFVR9mI7ZlShplJ0MQo8eOvD8B/p
         hD+hgaEgYfIlJXfDf0IJUF+OWGiCFz3h/TKZ8EV61Pz/sg3alLeUsJV6UdZGWx2PP1rI
         63gDiQTni9P+W5M4ftrKbVUksn0xHUKES0A+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415864; x=1703020664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0qCHVo7XzgiM/gOkeUKMtC009iJZbF6DLauLv10AR0=;
        b=DMk2szF/IL0gMjlTJwYsRmquLoYnZN7puNYxa0PERD/pgEiZ3RgKlZ5hcwnYXe3SIG
         p86LueUTSCkfSwc0Xg0m15dsZAqe7d0ELu+6eQE1ituGHQQ/iixM1PssRH18qr/lMu0E
         Pu1vdSNStorzafirfrIdnsjpUy+06poAWW9D0rle18jCHIbPPbMb32olozjKxAtzZhEk
         dt5eYiNHv/PAxzVaFKadm6FKm1yfmfsVK95RulBC+IO1QpNWR7j7PqjrgTQkrD/VAmsI
         bt3ul+YRFDANKuO16udR+v6xpB/PCONatbeABS/IjNpG2Rz2+xf1DIHOFQ55Zb18ufJJ
         bomg==
X-Gm-Message-State: AOJu0YxMHJi/By8I64D/qCTd6EgsKH0l8gGvJZt0shKC2MwFcy5figHf
	v0uWcWTd+c9ZondUKOgyxEki5g==
X-Google-Smtp-Source: AGHT+IH0jtWZUf2hGPaaxQrJqxuBCy5YRYRX5P8B4FrkUSNzU8QibCISdfs+bItVAVMNJIeIAj6vqQ==
X-Received: by 2002:a05:6a20:1483:b0:18c:9855:e949 with SMTP id o3-20020a056a20148300b0018c9855e949mr5672480pzi.15.1702415864415;
        Tue, 12 Dec 2023 13:17:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a63eb0e000000b005ac384b71cbsm8583878pgh.60.2023.12.12.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:17:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/3] kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
Date: Tue, 12 Dec 2023 13:17:38 -0800
Message-Id: <20231212211741.164376-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212211606.make.155-kees@kernel.org>
References: <20231212211606.make.155-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=keescook@chromium.org;
 h=from:subject; bh=KaMikVVf9IlMYxhWSymwvYJ80Grx9jhkkXD92Gcwols=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleM3zg8fq+Kgz91M5MgN0iGKTEy9c1pTW6k2g3
 Om7gwyq3vSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjN8wAKCRCJcvTf3G3A
 JiEbD/9sPG6e4XUmGL/t2yQxqs/Tot72LHnqAm/mN/d6Ly5AAAqHsoFvek/mQG8wTg0lCNknNj1
 YF1q7adAapgFepvZU8OXC+tWuPzPLcG3o8K6Sgkeir5yl9fwIzvjt/J0dJZoYYENLHghz4BAKXi
 rzcIQJGt+KoQ1kgGjloXVMlL9LG0DZtXjSoBCd9a5u77yL2JMD/XxJt/ttDsxn52o+ts7JLolAo
 YKyCkIpgJbBrALTTmUjiOCIh1UJzxnQFkN2EtES96fjl+CVDIg/8tmBk5AZZDTh66MQ75dbLi6I
 +1n+T71e3pcJDw97P1Hfd7QmLBAQSSNgTD8DemX7IVA52zA01seskFB9mwF/8GYRzvm1TJisAqM
 PeNcVIyvLDfy1ahMBfJszaBkCqnOmmwjVGfSLGhtq93fVgtjaD4zfyP0UtsNFTVVbjQ9tU84hev
 7dd6XddCX4RE6UvGt8qoPYZRUlkfb84C+zWvymEA2Gn/eaq8y5odSWRlXl3WFPW3XDvilS4fER6
 qrMi85l+bsuNtfTSIwl/x6YCRX3j3zmPwmaI6n8VA3xjMNARhArAAAdpCpG2TjocSWY1ZOID5OX
 xUkJTCaX7P1h/qoC1gVn2OIdWrbRnbsAXSNrAplbX1sBjWSnBCAUqNNmxw93lDSSn/pSyBZGigO UaMJYSmjnQJhdiw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Link: https://lore.kernel.org/r/20231116192127.1558276-1-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..37353901ede1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -850,16 +850,16 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 					  const unsigned char *path,
 					  const void *ns)
 {
-	size_t len;
+	ssize_t len;
 	char *p, *name;
 
 	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
+	if (len < 0) {
 		spin_unlock_irq(&kernfs_pr_cont_lock);
 		return NULL;
 	}
-- 
2.34.1


