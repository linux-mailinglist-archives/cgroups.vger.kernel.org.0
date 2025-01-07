Return-Path: <cgroups+bounces-6061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC4A036B3
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 04:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868493A60B6
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 03:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D31E22FC;
	Tue,  7 Jan 2025 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Ev526+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F871E3DC5;
	Tue,  7 Jan 2025 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221937; cv=none; b=NiYT9BJ60GOvR7XoqXhNxc+t2ttn+7+KRXWQwiqoIiaw81HVnFDHj4ieeYr34tB36+fJsnVqsCLD4q3XJJXemKKg13aPjLUSs76f4w0qlbKH2eyLQGtTRcKn0ZttEfYCmFD/HXd1rTRImSL4Q/O4VAWEH1TAS+KUudY2COfMhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221937; c=relaxed/simple;
	bh=SB2ZRokZ4gvfRjMTn5gnLODEpOxEfJQkDTJScLurBoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EzpH5aOh1Ia8m8uBKLMnsAaSoeQt/B69eIs6XTknabSfSe/pagUouR/Gh11aG8J3zxDFk/D4l41TkUVPd0GSxJfDmWGjfmHGbb642CvtoUptjG3QBiu5WP4HPK8otgSvzznBY768jGsAvaT6tFPbdiMpAamvxn13JZ4mbcaXHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Ev526+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21634338cfdso24187735ad.2;
        Mon, 06 Jan 2025 19:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736221936; x=1736826736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rybZPDGa7aeomBfiapsYPjWOJP0BhmUMg778ab/RNWg=;
        b=U1Ev526+EoO+72jFBsi09csjc+Iq5cM83AKyRFr/Hd4blaCzXbhA72I/y4bOtsI10N
         hLpuFrbAAde5MrPY7pSXByZEMHzfhDxWBRKIJbueIJ+1f4Ay8TWuFDcJ5pGF/XZYS/l5
         +owRWfTVVlhC8gT0bI7o1kBg4mAmaMqqlEbwv1Uct7SrnH5itF5+ONHrD5gMRzIEAn+k
         tryxTKR7RgZmNXVILgATpcVf+6GTh8nNEs+I6xyfIqn2XYrU0XndezGD37intuxUFgjM
         deSs3y1HHyMbU/Ht9bDXep++9Hjwx4Eq0MIVdsxbh7biF0Upka3ixjX8XjunILSRNjvr
         YsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736221936; x=1736826736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rybZPDGa7aeomBfiapsYPjWOJP0BhmUMg778ab/RNWg=;
        b=X41hceQKAv7f9bJTW8W6/v+NllRAWVdwh7ya2JL2EP4SglrCnbbHgWhDvOmVd2/jGS
         ne4lfz7vGyA7Kyk63LFmN22GDhIExUJUNaEg/QHIZCoj28JdK02Eih6+IiaxVYtvtTh3
         IBtcerxH+yET4Ro8FPmqoVSml7WXcO0TbHyQNtDL0A5lIH9RN18zUH4crxJHmh8MNfO5
         iJ9zZpD986fFdAUU96zv05Zl52CAvCf03cCrBqsnZh0zsiOmlL1DhrcoKVlVs0Qv81AN
         53JVL2iK5ETSwMYhiZt6s8PUqmLe+7x0ZSxSX8Z+qkvUe3e0hG0h2GeDOBIqwvb9+S3i
         mUMw==
X-Forwarded-Encrypted: i=1; AJvYcCW/O5hMHcst0DHCqeZJn93Okup0Gy5zOeURBGPIU6ocU3feWWo8JbVqyQZNJzxv4rf5Nu2OvkQ/GCVo1BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPTENwUD1DIoVgYknlF9YNT2gwcOujEWsd0zD/yDQSih4hcsJ
	2S7vqDq1v919NxW8q0Txe3dGfDil5nPUYB+02uFqlOox7S1WQmwe2TyMqHCozQI=
X-Gm-Gg: ASbGncvlE+JM+fSCd/UBoU/nTxc8/0W80a+tfjwZZStP0FLq2r7ontG0zYIKLd0u0Yy
	VqCIAFTHGR93R/kkkw/jljdFOabiSJqIGlIzjmRyY/OOl4PblIcLwXXZugjbdloSXSdcXcyrFtH
	aagcclVGZhmiHIoG/xKVuZpPjFGXyYJtv9V/tSQJBueL2tqeD4nIWbCpffoqHO2X48n+0GRnfMN
	opoRMz5z7dR1rXhpoOKSyg/89VsGW38gfNsa11KIJn4MkN9SwDJsszkBUruvc1HbKNW48obUKpc
	UilhZFeHwEjvaJOyGH+hgzytd8E=
X-Google-Smtp-Source: AGHT+IE7kzSJJggL6Z8KiIHBRhsXBS9mADY4GGN8p4TBnMlDpGNKsc5uJ8wb8XO4YzWO7Ps2FK1ZkA==
X-Received: by 2002:a17:903:22c6:b0:216:2474:3c9f with SMTP id d9443c01a7336-219e6f38177mr898724415ad.52.1736221935819;
        Mon, 06 Jan 2025 19:52:15 -0800 (PST)
Received: from mm2dtv09.. (60-251-198-229.hinet-ip.hinet.net. [60.251.198.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6251sm293848655ad.207.2025.01.06.19.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 19:52:15 -0800 (PST)
From: Kenny Cheng <chao.shun.cheng.tw@gmail.com>
To: hannes@cmpxchg.org,
	muchun.song@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	c.s.cheng@realtek.com,
	Kenny Cheng <chao.shun.cheng.tw@gmail.com>
Subject: [PATCH] mm: avoid implicit type conversion
Date: Tue,  7 Jan 2025 11:51:41 +0800
Message-Id: <20250107035141.2858582-1-chao.shun.cheng.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function 'task_in_memcg_oom' returns a 'struct mem_cgroup *' type.
If the compiler does not inline this function, a compile error occurs,
as shown below:

./include/linux/memcontrol.h:961:9: error: incompatible pointer to 
integer conversion returning 'struct mem_cgroup *' from a function with
result type 'unsigned char' [-Wint-conversion]

This patch avoids the implicit type conversion by ensuring the return
type is correct.

Signed-off-by: Kenny Cheng <chao.shun.cheng.tw@gmail.com>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5502aa8e138e..47acf1e4f5a7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1826,7 +1826,7 @@ bool mem_cgroup_oom_synchronize(bool wait);
 
 static inline bool task_in_memcg_oom(struct task_struct *p)
 {
-	return p->memcg_in_oom;
+	return !!p->memcg_in_oom;
 }
 
 static inline void mem_cgroup_enter_user_fault(void)
-- 
2.34.1


