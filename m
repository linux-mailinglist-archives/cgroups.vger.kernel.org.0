Return-Path: <cgroups+bounces-7279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC813A77A37
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375C516BA5E
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52A202F87;
	Tue,  1 Apr 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qh09Uo0r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC120298F
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508672; cv=none; b=skZU8SVOi7v2D2lQZvMMGAl3EjBOh/5UThC4atFw9V8pAh1iUqwx2Sy3HBsBU8LbZn7bT+pB1/9yBgLoey7hEqmXvRYGPg4J0NpxlsG4vZoqngikbDvUESiPghgHJaz2zavPPeGq/M10eAwVvqPj2LUC72UE4Gyqurs7RiCajt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508672; c=relaxed/simple;
	bh=E0+exfqVjPHy3u7zfUx/DCOqizSWrHwao0vl1kGvu+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtWJ6QVeHaF9VEN9vUaRV2gdlOPFdlK3zT7Vv4vd4Q5IIXnxPZcpOgAwhTG4V4bDvFEulo114i0JJWsDXyzliKxzNOku8eWyAmaKH3TtERqLhhmP+fSp754x77Ridwvd6ZTjihClAIw8Ntb33K48TD/1cR/00Q9LsyGRUujoRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qh09Uo0r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso38456455e9.0
        for <cgroups@vger.kernel.org>; Tue, 01 Apr 2025 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743508669; x=1744113469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYfumVgNUUGcpEJ27Q8ui1p/c9wt59eDcNpxRKPwCw8=;
        b=Qh09Uo0rikyhA24f6vOfv7CnUvOYVQfcXoQwYw6RPeBUlwxVPWTelLfVu40mZER6/b
         m6KRfqcZgGT+wJwAGv5Z/kPnZt/tzifYbCMmbm/WWseGMDMX1C/RIET6kGAIJy8uK5Nr
         blokd9GCBcsyWmxVlXNSawPnJN/yZ950UJn8zybZsB7UWkBy8uddunPg59QR7rgHkjYN
         ib15Km+qr/5SqjTQZTev4qyfn2XV1cuUOw49oFy+ougj8g3wS2mrTOXbasn+CkZge84i
         EgkwlvheOkMX9oBi4lVAsCFy99/yfJ5zGLsQhx90FtSR8PW6JJwAf2aofGpXT8aTqzKm
         YdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508669; x=1744113469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYfumVgNUUGcpEJ27Q8ui1p/c9wt59eDcNpxRKPwCw8=;
        b=N8qNuAJRUFq5YjnxAhfhw6bMlo0WG+l2gT+5snwZWpBO0aJW249Y6H8jLXMJGVRJc1
         ra76KoPokjNOD5qODVyxOEQjTASfH7Owj/5Jzf0CwsSFkeJQGtRbnE21sa3Og9GQmvVU
         e66g5mAYvtyVkyjeJ6A5gG8x9U5L7l+cvRf+brNlxkBSMO1uhrKvgP9jOLgBnI43ys/x
         W9+eUpCUUYP22BE2WhdCb84RqNVUKZ3iYRQJ18dbxMSbhkogoxSo5BXkg4IYdmEEHOZC
         BRzE9S7QRSZbpi9jzWr1sV8SKtF+R322C2Xka09R0pNE+ztp6gMAXSLMqKY+a0qqZDfW
         souQ==
X-Gm-Message-State: AOJu0Yx+kvu93AcrjcFTq9ILBNjBW3PM2jJ4kTfeQQiAVk7zI2U/Jf7N
	s1pjMHjkAczyu3HbRdODtnQml5JsUmN/2Qw9IXSVn3Z+cUXzj3NEXez/jtl/SCG7Iua9rQK665Z
	x
X-Gm-Gg: ASbGncuBZr17qz0u1SxljPOFo3Je2n6zu19Nk676vJ5zGjklJ0UWVkEhEVu1sTAFVFi
	ZYJpE3LYaQWaDkoNuOhdBgDI7Y5MNiLvtKHnhVmjrIJOtYWWQZAYB1y6W95yU7VmAyqA+pihgNz
	89idBVZI+HoT/ffrF5Dk4JLtmCSkZwmz7rSOTqwc1A/U3gYqdtSzzi4CWMmWGVr57eWrvJYx9/W
	YMknRpsxdfVNTo8LKLj1ct/u0NNn5eK34GORiGq5BsmDthrJes2IVACmYX+3p8Oo62v1AIbps1k
	/5NxUR0Us2ScLAO7RGxMsCnzGVenx7/pndLktxyarkM/D1U=
X-Google-Smtp-Source: AGHT+IHft1xCvejDy94t7YBv8XrfyqQwOT6qYu3NmUFkGtsxbskgvYLtZMr36q2jppnAQb1Fl+BCKA==
X-Received: by 2002:a05:6000:4027:b0:391:2b11:657 with SMTP id ffacd0b85a97d-39c121186d5mr10146209f8f.38.1743508669030;
        Tue, 01 Apr 2025 04:57:49 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a42a3sm14130150f8f.91.2025.04.01.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:57:48 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v3 3/3] cgroup: Drop sock_cgroup_classid() dummy implementation
Date: Tue,  1 Apr 2025 13:57:32 +0200
Message-ID: <20250401115736.1046942-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401115736.1046942-1-mkoutny@suse.com>
References: <20250401115736.1046942-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The semantic of returning 0 is unclear when !CONFIG_CGROUP_NET_CLASSID.
Since there are no callers of sock_cgroup_classid() with that config
anymore we can undefine the helper at all and enforce all (future)
callers to handle cases when !CONFIG_CGROUP_NET_CLASSID.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17960a1e858db..28f33b0807c9a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -866,14 +866,12 @@ static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
 #endif
 }
 
+#ifdef CONFIG_CGROUP_NET_CLASSID
 static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
 {
-#ifdef CONFIG_CGROUP_NET_CLASSID
 	return READ_ONCE(skcd->classid);
-#else
-	return 0;
-#endif
 }
+#endif
 
 static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
 					   u16 prioidx)
@@ -883,13 +881,13 @@ static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
 #endif
 }
 
+#ifdef CONFIG_CGROUP_NET_CLASSID
 static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
 					   u32 classid)
 {
-#ifdef CONFIG_CGROUP_NET_CLASSID
 	WRITE_ONCE(skcd->classid, classid);
-#endif
 }
+#endif
 
 #else	/* CONFIG_SOCK_CGROUP_DATA */
 
-- 
2.48.1


