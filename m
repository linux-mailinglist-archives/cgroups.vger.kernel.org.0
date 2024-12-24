Return-Path: <cgroups+bounces-6002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5E9FB82F
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8DC18849FA
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660864689;
	Tue, 24 Dec 2024 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f73vRsJk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF1BE46
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002866; cv=none; b=N4nb5kewq0Uu5bVjMJykY7Ozpu0KMnQKhdp3ZhhSFtRTpstplgx6fpQk8LWg6Y8J6ZNDc/z1cz3BTC92zU5SlYYZNpUCOTuAQceEfElliqY8ijYbJXE/AkPVy7OBUU69ZH+nArduyrW4nO7k1ImInTuclpDk0yEILLdnL3AWv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002866; c=relaxed/simple;
	bh=nJxWn6g1vg1g0C/AYa8vyQ/WA3q00hhqMzpWuXoE/04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkOI2P7wRWlAOtgKQcJPQj+Lmfv94BitPNXNvSZ7V/KFIT5ByWDjjui6NBXao9TxF843gWDm2VhS+KNKF8kpIbC98i8WKWKfwgCt1TnQxVRLP2RVZBlBgj55bd2YaS0yXrxB3uLTpM7aGQ3IJ/t9idyvd7Yzm2v0Pa6am9P50DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f73vRsJk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so3307253a91.3
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002864; x=1735607664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF5+lUY/lcy3tq2Y5kiTvVdLllXSJTZSMxUiRf304xw=;
        b=f73vRsJkaMKmkecoqYGWvfO32i6nXAcOGYYASlHDCwR/TXc+JXuJImnUYXSYf7yB2f
         AZCefzIHabfQ58rTDNztbcssQaQp/nRYGoSww95yf1eMYYvYEQezh7POo9VEk7Hk6A9h
         sSROevLUEfFKZzReYW7Cl0wul/ZsTxgb7r0FRwbpIbJMNHi/f/n/tm+OBHqd8/4cjQHc
         CeKIz5VjPs2vkyXoFbriZgYxgRI8IJ26H60i7gC7N4IuDh8/myow7EUeU+THeIE8Butz
         EmWB4WVIYCto1t+JKfUd1SXHUN+wrnS2i3n5XqGfEUVvjE17noaBgkQMEb8YwTnHWnKi
         WZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002864; x=1735607664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF5+lUY/lcy3tq2Y5kiTvVdLllXSJTZSMxUiRf304xw=;
        b=myaaQfidkBsGijj1aE/x/y3lBAgqAZXjLU2BRNQzokjwZnPd0lvQKPpQyo1waL+GlO
         OG575Pb2a1SujSNj3azzb2E3ZhHx4ZHdWzMqf2GNIpMusR75r+Ab1MkWUTl8hh+A2zWt
         elXtXzwa64bZvNYtB0aFTABUCky4riI+RnqiTMiBVxOZuh8V2p+2FXQ9xN+9u16XAjhw
         d35owKL+6gFJzHLjsic3Ezp5QQnuix+mn7qOrdyn8/JQCUCoHjYsi6xe1lO6tD6TvJ49
         W4rPC6vBaoyWQudohWFdvzzEEFfJl16axjaj4V06GnTQmT7i4Mwu15raREZ9zLyqNawU
         RPGA==
X-Forwarded-Encrypted: i=1; AJvYcCVIBkHpRVefpiyId5qgasOzbJEaeunrLS1KnSXQfxJ52xO+SuufN/Nugex0FPwq01U4ZXVjnoDq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/IweFxZxfh0gv88ODH1pLkie75VkO/Vra3lv70wAfH89ZA+n
	ecryiLflZExVku/I5lMovQSQUTPRXIDnnx/fNp97lAoUXiRXkJWZ
X-Gm-Gg: ASbGncsfYPe5ayRrHh1kPazQvuGOYzXTh5+01VaCQQyppdjfDZx8SKvqlm45mRaS6o8
	66+tMnqneeHvADVKDOsraiwsAAAgR5jqOv8uFQaDsimhzArvBrcIoQJU50Bp1ktg7ChFANMDx51
	Jrzkrt5MR2xTSatphWEa5vjJUs7+knLYjpMKjks06OsBBWvbiVNL9wzsybtlHIxeYXRQrVUcy5q
	0XubrlCL2YlX3pSZ126izfEisek4T03F5kMW4ZGI04VZ5u/u8roIGcF0GCFLOQAkOJgOIZWGBDU
	0L6cYp5JQXhg3TbU5w==
X-Google-Smtp-Source: AGHT+IESNbkbhfztvX6YzHV2B4TGbaIbNOhCOeua4C6yql386xi6jXCF50xnvVGI3HxJdfepwaKGzw==
X-Received: by 2002:a17:90b:2545:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-2f452e49630mr22512064a91.19.1735002864134;
        Mon, 23 Dec 2024 17:14:24 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:23 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 8/9 RFC] cgroup: remove bpf rstat flush from css generic flush
Date: Mon, 23 Dec 2024 17:14:01 -0800
Message-ID: <20241224011402.134009-9-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove this call from the generic subsystem flush. Leave it up to bpf
programs to manually flush any subsystems desired by using the kfunc
cgroup_rstat_flush().

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c52e8429c75d..03effaaf09a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -346,10 +346,8 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos = cgroup_rstat_updated_list(css, cpu);
 
-		for (; pos; pos = pos->rstat_flush_next) {
-			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
+		for (; pos; pos = pos->rstat_flush_next)
 			pos->ss->css_rstat_flush(pos, cpu);
-		}
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(lock)) {
-- 
2.47.1


