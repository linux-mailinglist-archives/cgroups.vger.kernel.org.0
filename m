Return-Path: <cgroups+bounces-5271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838D9B13EF
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 02:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB2AB21D5E
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8023A0;
	Sat, 26 Oct 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhK/Yyfg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E8AD24
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903717; cv=none; b=lk0yisK/LjOvVGxeG/lVBMDZ/zkH1oU28CEavRG7pG+khUxAwz2xJvnDDvg8gcOJ/EZq7OkY56JNXAscG2KtH1Ff/lTl/HzgICWyBWQdwi0Y9xM7kbZElp83scqyxo1mPDGXB+6WX+b7K2QdNiOPIeOeWMsg0pbxsK/W/FiD/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903717; c=relaxed/simple;
	bh=yjNLe72WS26/DeD/h4HlUv63810HvL7Oh8mkXFFLXls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeL9kfwSvtpPgKh57tEmNkhwt9D34Wilj9Y+kzsYgaSIS8DRY0wASS6hU9IJwiOziu7299zUryQzlO5hqxY3WWhytZvPUTP+YBf65tbzDBA/Tal+hov57N0qLbFVsOQR+faQANIJyGlUjA5X7Fojr58BcQjpYltLJgsxk5o0y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhK/Yyfg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1869621a91.3
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729903715; x=1730508515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/m6Vv8AwalfQLibkYgB/kravCl5ywXx4WdWAUR3/mNs=;
        b=NhK/Yyfghz2WDQqsfkwfD273deOMHqV2LpLDUx7g2ImYL7CCLUDKmHKMYJx4+VGtod
         heB5AvHe4ozM5v2kXWuA0WXbSUPRk9Uho7eiXLih6C5pojJlpUCmyVED/kMT9poV87ub
         Yw0q9IdW77at4xyutriU/7pZlnvmX7ZH2axR3SWMsfpgzecfoDrl7C+GplIHzhGwhbO2
         HOGgGmb9mxzuxyPhb66p/b8kvJuANCLKuKV//fBzIMxEGH165zvE4lJZEzrP7x8vEP9m
         up/pCAuei2ySuDjFv3MLQLGbUx9rh3pmRyfHturu+xYjzRvgtHydPcCaP5cgn2aY431Q
         DvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729903715; x=1730508515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/m6Vv8AwalfQLibkYgB/kravCl5ywXx4WdWAUR3/mNs=;
        b=XYWvXV7juvJgmnu2AO6XSlCwIuwkkilnP+XvNTZs8K0Oo5GyREnYSpdezuU7HmBf4C
         EfbaWKAxMhjHWiWT1eSZxAYfO9GQ2w8e/H+binwJhOscWAtCzu2y9in8yiRLI/+aVRM4
         /W2K+eHmFCi0mL1HGG9jq36DqhigF3rzr9EgyBMAiWhvXlI/j0UgQ9R5T+bjIe5H1+Zf
         K6bipd452V7WBqg80DVFS3Qrbjcopygme4QMPOiDnhkd174XYKJWVBoCZvbSPg5M2DQy
         p259D/1bu/SK33e7BhMGWYynlODZ9zLYD4b3HSC6TcoWv9WPJJ1mvu5O3wkqqlQwP+yc
         batw==
X-Forwarded-Encrypted: i=1; AJvYcCXFGsD67G/bWig4ww8xDGRsG79R8pKSoskUCRehhqy6U2+QbaMs128wc9RdvkPVXfRmubJFRjny@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9LbfH4yvcbYxjclYnrvAHqrQ0imEWEe1rI7FMiv4/SDMuWjP
	q7Xsu/ag5WjG9m3D13G6f6NodVDmXYvsvSI9rqPDm3ucC3SD2V29VupV0zTH
X-Google-Smtp-Source: AGHT+IFzSnuI9+m8TtVj40VZtktnFq63E06IKbZ6g92J1/kCvXWoJuT0IbxmhnXck19cwpQWJd/5zQ==
X-Received: by 2002:a17:90b:344:b0:2e2:973b:f8e7 with SMTP id 98e67ed59e1d1-2e8f11bad49mr1467421a91.38.1729903714766;
        Fri, 25 Oct 2024 17:48:34 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48ad66sm4249738a91.4.2024.10.25.17.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 17:48:34 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 0/2 v2] memcg: tracepoint for flushing stats
Date: Fri, 25 Oct 2024 17:48:24 -0700
Message-ID: <20241026004826.55351-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tracepoint gives visibility on how often the flushing of memcg stats
occurs and contains info on whether it was forced, skipped, and the value
of stats updated. It can help with understanding how readers are affected
by having to perform the flush, and the effectiveness of the flush by
inspecting the number of stats updated. Paired with the recently added
tracepoints for tracing rstat updates, it can also help show correlation
where stats exceed thresholds frequently.

JP Kobryn (2):
  add memcg flush tracepoint event
  use memcg flush tracepoint

 include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
 mm/memcontrol.c              | 22 +++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.47.0


