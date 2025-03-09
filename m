Return-Path: <cgroups+bounces-6905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A732A58443
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 14:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CD83AD534
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B91DD0EF;
	Sun,  9 Mar 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DnGFAOon"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443401DDC30
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526998; cv=none; b=k2GQp+xjdriNnzPQdcv1NRiYb9DO/R5J4f32lUfQfquTccOtKdfbJMyvJUaG7Y/1NlXNF4AEaLnt4xwWgABZo+UpC+OeTczVgs78udhcJVavwcvwEydDX4yr914Ra1CZzQrnsf8QgXozU5V2sM828nzvVM1duydgT0pXhF0rKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526998; c=relaxed/simple;
	bh=HBzrftBgtmyJjSlrkubZ14+wzgBNDhuJgvNUC0ysav8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbZSX0uO276PzLXLM6QXmFzY6scWYFIhJg9a1WnoDOUMxR36E6MYwoMBam9WaVJN6ka6wMrUY/EM0iXvCuCyMVplazZoEex4sASCQo5BNBoMXpKHWkOB3et+BmNgUvucpsqzJCA1kF7cFVxpQ2j3/YM5rfl3cNRjVKO8EWDXv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DnGFAOon; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 082DC3F85E
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526986;
	bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=DnGFAOont7kegxZZuYeEL0LYbay7ol3vliwUq0jV7RmqdBvuSPGc1rN+6LZCysjuD
	 3+5/2i6bAHskQ3F0CXFqbr3AfZ4aHyGGfRyI07YsZdOvCWhPHzMmsRNIGHt9V23pK1
	 JGx41As7ZL1OqWDUKXCS0As5VjQPpkXTcxEvzghb/l+GtWO9JCpA/NufTRJnp/Ps+7
	 fGN8CQJbLYBHNo5qSo5zohmY+iQydCsxFUQGLVomvk/8bwktAT4tLdFt5f+NdV0kKW
	 aRGW5xuP5Jk/4Kqpyw+T49u/Kxduq1ufqkyMM6UZ9HDIX4EVkPFWhgSZTHrmm9QuVt
	 L0DfaiNBi6e5A==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac1e442740cso317834966b.1
        for <cgroups@vger.kernel.org>; Sun, 09 Mar 2025 06:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526983; x=1742131783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
        b=VMq3tUzywAiovnbYauHWc/i9KmHza3rrB0u08rTVptUsiaSSnl8UFjEAKMpQPf8CXE
         Zwtn2WoXHkQe7NPiEI3oSZMXxmLePt/wxwfSx+gpCTGowezq9JGe6K9e6rpCH6VkNi0X
         WLKg67NsdtYm/fAEkKfHDqSHyQ03ShoDdgDDGFEMlQn0D5vFf+kHDbdhGO+8vyIBlwCP
         0IjXAe/0xVKx1cnYB0nFoLhRGfAjhr9jPZmA4tAQKH5MzFgkdOj8QSlWVRKYFQiUoX2v
         ZzUpA1AtWrODN6QXj1xeo/j0J3lBc91KeWgWgzRwjWlL+Z8m9Qc3kn7D/M30x+C6i4Zk
         mr0A==
X-Forwarded-Encrypted: i=1; AJvYcCX/XztjLFNy808S8iJd3woCUyQDLCEHp1h/Rd7a2I/WoGKp2h1m63wjFFPh+pvpiw85OqPnizE4@vger.kernel.org
X-Gm-Message-State: AOJu0YyWja7NYExmEgTS+UyN0cjL487bAi72ros/65X2FU9dJhNLJcdH
	4P8vFAgROPSMQ3kQWVBONc59e7qPC5Ss5Z3hMdmBAn4EjnC+tO6MP+stBKCs6KBhU8+eUB2+tBX
	3B0PxfDAATDeAjZ8q+pa5llNuXMPxySchJc4/GTT3CxTEmnxPTDtWFCIOt/jMKC6QfiL4l+Y=
X-Gm-Gg: ASbGncuSgQQ6gwlejKacOu6UK6kLJAcbvy5fnA+6LhUlUdlxgENbBvL39TTwhaaRXc7
	ZqgWd8s/DcpeynMG8ohp44RbS2qbYM4MRE+0nYSAmf/HsXs7zi9EkGKGStj70jqnpHKdvsZMNhL
	eOmcX+ncAigZaiuuwwigAFFwrkAB79qm3Uqesv9/dk3H9QHt7YEDpuUsB3GyHN2Li1iQsd5tjNN
	HFe8Rp2MVitTXpmX+z52ocYpGhHN/9eeyuXAc1NV5aG1yyRHY7lV97SIDuoE6YWIIinwG4RpAx+
	WQ2natf1Gmjp7FC354h/RluueyziR2ltRjma8H9NV6HA725v2HU4kLgScREbZbLnv01M4pZpK3J
	iN0GWyKcAs+ZVVgEyeQ==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252828866b.35.1741526983276;
        Sun, 09 Mar 2025 06:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Jp1lBL5UEDOmoLhr3/1+wDXXnEG000YcKS7uOUaGglmKZVGqoQ8LvIDpjopxUUJhpkTkFg==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252824566b.35.1741526982866;
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 3/4] tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
Date: Sun,  9 Mar 2025 14:28:14 +0100
Message-ID: <20250309132821.103046-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 15 +++++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e2d46636a0c..b60e0e1433f4 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -205,6 +205,21 @@ int cg_open(const char *cgroup, const char *control, int flags)
 	return open(path, flags);
 }
 
+/*
+ * Returns cgroup id on success, or -1 on failure.
+ */
+uint64_t cg_get_id(const char *cgroup)
+{
+	struct stat st;
+	int ret;
+
+	ret = stat(cgroup, &st);
+	if (ret)
+		return -1;
+
+	return st.st_ino;
+}
+
 int cg_write_numeric(const char *cgroup, const char *control, long value)
 {
 	char buf[64];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 19b131ee7707..3f2d9676ceda 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdlib.h>
 
 #include "../kselftest.h"
@@ -39,6 +40,7 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);
+extern uint64_t cg_get_id(const char *cgroup);
 int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
-- 
2.43.0


