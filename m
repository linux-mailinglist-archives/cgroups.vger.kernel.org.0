Return-Path: <cgroups+bounces-1431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1BF851FE0
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 22:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF494285A2E
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E54D5B4;
	Mon, 12 Feb 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/12o5m4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43614D5A0
	for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773979; cv=none; b=cgy3AUUjQ77cVH2LH1x0N27WBuDwLX65mjOXSxJUAPvvgJLljDbCX021lDZpZcDAFJAhIXOt083sM5NaKLVPi6zaO+V4o42QzAhj1gskTZ48RMMcuaA7WfpKuWZQnh3bquUl7xIaInDY4hT+PyZYEHcZhXH/HUInlPhfs7/zQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773979; c=relaxed/simple;
	bh=xFlCSB2BhnykCmQeRsN0j73C4UQlJIZav61x4g1IDdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r5/QTFO3g1h3iqHKedjUWYlsIIbBUMt5xcswxCtuLent90CWsR8N5XZSReK0nl9JNomVtjO/oPckh64mwvG5wPyJ+6O+FAw3oSkssykU2EcI3NA4ybHfKarK+3sCk62ztmBdNkuYZQG6iKbqlhVBcZu45qKwBSVapzSYbN3ifIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/12o5m4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60665b5fabcso4468677b3.1
        for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773977; x=1708378777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9b+4SdACUtX02zckFp4W9j//70BE65Et6Qs8xfY7vk=;
        b=M/12o5m4O5L7Cmffsgn+3ctDjJPoIyHgXvE3XohbdSYRip+xxol1RqJnieBh2IzGMa
         IDFtU90EoNVA82v18P0o/JWnTomPM6uY3ZQAPrr4ahvpyZMDM+dStxQlBD5eqVRlffgF
         snXt0E61LpPpNQ+XIhMNHZrgGIQeSOT0H4s4bTt2zOL2BAmWPW0WMIVI3taQ5KYC3WgQ
         vOC0dGwchTHXwYRDyWMILr6gMYkQrxa9+ZQNR3UQzbopOalvnHuoAosmbAWDeNx6txbq
         JjE9mAOFaYIen/RqAR4IL+CSiZDMxLttO3VY8u4Q5LDRwiraX7gghY0g3/Oi96/KNSBW
         02Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773977; x=1708378777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9b+4SdACUtX02zckFp4W9j//70BE65Et6Qs8xfY7vk=;
        b=feo70dktunRowo8jZD6jCKer4QeiokuUnukbe5LgEAbdZ3ZtCQ9TmFNs227Diqq6i3
         4Gs0g9h4sTRihEzJJMn3o+og6eBCJcBHNuGloiQcUoELU0CaaO1X2Kg7W9aTy0qXMrrJ
         zap0mToYZ8CcPM+GPWbhYJ6dpC60lpabrEIFytECcGjfIrAVN+6q7pF/u8Uc08mldY2T
         y9iLcJpim/cOmx9cuOFelNGBeZfbvTVBchbyHwY8UO2vxyqivlzZ0+DS8VVlFH+mpES1
         HM0Lfm8hOF3vrixGaYMtC/+gQNeVoNEt6iiWWxZ6FU8hRf4lVxh0xUHIAY+Us/qHu6Lo
         SXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9C2mzGRPhXcwfZmDqBDwvCJHWgd4S/YQ6YGWf7b5pzGQXps2fBRQT55XFiu4ITcxWhHHB9iR+FShmo2EfYNAsS/IfsGotAQ==
X-Gm-Message-State: AOJu0YxoYXwsNESsc/DikI4ym+skkSoUCpJ9qK07ozH2QQZ/4G+8h7M0
	IQuJRvnluLRTdDP64r2O3Qn6/n8uA2fKAjUAIRoe2iWvOMXDICCL2ORgkvlrJtXz8OnAus0FpMu
	nmA==
X-Google-Smtp-Source: AGHT+IEGxw+pumepe2rycJxKPCLRRtMyemZOKJSP2HsBcIOyAk76oq0qhFPUoU2Rl7QOiTv7xvjwgacHnLI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a0d:d495:0:b0:607:7f86:dc24 with SMTP id
 w143-20020a0dd495000000b006077f86dc24mr109272ywd.3.1707773976926; Mon, 12 Feb
 2024 13:39:36 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:48 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-3-surenb@google.com>
Subject: [PATCH v3 02/35] scripts/kallysms: Always include __start and __stop symbols
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..47978efe4797 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -204,6 +204,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -211,6 +216,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.43.0.687.g38aa6559b0-goog


