Return-Path: <cgroups+bounces-14526-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB+xGCHrpWlSIAAAu9opvQ
	(envelope-from <cgroups+bounces-14526-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:55:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B21DEFFB
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44174307D7E9
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AA317146;
	Mon,  2 Mar 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Jpwy7aPi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7802EA468
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481193; cv=none; b=TOuXf/CKYw25QJPvhb4KAsFOjnzFMgx+5EeGrUaOWimDkvjKVeJmjJ4QWl8xGSvKDPXp9XinIMrNv1qIhvYhOHFh9D4njMstentNZ/R17dTCfmOFQv2/qJfk4QGYGu9hGHHjw0YmLVxna343iUKLRRoWw5yW64+GKnuP0UVOjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481193; c=relaxed/simple;
	bh=LXxELu9ePidewYBeVAy1Rzm8gqGexmW1c2vV9vPcBjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/+s8SIiDl7GLcGomCNnz6htNDHGCtw+NhThS69fc6laGXV7ZcB8yDInqkAonSlDykUm2XHyrY0rEVJLX5+1VAI32XUNbShjDgTaqrdDjHWA7q0Fp5iNOVltU48+1Xnqo9/F+j84w/YsFfPiKvOyE3Co2CFcohdxlSv7MV2OSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Jpwy7aPi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb4acdacb2so640795185a.3
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772481190; x=1773085990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXxELu9ePidewYBeVAy1Rzm8gqGexmW1c2vV9vPcBjI=;
        b=Jpwy7aPiA7RAM0SCg+M6no08eVJsCjT/Y67qs18/NfNXiaeg7eHWmHzoeg/wL9Mk90
         c2lcGdyNyQkqZe70N0e3sHB7qE0RH37ASXKACZzT1X8mS5qRLKRa0mu/8hpE7WEXxXdB
         c8uk4x0enpfQiPQx8WCmIBra+AucdgmuhrK9ZPoGadOhHqloHQ5LA0iCKvFrqBRxTeDo
         DF6ihu9xoop4MYIMnoQwneZTrg5Y50NVqDprDuiwY0v1nI/K+MluerGXmDAYzb8OZHPi
         RMsmEwBKdRe6luFVP+KsO24m+HRubVxFVP39EDzy3KarDPGh1ceBgkw3qoOa8NQZQ6xm
         r5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481190; x=1773085990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXxELu9ePidewYBeVAy1Rzm8gqGexmW1c2vV9vPcBjI=;
        b=AN9JSfSvDFECTKWjLXeLGg20jbGkUbuepSOFxZwy6J9cFSOXIPTgvulkNiOrPeHuAc
         7GYNvoTYg7k5MWUhmqgv/BO0EmEZ4wdruvI4a7r9ixFDgTn91e1NpUNJDqPrTd7HWOSY
         rAfxUjqy4irgb4aopL9FLNVYb5DbwSHz1Aspt2n12zxsBAkL149Z8AuljPfVEA6/WP/S
         6nMHmmDhbCtwMoQwHhEDj3ry1CQCBbkKp/dAjN6IvCnyn9Qc05EBfY1ZAD6JloB2mlKK
         vbqWcHYpdY5ILghiZ8R/JROEz2aUza8QfQOXDKCtNEZyJGVi5WsRRvcxqWM1nFFmljyK
         BGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Bmv38C3Tk6h0wAJwLbqZAOsRfSZ9fQOhwbZ174j51qLutccEy8qye4Q4zhK+IZkrbgs2dj5B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9r26byusljhl3cVZB/RMP1xwAeOknbfmQnPlHQLiAGR3y6iQd
	+rWMxnh9uQqjgftn8KLzI0VyrGf06xsFaZzCUzXfKr4IUSNVle7O5ByNum80gFwqqQZuk6cIOrW
	+UVBu
X-Gm-Gg: ATEYQzz8Fl/BK0REas8h1pyb5k+xdt5hmKveCe0HzNnZNVz5mNCSiN2d0KNqmjFZtNJ
	joYz225fVTKhLt2WZB4AexoSI/VKZ2OfBRtTJwVgrebn5eAfXr0JpEa4khyu7oIil7N2SwzfjNh
	vCpgpR0vhEOfAqMpJbftEAErB4cF7KT3MELR1OxNBXFvUOzlOmcyD6P6RE82WbPlQgPXWXqxIEe
	5NCrF3EotDcDlo18X7g8NSExcMBgFS5qgRVT1rDiLk0q2uMBHLc/lmblyOlyreK1UzswtaHOadV
	JQ2pMFgyKHAPC5O1/Hy9ay9DUcvqykKjG+qYuE6gGkb14p/wKKtPSKjf0og9KnlWzlfFDr+QJUJ
	D0rtKqrqL3z1la3trC1T8Nxo/GiYwf7e0nwuOGxPR9w2krB6UMKNP9CFuNzPUKZeL5jXisnTKNP
	FmNr+uV528UsHA0dRnjY4kCA==
X-Received: by 2002:a05:620a:3714:b0:8c9:ea27:dbdb with SMTP id af79cd13be357-8cbc8e0380bmr1839034685a.57.1772481190443;
        Mon, 02 Mar 2026 11:53:10 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf673060sm1210821185a.14.2026.03.02.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:53:09 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5]: memcg: obj stock and slab stat caching cleanups
Date: Mon,  2 Mar 2026 14:50:13 -0500
Message-ID: <20260302195305.620713-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB9B21DEFFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14526-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is a follow-up to `[PATCH] memcg: fix slab accounting in
refill_obj_stock() trylock path`. The way the slab stat cache and the
objcg charge cache interact appears a bit too fragile. This series
factors those paths apart as much as practical.

Based on today's mm-new.

 mm/memcontrol.c | 146 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 50 deletions(-)


