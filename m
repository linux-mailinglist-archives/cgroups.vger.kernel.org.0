Return-Path: <cgroups+bounces-7567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A0A89230
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E854117D9B1
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F77A233704;
	Tue, 15 Apr 2025 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gwxYAnMX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0825157A48
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685272; cv=none; b=s/X+o47mhr00GuruXUDtZIGK4GGTp10nfhg4qqfZJ7sSKdgN+X805yGUNyCQW0kJvevi/xGxZ9Av6Bl813yZJ6O+oVw3MLM8Vz4RBZ80wLnPH6GQf6BapghejsxwNWDYx9xJCK2O1F/WF8t+DvigM9ViiA1akKOUHvTu3H3AMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685272; c=relaxed/simple;
	bh=N963eLsna70u/SXWWOCTgEo6yKRzuPJMpqN+SD/ylcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tE3ICgiz1aATxOQoDI8Toc6OhI1iid8fwEGyMDHFtdXMKkW5Jq7X1VCsn+zFp8qkpyF3cR+YfKDdukq012Vc9r9nfLuUPjtBJ2fL4zag4WXxJOD44x2XGW0Ttmh86udYQ8gexDCevtIriLgXr/QpREzi5HhHJEKREpL3EY1mnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gwxYAnMX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22423adf751so45814325ad.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685270; x=1745290070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhcsyw5OvFqI3eRSntntJlPhmFn+ppWjISpYyf0tCPE=;
        b=gwxYAnMXlbfzgTzBgnwWseP7oizIOtrP7G+friYS+aqpLw5r8K+fjniJuMV9lx4SYO
         M0A9/IHjmtbVlvcWDgWS/TcVyWqZW9TAn3YpW1iWuY2p7J83wOLEV9jysfin6/1QXmco
         4o9VKWi19j5TFL+1XD5hczYxQUA16tNn5GCw77LDxsG2eKpXibdQCJMWdT1t/PNNbTIK
         NecvueU2WfnOVgCeudq5H6UnnB905WpNptPc05YuzIfijhZFZAnuYeh4MlR6EPtRiNVS
         F+/m8F5y01HZpZ8MUY2NgUlKTLTCCdyMwnNVPM+0sik5opi1wxbfEoI8/Yw1Wwar1dRe
         ZjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685270; x=1745290070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhcsyw5OvFqI3eRSntntJlPhmFn+ppWjISpYyf0tCPE=;
        b=DAWYQ63uiS3aB3EzWse3R0fSlxUGMMu+Tp1+F8zSOTfXmsulQcewcsjX7OaNCkVnb+
         tueSIPNkOoZ7kNcoQzoFxI8xTLBzNueemVDD9vSWb4xmr0kRaiwGl7Rb5EgF7u2239q/
         Am48dbuVMKgykxDwJ/W1trwzcqIs6vA4b9q8BZZ1aEhkqCAJeNBWSil8z6leT4XJXkh5
         Q13jFe1PuU/m3uU1pB1aSICeVwM+ZUcbpxi1QU4/IcaAjttZ0csmuWflJD+lGZAc21fm
         v/7iSxavzao8yWliK5sc0P+CHzSNRTu3lIRvMJzidRMBxRjsNBsw/VlU57+cvOb4D4gB
         bzjg==
X-Forwarded-Encrypted: i=1; AJvYcCWBlhc+ZC2DvaRkpyXLstOUbYuiQ0+HG3swOEkGk1xKjJ+pm106GBguwJi/spZS2y98cQ0rgZiN@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqvNASO+Gjlrlrnf1W7SGwtpC709YVUmvxY5IkgPrT1aC7ziN
	7zTjQmPDzE0xq3J/TQbwBPob6PDgh74Urg8pjNPKe268JsBig4ghgQ+AQzd+A7k=
X-Gm-Gg: ASbGncsLJwL4+oi8shNRjeuWuvrjXA/2hWEZigBKqnKV8lUAF893HT81fKcqN5Ds5HM
	Jf7peiS097/7FQ9c073CiqyjyU27fEBNj9FaWZe20ZCQmWeMevb1U49nOqqIzK/91W+TBC9WUBm
	bJg2CTEUcLTLqRbkDcgZk3EXBDXSJmGDH8j++CUZhoyOA3+kHneg00caWZ24sPMD40+MCke71XC
	cMnbqwKWdMtDxS9BqQTx3+H+48G32rf5F+eS/P4HsrHJ/L+LojySV/UzJYkDUHFwOryIfSE9lFE
	VrI98C5t0e9vHn8raQHWygm+UacJeiSvumXrUtp23mA4ZsOaOJYUxvk+yhO3z4DmukUnJP1P
X-Google-Smtp-Source: AGHT+IHQB5bi/wRWV63xYCSrz429tnAZcPPlisuUNzOS3Dpdg6ZYVtpDC/C2wxVGDE/gRRdOBX11FA==
X-Received: by 2002:a17:902:ef4c:b0:224:76f:9e4a with SMTP id d9443c01a7336-22bea4ab7e3mr209530695ad.14.1744685269959;
        Mon, 14 Apr 2025 19:47:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:49 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 21/28] mm: zswap: prevent lruvec release in zswap_folio_swapin()
Date: Tue, 15 Apr 2025 10:45:25 +0800
Message-Id: <20250415024532.26632-22-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in zswap_folio_swapin().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 204fb59da33c..4a41c2371f3d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -752,8 +752,10 @@ void zswap_folio_swapin(struct folio *folio)
 	struct lruvec *lruvec;
 
 	if (folio) {
+		rcu_read_lock();
 		lruvec = folio_lruvec(folio);
 		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_disk_swapins);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.20.1


