Return-Path: <cgroups+bounces-2221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705888FA1D
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 09:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A6B1C22050
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCEF55769;
	Thu, 28 Mar 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cqeKZ1EK"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A454664;
	Thu, 28 Mar 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615318; cv=none; b=ADp0DHRFesqzmBqyBraEiBZ7Cn3ofVvwW5DPw1MBmrQPiUnrSH7WgEzOTrKk7p3J4YZGaiYYlArNOaiP7/txA0P2Hw6ciqtfNSDrgKBWugd+npruxvuVcKByKVtDcm5ygFtVdk4jZWiK8hTVfuw/YwXhQjpm7y9t8IlgvIHwb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615318; c=relaxed/simple;
	bh=0S92q9jWn+0AOJhSlRqLSvXZuI0LWysnR5Y79MfWKxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAa8362O7fSLmgIhzIz0KZS6fZi3HspKhigBkLHqiRFox5tzZ+GUsDVW6tt2Bdro5vraHmfZvDAmLPyp78jc8afrV+qdYLuZJqoaa3t7tTn2yihJfNc9wiQNPmSpbGHTrTEJwq9QHeJiwyQxKBAESYkWqphvpM+7u0t+L2h0YRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cqeKZ1EK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0gTZ/AYdl2XxNSUh4NHlA/uFL92xrJ/lAvDl8Skx55E=; b=cqeKZ1EKDCW8JoHDHIYBA3z0UV
	q1QnZfHjnpsj9lQonxr8+VXCyqTvLlkjZRM2kZ6ED1sTuJqli8dPylm8A0/foxi7NPzMKpRVAAqvK
	xst9lkD0fYMIB9Zvx+ckITEmWK822Cu3XDX6j6k03uR3r2DlGtpVxJd4c2uhNNiIB+3spjz6yt949
	cf4ykfM3bPVpSaLpwmNTbCnAg8N/1F9VRFZKLhivRqF/gu+0tawhGwwJpX57bPs568all8/KFWi6X
	w27BsHIGFFQLBbFHnvcnJlwwt8C0mYaHCmk6hrhH9WcNNBgIg7qKM1CZlQ03RKqp2I6V11AmJkZnU
	6HxAPXnQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplKc-0000000D7aF-13aB;
	Thu, 28 Mar 2024 08:41:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] block: add a bio_list_merge_init helper
Date: Thu, 28 Mar 2024 09:41:44 +0100
Message-Id: <20240328084147.2954434-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
References: <20240328084147.2954434-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is a simple combination of bio_list_merge + bio_list_init
similar to list_splice_init.  While it only saves a single
line in a callers, it makes the move all bios from one list to
another and reinitialize the original pattern a lot more obvious
in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 875d792bffff82..9b8a369f44bc6b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -615,6 +615,13 @@ static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
 	bl->tail = bl2->tail;
 }
 
+static inline void bio_list_merge_init(struct bio_list *bl,
+		struct bio_list *bl2)
+{
+	bio_list_merge(bl, bl2);
+	bio_list_init(bl2);
+}
+
 static inline void bio_list_merge_head(struct bio_list *bl,
 				       struct bio_list *bl2)
 {
-- 
2.39.2


