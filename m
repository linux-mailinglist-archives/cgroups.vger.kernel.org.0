Return-Path: <cgroups+bounces-457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C57EE763
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D231C209BF
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26E46527;
	Thu, 16 Nov 2023 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gksdvUXO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31977D52
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 11:21:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1128333b3a.0
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162488; x=1700767288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIo7yB6lg0mEMstu2RR7JQJ7c10/IQwKA8lnXu5L+VQ=;
        b=gksdvUXOqQfywnZfE/U/dRvbFNoqk2OdL1XDO2JtjQ5v8cHKjYv+3HHvN3Xc2t4pxx
         jYl0X/SE/yNf57xIwCVKy9YYoToydy5pimU0FbJ9e5ILq8XV65nWX5Ry0h5f/xv0Ux/8
         tmHpMPZUHqFGvTd83KfjtCu13x5CmwEB9NQs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162488; x=1700767288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIo7yB6lg0mEMstu2RR7JQJ7c10/IQwKA8lnXu5L+VQ=;
        b=trt2bxvlVe7ifRAC1QfMDLJYTaeQi5T4uIU5KtwbZlyUQY//OvfyT3S8K/Lb81KohA
         FXgg6nbQ+qKEsKpAGAlzLXr8nDGRZvQrN03ghOiEqepyWaWJaIKNPrCkMIIWHWqm8ixz
         tSn5oEglUWq+Uy52FRRnTef1D5HGNQa1hzEFWOr7Ws1Pq7UASGoDfBk3sYlDg0xGj0cR
         UCY7kbc3Z89A1aDDF30IT+wxs4mTaLUQkN2VXCUO8daZ77CV75+345BRbTBHGzhx8K3t
         zKfF5FDSrX/ca3N5imEak3coRMojdetthOY6gcBfYclkRtZKA49QSaaT0VrcmcC/VBlt
         3RUw==
X-Gm-Message-State: AOJu0YwFu8ZyLWQy9IlqIOzYORojTl+x+OKM1HBD/7iW6bFfJnv6W3ZP
	SPd0tDkfrftO71sOwVKhOqsUXw==
X-Google-Smtp-Source: AGHT+IEwPnM9Dx2nNDBuGD4lru9jT+pK5qmTq2kW6VUI6EBCZ4wKKaLw5OQNeQMU1nuyaJhO1qo8DA==
X-Received: by 2002:a05:6a20:daa8:b0:186:6cb3:477 with SMTP id iy40-20020a056a20daa800b001866cb30477mr16580809pzb.28.1700162488340;
        Thu, 16 Nov 2023 11:21:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020a056a00008900b0066a31111cc5sm83004pfj.152.2023.11.16.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:21:27 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
Date: Thu, 16 Nov 2023 11:21:24 -0800
Message-Id: <20231116192127.1558276-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116191718.work.246-kees@kernel.org>
References: <20231116191718.work.246-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=keescook@chromium.org;
 h=from:subject; bh=LRsHUfYO0eDcNqxdqH4Irr7bDjuYf6fIiWZiwxT3W+g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmu1weRodlm3lOcUmdMyw49wlyXCXGK9aCKK5
 leBJkEo/2GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZrtQAKCRCJcvTf3G3A
 Jg/BD/wIwwRk/W4vfmpcw3JeNwWAhbL25AwyJuBta59Of8OWThCkAoKsImJQHA/3k2NBUNS2Fwi
 S8ZiHqT8qaygVtCmErykGZeBzNtYaTjfHOBTZfiKjDX1YrdFjtjbW9VOeHR3vkDfDErswrhlklf
 22E55Z+V/rJHaf7jmrXD1k6ABqlVNQYs9jxxCJSSy/GwygBrxwJ1KcH4qp66EV0dcN04q/BhCOT
 ZUqjqaD1nN4eGnS8nEUvxSuwhxKt7qAX9zWWe6r1rdjN3iNxhyXDMooCa6tKQXlSwpdVlkqdT69
 gGSs7tLucDzx3R6aVpQsR4+s9RhM3sgsArYgpKaJEsSNmYqCAeG4/7VNNombjfWw0Bjz697xIDY
 lN3nUchv53ibE3bW5hNhK32eWaq7fXoyhr++bVF4iWgVb1YhvxMhD4iCDFNmg7oqEMUTpWzBzdn
 3U631WffbyCMCgSZZdr589/vR4ATcXf61J+X20n4pRN62zGTVvn742alOwMwzeu4BbeOuux1hfr
 lH8vjyDbNIatVWrktpNj5NZdHdoeQttsZgKMNrNjZ+y5kEKZ19+iLv1eGJl5INgxQ8Hjd/UP25K
 eOJ34S69uiPxy6L/8n3mz4Tql8Ib5tSlG2VloXBwZBuu22BVA0p+0KJ5VufGbgJqqa3OCnwYFml 1S7SeuZU1GbAWjQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Nothing actually checks the return value coming from kernfs_name_locked(),
so this has no impact on error paths. The caller hierarchy is:

kernfs_name_locked()
        kernfs_name()
                pr_cont_kernfs_name()
                        return value ignored
                cgroup_name()
                        current_css_set_cg_links_read()
                                return value ignored
                        print_page_owner_memcg()
                                return value ignored

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 37353901ede1..8c0e5442597e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -54,9 +54,9 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
 	if (!kn)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
 
-	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
+	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -182,12 +182,12 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  * @buflen: size of @buf
  *
  * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strlcpy().
+ * similar to strscpy().
  *
  * Fills buffer with "(null)" if @kn is %NULL.
  *
- * Return: the length of @kn's name and if @buf isn't long enough,
- * it's filled up to @buflen-1 and nul terminated.
+ * Return: the resulting length of @buf. If @buf isn't long enough,
+ * it's filled up to @buflen-1 and nul terminated, and returns -E2BIG.
  *
  * This function can be called from any context.
  */
-- 
2.34.1


