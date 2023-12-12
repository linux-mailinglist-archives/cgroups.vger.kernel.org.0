Return-Path: <cgroups+bounces-921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662C80F8FD
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70BC1F218DB
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA665A84;
	Tue, 12 Dec 2023 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdqF6PJi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E8FBE
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c6839373f8so4518297a12.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702415862; x=1703020662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxiCx504yHLmFes8dR2H4gaz2egSElvJRBaPgOOtpHk=;
        b=IdqF6PJiZgqoOF91vWkL9uv6tUIpcXv1DXnHvXWpQB8m5+BNDhZ6YJV13mIh/F4muk
         gpm+FM+y6gpy8b6eC6AxF8ckl4O+zv0SbDTwYolCQMp6dP0jC3UNVqWAFaTo4wYHoStB
         qhUIcaKRPNERf6kVb02TsoFI3QXDHgS0YuJjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415862; x=1703020662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxiCx504yHLmFes8dR2H4gaz2egSElvJRBaPgOOtpHk=;
        b=ft7x8BtM23flEXO+w/YuJyIx8rZjDA5pILtq1hIIZMM+XffQWqWfas78hksGJZPyPr
         xPIaNji2CtIpBSKgvp80dKqB0nE5aWvdoMxoLbWMM4wjj7F6wqzEdOxOsw9OZDd6AU43
         nWmwjbEb3DiYPNN+nPNYRxPxvdLhiRNiyXc9Zj5DMoZCIYqnTdQ7XwJbXk40HmS4323N
         Q4ke+SYCBVx+4L4OQkolw0YQZ/G9DSjAg2Cqhyc+Xkdvqa6kmcgpGyp2kz0i47y3s/KT
         xMF+vDXSdLeVo8wrnjWlgh2G3KhL18/BoJkmm0d/sMTrhGLwVO6yILE0tigCsxnpYabI
         dG2g==
X-Gm-Message-State: AOJu0YxFKpnD1eQsGL6MzA4tOxY1sC4XkI+eVJSP+vEeRhQDu5B9SV6Z
	mECMlCfgwCQN9ZLc7Z4RLMHWdQ==
X-Google-Smtp-Source: AGHT+IFZhYAnfJATAp5f8kNXN8iWkuiSMleFokPSoTjfG2AtdN5pQcDE9+7YEKuV8bBVd3VgTPcxlg==
X-Received: by 2002:a05:6a20:54a5:b0:187:4118:140 with SMTP id i37-20020a056a2054a500b0018741180140mr11548864pzk.24.1702415862593;
        Tue, 12 Dec 2023 13:17:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b006ce2e163776sm8602974pfe.106.2023.12.12.13.17.41
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
Subject: [PATCH v3 2/3] kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
Date: Tue, 12 Dec 2023 13:17:39 -0800
Message-Id: <20231212211741.164376-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212211606.make.155-kees@kernel.org>
References: <20231212211606.make.155-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=keescook@chromium.org;
 h=from:subject; bh=JAJdaxInWUYVNuwIwA8b/GPyHonLetqQSJoS2H+M0wM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleM3zBNLwq83oMtldatGW+UhXwbgyaP8FTFySX
 SrtWyh/9ueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjN8wAKCRCJcvTf3G3A
 JibgD/4ufESExpzCqMOVFpDS9aGRGAsdrjazCpf2iQUYdg+lI0jphQkKsm1h7avlTW9hQbHum6L
 XIDQ9PZDb5lLDOIrjLmhf+1t7dFf2HgZDEIL9C1UB40I4ze6I2zfTCPr2rv8KLL0jQEAk/HF/kD
 KBPvKK8EjofpwVMA4R4UkK3MSVft3BwsaFymv8tPSnP28RqgaQuGyk8s0zXZQhgnhPyCwkDppqf
 d95VD7b1tomfnFI6BYSAVEQHrqgDQnsPn3M6mCHHHexOvtBkfDk4zqvVq6BsLavJz8cBTGpl5h6
 vxv838RYpK/CzhAc+7h/dvNtSXfZ4DADXAYimQlIwpLns6ovAhAtiGPrfqQ7i86/H40wiFiPnaG
 +rH5o5weDvcjdYHfuJlPCkyF5Y+dzImoFy2JZRb1JppWutCqQbNlDaL7lsICz7Qlx+q85h+3qJd
 2lCyNhZz4U+/Wd94y0/qO/r45w3UZU7w268hZ2/cHdHl8TUENeOm6mtDtw6IGfMrIMlgvWv0mY7
 w/YnvghTBDpffCRAyaI3Hd26Wo1a8mN2xSSugompKNDzZFvwfsz01buF6HmE2hHT77Zn+Qzg5Uf
 MFVhfxh2inSL/3Epv/vGCB8mXxgG2gV5JfEib/uhKFmdmTC84lECXJlavTsoFplQXRWLyHkCIvc LPtZ/+CnQncuMaQ==
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
Link: https://lore.kernel.org/r/20231116192127.1558276-2-keescook@chromium.org
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


