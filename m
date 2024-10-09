Return-Path: <cgroups+bounces-5086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3978997068
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C181F217AC
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8331822F8;
	Wed,  9 Oct 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEZ0b24P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EF1DEFE8;
	Wed,  9 Oct 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488430; cv=none; b=gnu1voO9pISkV8HTgKMAGqvBZiR/bNSfOjUAzgwAjIp0IoeJxvYxwjRmUs6MDTXo9VS/DVunO1FhTM9s5cJEQPXWQCZnOtk5ZJfiStRlm3ibH8GYQoT3/xToQfwupzkWjPbr6CvQ1Nw4iZEsSwnq82rXhSAxMBZu6TEKmhcMkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488430; c=relaxed/simple;
	bh=vjg4nVqQUAH4qx0v48cbTsQL1sF0htHXJRSpC/Uip2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f5732bYLU3iux3F1cD+rDJ2dCV6LP7KOvcjqcCAvJhIovE+I+z3IFMcBuqsHacAw2KDx9+L8PnqmT6Z+Sr1uiSTondUIfYApoRp4Bx+p4uX3Ki1MFliFTImcI7my3OkA59JgKigRZm8eNsdVQdVdFi3CyizgnMyb1SWepyDxMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEZ0b24P; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7163489149eso6092265a12.1;
        Wed, 09 Oct 2024 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488428; x=1729093228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwYnY2ij5HfjfOepkbVzbb8F4NJ5eXK7Cz9FjuppO9Y=;
        b=LEZ0b24PL/zabEwq8+lUo6oQnnh2IfYYrKF4DZOl0EjZBFHPstDMxnyoFLW0wISdf/
         zZJtBT8ZDF8yHQWGym4Jv/hSAkZrjadTv6/JAGf0JiwchMr8MESU0o/+/HPdB00mf224
         ol9aHfjCpoSEu/5oyH3pACIF3RrjGLQzJiSP55TzOMn4ndTpIyEYAgf6sxKN49wDhXbL
         jsn6TbIsSKbdVXmHPJeoSJ5ZhUn50cOjgBTDxvvreVHFIZ3liI5mGWqHqx37OiyAlCar
         k75BnakH+Dq6jORyECRMzCJOVHnvf7sLxXzmniZoi4zuEo2zlkEi/YN5RI2/P1dKn8cm
         dSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488428; x=1729093228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwYnY2ij5HfjfOepkbVzbb8F4NJ5eXK7Cz9FjuppO9Y=;
        b=IJ02/4iXN7VtZBSL46BEzoM/GvjFlRxuOuGOPYqR6s8sIa9BnHPp6nJiM0ygfluuPE
         6lZ4fS8L3A5ajque1Z5nwoKci5odwPSuaFmilqIl0BLl9yEh5xaMch3XqIqti0ivROky
         KiB8hKfNoZX68tyONog7lIDXxwepEVv6ZMj+U07Pzzuz19Y1wlYWSLszMU1tR+3QQi8Z
         IGKEjGXdSW3xU4jxxw7hZBgmiHI4207tMrDOjbRO9riYxN4RjFWdLkQcI08AAF2R0buT
         OXyeLw+BKM1koEHZ6VNWiiIyXg1ChcQK5Gp+Ydntkqhg1pJuBF40vyW2Qgv7t/yNogJ+
         fJMg==
X-Forwarded-Encrypted: i=1; AJvYcCWeBZ7RQEZ3Id43otSL8PApYNRoq68z0Vsi/wV4zaP4qXjJZDYZLiG/kBjcuS7EMWuJIs6XNoyV@vger.kernel.org, AJvYcCX2B+d/l4sxzxEO5x9pueW4uV6fdZOOIny2WMuM5JkghrStY0jg1cAr6yJYsh9sRigJYheEEdAiBsOTzAm6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfz+5zs9awYIwWCHqE4752Q3KSQK5w51KjqvsPipuLaDwFeXcX
	gTSrLMqcce6FkeBoswmheJe4+7euUqiDQvokxmWyGgGYkXP6YWOX
X-Google-Smtp-Source: AGHT+IFLpjnPQw0blTknN6xr5VxxX+9jzOR9xdHOfL8SnjGnBoNa2ux3Z/7ha5z0xWEhggv8AZfwtQ==
X-Received: by 2002:a05:6a20:ce4c:b0:1d2:e8f6:81e with SMTP id adf61e73a8af0-1d8a3c33359mr4305093637.24.1728488428335;
        Wed, 09 Oct 2024 08:40:28 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd1e6sm7933679b3a.61.2024.10.09.08.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:40:27 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	hch@infradead.org,
	llong@redhat.com,
	xavier_qy@163.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] lib/Makefile: Make union-find compilation conditional on CONFIG_CPUSETS
Date: Wed,  9 Oct 2024 23:40:22 +0800
Message-Id: <20241009154022.2432662-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cpuset is the only user of the union-find implementation.
Compiling union-find in all configurations unnecessarily increases the
code size when building the kernel without cgroup support. Modify the
build system to compile union-find only when CONFIG_CPUSETS is enabled.

Link: https://lore.kernel.org/lkml/1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com/
Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..53f82de7cbe2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -35,8 +35,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o union_find.o
+	 buildid.o objpool.o
 
+lib-$(CONFIG_CPUSETS) += union_find.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
 
-- 
2.34.1


